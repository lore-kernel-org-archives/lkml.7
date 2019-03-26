Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12AAFC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 16:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE0D220863
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 16:11:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732270AbfCZQLm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 12:11:42 -0400
Received: from mga02.intel.com ([134.134.136.20]:55266 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732226AbfCZQLi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 12:11:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Mar 2019 09:11:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,273,1549958400"; 
   d="scan'208";a="217714809"
Received: from otc-icl-cdi187.jf.intel.com ([10.54.55.103])
  by orsmga001.jf.intel.com with ESMTP; 26 Mar 2019 09:11:37 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V4 17/23] perf/x86/intel: Export new top down events for Icelake
Date:   Tue, 26 Mar 2019 09:08:55 -0700
Message-Id: <20190326160901.4887-18-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190326160901.4887-1-kan.liang@linux.intel.com>
References: <20190326160901.4887-1-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Export new top down events for perf that map to the sub metrics
in the metrics register, and another for the new slots fixed counter.
This makes the new fixed counters in Icelake visible to the perf
user tools.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

No changes since V3.

 arch/x86/events/intel/core.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 31e4e283e7c5..b08e361fc718 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -320,6 +320,12 @@ EVENT_ATTR_STR_HT(topdown-recovery-bubbles, td_recovery_bubbles,
 EVENT_ATTR_STR_HT(topdown-recovery-bubbles.scale, td_recovery_bubbles_scale,
 	"4", "2");
 
+EVENT_ATTR_STR(slots,			slots,		"event=0x00,umask=0x4");
+EVENT_ATTR_STR(topdown-retiring,	td_retiring,	"event=0xff,umask=0x1");
+EVENT_ATTR_STR(topdown-bad-spec,	td_bad_spec,	"event=0xff,umask=0x2");
+EVENT_ATTR_STR(topdown-fe-bound,	td_fe_bound,	"event=0xff,umask=0x3");
+EVENT_ATTR_STR(topdown-be-bound,	td_be_bound,	"event=0xff,umask=0x4");
+
 static struct attribute *snb_events_attrs[] = {
 	EVENT_PTR(td_slots_issued),
 	EVENT_PTR(td_slots_retired),
@@ -4383,6 +4389,11 @@ EVENT_ATTR_STR(el-capacity-write, el_capacity_write, "event=0x54,umask=0x2");
 static struct attribute *icl_events_attrs[] = {
 	EVENT_PTR(mem_ld_hsw),
 	EVENT_PTR(mem_st_hsw),
+	EVENT_PTR(slots),
+	EVENT_PTR(td_retiring),
+	EVENT_PTR(td_bad_spec),
+	EVENT_PTR(td_fe_bound),
+	EVENT_PTR(td_be_bound),
 	NULL,
 };
 
-- 
2.17.1

