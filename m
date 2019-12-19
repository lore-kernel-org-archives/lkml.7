Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE187C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 13:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9633E218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 13:09:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YIw8i826"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbfLSNJ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 08:09:28 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:58844 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbfLSNJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 08:09:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZqEQHdL69+nxWb4IBWBcXrWuCHzYrSvVGFIPzfqiGIs=; b=YIw8i826MelimQz3YS9ASK34P
        zFpUYENsO/e/685y7xkaPKknwBIlgwCxDeuLgNVz75l+9LLYexCZ4YEibtqivBfXuV1CR9I4QD4td
        k9ItzalibvTdLqheM1VPYU89NK/jc4gYwv4Ke7lSFjrC+Qaz5tTApBjFgCVMCtKeDhLMzZ0n7kNyn
        U2QWHcQACc4Yc4p0+sAH6cJg5KaYoAzrHwErcXntOy9evrLwT9pFcTBTJ3eHsYzmuts9O/h9gqJqu
        vp0GakyzosenMUdgBAqcqkZD0tbbNj2ZfrJb78ZEvtTw9U2Gyt6Xb5Hpeam1tAZt4a/LlYA1ReIxf
        VbSIls2ew==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ihvYK-0007C2-TU; Thu, 19 Dec 2019 13:09:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2289F3033F1;
        Thu, 19 Dec 2019 14:07:51 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A27B12B3DB890; Thu, 19 Dec 2019 14:09:14 +0100 (CET)
Date:   Thu, 19 Dec 2019 14:09:14 +0100
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
Subject: Re: [PATCH 1/3] perf/x86: Add perf text poke event
Message-ID: <20191219130914.GJ2827@hirez.programming.kicks-ass.net>
References: <20191218142618.19332-1-adrian.hunter@intel.com>
 <20191218142618.19332-2-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191218142618.19332-2-adrian.hunter@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2019 at 04:26:16PM +0200, Adrian Hunter wrote:
> Record changes to kernel text (i.e. self-modifying code) in order to
> support tracers like Intel PT decoding through jump labels.

I don't get the obsession with just jump-labels, we need a solution all
modifying code. The fentry site usage is increasing, and optprobes are
also fairly popular with a bunch of people.

> A copy of the running kernel code is needed as a reference point
> (e.g. from /proc/kcore). The text poke event records the old bytes
> and the new bytes so that the event can be processed forwards or backwards.
> 
> In the case of Intel PT tracing, the executable code must be walked to
> reconstruct the control flow. For x86 a jump label text poke begins:
>   - write INT3 byte
>   - IPI-SYNC
>   - write instruction tail
> At this point the actual control flow will be through the INT3 and handler
> and not hit the old or new instruction. Intel PT outputs FUP/TIP packets
> for the INT3, so the flow can still be decoded. Subsequently:
>   - emit RECORD_TEXT_POKE with the new instruction
>   - IPI-SYNC
>   - write first byte
>   - IPI-SYNC
> So before the text poke event timestamp, the decoder will see either the
> old instruction flow or FUP/TIP of INT3. After the text poke event
> timestamp, the decoder will see either the new instruction flow or FUP/TIP
> of INT3. Thus decoders can use the timestamp as the point at which to
> modify the executable code.

I feel a much better justification for the design can be found in the
discussion we've had around ARM-CS.

Basically SMP instruction coherency mandates something like this, it is
just a happy accident x86 already had all the bits in place.

How is something like:

"Record (single instruction) changes to the kernel text (i.e.
self-modifying code) in order to support tracers like Intel PT and
ARM CoreSight.

A copy of the running kernel code is needed as a reference point (e.g.
from /proc/kcore). The text poke event records the old bytes and the
new bytes so that the event can be processed forwards or backwards.

The basic problem is recording the modified instruction in an
unambiguous manner given SMP instruction cache (in)coherence. That is,
when modifying an instruction concurrently any solution with one or
multiple timestamps is not sufficient:

	CPU0				CPU1
 0
 1	write insn A
 2					execute insn A
 3	sync-I$
 4

Due to I$, CPU1 might execute either the old or new A. No matter where
we record tracepoints on CPU0, one simply cannot tell what CPU1 will
have observed, except that at 0 it must be the old one and at 4 it
must be the new one.

To solve this, take inspiration from x86 text poking, which has to
solve this exact problem due to variable length instruction encoding
and I-fetch windows.

 1) overwrite the instruction with a breakpoint and sync I$

This guarantees that that code flow will never hit the target
instruction anymore, on any CPU (or rather, it will cause an
exception).

 2) issue the TEXT_POKE event

 3) overwrite the breakpoint with the new instruction and sync I$

Now we know that any execution after the TEXT_POKE event will either
observe the breakpoint (and hit the exception) or the new instruction.

So by guarding the TEXT_POKE event with an exception on either side;
we can now tell, without doubt, which instruction another CPU will
have observed."

?

> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  arch/x86/kernel/alternative.c   | 37 +++++++++++++-

I'm thinking it might make sense to do this x86 part in a separate
patch, and just present the generic thing first:

>  include/linux/perf_event.h      |  6 +++
>  include/uapi/linux/perf_event.h | 19 ++++++-
>  kernel/events/core.c            | 87 ++++++++++++++++++++++++++++++++-
>  4 files changed, 146 insertions(+), 3 deletions(-)
> 

> @@ -1006,6 +1007,22 @@ enum perf_event_type {
>  	 */
>  	PERF_RECORD_BPF_EVENT			= 18,
>  
> +	/*
> +	 * Records changes to kernel text i.e. self-modified code.
> +	 * 'len' is the number of old bytes, which is the same as the number
> +	 * of new bytes. 'bytes' contains the old bytes followed immediately
> +	 * by the new bytes.
> +	 *
> +	 * struct {
> +	 *	struct perf_event_header	header;
> +	 *	u64				addr;
> +	 *	u16				len;
> +	 *	u8				bytes[];

Would it make sense to have something like:

	 *	u16				old_len;
	 *	u16				new_len;
	 *	u8				old_bytes[old_len];
	 *	u8				new_bytes[new_len];

That would allow using this for (short) trampolines (ftrace, optprobes
etc..). {old_len=0, new_len>0} would indicate a new trampoline, while
{old_len>0, new_len=0} would indicate the dissapearance of a trampoline.

> +	 *	struct sample_id		sample_id;
> +	 * };
> +	 */
> +	PERF_RECORD_TEXT_POKE			= 19,
> +
>  	PERF_RECORD_MAX,			/* non-ABI */
>  };

Then the x86 patch, hooking up the event, can also cover kprobes and
stuff.

