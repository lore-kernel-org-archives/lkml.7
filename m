Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87325C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 10:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FB5821E6E
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 10:22:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="cgldBAAq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728449AbfHGKWR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 06:22:17 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37882 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727012AbfHGKWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 06:22:16 -0400
Received: by mail-pl1-f193.google.com with SMTP id b3so40155285plr.4
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 03:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5pKCbAR3l6bvIBJXDcKPzlpm5S/RS8kN0F54s+uDdU8=;
        b=cgldBAAqs3U+Fb21g1kXtoTqxjoP9OTnXgX1HybFVnEKDAlz3uIkIRS755GDcdnVtN
         bQBu7B6B0/WWrpXpH0zQpCO/jpueCtpBtPQZeYFqiiI5egtdFh9Td/dUbd0cmut/HtMp
         wOpr6OU6a/9AGdpBSDaPq9lzWP32/fOwvrdsI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5pKCbAR3l6bvIBJXDcKPzlpm5S/RS8kN0F54s+uDdU8=;
        b=i1awu2YwdQ09pZmH3UUaa7os5u1LXgnyWMyUAuLi9LIBVeVAc7vJbDi+WifJce5wVp
         UpZNjLceOm7PCFEELYI1Lu5ewiYyodl2WSjthldeuG0puY7dnAGG6TtqU83DpZnklgCD
         mkA1/C2BEL1ptoWePwvBHzNA1TRjKhuFKEiotL2folDOc/JvtqgFDPzLV/c0q0DA5xU5
         ceeGh56G62T0tD8tPwxjRtggGyO9ZqYjSIONnz7jDnRtUyrOaA56ELN2lWPsmCkIJ3mQ
         u1PCV8SZJrJrZsEQvFP2uUU4NRnk0s8lQaIlf6R2Lj+qEHedX5VzIMldLzFA2ueK7jg1
         gU7w==
X-Gm-Message-State: APjAAAUxEauWywzuaX07HDtkfcCbb0LCCIE2rWhkkfa7YkXvYWwIkQsi
        NC+40wxyufvWQoSzNDxBsZM5dg==
X-Google-Smtp-Source: APXvYqxkAKdXaH02KtpWhXjwVrqHxHh8h78EaGR7CFaGu7+FC+YXn1G47I4J0pNpHDOZj0+hi4WQzg==
X-Received: by 2002:a17:902:2aa8:: with SMTP id j37mr7160037plb.316.1565173335700;
        Wed, 07 Aug 2019 03:22:15 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id a3sm100521186pfl.145.2019.08.07.03.22.14
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 07 Aug 2019 03:22:14 -0700 (PDT)
Date:   Wed, 7 Aug 2019 06:22:13 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, max.byungchul.park@gmail.com,
        byungchul.park@lge.com, Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>, kernel-team@android.com,
        kernel-team@lge.com, Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Rao Shoaib <rao.shoaib@oracle.com>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RFC v1 2/2] rcuperf: Add kfree_rcu performance Tests
Message-ID: <20190807102213.GD169551@google.com>
References: <20190806212041.118146-1-joel@joelfernandes.org>
 <20190806212041.118146-2-joel@joelfernandes.org>
 <20190807002915.GV28441@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190807002915.GV28441@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2019 at 05:29:15PM -0700, Paul E. McKenney wrote:
> On Tue, Aug 06, 2019 at 05:20:41PM -0400, Joel Fernandes (Google) wrote:
> > This test runs kfree_rcu in a loop to measure performance of the new
> > kfree_rcu, with and without patch.
> > 
> > To see improvement, run with boot parameters:
> > rcuperf.kfree_loops=2000 rcuperf.kfree_alloc_num=100 rcuperf.perf_type=kfree
> > 
> > Without patch, test runs in 6.9 seconds.
> > With patch, test runs in 6.1 seconds (+13% improvement)
> > 
> > If it is desired to run the test but with the traditional (non-batched)
> > kfree_rcu, for example to compare results, then you could pass along the
> > rcuperf.kfree_no_batch=1 boot parameter.
> 
> You lost me on this one.  You ran two runs, with rcuperf.kfree_no_batch=1
> and without?  Or you ran this patch both with and without the earlier
> patch, and could have run with the patch and rcuperf.kfree_no_batch=1?

I always run the rcutorture test with patch because the patch doesn't really
do anything if rcuperf.kfree_no_batch=0. This parameter is added so that in
the future folks can compare effect of non-batching with that of the
batching. However, I can also remove the patch itself and run this test
again.

> If the latter, it would be good to try all three.

Ok, sure.

