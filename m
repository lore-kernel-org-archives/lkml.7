Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FDBDC06510
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 14:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3952B2173E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 14:01:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="q1EXwTG4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729315AbfGAOBX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 10:01:23 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50212 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbfGAOBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 10:01:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=afNqu/duuK9wJTjZbPueWefwBIXHOijfGxxZ9sdqRnQ=; b=q1EXwTG4IJbKO+kQhc70xhFLZ
        zx4OCyUxNDvnpQzcKOkkzn63y1QkqNmFWfh53S3jS3iEdiVAD5zrS3iN0Yc5WtNQTUhALi5BR9kr7
        Ts0K7a+gmFwsemaJV6qgp6jEfJNtjTWmSz57A3cBzms/myhXugJx0aYIv4dJ5gB5sbEV66IXddxmW
        xe2WKaCnIqqMBnHLtiH+aI4AL5uy+XjXmjkYUtPHnNaCITPxRsAN3AzJgptIkKXGbd8J/6FvPDorU
        RrjrAzJwX+ePwqkpviUHdyT163GtfmimDS+5sj5RryHa8O/OekqcXnZH1SyiUrXZM34pIdJHldHAs
        WZpE54ufA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hhwrX-0004zz-Io; Mon, 01 Jul 2019 14:00:55 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C9D6720963E23; Mon,  1 Jul 2019 16:00:53 +0200 (CEST)
Date:   Mon, 1 Jul 2019 16:00:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Scott Wood <swood@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        rcu <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [RFC] Deadlock via recursive wakeup via RCU with threadirqs
Message-ID: <20190701140053.GV3402@hirez.programming.kicks-ass.net>
References: <20190627184107.GA26519@linux.ibm.com>
 <13761fee4b71cc004ad0d6709875ce917ff28fce.camel@redhat.com>
 <20190627203612.GD26519@linux.ibm.com>
 <20190628141522.GF3402@hirez.programming.kicks-ass.net>
 <20190628155404.GV26519@linux.ibm.com>
 <20190628160408.GH32547@worktop.programming.kicks-ass.net>
 <20190628172056.GW26519@linux.ibm.com>
 <20190701094215.GR3402@hirez.programming.kicks-ass.net>
 <20190701102442.35grdpcsbrwyyaco@linutronix.de>
 <20190701122305.GB26519@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190701122305.GB26519@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 01, 2019 at 05:23:05AM -0700, Paul E. McKenney wrote:
> On Mon, Jul 01, 2019 at 12:24:42PM +0200, Sebastian Andrzej Siewior wrote:
> > On 2019-07-01 11:42:15 [+0200], Peter Zijlstra wrote:
> > > I'm not sure if smp_send_reschedule() can be used as self-IPI, some
> > > hardware doesn't particularly like that IIRC. That is, hardware might
> > > only have interfaces to IPI _other_ CPUs, but not self.
> > > 
> > > The normal scheduler code takes care to not call smp_send_reschedule()
> > > to self.
> > 
> > and irq_work:
> >   471ba0e686cb1 ("irq_work: Do not raise an IPI when queueing work on the local CPU")
> 
> OK, so it looks like I will need to use something else.  But thank you
> for calling my attention to this commit.

I think that commit is worded slight confusing -- sorry I should've paid
more attention.

irq_work _does_ work locally, and arch_irq_work_raise() must self-IPI,
otherwise everything is horribly broken.

But what happened, was that irq_work_queue() and irq_work_queue_on(.cpu
= smp_processor_id()) wasn't using the same code, and the latter would
try to self-IPI through arch_send_call_function_single_ipi().

Nick fixed that so that irq_work_queue() and irq_work_queue_on(.cpu =
smp_processor_id() now both use arch_raise_irq_work() and remote stuff
uses arch_send_call_function_single_ipi().

