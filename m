Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC78AC4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8A6E2184D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560279661;
	bh=5/FeXQyahD8sw4o5l43x7/+RIHSJNm9FOH4463sbbFw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AM8CMvKuKifyBe6E/X8dXAmgqbscWSmal0QPxm2Z1moQxPoj8o6ojQRtO8d6n+Kuo
	 xCoHTz+qlJAv59qQHhRDbCVhPqREuXrS2ntjUcG+V1w40MAYskNg0/XJkQkMlEXrL0
	 nonUayCZMI9Odnn4OUJ3BMt149nZ0/DuYbyeyc1E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392272AbfFKTBB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 15:01:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:37686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391745AbfFKTA7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 15:00:59 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E4892183E;
        Tue, 11 Jun 2019 19:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560279658;
        bh=5/FeXQyahD8sw4o5l43x7/+RIHSJNm9FOH4463sbbFw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yvpKrJA6uU+HV5K67uZU9OIv5FSwFi/TwetThyUjewilViVHcGUo1UDvtMYK30rtd
         NdeZgol7msT04jXTB4AULNARjqb4wx8ONgnPfsV92w6OqE/nwTzB9nrQ8GSgU6bcx2
         Ptv5Qf49M8WpQMhfpwRKMEQsxLxAPBwtXrnOLabs=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>
Subject: [PATCH 27/85] perf augmented_raw_syscalls: Move the probe_read_str to a separate function
Date:   Tue, 11 Jun 2019 15:58:13 -0300
Message-Id: <20190611185911.11645-28-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190611185911.11645-1-acme@kernel.org>
References: <20190611185911.11645-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

One more step into copying multiple filenames to support syscalls like
rename*.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-xdqtjexdyp81oomm1rkzeifl@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../examples/bpf/augmented_raw_syscalls.c     | 27 ++++++++++++-------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/tools/perf/examples/bpf/augmented_raw_syscalls.c b/tools/perf/examples/bpf/augmented_raw_syscalls.c
index c9fd3b4d8e55..356513e81ec1 100644
--- a/tools/perf/examples/bpf/augmented_raw_syscalls.c
+++ b/tools/perf/examples/bpf/augmented_raw_syscalls.c
@@ -60,11 +60,27 @@ struct augmented_args_filename {
 
 bpf_map(augmented_filename_map, PERCPU_ARRAY, int, struct augmented_args_filename, 1);
 
+static inline
+unsigned int augmented_args__read_filename(struct augmented_args_filename *augmented_args,
+					   const void *filename_arg, unsigned int filename_len)
+{
+	unsigned int len = sizeof(*augmented_args);
+
+	augmented_args->filename.reserved = 0;
+	augmented_args->filename.size = probe_read_str(&augmented_args->filename.value, filename_len, filename_arg);
+	if (augmented_args->filename.size < sizeof(augmented_args->filename.value)) {
+		len -= sizeof(augmented_args->filename.value) - augmented_args->filename.size;
+		len &= sizeof(augmented_args->filename.value) - 1;
+	}
+
+	return len;
+}
+
 SEC("raw_syscalls:sys_enter")
 int sys_enter(struct syscall_enter_args *args)
 {
 	struct augmented_args_filename *augmented_args;
-	unsigned int len = sizeof(*augmented_args), filename_len;
+	unsigned int len, filename_len;
 	const void *filename_arg = NULL;
 	struct syscall *syscall;
 	int key = 0;
@@ -182,14 +198,7 @@ processed 46 insns (limit 1000000) max_states_per_insn 0 total_states 12 peak_st
 	loop_iter_last(5)
 
 	if (filename_arg != NULL && filename_len <= sizeof(augmented_args->filename.value)) {
-		augmented_args->filename.reserved = 0;
-		augmented_args->filename.size = probe_read_str(&augmented_args->filename.value,
-							      filename_len,
-							      filename_arg);
-		if (augmented_args->filename.size < sizeof(augmented_args->filename.value)) {
-			len -= sizeof(augmented_args->filename.value) - augmented_args->filename.size;
-			len &= sizeof(augmented_args->filename.value) - 1;
-		}
+		len = augmented_args__read_filename(augmented_args, filename_arg, filename_len);
 	} else {
 		len = sizeof(augmented_args->args);
 	}
-- 
2.20.1

