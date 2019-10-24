Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE7BECA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 21:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80D5921929
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 21:00:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728839AbfJXVAD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 17:00:03 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33958 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727838AbfJXVAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 17:00:02 -0400
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iNkD7-0001Z3-Rp; Thu, 24 Oct 2019 22:59:58 +0200
Date:   Thu, 24 Oct 2019 22:59:56 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andy Lutomirski <luto@kernel.org>
cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: [patch V2 07/17] x86/entry/64: Remove redundant interrupt
 disable
In-Reply-To: <alpine.DEB.2.21.1910242032080.1783@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.21.1910242257310.1783@nanos.tec.linutronix.de>
References: <20191023122705.198339581@linutronix.de> <20191023123118.296135499@linutronix.de> <20191023220618.qsmog2k5oaagj27v@treble> <alpine.DEB.2.21.1910240146200.1852@nanos.tec.linutronix.de> <CALCETrX+N_cR-HAmQyHxqUo0LPCk4GmqbzizXk-gq9qp00-RdA@mail.gmail.com>
 <alpine.DEB.2.21.1910242032080.1783@nanos.tec.linutronix.de>
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

On Thu, 24 Oct 2019, Thomas Gleixner wrote:
> Whatever we decide it is, leaving it completely inconsistent is not a
> solution at all. The options are:

Actually there is also:

    0) Always do unconditional trace_irqs_on().

       But that does not allow to actually trace the real return flags
       state which might be useful to diagnose crap which results from user
       space CLI.
 
>   1)  Always do conditional tracing depending on the user_regs->eflags.IF
>       state.
> 
>   2)  #1 + warn once when syscalls and exceptions (except NMI/MCE) happen
>       and user_regs->eflags.IF is cleared.
> 
>   3a) #2 + enforce signal handling to run with interrupts enabled.
> 
>   3b) #2 + set regs->eflags.IF. So the state is always correct from the
>       kernel POV. Of course that changes existing behaviour, but its
>       changing undefined and inconsistent behaviour.
>   
>   4) Let iopl(level) return -EPERM if level == 3.
> 
>      Yeah, I know it's not possible due to regressions (DPKD uses iopl(3)),
>      but TBH that'd be the sanest option of all.
> 
>      Of course the infinite wisdom of hardware designers tied IN, INS, OUT,
>      OUTS and CLI/STI together on IOPL so we cannot even distangle them in
>      any way.
> 
>      The only way out would be to actually use a full 8K sized I/O bitmap,
>      but that's a massive pain as it has to be copied on every context
>      switch. 
> 
> Really pretty options to chose from ...
> 
> Thanks,
> 
> 	tglx
> 
