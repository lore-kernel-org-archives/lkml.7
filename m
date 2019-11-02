Return-Path: <SRS0=TDlZ=Y2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B7ECA9EC7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 15:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC92D21855
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 15:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572707155;
	bh=1y5Bat7vPpY5QvpEoK0Vmi+ZYimxQEsWhingPtGW4ow=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=KaSwaJwOsfJ6IStlLnmnDk5K9bmiGABDMR5+5vplid0KXD84idc+ySXyrxrc0zXPd
	 w0K2IfgBq9XIYTWnYBmiqZQ8RA8lSqNoox1tWq8DQzUUrXM+DkcApT6C8Kf6YgI6KB
	 zaymdbfEDUcRy0C/MiBY5RcumK86aQYOzhtirGQ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbfKBPFr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Nov 2019 11:05:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:60352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726437AbfKBPFr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Nov 2019 11:05:47 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B22121726;
        Sat,  2 Nov 2019 15:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572707145;
        bh=1y5Bat7vPpY5QvpEoK0Vmi+ZYimxQEsWhingPtGW4ow=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=xyA4AUF+tlW9jBhFFCq7g81+9RfzwNjco+NkamqnMOz5TkvNuXuH6jgjmTtUacd+v
         fYAGzZJhpWIwp8Bc0gy4EE2ZRFBR0Bpj3XRNSdmzf0A542iPAVeaxcxs8BsNLa0Bj6
         vjebbariy1/0tvrXQJ+opODbI2VOub3kxsivCug8=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 555153520402; Sat,  2 Nov 2019 08:05:45 -0700 (PDT)
Date:   Sat, 2 Nov 2019 08:05:45 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Lai Jiangshan <laijs@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: Re: [PATCH V2 0/7] rcu: introduce percpu rcu_preempt_depth
Message-ID: <20191102150545.GQ20975@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191102124559.1135-1-laijs@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191102124559.1135-1-laijs@linux.alibaba.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 02, 2019 at 12:45:52PM +0000, Lai Jiangshan wrote:
> Rather than using the generic version of preempt_count, x86 uses
> a special version of preempt_count implementation that take advantage
> of x86 (single instruction to access/add/decl/flip-bits of percpu
> counter). It makes the preempt_count operations really cheap.
> 
> For x86, rcu_preempt_depth can also take the same advantage by
> using the same technique.
> 
> After the patchset:
>  - No function call when using rcu_read_[un]lock().
>      It is minor improvement, other arch can also achieve it via
>      moving ->rcu_read_lock_nesting and ->rcu_read_unlock_special
>      to thread_info, but inlined rcu_read_[un]lock() generates
>      more instructions and footprint in other arch generally.
>  - Only single instruction for rcu_read_lock().
>  - Only 2 instructions for the fast path of rcu_read_unlock().
> 
> Patch4 simplifies rcu_read_unlock() by avoid using negative
> ->rcu_read_lock_nesting, Patch7 introduces the percpu rcu_preempt_depth.
> Other patches are for preparation.
> 
> changed from v1:
>   drop patch1/2 of the v1
>   drop merged patches
> 
>   Using special.b.deferred_qs to avoid wakeup in v1 is changed to using
>   preempt_count. And special.b.deferred_qs is removed.
> 
> Lai Jiangshan (7):
>   rcu: use preempt_count to test whether scheduler locks is held
>   rcu: cleanup rcu_preempt_deferred_qs()
>   rcu: remove useless special.b.deferred_qs
>   rcu: don't use negative ->rcu_read_lock_nesting
>   rcu: wrap usages of rcu_read_lock_nesting
>   rcu: clear the special.b.need_qs in rcu_note_context_switch()
>   x86,rcu: use percpu rcu_preempt_depth

I am getting on a plane shortly, so what I have done is start a longish
rcutorture test on these.  I will take a look at them later on.

And I presume that answers to my questions on some of the patches in
this series will be forthcoming.  ;-)

							Thanx, Paul

>  arch/x86/Kconfig                         |   2 +
>  arch/x86/include/asm/rcu_preempt_depth.h |  87 +++++++++++++++++++
>  arch/x86/kernel/cpu/common.c             |   7 ++
>  arch/x86/kernel/process_32.c             |   2 +
>  arch/x86/kernel/process_64.c             |   2 +
>  include/linux/rcupdate.h                 |  24 ++++++
>  include/linux/sched.h                    |   2 +-
>  init/init_task.c                         |   2 +-
>  kernel/fork.c                            |   2 +-
>  kernel/rcu/Kconfig                       |   3 +
>  kernel/rcu/tree_exp.h                    |  35 ++------
>  kernel/rcu/tree_plugin.h                 | 101 ++++++++++++++---------
>  12 files changed, 196 insertions(+), 73 deletions(-)
>  create mode 100644 arch/x86/include/asm/rcu_preempt_depth.h
> 
> -- 
> 2.20.1
> 
