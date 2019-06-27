Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81265C48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 14:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D5D72086D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 14:35:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbfF0Oe7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 10:34:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:36390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726465AbfF0Oe6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 10:34:58 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3653A20828;
        Thu, 27 Jun 2019 14:34:57 +0000 (UTC)
Date:   Thu, 27 Jun 2019 10:34:55 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [RFC] Deadlock via recursive wakeup via RCU with threadirqs
Message-ID: <20190627103455.01014276@gandalf.local.home>
In-Reply-To: <20190627142436.GD215968@google.com>
References: <20190626135447.y24mvfuid5fifwjc@linutronix.de>
        <20190626162558.GY26519@linux.ibm.com>
        <20190627142436.GD215968@google.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jun 2019 10:24:36 -0400
Joel Fernandes <joel@joelfernandes.org> wrote:

> > What am I missing here?  
> 
> This issue I think is
> 
> (in normal process context)
> spin_lock_irqsave(rq_lock); // which disables both preemption and interrupt
> 			   // but this was done in normal process context,
> 			   // not from IRQ handler
> rcu_read_lock();
>           <---------- IPI comes in and sets exp_hint

How would an IPI come in here with interrupts disabled?

-- Steve

> rcu_read_unlock()
>    -> rcu_read_unlock_special
>         -> raise_softirq_irqoff
> 	    -> wakeup_softirq  <--- because in_interrupt returns false.  
> 
> I think the issue is in_interrupt() does not know about threaded interrupts.
> If it did, then the ksoftirqd wake up would not happen.
> 
> Did I get something wrong?

