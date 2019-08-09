Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E119FC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 12:32:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7F80208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 12:32:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407044AbfHIMcq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 08:32:46 -0400
Received: from mga14.intel.com ([192.55.52.115]:27717 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406805AbfHIMcn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 08:32:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Aug 2019 05:32:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,364,1559545200"; 
   d="scan'208";a="165994652"
Received: from um.fi.intel.com (HELO localhost) ([10.237.72.183])
  by orsmga007.jf.intel.com with ESMTP; 09 Aug 2019 05:32:40 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-kernel@vger.kernel.org, jolsa@redhat.com,
        alexander.shishkin@linux.intel.com
Subject: Re: [PATCH v1 4/6] perf: Allow using AUX data in perf samples
In-Reply-To: <20180621201632.GE27616@hirez.programming.kicks-ass.net>
References: <20180612075117.65420-1-alexander.shishkin@linux.intel.com> <20180612075117.65420-5-alexander.shishkin@linux.intel.com> <20180614202022.GC12217@hirez.programming.kicks-ass.net> <20180619104725.bqvs7uwzhb4ihyxy@um.fi.intel.com> <20180621201632.GE27616@hirez.programming.kicks-ass.net>
Date:   Fri, 09 Aug 2019 15:32:39 +0300
Message-ID: <87lfw234ew.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:

> On Tue, Jun 19, 2018 at 01:47:25PM +0300, Alexander Shishkin wrote:
>> Right, the SW stuff may then race with event_function_call() stuff. Hmm.
>> For the HW stuff, I'm hoping that some kind of a sleight of hand may
>> suffice. Let me think some more.
>
> I currently don't see how the SW driven snapshot can ever work, see my
> comment on the last patch.

Yes, this should be solved by grouping, similarly PEBS->PT.

>> > Why can't you just snapshot the current location and let the thing
>> > 'run' ?
>> 
>> Because the buffer will overwrite itself and the location will be useless.
>
> Not if it's large enough ;-)
>
>> We don't write the AUX data out in this 'mode' at all, only the samples,
>> which allows for much less data in the resulting perf.data, less work for
>> the consumer, less IO bandwidth etc, and as a bonus, no AUX-related
>> interrupts.
>> 
>> But actually, even to snapshot the location we need to stop the event.
>
> Maybe new methods that should only be called from NMI context? 

Right, I went with that and added a ->snapshot_aux() method that can't
change any states or do anything that would affect the operation of
potentially preempted in-IRQ callbacks. So, if NMI hits in the middle of
->stop() or whatnot, we should be fine. Some context: in AUX overwrite
mode (aka "snapshot mode") we don't get PT related NMIs, the only NMIs
are from the HW events for which we're writing samples. We use the cpu
local ->handle_nmi (a kind of misnomer) to tell us if the NMI hit
between ->start() and ->stop() and we can safely take the sample.

The other problem is sampling SW events, that would require a ctx->lock
to prevent racing with event_function_call()s from other cpus, resulting
in somewhat cringy "if (!in_nmi()) raw_spin_lock(...)", but I don't have
better idea as to how to handle that.

The whole thing is squashed into one patch below for convenience.

From df0b5efd9c24a9e4477a3501331888c4b4682588 Mon Sep 17 00:00:00 2001
From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Date: Tue, 12 Jun 2018 10:51:15 +0300
Subject: [RFC v0] perf, pt: Allow using AUX data in perf samples

---
 arch/x86/events/intel/pt.c      |  40 +++++++++
 include/linux/perf_event.h      |  15 ++++
 include/uapi/linux/perf_event.h |   7 +-
 kernel/events/core.c            | 139 +++++++++++++++++++++++++++++++-
 kernel/events/internal.h        |   1 +
 5 files changed, 200 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index d58124d93e5f..a7318c29242e 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -1413,6 +1413,45 @@ static void pt_event_stop(struct perf_event *event, int mode)
 	}
 }
 
