Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF6EFC0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 08:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9810F20818
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 08:07:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GPQWyTvO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbfHEIH5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 04:07:57 -0400
Received: from merlin.infradead.org ([205.233.59.134]:47256 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbfHEIH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 04:07:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hQA/rHY648PLuDHdt0h8sdeUqJlY++q1WEQC024LSPw=; b=GPQWyTvOO6m8SdhjgY7gIUtSt
        8td4m7e5ShiEOi/gFXT67z1QlfvbOoXqXC94vtc6tPLADjYpr/T03SlVHwhCdrgD6wqDo2qx0PsXl
        y4Vvp6xJkj13Qr2DwVoJt5jwnAOMe8w9tRojqYXOjZ3Cbg/2iisbX99BHQhNxz1fv457wOcGPw9Xp
        B9WjroZnZMHKQgZuQ4SsmJ90DIUyAOeyzcE1T6CGvFfUTRxKSD4KIzF+U4XOBUPA79baEvWVX8krj
        X844yml+HqGp/2tDNFgXFp+6k4DTWOjE11r0fyQxhdeOhPbeg2zgkgLda89/uSFox19DR8dNbrX1W
        U6zXwx/Yw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1huY1q-0006OZ-0J; Mon, 05 Aug 2019 08:07:38 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BA9AB20238109; Mon,  5 Aug 2019 10:07:36 +0200 (CEST)
Date:   Mon, 5 Aug 2019 10:07:36 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
Subject: Re: [PATCH RFC tip/core/rcu 14/14] rcu/nohz: Make multi_cpu_stop()
 enable tick on all online CPUs
Message-ID: <20190805080736.GI2349@hirez.programming.kicks-ass.net>
References: <20190802151435.GA1081@linux.ibm.com>
 <20190802151501.13069-14-paulmck@linux.ibm.com>
 <20190804144317.GF2349@hirez.programming.kicks-ass.net>
 <20190804144835.GB2386@hirez.programming.kicks-ass.net>
 <20190804184159.GC28441@linux.ibm.com>
 <20190804202446.GA25634@linux.ibm.com>
 <20190805041901.GA17621@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190805041901.GA17621@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 04, 2019 at 09:19:01PM -0700, Paul E. McKenney wrote:
> On Sun, Aug 04, 2019 at 01:24:46PM -0700, Paul E. McKenney wrote:

> > For whatever it is worth, the things on my list include using 25 rounds
> > of resched_cpu() on each CPU with ten-jiffy wait between each (instead of
> > merely 10 rounds), using waitqueues or some such to actually force a
> > meaningful context switch on the other CPUs, etc.

That really should not be needed. What are those other CPUs doing?

> Which appears to have reduced the bug rate by about a factor of two.
> (But statistics and all that.)

Which is just weird..

> I am now trying the same test, but with CONFIG_PREEMPT=y and without
> quite so much hammering on the scheduler.  This is keying off Peter's
> earlier mention of preemption.  If this turns out to be solid, perhaps
> we outlaw CONFIG_PREEMPT=n && CONFIG_NO_HZ_FULL=y?

CONFIG_PREEMPT=n should work just fine, _something_ is off.
