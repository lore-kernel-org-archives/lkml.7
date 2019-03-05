Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D8DC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 21:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AD35204EC
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 21:59:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JTjUJCeS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbfCEV7K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 16:59:10 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:50384 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbfCEV7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 16:59:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=S5D+ZKEb9YSuAyGw+/SJ6MvstacJ7JCOweqz7ts1ryU=; b=JTjUJCeSbpvatbieJ0j4PJwuG
        gCyllfeU9i/fa4of0HnRX8/1Kc7QBsrR0DFcMN5NWhQa6cmL8xW4KOHn0y2WWH9jpXWgSRl8aJHrH
        LuTarTzKzUjdifYQQz/dCHkmpaMHthq5TzGIxHBDlqeBCCSjhCeJ3mvLJg3sfmM3X1AThoRnyATO1
        t0ozP5TxF5YGiWvAFzqhgmseunx4rcbSoAja2cNb3CepklnjjL0j7Rk6FfOlKZMBLXFmAY6OXATbA
        6mH6Ef+kFz98i4Zgl3aNhWBxZTJsPRXXIRoEMHh4BJyEr3dfhSQYyIqxofFE/fc/I8XWIG/zVmr+P
        Y81wDuijA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h1I5K-0006M9-Af; Tue, 05 Mar 2019 21:58:50 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7B134202CAE28; Tue,  5 Mar 2019 22:58:48 +0100 (CET)
Date:   Tue, 5 Mar 2019 22:58:48 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <andi@firstfloor.org>,
        Chris Lameter <cl@linux.com>, Ben Maurer <bmaurer@fb.com>,
        rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>,
        Carlos O'Donell <carlos@redhat.com>,
        Florian Weimer <fweimer@redhat.com>
Subject: Re: [PATCH for 5.1 0/3] Restartable Sequences updates for 5.1
Message-ID: <20190305215848.GQ32477@hirez.programming.kicks-ass.net>
References: <20190305194755.2602-1-mathieu.desnoyers@efficios.com>
 <1689743723.311.1551817115045.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1689743723.311.1551817115045.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 05, 2019 at 03:18:35PM -0500, Mathieu Desnoyers wrote:
> * NUMA node ID in TLS
> 
> Having the NUMA node ID available in a TLS variable would allow glibc to
> perform interesting NUMA performance improvements within its locking
> implementation, so I have a patch adding NUMA node ID support to rseq
> as a new rseq system call flag.

Details? There's just not much room in the futex word, and futexes
themselves are not numa aware.

Before all this spectre nonsense; tglx and me were looking at a futex2
syscall that would, among other things, cure this.

> * Adaptative mutex improvements
> 
> I have done a prototype using rseq to implement an adaptative mutex which
> can detect preemption using a rseq critical section. This ensures the
> thread doesn't continue to busy-loop after it returns from preemption, and
> calls sys_futex() instead. This is part of a user-space prototype branch [2],
> and does not require any kernel change.

I'm still not convinced that is actually the right way to go about
things. The kernel heuristic is spin while the _owner_ runs, and we
don't get preempted, obviously.

And the only userspace spinning that makes sense is to cover the cost of
the syscall. Now Obviously PTI wrecked everything, but before that
syscalls were actually plenty fast and you didn't need many cmpxchg
cycles to amortize the syscall itself -- which could then do kernel side
adaptive spinning (when required).


