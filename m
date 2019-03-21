Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90572C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 08:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 605D7218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 08:27:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbfCUI1m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 04:27:42 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:37283 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727881AbfCUI1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 04:27:42 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1h6t33-0007FC-TW; Thu, 21 Mar 2019 09:27:38 +0100
Date:   Thu, 21 Mar 2019 09:27:37 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, tglx@linutronix.de,
        Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH v3] rcu: Allow to eliminate softirq processing from
 rcutree
Message-ID: <20190321082737.t5jhdyuartimamu2@linutronix.de>
References: <20190320154440.GA16332@linux.ibm.com>
 <20190320160547.s5lbeahr2y4jlzwt@linutronix.de>
 <20190320161500.GK4102@linux.ibm.com>
 <20190320163532.mr32oi53iaueuizw@linutronix.de>
 <20190320173001.GM4102@linux.ibm.com>
 <20190320175952.yh6yfy64vaiurszw@linutronix.de>
 <20190320181210.GO4102@linux.ibm.com>
 <20190320181435.x3qyutwqllmq5zbk@linutronix.de>
 <20190320211333.eq7pwxnte7la67ph@linutronix.de>
 <20190320234601.GQ4102@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190320234601.GQ4102@linux.ibm.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-03-20 16:46:01 [-0700], Paul E. McKenney wrote:
> Thank you!  I reverted v2 and applied this one with the same sort of
> update.  Testing is going well thus far aside from my failing to add
> the required "=0" after the rcutree.use_softirq.  I will probably not
> be the only one who will run afoul of this, so I updated the commit log
> and the documentation accordingly, as shown below.

perfect, thank you.

> 							Thanx, Paul
> 
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index f46b4af96ab9..b807204ffd83 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -629,7 +609,10 @@ static void rcu_read_unlock_special(struct task_struct *t)
>  		/* Need to defer quiescent state until everything is enabled. */
>  		if (irqs_were_disabled) {
>  			/* Enabling irqs does not reschedule, so... */
> -			raise_softirq_irqoff(RCU_SOFTIRQ);
> +			if (!use_softirq)

that exclamation mark needs to go :/

> +				raise_softirq_irqoff(RCU_SOFTIRQ);
> +			else
> +				invoke_rcu_core();
>  		} else {
>  			/* Enabling BH or preempt does reschedule, so... */
>  			set_tsk_need_resched(current);

Sebastian
