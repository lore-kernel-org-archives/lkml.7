Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D11D5C04E87
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 00:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B485213F2
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 00:52:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FPkey/77"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727467AbfEUAw5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 20:52:57 -0400
Received: from mail-yb1-f201.google.com ([209.85.219.201]:44610 "EHLO
        mail-yb1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbfEUAw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 20:52:56 -0400
Received: by mail-yb1-f201.google.com with SMTP id 83so15819343ybo.11
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 17:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=dbGBhs5e+j8qP5U9laxaO/gvuR/5GVJYLMdQz5FWs+g=;
        b=FPkey/77dwHAczJOL6bYr0SAaofLrszcmaSgql3afPFLQY0AS0lID/ncChqar1VREN
         sdwomkxX+Y8/cS/OCJZSReflcUOIzou5LJsgoyrmOzwSSYszYmAmHFGqk45PjP6e50Jq
         YdH7+V26AJwWTIdeBCwRJb7rX3vOU+YFD9mqnRrtHYaClTZ+f/Tx/Hb3ZQlZqMLPnmXj
         uokNooT99Z39dbbxtIBXX5TYr94X+Qp6u4ammM6qVmQklU9fD3Oh8u1oU/8+eGcoE2mo
         SSoJzVQo+vxdT7LBOGWpSfL+2wkyOQCFfz/njacZeNP7T4TKj5Onf26hlYZW3NZlKm+3
         XWTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=dbGBhs5e+j8qP5U9laxaO/gvuR/5GVJYLMdQz5FWs+g=;
        b=BLJ81LXLkwk5QAL3GVL+JkM4nequNXCwXdgQyf4ZO9diVpxfEHQ/8NV0ZDu0qlop2W
         Um0Xc9iAgLrO8fui7Fz8p4L2cAxBilPXrf9/QQxXWhoMrsO5GspFyQ1f/SiBzVZu5zFU
         A3Oopgfttu1Ec8Kvss83vFQdz1ZTp6XxXITGTEbxCEamaAyFc/3VCNOHRoVgZvM2NhOB
         3YVgnWq7hYi0IiEBsVDTwG8o/knSiogBsgRRYqnKpSxQEz3tufR7IMSMpcu9vOez5pTu
         Gj7UorkLfIbzjOjDBaP3xfqtcQJT38cu1MC3Vbk+PK5IOk15L3pCaBHk/s7rki5sbU3q
         gimA==
X-Gm-Message-State: APjAAAXK1zCHMA376e2+Xl0OKABkxbHGG0tKxN5kfewkacbh10098g+O
        JXIbgdXT4l2jPZQmQH2GU5ucPqmY3LGj3FVjteOBGQ18PSbbFCWvtL31GrNIj2eYLY8Fjl/1/nm
        7Q+LMdEnsIWmjVL84w9lCcHDlkUR+VpeY0k+YswU2FWQjk3QAKyHQVxA5UgX8VbY27+zP1kW3
X-Google-Smtp-Source: APXvYqyVDRmu+lzQoPwMuXSA4GgKRKnlzQrK2ocdm2xFRpImDG6DE/NLOLhu76SAqpb3GADxdmD55XXBNXT4
X-Received: by 2002:a0d:eb52:: with SMTP id u79mr38684253ywe.119.1558399975339;
 Mon, 20 May 2019 17:52:55 -0700 (PDT)
Date:   Mon, 20 May 2019 17:52:46 -0700
Message-Id: <20190521005246.423-1-eranian@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH v2] perf/x86/intel/ds: fix EVENT vs. UEVENT PEBS constraints
From:   Stephane Eranian <eranian@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, peterz@infradead.org, ak@linux.intel.com,
        kan.liang@intel.com, jolsa@redhat.com, vincent.weaver@maine.edu
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes an issue revealed by the following commit:
Commit 6b89d4c1ae85 ("perf/x86/intel: Fix INTEL_FLAGS_EVENT_CONSTRAINT* masking")

That patch modified INTEL_FLAGS_EVENT_CONSTRAINT() to only look at the event code
when matching a constraint. If code+umask were needed, then the
INTEL_FLAGS_UEVENT_CONSTRAINT() macro was needed instead.
This broke with some of the constraints for PEBS events.
Several of them, including the one used for cycles:p, cycles:pp, cycles:ppp
fell in that category and caused the event to be rejected in PEBS mode.
In other words, on some platforms a cmdline such as:

  $ perf top -e cycles:pp

  would fail with EINVAL.

This patch fixes this issue by properly using INTEL_FLAGS_UEVENT_CONSTRAINT()
when needed in the PEBS constraint tables.

In v2:
  - add fixes for Core2, Nehalem, Silvermont, and Atom

Reported-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Stephane Eranian <eranian@google.com>
---
 arch/x86/events/intel/ds.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index ea2cb6b7e456..5e9bb246b3a6 100644
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
-- 
2.21.0.1020.gf2820cf01a-goog

