Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C78C04AAF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 09:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD44920882
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 09:31:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="SR3Kdy6B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730008AbfERJb3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 05:31:29 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34727 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbfERJb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 05:31:29 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4I9VJ6C1742078
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 18 May 2019 02:31:19 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4I9VJ6C1742078
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1558171880;
        bh=4Qd8xv/bKZ75un3Hrz2gqPJOSLiD9F8jnyGYDogsqFo=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=SR3Kdy6BMViy8T+symMgVCjE4bmAlnEcRnaJRJiI0N/TGQ3wbQtCJNdcQXyLGwM/q
         B6AtUt0BMURzXv4TP9kkCLbQcnK5n7p9b3jHuq2208c/30DIfM01nXzSev6MiUYMZ1
         9HHYxAkO6LkXjYBozxUw2b7GwfD710EYqCrWQvM7DJyQFxW8Sh7hM+aNCihBwhRJIV
         Gjc9Vk1tg18b+5ZUGvuOC744cDURl5xaPA8q1mzc+uLS2alsjDtb1C4TI78NOJOg45
         ZgRSCc7kT1sEIhK58Tvp6LQDPJlvIr5lfXIhF6W6oVJBv9fbMhhHTuRTp7VHi7LM1d
         h6IpG4mcnS4XQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4I9VJYW1742075;
        Sat, 18 May 2019 02:31:19 -0700
Date:   Sat, 18 May 2019 02:31:19 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Kan Liang <tipbot@zytor.com>
Message-ID: <tip-af785e75bf616704cab031e66403b6adcf5b700a@git.kernel.org>
Cc:     ravi.bangoria@linux.ibm.com, mingo@kernel.org, tglx@linutronix.de,
        acme@redhat.com, linux-kernel@vger.kernel.org, jolsa@kernel.org,
        ak@linux.intel.com, kan.liang@linux.intel.com, hpa@zytor.com
Reply-To: ravi.bangoria@linux.ibm.com, mingo@kernel.org,
          tglx@linutronix.de, acme@redhat.com,
          linux-kernel@vger.kernel.org, jolsa@kernel.org,
          ak@linux.intel.com, kan.liang@linux.intel.com, hpa@zytor.com
In-Reply-To: <1557865174-56264-2-git-send-email-kan.liang@linux.intel.com>
References: <1557865174-56264-2-git-send-email-kan.liang@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf parse-regs: Add generic support for
 arch__intr/user_reg_mask()
Git-Commit-ID: af785e75bf616704cab031e66403b6adcf5b700a
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  af785e75bf616704cab031e66403b6adcf5b700a
Gitweb:     https://git.kernel.org/tip/af785e75bf616704cab031e66403b6adcf5b700a
Author:     Kan Liang <kan.liang@linux.intel.com>
AuthorDate: Tue, 14 May 2019 13:19:33 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 16 May 2019 14:17:12 -0300

perf parse-regs: Add generic support for arch__intr/user_reg_mask()

There may be different register mask for use with intr or user on some
platforms, e.g. Icelake.

Add weak functions arch__intr_reg_mask() and arch__user_reg_mask() to
return intr and user register mask respectively.

Check mask before printing or comparing the register name.

Generic code always return PERF_REGS_MASK. No functional change.

Suggested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Tested-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/1557865174-56264-2-git-send-email-kan.liang@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/parse-regs-options.c | 13 ++++++++++---
 tools/perf/util/perf_regs.c          | 10 ++++++++++
 tools/perf/util/perf_regs.h          |  2 ++
 3 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/parse-regs-options.c b/tools/perf/util/parse-regs-options.c
index b21617f2bec1..08581e276225 100644
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
index 2acfcc527cac..2774cec1f15f 100644
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
index 1a15a4bfc28d..cb9c246c8962 100644
--- a/tools/perf/util/perf_regs.h
+++ b/tools/perf/util/perf_regs.h
@@ -23,6 +23,8 @@ enum {
 };
 
 int arch_sdt_arg_parse_op(char *old_op, char **new_op);
+uint64_t arch__intr_reg_mask(void);
+uint64_t arch__user_reg_mask(void);
 
 #ifdef HAVE_PERF_REGS_SUPPORT
 #include <perf_regs.h>
