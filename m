Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF1BBCA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 14:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E26A2166E
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 14:12:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lMdCIZOr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393882AbfJXOMv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 10:12:51 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49090 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391388AbfJXOMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 10:12:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=JvoxmUU9b2uQwSKQN281RvIAE5KjAQVrkH7Nx19kI/o=; b=lMdCIZOrmJ8MAgG0/DrMnpRtn
        kAUMhb767m0+ln4AlDkxKSXaypMHqM88jnQsZeuabD91KCzrSSCcBxKbU2ULuxZn+vnJt44S+wLv4
        qBzgWzFutyCv5mx6HafsdjzrkswFReSMhiJ2td7bgCnXtsarYoMMQo0mDIPD8iITpxyCwGAnatY7x
        HZAj0AaTCWIdgfvfiqgYmELYLBlN1Ph7+GQXQbPtjNwrb1+Ucs04Qk1U01NPe7ZMiWr857j7Ox/nw
        KY8k6e2GSQU6F28iV7Y7OA+ser8oLeAD1S9oUH52D8yFnxqJm2jzYOgJeIqUe5hifMAO7Sl3DlX9P
        SbaBk2J6Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iNdr1-0002dU-0x; Thu, 24 Oct 2019 14:12:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4FF8F303DDD;
        Thu, 24 Oct 2019 16:11:42 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A19D92B1D7CA7; Thu, 24 Oct 2019 16:12:40 +0200 (CEST)
Date:   Thu, 24 Oct 2019 16:12:40 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        jolsa@redhat.com, adrian.hunter@intel.com,
        mathieu.poirier@linaro.org, mark.rutland@arm.com
Subject: Re: [PATCH v2 1/4] perf: Allow using AUX data in perf samples
Message-ID: <20191024141240.GI4114@hirez.programming.kicks-ass.net>
References: <20191022095812.67071-1-alexander.shishkin@linux.intel.com>
 <20191022095812.67071-2-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022095812.67071-2-alexander.shishkin@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2019 at 12:58:09PM +0300, Alexander Shishkin wrote:
> AUX data can be used to annotate perf events such as performance counters
> or tracepoints/breakpoints by including it in sample records when
> PERF_SAMPLE_AUX flag is set. Such samples would be instrumental in debugging
> and profiling by providing, for example, a history of instruction flow
> leading up to the event's overflow.
> 
> The implementation makes use of grouping an AUX event with all the events
> that wish to take samples of the AUX data, such that the former is the
> group leader. The samplees should also specify the desired size of the AUX
> sample via attr.aux_sample_size.
> 
> AUX capable PMUs need to explicitly add support for sampling, because it
> relies on a new callback to take a snapshot of the buffer without touching
> the event states.

Mathieu (and other ARM-CS folks) is this something that can work for
you? It would be really bad to discover this interface can't work for
you after it's been merged.

> Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> ---
>  include/linux/perf_event.h      |  20 ++++
>  include/uapi/linux/perf_event.h |   7 +-
>  kernel/events/core.c            | 159 +++++++++++++++++++++++++++++++-
>  kernel/events/internal.h        |   1 +
>  kernel/events/ring_buffer.c     |  36 ++++++++
>  5 files changed, 220 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 587ae4d002f5..24c5093f1229 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -249,6 +249,8 @@ struct perf_event;
>  #define PERF_PMU_CAP_NO_EXCLUDE			0x80
>  #define PERF_PMU_CAP_AUX_OUTPUT			0x100
>  
> +struct perf_output_handle;
> +
>  /**
>   * struct pmu - generic performance monitoring unit
>   */
> @@ -423,6 +425,19 @@ struct pmu {
>  	 */
>  	void (*free_aux)		(void *aux); /* optional */
>  
> +	/*
> +	 * Take a snapshot of the AUX buffer without touching the event
> +	 * state, so that preempting ->start()/->stop() callbacks does
> +	 * not interfere with their logic. Called in PMI context.
> +	 *
> +	 * Returns the size of AUX data copied to the output handle.
> +	 *
> +	 * Optional.
> +	 */
> +	long (*snapshot_aux)		(struct perf_event *event,
> +					 struct perf_output_handle *handle,
> +					 unsigned long size);
> +
>  	/*
>  	 * Validate address range filters: make sure the HW supports the
>  	 * requested configuration and number of filters; return 0 if the
> @@ -964,6 +979,7 @@ struct perf_sample_data {
>  		u32	reserved;
>  	}				cpu_entry;
>  	struct perf_callchain_entry	*callchain;
> +	u64				aux_size;
>  
>  	/*
>  	 * regs_user may point to task_pt_regs or to regs_user_copy, depending
> @@ -996,6 +1012,7 @@ static inline void perf_sample_data_init(struct perf_sample_data *data,
>  	data->weight = 0;
>  	data->data_src.val = PERF_MEM_NA;
>  	data->txn = 0;
> +	data->aux_size = 0;
>  }
>  
>  extern void perf_output_sample(struct perf_output_handle *handle,
> @@ -1353,6 +1370,9 @@ extern unsigned int perf_output_copy(struct perf_output_handle *handle,
>  			     const void *buf, unsigned int len);
>  extern unsigned int perf_output_skip(struct perf_output_handle *handle,
>  				     unsigned int len);
> +extern long perf_output_copy_aux(struct perf_output_handle *aux_handle,
> +				 struct perf_output_handle *handle,
> +				 unsigned long from, unsigned long to);
>  extern int perf_swevent_get_recursion_context(void);
>  extern void perf_swevent_put_recursion_context(int rctx);
>  extern u64 perf_swevent_set_period(struct perf_event *event);
> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> index bb7b271397a6..84dbd1499a24 100644
> --- a/include/uapi/linux/perf_event.h
> +++ b/include/uapi/linux/perf_event.h
> @@ -141,8 +141,9 @@ enum perf_event_sample_format {
>  	PERF_SAMPLE_TRANSACTION			= 1U << 17,
>  	PERF_SAMPLE_REGS_INTR			= 1U << 18,
>  	PERF_SAMPLE_PHYS_ADDR			= 1U << 19,
> +	PERF_SAMPLE_AUX				= 1U << 20,
>  
> -	PERF_SAMPLE_MAX = 1U << 20,		/* non-ABI */
> +	PERF_SAMPLE_MAX = 1U << 21,		/* non-ABI */
>  
>  	__PERF_SAMPLE_CALLCHAIN_EARLY		= 1ULL << 63, /* non-ABI; internal use */
>  };
> @@ -424,7 +425,7 @@ struct perf_event_attr {
>  	 */
>  	__u32	aux_watermark;
>  	__u16	sample_max_stack;
> -	__u16	__reserved_2;	/* align to __u64 */
> +	__u16	aux_sample_size;
>  };
>  
>  /*
> @@ -864,6 +865,8 @@ enum perf_event_type {
>  	 *	{ u64			abi; # enum perf_sample_regs_abi
>  	 *	  u64			regs[weight(mask)]; } && PERF_SAMPLE_REGS_INTR
>  	 *	{ u64			phys_addr;} && PERF_SAMPLE_PHYS_ADDR
> +	 *	{ u64			size;
> +	 *	  char			data[size]; } && PERF_SAMPLE_AUX
>  	 * };
>  	 */
>  	PERF_RECORD_SAMPLE			= 9,
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 77793ef0d8bc..5e2c7a715434 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -1953,7 +1953,10 @@ static int perf_get_aux_event(struct perf_event *event,
>  	if (!group_leader)
>  		return 0;
>  
> -	if (!perf_aux_output_match(event, group_leader))
> +	if (event->attr.aux_output && !perf_aux_output_match(event, group_leader))
> +		return 0;
> +
> +	if (event->attr.aux_sample_size && !group_leader->pmu->snapshot_aux)
>  		return 0;
>  
>  	if (!atomic_long_inc_not_zero(&group_leader->refcount))
> @@ -6192,6 +6195,121 @@ perf_output_sample_ustack(struct perf_output_handle *handle, u64 dump_size,
>  	}
>  }
>  
> +static unsigned long perf_aux_sample_size(struct perf_event *event,
> +					  struct perf_sample_data *data,
> +					  size_t size)
> +{
> +	struct perf_event *sampler = event->aux_event;
> +	struct ring_buffer *rb;
> +
> +	data->aux_size = 0;
> +
> +	if (!sampler)
> +		goto out;
> +
> +	if (WARN_ON_ONCE(READ_ONCE(sampler->state) != PERF_EVENT_STATE_ACTIVE))
> +		goto out;
> +
> +	if (WARN_ON_ONCE(READ_ONCE(sampler->oncpu) != smp_processor_id()))
> +		goto out;
> +
> +	rb = ring_buffer_get(sampler->parent ? sampler->parent : sampler);
> +	if (!rb)
> +		goto out;
> +
> +	/*
> +	 * If this is an NMI hit inside sampling code, don't take
> +	 * the sample. See also perf_aux_sample_output().
> +	 */
> +	if (READ_ONCE(rb->aux_in_sampling)) {
> +		data->aux_size = 0;
> +	} else {
> +		size = min_t(size_t, size, perf_aux_size(rb));
> +		data->aux_size = ALIGN(size, sizeof(u64));
> +	}
> +	ring_buffer_put(rb);
> +
> +out:
> +	return data->aux_size;
> +}
> +
> +long perf_pmu_aux_sample_output(struct perf_event *event,
> +				struct perf_output_handle *handle,
> +				unsigned long size)
> +{
> +	unsigned long flags;
> +	long ret;
> +
> +	/*
> +	 * Normal ->start()/->stop() callbacks run in IRQ mode in scheduler
> +	 * paths. If we start calling them in NMI context, they may race with
> +	 * the IRQ ones, that is, for example, re-starting an event that's just
> +	 * been stopped, which is why we're using a separate callback that
> +	 * doesn't change the event state.
> +	 *
> +	 * IRQs need to be disabled to prevent IPIs from racing with us.
> +	 */
> +	local_irq_save(flags);
> +
> +	ret = event->pmu->snapshot_aux(event, handle, size);
> +
> +	local_irq_restore(flags);
> +
> +	return ret;
> +}
> +
> +static void perf_aux_sample_output(struct perf_event *event,
> +				   struct perf_output_handle *handle,
> +				   struct perf_sample_data *data)
> +{
> +	struct perf_event *sampler = event->aux_event;
> +	unsigned long pad;
> +	struct ring_buffer *rb;
> +	long size;
> +
> +	if (WARN_ON_ONCE(!sampler || !data->aux_size))
> +		return;
> +
> +	rb = ring_buffer_get(sampler->parent ? sampler->parent : sampler);
> +	if (!rb)
> +		return;
> +
> +	/*
> +	 * Guard against NMI hits inside the critical section;
> +	 * see also perf_aux_sample_size().
> +	 */
> +	WRITE_ONCE(rb->aux_in_sampling, 1);
> +
> +	size = perf_pmu_aux_sample_output(sampler, handle, data->aux_size);
> +
> +	/*
> +	 * An error here means that perf_output_copy() failed (returned a
> +	 * non-zero surplus that it didn't copy), which in its current
> +	 * enlightened implementation is not possible. If that changes, we'd
> +	 * like to know.
> +	 */
> +	if (WARN_ON_ONCE(size < 0))
> +		goto out_clear;
> +
> +	/*
> +	 * The pad comes from ALIGN()ing data->aux_size up to u64 in
> +	 * perf_aux_sample_size(), so should not be more than that.
> +	 */
> +	pad = data->aux_size - size;
> +	if (WARN_ON_ONCE(pad >= sizeof(u64)))
> +		pad = 8;
> +
> +	if (pad) {
> +		u64 zero = 0;
> +		perf_output_copy(handle, &zero, pad);
> +	}
> +
> +out_clear:
> +	WRITE_ONCE(rb->aux_in_sampling, 0);
> +
> +	ring_buffer_put(rb);
> +}
> +
>  static void __perf_event_header__init_id(struct perf_event_header *header,
>  					 struct perf_sample_data *data,
>  					 struct perf_event *event)
> @@ -6511,6 +6629,13 @@ void perf_output_sample(struct perf_output_handle *handle,
>  	if (sample_type & PERF_SAMPLE_PHYS_ADDR)
>  		perf_output_put(handle, data->phys_addr);
>  
> +	if (sample_type & PERF_SAMPLE_AUX) {
> +		perf_output_put(handle, data->aux_size);
> +
> +		if (data->aux_size)
> +			perf_aux_sample_output(event, handle, data);
> +	}
> +
>  	if (!event->attr.watermark) {
>  		int wakeup_events = event->attr.wakeup_events;
>  
> @@ -6699,6 +6824,35 @@ void perf_prepare_sample(struct perf_event_header *header,
>  
>  	if (sample_type & PERF_SAMPLE_PHYS_ADDR)
>  		data->phys_addr = perf_virt_to_phys(data->addr);
> +
> +	if (sample_type & PERF_SAMPLE_AUX) {
> +		u64 size;
> +
> +		header->size += sizeof(u64); /* size */
> +
> +		/*
> +		 * Given the 16bit nature of header::size, an AUX sample can
> +		 * easily overflow it, what with all the preceding sample bits.
> +		 * Make sure this doesn't happen by using up to U16_MAX bytes
> +		 * per sample in total (rounded down to 8 byte boundary).
> +		 */
> +		size = min_t(size_t, U16_MAX - header->size,
> +			     event->attr.aux_sample_size);
> +		size = rounddown(size, 8);
> +		size = perf_aux_sample_size(event, data, size);
> +
> +		WARN_ON_ONCE(size + header->size > U16_MAX);
> +		header->size += size;
> +	}
> +	/*
> +	 * If you're adding more sample types here, you likely need to do
> +	 * something about the overflowing header::size, like repurpose the
> +	 * lowest 3 bits of size, which should be always zero at the moment.
> +	 * This raises a more important question, do we really need 512k sized
> +	 * samples and why, so good argumentation is in order for whatever you
> +	 * do here next.
> +	 */
> +	WARN_ON_ONCE(header->size & 7);
>  }
>  
>  static __always_inline int
> @@ -11213,6 +11367,9 @@ SYSCALL_DEFINE5(perf_event_open,
>  	if (event->attr.aux_output && !perf_get_aux_event(event, group_leader))
>  		goto err_locked;
>  
> +	if (event->attr.aux_sample_size && !perf_get_aux_event(event, group_leader))
> +		goto err_locked;
> +
>  	/*
>  	 * Must be under the same ctx::mutex as perf_install_in_context(),
>  	 * because we need to serialize with concurrent event creation.
> diff --git a/kernel/events/internal.h b/kernel/events/internal.h
> index 3aef4191798c..747d67f130cb 100644
> --- a/kernel/events/internal.h
> +++ b/kernel/events/internal.h
> @@ -50,6 +50,7 @@ struct ring_buffer {
>  	unsigned long			aux_mmap_locked;
>  	void				(*free_aux)(void *);
>  	refcount_t			aux_refcount;
> +	int				aux_in_sampling;
>  	void				**aux_pages;
>  	void				*aux_priv;
>  
> diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
> index 246c83ac5643..7ffd5c763f93 100644
> --- a/kernel/events/ring_buffer.c
> +++ b/kernel/events/ring_buffer.c
> @@ -562,6 +562,42 @@ void *perf_get_aux(struct perf_output_handle *handle)
>  }
>  EXPORT_SYMBOL_GPL(perf_get_aux);
>  
> +/*
> + * Copy out AUX data from an AUX handle.
> + */
> +long perf_output_copy_aux(struct perf_output_handle *aux_handle,
> +			  struct perf_output_handle *handle,
> +			  unsigned long from, unsigned long to)
> +{
> +	unsigned long tocopy, remainder, len = 0;
> +	struct ring_buffer *rb = aux_handle->rb;
> +	void *addr;
> +
> +	from &= (rb->aux_nr_pages << PAGE_SHIFT) - 1;
> +	to &= (rb->aux_nr_pages << PAGE_SHIFT) - 1;
> +
> +	do {
> +		tocopy = PAGE_SIZE - offset_in_page(from);
> +		if (to > from)
> +			tocopy = min(tocopy, to - from);
> +		if (!tocopy)
> +			break;
> +
> +		addr = rb->aux_pages[from >> PAGE_SHIFT];
> +		addr += offset_in_page(from);
> +
> +		remainder = perf_output_copy(handle, addr, tocopy);
> +		if (remainder)
> +			return -EFAULT;
> +
> +		len += tocopy;
> +		from += tocopy;
> +		from &= (rb->aux_nr_pages << PAGE_SHIFT) - 1;
> +	} while (to != from);
> +
> +	return len;
> +}
> +
>  #define PERF_AUX_GFP	(GFP_KERNEL | __GFP_ZERO | __GFP_NOWARN | __GFP_NORETRY)
>  
>  static struct page *rb_alloc_aux_page(int node, int order)
> -- 
> 2.23.0
> 
