Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D5B4C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 09:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 622EA218E2
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 09:56:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DYI5C/wT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbfCWJ4U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 05:56:20 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53224 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbfCWJ4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 05:56:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Yv2y1dnI1IMlueSXfn7Alpgw7H3d0jBHHD/J+YU1uuI=; b=DYI5C/wTJ1ouhecchHuspwaht
        j+HRD33Foirq8MQ9O0AD4tTqQWD4onL4I69j2mwJFX2Cfk1Dub50bT2prFPzs2c6ev+dehdEK3F1s
        4UAPcAWAzKec4Exi5qWb+n0dzQpP0kEhJe+0a1ed1yf3JhvLO053jfMSaSvQlDc1pnEg5Hc6LsjXU
        VGBFyt7kuz0dXvNycxA6Tk2AkYDvRUepjMSiEoWLO1OBXzojRy03Jy24ylAtra9+spK3r3ydfQzyW
        Cyb85EbgFHKWwSZ515kJGviQ5GKgoQYAJmi6b13W9+DelIdKO45xNp1T2f0bk+ceUA9ZgeaIZkWOo
        zfqDSUNvw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h7dNt-0002bC-HR; Sat, 23 Mar 2019 09:56:13 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C59C8203BF976; Sat, 23 Mar 2019 10:56:10 +0100 (CET)
Date:   Sat, 23 Mar 2019 10:56:10 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     kan.liang@linux.intel.com, acme@kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, jolsa@kernel.org,
        eranian@google.com, alexander.shishkin@linux.intel.com
Subject: Re: [PATCH V3 01/23] perf/x86: Support outputting XMM registers
Message-ID: <20190323095610.GB6058@hirez.programming.kicks-ass.net>
References: <20190322163718.2191-1-kan.liang@linux.intel.com>
 <20190322163718.2191-2-kan.liang@linux.intel.com>
 <20190322170841.GJ7905@worktop.programming.kicks-ass.net>
 <20190322172250.GF24002@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190322172250.GF24002@tassilo.jf.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 10:22:50AM -0700, Andi Kleen wrote:
> > > diff --git a/arch/x86/include/uapi/asm/perf_regs.h b/arch/x86/include/uapi/asm/perf_regs.h
> > > index f3329cabce5c..b33995313d17 100644
> > > --- a/arch/x86/include/uapi/asm/perf_regs.h
> > > +++ b/arch/x86/include/uapi/asm/perf_regs.h
> > > @@ -28,7 +28,29 @@ enum perf_event_x86_regs {
> > >  	PERF_REG_X86_R14,
> > >  	PERF_REG_X86_R15,
> > >  
> > > -	PERF_REG_X86_32_MAX = PERF_REG_X86_GS + 1,
> > > -	PERF_REG_X86_64_MAX = PERF_REG_X86_R15 + 1,
> > 
> > So this changes UAPI visible symbols... did we think about that?
> 
> Should be fine. Old programs won't use the new bits,
> and it just uses not yet used bits.

Old programs (that used the above symbols) will now fail to compile.
Even if they won't use the new bits, that seems like a bad thing.

> > > +	/* These all need two bits set because they are 128bit */
> > > +	PERF_REG_X86_XMM0  = 32,
> > > +	PERF_REG_X86_XMM1  = 34,
> > > +	PERF_REG_X86_XMM2  = 36,
> > > +	PERF_REG_X86_XMM3  = 38,
> > > +	PERF_REG_X86_XMM4  = 40,
> > > +	PERF_REG_X86_XMM5  = 42,
> > > +	PERF_REG_X86_XMM6  = 44,
> > > +	PERF_REG_X86_XMM7  = 46,
> > > +	PERF_REG_X86_XMM8  = 48,
> > > +	PERF_REG_X86_XMM9  = 50,
> > > +	PERF_REG_X86_XMM10 = 52,
> > > +	PERF_REG_X86_XMM11 = 54,
> > > +	PERF_REG_X86_XMM12 = 56,
> > > +	PERF_REG_X86_XMM13 = 58,
> > > +	PERF_REG_X86_XMM14 = 60,
> > > +	PERF_REG_X86_XMM15 = 62,
> > > +
> > > +	/* This does not include the XMMX registers */
> > > +	PERF_REG_GPR_X86_32_MAX = PERF_REG_X86_GS + 1,
> > > +	PERF_REG_GPR_X86_64_MAX = PERF_REG_X86_R15 + 1,
> > > +
> > > +	/* All registers include the XMMX registers */
> > > +	PERF_REG_X86_MAX = PERF_REG_X86_XMM15 + 2,
> > >  };
> > >  #endif /* _ASM_X86_PERF_REGS_H */
> > 
> > Also, what happens if we run a 32bit kernel or 32bit compat task?
> > 
> > Then the register dump will report PERF_SAMPLE_REGS_ABI_32, should we
> > then still interpret the XMM registers as 2x64bit?
> 
> Yes XMM registers are 128bit in 32bit mode too.
> 
> > 
> > Are they still at the same offset?
> 
> Yes.

I think that is broken.. perf_prepare_sample() does:

 size += hweight(mask) * sizeof(u64);

And since 32bits will not have r8-r15 set, the XMM registers will shift
forward no?

> > Do we need additional PERF_SAMPLE_REGS_ABI_* definitions for this?
> 
> I don't think so.

because....?
