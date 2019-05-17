Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D2D9C46460
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 19:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C09521726
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 19:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558122072;
	bh=gR3tmnMZzZ8L7oWCW7seSRGoI3m/ADqnzUibuwaL6vg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MrnIwyuScKbZ+anGp+0W7Fj7L46fla8g1NwW5imh0oEeDGZ73yz59RijN2MpivZ9a
	 7gZV20Q0mf5k9vBgNVwUqksLphXWtJ9GHnAyK+e7h8VemA+6L3/ZmI8riZCfSjtlqp
	 qPAculdnPIB6/uz9NjSlNg4vKdeJrXuRoQCmoAWM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729432AbfEQTlL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 15:41:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:57974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726648AbfEQTlK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 15:41:10 -0400
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8201921744;
        Fri, 17 May 2019 19:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558122068;
        bh=gR3tmnMZzZ8L7oWCW7seSRGoI3m/ADqnzUibuwaL6vg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Aq7+XAUq99AZLcZGGeyAA+CCQft07Z3QlyaNnDVhkB/OASTziZQDRN0w3qhZ9wWrN
         5S49amvbzPGhUzKg2OipuPqplQ1xQCbPrzlD/uVJr1um7mYrjTUlubDevqN6+f/47D
         Mh8dy7AiZOBtoqgXI7NfRYnPHjrmC4EfEzTYADsU=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 65/73] perf parse-regs: Add generic support for arch__intr/user_reg_mask()
Date:   Fri, 17 May 2019 16:36:03 -0300
Message-Id: <20190517193611.4974-66-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190517193611.4974-1-acme@kernel.org>
References: <20190517193611.4974-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
-- 
2.20.1

