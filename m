Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C60EEC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 08:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9169620661
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 08:22:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KUz9yPO6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729430AbfCFIWF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 03:22:05 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:32950 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729113AbfCFIWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 03:22:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=z2ymufQJ0P3rLeTTJZ1Gd3ZH+R+sItiRUE83Isz0u5U=; b=KUz9yPO6KqLzIhYpNvhgFuCcT
        UDUTpidTjHWcCyI7SNOMAqoPQEVmc9fU0S7tXvF4X7a/6V7d4eDH6aFoU2tRkzDijZVp9CRG02ZV6
        fNjmX20QQW6p9ZsEW/CNZ4UBZQAyRmR50g9Z2/36PK4hu5X+JKZjYBjw3brToiIptOsXfz/vYFMaA
        zcMLAdfRU40iqOOwK2XqC/aRFcYL48wqSPNNT36tfPjkMsnm7nmkkrDo3FOqI7ntKuU+GaovzrFNc
        uvATFZoN2qVSZ+MTl5mrtH11v60lp/Zn6rYVQkNloo2luhbr7elNoTrtIpGjDPib5/vKiT+NsULxe
        jUsCGb7Qg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h1Rny-0006Ki-3E; Wed, 06 Mar 2019 08:21:34 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F05C020288B9E; Wed,  6 Mar 2019 09:21:30 +0100 (CET)
Date:   Wed, 6 Mar 2019 09:21:30 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     "H.J. Lu" <hjl.tools@gmail.com>,
        libc-alpha <libc-alpha@sourceware.org>,
        Thomas Gleixner <tglx@linutronix.de>,
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
Message-ID: <20190306082130.GR32477@hirez.programming.kicks-ass.net>
References: <20190305194755.2602-1-mathieu.desnoyers@efficios.com>
 <1689743723.311.1551817115045.JavaMail.zimbra@efficios.com>
 <20190305215848.GQ32477@hirez.programming.kicks-ass.net>
 <486623963.509.1551825130539.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <486623963.509.1551825130539.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 05, 2019 at 05:32:10PM -0500, Mathieu Desnoyers wrote:
> ----- On Mar 5, 2019, at 4:58 PM, Peter Zijlstra peterz@infradead.org wrote:
> 
> > On Tue, Mar 05, 2019 at 03:18:35PM -0500, Mathieu Desnoyers wrote:
> >> * NUMA node ID in TLS
> >> 
> >> Having the NUMA node ID available in a TLS variable would allow glibc to
> >> perform interesting NUMA performance improvements within its locking
> >> implementation, so I have a patch adding NUMA node ID support to rseq
> >> as a new rseq system call flag.
> > 
> > Details? There's just not much room in the futex word, and futexes
> > themselves are not numa aware.
> 
> It was discussed in this libc-alpha mailing list thread:
> 
> https://public-inbox.org/libc-alpha/CAMe9rOo7i_-keOooa0D+P_wzatVCdKkTRiFiJ-cxpnvi+eApuQ@mail.gmail.com/
> 
> (adding the relevant people in CC)
> 
> I'd like to hear in more details on how they intend to design
> NUMA-aware spinlocks within glibc. All I know is that quick
> access to the node ID would help for this.

Userspace spinlocks are a trainwreck anyway. The only case where they
can possibly work is when there's only a single thread on every cpu.
Pretty much any other scenario is fail; see why we have paravirt
spinlocks.
