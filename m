Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B8ACA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 10:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA12A20663
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 10:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AAeuIf24"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbfJ3KsB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 06:48:01 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:34575 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbfJ3KsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 06:48:01 -0400
Received: by mail-yw1-f68.google.com with SMTP id d192so682420ywa.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 03:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=c2SnndOBw8E3H10SMHwgWWeJKENZfkxJu0k+bJmqZcs=;
        b=AAeuIf24cscbakXFeZmlV1HRwFP5fNrX6yET61G0oMxAuVjIJdXe5tQQrquTZiKBWW
         vCYhMB9Pqnaj/J33M4cY8muQoZh5kuympsTaxN4WA5y25Iq2+rAKAA9YWhcoO1NyyquQ
         U7kNek2cKLByX0mwH/f40jGxE/QBTeKutItpOI2v3VX/8K2XY/yDYqziZkiHUgPGrQfy
         TrO44G+e+GdA3AnQRgnvgSe6rXcAHBLg4fndE/pBV6bwf+u9BmAfBB9/bFHKJ5qvtSau
         93EP2jgeuky0OWXvhXlbXXcTnxEA0N3MxTFCWieEbE9z4GTACHzt8bGsW2oRDkngS12n
         2Sww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=c2SnndOBw8E3H10SMHwgWWeJKENZfkxJu0k+bJmqZcs=;
        b=c5SYWqAvGzbkx3YajyNRygzIbZCa4LVoq93ZEig94Zsgcw7431vgth9wn3Mi30lkNl
         ZInK/pEyABpM6gKQCA7inFOApoK+3CzcUNYrYJ/a2MtCPu+h1tlol3f+8wrGuO1DDaWG
         g7kfMZy+lBhybF2Hfa7mgNZZOc4sKYVgddl3VfkphvwAyq136bgzoSLBq6J/rPQi16eP
         8NSA3l1UZow5vROIMob0TRr6xsXBkq9O5dq5TeOyPr33d/7Ykv89G/topzQQrQZjEPT4
         X5CxJrwc0aJuC1gf3gNDD0QNCKK3dTiXPYMBp+3kmYblQsZ7ok6KzMSI3EvsTAcDM9rT
         +pgQ==
X-Gm-Message-State: APjAAAV1SLUJY9xmtiqjrs5wmABrelQasI6dJUtDmGSLXxKwidUJlNKC
        A0FsqsmVOv48LS8FO+ICA17Org==
X-Google-Smtp-Source: APXvYqynubIkcUXj+cu0UmTtluqvA9cyyMRLzVBEAQUVwfs1c+CIFmEsSYLfj8E/BGTNKyhJ3elBZA==
X-Received: by 2002:a0d:ca12:: with SMTP id m18mr16187422ywd.97.1572432478525;
        Wed, 30 Oct 2019 03:47:58 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (li72-186.members.linode.com. [74.207.230.186])
        by smtp.gmail.com with ESMTPSA id d4sm833786ywl.0.2019.10.30.03.47.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Oct 2019 03:47:57 -0700 (PDT)
Date:   Wed, 30 Oct 2019 18:47:47 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 1/6] perf/x86: Add perf text poke event
Message-ID: <20191030104747.GA21153@leoy-ThinkPad-X240s>
References: <20191025130000.13032-1-adrian.hunter@intel.com>
 <20191025130000.13032-2-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191025130000.13032-2-adrian.hunter@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On Fri, Oct 25, 2019 at 03:59:55PM +0300, Adrian Hunter wrote:
> Record changes to kernel text (i.e. self-modifying code) in order to
> support tracers like Intel PT decoding through jump labels.
> 
> A copy of the running kernel code is needed as a reference point
> (e.g. from /proc/kcore). The text poke event records the old bytes
> and the new bytes so that the event can be processed forwards or backwards.
> 
> The text poke event has 'flags' to describe when the event is sent. At
> present the only flag is PERF_TEXT_POKE_UPDATE which indicates the
> point at which tools should update their reference kernel executable to
> change the old bytes to the new bytes.
> 
> Other architectures may wish to emit a pair of text poke events. One before
> and one after a text poke. In that case, PERF_TEXT_POKE_UPDATE flag would
> be set on only one of the pair.

