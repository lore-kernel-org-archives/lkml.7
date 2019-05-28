Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0744AC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 22:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D83132075B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 22:09:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728167AbfE1WJ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 18:09:28 -0400
Received: from mga01.intel.com ([192.55.52.88]:11133 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727684AbfE1WJO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 18:09:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 May 2019 15:09:13 -0700
X-ExtLoop1: 1
Received: from otc-lr-04.jf.intel.com ([10.54.39.157])
  by orsmga002.jf.intel.com with ESMTP; 28 May 2019 15:09:13 -0700
From:   kan.liang@linux.intel.com
To:     mingo@kernel.org, acme@redhat.com, peterz@infradead.org,
        vincent.weaver@maine.edu, linux-kernel@vger.kernel.org
Cc:     alexander.shishkin@linux.intel.com, ak@linux.intel.com,
        jolsa@redhat.com, eranian@google.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V3 3/5] perf/x86: Clean up PEBS_XMM_REGS
Date:   Tue, 28 May 2019 15:08:32 -0700
Message-Id: <1559081314-9714-3-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559081314-9714-1-git-send-email-kan.liang@linux.intel.com>
References: <1559081314-9714-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Use generic macro PERF_REG_EXTENDED_MASK to replace PEBS_XMM_REGS to
avoid duplication.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

New for V3

 arch/x86/events/core.c       |  4 ++--
 arch/x86/events/intel/ds.c   |  2 +-
 arch/x86/events/perf_event.h | 18 ------------------
 3 files changed, 3 insertions(+), 21 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index f315425..7708a6f 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -561,13 +561,13 @@ int x86_pmu_hw_config(struct perf_event *event)
 	}
 
 	/* sample_regs_user never support XMM registers */
-	if (unlikely(event->attr.sample_regs_user & PEBS_XMM_REGS))
+	if (unlikely(event->attr.sample_regs_user & PERF_REG_EXTENDED_MASK))
 		return -EINVAL;
 	/*
 	 * Besides the general purpose registers, XMM registers may
 	 * be collected in PEBS on some platforms, e.g. Icelake
 	 */
-	if (unlikely(event->attr.sample_regs_intr & PEBS_XMM_REGS)) {
+	if (unlikely(event->attr.sample_regs_intr & PERF_REG_EXTENDED_MASK)) {
 		if (x86_pmu.pebs_no_xmm_regs)
 			return -EINVAL;
 
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index f860cdd..e6a0fa9 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -987,7 +987,7 @@ static u64 pebs_update_adaptive_cfg(struct perf_event *event)
 		pebs_data_cfg |= PEBS_DATACFG_GP;
 
 	if ((sample_type & PERF_SAMPLE_REGS_INTR) &&
-	    (attr->sample_regs_intr & PEBS_XMM_REGS))
+	    (attr->sample_regs_intr & PERF_REG_EXTENDED_MASK))
 		pebs_data_cfg |= PEBS_DATACFG_XMMS;
 
 	if (sample_type & PERF_SAMPLE_BRANCH_STACK) {
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index a6ac2f4..d3b6e90 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -121,24 +121,6 @@ struct amd_nb {
 	 (1ULL << PERF_REG_X86_R14)   | \
 	 (1ULL << PERF_REG_X86_R15))
 
-#define PEBS_XMM_REGS                   \
-	((1ULL << PERF_REG_X86_XMM0)  | \
-	 (1ULL << PERF_REG_X86_XMM1)  | \
-	 (1ULL << PERF_REG_X86_XMM2)  | \
-	 (1ULL << PERF_REG_X86_XMM3)  | \
-	 (1ULL << PERF_REG_X86_XMM4)  | \
-	 (1ULL << PERF_REG_X86_XMM5)  | \
-	 (1ULL << PERF_REG_X86_XMM6)  | \
-	 (1ULL << PERF_REG_X86_XMM7)  | \
-	 (1ULL << PERF_REG_X86_XMM8)  | \
-	 (1ULL << PERF_REG_X86_XMM9)  | \
-	 (1ULL << PERF_REG_X86_XMM10) | \
-	 (1ULL << PERF_REG_X86_XMM11) | \
-	 (1ULL << PERF_REG_X86_XMM12) | \
-	 (1ULL << PERF_REG_X86_XMM13) | \
-	 (1ULL << PERF_REG_X86_XMM14) | \
-	 (1ULL << PERF_REG_X86_XMM15))
-
 /*
  * Per register state.
  */
-- 
2.7.4

