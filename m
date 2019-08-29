Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE6BC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 08:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3979233A1
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 08:53:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qTsw9a+n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbfH2Ixz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 04:53:55 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39740 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbfH2Ixz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 04:53:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7V5ganeEJBh/ANVBsszc74jPYOOGOhNbXOVXx/PcXEQ=; b=qTsw9a+nEDh68p5PWYTXuM13d
        AHor4XODRfl8k1oaBdECZok9x1C6j21pRGXl1mMp0Iw1X+VDVG/PeUCadVvj4K87rzOEN0l9YvnwB
        Zxp9HyUBtXcUYe4cWAznuzJ9j22H5MZXaFQf1Q/i/I0mEgeFFf2iW5cwLOUhticbYc/9tXiNgw6kv
        zwk4ruVT4TZ2bALKMIi2sRnSNbCrcak4E6Xmlkqm8ai4QOiswbFSglpRhaaTxOf1BkQvJnkbVUK9s
        QKNdbT/Fp/cmWjIFM/FJz7qAleTWM745Twtkwdm8CotAQVO0/2S61UOpkC8WzraO6qQ9rU0x728K2
        x06oXWzzg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i3GBa-0007Qs-DT; Thu, 29 Aug 2019 08:53:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 731E73074C6;
        Thu, 29 Aug 2019 10:53:05 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9CF5E201EED7A; Thu, 29 Aug 2019 10:53:39 +0200 (CEST)
Date:   Thu, 29 Aug 2019 10:53:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Nadav Amit <nadav.amit@gmail.com>, Andi Kleen <ak@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Edward Cree <ecree@solarflare.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        songliubraving@fb.com
Subject: Re: Tracing text poke / kernel self-modifying code (Was: Re: [RFC v2
 0/6] x86: dynamic indirect branch promotion)
Message-ID: <20190829085339.GN2369@hirez.programming.kicks-ass.net>
References: <c4e836e8-1949-27f5-f6a0-ed860f590ec5@intel.com>
 <20190108092559.GA6808@hirez.programming.kicks-ass.net>
 <306d38fb-7ce6-a3ec-a351-6c117559ebaa@intel.com>
 <20190108101058.GB6808@hirez.programming.kicks-ass.net>
 <20190108172721.GN6118@tassilo.jf.intel.com>
 <D1A153D5-D23B-45E6-9E7A-EB9CBAE84B7E@gmail.com>
 <20190108190104.GC1900@hirez.programming.kicks-ass.net>
 <7EB5F9ED-8743-4225-BE97-8D5C8D8E0F84@gmail.com>
 <20190109103544.GH1900@hirez.programming.kicks-ass.net>
 <7b4952c2-d3e3-488f-3697-2e8b71c58063@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b4952c2-d3e3-488f-3697-2e8b71c58063@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2019 at 11:23:52AM +0300, Adrian Hunter wrote:
> On 9/01/19 12:35 PM, Peter Zijlstra wrote:
> > On Tue, Jan 08, 2019 at 12:47:42PM -0800, Nadav Amit wrote:
> > 
> >> A general solution is more complicated, however, due to the racy nature of
> >> cross-modifying code. There would need to be TSC recording of the time
> >> before the modifications start and after they are done.
> >>
> >> BTW: I am not sure that static-keys are much better. Their change also
> >> affects the control flow, and they do affect the control flow.
> > 
> > Any text_poke() user is a problem; which is why I suggested a
> > PERF_RECORD_TEXT_POKE that emits the new instruction. Such records are
> > timestamped and can be correlated to the trace.
> > 
> > As to the racy nature of text_poke, yes, this is a wee bit tricky and
> > might need some care. I _think_ we can make it work, but I'm not 100%
> > sure on exactly how PT works, but something like:
> > 
> >  - write INT3 byte
> >  - IPI-SYNC
> > 
> > and ensure the poke_handler preserves the existing control flow (which
> > it currently does not, but should be possible).
> > 
> >  - emit RECORD_TEXT_POKE with the new instruction
> > 
> > at this point the actual control flow will be through the INT3 and
> > handler and not hit the actual instruction, so the actual state is
> > irrelevant.
> > 
> >  - write instruction tail
> >  - IPI-SYNC
> >  - write first byte
> >  - IPI-SYNC
> > 
> > And at this point we start using the new instruction, but this is after
> > the timestamp from the RECORD_TEXT_POKE event and decoding should work
> > just fine.
> > 
> 
> Presumably the IPI-SYNC does not guarantee that other CPUs will not already
> have seen the change.  In that case, it is not possible to provide a
> timestamp before which all CPUs executed the old code, and after which all
> CPUs execute the new code.

'the change' is an INT3 poke, so either you see the old code flow, or
you see an INT3 emulate the old flow in your trace.

That should be unambiguous.

Then you emit the RECORD_TEXT_POKE with the new instruction on. This
prepares the decoder to accept a new reality.

Then we finish the instruction poke.

And then when the trace no longer shows INT3 exceptions, you know the
new code is in effect.

How is this ambiguous?

