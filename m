Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0526C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 12:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 689EA20868
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 12:08:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UV0i+VCp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729055AbfDPMIv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 08:08:51 -0400
Received: from merlin.infradead.org ([205.233.59.134]:45128 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726857AbfDPMIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 08:08:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=X+xM7T1dkmqCagpQwf3/KoRz3Labh9sfqwlLQysIDgs=; b=UV0i+VCpuUKfWm4H5NOmlhuyy
        qBGYoPPiKSY0WeNd+QQb6LTCxmnY7//Roe5C69oZqnu2HlNbZFsZTLoWMQhrdR0h17Y/SMYCZUw9H
        ETqtLNtkjrbHPYmxwgttxKaT73Hpql0yUELMg+OIBSnF3B6iI9luCxEaIEGx1aD/SYR4SqOf2W86n
        m6RlST2p7Klge+HQditkPQ61KnT13RLv93gpf8jAz494gmCUAhxLCB2v0Kxzjc93dgjoChNx16mMX
        eOAAua2jqb5MLwuCkuPZIe4Hcg7GRVjUUxxbMivEqOZhtVqP0jbGLTdbIo1bRTciU0qQX18Wpv3yS
        wTGBd5zmw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hGMsy-0002Jn-3M; Tue, 16 Apr 2019 12:08:24 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 961F728691C15; Tue, 16 Apr 2019 14:08:22 +0200 (CEST)
Date:   Tue, 16 Apr 2019 14:08:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Reshetova, Elena" <elena.reshetova@intel.com>
Cc:     Ingo Molnar <mingo@kernel.org>, "tytso@mit.edu" <tytso@mit.edu>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "luto@kernel.org" <luto@kernel.org>,
        "luto@amacapital.net" <luto@amacapital.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "jannh@google.com" <jannh@google.com>,
        "Perla, Enrico" <enrico.perla@intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] x86/entry/64: randomize kernel stack offset upon syscall
Message-ID: <20190416120822.GV11158@hirez.programming.kicks-ass.net>
References: <20190415060918.3766-1-elena.reshetova@intel.com>
 <20190415072535.GA51449@gmail.com>
 <2236FBA76BA1254E88B949DDB74E612BA4C4F90F@IRSMSX102.ger.corp.intel.com>
 <20190416073444.GC127769@gmail.com>
 <2236FBA76BA1254E88B949DDB74E612BA4C51962@IRSMSX102.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2236FBA76BA1254E88B949DDB74E612BA4C51962@IRSMSX102.ger.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 11:10:16AM +0000, Reshetova, Elena wrote:
> > 
> > The kernel can execute millions of syscalls per second, I'm pretty sure
> > there's a statistical attack against:
> > 
> >  * This is a maximally equidistributed combined Tausworthe generator
> >  * based on code from GNU Scientific Library 1.5 (30 Jun 2004)
> >  *
> >  * lfsr113 version:
> >  *
> >  * x_n = (s1_n ^ s2_n ^ s3_n ^ s4_n)
> >  *
> >  * s1_{n+1} = (((s1_n & 4294967294) << 18) ^ (((s1_n <<  6) ^ s1_n) >> 13))
> >  * s2_{n+1} = (((s2_n & 4294967288) <<  2) ^ (((s2_n <<  2) ^ s2_n) >> 27))
> >  * s3_{n+1} = (((s3_n & 4294967280) <<  7) ^ (((s3_n << 13) ^ s3_n) >> 21))
> >  * s4_{n+1} = (((s4_n & 4294967168) << 13) ^ (((s4_n <<  3) ^ s4_n) >> 12))
> >  *
> >  * The period of this generator is about 2^113 (see erratum paper).
> > 
> > ... which recovers the real PRNG state much faster than the ~60 seconds
> > seeding interval and allows the prediction of the next stack offset?
> 
> I hope Theodore can comment on bounds here. How many syscalls we need
> to issue  assuming that each leaks 5 presudorandom bits out of 32 bit 
> presudorandom number produced by PRGN before we can predict the
> PRNG output. 

So the argument against using TSC directly was that it might be easy to
guess most of the TSC bits in timing attack. But IIRC there is fairly
solid evidence that the lowest TSC bits are very hard to guess and might
in fact be a very good random source.

So what one could do, is for each invocation mix in the low (2?) bits of
the TSC into a per-cpu/task PRNG state. By always adding some fresh
entropy it would become very hard indeed to predict the outcome, even
for otherwise 'trivial' PRNGs.
