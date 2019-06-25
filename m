Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4946C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 14:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C26B12146E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 14:22:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730156AbfFYOWd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 10:22:33 -0400
Received: from mga03.intel.com ([134.134.136.65]:3432 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728252AbfFYOWd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 10:22:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jun 2019 07:22:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,416,1557212400"; 
   d="scan'208";a="359968161"
Received: from otc-icl-cdi-210.jf.intel.com ([10.54.55.28])
  by fmsmga005.fm.intel.com with ESMTP; 25 Jun 2019 07:22:31 -0700
From:   kan.liang@linux.intel.com
To:     mingo@redhat.com, jolsa@kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH] perf/x86/intel: Fix spurious NMI on fixed counter
Date:   Tue, 25 Jun 2019 07:21:35 -0700
Message-Id: <20190625142135.22112-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.14.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

If a user first sample a PEBS event on a fixed counter, then sample a
non-PEBS event on the same fixed counter on Icelake, it will trigger
spurious NMI. For example,

  perf record -e 'cycles:p' -a
  perf record -e 'cycles' -a

The error message for spurious NMI.

  [June 21 15:38] Uhhuh. NMI received for unknown reason 30 on CPU 2.
  [  +0.000000] Do you have a strange power saving mode enabled?
  [  +0.000000] Dazed and confused, but trying to continue

The issue was introduced by the following commit:

  commit 6f55967ad9d9 ("perf/x86/intel: Fix race in intel_pmu_disable_event()")

The commit moves the intel_pmu_pebs_disable() after
intel_pmu_disable_fixed(), which returns immediately.
The related bit of PEBS_ENABLE MSR will never be cleared for the fixed
counter. Then a non-PEBS event runs on the fixed counter, but the bit
on PEBS_ENABLE is still set, which trigger spurious NMI.

Check and disable PEBS for fixed counter after intel_pmu_disable_fixed().

Reported-by: Yi, Ammy <ammy.yi@intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Fixes: 6f55967ad9d9 ("perf/x86/intel: Fix race in intel_pmu_disable_event()")
---
 arch/x86/events/intel/core.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 4377bf6a6f82..464316218b77 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2160,12 +2160,10 @@ static void intel_pmu_disable_event(struct perf_event *event)
 	cpuc->intel_ctrl_host_mask &= ~(1ull << hwc->idx);
 	cpuc->intel_cp_status &= ~(1ull << hwc->idx);
 
-	if (unlikely(hwc->config_base == MSR_ARCH_PERFMON_FIXED_CTR_CTRL)) {
+	if (unlikely(hwc->config_base == MSR_ARCH_PERFMON_FIXED_CTR_CTRL))
 		intel_pmu_disable_fixed(hwc);
-		return;
-	}
-
-	x86_pmu_disable_event(event);
+	else
+		x86_pmu_disable_event(event);
 
 	/*
 	 * Needs to be called after x86_pmu_disable_event,
-- 
2.14.5

