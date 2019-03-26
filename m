Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A66D8C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 00:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 729FB2080F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 00:02:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729250AbfCZACk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 20:02:40 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:47126 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726616AbfCZACj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 20:02:39 -0400
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h8ZY0-0001QY-JS; Tue, 26 Mar 2019 01:02:32 +0100
Date:   Tue, 26 Mar 2019 01:02:32 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
cc:     Peter Zijlstra <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>, acme@kernel.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org, jolsa@kernel.org,
        eranian@google.com, alexander.shishkin@linux.intel.com
Subject: Re: [PATCH V3 01/23] perf/x86: Support outputting XMM registers
In-Reply-To: <697d0b76-d08f-5fa4-d49a-c291ab0f57de@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1903260053110.1789@nanos.tec.linutronix.de>
References: <20190322163718.2191-1-kan.liang@linux.intel.com> <20190322163718.2191-2-kan.liang@linux.intel.com> <20190322170841.GJ7905@worktop.programming.kicks-ass.net> <20190322172250.GF24002@tassilo.jf.intel.com> <20190323095610.GB6058@hirez.programming.kicks-ass.net>
 <697d0b76-d08f-5fa4-d49a-c291ab0f57de@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Mar 2019, Liang, Kan wrote:
> On 3/23/2019 5:56 AM, Peter Zijlstra wrote:
> > On Fri, Mar 22, 2019 at 10:22:50AM -0700, Andi Kleen wrote:
> > > > > diff --git a/arch/x86/include/uapi/asm/perf_regs.h
> > > > > b/arch/x86/include/uapi/asm/perf_regs.h
> > > > > index f3329cabce5c..b33995313d17 100644
> > > > > --- a/arch/x86/include/uapi/asm/perf_regs.h
> > > > > +++ b/arch/x86/include/uapi/asm/perf_regs.h
> > > > > @@ -28,7 +28,29 @@ enum perf_event_x86_regs {
> > > > >   	PERF_REG_X86_R14,
> > > > >   	PERF_REG_X86_R15,
> > > > >   -	PERF_REG_X86_32_MAX = PERF_REG_X86_GS + 1,
> > > > > -	PERF_REG_X86_64_MAX = PERF_REG_X86_R15 + 1,
> > > > 
> > > > So this changes UAPI visible symbols... did we think about that?
> > > 
> > > Should be fine. Old programs won't use the new bits,
> > > and it just uses not yet used bits.
> > 
> > Old programs (that used the above symbols) will now fail to compile.
> > Even if they won't use the new bits, that seems like a bad thing.
> > 
> 
> Yes, other programs which use the PERF_REG_GPR_X86_32/64_MAX symbols should be
> broken.
> I think the new name PERF_REG_GPR_X86_32/64_MAX are more accurate. So I will
> keep both names in V4, and add comments for the old names.
> 
> /*
>  * These names are deprecated, please use new names as below to instead.

This is a pointless exercise. You can call them deprecated, but you cannot
remove them by any means. It's a userspace ABI. End of story.

>  *     PERF_REG_GPR_X86_32_MAX
>  *     PERF_REG_GPR_X86_64_MAX

Just keep the ones we have without adding new ones and just add a comment
that these are the limits for the GPRs. 

>  */
> PERF_REG_X86_32_MAX = PERF_REG_X86_GS + 1,
> PERF_REG_X86_64_MAX = PERF_REG_X86_R15 + 1,
> 
> 
> > > > > +	/* These all need two bits set because they are 128bit */
> > > > > +	PERF_REG_X86_XMM0  = 32,
> > > > > +	PERF_REG_X86_XMM1  = 34,
> > > > > +	PERF_REG_X86_XMM2  = 36,
> > > > > +	PERF_REG_X86_XMM3  = 38,
> > > > > +	PERF_REG_X86_XMM4  = 40,
> > > > > +	PERF_REG_X86_XMM5  = 42,
> > > > > +	PERF_REG_X86_XMM6  = 44,
> > > > > +	PERF_REG_X86_XMM7  = 46,
> > > > > +	PERF_REG_X86_XMM8  = 48,
> > > > > +	PERF_REG_X86_XMM9  = 50,
> > > > > +	PERF_REG_X86_XMM10 = 52,
> > > > > +	PERF_REG_X86_XMM11 = 54,
> > > > > +	PERF_REG_X86_XMM12 = 56,
> > > > > +	PERF_REG_X86_XMM13 = 58,
> > > > > +	PERF_REG_X86_XMM14 = 60,
> > > > > +	PERF_REG_X86_XMM15 = 62,
> > > > > +
> > > > > +	/* This does not include the XMMX registers */
> > > > > +	PERF_REG_GPR_X86_32_MAX = PERF_REG_X86_GS + 1,
> > > > > +	PERF_REG_GPR_X86_64_MAX = PERF_REG_X86_R15 + 1,
> > > > > +
> > > > > +	/* All registers include the XMMX registers */
> > > > > +	PERF_REG_X86_MAX = PERF_REG_X86_XMM15 + 2,

And this wants to be PERF_REG_X86_XMM_MAX so you won't run into the same
trouble when yet another register set has to be added.

Thanks,

	tglx
