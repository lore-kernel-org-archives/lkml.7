Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14167C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 10:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D51EB222BD
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 10:57:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbfKMK5F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 05:57:05 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:37373 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727731AbfKMK5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 05:57:04 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iUqKL-00026P-2y; Wed, 13 Nov 2019 11:56:45 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id BB8F51C0357;
        Wed, 13 Nov 2019 11:56:44 +0100 (CET)
Date:   Wed, 13 Nov 2019 10:56:44 -0000
From:   "tip-bot2 for Alexander Shishkin" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/pt: Opportunistically use single
 range output mode
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
In-Reply-To: <20191105082701.78442-2-alexander.shishkin@linux.intel.com>
References: <20191105082701.78442-2-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Message-ID: <157364260438.29376.4571697705075679485.tip-bot2@tip-bot2>
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

Commit-ID:     670638477aede0d7a355ced04b569214aa3feacd
Gitweb:        https://git.kernel.org/tip/670638477aede0d7a355ced04b569214aa3feacd
Author:        Alexander Shishkin <alexander.shishkin@linux.intel.com>
AuthorDate:    Tue, 05 Nov 2019 10:27:00 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 13 Nov 2019 11:06:17 +01:00

perf/x86/intel/pt: Opportunistically use single range output mode

Most of PT implementations support Single Range Output mode, which is
an alternative to ToPA that can be used for a single contiguous buffer
and if we don't require an interrupt, that is, in AUX snapshot mode.

Now that perf core will use high order allocations for the AUX buffer,
in many cases the first condition will also be satisfied.

The two most obvious benefits of the Single Range Output mode over the
ToPA are:

 * not having to allocate the ToPA table(s),
 * not using the ToPA walk hardware.

Make use of this functionality where available and appropriate.

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
Link: https://lkml.kernel.org/r/20191105082701.78442-2-alexander.shishkin@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/intel/pt.c | 118 +++++++++++++++++++++++++++---------
 arch/x86/events/intel/pt.h |   2 +-
 2 files changed, 92 insertions(+), 28 deletions(-)

diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index 2f20d5a..c87d163 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -482,6 +482,8 @@ static u64 pt_config_filters(struct perf_event *event)
 
 static void pt_config(struct perf_event *event)
 {
+	struct pt *pt = this_cpu_ptr(&pt_ctx);
+	struct pt_buffer *buf = perf_get_aux(&pt->handle);
 	u64 reg;
 
 	/* First round: clear STATUS, in particular the PSB byte counter. */
@@ -491,7 +493,9 @@ static void pt_config(struct perf_event *event)
 	}
 
 	reg = pt_config_filters(event);
