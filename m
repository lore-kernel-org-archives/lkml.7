Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 362C9C3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 00:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 033EE22CF8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 00:46:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="jrf17TSZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbfIDAq3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 20:46:29 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40722 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbfIDAq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 20:46:28 -0400
Received: by mail-pf1-f194.google.com with SMTP id w16so12052498pfn.7
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 17:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IRRqhH2tyZ7+XB/z8/zEf8laZnPNNt4IgLHMJO+UON0=;
        b=jrf17TSZAfr6GajhdyMbxXuqUcsdG3afXUIQ1hdQdp/TdEP7c1uP45aWwjmTzVTleq
         WDcNMrxctNwzJWsiYhX74ANd3D7dtvYq/IhDSp59cCbGoZobD84E2YRJMWYlH6Cgn45K
         muIg4ItTUidTQKKNWeqQbK/b8Ezygu+qWyNig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IRRqhH2tyZ7+XB/z8/zEf8laZnPNNt4IgLHMJO+UON0=;
        b=SkSNHz/6ZsDjnnHr/VkN07UqIVkkDQq5g6L4CEYYPYf5q1FnCn/ucVZ2tqQ0PPwEpC
         0lXw3jam4xXjgxIR8p6F3gcExv771h4ff6yMIu8emqFmLIZnzjeiSL8cpBhPLgVW5LFy
         YzNTDQ+cNSI5sAESDsV1mNDQPjC8urstM8l5ujmkPwB7Oj5CPj3wX+1Jwq0iVuchzwEP
         +SpFdPA8pUtrqrxzldOVZu4Y3B++Fh7MmrPI2s79ttQ5O0JWZG3Dr5iYzpGiZAn3VRKn
         okkIygvl0anMyWRb6sst8txAQYZU1gp4SQSmXR2kHMqdjNaQOs+wl4QrMzAadrCXfzBt
         0xaw==
X-Gm-Message-State: APjAAAXNSv4fWZ6+/UFrWrEDjpgyeWSvQ+DhoaVh3KiHtXxyeauLJ2eK
        WBiXXekjH8hPQic/3d00YYS+lA==
X-Google-Smtp-Source: APXvYqzCRYJf4WcESg8CeoZ2+KW8jWjiw0OZbT+HsvUrQgz11IU9JeweAy0YPnrOxhNNVpahRpJlBA==
X-Received: by 2002:aa7:955d:: with SMTP id w29mr224378pfq.60.1567557987991;
        Tue, 03 Sep 2019 17:46:27 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id w21sm696504pjh.19.2019.09.03.17.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 17:46:27 -0700 (PDT)
Date:   Tue, 3 Sep 2019 20:46:26 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Petr Mladek <pmladek@suse.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [PATCH -rcu dev 2/2] rcu/dyntick-idle: Add better tracing
Message-ID: <20190904004626.GB127034@google.com>
References: <20190830162348.192303-1-joel@joelfernandes.org>
 <20190830162348.192303-2-joel@joelfernandes.org>
 <20190903200446.GE4125@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903200446.GE4125@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2019 at 01:04:46PM -0700, Paul E. McKenney wrote:
> On Fri, Aug 30, 2019 at 12:23:48PM -0400, Joel Fernandes (Google) wrote:
> > The dyntick-idle traces are a bit confusing. This patch makes it simpler
> > and adds some missing cases such as EQS-enter due to user vs idle mode.
> > 
> > Following are the changes:
> > (1) Add a new context field to trace_rcu_dyntick tracepoint. This
> >     context field can be "USER", "IDLE" or "IRQ".
> > 
> > (2) Remove the "++=" and "--=" strings and replace them with
> >    "StillNonIdle". This is much easier on the eyes, and the -- and ++
> >    are easily apparent in the dynticks_nesting counters we are printing
> >    anyway.
> > 
> > This patch is based on the previous patches to simplify rcu_dyntick
> > counters [1] and with these traces, I have verified the counters are
> > working properly.
> > 
> > [1]
> > Link: https://lore.kernel.org/patchwork/patch/1120021/
> > Link: https://lore.kernel.org/patchwork/patch/1120022/
> > 
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
> This looks fine, but depends on the earlier patch.

The earlier patch looks Ok? Did not see any review comments. That is just a
revert of an old commit.

thanks,

 - Joel

