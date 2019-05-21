Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1912C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 08:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2782216B7
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 08:29:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="EZRJDf3Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbfEUI3c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 04:29:32 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45533 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbfEUI3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 04:29:32 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4L8SDAD3090919
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 21 May 2019 01:28:14 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4L8SDAD3090919
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1558427294;
        bh=rRW28Cvkz9pK3Rig70/BespMV5RETILakf+L5oAJcQI=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=EZRJDf3ZDAvKZK1/Wc+38hH4SVLSQDvIqnEPL7DPTh9ygDoRnF8sEhb7hYeA/j/YG
         Q0nPuekGbL2zI1Bu4OkGyawgray4vbyMEhgGkf0r7sZ7+Zhlc+6jBVktyfE+qAhdzC
         us2jwXNPldfKQrrB3d/QdxVxEwyM1Kt3/7xSi5M6QE1KwKyUrG90jPYAwBU5zN9XIY
         f6+0VMPqjqgF0O9+v0EkvXaElJA7FbPzlraPlQxVad9KjZ2ZWSlZbFfxV6d6Gqabi5
         u7NAlR0khVlNYSZxZWHJZO2Ylw7aY/E+7obEHNhrTOBmsTvtE/TUN4YmWCXdECALBh
         l9HSDjEqMdQuQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4L8SDV93090907;
        Tue, 21 May 2019 01:28:13 -0700
Date:   Tue, 21 May 2019 01:28:13 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Stephane Eranian <tipbot@zytor.com>
Message-ID: <tip-23e3983a466cd540ffdd2bbc6e0c51e31934f941@git.kernel.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        vincent.weaver@maine.edu, acme@redhat.com,
        torvalds@linux-foundation.org, hpa@zytor.com,
        alexander.shishkin@linux.intel.com, tglx@linutronix.de,
        eranian@google.com, peterz@infradead.org, jolsa@redhat.com
Reply-To: tglx@linutronix.de, mingo@kernel.org, peterz@infradead.org,
          eranian@google.com, linux-kernel@vger.kernel.org,
          vincent.weaver@maine.edu, acme@redhat.com, jolsa@redhat.com,
          torvalds@linux-foundation.org, hpa@zytor.com,
          alexander.shishkin@linux.intel.com
In-Reply-To: <20190521005246.423-1-eranian@google.com>
References: <20190521005246.423-1-eranian@google.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf/x86/intel/ds: Fix EVENT vs. UEVENT PEBS
 constraints
Git-Commit-ID: 23e3983a466cd540ffdd2bbc6e0c51e31934f941
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

Commit-ID:  23e3983a466cd540ffdd2bbc6e0c51e31934f941
Gitweb:     https://git.kernel.org/tip/23e3983a466cd540ffdd2bbc6e0c51e31934f941
Author:     Stephane Eranian <eranian@google.com>
AuthorDate: Mon, 20 May 2019 17:52:46 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 21 May 2019 10:25:29 +0200

perf/x86/intel/ds: Fix EVENT vs. UEVENT PEBS constraints

This patch fixes an bug revealed by the following commit:

  6b89d4c1ae85 ("perf/x86/intel: Fix INTEL_FLAGS_EVENT_CONSTRAINT* masking")

That patch modified INTEL_FLAGS_EVENT_CONSTRAINT() to only look at the event code
when matching a constraint. If code+umask were needed, then the
INTEL_FLAGS_UEVENT_CONSTRAINT() macro was needed instead.
This broke with some of the constraints for PEBS events.

Several of them, including the one used for cycles:p, cycles:pp, cycles:ppp
fell in that category and caused the event to be rejected in PEBS mode.
In other words, on some platforms a cmdline such as:

  $ perf top -e cycles:pp

would fail with -EINVAL.

This patch fixes this bug by properly using INTEL_FLAGS_UEVENT_CONSTRAINT()
when needed in the PEBS constraint tables.

Reported-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Stephane Eranian <eranian@google.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Cc: kan.liang@intel.com
Link: http://lkml.kernel.org/r/20190521005246.423-1-eranian@google.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/intel/ds.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 7a9f5dac5abe..7acc526b4ad2 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -684,7 +684,7 @@ struct event_constraint intel_core2_pebs_event_constraints[] = {
 	INTEL_FLAGS_UEVENT_CONSTRAINT(0x1fc7, 0x1), /* SIMD_INST_RETURED.ANY */
 	INTEL_FLAGS_EVENT_CONSTRAINT(0xcb, 0x1),    /* MEM_LOAD_RETIRED.* */
 	/* INST_RETIRED.ANY_P, inv=1, cmask=16 (cycles:p). */
-	INTEL_FLAGS_EVENT_CONSTRAINT(0x108000c0, 0x01),
+	INTEL_FLAGS_UEVENT_CONSTRAINT(0x108000c0, 0x01),
 	EVENT_CONSTRAINT_END
 };
 