-	reg |= RTIT_CTL_TOPA | RTIT_CTL_TRACEEN;
+	reg |= RTIT_CTL_TRACEEN;
+	if (!buf->single)
+		reg |= RTIT_CTL_TOPA;
 
 	/*
 	 * Previously, we had BRANCH_EN on by default, but now that PT has
@@ -543,18 +547,6 @@ static void pt_config_stop(struct perf_event *event)
 	wmb();
 }
 
-static void pt_config_buffer(void *buf, unsigned int topa_idx,
-			     unsigned int output_off)
-{
-	u64 reg;
-
-	wrmsrl(MSR_IA32_RTIT_OUTPUT_BASE, virt_to_phys(buf));
-
-	reg = 0x7f | ((u64)topa_idx << 7) | ((u64)output_off << 32);
-
-	wrmsrl(MSR_IA32_RTIT_OUTPUT_MASK, reg);
-}
-
 /**
  * struct topa - ToPA metadata
  * @list:	linkage to struct pt_buffer's list of tables
@@ -612,6 +604,26 @@ static inline phys_addr_t topa_pfn(struct topa *topa)
 #define TOPA_ENTRY_SIZE(t, i) (sizes(TOPA_ENTRY((t), (i))->size))
 #define TOPA_ENTRY_PAGES(t, i) (1 << TOPA_ENTRY((t), (i))->size)
 
+static void pt_config_buffer(struct pt_buffer *buf)
+{
+	u64 reg, mask;
+	void *base;
+
+	if (buf->single) {
+		base = buf->data_pages[0];
+		mask = (buf->nr_pages * PAGE_SIZE - 1) >> 7;
+	} else {
+		base = topa_to_page(buf->cur)->table;
+		mask = (u64)buf->cur_idx;
+	}
+
+	wrmsrl(MSR_IA32_RTIT_OUTPUT_BASE, virt_to_phys(base));
+
+	reg = 0x7f | (mask << 7) | ((u64)buf->output_off << 32);
+
+	wrmsrl(MSR_IA32_RTIT_OUTPUT_MASK, reg);
+}
+
 /**
  * topa_alloc() - allocate page-sized ToPA table
  * @cpu:	CPU on which to allocate.
@@ -812,6 +824,11 @@ static void pt_update_head(struct pt *pt)
 	struct pt_buffer *buf = perf_get_aux(&pt->handle);
 	u64 topa_idx, base, old;
 
+	if (buf->single) {
+		local_set(&buf->data_size, buf->output_off);
+		return;
+	}
+
 	/* offset of the first region in this table from the beginning of buf */
 	base = buf->cur->offset + buf->output_off;
 
@@ -913,18 +930,21 @@ static void pt_handle_status(struct pt *pt)
  */
 static void pt_read_offset(struct pt_buffer *buf)
 {
-	u64 offset, base_topa;
+	u64 offset, base;
 	struct topa_page *tp;
 
-	rdmsrl(MSR_IA32_RTIT_OUTPUT_BASE, base_topa);
-	tp = phys_to_virt(base_topa);
-	buf->cur = &tp->topa;
+	if (!buf->single) {
+		rdmsrl(MSR_IA32_RTIT_OUTPUT_BASE, base);
+		tp = phys_to_virt(base);
+		buf->cur = &tp->topa;
+	}
 
 	rdmsrl(MSR_IA32_RTIT_OUTPUT_MASK, offset);
 	/* offset within current output region */
 	buf->output_off = offset >> 32;
 	/* index of current output region within this table */
-	buf->cur_idx = (offset & 0xffffff80) >> 7;
+	if (!buf->single)
+		buf->cur_idx = (offset & 0xffffff80) >> 7;
 }
 
 static struct topa_entry *
