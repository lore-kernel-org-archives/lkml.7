Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D58CAC3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 15:34:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D2EB206BB
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 15:34:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ib9f3bRp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728891AbfHUPeC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 11:34:02 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37490 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbfHUPeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 11:34:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=iNMFWtCVUyppqjH3IdnBVXbgFcyLHvc4XyezRJUSxvM=; b=Ib9f3bRpltoNRpCH+woTeIbcP
        WSDU6AvMySyh08AJoaEp9TdoMNorEIVRwrO5lL0DuVFdFMXiJEWZIpZtbb+yH40vKc984XF03tDR2
        KP3hunB1Nwkg38TWWg3kCGkkDgO/ppmczHxyl4Y6t0JVqW45CfqJcLnZTwO/QZP5XI1FAPX799s4u
        +O3Q8TVigoYhA0gSn6JJJv4/bEBjJoNT1fYZfgQt+PrsSMvjCiI3/3jOXixI2ENXZMvami4TBQHK7
        UlYA0ZFtj9h1nBNFQQYgk4WCxeLcJJC0Yz0eUYZ4amOid8XMjqrk4WlPu2wI0Q4FvV3/cX3jPKxeu
        hzBdpRjtw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i0Sc4-0005hh-My; Wed, 21 Aug 2019 15:33:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B95E2305F65;
        Wed, 21 Aug 2019 17:32:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4CE5520A978FE; Wed, 21 Aug 2019 17:33:25 +0200 (CEST)
Date:   Wed, 21 Aug 2019 17:33:25 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Will Deacon <will@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joel Fernandes <joel@joelfernandes.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        rostedt <rostedt@goodmis.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 1/1] Fix: trace sched switch start/stop racy updates
Message-ID: <20190821153325.GD2349@hirez.programming.kicks-ass.net>
References: <Pine.LNX.4.44L0.1908161505400.1525-100000@iolanthe.rowland.org>
 <CAEXW_YQrh42N5bYMmQJCFb6xa0nwXH8jmZMEAnGVBMjGF8wR1Q@mail.gmail.com>
 <alpine.DEB.2.21.1908162245440.1923@nanos.tec.linutronix.de>
 <CAHk-=wh9qDFfWJscAQw_w+obDmZvcE5jWJRdYPKYP6YhgoGgGA@mail.gmail.com>
 <1642847744.23403.1566005809759.JavaMail.zimbra@efficios.com>
 <CAHk-=wgC4+kV9AiLokw7cPP429rKCU+vjA8cWAfyOjC3MtqC4A@mail.gmail.com>
 <20190820135612.GS2332@hirez.programming.kicks-ass.net>
 <20190820202932.GW28441@linux.ibm.com>
 <20190821103200.kpufwtviqhpbuv2n@willie-the-truck>
 <20190821132310.GC28441@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821132310.GC28441@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 06:23:10AM -0700, Paul E. McKenney wrote:
> On Wed, Aug 21, 2019 at 11:32:01AM +0100, Will Deacon wrote:

> > and so it is using a store-pair instruction to reduce the complexity in
> > the immediate generation. Thus, the 64-bit store will only have 32-bit
> > atomicity. In fact, this is scary because if I change bar to:
> > 
> > void bar(u64 *x)
> > {
> > 	*(volatile u64 *)x = 0xabcdef10abcdef10;
> > }
> > 
> > then I get:
> > 
> > bar:
> > 	mov	w1, 61200
> > 	movk	w1, 0xabcd, lsl 16
> > 	str	w1, [x0]
> > 	str	w1, [x0, 4]
> > 	ret
> > 
> > so I'm not sure that WRITE_ONCE would even help :/
> 
> Well, I can have the LWN article cite your email, then.  So thank you
> very much!
> 
> Is generation of this code for a 64-bit volatile store considered a bug?
> Or does ARMv8 exclude the possibility of 64-bit MMIO registers?  And I
> would guess that Thomas and Linus would ask a similar bugginess question
> for normal stores.  ;-)

I'm calling this a compiler bug; the way I understand volatile this is
very much against the intentended use case. That is, this is buggy even
on UP vs signals or MMIO.