+static long pt_event_snapshot_aux(struct perf_event *event,
+				  struct perf_output_handle *handle,
+				  unsigned long size)
+{
+	struct pt *pt = this_cpu_ptr(&pt_ctx);
+	struct pt_buffer *buf = perf_get_aux(&pt->handle);
+	unsigned long from = 0, to;
+	long ret;
+
+	if (!buf->snapshot)
+		return 0;
+
+	/*
+	 * Here, handle_nmi tells us if the tracing is on
+	 */
+	if (!READ_ONCE(pt->handle_nmi))
+		return 0;
+
+	pt_config_stop(event);
+
+	pt_read_offset(buf);
+	pt_update_head(pt);
+
+	to = local_read(&buf->data_size);
+	if (to < size)
+		from = buf->nr_pages << PAGE_SHIFT;
+	from += to - size;
+
+	ret = perf_output_copy_aux(&pt->handle, handle, from, to);
+
+	/*
+	 * If the tracing was on, restart it.
+	 */
+	if (READ_ONCE(pt->handle_nmi))
+		pt_config(event);
+
+	return ret;
+}
+
 static void pt_event_del(struct perf_event *event, int mode)
 {
 	pt_event_stop(event, PERF_EF_UPDATE);
@@ -1532,6 +1571,7 @@ static __init int pt_init(void)
 	pt_pmu.pmu.del			 = pt_event_del;
 	pt_pmu.pmu.start		 = pt_event_start;
 	pt_pmu.pmu.stop			 = pt_event_stop;
+	pt_pmu.pmu.snapshot_aux		 = pt_event_snapshot_aux;
 	pt_pmu.pmu.read			 = pt_event_read;
 	pt_pmu.pmu.setup_aux		 = pt_buffer_setup_aux;
 	pt_pmu.pmu.free_aux		 = pt_buffer_free_aux;
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 9c8b70e8dc99..48ad35da73cd 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -103,6 +103,10 @@ struct perf_branch_stack {
 	struct perf_branch_entry	entries[0];
 };
 
+struct perf_aux_record {
+	u64		size;
+};
+
 struct task_struct;
 
 /*
@@ -248,6 +252,8 @@ struct perf_event;
 #define PERF_PMU_CAP_NO_EXCLUDE			0x80
 #define PERF_PMU_CAP_AUX_OUTPUT			0x100
 
+struct perf_output_handle;
+
 /**
  * struct pmu - generic performance monitoring unit
  */
@@ -422,6 +428,13 @@ struct pmu {
 	 */
 	void (*free_aux)		(void *aux); /* optional */
 
+	/*
+	 * Fun stuff
+	 */
+	long (*snapshot_aux)		(struct perf_event *event,
+					 struct perf_output_handle *handle,
+					 unsigned long size);
+
 	/*
 	 * Validate address range filters: make sure the HW supports the
 	 * requested configuration and number of filters; return 0 if the
@@ -960,6 +973,7 @@ struct perf_sample_data {
 		u32	reserved;
 	}				cpu_entry;
 	struct perf_callchain_entry	*callchain;
+	struct perf_aux_record		aux;
 
 	/*
 	 * regs_user may point to task_pt_regs or to regs_user_copy, depending
@@ -992,6 +1006,7 @@ static inline void perf_sample_data_init(struct perf_sample_data *data,
 	data->weight = 0;
 	data->data_src.val = PERF_MEM_NA;
 	data->txn = 0;
+	data->aux.size = 0;
 }
 
 extern void perf_output_sample(struct perf_output_handle *handle,
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index bb7b271397a6..947f49d46f0d 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -141,8 +141,9 @@ enum perf_event_sample_format {
 	PERF_SAMPLE_TRANSACTION			= 1U << 17,
 	PERF_SAMPLE_REGS_INTR			= 1U << 18,
 	PERF_SAMPLE_PHYS_ADDR			= 1U << 19,
+	PERF_SAMPLE_AUX				= 1U << 20,
 
-	PERF_SAMPLE_MAX = 1U << 20,		/* non-ABI */
+	PERF_SAMPLE_MAX = 1U << 21,		/* non-ABI */
 
 	__PERF_SAMPLE_CALLCHAIN_EARLY		= 1ULL << 63, /* non-ABI; internal use */
 };
@@ -300,6 +301,7 @@ enum perf_event_read_format {
 					/* add: sample_stack_user */
 #define PERF_ATTR_SIZE_VER4	104	/* add: sample_regs_intr */
 #define PERF_ATTR_SIZE_VER5	112	/* add: aux_watermark */
+#define PERF_ATTR_SIZE_VER6	120	/* add: aux_sample_size */
 
 /*
  * Hardware event_id to monitor via a performance monitoring event:
@@ -425,6 +427,7 @@ struct perf_event_attr {
 	__u32	aux_watermark;
 	__u16	sample_max_stack;
 	__u16	__reserved_2;	/* align to __u64 */
+	__u64	aux_sample_size;
 };
 
 /*
@@ -864,6 +867,8 @@ enum perf_event_type {
 	 *	{ u64			abi; # enum perf_sample_regs_abi
 	 *	  u64			regs[weight(mask)]; } && PERF_SAMPLE_REGS_INTR
 	 *	{ u64			phys_addr;} && PERF_SAMPLE_PHYS_ADDR
+	 *	{ u64			size;
+	 *	  char			data[size]; } && PERF_SAMPLE_AUX
 	 * };
 	 */
 	PERF_RECORD_SAMPLE			= 9,
diff --git a/kernel/events/core.c b/kernel/events/core.c
index d72b756b4ccb..9754c1af51a4 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1953,7 +1953,10 @@ static int perf_get_aux_event(struct perf_event *event,
 	if (!group_leader)
 		return 0;
 
-	if (!perf_aux_output_match(event, group_leader))
+	if (event->attr.aux_output && !perf_aux_output_match(event, group_leader))
+		return 0;
+
+	if (event->attr.aux_sample_size && !group_leader->pmu->snapshot_aux)
 		return 0;
 
 	if (!atomic_long_inc_not_zero(&group_leader->refcount))
@@ -6150,6 +6153,103 @@ perf_output_sample_ustack(struct perf_output_handle *handle, u64 dump_size,
 	}
 }
 
+static unsigned long perf_aux_sample_size(struct perf_event *event,
+					  struct perf_sample_data *data,
+					  size_t size)
+{
+	struct perf_event *sampler = event->aux_event;
+	struct ring_buffer *rb;
+
+	data->aux.size = 0;
+
+	if (!sampler)
+		goto out;
+
+	if (WARN_ON_ONCE(READ_ONCE(sampler->state) != PERF_EVENT_STATE_ACTIVE))
+		goto out;
+
+	if (WARN_ON_ONCE(READ_ONCE(sampler->oncpu) != smp_processor_id()))
+		goto out;
+
+	rb = ring_buffer_get(sampler);
+	if (!rb)
+		goto out;
+
+	size = min(size, perf_aux_size(rb));
+	data->aux.size = ALIGN(size, sizeof(u64));
+	ring_buffer_put(rb);
+
+out:
+	return data->aux.size;
+}
+
+int perf_pmu_aux_sample_output(struct perf_event *event,
+			       struct perf_output_handle *handle,
+			       unsigned long size)
+{
+	unsigned long flags;
+	int ret;
+
+	/*
+	 * NMI vs IRQ
+	 *
+	 * Normal ->start()/->stop() callbacks run in IRQ mode in scheduler
+	 * paths. If we start calling them in NMI context, they may race with
+	 * the IRQ ones, that is, for example, re-starting an event that's just
+	 * been stopped.
+	 */
+	if (!in_nmi())
+		raw_spin_lock_irqsave(&event->ctx->lock, flags);
+
+	ret = event->pmu->snapshot_aux(event, handle, size);
+
+	if (!in_nmi())
+		raw_spin_unlock_irqrestore(&event->ctx->lock, flags);
+
+	return ret;
+}
+
+static void perf_aux_sample_output(struct perf_event *event,
+				   struct perf_output_handle *handle,
+				   struct perf_sample_data *data)
+{
+	struct perf_event *sampler = event->aux_event;
+	unsigned long pad;
+	struct ring_buffer *rb;
+	int ret;
+
+	if (WARN_ON_ONCE(!sampler || !data->aux.size))
+		return;
+
+	rb = ring_buffer_get(sampler);
+	if (!rb)
+		return;
+
+	if (READ_ONCE(rb->aux_in_sampling))
+		goto out_put;
+
+	WRITE_ONCE(rb->aux_in_sampling, 1);
+
+	ret = perf_pmu_aux_sample_output(sampler, handle, data->aux.size);
+	if (ret < 0) {
+		pr_warn_ratelimited("failed to copy trace data\n");
+		goto out_clear;
+	}
+
+	pad = data->aux.size - ret;
+	if (pad) {
+		u64 p = 0;
+
+		perf_output_copy(handle, &p, pad);
+	}
+
+out_clear:
+	WRITE_ONCE(rb->aux_in_sampling, 0);
+
+out_put:
+	ring_buffer_put(rb);
+}
+
 static void __perf_event_header__init_id(struct perf_event_header *header,
 					 struct perf_sample_data *data,
 					 struct perf_event *event)
@@ -6469,6 +6569,13 @@ void perf_output_sample(struct perf_output_handle *handle,
 	if (sample_type & PERF_SAMPLE_PHYS_ADDR)
 		perf_output_put(handle, data->phys_addr);
 
+	if (sample_type & PERF_SAMPLE_AUX) {
+		perf_output_put(handle, data->aux.size);
+
+		if (data->aux.size)
+			perf_aux_sample_output(event, handle, data);
+	}
+
 	if (!event->attr.watermark) {
 		int wakeup_events = event->attr.wakeup_events;
 
@@ -6657,6 +6764,32 @@ void perf_prepare_sample(struct perf_event_header *header,
 
 	if (sample_type & PERF_SAMPLE_PHYS_ADDR)
 		data->phys_addr = perf_virt_to_phys(data->addr);
+
+	if (sample_type & PERF_SAMPLE_AUX) {
+		u64 size;
+
+		header->size += sizeof(u64); /* size */
+
+		/*
+		 * Given the 16bit nature of header::size, an AUX sample can
+		 * easily overflow it, what with all the preceding sample bits.
+		 * Make sure this doesn't happen by using up to U16_MAX bytes
+		 * per sample in total (rounded down to 8 byte boundary).
+		 */
+		size = min_t(size_t, U16_MAX - header->size,
+			     event->attr.aux_sample_size);
+		size = rounddown(size, 8);
+		size = perf_aux_sample_size(event, data, size);
+
+		WARN_ON_ONCE(size + header->size > U16_MAX);
+		header->size += size;
+	}
+	/*
+	 * If you're adding more sample types here, you likely need to do
+	 * something about the overflowing header::size, like repurpose the
+	 * lowest 3 bits of size, which should be always zero at the moment.
+	 */
+	WARN_ON_ONCE(header->size & 7);
 }
 
 static __always_inline int
@@ -11171,9 +11304,12 @@ SYSCALL_DEFINE5(perf_event_open,
 		}
 	}
 
 	if (event->attr.aux_output && !perf_get_aux_event(event, group_leader))
 		goto err_locked;
 
+	if (event->attr.aux_sample_size && !perf_get_aux_event(event, group_leader))
+		goto err_locked;
+
 	/*
 	 * Must be under the same ctx::mutex as perf_install_in_context(),
 	 * because we need to serialize with concurrent event creation.
diff --git a/kernel/events/internal.h b/kernel/events/internal.h
index 3aef4191798c..747d67f130cb 100644
--- a/kernel/events/internal.h
+++ b/kernel/events/internal.h
@@ -50,6 +50,7 @@ struct ring_buffer {
 	unsigned long			aux_mmap_locked;
 	void				(*free_aux)(void *);
 	refcount_t			aux_refcount;
+	int				aux_in_sampling;
 	void				**aux_pages;
 	void				*aux_priv;
 
-- 
2.20.1

