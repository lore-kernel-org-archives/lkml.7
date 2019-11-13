Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B47C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 10:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 094F6222BD
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 10:57:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbfKMK5T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 05:57:19 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:37371 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727211AbfKMK5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 05:57:03 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iUqKK-00026O-Mc; Wed, 13 Nov 2019 11:56:44 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 434D81C0092;
        Wed, 13 Nov 2019 11:56:44 +0100 (CET)
Date:   Wed, 13 Nov 2019 10:56:43 -0000
From:   "tip-bot2 for Alexander Shishkin" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/pt: Prevent redundant WRMSRs
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191105082701.78442-3-alexander.shishkin@linux.intel.com>
References: <20191105082701.78442-3-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Message-ID: <157364260386.29376.10869455028795555021.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     295c52ee1485e4dee660fc1a0e6ceed6c803c9d3
Gitweb:        https://git.kernel.org/tip/295c52ee1485e4dee660fc1a0e6ceed6c803c9d3
Author:        Alexander Shishkin <alexander.shishkin@linux.intel.com>
AuthorDate:    Tue, 05 Nov 2019 10:27:01 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 13 Nov 2019 11:06:18 +01:00

perf/x86/intel/pt: Prevent redundant WRMSRs

With recent optimizations to AUX and PT buffer management code (high order
AUX allocations, opportunistic Single Range Output), it is far more likely
now that the output MSRs won't need reprogramming on every sched-in.

To avoid needless WRMSRs of those registers, cache their values and only
write them when needed.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Link: https://lkml.kernel.org/r/20191105082701.78442-3-alexander.shishkin@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/intel/pt.c | 25 ++++++++++++++++---------
 arch/x86/events/intel/pt.h | 10 +++++++---
 2 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index c87d163..1db7a51 100644
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
index 3f78182..96906a6 100644
--- a/arch/x86/events/intel/pt.h
+++ b/arch/x86/events/intel/pt.h
@@ -113,16 +113,20 @@ struct pt_filters {
 
 /**
  * struct pt - per-cpu pt context
- * @handle:	perf output handle
+ * @handle:		perf output handle
  * @filters:		last configured filters
- * @handle_nmi:	do handle PT PMI on this cpu, there's an active event
- * @vmx_on:	1 if VMX is ON on this cpu
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
