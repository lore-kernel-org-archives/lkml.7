Return-Path: <SRS0=F9vw=WN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FAKE_REPLY_C,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB49C3A59D
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 01:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D55E2077C
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 01:04:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="ulMyjoKb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbfHQBEo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 21:04:44 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43965 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbfHQBEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 21:04:44 -0400
Received: by mail-pf1-f194.google.com with SMTP id v12so3960581pfn.10
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2019 18:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=dIMMehKYToB1MG0JkVksYloRIJr701b2wPO4u7S8P1A=;
        b=ulMyjoKb7Y1Po+CWHKzMW3sOhPqAwjsHDteluTf0xSAHKDqnaOgLTYuaSfCT9/XJ4Y
         9AOFG33i7Tx1vWgV/qiFYZrr3CznRUh3Fjv54FUmU062fk2v3X0KmSjNsdunl7fltiHK
         gdzDvevaqlHaI+a8YpniH7o1IhpQnxbmtGq6Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dIMMehKYToB1MG0JkVksYloRIJr701b2wPO4u7S8P1A=;
        b=eEwrCkJNN9kFf8AHGyNts3pQMi0G+Zgzs50gQCXAhgbG+jz5mT/DOxoNL730yyd1m/
         8z18hHYCzTN3gxOOrwOajnmdVtkpWVmsolmaIqy+IqrdAJLs0u/yw5GAd/EhmZwQhBIF
         ZwLtCkfSj30NWovQJBMQQhDTnubA/sDDW4Hc8HmNWtTNzNHmaVxFdEmZSu7T1uNmkte3
         p4r7ufPDzMIzP/D3FI2aSCB/u2HVKWGhpf8ZvXlzqvXtom6rQMYOI31VEJ0YBRh8bXLZ
         mOOCwV+Sbk7P/XSBEc9H6boCxzTV6f9YcYYPtIpzI3AUFK0RcRny0f/U7V5Dtz6E5tQg
         ZjwQ==
X-Gm-Message-State: APjAAAXVTUGIc1I4DuknyS0sZlRVV7hF5s1meub9cdRR97X0WZtTTO66
        fcRAuauJZZaa9OWfVTjknMl12w==
X-Google-Smtp-Source: APXvYqwrfnsN5jdqebeFEbj6h6d9hWEi5UjCHAip28DGgNyGBCmhFbqodp7mHZ0k6ZqO5vTskwlOGQ==
X-Received: by 2002:a63:484d:: with SMTP id x13mr9971571pgk.122.1566003882857;
        Fri, 16 Aug 2019 18:04:42 -0700 (PDT)
Received: from localhost ([172.19.216.18])
        by smtp.gmail.com with ESMTPSA id q8sm4747421pjq.20.2019.08.16.18.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2019 18:04:42 -0700 (PDT)
Date:   Fri, 16 Aug 2019 21:04:25 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     kbuild test robot <lkp@intel.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>, atishp04@gmail.com
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org
Subject: Re: [rcu:from-joel.2019.08.16a 143/172] kernel/rcu/tree.c:2808:6:
 note: in expansion of macro 'xchg'
Message-ID: <20190817010425.GA89926@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201908170558.4JoZrC3p%lkp@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 17, 2019 at 05:10:59AM +0800, kbuild test robot wrote:
> tree:   https://kernel.googlesource.com/pub/scm/linux/kernel/git/paulmck/linux-rcu.git from-joel.2019.08.16a
> head:   01b0e4d3e0ac279b295bc06a3591f0b810b9908f
> commit: bda80ba9decc7a32413e88d2f070de180c4b76ab [143/172] rcu/tree: Add basic support for kfree_rcu() batching
> config: riscv-defconfig (attached as .config)
> compiler: riscv64-linux-gcc (GCC) 7.4.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout bda80ba9decc7a32413e88d2f070de180c4b76ab
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.4.0 make.cross ARCH=riscv 

This seems to be a riscv issue:

A call to '__compiletime_assert_2792' declared with attribute error:
BUILD_BUG failed

Could riscv folks take a look at it? Why is using xchg() causing issues? The
xchg() is being done on a bool.

