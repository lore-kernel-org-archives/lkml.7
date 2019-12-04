Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36123C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 17:39:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08C0020674
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 17:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575481173;
	bh=0hhXOqQVLzcC/91DX1iMkXjEIx1nrjiGpDRjL6AIWA0=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=mZ+vOVD7uHiJ70clx2KhoW26sZHJCCrp5ukd5Sb93n6StP/PXX4p7+tAXLKXb+hrB
	 v+BHXIcbzzJVYusE/Eq2YjDcVjQB8gPy/D455n1pYDc3+EiGvYXxCLGsp+7YSfAvtd
	 tu8+YbfkYzTW3o1YcL2ZcxY3HTzzOnG3CVpvDpcI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbfLDRjc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 12:39:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:33182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726934AbfLDRja (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 12:39:30 -0500
Received: from localhost.localdomain (c-73-169-115-106.hsd1.co.comcast.net [73.169.115.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA13D20803;
        Wed,  4 Dec 2019 17:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575481170;
        bh=0hhXOqQVLzcC/91DX1iMkXjEIx1nrjiGpDRjL6AIWA0=;
        h=From:To:Cc:Subject:Date:From;
        b=Lzi2+UhYABr7RnaS7JA+Qpdd5fUix+MiSApd70giJxIAqJ3XMRROxqS6/vIyWO9Dj
         SUX3rkMJCqdeoeOIUzNMG6AC20sa5M3u55hBImUuqlqg9pPCtKIz7NvOwPXDFRScta
         J1nqHLf+G6OSu4k/Y0l+/gba1SdkhkkRpfJp0JW8=
From:   David Ahern <dsahern@kernel.org>
To:     acme@kernel.org
Cc:     namhyung@kernel.org, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        David Ahern <dsahern@gmail.com>
Subject: [PATCH] perf sched timehist: Add support for filtering on CPU
Date:   Wed,  4 Dec 2019 10:39:25 -0700
Message-Id: <20191204173925.66976-1-dsahern@kernel.org>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Ahern <dsahern@gmail.com>

Allow user to limit output to one or more CPUs. Really helpful on systems
with a large number of cpus.

Signed-off-by: David Ahern <dsahern@gmail.com>
---
 tools/perf/Documentation/perf-sched.txt |  4 ++++
 tools/perf/builtin-sched.c              | 13 +++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/tools/perf/Documentation/perf-sched.txt b/tools/perf/Documentation/perf-sched.txt
index 63f938b887dd..5fbe42bd599b 100644
--- a/tools/perf/Documentation/perf-sched.txt
+++ b/tools/perf/Documentation/perf-sched.txt
@@ -110,6 +110,10 @@ OPTIONS for 'perf sched timehist'
 --max-stack::
 	Maximum number of functions to display in backtrace, default 5.
 
+-C=::
+--cpu=::
+	Only show events for the given CPU(s) (comma separated list).
+
 -p=::
 --pid=::
 	Only show events for given process ID (comma separated list).
diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 8a12d71364c3..82fcc2c15fe4 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -51,6 +51,9 @@
 #define SYM_LEN			129
 #define MAX_PID			1024000
 
+static const char *cpu_list;
+static DECLARE_BITMAP(cpu_bitmap, MAX_NR_CPUS);
+
 struct sched_atom;
 
 struct task_desc {
@@ -2008,6 +2011,9 @@ static void timehist_print_sample(struct perf_sched *sched,
 	char nstr[30];
 	u64 wait_time;
 
+	if (cpu_list && !test_bit(sample->cpu, cpu_bitmap))
+		return;
+
 	timestamp__scnprintf_usec(t, tstr, sizeof(tstr));
 	printf("%15s [%04d] ", tstr, sample->cpu);
 
@@ -2994,6 +3000,12 @@ static int perf_sched__timehist(struct perf_sched *sched)
 	if (IS_ERR(session))
 		return PTR_ERR(session);
 
+	if (cpu_list) {
+		err = perf_session__cpu_bitmap(session, cpu_list, cpu_bitmap);
+		if (err < 0)
+			goto out;
+	}
+
 	evlist = session->evlist;
 
 	symbol__init(&session->header.env);
@@ -3429,6 +3441,7 @@ int cmd_sched(int argc, const char **argv)
 		   "analyze events only for given process id(s)"),
 	OPT_STRING('t', "tid", &symbol_conf.tid_list_str, "tid[,tid...]",
 		   "analyze events only for given thread id(s)"),
+	OPT_STRING('C', "cpu", &cpu_list, "cpu", "list of cpus to profile"),
 	OPT_PARENT(sched_options)
 	};
 
-- 
2.20.1