Thanks a lot for the patch set.

Below is my understanding for implementation 'emit a pair of text poke
events' as you mentioned:

Since Arm64 instruction is fixed size, it doesn't need to rely on INT3
liked mechanism to replace instructions and directly uses two operations
to alter instruction (modify instruction and flush icache line).  So
Arm64 has no chance to send perf event in the middle of altering
instruction.

Thus we can send pair of text poke events in the kernel:

  perf_event_text_poke(PERF_TEXT_POKE_UPDATE_PREV)

    Change instruction
    Flush icache

  perf_event_text_poke(PERF_TEXT_POKE_UPDATE_POST)

In the userspace, if perf tool detects the instruction is changed
from nop to branch, we need to update dso cache for the
'PERF_TEXT_POKE_UPDATE_PREV' event; if detect the instruction is
changed from branch to nop, we need to update dso cache for
'PERF_TEXT_POKE_UPDATE_POST' event.  The main idea is to ensure the
branch instructions can be safely contained in the dso file and any
branch samples can read out correct branch instruction.

Could you confirm this is the same with your understanding?  Or I miss
anything?  I personally even think the pair events can be used for
different arches (e.g. the solution can be reused on Arm64/x86, etc).

> In the case of Intel PT tracing, the executable code must be walked to
> reconstruct the control flow. For x86 a jump label text poke begins:
>   - write INT3 byte
>   - IPI-SYNC
> At this point the actual control flow will be through the INT3 and handler
> and not hit the old or new instruction. Intel PT outputs FUP/TIP packets
> for the INT3, so the flow can still be decoded. Subsequently:
>   - emit RECORD_TEXT_POKE with the new instruction

s/RECORD_TEXT_POKE/PERF_TEXT_POKE_UPDATE

And I think emit the perf event is after the item 'write instruction
tail' but not before it.  So the commit log is not consistent with
the change in the patch.

>   - write instruction tail
>   - IPI-SYNC
>   - write first byte
>   - IPI-SYNC
> So before the text poke event timestamp, the decoder will see either the
> old instruction flow or FUP/TIP of INT3. After the text poke event
> timestamp, the decoder will see either the new instruction flow or FUP/TIP

I will check internally for timestamp on Arm/Arm64 ...

Thanks,
Leo Yan