[snip] 
> > ---
> >  kernel/rcu/rcuperf.c | 169 ++++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 168 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/rcu/rcuperf.c b/kernel/rcu/rcuperf.c
> > index 7a6890b23c5f..34658760da5e 100644
> > --- a/kernel/rcu/rcuperf.c
> > +++ b/kernel/rcu/rcuperf.c
> > @@ -89,7 +89,7 @@ torture_param(int, writer_holdoff, 0, "Holdoff (us) between GPs, zero to disable
> >  
> >  static char *perf_type = "rcu";
> >  module_param(perf_type, charp, 0444);
> > -MODULE_PARM_DESC(perf_type, "Type of RCU to performance-test (rcu, rcu_bh, ...)");
> > +MODULE_PARM_DESC(perf_type, "Type of RCU to performance-test (rcu, rcu_bh, kfree,...)");
> >  
> >  static int nrealreaders;
> >  static int nrealwriters;
> > @@ -592,6 +592,170 @@ rcu_perf_shutdown(void *arg)
> >  	return -EINVAL;
> >  }
> >  
> > +/*
> > + * kfree_rcu performance tests: Start a kfree_rcu loop on all CPUs for number
> > + * of iterations and measure total time for all iterations to complete.
> > + */
> > +
> > +torture_param(int, kfree_nthreads, -1, "Number of RCU reader threads");
> > +torture_param(int, kfree_alloc_num, 8000, "Number of allocations and frees done by a thread");
> > +torture_param(int, kfree_alloc_size, 16,  "Size of each allocation");
> 
> Is this used?  How does it relate to KFREE_OBJ_BYTES?

You're right, I had added this before but it is unused now. Sorry about that,
I will remove it.

> > +torture_param(int, kfree_loops, 10, "Size of each allocation");
> 
> I suspect that this kfree_loops string is out of date.

Yes, complete screw up, will update it.

> > +torture_param(int, kfree_no_batch, 0, "Use the non-batching (slower) version of kfree_rcu");
> 
> All of these need to be added to kernel-parameters.txt.  Along with
> any added by the earlier patch, for that matter.

Sure, should I split that into a separate patch?

> > +static struct task_struct **kfree_reader_tasks;
> > +static int kfree_nrealthreads;
> > +static atomic_t n_kfree_perf_thread_started;
> > +static atomic_t n_kfree_perf_thread_ended;
> > +
> > +#define KFREE_OBJ_BYTES 8
> > +
> > +struct kfree_obj {
> > +	char kfree_obj[KFREE_OBJ_BYTES];
> > +	struct rcu_head rh;
> > +};
> > +
> > +void kfree_call_rcu_nobatch(struct rcu_head *head, rcu_callback_t func);
> > +
> > +static int
> > +kfree_perf_thread(void *arg)
> > +{
> > +	int i, l = 0;
> 
> It is really easy to confuse "l" and "1" in some fonts, so please use
> a different name.  (From the "showing my age" department:  On typical
> 1970s typewriters, there was no numeral "1" -- you typed the letter
> "l" instead, thus anticipating at least the first digit of "1337".)

:-D Ok, I will improve the names.

> > +	long me = (long)arg;
> > +	struct kfree_obj **alloc_ptrs;
> > +	u64 start_time, end_time;
> > +
> > +	VERBOSE_PERFOUT_STRING("kfree_perf_thread task started");
> > +	set_cpus_allowed_ptr(current, cpumask_of(me % nr_cpu_ids));
> > +	set_user_nice(current, MAX_NICE);
> > +	atomic_inc(&n_kfree_perf_thread_started);
> > +
> > +	alloc_ptrs = (struct kfree_obj **)kmalloc(sizeof(struct kfree_obj *) * kfree_alloc_num,
> > +						  GFP_KERNEL);
> > +	if (!alloc_ptrs)
> > +		return -ENOMEM;
> > +
> > +	start_time = ktime_get_mono_fast_ns();
> 
> Don't you want to announce that you started here rather than above in
> order to avoid (admittedly slight) measurement inaccuracies?

I did not follow, are you referring to the measurement inaccuracy related to
the "kfree_perf_thread task started" string print?  Or, are you saying that
ktime_get_mono_fast_ns() has to start earlier than over here?

> > +	do {
> > +		for (i = 0; i < kfree_alloc_num; i++) {
> > +			alloc_ptrs[i] = kmalloc(sizeof(struct kfree_obj), GFP_KERNEL);
> > +			if (!alloc_ptrs[i])
> > +				return -ENOMEM;
> > +		}
> > +
> > +		for (i = 0; i < kfree_alloc_num; i++) {
> > +			if (!kfree_no_batch) {
> > +				kfree_rcu(alloc_ptrs[i], rh);
> > +			} else {
> > +				rcu_callback_t cb;
> > +
> > +				cb = (rcu_callback_t)(unsigned long)offsetof(struct kfree_obj, rh);
> > +				kfree_call_rcu_nobatch(&(alloc_ptrs[i]->rh), cb);
> > +			}
> > +		}
> > +
> > +		schedule_timeout_uninterruptible(2);
> 
> Why the two-jiffy wait in the middle of a timed test?  Yes, you need
> a cond_resched() and maybe more here, but a two-jiffy wait?  I don't
> see how this has any chance of getting valid measurements.
> 
> What am I missing here?

I am getting pretty reliable and repeatable results with this test. The sleep
was mostly just to give the system a chance to scheduler other tasks. I can
remove the schedule and also try with just cond_resched().

The other reason for the schedule call was also to give the test a longer
running time and help with easier measurement as a result, since the test
would run otherwise for a very shortwhile. Agreed there might be a better way
to handle this issue.

(I will reply to the rest of the comments below in a bit, I am going to a
hospital now to visit a sick relative and will be back a bit later.)

thanks!

 - Joel

