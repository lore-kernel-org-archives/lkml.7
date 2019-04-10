Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 981A8C10F0E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 01:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71F2B2084F
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 01:10:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbfDJBKr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 21:10:47 -0400
Received: from mga04.intel.com ([192.55.52.120]:13855 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726532AbfDJBKo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 21:10:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Apr 2019 18:10:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,331,1549958400"; 
   d="scan'208";a="134419250"
Received: from otc-lr-04.jf.intel.com ([10.54.39.19])
  by orsmga006.jf.intel.com with ESMTP; 09 Apr 2019 18:10:43 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, acme@kernel.org, jolsa@kernel.org,
        eranian@google.com, alexander.shishkin@linux.intel.com,
        ak@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 1/2] perf/x86/intel: Support adaptive PEBS for fixed counters
Date:   Tue,  9 Apr 2019 18:09:59 -0700
Message-Id: <1554858600-148296-2-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554858600-148296-1-git-send-email-kan.liang@linux.intel.com>
References: <1554858600-148296-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Fixed counters can also generate adaptive PEBS record, if the
corresponding bit in IA32_FIXED_CTR_CTRL is set.
Otherwise, only basic record is generated.

Unconditionally set the bit when PEBS is enabled on fixed counters.
Let MSR_PEBS_CFG decide which format of PEBS record should be generated.
There is no harmful to leave the bit set.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/core.c      | 5 +++++
 arch/x86/include/asm/perf_event.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 56df0f6..f34d92b 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2174,6 +2174,11 @@ static void intel_pmu_enable_fixed(struct perf_event *event)
 	bits <<= (idx * 4);
 	mask = 0xfULL << (idx * 4);
 
+	if (x86_pmu.intel_cap.pebs_baseline && event->attr.precise_ip) {
+		bits |= ICL_FIXED_0_ADAPTIVE << (idx * 4);
+		mask |= ICL_FIXED_0_ADAPTIVE << (idx * 4);
+	}
+
 	rdmsrl(hwc->config_base, ctrl_val);
 	ctrl_val &= ~mask;
 	ctrl_val |= bits;
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index dcb8bac..ce0dc88 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -33,6 +33,7 @@
 #define HSW_IN_TX					(1ULL << 32)
 #define HSW_IN_TX_CHECKPOINTED				(1ULL << 33)
 #define ICL_EVENTSEL_ADAPTIVE				(1ULL << 34)
+#define ICL_FIXED_0_ADAPTIVE				(1ULL << 32)
 
 #define AMD64_EVENTSEL_INT_CORE_ENABLE			(1ULL << 36)
 #define AMD64_EVENTSEL_GUESTONLY			(1ULL << 40)
-- 
2.7.4

