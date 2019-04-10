Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11DFDC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 18:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2B5B2077C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 18:57:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbfDJS5w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 14:57:52 -0400
Received: from mga04.intel.com ([192.55.52.120]:12518 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726589AbfDJS5t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 14:57:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Apr 2019 11:57:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,334,1549958400"; 
   d="scan'208";a="141655354"
Received: from otc-lr-04.jf.intel.com ([10.54.39.19])
  by orsmga003.jf.intel.com with ESMTP; 10 Apr 2019 11:57:48 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, acme@kernel.org, jolsa@kernel.org,
        eranian@google.com, alexander.shishkin@linux.intel.com,
        ak@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 1/2] perf/x86/intel: Fix the checking for instruction event
Date:   Wed, 10 Apr 2019 11:57:08 -0700
Message-Id: <1554922629-126287-2-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554922629-126287-1-git-send-email-kan.liang@linux.intel.com>
References: <1554922629-126287-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Some bits must be masked before checking X86_CONFIG(.event=0xc0), e.g.
ARCH_PERFMON_EVENTSEL_INT, ARCH_PERFMON_EVENTSEL_USR and
ARCH_PERFMON_EVENTSEL_OS. Those bits will be set in hw_config().
Otherwise the condition will never be met.

Other fields, e.g the INV, ANY, E, or CMASK fields are not allowed for
the reduced Skid PEBS.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

New patch to fix a bug on top of Icelake V5 patch series
(with Peter's cleanup patch).

The patch may be merged back into:

  Subject: perf/x86/intel: Add Icelake support

 arch/x86/events/intel/core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index f34d92b..34220ab 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3421,6 +3421,9 @@ hsw_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
 	return c;
 }
 
+#define EVENT_CONFIG(config)		\
+	(config & (X86_ALL_EVENT_FLAGS | INTEL_ARCH_EVENT_MASK))
+
 static struct event_constraint *
 icl_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
 			  struct perf_event *event)
@@ -3430,7 +3433,7 @@ icl_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
 	 * Force instruction:ppp in Fixed counter 0
 	 */
 	if ((event->attr.precise_ip == 3) &&
-	    (event->hw.config == X86_CONFIG(.event=0xc0)))
+	    (EVENT_CONFIG(event->hw.config) == X86_CONFIG(.event=0xc0)))
 		return &fixed_counter0_constraint;
 
 	return hsw_get_event_constraints(cpuc, idx, event);
-- 
2.7.4

