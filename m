Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAEB6C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 17:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA7C820840
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 17:27:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387674AbfGXR1m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 13:27:42 -0400
Received: from mga01.intel.com ([192.55.52.88]:32494 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726714AbfGXR1X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 13:27:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jul 2019 10:18:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,303,1559545200"; 
   d="scan'208";a="368859112"
Received: from labuser-ice-lake-client-platform.jf.intel.com ([10.54.55.84])
  by fmsmga005.fm.intel.com with ESMTP; 24 Jul 2019 10:18:28 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V3 5/8] perf/x86/intel: Export TopDown events for Icelake
Date:   Wed, 24 Jul 2019 10:17:50 -0700
Message-Id: <20190724171753.8087-6-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190724171753.8087-1-kan.liang@linux.intel.com>
References: <20190724171753.8087-1-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Export new TopDown metrics events for perf that map to the sub metrics
in the metrics register, and another for the new slots fixed counter.
This makes the new fixed counters in Icelake visible to the perf
user tools.

Originally-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/core.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 9dc24cebb68c..7925cf8830eb 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -321,6 +321,12 @@ EVENT_ATTR_STR_HT(topdown-recovery-bubbles, td_recovery_bubbles,
 EVENT_ATTR_STR_HT(topdown-recovery-bubbles.scale, td_recovery_bubbles_scale,
 	"4", "2");
 
+EVENT_ATTR_STR(slots,			slots,		"event=0x00,umask=0x4");
+EVENT_ATTR_STR(topdown-retiring,	td_retiring,	"event=0x00,umask=0x10");
+EVENT_ATTR_STR(topdown-bad-spec,	td_bad_spec,	"event=0x00,umask=0x11");
+EVENT_ATTR_STR(topdown-fe-bound,	td_fe_bound,	"event=0x00,umask=0x12");
+EVENT_ATTR_STR(topdown-be-bound,	td_be_bound,	"event=0x00,umask=0x13");
+
 static struct attribute *snb_events_attrs[] = {
 	EVENT_PTR(td_slots_issued),
 	EVENT_PTR(td_slots_retired),
@@ -4544,6 +4550,15 @@ static struct attribute *icl_events_attrs[] = {
 	NULL,
 };
 
+static struct attribute *icl_td_events_attrs[] = {
+	EVENT_PTR(slots),
+	EVENT_PTR(td_retiring),
+	EVENT_PTR(td_bad_spec),
+	EVENT_PTR(td_fe_bound),
+	EVENT_PTR(td_be_bound),
+	NULL,
+};
+
 static struct attribute *icl_tsx_events_attrs[] = {
 	EVENT_PTR(tx_start),
 	EVENT_PTR(tx_abort),
@@ -5312,6 +5327,7 @@ __init int intel_pmu_init(void)
 			hsw_format_attr : nhm_format_attr;
 		extra_skl_attr = skl_format_attr;
 		mem_attr = icl_events_attrs;
+		td_attr = icl_td_events_attrs;
 		tsx_attr = icl_tsx_events_attrs;
 		x86_pmu.rtm_abort_event = X86_CONFIG(.event=0xca, .umask=0x02);
 		x86_pmu.lbr_pt_coexist = true;
-- 
2.17.1

