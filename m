Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADBCAC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 20:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EC1022DD6
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 20:40:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="d9XwoM+6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730821AbfHTUkH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 16:40:07 -0400
Received: from merlin.infradead.org ([205.233.59.134]:40494 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729887AbfHTUkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 16:40:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=mLmr7c8zexEAJWjucH2NPO9ANNs5Tm8KXy2A8sFO3Ls=; b=d9XwoM+6cRiup428FiZC1N+b1
        LrNwyDnFfiJgaEF5eLN2hlNS39/mGnvTmbv1jTxQ3cbLsno3VGIgA5np+35tucvrokJQwMzRvczLW
        T0z+kXrGBjcJ+IW0EUime0ZLwKpYSJP7PV+72GKHKG1bOyGB4pbqSHPdv6bjzK94rrIClKaS2mG8/
        rAVaZrau8VJ03VMASQ32J/Biw7aULJPZA47+ptmZougtsUe22QxjmrT+MOXst6BijR9lrLMuWKqnP
        q5vLs2qAdHkPE3pBBHN2v9CqqYRUqepbZ/jw7JOOO61db5Q1BwZTTNHi3n7sVYmnb5Lx14CGXlwE2
        XZAQBJeZw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i0Aut-0005HU-Bm; Tue, 20 Aug 2019 20:39:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1523B3075FF;
        Tue, 20 Aug 2019 22:39:07 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5031720A21FC6; Tue, 20 Aug 2019 22:39:39 +0200 (CEST)
Date:   Tue, 20 Aug 2019 22:39:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alan Stern <stern@rowland.harvard.edu>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rostedt <rostedt@goodmis.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 1/1] Fix: trace sched switch start/stop racy updates
Message-ID: <20190820203939.GV2349@hirez.programming.kicks-ass.net>
References: <241506096.21688.1565977319832.JavaMail.zimbra@efficios.com>
 <Pine.LNX.4.44L0.1908161505400.1525-100000@iolanthe.rowland.org>
 <CAEXW_YQrh42N5bYMmQJCFb6xa0nwXH8jmZMEAnGVBMjGF8wR1Q@mail.gmail.com>
 <alpine.DEB.2.21.1908162245440.1923@nanos.tec.linutronix.de>
 <20190816205740.GF10481@google.com>
 <3c0cb8a2-eba2-7bea-8523-b948253a6804@arm.com>
 <CAHk-=wi_KeD1M-_-_SU_H92vJ-yNkDnAGhAS=RR1yNNGWKW+aA@mail.gmail.com>
 <20190817045217.GZ28441@linux.ibm.com>
 <20190820140116.GT2332@hirez.programming.kicks-ass.net>
 <20190820203135.GX28441@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190820203135.GX28441@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2019 at 01:31:35PM -0700, Paul E. McKenney wrote:
> On Tue, Aug 20, 2019 at 04:01:16PM +0200, Peter Zijlstra wrote:

> > We really should get the compiler folks to give us a
> > -fno-pointer-provenance. Waiting on the standards committee to get their
> > act together seems unlikely, esp. given that some people actually seem
> > to _want_ this nonsense :/
> 
> The reason that they want it is to enable some significant optimizations
> in numerical code on the one hand and in heavily templated C++ code on
> the other.  Neither of which has much bearing on kernel code.
> 
> Interested in coming to the next C standards committee meeting in October
> to help me push for this?  ;-)

How about we try and get some compiler folks together at plumbers and
bribe them with beer? Once we have our compiler knob, we happy :-)