thanks,

 - Joel


> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All error/warnings (new ones prefixed by >>):
> 
>    In file included from arch/riscv/include/asm/atomic.h:19:0,
>                     from include/linux/atomic.h:7,
>                     from include/linux/spinlock.h:445,
>                     from kernel/rcu/tree.c:23:
>    kernel/rcu/tree.c: In function 'kfree_rcu_monitor':
> >> arch/riscv/include/asm/cmpxchg.h:140:2: warning: '__ret' is used uninitialized in this function [-Wuninitialized]
>      __ret;        \
>      ^~~~~
>    arch/riscv/include/asm/cmpxchg.h:121:21: note: '__ret' was declared here
>      __typeof__(*(ptr)) __ret;     \
>                         ^
> >> arch/riscv/include/asm/cmpxchg.h:146:23: note: in expansion of macro '__xchg'
>      (__typeof__(*(ptr))) __xchg((ptr), _x_, sizeof(*(ptr))); \
>                           ^~~~~~
> >> kernel/rcu/tree.c:2808:6: note: in expansion of macro 'xchg'
>      if (xchg(&krcp->monitor_todo, false))
>          ^~~~
>    In file included from include/linux/kernel.h:11:0,
>                     from kernel/rcu/tree.c:21:
> >> include/linux/compiler.h:350:38: error: call to '__compiletime_assert_2808' declared with attribute error: BUILD_BUG failed
>      _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
>                                          ^
>    include/linux/compiler.h:331:4: note: in definition of macro '__compiletime_assert'
>        prefix ## suffix();    \
>        ^~~~~~
>    include/linux/compiler.h:350:2: note: in expansion of macro '_compiletime_assert'
>      _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
>      ^~~~~~~~~~~~~~~~~~~
>    include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
>     #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>                                         ^~~~~~~~~~~~~~~~~~
>    include/linux/build_bug.h:59:21: note: in expansion of macro 'BUILD_BUG_ON_MSG'
>     #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
>                         ^~~~~~~~~~~~~~~~
> >> arch/riscv/include/asm/cmpxchg.h:138:3: note: in expansion of macro 'BUILD_BUG'
>       BUILD_BUG();      \
>       ^~~~~~~~~
> >> arch/riscv/include/asm/cmpxchg.h:146:23: note: in expansion of macro '__xchg'
>      (__typeof__(*(ptr))) __xchg((ptr), _x_, sizeof(*(ptr))); \
>                           ^~~~~~
> >> kernel/rcu/tree.c:2808:6: note: in expansion of macro 'xchg'
>      if (xchg(&krcp->monitor_todo, false))
>          ^~~~
>    In function 'kfree_rcu_drain_unlock',
>        inlined from 'kfree_rcu_monitor' at kernel/rcu/tree.c:2809:3:
>    include/linux/compiler.h:350:38: error: call to '__compiletime_assert_2792' declared with attribute error: BUILD_BUG failed
>      _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
>                                          ^
>    include/linux/compiler.h:331:4: note: in definition of macro '__compiletime_assert'
>        prefix ## suffix();    \
>        ^~~~~~
>    include/linux/compiler.h:350:2: note: in expansion of macro '_compiletime_assert'
>      _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
>      ^~~~~~~~~~~~~~~~~~~
>    include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
>     #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>                                         ^~~~~~~~~~~~~~~~~~
>    include/linux/build_bug.h:59:21: note: in expansion of macro 'BUILD_BUG_ON_MSG'
>     #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
>                         ^~~~~~~~~~~~~~~~
> >> arch/riscv/include/asm/cmpxchg.h:138:3: note: in expansion of macro 'BUILD_BUG'
>       BUILD_BUG();      \
>       ^~~~~~~~~
> >> arch/riscv/include/asm/cmpxchg.h:146:23: note: in expansion of macro '__xchg'
>      (__typeof__(*(ptr))) __xchg((ptr), _x_, sizeof(*(ptr))); \
>                           ^~~~~~
>    kernel/rcu/tree.c:2792:7: note: in expansion of macro 'xchg'
>      if (!xchg(&krcp->monitor_todo, true))
>           ^~~~
>    kernel/rcu/tree.c: In function 'kfree_call_rcu':
> >> kernel/rcu/tree.c:2860:5: warning: '__ret' may be used uninitialized in this function [-Wmaybe-uninitialized]
>      if (!xchg(&krcp->monitor_todo, true))
>         ^
>    In file included from include/linux/kernel.h:11:0,
>                     from kernel/rcu/tree.c:21:
>    include/linux/compiler.h:350:38: error: call to '__compiletime_assert_2860' declared with attribute error: BUILD_BUG failed
>      _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
>                                          ^
>    include/linux/compiler.h:331:4: note: in definition of macro '__compiletime_assert'
>        prefix ## suffix();    \
>        ^~~~~~
>    include/linux/compiler.h:350:2: note: in expansion of macro '_compiletime_assert'
>      _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
>      ^~~~~~~~~~~~~~~~~~~
>    include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
>     #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>                                         ^~~~~~~~~~~~~~~~~~
>    include/linux/build_bug.h:59:21: note: in expansion of macro 'BUILD_BUG_ON_MSG'
>     #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
>                         ^~~~~~~~~~~~~~~~
> >> arch/riscv/include/asm/cmpxchg.h:138:3: note: in expansion of macro 'BUILD_BUG'
>       BUILD_BUG();      \
>       ^~~~~~~~~
> >> arch/riscv/include/asm/cmpxchg.h:146:23: note: in expansion of macro '__xchg'
>      (__typeof__(*(ptr))) __xchg((ptr), _x_, sizeof(*(ptr))); \
>                           ^~~~~~
>    kernel/rcu/tree.c:2860:7: note: in expansion of macro 'xchg'
>      if (!xchg(&krcp->monitor_todo, true))
>           ^~~~
> --
>    In file included from arch/riscv/include/asm/atomic.h:19:0,
>                     from include/linux/atomic.h:7,
>                     from include/linux/spinlock.h:445,
>                     from kernel//rcu/tree.c:23:
>    kernel//rcu/tree.c: In function 'kfree_rcu_monitor':
> >> arch/riscv/include/asm/cmpxchg.h:140:2: warning: '__ret' is used uninitialized in this function [-Wuninitialized]
>      __ret;        \
>      ^~~~~
>    arch/riscv/include/asm/cmpxchg.h:121:21: note: '__ret' was declared here
>      __typeof__(*(ptr)) __ret;     \
>                         ^
> >> arch/riscv/include/asm/cmpxchg.h:146:23: note: in expansion of macro '__xchg'
>      (__typeof__(*(ptr))) __xchg((ptr), _x_, sizeof(*(ptr))); \
>                           ^~~~~~
>    kernel//rcu/tree.c:2808:6: note: in expansion of macro 'xchg'
>      if (xchg(&krcp->monitor_todo, false))
>          ^~~~
>    In file included from include/linux/kernel.h:11:0,
>                     from kernel//rcu/tree.c:21:
> >> include/linux/compiler.h:350:38: error: call to '__compiletime_assert_2808' declared with attribute error: BUILD_BUG failed
>      _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
>                                          ^
>    include/linux/compiler.h:331:4: note: in definition of macro '__compiletime_assert'
>        prefix ## suffix();    \
>        ^~~~~~
>    include/linux/compiler.h:350:2: note: in expansion of macro '_compiletime_assert'
>      _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
>      ^~~~~~~~~~~~~~~~~~~
>    include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
>     #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>                                         ^~~~~~~~~~~~~~~~~~
>    include/linux/build_bug.h:59:21: note: in expansion of macro 'BUILD_BUG_ON_MSG'
>     #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
>                         ^~~~~~~~~~~~~~~~
> >> arch/riscv/include/asm/cmpxchg.h:138:3: note: in expansion of macro 'BUILD_BUG'
>       BUILD_BUG();      \
>       ^~~~~~~~~
> >> arch/riscv/include/asm/cmpxchg.h:146:23: note: in expansion of macro '__xchg'
>      (__typeof__(*(ptr))) __xchg((ptr), _x_, sizeof(*(ptr))); \
>                           ^~~~~~
>    kernel//rcu/tree.c:2808:6: note: in expansion of macro 'xchg'
>      if (xchg(&krcp->monitor_todo, false))
>          ^~~~
>    In function 'kfree_rcu_drain_unlock',
>        inlined from 'kfree_rcu_monitor' at kernel//rcu/tree.c:2809:3:
>    include/linux/compiler.h:350:38: error: call to '__compiletime_assert_2792' declared with attribute error: BUILD_BUG failed
>      _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
>                                          ^
>    include/linux/compiler.h:331:4: note: in definition of macro '__compiletime_assert'
>        prefix ## suffix();    \
>        ^~~~~~
>    include/linux/compiler.h:350:2: note: in expansion of macro '_compiletime_assert'
>      _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
>      ^~~~~~~~~~~~~~~~~~~
>    include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
>     #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>                                         ^~~~~~~~~~~~~~~~~~
>    include/linux/build_bug.h:59:21: note: in expansion of macro 'BUILD_BUG_ON_MSG'
>     #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
>                         ^~~~~~~~~~~~~~~~
> >> arch/riscv/include/asm/cmpxchg.h:138:3: note: in expansion of macro 'BUILD_BUG'
>       BUILD_BUG();      \
>       ^~~~~~~~~
> >> arch/riscv/include/asm/cmpxchg.h:146:23: note: in expansion of macro '__xchg'
>      (__typeof__(*(ptr))) __xchg((ptr), _x_, sizeof(*(ptr))); \
>                           ^~~~~~
>    kernel//rcu/tree.c:2792:7: note: in expansion of macro 'xchg'
>      if (!xchg(&krcp->monitor_todo, true))
>           ^~~~
>    kernel//rcu/tree.c: In function 'kfree_call_rcu':
>    kernel//rcu/tree.c:2860:5: warning: '__ret' may be used uninitialized in this function [-Wmaybe-uninitialized]
>      if (!xchg(&krcp->monitor_todo, true))
>         ^
>    In file included from include/linux/kernel.h:11:0,
>                     from kernel//rcu/tree.c:21:
>    include/linux/compiler.h:350:38: error: call to '__compiletime_assert_2860' declared with attribute error: BUILD_BUG failed
>      _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
>                                          ^
>    include/linux/compiler.h:331:4: note: in definition of macro '__compiletime_assert'
>        prefix ## suffix();    \
>        ^~~~~~
>    include/linux/compiler.h:350:2: note: in expansion of macro '_compiletime_assert'
>      _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
>      ^~~~~~~~~~~~~~~~~~~
>    include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
>     #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>                                         ^~~~~~~~~~~~~~~~~~
>    include/linux/build_bug.h:59:21: note: in expansion of macro 'BUILD_BUG_ON_MSG'
>     #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
>                         ^~~~~~~~~~~~~~~~
> >> arch/riscv/include/asm/cmpxchg.h:138:3: note: in expansion of macro 'BUILD_BUG'
>       BUILD_BUG();      \
>       ^~~~~~~~~
> >> arch/riscv/include/asm/cmpxchg.h:146:23: note: in expansion of macro '__xchg'
>      (__typeof__(*(ptr))) __xchg((ptr), _x_, sizeof(*(ptr))); \
>                           ^~~~~~
>    kernel//rcu/tree.c:2860:7: note: in expansion of macro 'xchg'
>      if (!xchg(&krcp->monitor_todo, true))
>           ^~~~
> 
> vim +/xchg +2808 kernel/rcu/tree.c
> 
>   2776	
>   2777	static inline void kfree_rcu_drain_unlock(struct kfree_rcu_cpu *krcp,
>   2778					   unsigned long flags)
>   2779	{
>   2780		/* Flush ->head to ->head_free, all objects on ->head_free will be
>   2781		 * kfree'd after a grace period.
>   2782		 */
>   2783		if (queue_kfree_rcu_work(krcp)) {
>   2784			/* Success! Our job is done here. */
>   2785			spin_unlock_irqrestore(&krcp->lock, flags);
>   2786			return;
>   2787		}
>   2788	
>   2789		/* Previous batch that was queued to RCU did not get free yet, let us
>   2790		 * try again soon.
>   2791		 */
> > 2792		if (!xchg(&krcp->monitor_todo, true))
>   2793			schedule_delayed_work(&krcp->monitor_work, KFREE_DRAIN_JIFFIES);
>   2794		spin_unlock_irqrestore(&krcp->lock, flags);
>   2795	}
>   2796	
>   2797	/*
>   2798	 * This function is invoked after the KFREE_DRAIN_JIFFIES timeout has elapsed,
>   2799	 * and it drains the specified kfree_rcu_cpu structure's ->head list.
>   2800	 */
>   2801	static void kfree_rcu_monitor(struct work_struct *work)
>   2802	{
>   2803		unsigned long flags;
>   2804		struct kfree_rcu_cpu *krcp = container_of(work, struct kfree_rcu_cpu,
>   2805							 monitor_work.work);
>   2806	
>   2807		spin_lock_irqsave(&krcp->lock, flags);
> > 2808		if (xchg(&krcp->monitor_todo, false))
>   2809			kfree_rcu_drain_unlock(krcp, flags);
>   2810		else
>   2811			spin_unlock_irqrestore(&krcp->lock, flags);
>   2812	}
>   2813	
>   2814	/*
>   2815	 * This version of kfree_call_rcu does not do batching of kfree_rcu() requests.
>   2816	 * Used only by rcuperf torture test for comparison with kfree_rcu_batch().
>   2817	 */
>   2818	void kfree_call_rcu_nobatch(struct rcu_head *head, rcu_callback_t func)
>   2819	{
>   2820		__call_rcu(head, func, 1);
>   2821	}
>   2822	EXPORT_SYMBOL_GPL(kfree_call_rcu_nobatch);
>   2823	
>   2824	/*
>   2825	 * Queue a request for lazy invocation of kfree() after a grace period.
>   2826	 *
>   2827	 * Each kfree_call_rcu() request is added to a batch. The batch will be drained
>   2828	 * every KFREE_DRAIN_JIFFIES number of jiffies. All the objects in the batch
>   2829	 * will be kfree'd in workqueue context. This allows us to:
>   2830	 *
>   2831	 * 1. Batch requests together to reduce the number of grace periods during
>   2832	 * heavy kfree_rcu() load.
>   2833	 *
>   2834	 * 2. In the future, makes it possible to use kfree_bulk() on a large number of
>   2835	 * kfree_rcu() requests thus reducing the per-object overhead of kfree() and
>   2836	 * also reducing cache misses.
>   2837	 */
>   2838	void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
>   2839	{
>   2840		unsigned long flags;
>   2841		struct kfree_rcu_cpu *krcp;
>   2842	
>   2843		/* kfree_call_rcu() batching requires timers to be up. If the scheduler
>   2844		 * is not yet up, just skip batching and do the non-batched version.
>   2845		 */
>   2846		if (rcu_scheduler_active != RCU_SCHEDULER_RUNNING)
>   2847			return kfree_call_rcu_nobatch(head, func);
>   2848	
>   2849		head->func = func;
>   2850	
>   2851		local_irq_save(flags);	/* For safely calling this_cpu_ptr(). */
>   2852		krcp = this_cpu_ptr(&krc);
>   2853		spin_lock(&krcp->lock);
>   2854	
>   2855		/* Queue the kfree but don't yet schedule the batch. */
>   2856		head->next = krcp->head;
>   2857		krcp->head = head;
>   2858	
>   2859		/* Schedule monitor for timely drain after KFREE_DRAIN_JIFFIES. */
> > 2860		if (!xchg(&krcp->monitor_todo, true))
>   2861			schedule_delayed_work(&krcp->monitor_work, KFREE_DRAIN_JIFFIES);
>   2862	
>   2863		spin_unlock(&krcp->lock);
>   2864		local_irq_restore(flags);
>   2865	}
>   2866	EXPORT_SYMBOL_GPL(kfree_call_rcu);
>   2867	
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation


