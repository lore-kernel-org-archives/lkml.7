Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99CAEC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 20:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64FD62467E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 20:54:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LZ0ndjGX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbfLQUy0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 15:54:26 -0500
Received: from merlin.infradead.org ([205.233.59.134]:58086 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727402AbfLQUy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 15:54:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=XUsRpc5ei9NN7Lxdkonngt/t8AjkaZ5bnNlv1WXUG/s=; b=LZ0ndjGXusiCWS1b21+k60uAt
        PhRQw0iNxJLA612DqqmdT2EHOj+NQN7nSqp1x5STFbwLIjuUTR1loFCxT+vi6QheIxpGk8scGfFEy
        S0jzrdh5gagfe13LqnMZKoyhpFQQockRa0kymaeM3sRp9Cbwkqp8VI4x12c+uQHSSMjoZgUzJ9Xjh
        5IHrAAeuQQhtrSeiJuHE9hO8v54wI+lvMpL0l/HKKkpzxTDlb/AOCDyNZ6y9zdImts2IVquFTww8j
        IeCCU5LJV14iFkUh04aTbzSsaKOUZ8pHwx27dmEF3VAF925KGC2/i53SXqe2X/hCohn9gLMybYHA1
        lvTPK/kmQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ihJrK-0006Qa-Hp; Tue, 17 Dec 2019 20:54:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 376613035D4;
        Tue, 17 Dec 2019 21:52:58 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F1F042B2CEC3D; Tue, 17 Dec 2019 21:54:20 +0100 (CET)
Date:   Tue, 17 Dec 2019 21:54:20 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [GIT PULL] timer fixes
Message-ID: <20191217205420.GK2844@hirez.programming.kicks-ass.net>
References: <20191217115547.GA68104@gmail.com>
 <CAHk-=wiVZMU69qB7nmkkyvjtDenQ+89V94V=3mmdY88uWYrZiQ@mail.gmail.com>
 <20191217193039.GF2844@hirez.programming.kicks-ass.net>
 <CAHk-=wgH8bSsgxnUAjuoUyDwHPKZwdVirH__=mJQu7RCFfCwZA@mail.gmail.com>
 <20191217203506.GI2844@hirez.programming.kicks-ass.net>
 <CAHk-=whccvKaB-Fezv9w9XuZx4JDz4jDiJd+dATTj7yErhvpKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whccvKaB-Fezv9w9XuZx4JDz4jDiJd+dATTj7yErhvpKQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 12:43:46PM -0800, Linus Torvalds wrote:
> On Tue, Dec 17, 2019 at 12:35 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > Pray.. the TSC MSR is still writable from SMM, so BIOS monkeys could
> > still do what they've been doing for decades.
> 
> Sure. And the HPET is unreliable, so the checking causes issues.
> 
> Which one should we worry about?

I'm just waiting for the system that messes up the TSC and doesn't have
HPET/PIT _at_all_ :-/

But yes, I get your point.

> > Also, what consititutes a 'modern' CPU?
> 
> I think anything that has TSC_STABLE set should likely be considered
> more reliable than HPET.
> 
> Or whatever the bit is called. The "doesn't stop in idle" thing.

The doesn't stop on idle thing is CONSTANT_TSC, and that has been set
since Nehalem, and there are a metric ton of systems still failing due
to the described SMM 'feature'.

Perhaps we can go with TSC_KNOWN_FREQ, which relies on CPUID.15h to tell
us the actual TSC frequency, but I'm not sure all modern systems
actually fill out that leaf :/

The systems that completely got rid of the HPET/PIT pretty much must
fill that out, otherwise there's just no way we can recover the TSC
frequency.

I'm going to have to wait for Thomas to chime in though; I only
occasionally poke at this stuff ;-)
