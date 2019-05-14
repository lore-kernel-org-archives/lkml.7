Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8313CC04AB7
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 14:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54833216E3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 14:39:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbfENOju (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 10:39:50 -0400
Received: from mga18.intel.com ([134.134.136.126]:51571 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726107AbfENOju (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 10:39:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 May 2019 07:39:50 -0700
X-ExtLoop1: 1
Received: from otc-lr-04.jf.intel.com ([10.54.39.157])
  by FMSMGA003.fm.intel.com with ESMTP; 14 May 2019 07:39:50 -0700
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, jolsa@kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 2/3] perf parse-regs: Add generic support for non-gprs
Date:   Tue, 14 May 2019 07:39:12 -0700
Message-Id: <1557844753-58223-2-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1557844753-58223-1-git-send-email-kan.liang@linux.intel.com>
References: <1557844753-58223-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Some non general purpose registers, e.g. XMM, can be collected on some
platforms, e.g. X86 Icelake.

Add a weak function has_non_gprs_support() to check if the
kernel/hardware support non-gprs collection.
Add a weak function non_gprs_mask() to return non-gprs mask.

By default, the non-gprs collection is not support. Specific platforms
should implement their own non-gprs functions if they can collect
non-gprs.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/util/parse-regs-options.c | 10 +++++++++-
 tools/perf/util/perf_regs.c          | 10 ++++++++++
 tools/perf/util/perf_regs.h          |  2 ++
 3 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/parse-regs-options.c b/tools/perf/util/parse-regs-options.c
index b21617f..2f90f31 100644
--- a/tools/perf/util/parse-regs-options.c
+++ b/tools/perf/util/parse-regs-options.c
@@ -12,6 +12,7 @@ __parse_regs(const struct option *opt, const char *str, int unset, bool intr)
 	const struct sample_reg *r;
 	char *s, *os = NULL, *p;
 	int ret = -1;
+	bool has_non_gprs = has_non_gprs_support(intr);
 
 	if (unset)
 		return 0;
@@ -37,6 +38,8 @@ __parse_regs(const struct option *opt, const char *str, int unset, bool intr)
 			if (!strcmp(s, "?")) {
 				fprintf(stderr, "available registers: ");
 				for (r = sample_reg_masks; r->name; r++) {
+					if (!has_non_gprs && (r->mask & ~PERF_REGS_MASK))
+						break;
 					fprintf(stderr, "%s ", r->name);
 				}
 				fputc('\n', stderr);
@@ -44,6 +47,8 @@ __parse_regs(const struct option *opt, const char *str, int unset, bool intr)
 				return -1;
 			}
 			for (r = sample_reg_masks; r->name; r++) {
+				if (!has_non_gprs && (r->mask & ~PERF_REGS_MASK))
+					continue;
 				if (!strcasecmp(s, r->name))
 					break;
 			}
@@ -64,8 +69,11 @@ __parse_regs(const struct option *opt, const char *str, int unset, bool intr)
 	ret = 0;
 
 	/* default to all possible regs */
-	if (*mode == 0)
+	if (*mode == 0) {
 		*mode = PERF_REGS_MASK;
+		if (has_non_gprs)
+			*mode |= non_gprs_mask(intr);
+	}
 error:
 	free(os);
 	return ret;
diff --git a/tools/perf/util/perf_regs.c b/tools/perf/util/perf_regs.c
index 2acfcc5..0d278b6 100644
--- a/tools/perf/util/perf_regs.c
+++ b/tools/perf/util/perf_regs.c
@@ -13,6 +13,16 @@ int __weak arch_sdt_arg_parse_op(char *old_op __maybe_unused,
 	return SDT_ARG_SKIP;
 }
 
+bool __weak has_non_gprs_support(bool intr __maybe_unused)
+{
+	return false;
+}
+
+u64 __weak non_gprs_mask(bool intr __maybe_unused)
+{
+	return 0;
+}
+
 #ifdef HAVE_PERF_REGS_SUPPORT
 int perf_reg_value(u64 *valp, struct regs_dump *regs, int id)
 {
diff --git a/tools/perf/util/perf_regs.h b/tools/perf/util/perf_regs.h
index 1a15a4b..983b4e6 100644
--- a/tools/perf/util/perf_regs.h
+++ b/tools/perf/util/perf_regs.h
@@ -23,6 +23,8 @@ enum {
 };
 
 int arch_sdt_arg_parse_op(char *old_op, char **new_op);
+bool has_non_gprs_support(bool intr);
+u64 non_gprs_mask(bool intr);
 
 #ifdef HAVE_PERF_REGS_SUPPORT
 #include <perf_regs.h>
-- 
2.7.4