@@ -1040,6 +1060,9 @@ static int pt_buffer_reset_markers(struct pt_buffer *buf,
 	unsigned long head = local64_read(&buf->head);
 	unsigned long idx, npages, wakeup;
 
+	if (buf->single)
+		return 0;
+
 	/* can't stop in the middle of an output region */
 	if (buf->output_off + handle->size + 1 < pt_buffer_region_size(buf)) {
 		perf_aux_output_flag(handle, PERF_AUX_FLAG_TRUNCATED);
@@ -1121,13 +1144,17 @@ static void pt_buffer_reset_offsets(struct pt_buffer *buf, unsigned long head)
 	if (buf->snapshot)
 		head &= (buf->nr_pages << PAGE_SHIFT) - 1;
 
-	pg = (head >> PAGE_SHIFT) & (buf->nr_pages - 1);
-	te = pt_topa_entry_for_page(buf, pg);
+	if (!buf->single) {
+		pg = (head >> PAGE_SHIFT) & (buf->nr_pages - 1);
+		te = pt_topa_entry_for_page(buf, pg);
 
-	cur_tp = topa_entry_to_page(te);
-	buf->cur = &cur_tp->topa;
-	buf->cur_idx = te - TOPA_ENTRY(buf->cur, 0);
-	buf->output_off = head & (pt_buffer_region_size(buf) - 1);
+		cur_tp = topa_entry_to_page(te);
+		buf->cur = &cur_tp->topa;
+		buf->cur_idx = te - TOPA_ENTRY(buf->cur, 0);
+		buf->output_off = head & (pt_buffer_region_size(buf) - 1);
+	} else {
+		buf->output_off = head;
+	}
 
 	local64_set(&buf->head, head);
 	local_set(&buf->data_size, 0);
@@ -1141,6 +1168,9 @@ static void pt_buffer_fini_topa(struct pt_buffer *buf)
 {
 	struct topa *topa, *iter;
 
+	if (buf->single)
+		return;
+
 	list_for_each_entry_safe(topa, iter, &buf->tables, list) {
 		/*
 		 * right now, this is in free_aux() path only, so
@@ -1186,6 +1216,36 @@ static int pt_buffer_init_topa(struct pt_buffer *buf, int cpu,
 	return 0;
 }
 
+static int pt_buffer_try_single(struct pt_buffer *buf, int nr_pages)
+{
+	struct page *p = virt_to_page(buf->data_pages[0]);
+	int ret = -ENOTSUPP, order = 0;
+
+	/*
+	 * We can use single range output mode
+	 * + in snapshot mode, where we don't need interrupts;
+	 * + if the hardware supports it;
+	 * + if the entire buffer is one contiguous allocation.
+	 */
+	if (!buf->snapshot)
+		goto out;
+
+	if (!intel_pt_validate_hw_cap(PT_CAP_single_range_output))
+		goto out;
+
+	if (PagePrivate(p))
+		order = page_private(p);
+
+	if (1 << order != nr_pages)
+		goto out;
+
+	buf->single = true;
+	buf->nr_pages = nr_pages;
+	ret = 0;
+out:
+	return ret;
+}
+
 /**
  * pt_buffer_setup_aux() - set up topa tables for a PT buffer
  * @cpu:	Cpu on which to allocate, -1 means current.
@@ -1230,6 +1290,10 @@ pt_buffer_setup_aux(struct perf_event *event, void **pages,
 
 	INIT_LIST_HEAD(&buf->tables);
 
+	ret = pt_buffer_try_single(buf, nr_pages);
+	if (!ret)
+		return buf;
+
 	ret = pt_buffer_init_topa(buf, cpu, nr_pages, GFP_KERNEL);
 	if (ret) {
 		kfree(buf);
@@ -1396,8 +1460,7 @@ void intel_pt_interrupt(void)
 			return;
 		}
 
-		pt_config_buffer(topa_to_page(buf->cur)->table, buf->cur_idx,
-				 buf->output_off);
+		pt_config_buffer(buf);
 		pt_config_start(event);
 	}
 }
@@ -1461,8 +1524,7 @@ static void pt_event_start(struct perf_event *event, int mode)
 	WRITE_ONCE(pt->handle_nmi, 1);
 	hwc->state = 0;
 
-	pt_config_buffer(topa_to_page(buf->cur)->table, buf->cur_idx,
-			 buf->output_off);
+	pt_config_buffer(buf);
 	pt_config(event);
 
 	return;
diff --git a/arch/x86/events/intel/pt.h b/arch/x86/events/intel/pt.h
index 1d2bb75..3f78182 100644
--- a/arch/x86/events/intel/pt.h
+++ b/arch/x86/events/intel/pt.h
@@ -64,6 +64,7 @@ struct pt_pmu {
  * @lost:	if data was lost/truncated
  * @head:	logical write offset inside the buffer
  * @snapshot:	if this is for a snapshot/overwrite counter
+ * @single:	use Single Range Output instead of ToPA
  * @stop_pos:	STOP topa entry index
  * @intr_pos:	INT topa entry index
  * @stop_te:	STOP topa entry pointer
@@ -80,6 +81,7 @@ struct pt_buffer {
 	local_t			data_size;
 	local64_t		head;
 	bool			snapshot;
+	bool			single;
 	long			stop_pos, intr_pos;
 	struct topa_entry	*stop_te, *intr_te;
 	void			**data_pages;
