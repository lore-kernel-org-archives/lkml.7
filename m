Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9597CA9EA0
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 10:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1C3421D7D
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 10:40:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hkJj6eZ+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728404AbfKDKkf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 05:40:35 -0500
Received: from merlin.infradead.org ([205.233.59.134]:55110 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbfKDKkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 05:40:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ojEYhk+TWpoTtlJiCYXcbZ+ElzNcn50Ygh15OiWS//w=; b=hkJj6eZ+Mi7QPR/uGGFaPHxMg
        m1SsWiEfVo1mf2ZUFP/Tg1/1FjMEd9uNSoBczjWDsVCkIEPJ7SFVZ1AmGm0vrucTBl2XqqVgjJKil
        GqunGHwcokInexPC9zOuOh2h8a39aot40x5pkD0urSZv1Knrq0OHL0mcRtAi5xRUzM5QJ1K9Gyx68
        Wkmt35fWdj/QZcnKpxLYFOo3SSRwaDGQ7g5yH3xdCA2R5GZZwQgkIwCx+o/YGycvNwMKC7/f5cGZc
        wpq3ix4Yx2pKKyfggL0mXM93PNrjxuQysFOcFiPeRlr0VYsF6mZ3zp5pLU8KRpBFqsMy9BwlOf6qz
        4R999br+Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iRZmP-0002mC-6p; Mon, 04 Nov 2019 10:40:13 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 80D8C305FC2;
        Mon,  4 Nov 2019 11:39:06 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B1CD12B4220F7; Mon,  4 Nov 2019 11:40:09 +0100 (CET)
Date:   Mon, 4 Nov 2019 11:40:09 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 1/6] perf/x86: Add perf text poke event
Message-ID: <20191104104009.GF4131@hirez.programming.kicks-ass.net>
References: <20191025130000.13032-1-adrian.hunter@intel.com>
 <20191025130000.13032-2-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191025130000.13032-2-adrian.hunter@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
> 
> In the case of Intel PT tracing, the executable code must be walked to
> reconstruct the control flow. For x86 a jump label text poke begins:
>   - write INT3 byte
>   - IPI-SYNC
> At this point the actual control flow will be through the INT3 and handler
> and not hit the old or new instruction. Intel PT outputs FUP/TIP packets
> for the INT3, so the flow can still be decoded. Subsequently:
>   - emit RECORD_TEXT_POKE with the new instruction
>   - write instruction tail
>   - IPI-SYNC
>   - write first byte
>   - IPI-SYNC
> So before the text poke event timestamp, the decoder will see either the
> old instruction flow or FUP/TIP of INT3. After the text poke event
> timestamp, the decoder will see either the new instruction flow or FUP/TIP
> of INT3. Thus decoders can use the timestamp as the point at which to
> modify the executable code.
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

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

What's the purpose of the 'flags' field? We currently only have the 1
flag defined, but what possible other flags are you thinking of?

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

Maybe use: 'len * 2', compiler should be smart enough.

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

Also, I'm thinking this patch has a problem with
arch_unoptimize_kprobe() as it stands today.

I've got a patch pending for that:

  https://lkml.kernel.org/r/20191018074634.629386219@infradead.org

That rewrites that a little, but it will be slightly differently broken
after that.

The problem is that while we can (and do) ignore regular kprobes (they
use text_poke() which isn't instrumented, and they don't need to be,
because they're always going through INT3), we cannot ignore optprobes.

Installing the optprobe works as expected, but unoptimizing is difficult
and as it stands your patch will not report the old text (you'll see
that first byte overwriten with 0xCC) and after my patch you'll not see
it at all.

Now, I suppose we can stick an explicit perf_event_text_poke() in there
after my patch.

We have to delay this patch until after my x86/ftrace rewrite anyway,
because otherwise ftrace is hidden too.

And even then, this will then notify us of all text modifications, but
what about all the extra text, like ftrace trampolines, k(ret)probe
trampolines, optprobe slots, bpf-jit, etc.?

