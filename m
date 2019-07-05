Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23702C46499
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 21:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F33FD21738
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 21:00:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728130AbfGEVAg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 17:00:36 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36126 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbfGEVAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 17:00:36 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hjVJp-0007hv-Fg; Fri, 05 Jul 2019 23:00:33 +0200
Date:   Fri, 5 Jul 2019 23:00:32 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
cc:     Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, Nadav Amit <namit@vmware.com>,
        paulmck <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] cpu/hotplug: Cache number of online CPUs
In-Reply-To: <alpine.DEB.2.21.1907052246220.3648@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.21.1907052256490.3648@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1907042237010.1802@nanos.tec.linutronix.de> <1987107359.5048.1562273987626.JavaMail.zimbra@efficios.com> <alpine.DEB.2.21.1907042302570.1802@nanos.tec.linutronix.de> <1623929363.5480.1562277655641.JavaMail.zimbra@efficios.com>
 <alpine.DEB.2.21.1907050024270.1802@nanos.tec.linutronix.de> <611100399.5550.1562283294601.JavaMail.zimbra@efficios.com> <20190705084910.GA6592@gmail.com> <824482130.8027.1562341133252.JavaMail.zimbra@efficios.com>
 <alpine.DEB.2.21.1907052246220.3648@nanos.tec.linutronix.de>
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

On Fri, 5 Jul 2019, Thomas Gleixner wrote:
> On Fri, 5 Jul 2019, Mathieu Desnoyers wrote:
> > ----- On Jul 5, 2019, at 4:49 AM, Ingo Molnar mingo@kernel.org wrote:
> > > * Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> > >> The semantic I am looking for here is C11's relaxed atomics.
> > > 
> > > What does this mean?
> > 
> > C11 states:
> > 
> > "Atomic operations specifying memory_order_relaxed are  relaxed  only  with  respect
> > to memory ordering.  Implementations must still guarantee that any given atomic access
> > to a particular atomic object be indivisible with respect to all other atomic accesses
> > to that object."
> > 
> > So I am concerned that num_online_cpus() as proposed in this patch
> > try to access __num_online_cpus non-atomically, and without using
> > READ_ONCE().
> >
> > 
> > Similarly, the update-side should use WRITE_ONCE(). Protecting with a mutex
> > does not provide mutual exclusion against concurrent readers of that variable.
> 
> Again. This is nothing new. The current implementation of num_online_cpus()
> has no guarantees whatsoever. 
> 
> bitmap_hweight() can be hit by a concurrent update of the mask it is
> looking at.
> 
> num_online_cpus() gives you only the correct number if you invoke it inside
> a cpuhp_lock held section. So why do we need that fuzz about atomicity now?
> 
> It's racy and was racy forever and even if we add that READ/WRITE_ONCE muck
> then it still wont give you a reliable answer unless you hold cpuhp_lock at
> least for read. So fore me that READ/WRITE_ONCE is just a cosmetic and
> misleading reality distortion.

That said. If it makes everyone happy and feel better, I'm happy to add it
along with a bit fat comment which explains that it's just preventing a
theoretical store/load tearing issue and does not provide any guarantees
other than that.

Thanks,

	tglx
