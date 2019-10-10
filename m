Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DA9FC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 12:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 120D5206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 12:32:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kc7eo7i+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733289AbfJJMci (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 08:32:38 -0400
Received: from merlin.infradead.org ([205.233.59.134]:59476 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726923AbfJJMci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 08:32:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=JHl9GmYtentxJL+7m1E2SgJVgP8t2x02tS9jT0BZXPY=; b=kc7eo7i+iGPnb8iSo9NczDvt8Y
        rHiGsvmqx6erZt14GL+1e78YvnlkwOKyVo5iRHX3aNc6HNbp075D50M0f/3cwgl3k/RKzpL/fn5wM
        HwmRmVLSPU73hu0+yOml9+pkJbkPL/YWeQLnxcbi+dqHiHAflRV9XbPnwVPP1pQVlh4Wuojy77Zd/
        +DnGmEl9KT+vM1hdNOW5t7WCXnAqVKqFtFJN8sg3m4cOAF7mqkciZ9RpFPf7r0nm+GjldiZh9Hfok
        o/4vYmvXXwWQykt36mUK24VRQjx3gApcCdF/ZFsML1vLZHT4ZKAn7tMExucfcapZwXhbBM2KLLz1x
        3b7Rv0yw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iIXcD-0007JG-Cc; Thu, 10 Oct 2019 12:32:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 51A1B301224;
        Thu, 10 Oct 2019 14:31:27 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 88009205A4300; Thu, 10 Oct 2019 14:32:19 +0200 (CEST)
Date:   Thu, 10 Oct 2019 14:32:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Manfred Spraul <manfred@colorfullife.com>
Cc:     Waiman Long <longman@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        1vier1@web.de, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: wake_q memory ordering
Message-ID: <20191010123219.GO2328@hirez.programming.kicks-ass.net>
References: <990690aa-8281-41da-4a46-99bb8f9fec31@colorfullife.com>
 <20191010114244.GS2311@hirez.programming.kicks-ass.net>
 <7af22b09-2ab9-78c9-3027-8281f020e2e8@colorfullife.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7af22b09-2ab9-78c9-3027-8281f020e2e8@colorfullife.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2019 at 02:13:47PM +0200, Manfred Spraul wrote:
> Hi Peter,
> 
> On 10/10/19 1:42 PM, Peter Zijlstra wrote:
> > On Thu, Oct 10, 2019 at 12:41:11PM +0200, Manfred Spraul wrote:
> > > Hi,
> > > 
> > > Waiman Long noticed that the memory barriers in sem_lock() are not really
> > > documented, and while adding documentation, I ended up with one case where
> > > I'm not certain about the wake_q code:
> > > 
> > > Questions:
> > > - Does smp_mb__before_atomic() + a (failed) cmpxchg_relaxed provide an
> > >    ordering guarantee?
> > Yep. Either the atomic instruction implies ordering (eg. x86 LOCK
> > prefix) or it doesn't (most RISC LL/SC), if it does,
> > smp_mb__{before,after}_atomic() are a NO-OP and the ordering is
> > unconditinoal, if it does not, then smp_mb__{before,after}_atomic() are
> > unconditional barriers.
> 
> And _relaxed() differs from "normal" cmpxchg only for LL/SC architectures,
> correct?

Indeed.

> Therefore smp_mb__{before,after}_atomic() may be combined with
> cmpxchg_relaxed, to form a full memory barrier, on all archs.

Just so.

> > > - Is it ok that wake_up_q just writes wake_q->next, shouldn't
> > >    smp_store_acquire() be used? I.e.: guarantee that wake_up_process()
> > >    happens after cmpxchg_relaxed(), assuming that a failed cmpxchg_relaxed
> > >    provides any ordering.
> > There is no such thing as store_acquire, it is either load_acquire or
> > store_release. But just like how we can write load-aquire like
> > load+smp_mb(), so too I suppose we could write store-acquire like
> > store+smp_mb(), and that is exactly what is there (through the implied
> > barrier of wake_up_process()).
> 
> Thanks for confirming my assumption:
> The code is correct, due to the implied barrier inside wake_up_process().

It has a comment there, trying to state this.

		task->wake_q.next = NULL;

		/*
		 * wake_up_process() executes a full barrier, which pairs with
		 * the queueing in wake_q_add() so as not to miss wakeups.
		 */
		wake_up_process(task);
