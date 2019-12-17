Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41124C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 20:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EE93206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 20:35:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qykDt+ey"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728208AbfLQUfR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 15:35:17 -0500
Received: from merlin.infradead.org ([205.233.59.134]:57832 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727231AbfLQUfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 15:35:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=feYofmRueGJ0qKn7Vllzum/pxYHKm0V/zlVg2bfAmYA=; b=qykDt+eyis2MvEy/7BKBjIw9V
        DOZfo9sPk7G4Hl2LMkS9DnAT2zc6MID6iOH8qkbndYguXRN4UgULfWpsCh1ypIJFPN+7/ULhX2wrC
        o1g7AbDTa4ctKrY3y0hsUx8WQzsNdtmst8O2tUtbqWKEPWDqzoMvDm8YNSeDpx0fXaninbYTHw01/
        ac20Ri6or9in1vAyp0AQJB7HeboP1kyFN7wMLlhI/so6WsOKWmq6Ga6jdKSyOen6rKB1yP/bNVcq8
        6DjrfSSH5fteeYRime04nEm62skR80I6AstRKnVjZ1Q/70szfoLBZAYkNTFxO3slpRiah2CH0qi7R
        FnaGgIsLA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ihJYj-000627-4x; Tue, 17 Dec 2019 20:35:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9504C300F29;
        Tue, 17 Dec 2019 21:33:43 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 489232B2CEC1D; Tue, 17 Dec 2019 21:35:06 +0100 (CET)
Date:   Tue, 17 Dec 2019 21:35:06 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [GIT PULL] timer fixes
Message-ID: <20191217203506.GI2844@hirez.programming.kicks-ass.net>
References: <20191217115547.GA68104@gmail.com>
 <CAHk-=wiVZMU69qB7nmkkyvjtDenQ+89V94V=3mmdY88uWYrZiQ@mail.gmail.com>
 <20191217193039.GF2844@hirez.programming.kicks-ass.net>
 <CAHk-=wgH8bSsgxnUAjuoUyDwHPKZwdVirH__=mJQu7RCFfCwZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgH8bSsgxnUAjuoUyDwHPKZwdVirH__=mJQu7RCFfCwZA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 12:16:52PM -0800, Linus Torvalds wrote:
> On Tue, Dec 17, 2019 at 11:30 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > What alternatives are there? That is, we normally only use HPET to
> > double check nobody messed up the TSC.
> 
> The thing is HPET seems to be _less_ reliable than the TSC we're
> checking these days.
> 
> If that's the only use-case for HPET, we should just stop doing it.
> 
> > We can't just blindly trust TSC across everything x86.
> 
> No, but we can trust it when it's a modern CPU.

Pray.. the TSC MSR is still writable from SMM, so BIOS monkeys could
still do what they've been doing for decades. Which is try and 'hide'
SMM latency by taking the TSC timestamp on SMM entry and writing the
timestamp back into the TSC MSR on exit.

Yes, ever since TSC_ADJUST we can better recover from it, but
we still need to first detect it went sideways and by then time has been
observed buggered and any recovery is basically too late :/

Granted, this is happening less (at least, I really do hope so).

Also, what consititutes a 'modern' CPU?

> The HPET seems to get disabled on all the modern platforms, why do we
> even have it enabled by default?

These new ones yeah, cuz they wrecked HPET in PC10 :/

> We should do the HPET cross-check only when we know the TSC might be
> unreliable, I suspect.

But how do we know? Ever since Nehalem TSC has basically been good
hardware wise -- there's a few exception on large (>4) socket machines,
but nobody has those anyway.

It has always been the BIOS messing it up. Now, the reason I think it
has gotten better is because Windows is now also relying on TSC (like
we've been doing forever).

Maybe I'm too scarred by too much TSC wreckage over the years...