> 							Thanx, Paul
> 
> > ---
> >  include/trace/events/rcu.h | 13 ++++++++-----
> >  kernel/rcu/tree.c          | 19 +++++++++++++------
> >  2 files changed, 21 insertions(+), 11 deletions(-)
> > 
> > diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
> > index 66122602bd08..474c1f7e7104 100644
> > --- a/include/trace/events/rcu.h
> > +++ b/include/trace/events/rcu.h
> > @@ -449,12 +449,14 @@ TRACE_EVENT_RCU(rcu_fqs,
> >   */
> >  TRACE_EVENT_RCU(rcu_dyntick,
> >  
> > -	TP_PROTO(const char *polarity, long oldnesting, long newnesting, atomic_t dynticks),
> > +	TP_PROTO(const char *polarity, const char *context, long oldnesting,
> > +		 long newnesting, atomic_t dynticks),
> >  
> > -	TP_ARGS(polarity, oldnesting, newnesting, dynticks),
> > +	TP_ARGS(polarity, context, oldnesting, newnesting, dynticks),
> >  
> >  	TP_STRUCT__entry(
> >  		__field(const char *, polarity)
> > +		__field(const char *, context)
> >  		__field(long, oldnesting)
> >  		__field(long, newnesting)
> >  		__field(int, dynticks)
> > @@ -462,14 +464,15 @@ TRACE_EVENT_RCU(rcu_dyntick,
> >  
> >  	TP_fast_assign(
> >  		__entry->polarity = polarity;
> > +		__entry->context = context;
> >  		__entry->oldnesting = oldnesting;
> >  		__entry->newnesting = newnesting;
> >  		__entry->dynticks = atomic_read(&dynticks);
> >  	),
> >  
> > -	TP_printk("%s %lx %lx %#3x", __entry->polarity,
> > -		  __entry->oldnesting, __entry->newnesting,
> > -		  __entry->dynticks & 0xfff)
> > +	TP_printk("%s %s %lx %lx %#3x", __entry->polarity,
> > +		__entry->context, __entry->oldnesting, __entry->newnesting,
> > +		__entry->dynticks & 0xfff)
> >  );
> >  
> >  /*
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 417dd00b9e87..463407762b5a 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -533,7 +533,8 @@ static void rcu_eqs_enter(bool user)
> >  	}
> >  
> >  	lockdep_assert_irqs_disabled();
> > -	trace_rcu_dyntick(TPS("Start"), rdp->dynticks_nesting, 0, rdp->dynticks);
> > +	trace_rcu_dyntick(TPS("Start"), (user ? TPS("USER") : TPS("IDLE")),
> > +			  rdp->dynticks_nesting, 0, rdp->dynticks);
> >  	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !user && !is_idle_task(current));
> >  	rdp = this_cpu_ptr(&rcu_data);
> >  	do_nocb_deferred_wakeup(rdp);
> > @@ -606,14 +607,17 @@ static __always_inline void rcu_nmi_exit_common(bool irq)
> >  	 * leave it in non-RCU-idle state.
> >  	 */
> >  	if (rdp->dynticks_nmi_nesting != 1) {
> > -		trace_rcu_dyntick(TPS("--="), rdp->dynticks_nmi_nesting, rdp->dynticks_nmi_nesting - 2, rdp->dynticks);
> > +		trace_rcu_dyntick(TPS("StillNonIdle"), TPS("IRQ"),
> > +				  rdp->dynticks_nmi_nesting,
> > +				  rdp->dynticks_nmi_nesting - 2, rdp->dynticks);
> >  		WRITE_ONCE(rdp->dynticks_nmi_nesting, /* No store tearing. */
> >  			   rdp->dynticks_nmi_nesting - 2);
> >  		return;
> >  	}
> >  
> >  	/* This NMI interrupted an RCU-idle CPU, restore RCU-idleness. */
> > -	trace_rcu_dyntick(TPS("Startirq"), rdp->dynticks_nmi_nesting, 0, rdp->dynticks);
> > +	trace_rcu_dyntick(TPS("Start"), TPS("IRQ"), rdp->dynticks_nmi_nesting,
> > +			  0, rdp->dynticks);
> >  	WRITE_ONCE(rdp->dynticks_nmi_nesting, 0); /* Avoid store tearing. */
> >  
> >  	if (irq)
> > @@ -700,7 +704,8 @@ static void rcu_eqs_exit(bool user)
> >  	rcu_dynticks_task_exit();
> >  	rcu_dynticks_eqs_exit();
> >  	rcu_cleanup_after_idle();
> > -	trace_rcu_dyntick(TPS("End"), rdp->dynticks_nesting, 1, rdp->dynticks);
> > +	trace_rcu_dyntick(TPS("End"), (user ? TPS("USER") : TPS("IDLE")),
> > +			  rdp->dynticks_nesting, 1, rdp->dynticks);
> >  	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !user && !is_idle_task(current));
> >  	WRITE_ONCE(rdp->dynticks_nesting, 1);
> >  	WARN_ON_ONCE(rdp->dynticks_nmi_nesting);
> > @@ -787,9 +792,11 @@ static __always_inline void rcu_nmi_enter_common(bool irq)
> >  		rdp->rcu_forced_tick = true;
> >  		tick_dep_set_cpu(rdp->cpu, TICK_DEP_BIT_RCU);
> >  	}
> > -	trace_rcu_dyntick(incby == 1 ? TPS("Endirq") : TPS("++="),
> > -			  rdp->dynticks_nmi_nesting,
> > +
> > +	trace_rcu_dyntick(incby == 1 ? TPS("End") : TPS("StillNonIdle"),
> > +			  TPS("IRQ"), rdp->dynticks_nmi_nesting,
> >  			  rdp->dynticks_nmi_nesting + incby, rdp->dynticks);
> > +
> >  	WRITE_ONCE(rdp->dynticks_nmi_nesting, /* Prevent store tearing. */
> >  		   rdp->dynticks_nmi_nesting + incby);
> >  	barrier();
> > -- 
> > 2.23.0.187.g17f5b7556c-goog
> > 
