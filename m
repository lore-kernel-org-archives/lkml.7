Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B3AEC10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 15:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 037C4206C0
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 15:52:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728992AbfJHPwa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 11:52:30 -0400
Received: from mga06.intel.com ([134.134.136.31]:21587 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728581AbfJHPwR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 11:52:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Oct 2019 08:52:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,270,1566889200"; 
   d="scan'208";a="277135037"
Received: from otc-lr-04.jf.intel.com ([10.54.39.120])
  by orsmga001.jf.intel.com with ESMTP; 08 Oct 2019 08:52:17 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 7/9] perf/x86/intel: Add Tiger Lake CPU support
Date:   Tue,  8 Oct 2019 08:50:08 -0700
Message-Id: <1570549810-25049-8-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1570549810-25049-1-git-send-email-kan.liang@linux.intel.com>
References: <1570549810-25049-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Tiger Lake is the followon to Ice Lake. From the perspective of Intel
core PMU, there is little changes compared with Ice Lake, e.g. small
changes in event list. But it doesn't impact on core PMU functionality.
Share the perf code with Ice Lake. The event list patch will be submitted
later separately.

The patch has been tested on real hardware.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 9d91a47..fcef678 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -5033,6 +5033,8 @@ __init int intel_pmu_init(void)
 		/* fall through */
 	case INTEL_FAM6_ICELAKE_L:
 	case INTEL_FAM6_ICELAKE:
+	case INTEL_FAM6_TIGERLAKE_L:
+	case INTEL_FAM6_TIGERLAKE:
 		x86_pmu.late_ack = true;
 		memcpy(hw_cache_event_ids, skl_hw_cache_event_ids, sizeof(hw_cache_event_ids));
 		memcpy(hw_cache_extra_regs, skl_hw_cache_extra_regs, sizeof(hw_cache_extra_regs));
-- 
2.7.4