> of INT3. Thus decoders can use the timestamp as the point at which to
> modify the executable code.
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  arch/x86/include/asm/text-patching.h |  1 +
>  arch/x86/kernel/alternative.c        | 39 +++++++++++-
>  include/linux/perf_event.h           |  6 ++
>  include/uapi/linux/perf_event.h      | 28 ++++++++-
>  kernel/events/core.c                 | 90 +++++++++++++++++++++++++++-
>  5 files changed, 161 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/include/asm/text-patching.h b/arch/x86/include/asm/text-patching.h
> index 5e8319bb207a..873141765d8e 100644
> --- a/arch/x86/include/asm/text-patching.h
> +++ b/arch/x86/include/asm/text-patching.h
> @@ -30,6 +30,7 @@ struct text_poke_loc {
>  	void *addr;
>  	size_t len;
>  	const char opcode[POKE_MAX_OPCODE_SIZE];
> +	u8 old;
>  };
>  
>  extern void text_poke_early(void *addr, const void *opcode, size_t len);
> diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
> index 9d3a971ea364..9488f0fa7e22 100644
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -3,6 +3,7 @@
>  
>  #include <linux/module.h>
>  #include <linux/sched.h>
> +#include <linux/perf_event.h>
>  #include <linux/mutex.h>
>  #include <linux/list.h>
>  #include <linux/stringify.h>
> @@ -1045,8 +1046,10 @@ void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries)
>  	/*
>  	 * First step: add a int3 trap to the address that will be patched.
>  	 */
> -	for (i = 0; i < nr_entries; i++)
> +	for (i = 0; i < nr_entries; i++) {
> +		tp[i].old = *(u8 *)tp[i].addr;
>  		text_poke(tp[i].addr, &int3, sizeof(int3));
> +	}
>  
>  	on_each_cpu(do_sync_core, NULL, 1);
>  
> @@ -1054,12 +1057,46 @@ void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries)
>  	 * Second step: update all but the first byte of the patched range.
>  	 */
>  	for (i = 0; i < nr_entries; i++) {
> +		u8 old[POKE_MAX_OPCODE_SIZE] = { tp[i].old, };
> +
> +		memcpy(old + sizeof(int3),
> +		       tp[i].addr + sizeof(int3),
> +		       tp[i].len - sizeof(int3));
> +
>  		if (tp[i].len - sizeof(int3) > 0) {
>  			text_poke((char *)tp[i].addr + sizeof(int3),
>  				  (const char *)tp[i].opcode + sizeof(int3),
>  				  tp[i].len - sizeof(int3));
>  			patched_all_but_first++;
>  		}
> +
> +		/*
> +		 * Emit a perf event to record the text poke, primarily to
> +		 * support Intel PT decoding which must walk the executable code
> +		 * to reconstruct the trace. The flow up to here is:
> +		 *   - write INT3 byte
> +		 *   - IPI-SYNC
> +		 * At this point the actual control flow will be through the
> +		 * INT3 and handler and not hit the old or new instruction.
> +		 * Intel PT outputs FUP/TIP packets for the INT3, so the flow
> +		 * can still be decoded. Subsequently:
> +		 *   - emit RECORD_TEXT_POKE with the new instruction
> +		 *   - write instruction tail
> +		 *   - IPI-SYNC
> +		 *   - write first byte
> +		 *   - IPI-SYNC
> +		 * So before the text poke event timestamp, the decoder will see
> +		 * either the old instruction flow or FUP/TIP of INT3. After the
> +		 * text poke event timestamp, the decoder will see either the
> +		 * new instruction flow or FUP/TIP of INT3. Thus decoders can
> +		 * use the timestamp as the point at which to modify the
> +		 * executable code.
> +		 * The old instruction is recorded so that the event can be
> +		 * processed forwards or backwards.
> +		 */
> +		perf_event_text_poke((unsigned long)tp[i].addr,
> +				     PERF_TEXT_POKE_UPDATE, old, tp[i].opcode,
> +				     tp[i].len);
>  	}
>  
>  	if (patched_all_but_first) {
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 61448c19a132..db88b7ade8c6 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -1183,6 +1183,8 @@ extern void perf_event_exec(void);
>  extern void perf_event_comm(struct task_struct *tsk, bool exec);
>  extern void perf_event_namespaces(struct task_struct *tsk);
>  extern void perf_event_fork(struct task_struct *tsk);
> +extern void perf_event_text_poke(unsigned long addr, u16 flags, const void *old_bytes,
> +				 const void *new_bytes, size_t len);
>  
>  /* Callchains */
>  DECLARE_PER_CPU(struct perf_callchain_entry, perf_callchain_entry);
> @@ -1406,6 +1408,10 @@ static inline void perf_event_exec(void)				{ }
>  static inline void perf_event_comm(struct task_struct *tsk, bool exec)	{ }
>  static inline void perf_event_namespaces(struct task_struct *tsk)	{ }
>  static inline void perf_event_fork(struct task_struct *tsk)		{ }
> +static inline void perf_event_text_poke(unsigned long addr, u16 flags,
> +					const void *old_bytes,
> +					const void *new_bytes,
> +					size_t len)			{ }
>  static inline void perf_event_init(void)				{ }
>  static inline int  perf_swevent_get_recursion_context(void)		{ return -1; }
>  static inline void perf_swevent_put_recursion_context(int rctx)		{ }
> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> index bb7b271397a6..c8d1f52a7fce 100644
> --- a/include/uapi/linux/perf_event.h
> +++ b/include/uapi/linux/perf_event.h
> @@ -375,7 +375,8 @@ struct perf_event_attr {
>  				ksymbol        :  1, /* include ksymbol events */
>  				bpf_event      :  1, /* include bpf events */
>  				aux_output     :  1, /* generate AUX records instead of events */
> -				__reserved_1   : 32;
> +				text_poke      :  1, /* include text poke events */
> +				__reserved_1   : 31;
>  
>  	union {
>  		__u32		wakeup_events;	  /* wakeup every n events */
> @@ -1000,6 +1001,26 @@ enum perf_event_type {
>  	 */
>  	PERF_RECORD_BPF_EVENT			= 18,
>  
> +	/*
> +	 * Records changes to kernel text i.e. self-modified code.
> +	 * 'flags' has PERF_TEXT_POKE_UPDATE (i.e. bit 0) set to
> +	 * indicate to tools to update old bytes to new bytes in the
> +	 * executable image.
> +	 * 'len' is the number of old bytes, which is the same as the number
> +	 * of new bytes. 'bytes' contains the old bytes followed immediately
> +	 * by the new bytes.
> +	 *
> +	 * struct {
> +	 *	struct perf_event_header	header;
> +	 *	u64				addr;
> +	 *	u16				flags;
> +	 *	u16				len;
> +	 *	u8				bytes[];
> +	 *	struct sample_id		sample_id;
> +	 * };
> +	 */
> +	PERF_RECORD_TEXT_POKE			= 19,
> +
>  	PERF_RECORD_MAX,			/* non-ABI */
>  };
>  
> @@ -1041,6 +1062,11 @@ enum perf_callchain_context {
>  #define PERF_AUX_FLAG_PARTIAL		0x04	/* record contains gaps */
>  #define PERF_AUX_FLAG_COLLISION		0x08	/* sample collided with another */
>  
> +/**
> + * PERF_RECORD_TEXT_POKE::flags bits
> + */
> +#define PERF_TEXT_POKE_UPDATE		0x01	/* update old bytes to new bytes */
> +
>  #define PERF_FLAG_FD_NO_GROUP		(1UL << 0)
>  #define PERF_FLAG_FD_OUTPUT		(1UL << 1)
>  #define PERF_FLAG_PID_CGROUP		(1UL << 2) /* pid=cgroup id, per-cpu mode only */
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 9ec0b0bfddbd..666e094e8ed9 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -386,6 +386,7 @@ static atomic_t nr_freq_events __read_mostly;
>  static atomic_t nr_switch_events __read_mostly;
>  static atomic_t nr_ksymbol_events __read_mostly;
>  static atomic_t nr_bpf_events __read_mostly;
> +static atomic_t nr_text_poke_events __read_mostly;
>  
>  static LIST_HEAD(pmus);
>  static DEFINE_MUTEX(pmus_lock);
> @@ -4351,7 +4352,7 @@ static bool is_sb_event(struct perf_event *event)
>  	if (attr->mmap || attr->mmap_data || attr->mmap2 ||
>  	    attr->comm || attr->comm_exec ||
>  	    attr->task || attr->ksymbol ||
> -	    attr->context_switch ||
> +	    attr->context_switch || attr->text_poke ||
>  	    attr->bpf_event)
>  		return true;
>  	return false;
> @@ -4425,6 +4426,8 @@ static void unaccount_event(struct perf_event *event)
>  		atomic_dec(&nr_ksymbol_events);
>  	if (event->attr.bpf_event)
>  		atomic_dec(&nr_bpf_events);
> +	if (event->attr.text_poke)
> +		atomic_dec(&nr_text_poke_events);
>  
>  	if (dec) {
>  		if (!atomic_add_unless(&perf_sched_count, -1, 1))
> @@ -8070,6 +8073,89 @@ void perf_event_bpf_event(struct bpf_prog *prog,
>  	perf_iterate_sb(perf_event_bpf_output, &bpf_event, NULL);
>  }
>  
> +struct perf_text_poke_event {
> +	const void		*old_bytes;
> +	const void		*new_bytes;
> +	size_t			pad;
> +	u16			flags;
> +	u16			len;
> +
> +	struct {
> +		struct perf_event_header	header;
> +
> +		u64				addr;
> +	} event_id;
> +};
> +
> +static int perf_event_text_poke_match(struct perf_event *event)
> +{
> +	return event->attr.text_poke;
> +}
> +
> +static void perf_event_text_poke_output(struct perf_event *event, void *data)
> +{
> +	struct perf_text_poke_event *text_poke_event = data;
> +	struct perf_output_handle handle;
> +	struct perf_sample_data sample;
> +	u64 padding = 0;
> +	int ret;
> +
> +	if (!perf_event_text_poke_match(event))
> +		return;
> +
> +	perf_event_header__init_id(&text_poke_event->event_id.header, &sample, event);
> +
> +	ret = perf_output_begin(&handle, event, text_poke_event->event_id.header.size);
> +	if (ret)
> +		return;
> +
> +	perf_output_put(&handle, text_poke_event->event_id);
> +	perf_output_put(&handle, text_poke_event->flags);
> +	perf_output_put(&handle, text_poke_event->len);
> +
> +	__output_copy(&handle, text_poke_event->old_bytes, text_poke_event->len);
> +	__output_copy(&handle, text_poke_event->new_bytes, text_poke_event->len);
> +
> +	if (text_poke_event->pad)
> +		__output_copy(&handle, &padding, text_poke_event->pad);
> +
> +	perf_event__output_id_sample(event, &handle, &sample);
> +
> +	perf_output_end(&handle);
> +}
> +
> +void perf_event_text_poke(unsigned long addr, u16 flags, const void *old_bytes,
> +			  const void *new_bytes, size_t len)
> +{
> +	struct perf_text_poke_event text_poke_event;
> +	size_t tot, pad;
> +
> +	if (!atomic_read(&nr_text_poke_events))
> +		return;
> +
> +	tot  = sizeof(text_poke_event.flags) +
> +	       sizeof(text_poke_event.len) + (len << 1);
> +	pad  = ALIGN(tot, sizeof(u64)) - tot;
> +
> +	text_poke_event = (struct perf_text_poke_event){
> +		.old_bytes    = old_bytes,
> +		.new_bytes    = new_bytes,
> +		.pad          = pad,
> +		.flags        = flags,
> +		.len          = len,
> +		.event_id  = {
> +			.header = {
> +				.type = PERF_RECORD_TEXT_POKE,
> +				.misc = PERF_RECORD_MISC_KERNEL,
> +				.size = sizeof(text_poke_event.event_id) + tot + pad,
> +			},
> +			.addr = addr,
> +		},
> +	};
> +
> +	perf_iterate_sb(perf_event_text_poke_output, &text_poke_event, NULL);
> +}
> +
>  void perf_event_itrace_started(struct perf_event *event)
>  {
>  	event->attach_state |= PERF_ATTACH_ITRACE;
> @@ -10356,6 +10442,8 @@ static void account_event(struct perf_event *event)
>  		atomic_inc(&nr_ksymbol_events);
>  	if (event->attr.bpf_event)
>  		atomic_inc(&nr_bpf_events);
> +	if (event->attr.text_poke)
> +		atomic_inc(&nr_text_poke_events);
>  
>  	if (inc) {
>  		/*
> -- 
> 2.17.1
> 
