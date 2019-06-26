Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B10E0C48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 16:16:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84FAE21738
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 16:16:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="q8fUaCvb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbfFZQQ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 12:16:28 -0400
Received: from merlin.infradead.org ([205.233.59.134]:45898 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbfFZQQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 12:16:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=kp5vQ7g7PZjn2bwIYsd/b7jSyWQLrC+PRo907sE6ngQ=; b=q8fUaCvbwsnyax89+ww7wBhkQ
        cotQb54IGOruOk0WHbZBW4F8odZTwG6CKyM6IfY9n8qSiEjwZ5NZtv2mrp8vgjFse37dmeUIZuZMB
        +coVcpzIHhL7t+5fMi+8+y3EhoBLdyY0bv+kEqpVSzjgwlNgdLINKm+BkkkKLGiYV5Ljr89Rn50YX
        4zkmNYGeJkf4rF5aBN6VEFnPaiInhulHuB5CxnqdNjQy+1gtd8xxNGVRGjz65PUa/QhBn0+N4iGkE
        HMwLyUsh+jZx621iVYWq8KBQj8zT+oA+7+G1DGrfIyn31vveAyB/HDeZ6vgpotJ1d2IJiRL0j/G/m
        M9hR18mRg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hgAah-0008EN-Bs; Wed, 26 Jun 2019 16:16:11 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AC90F209CEDB5; Wed, 26 Jun 2019 18:16:08 +0200 (CEST)
Date:   Wed, 26 Jun 2019 18:16:08 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Ankur Arora <ankur.a.arora@oracle.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        KarimAllah <karahmed@amazon.de>,
        LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>
Subject: Re: cputime takes cstate into consideration
Message-ID: <20190626161608.GM3419@hirez.programming.kicks-ass.net>
References: <CANRm+Cyge6viybs63pt7W-cRdntx+wfyOq5EWE2qmEQ71SzMHg@mail.gmail.com>
 <alpine.DEB.2.21.1906261211410.32342@nanos.tec.linutronix.de>
 <20190626145413.GE6753@char.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626145413.GE6753@char.us.oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 10:54:13AM -0400, Konrad Rzeszutek Wilk wrote:
> On Wed, Jun 26, 2019 at 12:33:30PM +0200, Thomas Gleixner wrote:
> > On Wed, 26 Jun 2019, Wanpeng Li wrote:
> > > After exposing mwait/monitor into kvm guest, the guest can make
> > > physical cpu enter deeper cstate through mwait instruction, however,
> > > the top command on host still observe 100% cpu utilization since qemu
> > > process is running even though guest who has the power management
> > > capability executes mwait. Actually we can observe the physical cpu
> > > has already enter deeper cstate by powertop on host. Could we take
> > > cstate into consideration when accounting cputime etc?
> > 
> > If MWAIT can be used inside the guest then the host cannot distinguish
> > between execution and stuck in mwait.
> > 
> > It'd need to poll the power monitoring MSRs on every occasion where the
> > accounting happens.
> > 
> > This completely falls apart when you have zero exit guest. (think
> > NOHZ_FULL). Then you'd have to bring the guest out with an IPI to access
> > the per CPU MSRs.
> > 
> > I assume a lot of people will be happy about all that :)
> 
> There were some ideas that Ankur (CC-ed) mentioned to me of using the perf
> counters (in the host) to sample the guest and construct a better
> accounting idea of what the guest does. That way the dashboard
> from the host would not show 100% CPU utilization.

But then you generate extra noise and vmexits on those cpus, just to get
this accounting sorted, which sounds like a bad trade.
