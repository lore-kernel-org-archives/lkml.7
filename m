Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FAB8C17447
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 10:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AF3C222BD
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 10:57:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbfKMK5L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 05:57:11 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:37368 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727720AbfKMK5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 05:57:04 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iUqKM-00026Z-IW; Wed, 13 Nov 2019 11:56:46 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 28E001C0092;
        Wed, 13 Nov 2019 11:56:46 +0100 (CET)
Date:   Wed, 13 Nov 2019 10:56:45 -0000
From:   "tip-bot2 for Alexander Shishkin" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/aux: Allow using AUX data in perf samples
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vince Weaver <vincent.weaver@maine.edu>,
        adrian.hunter@intel.com, mathieu.poirier@linaro.org,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191025140835.53665-2-alexander.shishkin@linux.intel.com>
References: <20191025140835.53665-2-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Message-ID: <157364260576.29376.3181451138881725954.tip-bot2@tip-bot2>
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

Commit-ID:     a4faf00d994c40e64f656805ac375c65e324eefb
Gitweb:        https://git.kernel.org/tip/a4faf00d994c40e64f656805ac375c65e324eefb
Author:        Alexander Shishkin <alexander.shishkin@linux.intel.com>
AuthorDate:    Fri, 25 Oct 2019 17:08:33 +03:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 13 Nov 2019 11:06:14 +01:00

perf/aux: Allow using AUX data in perf samples

AUX data can be used to annotate perf events such as performance counters
or tracepoints/breakpoints by including it in sample records when
PERF_SAMPLE_AUX flag is set. Such samples would be instrumental in debugging
and profiling by providing, for example, a history of instruction flow
leading up to the event's overflow.

The implementation makes use of grouping an AUX event with all the events
that wish to take samples of the AUX data, such that the former is the
group leader. The samplees should also specify the desired size of the AUX
sample via attr.aux_sample_size.

AUX capable PMUs need to explicitly add support for sampling, because it
relies on a new callback to take a snapshot of the buffer without touching
the event states.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Cc: adrian.hunter@intel.com
Cc: mathieu.poirier@linaro.org
Link: https://lkml.kernel.org/r/20191025140835.53665-2-alexander.shishkin@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/perf_event.h      |  19 +++-
 include/uapi/linux/perf_event.h |  10 +-
 kernel/events/core.c            | 173 ++++++++++++++++++++++++++++++-
 kernel/events/internal.h        |   1 +-
 kernel/events/ring_buffer.c     |  36 ++++++-
 5 files changed, 234 insertions(+), 5 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 011dcbd..34c7c69 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -249,6 +249,8 @@ struct perf_event;
 #define PERF_PMU_CAP_NO_EXCLUDE			0x80
 #define PERF_PMU_CAP_AUX_OUTPUT			0x100
 
+struct perf_output_handle;
+
 /**
  * struct pmu - generic performance monitoring unit
  */
@@ -433,6 +435,19 @@ struct pmu {
 	void (*free_aux)		(void *aux); /* optional */
 
 	/*
+	 * Take a snapshot of the AUX buffer without touching the event
+	 * state, so that preempting ->start()/->stop() callbacks does
+	 * not interfere with their logic. Called in PMI context.
+	 *
+	 * Returns the size of AUX data copied to the output handle.
+	 *
+	 * Optional.
+	 */
+	long (*snapshot_aux)		(struct perf_event *event,
+					 struct perf_output_handle *handle,
+					 unsigned long size);
+
+	/*
 	 * Validate address range filters: make sure the HW supports the
 	 * requested configuration and number of filters; return 0 if the
 	 * supplied filters are valid, -errno otherwise.
@@ -973,6 +988,7 @@ struct perf_sample_data {
 		u32	reserved;
 	}				cpu_entry;
 	struct perf_callchain_entry	*callchain;
+	u64				aux_size;
 
 	/*
 	 * regs_user may point to task_pt_regs or to regs_user_copy, depending
@@ -1362,6 +1378,9 @@ extern unsigned int perf_output_copy(struct perf_output_handle *handle,
 			     const void *buf, unsigned int len);
 extern unsigned int perf_output_skip(struct perf_output_handle *handle,
 				     unsigned int len);
+extern long perf_output_copy_aux(struct perf_output_handle *aux_handle,
+				 struct perf_output_handle *handle,
+				 unsigned long from, unsigned long to);
 extern int perf_swevent_get_recursion_context(void);
 extern void perf_swevent_put_recursion_context(int rctx);
 extern u64 perf_swevent_set_period(struct perf_event *event);
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index bb7b271..377d794 100644
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
@@ -424,7 +426,9 @@ struct perf_event_attr {
 	 */
 	__u32	aux_watermark;
 	__u16	sample_max_stack;
-	__u16	__reserved_2;	/* align to __u64 */
+	__u16	__reserved_2;
+	__u32	aux_sample_size;
+	__u32	__reserved_3;
 };
 
 /*
@@ -864,6 +868,8 @@ enum perf_event_type {
 	 *	{ u64			abi; # enum perf_sample_regs_abi
 	 *	  u64			regs[weight(mask)]; } && PERF_SAMPLE_REGS_INTR
 	 *	{ u64			phys_addr;} && PERF_SAMPLE_PHYS_ADDR
+	 *	{ u64			size;
+	 *	  char			data[size]; } && PERF_SAMPLE_AUX
 	 * };
 	 */
 	PERF_RECORD_SAMPLE			= 9,
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 8d65e03..16d80ad 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1941,6 +1941,11 @@ static void perf_put_aux_event(struct perf_event *event)
 	}
 }
 
