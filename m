Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A57C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 20:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55C5920881
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 20:20:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbfENUUM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 16:20:12 -0400
Received: from mga09.intel.com ([134.134.136.24]:23576 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726036AbfENUUJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 16:20:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 May 2019 13:20:08 -0700
X-ExtLoop1: 1
Received: from otc-lr-04.jf.intel.com ([10.54.39.157])
  by fmsmga006.fm.intel.com with ESMTP; 14 May 2019 13:20:08 -0700
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, jolsa@kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 2/3] perf parse-regs: Add generic support for arch__intr/user_reg_mask()
Date:   Tue, 14 May 2019 13:19:33 -0700
Message-Id: <1557865174-56264-2-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1557865174-56264-1-git-send-email-kan.liang@linux.intel.com>
References: <1557865174-56264-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

There may be different register mask for use with intr or user on some
platforms, e.g. Icelake.

Add weak functions arch__intr_reg_mask() and arch__user_reg_mask() to
return intr and user register mask respectively.

Check mask before printing or comparing the register name.

Generic code always return PERF_REGS_MASK. No functional change.

Suggested-by: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

Changes since V1:
- Drop has_non_gprs_support() and non_gprs_mask()
  Use arch__intr/user_reg_mask()

 tools/perf/util/parse-regs-options.c | 13 ++++++++++---
 tools/perf/util/perf_regs.c          | 10 ++++++++++
 tools/perf/util/perf_regs.h          |  2 ++
 3 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/parse-regs-options.c b/tools/perf/util/parse-regs-options.c
index b21617f..08581e2 100644
--- a/tools/perf/util/parse-regs-options.c
+++ b/tools/perf/util/parse-regs-options.c
@@ -12,6 +12,7 @@ __parse_regs(const struct option *opt, const char *str, int unset, bool intr)
 	const struct sample_reg *r;
 	char *s, *os = NULL, *p;
 	int ret = -1;
+	uint64_t mask;
 
 	if (unset)
 		return 0;
@@ -22,6 +23,11 @@ __parse_regs(const struct option *opt, const char *str, int unset, bool intr)
 	if (*mode)
 		return -1;
 
+	if (intr)
+		mask = arch__intr_reg_mask();
+	else
+		mask = arch__user_reg_mask();
+
 	/* str may be NULL in case no arg is passed to -I */
 	if (str) {
 		/* because str is read-only */
@@ -37,14 +43,15 @@ __parse_regs(const struct option *opt, const char *str, int unset, bool intr)
 			if (!strcmp(s, "?")) {
 				fprintf(stderr, "available registers: ");
 				for (r = sample_reg_masks; r->name; r++) {
-					fprintf(stderr, "%s ", r->name);
+					if (r->mask & mask)
+						fprintf(stderr, "%s ", r->name);
 				}
 				fputc('\n', stderr);
 				/* just printing available regs */
 				return -1;
 			}
 			for (r = sample_reg_masks; r->name; r++) {
-				if (!strcasecmp(s, r->name))
+				if ((r->mask & mask) && !strcasecmp(s, r->name))
 					break;
 			}
 			if (!r->name) {
@@ -65,7 +72,7 @@ __parse_regs(const struct option *opt, const char *str, int unset, bool intr)
 
 	/* default to all possible regs */
 	if (*mode == 0)
-		*mode = PERF_REGS_MASK;
+		*mode = mask;
 error:
 	free(os);
 	return ret;
diff --git a/tools/perf/util/perf_regs.c b/tools/perf/util/perf_regs.c
index 2acfcc5..2774cec 100644
--- a/tools/perf/util/perf_regs.c
+++ b/tools/perf/util/perf_regs.c
@@ -13,6 +13,16 @@ int __weak arch_sdt_arg_parse_op(char *old_op __maybe_unused,
 	return SDT_ARG_SKIP;
 }
 
+uint64_t __weak arch__intr_reg_mask(void)
+{
+	return PERF_REGS_MASK;
+}
+
+uint64_t __weak arch__user_reg_mask(void)
+{
+	return PERF_REGS_MASK;
+}
+
 #ifdef HAVE_PERF_REGS_SUPPORT
 int perf_reg_value(u64 *valp, struct regs_dump *regs, int id)
 {
diff --git a/tools/perf/util/perf_regs.h b/tools/perf/util/perf_regs.h
index 1a15a4b..cb9c246 100644
--- a/tools/perf/util/perf_regs.h
+++ b/tools/perf/util/perf_regs.h
@@ -23,6 +23,8 @@ enum {
 };
 
 int arch_sdt_arg_parse_op(char *old_op, char **new_op);
+uint64_t arch__intr_reg_mask(void);
+uint64_t arch__user_reg_mask(void);
 
 #ifdef HAVE_PERF_REGS_SUPPORT
 #include <perf_regs.h>
-- 
2.7.4

