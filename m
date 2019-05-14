Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12117C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 20:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E078420879
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 20:20:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbfENUUH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 16:20:07 -0400
Received: from mga09.intel.com ([134.134.136.24]:23576 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726036AbfENUUH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 16:20:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 May 2019 13:20:06 -0700
X-ExtLoop1: 1
Received: from otc-lr-04.jf.intel.com ([10.54.39.157])
  by fmsmga006.fm.intel.com with ESMTP; 14 May 2019 13:20:05 -0700
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, jolsa@kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 1/3] perf parse-regs: Split parse_regs
Date:   Tue, 14 May 2019 13:19:32 -0700
Message-Id: <1557865174-56264-1-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The available registers for --int-regs and --user-regs may be different,
e.g. XMM registers.

Split parse_regs into two dedicated functions for --int-regs and
--user-regs respectively.

Modify the warning message. "--user-regs=?" should be applied to show
the available registers for --user-regs.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

No changes since V1

 tools/perf/builtin-record.c          |  4 ++--
 tools/perf/util/parse-regs-options.c | 19 ++++++++++++++++---
 tools/perf/util/parse-regs-options.h |  3 ++-
 3 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 386e665..45172bb 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -2029,10 +2029,10 @@ static struct option __record_options[] = {
 		    "use per-thread mmaps"),
 	OPT_CALLBACK_OPTARG('I', "intr-regs", &record.opts.sample_intr_regs, NULL, "any register",
 		    "sample selected machine registers on interrupt,"
-		    " use '-I?' to list register names", parse_regs),
+		    " use '-I?' to list register names", parse_intr_regs),
 	OPT_CALLBACK_OPTARG(0, "user-regs", &record.opts.sample_user_regs, NULL, "any register",
 		    "sample selected machine registers on interrupt,"
-		    " use '-I?' to list register names", parse_regs),
+		    " use '--user-regs=?' to list register names", parse_user_regs),
 	OPT_BOOLEAN(0, "running-time", &record.opts.running_time,
 		    "Record running/enabled time of read (:S) events"),
 	OPT_CALLBACK('k', "clockid", &record.opts,
diff --git a/tools/perf/util/parse-regs-options.c b/tools/perf/util/parse-regs-options.c
index 9cb187a..b21617f 100644
--- a/tools/perf/util/parse-regs-options.c
+++ b/tools/perf/util/parse-regs-options.c
@@ -5,8 +5,8 @@
 #include <subcmd/parse-options.h>
 #include "util/parse-regs-options.h"
 
-int
-parse_regs(const struct option *opt, const char *str, int unset)
+static int
+__parse_regs(const struct option *opt, const char *str, int unset, bool intr)
 {
 	uint64_t *mode = (uint64_t *)opt->value;
 	const struct sample_reg *r;
@@ -48,7 +48,8 @@ parse_regs(const struct option *opt, const char *str, int unset)
 					break;
 			}
 			if (!r->name) {
-				ui__warning("Unknown register \"%s\", check man page or run \"perf record -I?\"\n", s);
+				ui__warning("Unknown register \"%s\", check man page or run \"perf record %s?\"\n",
+					    s, intr ? "-I" : "--user-regs=");
 				goto error;
 			}
 
@@ -69,3 +70,15 @@ parse_regs(const struct option *opt, const char *str, int unset)
 	free(os);
 	return ret;
 }
+
+int
+parse_user_regs(const struct option *opt, const char *str, int unset)
+{
+	return __parse_regs(opt, str, unset, false);
+}
+
+int
+parse_intr_regs(const struct option *opt, const char *str, int unset)
+{
+	return __parse_regs(opt, str, unset, true);
+}
diff --git a/tools/perf/util/parse-regs-options.h b/tools/perf/util/parse-regs-options.h
index cdefb1a..2b23d25 100644
--- a/tools/perf/util/parse-regs-options.h
+++ b/tools/perf/util/parse-regs-options.h
@@ -2,5 +2,6 @@
 #ifndef _PERF_PARSE_REGS_OPTIONS_H
 #define _PERF_PARSE_REGS_OPTIONS_H 1
 struct option;
-int parse_regs(const struct option *opt, const char *str, int unset);
+int parse_user_regs(const struct option *opt, const char *str, int unset);
+int parse_intr_regs(const struct option *opt, const char *str, int unset);
 #endif /* _PERF_PARSE_REGS_OPTIONS_H */
-- 
2.7.4

