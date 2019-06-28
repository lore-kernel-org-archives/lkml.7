Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E848C5B579
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 14:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26900208E3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 14:15:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="shIOtJ5Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfF1OPr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 10:15:47 -0400
Received: from merlin.infradead.org ([205.233.59.134]:43644 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726616AbfF1OPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 10:15:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KGyxyb6C9C36jd3MUag3X49JqaizbydoeqxFEKojv6k=; b=shIOtJ5Qnv0SN0BmGMmEU85BH
        SOLnXtGR4diAGHxmbXBVtYWSTszrr6hEE5zK9mDNqOjaWnbqydFVS8NyWGUPL//1ZDl+nBAnROyFx
        lJqT4dwEH3BsOwh3ULkv16SXLb/g31gaRS8EJ7/xCtVPU7nEAlYtgTUx2a5SnXUla3TAwkLnAMaWm
        D9pFMkH8vCiqJICV/G2UN/a2gA1jkDj8cVb8kjwdiOuJDsyvnlFhs14H3adUVTPFcMRSnQ6uaUEvk
        XPJzJm51Uf3+DdMkdwK3hu10u/3gdEKrk867Ro5T1wlY878pBWemvPWjC6OjMJBso+HFftng2Y/he
        /8hKJmSFQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hgreu-0000wl-B2; Fri, 28 Jun 2019 14:15:24 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 69AF620215B79; Fri, 28 Jun 2019 16:15:22 +0200 (CEST)
Date:   Fri, 28 Jun 2019 16:15:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Scott Wood <swood@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        rcu <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [RFC] Deadlock via recursive wakeup via RCU with threadirqs
Message-ID: <20190628141522.GF3402@hirez.programming.kicks-ass.net>
References: <20190627142436.GD215968@google.com>
 <20190627103455.01014276@gandalf.local.home>
 <20190627153031.GA249127@google.com>
 <20190627155506.GU26519@linux.ibm.com>
 <CAEXW_YSEN_OL3ftTLN=M-W70WSuCgHJqU-R9VhS=A3uVj_AL+A@mail.gmail.com>
 <20190627173831.GW26519@linux.ibm.com>
 <20190627181638.GA209455@google.com>
 <20190627184107.GA26519@linux.ibm.com>
 <13761fee4b71cc004ad0d6709875ce917ff28fce.camel@redhat.com>
 <20190627203612.GD26519@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190627203612.GD26519@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 27, 2019 at 01:36:12PM -0700, Paul E. McKenney wrote:
> On Thu, Jun 27, 2019 at 03:17:27PM -0500, Scott Wood wrote:
> > On Thu, 2019-06-27 at 11:41 -0700, Paul E. McKenney wrote:
> > > On Thu, Jun 27, 2019 at 02:16:38PM -0400, Joel Fernandes wrote:
> > > > 
> > > > I think the fix should be to prevent the wake-up not based on whether we
> > > > are
> > > > in hard/soft-interrupt mode but that we are doing the rcu_read_unlock()
> > > > from
> > > > a scheduler path (if we can detect that)
> > > 
> > > Or just don't do the wakeup at all, if it comes to that.  I don't know
> > > of any way to determine whether rcu_read_unlock() is being called from
> > > the scheduler, but it has been some time since I asked Peter Zijlstra
> > > about that.
> > > 
> > > Of course, unconditionally refusing to do the wakeup might not be happy
> > > thing for NO_HZ_FULL kernels that don't implement IRQ work.
> > 
> > Couldn't smp_send_reschedule() be used instead?
> 
> Good point.  If current -rcu doesn't fix things for Sebastian's case,
> that would be well worth looking at.  But there must be some reason
> why Peter Zijlstra didn't suggest it when he instead suggested using
> the IRQ work approach.
> 
> Peter, thoughts?

I've not exactly kept up with the thread; but irq_work allows you to run
some actual code on the remote CPU which is often useful and it is only
a little more expensive than smp_send_reschedule().

Also, just smp_send_reschedule() doesn't really do anything without
first poking TIF_NEED_RESCHED (or other scheduler state) and if you want
to do both, there's other helpers you should use, like resched_cpu().


