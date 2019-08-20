Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 446F1C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 14:01:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 139B122CF7
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 14:01:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FRnIwSNx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730293AbfHTOB5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 10:01:57 -0400
Received: from merlin.infradead.org ([205.233.59.134]:37300 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730133AbfHTOB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 10:01:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=gLhg4HAa4igL5SyHGpnfr2gcltQ/3hnkrbcKe7wbKUw=; b=FRnIwSNxSTuM6hcyu83oqyloX
        3b5NsACn6SxOMm1uowjxEedIkVTh1ipU2CUgs2pLkzRlWrZIrF8wuSjgxGLmXgAqNWlzTFfD6L3sB
        y9jjRrAlD0NlSg/i2nU8p0NYHqWmItceaE/5a/gB6qHtJKRFRW/3UbD/YlCS62iyVx4zgUH75c8PK
        8KVYJTzSJ8yVCzNXoQx0x58GQ28bUNNVtAfl7G9nhOCp6ibwT/hBovvqKJQlA7eGgQblf5+nL0ffa
        VmBlgci966Qgj9eeEHYb9QB6X4bjzCksmqBMX0maO5vuJgse/xm9thoZkVezjHVZ2lPl/N0HX5RDC
        I1/tUOvLA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i04hM-0000CS-9G; Tue, 20 Aug 2019 14:01:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 83D7F307603;
        Tue, 20 Aug 2019 16:00:45 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A6C4620A99A00; Tue, 20 Aug 2019 16:01:16 +0200 (CEST)
Date:   Tue, 20 Aug 2019 16:01:16 +0200
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
Message-ID: <20190820140116.GT2332@hirez.programming.kicks-ass.net>
References: <241506096.21688.1565977319832.JavaMail.zimbra@efficios.com>
 <Pine.LNX.4.44L0.1908161505400.1525-100000@iolanthe.rowland.org>
 <CAEXW_YQrh42N5bYMmQJCFb6xa0nwXH8jmZMEAnGVBMjGF8wR1Q@mail.gmail.com>
 <alpine.DEB.2.21.1908162245440.1923@nanos.tec.linutronix.de>
 <20190816205740.GF10481@google.com>
 <3c0cb8a2-eba2-7bea-8523-b948253a6804@arm.com>
 <CAHk-=wi_KeD1M-_-_SU_H92vJ-yNkDnAGhAS=RR1yNNGWKW+aA@mail.gmail.com>
 <20190817045217.GZ28441@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190817045217.GZ28441@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 09:52:17PM -0700, Paul E. McKenney wrote:
> On Fri, Aug 16, 2019 at 03:57:43PM -0700, Linus Torvalds wrote:
> 
> [ . . . ]
> 
> > We add READ_ONCE and WRITE_ONCE annotations when they make sense. Not
> > because of some theoretical "compiler is free to do garbage"
> > arguments. If such garbage happens, we need to fix the compiler, the
> > same way we already do with
> > 
> >   -fno-strict-aliasing
> 
> Yeah, the compete-with-FORTRAN stuff.  :-/
> 
> There is some work going on in the C committee on this, where the
> theorists would like to restrict strict-alias based optimizations to
> enable better analysis tooling.  And no, although the theorists are
> pushing in the direction we would like them to, as far as I can see
> they are not pushing as far as we would like.  But it might be that
> -fno-strict-aliasing needs some upgrades as well.  I expect to learn
> more at the next meeting in a few months.
> 
> http://www.open-std.org/jtc1/sc22/wg14/www/docs/n2364.pdf
> http://www.open-std.org/jtc1/sc22/wg14/www/docs/n2363.pdf
> http://www.open-std.org/jtc1/sc22/wg14/www/docs/n2362.pdf

We really should get the compiler folks to give us a
-fno-pointer-provenance. Waiting on the standards committee to get their
act together seems unlikely, esp. given that some people actually seem
to _want_ this nonsense :/