+static bool perf_need_aux_event(struct perf_event *event)
+{
+	return !!event->attr.aux_output || !!event->attr.aux_sample_size;
+}
+
 static int perf_get_aux_event(struct perf_event *event,
 			      struct perf_event *group_leader)
 {
@@ -1953,7 +1958,17 @@ static int perf_get_aux_event(struct perf_event *event,
 	if (!group_leader)
 		return 0;
 
-	if (!perf_aux_output_match(event, group_leader))
+	/*
+	 * aux_output and aux_sample_size are mutually exclusive.
+	 */
+	if (event->attr.aux_output && event->attr.aux_sample_size)
+		return 0;
+
+	if (event->attr.aux_output &&
+	    !perf_aux_output_match(event, group_leader))
+		return 0;
+
+	if (event->attr.aux_sample_size && !group_leader->pmu->snapshot_aux)
 		return 0;
 
 	if (!atomic_long_inc_not_zero(&group_leader->refcount))
@@ -6222,6 +6237,122 @@ perf_output_sample_ustack(struct perf_output_handle *handle, u64 dump_size,
 	}
 }
 
+static unsigned long perf_prepare_sample_aux(struct perf_event *event,
+					  struct perf_sample_data *data,
+					  size_t size)
+{
+	struct perf_event *sampler = event->aux_event;
+	struct ring_buffer *rb;
+
+	data->aux_size = 0;
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
+	rb = ring_buffer_get(sampler->parent ? sampler->parent : sampler);
+	if (!rb)
+		goto out;
+
+	/*
+	 * If this is an NMI hit inside sampling code, don't take
+	 * the sample. See also perf_aux_sample_output().
+	 */
+	if (READ_ONCE(rb->aux_in_sampling)) {
+		data->aux_size = 0;
+	} else {
+		size = min_t(size_t, size, perf_aux_size(rb));
+		data->aux_size = ALIGN(size, sizeof(u64));
+	}
+	ring_buffer_put(rb);
+
+out:
+	return data->aux_size;
+}
+
+long perf_pmu_snapshot_aux(struct ring_buffer *rb,
+			   struct perf_event *event,
+			   struct perf_output_handle *handle,
+			   unsigned long size)
+{
+	unsigned long flags;
+	long ret;
+
+	/*
+	 * Normal ->start()/->stop() callbacks run in IRQ mode in scheduler
+	 * paths. If we start calling them in NMI context, they may race with
+	 * the IRQ ones, that is, for example, re-starting an event that's just
+	 * been stopped, which is why we're using a separate callback that
+	 * doesn't change the event state.
+	 *
+	 * IRQs need to be disabled to prevent IPIs from racing with us.
+	 */
+	local_irq_save(flags);
+	/*
+	 * Guard against NMI hits inside the critical section;
+	 * see also perf_prepare_sample_aux().
+	 */
+	WRITE_ONCE(rb->aux_in_sampling, 1);
+	barrier();
+
+	ret = event->pmu->snapshot_aux(event, handle, size);
+
+	barrier();
+	WRITE_ONCE(rb->aux_in_sampling, 0);
+	local_irq_restore(flags);
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
+	long size;
+
+	if (WARN_ON_ONCE(!sampler || !data->aux_size))
+		return;
+
+	rb = ring_buffer_get(sampler->parent ? sampler->parent : sampler);
+	if (!rb)
+		return;
+
+	size = perf_pmu_snapshot_aux(rb, sampler, handle, data->aux_size);
+
+	/*
+	 * An error here means that perf_output_copy() failed (returned a
+	 * non-zero surplus that it didn't copy), which in its current
+	 * enlightened implementation is not possible. If that changes, we'd
+	 * like to know.
+	 */
+	if (WARN_ON_ONCE(size < 0))
+		goto out_put;
+
+	/*
+	 * The pad comes from ALIGN()ing data->aux_size up to u64 in
+	 * perf_prepare_sample_aux(), so should not be more than that.
+	 */
+	pad = data->aux_size - size;
+	if (WARN_ON_ONCE(pad >= sizeof(u64)))
+		pad = 8;
+
+	if (pad) {
+		u64 zero = 0;
+		perf_output_copy(handle, &zero, pad);
+	}
+
+out_put:
+	ring_buffer_put(rb);
+}
+
 static void __perf_event_header__init_id(struct perf_event_header *header,
 					 struct perf_sample_data *data,
 					 struct perf_event *event)
@@ -6541,6 +6672,13 @@ void perf_output_sample(struct perf_output_handle *handle,
 	if (sample_type & PERF_SAMPLE_PHYS_ADDR)
 		perf_output_put(handle, data->phys_addr);
 
+	if (sample_type & PERF_SAMPLE_AUX) {
+		perf_output_put(handle, data->aux_size);
+
+		if (data->aux_size)
+			perf_aux_sample_output(event, handle, data);
+	}
+
 	if (!event->attr.watermark) {
 		int wakeup_events = event->attr.wakeup_events;
 
@@ -6729,6 +6867,35 @@ void perf_prepare_sample(struct perf_event_header *header,
 
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
+		size = perf_prepare_sample_aux(event, data, size);
+
+		WARN_ON_ONCE(size + header->size > U16_MAX);
+		header->size += size;
+	}
+	/*
+	 * If you're adding more sample types here, you likely need to do
+	 * something about the overflowing header::size, like repurpose the
+	 * lowest 3 bits of size, which should be always zero at the moment.
+	 * This raises a more important question, do we really need 512k sized
+	 * samples and why, so good argumentation is in order for whatever you
+	 * do here next.
+	 */
+	WARN_ON_ONCE(header->size & 7);
 }
 
 static __always_inline int
@@ -10727,7 +10894,7 @@ static int perf_copy_attr(struct perf_event_attr __user *uattr,
 
 	attr->size = size;
 
-	if (attr->__reserved_1 || attr->__reserved_2)
+	if (attr->__reserved_1 || attr->__reserved_2 || attr->__reserved_3)
 		return -EINVAL;
 
 	if (attr->sample_type & ~(PERF_SAMPLE_MAX-1))
@@ -11277,7 +11444,7 @@ SYSCALL_DEFINE5(perf_event_open,
 		}
 	}
 
-	if (event->attr.aux_output && !perf_get_aux_event(event, group_leader))
+	if (perf_need_aux_event(event) && !perf_get_aux_event(event, group_leader))
 		goto err_locked;
 
 	/*
diff --git a/kernel/events/internal.h b/kernel/events/internal.h
index 3aef419..747d67f 100644
--- a/kernel/events/internal.h
+++ b/kernel/events/internal.h
@@ -50,6 +50,7 @@ struct ring_buffer {
 	unsigned long			aux_mmap_locked;
 	void				(*free_aux)(void *);
 	refcount_t			aux_refcount;
+	int				aux_in_sampling;
 	void				**aux_pages;
 	void				*aux_priv;
 
diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 246c83a..7ffd5c7 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -562,6 +562,42 @@ void *perf_get_aux(struct perf_output_handle *handle)
 }
 EXPORT_SYMBOL_GPL(perf_get_aux);
 
+/*
+ * Copy out AUX data from an AUX handle.
+ */
+long perf_output_copy_aux(struct perf_output_handle *aux_handle,
+			  struct perf_output_handle *handle,
+			  unsigned long from, unsigned long to)
+{
+	unsigned long tocopy, remainder, len = 0;
+	struct ring_buffer *rb = aux_handle->rb;
+	void *addr;
+
+	from &= (rb->aux_nr_pages << PAGE_SHIFT) - 1;
+	to &= (rb->aux_nr_pages << PAGE_SHIFT) - 1;
+
+	do {
+		tocopy = PAGE_SIZE - offset_in_page(from);
+		if (to > from)
+			tocopy = min(tocopy, to - from);
+		if (!tocopy)
+			break;
+
+		addr = rb->aux_pages[from >> PAGE_SHIFT];
+		addr += offset_in_page(from);
+
+		remainder = perf_output_copy(handle, addr, tocopy);
+		if (remainder)
+			return -EFAULT;
+
+		len += tocopy;
+		from += tocopy;
+		from &= (rb->aux_nr_pages << PAGE_SHIFT) - 1;
+	} while (to != from);
+
+	return len;
+}
+
 #define PERF_AUX_GFP	(GFP_KERNEL | __GFP_ZERO | __GFP_NOWARN | __GFP_NORETRY)
 
 static struct page *rb_alloc_aux_page(int node, int order)
