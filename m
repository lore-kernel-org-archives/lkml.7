Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F8E7CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 14:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A55720679
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 14:09:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503423AbfJYOJA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 10:09:00 -0400
Received: from mga11.intel.com ([192.55.52.93]:57127 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2503311AbfJYOI6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 10:08:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Oct 2019 07:08:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,228,1569308400"; 
   d="scan'208";a="350035414"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 25 Oct 2019 07:08:54 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        jolsa@redhat.com, adrian.hunter@intel.com,
        mathieu.poirier@linaro.org, mark.rutland@arm.com,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH v3 2/3] perf/x86/intel/pt: Factor out starting the trace
Date:   Fri, 25 Oct 2019 17:08:34 +0300
Message-Id: <20191025140835.53665-3-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191025140835.53665-1-alexander.shishkin@linux.intel.com>
References: <20191025140835.53665-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PT trace is now enabled at the bottom of the event configuration
function that takes care of all configuration bits related to a given
event, including the address filter update. This is only needed where
the event configuration changes, that is, in ->add()/->start().

In the interrupt path we can use a lighter version that keeps the
configuration intact, since it hasn't changed, and only flips the
enable bit.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 arch/x86/events/intel/pt.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index 05e43d0f430b..170f3b402274 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -397,6 +397,20 @@ static bool pt_event_valid(struct perf_event *event)
  * These all are cpu affine and operate on a local PT
  */
 
+static void pt_config_start(struct perf_event *event)
+{
+	struct pt *pt = this_cpu_ptr(&pt_ctx);
+	u64 ctl = event->hw.config;
+
+	ctl |= RTIT_CTL_TRACEEN;
+	if (READ_ONCE(pt->vmx_on))
+		perf_aux_output_flag(&pt->handle, PERF_AUX_FLAG_PARTIAL);
+	else
+		wrmsrl(MSR_IA32_RTIT_CTL, ctl);
+
+	WRITE_ONCE(event->hw.config, ctl);
+}
+
 /* Address ranges and their corresponding msr configuration registers */
 static const struct pt_address_range {
 	unsigned long	msr_a;
@@ -468,7 +482,6 @@ static u64 pt_config_filters(struct perf_event *event)
 
 static void pt_config(struct perf_event *event)
 {
-	struct pt *pt = this_cpu_ptr(&pt_ctx);
 	u64 reg;
 
 	/* First round: clear STATUS, in particular the PSB byte counter. */
@@ -501,10 +514,7 @@ static void pt_config(struct perf_event *event)
 	reg |= (event->attr.config & PT_CONFIG_MASK);
 
 	event->hw.config = reg;
-	if (READ_ONCE(pt->vmx_on))
-		perf_aux_output_flag(&pt->handle, PERF_AUX_FLAG_PARTIAL);
-	else
-		wrmsrl(MSR_IA32_RTIT_CTL, reg);
+	pt_config_start(event);
 }
 
 static void pt_config_stop(struct perf_event *event)
@@ -1381,7 +1391,7 @@ void intel_pt_interrupt(void)
 
 		pt_config_buffer(topa_to_page(buf->cur)->table, buf->cur_idx,
 				 buf->output_off);
-		pt_config(event);
+		pt_config_start(event);
 	}
 }
 
-- 
2.23.0

