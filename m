Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3016BC5B579
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 19:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0190D208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 19:29:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="LtVR7QBO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbfF1T30 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 15:29:26 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35249 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbfF1T30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 15:29:26 -0400
Received: by mail-pl1-f194.google.com with SMTP id w24so3782471plp.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 12:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Hh7rxUwesW9kHyHoI29Fe2G8YeIM6SECUuA2SV2qpnc=;
        b=LtVR7QBOHZpCFxBpAaGPfkCN0pix92vR4RqOK/JwMbQdRwdP+36fFpY0fsb/3/DosY
         o8dqFBvHlkEviuoJLk/+txGWq4wUWJA/Ql5PVKMwNCvMBP0AOl4nbCqNuE1hZmsf+M/t
         uVkmFixyF4x5TKAXMyfA+/OhKD5MSR9Qqz2aY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Hh7rxUwesW9kHyHoI29Fe2G8YeIM6SECUuA2SV2qpnc=;
        b=EXN+jCMkzazSQjmzMFxfxxp0k5E9oTBF7F4+trOVq0nbyYoAlCHNABUH+n9x5LE7sx
         rI8/vBXmMip/eeQzDL4fGBQceIopRIXjGVCBWXnHRrTU/OWiVDzKdPtkLPOSjSvMp36V
         QCRls3Nh0IOOJTr5tROUEPUsdpAIp5A1d5+zkyY+OD+5baERN7KBQNtOUfykwJZnZ+VK
         qIz43XcY8onF9asuhGi1cMgS8xn98//oe/y+Y/JOHfcc3/ardwk87XHyH/ENCnEmqV05
         /qegE3O1mHVFuPadRWspfR7rzPWzdbU2chemxUTLJqEL/991KvLl17b2TvavFSByM0x/
         ewfg==
X-Gm-Message-State: APjAAAU9gH7MFHi+bmj/iNnQzc0M/s2XwINCrG9DpxTXiivtZuJTbXLz
        dR3lO10FAZC+eV33BelYZ7NW+A==
X-Google-Smtp-Source: APXvYqw/RAipZ7HKNtBiz+dKctZgmT9smvE1KKhJtbwSIXYuO2sFs2HqlA6T6EnnPy549whi8Ij2hw==
X-Received: by 2002:a17:902:f082:: with SMTP id go2mr14218583plb.25.1561750165328;
        Fri, 28 Jun 2019 12:29:25 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id j13sm3006904pfh.13.2019.06.28.12.29.24
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 28 Jun 2019 12:29:24 -0700 (PDT)
Date:   Fri, 28 Jun 2019 15:29:23 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        rcu <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [RFC] Deadlock via recursive wakeup via RCU with threadirqs
Message-ID: <20190628192923.GB89956@google.com>
References: <20190627155506.GU26519@linux.ibm.com>
 <CAEXW_YSEN_OL3ftTLN=M-W70WSuCgHJqU-R9VhS=A3uVj_AL+A@mail.gmail.com>
 <20190627173831.GW26519@linux.ibm.com>
 <20190627181638.GA209455@google.com>
 <20190627184107.GA26519@linux.ibm.com>
 <20190628164008.GB240964@google.com>
 <20190628164559.GC240964@google.com>
 <20190628173011.GX26519@linux.ibm.com>
 <20190628174545.pwgwi3wxl2eapkvm@linutronix.de>
 <20190628182216.GY26519@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190628182216.GY26519@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2019 at 11:22:16AM -0700, Paul E. McKenney wrote:
> On Fri, Jun 28, 2019 at 07:45:45PM +0200, Sebastian Andrzej Siewior wrote:
> > On 2019-06-28 10:30:11 [-0700], Paul E. McKenney wrote:
> > > > I believe the .blocked field remains set even though we are not any more in a
> > > > reader section because of deferred processing of the blocked lists that you
> > > > mentioned yesterday.
> > > 
> > > That can indeed happen.  However, in current -rcu, that would mean
> > > that .deferred_qs is also set, which (if in_irq()) would prevent
> > > the raise_softirq_irqsoff() from being invoked.  Which was why I was
> > > asking the questions about whether in_irq() returns true within threaded
> > > interrupts yesterday.  If it does, I need to find if there is some way
> > > of determining whether rcu_read_unlock_special() is being called from
> > > a threaded interrupt in order to suppress the call to raise_softirq()
> > > in that case.
> > 
> > Please not that:
> > | void irq_exit(void)
> > | {
> > |…
> > in_irq() returns true
> > |         preempt_count_sub(HARDIRQ_OFFSET);
> > in_irq() returns false
> > |         if (!in_interrupt() && local_softirq_pending())
> > |                 invoke_softirq();
> > 
> > -> invoke_softirq() does
> > |        if (!force_irqthreads) {
> > |                 __do_softirq();
> > |         } else {
> > |                 wakeup_softirqd();
> > |         }
> > 
> > so for `force_irqthreads' rcu_read_unlock_special() within
> > wakeup_softirqd() will see false.
> 
> OK, fair point.  How about the following instead, again on -rcu?
> 
> Here is the rationale for the new version of the "if" statement:
> 
> 1.	irqs_were_disabled:  If interrupts are enabled, we should
> 	instead let the upcoming irq_enable()/local_bh_enable()
> 	do the rescheduling for us.
> 2.	use_softirq: If we aren't using softirq, then
> 	raise_softirq_irqoff() will be unhelpful.
> 3a.	in_interrupt(): If this returns true, the subsequent
> 	call to raise_softirq_irqoff() is guaranteed not to
> 	do a wakeup, so that call will be both very cheap and
> 	quite safe.
> 3b.	Otherwise, if !in_interrupt(), if exp (an expedited RCU grace
> 	period is being blocked), then incurring wakeup overhead
> 	is worthwhile, and if also !.deferred_qs then scheduler locks
> 	cannot be held so the wakeup will be safe.
> 
> Does that make more sense?

This makes a lot of sense. It would be nice to stick these comments on top of
rcu_read_unlock_special() for future reference.

thanks,

 - Joel


> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index 82c925df1d92..83333cfe8707 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -624,8 +624,9 @@ static void rcu_read_unlock_special(struct task_struct *t)
>  		      (rdp->grpmask & rnp->expmask) ||
>  		      tick_nohz_full_cpu(rdp->cpu);
>  		// Need to defer quiescent state until everything is enabled.
> -		if ((exp || in_irq()) && irqs_were_disabled && use_softirq &&
> -		    (in_irq() || !t->rcu_read_unlock_special.b.deferred_qs)) {
> +		if (irqs_were_disabled && use_softirq &&
> +		    (in_interrupt() ||
> +		     (exp && !t->rcu_read_unlock_special.b.deferred_qs))) {
>  			// Using softirq, safe to awaken, and we get
>  			// no help from enabling irqs, unlike bh/preempt.
>  			raise_softirq_irqoff(RCU_SOFTIRQ);
> 
