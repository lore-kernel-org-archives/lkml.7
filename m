Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4060C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 14:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9841B23426
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 14:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567089606;
	bh=tgXBR6U7m2oGcsdBxVlKdndD6piYs6RX6u2XGg9wlRE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=otVJcZ+RvWG4lQ3NxhpM5SOmZAWuZhTn21WxXtlGrdfCrDPT0DdWxzAv8/C0J9AIl
	 i5wR12STTgUxJVcposBuPzozGBkxSQnirG0o5iVOnek/SNOt3+tBGTS6Uec7gAFcjd
	 uEWDGxGLcu4zjj558xqvQH+f2nhWMuMU1I9q0BVg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728438AbfH2OkF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 10:40:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:43656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728416AbfH2OkD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 10:40:03 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4646223428;
        Thu, 29 Aug 2019 14:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567089602;
        bh=tgXBR6U7m2oGcsdBxVlKdndD6piYs6RX6u2XGg9wlRE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rKIhuAM0fvfIIoaQmyqjFlo3f6NBdNdzGttNnN7jgjXtdJI/7LWAOx0dr5e1hSXI/
         r9ck9/gWxGwrpG5W0sVEb7O69YtYKqZjlxlnvycWCbm+m2C8PsbD3ugmR67uZpTeYt
         vCqQtwtN/LWqVFCFxQXmmcOetmgYubuIjPn5KKQs=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Igor Lubashev <ilubashe@akamai.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        James Morris <jmorris@namei.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 06/37] perf tools: Warn that perf_event_paranoid can restrict kernel symbols
Date:   Thu, 29 Aug 2019 11:38:46 -0300
Message-Id: <20190829143917.29745-7-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190829143917.29745-1-acme@kernel.org>
References: <20190829143917.29745-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Igor Lubashev <ilubashe@akamai.com>

Warn that /proc/sys/kernel/perf_event_paranoid can also restrict kernel
symbols.

Signed-off-by: Igor Lubashev <ilubashe@akamai.com>
Tested-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: James Morris <jmorris@namei.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Suzuki Poulouse <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/1566869956-7154-6-git-send-email-ilubashe@akamai.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-record.c | 2 +-
 tools/perf/builtin-top.c    | 2 +-
 tools/perf/builtin-trace.c  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 359bb8f33e57..afe558449677 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -2372,7 +2372,7 @@ int cmd_record(int argc, const char **argv)
 	if (symbol_conf.kptr_restrict && !perf_evlist__exclude_kernel(rec->evlist))
 		pr_warning(
 "WARNING: Kernel address maps (/proc/{kallsyms,modules}) are restricted,\n"
-"check /proc/sys/kernel/kptr_restrict.\n\n"
+"check /proc/sys/kernel/kptr_restrict and /proc/sys/kernel/perf_event_paranoid.\n\n"
 "Samples in kernel functions may not be resolved if a suitable vmlinux\n"
 "file is not found in the buildid cache or in the vmlinux path.\n\n"
 "Samples in kernel modules won't be resolved at all.\n\n"
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 5970723cd55a..29e910fb2d9a 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -770,7 +770,7 @@ static void perf_event__process_sample(struct perf_tool *tool,
 		if (!perf_evlist__exclude_kernel(top->session->evlist)) {
 			ui__warning(
 "Kernel address maps (/proc/{kallsyms,modules}) are restricted.\n\n"
-"Check /proc/sys/kernel/kptr_restrict.\n\n"
+"Check /proc/sys/kernel/kptr_restrict and /proc/sys/kernel/perf_event_paranoid.\n\n"
 "Kernel%s samples will not be resolved.\n",
 			  al.map && map__has_symbols(al.map) ?
 			  " modules" : "");
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 8ea62fd2591d..58a75dd3a571 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1382,7 +1382,7 @@ static char *trace__machine__resolve_kernel_addr(void *vmachine, unsigned long l
 
 	if (symbol_conf.kptr_restrict) {
 		pr_warning("Kernel address maps (/proc/{kallsyms,modules}) are restricted.\n\n"
-			   "Check /proc/sys/kernel/kptr_restrict.\n\n"
+			   "Check /proc/sys/kernel/kptr_restrict and /proc/sys/kernel/perf_event_paranoid.\n\n"
 			   "Kernel samples will not be resolved.\n");
 		machine->kptr_restrict_warned = true;
 		return NULL;
-- 
2.21.0

