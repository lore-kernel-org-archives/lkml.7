Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC094C31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 21:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B476F20B7C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 21:36:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="oLqPhtdY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbfHIVgr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 17:36:47 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46589 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbfHIVgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 17:36:47 -0400
Received: by mail-pf1-f193.google.com with SMTP id c3so23565492pfa.13
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 14:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/aPM+dGjqbF/twu7tNDtqtaJN6yd/7yU4c7+a2/cJxw=;
        b=oLqPhtdYAogfpwokAq0y9xZzUtFmKpJVD7GORU7Y4b6sAwR117XaTK37RJPo12PHgG
         qW5oZhdXQwmz8EjCib2Jicn1UEeY/E3wpbNYGGOsDL2BO+1m+vLZ0446PwAulggiJOUA
         0zL4giNtUJtQSiAlNsOGQC2p+AoSkGKRWBVLU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/aPM+dGjqbF/twu7tNDtqtaJN6yd/7yU4c7+a2/cJxw=;
        b=Bq6Ii5KRMChU8VLbhIz/wvXj9ln5UjC0ZnpWCWgSvEf41pV9nvTjm1haXCmEv1O9uI
         IDh44HjmZa2ujAzESZc7wSriH0EH71bUszhE5yT+rFNYcSrI0HungzaWGXENODcHT0Eq
         hRR79q0Wej0Cpl23guNRQ9Y7s45HQXmC0IKWoYLb195cjgVctirdXIE3NAmpdSp/XvS2
         Nxx1e41FQR08D6UKDccPdC7fHW51aCGcT6TlfW/YftbvfwBW3MlHkafMUXS3YZniugOy
         ICQUtabveUqvL8I2ldkGT+WXJM8wyqT84Jic+e4Ktf8Ge6wQ4rpeqGAonOmTT91ML46C
         ZSCA==
X-Gm-Message-State: APjAAAUwGYyYFs/j2UwukJs28HiZgny26mPPLD73sc/nSYMMxFhCMYJ+
        +HY55f9h+qE/nHwb0vxtw8gW7w==
X-Google-Smtp-Source: APXvYqyhTj+wnZ2r/4zniW+vG+t30nHJkSlUrAs/aUpsNA6Acpb/Z+cqyKSnfKeMhAu4WJlr1McazA==
X-Received: by 2002:a62:3895:: with SMTP id f143mr23417327pfa.116.1565386605846;
        Fri, 09 Aug 2019 14:36:45 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id a10sm5050392pfl.159.2019.08.09.14.36.44
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 09 Aug 2019 14:36:45 -0700 (PDT)
Date:   Fri, 9 Aug 2019 17:36:43 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Byungchul Park <byungchul.park@lge.com>,
        linux-kernel@vger.kernel.org, Rao Shoaib <rao.shoaib@oracle.com>,
        max.byungchul.park@gmail.com, kernel-team@android.com,
        kernel-team@lge.com, Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RFC v1 1/2] rcu/tree: Add basic support for kfree_rcu
 batching
Message-ID: <20190809213643.GG255533@google.com>
References: <20190807094504.GB169551@google.com>
 <20190807175215.GE28441@linux.ibm.com>
 <20190808095232.GA30401@X58A-UD3R>
 <20190808125607.GB261256@google.com>
 <20190808233014.GA184373@google.com>
 <20190809151619.GD28441@linux.ibm.com>
 <20190809153924.GB211412@google.com>
 <20190809163346.GF28441@linux.ibm.com>
 <20190809202226.GC255533@google.com>
 <20190809204217.GN28441@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190809204217.GN28441@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 09, 2019 at 01:42:17PM -0700, Paul E. McKenney wrote:
