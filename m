Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 165FBCA9ED7
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 08:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8E31217F4
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 08:27:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388182AbfKEI1P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 03:27:15 -0500
Received: from mga04.intel.com ([192.55.52.120]:44760 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387675AbfKEI1O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 03:27:14 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Nov 2019 00:27:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,270,1569308400"; 
   d="scan'208";a="212493687"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 05 Nov 2019 00:27:12 -0800
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH 2/2] perf/x86/intel/pt: Prevent redundant WRMSRs
Date:   Tue,  5 Nov 2019 10:27:01 +0200
Message-Id: <20191105082701.78442-3-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.24.0.rc1
In-Reply-To: <20191105082701.78442-1-alexander.shishkin@linux.intel.com>
References: <20191105082701.78442-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With recent optimizations to AUX and PT buffer management code (high order
AUX allocations, opportunistic Single Range Output), it is far more likely
now that the output MSRs won't need reprogramming on every sched-in.

To avoid needless WRMSRs of those registers, cache their values and only
write them when needed.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 arch/x86/events/intel/pt.c | 25 ++++++++++++++++---------
 arch/x86/events/intel/pt.h | 12 ++++++++----
 2 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index 49426faf2688..41c18126161c 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -606,6 +606,7 @@ static inline phys_addr_t topa_pfn(struct topa *topa)
 
 static void pt_config_buffer(struct pt_buffer *buf)
 {
+	struct pt *pt = this_cpu_ptr(&pt_ctx);
 	u64 reg, mask;
 	void *base;
 
@@ -617,11 +618,17 @@ static void pt_config_buffer(struct pt_buffer *buf)
 		mask = (u64)buf->cur_idx;
 	}
 
-	wrmsrl(MSR_IA32_RTIT_OUTPUT_BASE, virt_to_phys(base));
+	reg = virt_to_phys(base);
+	if (pt->output_base != reg) {
+		pt->output_base = reg;
+		wrmsrl(MSR_IA32_RTIT_OUTPUT_BASE, reg);
+	}
 
 	reg = 0x7f | (mask << 7) | ((u64)buf->output_off << 32);
-
-	wrmsrl(MSR_IA32_RTIT_OUTPUT_MASK, reg);
+	if (pt->output_mask != reg) {
+		pt->output_mask = reg;
+		wrmsrl(MSR_IA32_RTIT_OUTPUT_MASK, reg);
+	}
 }
 
 /**
@@ -930,21 +937,21 @@ static void pt_handle_status(struct pt *pt)
  */
 static void pt_read_offset(struct pt_buffer *buf)
 {
-	u64 offset, base;
+	struct pt *pt = this_cpu_ptr(&pt_ctx);
 	struct topa_page *tp;
 
 	if (!buf->single) {
-		rdmsrl(MSR_IA32_RTIT_OUTPUT_BASE, base);
-		tp = phys_to_virt(base);
+		rdmsrl(MSR_IA32_RTIT_OUTPUT_BASE, pt->output_base);
+		tp = phys_to_virt(pt->output_base);
 		buf->cur = &tp->topa;
 	}
 
-	rdmsrl(MSR_IA32_RTIT_OUTPUT_MASK, offset);
+	rdmsrl(MSR_IA32_RTIT_OUTPUT_MASK, pt->output_mask);
 	/* offset within current output region */
-	buf->output_off = offset >> 32;
+	buf->output_off = pt->output_mask >> 32;
 	/* index of current output region within this table */
 	if (!buf->single)
-		buf->cur_idx = (offset & 0xffffff80) >> 7;
+		buf->cur_idx = (pt->output_mask & 0xffffff80) >> 7;
 }
 
 static struct topa_entry *
diff --git a/arch/x86/events/intel/pt.h b/arch/x86/events/intel/pt.h
index 3f26150886c2..96906a62aacd 100644
--- a/arch/x86/events/intel/pt.h
+++ b/arch/x86/events/intel/pt.h
@@ -113,16 +113,20 @@ struct pt_filters {
 
 /**
  * struct pt - per-cpu pt context
- * @handle:	perf output handle
- * @filters:	last configured filters
- * @handle_nmi:	do handle PT PMI on this cpu, there's an active event
- * @vmx_on:	1 if VMX is ON on this cpu
+ * @handle:		perf output handle
+ * @filters:		last configured filters
+ * @handle_nmi:		do handle PT PMI on this cpu, there's an active event
+ * @vmx_on:		1 if VMX is ON on this cpu
+ * @output_base:	cached RTIT_OUTPUT_BASE MSR value
+ * @output_mask:	cached RTIT_OUTPUT_MASK MSR value
  */
 struct pt {
 	struct perf_output_handle handle;
 	struct pt_filters	filters;
 	int			handle_nmi;
 	int			vmx_on;
+	u64			output_base;
+	u64			output_mask;
 };
 
 #endif /* __INTEL_PT_H__ */
-- 
2.24.0.rc1