@@ -693,7 +693,7 @@ struct event_constraint intel_atom_pebs_event_constraints[] = {
 	INTEL_FLAGS_UEVENT_CONSTRAINT(0x00c5, 0x1), /* MISPREDICTED_BRANCH_RETIRED */
 	INTEL_FLAGS_EVENT_CONSTRAINT(0xcb, 0x1),    /* MEM_LOAD_RETIRED.* */
 	/* INST_RETIRED.ANY_P, inv=1, cmask=16 (cycles:p). */
-	INTEL_FLAGS_EVENT_CONSTRAINT(0x108000c0, 0x01),
+	INTEL_FLAGS_UEVENT_CONSTRAINT(0x108000c0, 0x01),
 	/* Allow all events as PEBS with no flags */
 	INTEL_ALL_EVENT_CONSTRAINT(0, 0x1),
 	EVENT_CONSTRAINT_END
@@ -701,7 +701,7 @@ struct event_constraint intel_atom_pebs_event_constraints[] = {
 
 struct event_constraint intel_slm_pebs_event_constraints[] = {
 	/* INST_RETIRED.ANY_P, inv=1, cmask=16 (cycles:p). */
-	INTEL_FLAGS_EVENT_CONSTRAINT(0x108000c0, 0x1),
+	INTEL_FLAGS_UEVENT_CONSTRAINT(0x108000c0, 0x1),
 	/* Allow all events as PEBS with no flags */
 	INTEL_ALL_EVENT_CONSTRAINT(0, 0x1),
 	EVENT_CONSTRAINT_END
@@ -726,7 +726,7 @@ struct event_constraint intel_nehalem_pebs_event_constraints[] = {
 	INTEL_FLAGS_EVENT_CONSTRAINT(0xcb, 0xf),    /* MEM_LOAD_RETIRED.* */
 	INTEL_FLAGS_EVENT_CONSTRAINT(0xf7, 0xf),    /* FP_ASSIST.* */
 	/* INST_RETIRED.ANY_P, inv=1, cmask=16 (cycles:p). */
-	INTEL_FLAGS_EVENT_CONSTRAINT(0x108000c0, 0x0f),
+	INTEL_FLAGS_UEVENT_CONSTRAINT(0x108000c0, 0x0f),
 	EVENT_CONSTRAINT_END
 };
 
@@ -743,7 +743,7 @@ struct event_constraint intel_westmere_pebs_event_constraints[] = {
 	INTEL_FLAGS_EVENT_CONSTRAINT(0xcb, 0xf),    /* MEM_LOAD_RETIRED.* */
 	INTEL_FLAGS_EVENT_CONSTRAINT(0xf7, 0xf),    /* FP_ASSIST.* */
 	/* INST_RETIRED.ANY_P, inv=1, cmask=16 (cycles:p). */
-	INTEL_FLAGS_EVENT_CONSTRAINT(0x108000c0, 0x0f),
+	INTEL_FLAGS_UEVENT_CONSTRAINT(0x108000c0, 0x0f),
 	EVENT_CONSTRAINT_END
 };
 
@@ -752,7 +752,7 @@ struct event_constraint intel_snb_pebs_event_constraints[] = {
 	INTEL_PLD_CONSTRAINT(0x01cd, 0x8),    /* MEM_TRANS_RETIRED.LAT_ABOVE_THR */
 	INTEL_PST_CONSTRAINT(0x02cd, 0x8),    /* MEM_TRANS_RETIRED.PRECISE_STORES */
 	/* UOPS_RETIRED.ALL, inv=1, cmask=16 (cycles:p). */
-	INTEL_FLAGS_EVENT_CONSTRAINT(0x108001c2, 0xf),
+	INTEL_FLAGS_UEVENT_CONSTRAINT(0x108001c2, 0xf),
         INTEL_EXCLEVT_CONSTRAINT(0xd0, 0xf),    /* MEM_UOP_RETIRED.* */
         INTEL_EXCLEVT_CONSTRAINT(0xd1, 0xf),    /* MEM_LOAD_UOPS_RETIRED.* */
         INTEL_EXCLEVT_CONSTRAINT(0xd2, 0xf),    /* MEM_LOAD_UOPS_LLC_HIT_RETIRED.* */
@@ -767,9 +767,9 @@ struct event_constraint intel_ivb_pebs_event_constraints[] = {
         INTEL_PLD_CONSTRAINT(0x01cd, 0x8),    /* MEM_TRANS_RETIRED.LAT_ABOVE_THR */
 	INTEL_PST_CONSTRAINT(0x02cd, 0x8),    /* MEM_TRANS_RETIRED.PRECISE_STORES */
 	/* UOPS_RETIRED.ALL, inv=1, cmask=16 (cycles:p). */
-	INTEL_FLAGS_EVENT_CONSTRAINT(0x108001c2, 0xf),
+	INTEL_FLAGS_UEVENT_CONSTRAINT(0x108001c2, 0xf),
 	/* INST_RETIRED.PREC_DIST, inv=1, cmask=16 (cycles:ppp). */
-	INTEL_FLAGS_EVENT_CONSTRAINT(0x108001c0, 0x2),
+	INTEL_FLAGS_UEVENT_CONSTRAINT(0x108001c0, 0x2),
 	INTEL_EXCLEVT_CONSTRAINT(0xd0, 0xf),    /* MEM_UOP_RETIRED.* */
 	INTEL_EXCLEVT_CONSTRAINT(0xd1, 0xf),    /* MEM_LOAD_UOPS_RETIRED.* */
 	INTEL_EXCLEVT_CONSTRAINT(0xd2, 0xf),    /* MEM_LOAD_UOPS_LLC_HIT_RETIRED.* */
@@ -783,9 +783,9 @@ struct event_constraint intel_hsw_pebs_event_constraints[] = {
 	INTEL_FLAGS_UEVENT_CONSTRAINT(0x01c0, 0x2), /* INST_RETIRED.PRECDIST */
 	INTEL_PLD_CONSTRAINT(0x01cd, 0xf),    /* MEM_TRANS_RETIRED.* */
 	/* UOPS_RETIRED.ALL, inv=1, cmask=16 (cycles:p). */
-	INTEL_FLAGS_EVENT_CONSTRAINT(0x108001c2, 0xf),
+	INTEL_FLAGS_UEVENT_CONSTRAINT(0x108001c2, 0xf),
 	/* INST_RETIRED.PREC_DIST, inv=1, cmask=16 (cycles:ppp). */
-	INTEL_FLAGS_EVENT_CONSTRAINT(0x108001c0, 0x2),
+	INTEL_FLAGS_UEVENT_CONSTRAINT(0x108001c0, 0x2),
 	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_NA(0x01c2, 0xf), /* UOPS_RETIRED.ALL */
 	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_XLD(0x11d0, 0xf), /* MEM_UOPS_RETIRED.STLB_MISS_LOADS */
 	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_XLD(0x21d0, 0xf), /* MEM_UOPS_RETIRED.LOCK_LOADS */
@@ -806,9 +806,9 @@ struct event_constraint intel_bdw_pebs_event_constraints[] = {
 	INTEL_FLAGS_UEVENT_CONSTRAINT(0x01c0, 0x2), /* INST_RETIRED.PRECDIST */
 	INTEL_PLD_CONSTRAINT(0x01cd, 0xf),    /* MEM_TRANS_RETIRED.* */
 	/* UOPS_RETIRED.ALL, inv=1, cmask=16 (cycles:p). */
-	INTEL_FLAGS_EVENT_CONSTRAINT(0x108001c2, 0xf),
+	INTEL_FLAGS_UEVENT_CONSTRAINT(0x108001c2, 0xf),
 	/* INST_RETIRED.PREC_DIST, inv=1, cmask=16 (cycles:ppp). */
-	INTEL_FLAGS_EVENT_CONSTRAINT(0x108001c0, 0x2),
+	INTEL_FLAGS_UEVENT_CONSTRAINT(0x108001c0, 0x2),
 	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_NA(0x01c2, 0xf), /* UOPS_RETIRED.ALL */
 	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_LD(0x11d0, 0xf), /* MEM_UOPS_RETIRED.STLB_MISS_LOADS */
 	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_LD(0x21d0, 0xf), /* MEM_UOPS_RETIRED.LOCK_LOADS */
@@ -829,9 +829,9 @@ struct event_constraint intel_bdw_pebs_event_constraints[] = {
 struct event_constraint intel_skl_pebs_event_constraints[] = {
 	INTEL_FLAGS_UEVENT_CONSTRAINT(0x1c0, 0x2),	/* INST_RETIRED.PREC_DIST */
 	/* INST_RETIRED.PREC_DIST, inv=1, cmask=16 (cycles:ppp). */
-	INTEL_FLAGS_EVENT_CONSTRAINT(0x108001c0, 0x2),
+	INTEL_FLAGS_UEVENT_CONSTRAINT(0x108001c0, 0x2),
 	/* INST_RETIRED.TOTAL_CYCLES_PS (inv=1, cmask=16) (cycles:p). */
-	INTEL_FLAGS_EVENT_CONSTRAINT(0x108000c0, 0x0f),
+	INTEL_FLAGS_UEVENT_CONSTRAINT(0x108000c0, 0x0f),
 	INTEL_PLD_CONSTRAINT(0x1cd, 0xf),		      /* MEM_TRANS_RETIRED.* */
 	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_LD(0x11d0, 0xf), /* MEM_INST_RETIRED.STLB_MISS_LOADS */
 	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_ST(0x12d0, 0xf), /* MEM_INST_RETIRED.STLB_MISS_STORES */
