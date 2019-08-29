Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF98C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 22:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A466121726
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 22:23:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="Z8UYs6V0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728288AbfH2WXY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 18:23:24 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40610 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727912AbfH2WXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 18:23:23 -0400
Received: by mail-pf1-f193.google.com with SMTP id w16so3066091pfn.7
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 15:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iwgSPC5+ukBlrbIQeB/N8VAwP9kt6jHmPxRFKIIZNR4=;
        b=Z8UYs6V0qLG6rtyI7XKUacTn6lq1O1s+qRW37pkFtf3HmBqyzG/3NUc8S6wlRAk6jk
         6AknBj9ZgutPaRnCKnMUF982f2AdraJNFRCyoYzu+e8F3HIgF7QFHDpPAOPw8kp29t6s
         wPpPXVB0IOvcZ7GgabjhVf91UPxq+3oyQZW54=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iwgSPC5+ukBlrbIQeB/N8VAwP9kt6jHmPxRFKIIZNR4=;
        b=PDil6XuaTpNDffXBVlcbvqjrnDceOx34FCj55z9koilZGGlAwZC88JBu1USlhDjsoX
         L4AoMm4HvAz7SzT+3M/vA+OT6aNaKcUVpuHiTsrJCRa9aslL8ricRDB1qFJqueNdxtyL
         5Szlbtuqjc70JoQh8DW3iiW6Wa3FcgURYL1qbZDbyecfybiJhiHcv8ImcK0qjFfDePx7
         pVAmpw5OX3gidFrKDiLIiVZ/enNB1uQcYsoVZB5ELE65iuXP1j/k9qoM5WaVB1TdsLfA
         Q9XOR624EB3jGmcX2/90zjqFA75ahUmizstk69+WBUg1lRBK0ttcReedE9UUKXgCeozE
         jCTQ==
X-Gm-Message-State: APjAAAWwxgHkRHFL5iAMFdafCPQCN5noS/EN0ujb+1VAtxbg3L4LOXp/
        iydEj5E9F8MwiL/3CdIZnx8ydw==
X-Google-Smtp-Source: APXvYqwdEpxbHLpvww66IXQ+B+uwz1uKbVSfStxpcuTJ8OaCz61p1uvV8f7k6aUClGl3k9U+7M30iA==
X-Received: by 2002:a65:638c:: with SMTP id h12mr10218799pgv.436.1567117402248;
        Thu, 29 Aug 2019 15:23:22 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id e9sm3541022pja.17.2019.08.29.15.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 15:23:21 -0700 (PDT)
Date:   Thu, 29 Aug 2019 18:23:20 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, byungchul.park@lge.com,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        kernel-team@android.com
Subject: Re: [PATCH 5/5] rcu: Remove kfree_call_rcu_nobatch()
Message-ID: <20190829222320.GC183862@google.com>
References: <5d657e3b.1c69fb81.54250.01e2@mx.google.com>
 <20190828215636.GA26530@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828215636.GA26530@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

I think this is the only contentious patch preventing my resend of the
series, let me know what you think, I replied below:

On Wed, Aug 28, 2019 at 02:56:36PM -0700, Paul E. McKenney wrote:
> On Tue, Aug 27, 2019 at 03:01:59PM -0400, Joel Fernandes (Google) wrote:
[snip]
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 12c17e10f2b4..c767973d62ac 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -2777,8 +2777,10 @@ static void kfree_rcu_work(struct work_struct *work)
> >  		rcu_lock_acquire(&rcu_callback_map);
> >  		trace_rcu_invoke_kfree_callback(rcu_state.name, head, offset);
> >  
> > -		/* Could be possible to optimize with kfree_bulk in future */
> > -		kfree((void *)head - offset);
> > +		if (!WARN_ON_ONCE(!__is_kfree_rcu_offset(offset))) {
> > +			/* Could be optimized with kfree_bulk() in future. */
> > +			kfree((void *)head - offset);
> > +		}
> 
> This really needs to be in the previous patch until such time as Tiny RCU
> no longer needs the restriction.

I was only going by whatever is already committed to the -rcu dev branch. The
series is based on the -dev branch.

The original patch adding the kfree_rcu() batching is already merged into the
-rcu dev branch (that version just had 1 list, this series adds multiple
lists).

In the above diff, I just added the WARN_ON_ONCE() as extra checking for tree
RCU kfree batching. It has nothing to do with tiny RCU per-se. Should I
submit the WARN_ON_ONCE() as a separate patch then?

To prevent confusion, could you let me know if I am supposed to submitting
patches against a branch other than the dev branch?

> >  		rcu_lock_release(&rcu_callback_map);
> >  		cond_resched_tasks_rcu_qs();
> > @@ -2856,16 +2858,6 @@ static void kfree_rcu_monitor(struct work_struct *work)
> >  		spin_unlock_irqrestore(&krcp->lock, flags);
> >  }
> >  
> > -/*
> > - * This version of kfree_call_rcu does not do batching of kfree_rcu() requests.
> > - * Used only by rcuperf torture test for comparison with kfree_rcu_batch().
> > - */
> > -void kfree_call_rcu_nobatch(struct rcu_head *head, rcu_callback_t func)
> > -{
> > -	__call_rcu(head, func);
> > -}
> > -EXPORT_SYMBOL_GPL(kfree_call_rcu_nobatch);
> > -
> >  /*
> >   * Queue a request for lazy invocation of kfree() after a grace period.
> >   *
> > @@ -2885,12 +2877,6 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> >  	unsigned long flags;
> >  	struct kfree_rcu_cpu *krcp;
> >  
> > -	/* kfree_call_rcu() batching requires timers to be up. If the scheduler
> > -	 * is not yet up, just skip batching and do the non-batched version.
> > -	 */
> > -	if (rcu_scheduler_active != RCU_SCHEDULER_RUNNING)
> > -		return kfree_call_rcu_nobatch(head, func);
> > -
> >  	if (debug_rcu_head_queue(head)) {
> >  		/* Probable double kfree_rcu() */
> >  		WARN_ONCE(1, "kfree_call_rcu(): Double-freed call. rcu_head %p\n",
> > @@ -2909,8 +2895,15 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> >  	krcp->head = head;
> >  
> >  	/* Schedule monitor for timely drain after KFREE_DRAIN_JIFFIES. */
> > -	if (!xchg(&krcp->monitor_todo, true))
> > -		schedule_delayed_work(&krcp->monitor_work, KFREE_DRAIN_JIFFIES);
> > +	if (!xchg(&krcp->monitor_todo, true)) {
> > +		/* Scheduling the monitor requires scheduler/timers to be up,
> > +		 * if it is not, just skip it. An eventual kfree_rcu() will
> > +		 * kick it again.
> > +		 */
> > +		if ((rcu_scheduler_active == RCU_SCHEDULER_RUNNING)) {
> > +			schedule_delayed_work(&krcp->monitor_work, KFREE_DRAIN_JIFFIES);
> > +		}
> > +	}
> 
> And this also needs to be in an earlier patch.  Bisectability and all that!
> 
> Are we really guaranteed that there will be an eventual kfree_rcu()?
> More of a worry for Tiny RCU than for Tree RCU, but still could be
> annoying for someone trying to debug a memory leak.

Same comment as above, the original patch adding the schedule_delayed_work()
is already merged into the -dev branch. This series is based on top of that.
The reason I had to rearrange &krcp->monitor_todo code above is because we no
longer have kfree_rcu_no_batch() which this patch removes.

thanks,

 - Joel