> > Also, I can go back to 500M if I just keep KFREE_DRAIN_JIFFIES at HZ/50. So I
> > am quite happy about that. I think I can declare that the "let list grow
> > indefinitely" design works quite well even with an insanely heavily loaded
> > case of every CPU in a 16CPU system with 500M memory, indefinitely doing
> > kfree_rcu()in a tight loop with appropriate cond_resched(). And I am like
> > thinking - wow how does this stuff even work at such insane scales :-D
> 
> A lot of work by a lot of people over a long period of time.  On their
> behalf, I thank you for the implied compliment.  So once this patch gets
> in, perhaps you will have complimented yourself as well.  ;-)
> 
> But more work is needed, and will continue to be as new workloads,
> compiler optimizations, and hardware appears.  And it would be good to
> try this on a really big system at some point.

Cool!

> > > > > o	Along with the above boot parameter, use "rcutree.use_softirq=0"
> > > > > 	to cause RCU to use kthreads instead of softirq.  (You might well
> > > > > 	find issues in priority setting as well, but might as well find
> > > > > 	them now if so!)
> > > > 
> > > > Doesn't think one actually reduce the priority of the core RCU work? softirq
> > > > will always have higher priority than any there. So wouldn't that have the
> > > > effect of not reclaiming things fast enough? (Or, in my case not scheduling
> > > > the rcu_work which does the reclaim).
> > > 
> > > For low kfree_rcu() loads, yes, it increases overhead due to the need
> > > for context switches instead of softirq running at the tail end of an
> > > interrupt.  But for high kfree_rcu() loads, it gets you realtime priority
> > > (in conjunction with "rcutree.kthread_prio=", that is).
> > 
> > I meant for high kfree_rcu() loads, a softirq context executing RCU callback
> > is still better from the point of view of the callback running because the
> > softirq will run above all else (higher than the highest priority task) so
> > use_softirq=0 would be a down grade from that perspective if something higher
> > than rcutree.kthread_prio is running on the CPU. So unless kthread_prio is
> > set to the highest prio, then softirq running would work better. Did I miss
> > something?
> 
> Under heavy load, softirq stops running at the tail end of interrupts and
> is instead run within the context of a per-CPU ksoftirqd kthread.  At normal
> SCHED_OTHER priority.

Ah, yes. Agreed!

> > > > > o	With any of the above, invoke rcu_momentary_dyntick_idle() along
> > > > > 	with cond_resched() in your kfree_rcu() loop.  This simulates
> > > > > 	a trip to userspace for nohz_full CPUs, so if this helps for
> > > > > 	non-nohz_full CPUs, adjustments to the kernel might be called for.
> > 
> > I did not try this yet. But I am thinking why would this help in nohz_idle
> > case? In nohz_idle we already have the tick active when CPU is idle. I guess
> > it is because there may be a long time that elapses before
> > rcu_data.rcu_need_heavy_qs == true ?
> 
> Under your heavy rcuperf load, none of the CPUs would ever be idle.  Nor
> would they every be in nohz_full userspace context, either.

Sorry I made a typo, I meant 'tick active when CPU is non-idle for NOHZ_IDLE
systems' above.

> In contrast, a heavy duty userspace-driven workload would transition to
> and from userspace for each kfree_rcu(), and that would increment the
> dyntick-idle count on each transition to and from userspace.  Adding the
> rcu_momentary_dyntick_idle() emulates a pair of such transitions.

But even if we're in kernel mode and not transitioning, I thought the FQS
loop (rcu_implicit_dynticks_qs() function) would set need_heavy_qs to true at
2 * jiffies_to_sched_qs.

Hmm, I forgot that jiffies_to_sched_qs can be quite large I guess. You're
right, we could call rcu_momentary_dyntick_idle() in advance before waiting
for FQS loop to do the setting of need_heavy_qs.

Or, am I missing something with the rcu_momentary_dyntick_idle() point you
made?

thanks,

 - Joel


> 
> 							Thanx, Paul
> 
> > > > Ok, will try it.
> > > > 
> > > > Save these bullet points for future reference! ;-)  thanks,
> > > 
> > > I guess this is helping me to prepare for Plumbers.  ;-)
> > 
> > :-)
> > 
> > thanks, Paul!
> > 
> >  - Joel
> > 
> 
