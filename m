Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC5EBC0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 09:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90936208C4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 09:42:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FrxEHL1Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728465AbfGAJmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 05:42:52 -0400
Received: from merlin.infradead.org ([205.233.59.134]:33704 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727332AbfGAJmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 05:42:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=l8mrCiCp/0xRvJWtJijHHG/E/g8+XGDQbgPrBgivMT8=; b=FrxEHL1Z5IWGkU/zpXIKtrltQ
        7qDc2lmCOtOVGTRBysa9LaTqTjAf5CSuwuJHTiyxTtTE2ZBnyY5GTjfOMZMhZ5sBzNenKvu0TaU7n
        EaVGPR+JYI3PfdY/mskcKxrIXJD14ehMylRny7jvrbLyyL7+0aRWiS9/6TZp1B/dHtUmXpLFk1kg0
        e19275DQT6SxinPN4x1yHkBg3Uj18tPs50RFbjXsOL3yZpTmC34Aw6GZnP32hK7aFutcCLgwubTSR
        y/IyLp3ukjIv4w/vKJUdHKU++wtqe5f3JcQ/53AUvTNFrKwSvJjzAhnGmjpCzYRQBJqpzghcrhPKQ
        6RXVmO1jA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hhspF-0005HO-Ls; Mon, 01 Jul 2019 09:42:17 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 38D4F20A710F7; Mon,  1 Jul 2019 11:42:15 +0200 (CEST)
Date:   Mon, 1 Jul 2019 11:42:15 +0200
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
Message-ID: <20190701094215.GR3402@hirez.programming.kicks-ass.net>
References: <CAEXW_YSEN_OL3ftTLN=M-W70WSuCgHJqU-R9VhS=A3uVj_AL+A@mail.gmail.com>
 <20190627173831.GW26519@linux.ibm.com>
 <20190627181638.GA209455@google.com>
 <20190627184107.GA26519@linux.ibm.com>
 <13761fee4b71cc004ad0d6709875ce917ff28fce.camel@redhat.com>
 <20190627203612.GD26519@linux.ibm.com>
 <20190628141522.GF3402@hirez.programming.kicks-ass.net>
 <20190628155404.GV26519@linux.ibm.com>
 <20190628160408.GH32547@worktop.programming.kicks-ass.net>
 <20190628172056.GW26519@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190628172056.GW26519@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2019 at 10:20:56AM -0700, Paul E. McKenney wrote:
> On Fri, Jun 28, 2019 at 06:04:08PM +0200, Peter Zijlstra wrote:
> > On Fri, Jun 28, 2019 at 08:54:04AM -0700, Paul E. McKenney wrote:
> > > Thank you!  Plus it looks like scheduler_ipi() takes an early exit if
> > > ->wake_list is empty, regardless of TIF_NEED_RESCHED, right?
> > 
> > Yes, TIF_NEED_RESCHED is checked in the interrupt return path.
> 
> OK, got it.  So the following sequence would be a valid way to get the
> scheduler's attention on the current CPU shortly after interrupts
> are re-enabled, even if the current CPU is already holding some
> rq or pi locks, correct?
> 
> 	set_tsk_need_resched(current);
> 	set_preempt_need_resched();
> 	smp_send_reschedule(smp_processor_id());

I'm not sure if smp_send_reschedule() can be used as self-IPI, some
hardware doesn't particularly like that IIRC. That is, hardware might
only have interfaces to IPI _other_ CPUs, but not self.

The normal scheduler code takes care to not call smp_send_reschedule()
to self.
