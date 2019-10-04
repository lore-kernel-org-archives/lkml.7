Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71ED5C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 14:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49A582084D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 14:59:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="dFz1njCz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389567AbfJDO7S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 10:59:18 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33753 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389131AbfJDO7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 10:59:15 -0400
Received: by mail-pl1-f194.google.com with SMTP id d22so3276562pls.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 07:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2wfbTqj/1GifTktDH0NjO3xlylB7xIiO6s0VJ1u++Gc=;
        b=dFz1njCzuPEdsmtMfQ5fivnHO8J637sjOhRP/kVcH5LtG0PqI+FCkfqgNDTJfOQsxk
         AblZxZwPaxZ/O7txizihR0t04UHgyZXDz0phn6eVBphOFrRbIc4oNDLzq3oWb7WRI600
         lM11WsxCwbj0b9rrbIJllWowv3zec12G5U4+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2wfbTqj/1GifTktDH0NjO3xlylB7xIiO6s0VJ1u++Gc=;
        b=GID8Ij+UqRQ73ZoZfVFJUSrOdbpdvXtezij1ayeLVcFYQciiE5i/3vhb1b6jh3xSMe
         /HkWFn8WIbtvW4dkVv/29jdjlh7TrSt6ANwXJoyZOvLj1jOFTsxkv+hV1cjhj92drunj
         FEQXvi6XAFY6/q1GC65Vs5/Cn9Pz7GNMc6I0Mj2ZshJMbYX/QRFsjWP8JvP7kNi2Oj5q
         0gHeVUn7TsvWmQsKNvZrRqWhUu9yVXfoSnLZMahZIbgA++LK54Z6mPvVMpmBXO/3MTkQ
         5pC4t6tS7RjmB8RMuU0kMnZD/4XMlQS/DsYIcNvO/tTEeuloWiNb7zvsDaYjv21gkeQB
         nK1A==
X-Gm-Message-State: APjAAAVv9BSy74dYu0ovGznie5R1T+i3wvJa0xVH9BDkIdMW2hxoKR+E
        Q3Xk7OCfpxyhkOukTX89DDfupV5gkGk=
X-Google-Smtp-Source: APXvYqz5QLl7mSxo/aKu+aiFkmM3VA5g3CXy7W7GKn7/M/oI8ZwG4V+0GNpT2EGoi4Ya/6pA3NW0Og==
X-Received: by 2002:a17:902:8d98:: with SMTP id v24mr15629367plo.265.1570201154343;
        Fri, 04 Oct 2019 07:59:14 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id p68sm10907029pfp.9.2019.10.04.07.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 07:59:13 -0700 (PDT)
Date:   Fri, 4 Oct 2019 10:59:12 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     bristot@redhat.com, peterz@infradead.org, oleg@redhat.com,
        paulmck@kernel.org, rcu@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] Remove GP_REPLAY state from rcu_sync
Message-ID: <20191004145912.GA118626@google.com>
References: <20191004145741.118292-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191004145741.118292-1-joel@joelfernandes.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 04, 2019 at 10:57:41AM -0400, Joel Fernandes (Google) wrote:
> From: Joel Fernandes <joel@joelfernandes.org>
> 
> Please consider this is an RFC for discussion only. Just want to discuss
> why the GP_REPLAY state is needed at all.

And I messed up the subject prefix, but this is *really* RFC and for
discussion purposes :)

thanks,

 - Joel


> Here's the intention AFAICS:
> When rcu_sync_exit() has happened, the gp_state changes to GP_EXIT while
> we wait for a grace period before transitioning to GP_IDLE. In the
> meanwhile, if we receive another rcu_sync_exit(), then we want to wait
> for another GP to account for that.
> 
> Drawing some timing diagrams, it looks like this:
> 
> Legend:
> rse = rcu_sync_enter
> rsx = rcu_sync_exit
> i = GP_IDLE
> x = GP_EXIT
> r = GP_REPLAY
> e = GP_ENTER
> p = GP_PASSED
> rx = GP_REPLAY changes to GP_EXIT
> 
> GP num = The GP we are one.
> 
> note: A GP passes between the states:
>   e and p
>   x and i
>   x and rx
>   rx and i
> 
> In a simple case, the timing and states look like:
> time
> ---------------------->
> GP num         1111111    2222222
> GP state  i    e     p    x     i
> CPU0 :         rse	  rsx
> 
> However we can enter the replay state like this:
> time
> ---------------------->
> GP num         1111111    2222222222222222222223333333
> GP state  i    e     p    x              r     rx    i
> CPU0 :         rse	  rsx
> CPU1 :                         rse     rsx
> 
> Due to the second rse + rsx, we had to wait for another GP.
> 
> I believe the rationale is, if another rsx happens, another GP has to
> happen.
> 
> But this is not always true if you consider the following events:
> 
> time
> ---------------------->
> GP num         111111     22222222222222222222222222222222233333333
> GP state  i    e     p    x                 r              rx     i
> CPU0 :         rse	  rsx
> CPU1 :                         rse     rsx
> CPU2 :                                         rse     rsx
> 
> Here, we had 3 grace periods that elapsed, 1 for the rcu_sync_enter(),
> and 2 for the rcu_sync_exit(s).
> 
> However, we had 3 rcu_sync_exit()s, not 2. In other words, the
> rcu_sync_exit() got batched.
> 
> So my point here is, rcu_sync_exit() does not really always cause a new
> GP to happen and we can end up having the rcu_sync_exit()s as batched
> and sharing the same grace period.
> 
> Then what is the point of the GP_REPLAY state at all if it does not
> always wait for a new GP?  Taking a step back, why did we intend to have
> to wait for a new GP if another rcu_sync_exit() comes while one is still
> in progress?
> 
> Cc: bristot@redhat.com
> Cc: peterz@infradead.org
> Cc: oleg@redhat.com
> Cc: paulmck@kernel.org
> Cc: rcu@vger.kernel.org
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  kernel/rcu/sync.c | 14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)
> 
> diff --git a/kernel/rcu/sync.c b/kernel/rcu/sync.c
> index d4558ab7a07d..4f3aad67992c 100644
> --- a/kernel/rcu/sync.c
> +++ b/kernel/rcu/sync.c
> @@ -10,7 +10,7 @@
>  #include <linux/rcu_sync.h>
>  #include <linux/sched.h>
>  
> -enum { GP_IDLE = 0, GP_ENTER, GP_PASSED, GP_EXIT, GP_REPLAY };
> +enum { GP_IDLE = 0, GP_ENTER, GP_PASSED, GP_EXIT };
>  
>  #define	rss_lock	gp_wait.lock
>  
> @@ -85,13 +85,6 @@ static void rcu_sync_func(struct rcu_head *rhp)
>  		 */
>  		WRITE_ONCE(rsp->gp_state, GP_PASSED);
>  		wake_up_locked(&rsp->gp_wait);
> -	} else if (rsp->gp_state == GP_REPLAY) {
> -		/*
> -		 * A new rcu_sync_exit() has happened; requeue the callback to
> -		 * catch a later GP.
> -		 */
> -		WRITE_ONCE(rsp->gp_state, GP_EXIT);
> -		rcu_sync_call(rsp);
>  	} else {
>  		/*
>  		 * We're at least a GP after the last rcu_sync_exit(); eveybody
> @@ -167,16 +160,13 @@ void rcu_sync_enter(struct rcu_sync *rsp)
>   */
>  void rcu_sync_exit(struct rcu_sync *rsp)
>  {
> -	WARN_ON_ONCE(READ_ONCE(rsp->gp_state) == GP_IDLE);
> -	WARN_ON_ONCE(READ_ONCE(rsp->gp_count) == 0);
> +	WARN_ON_ONCE(READ_ONCE(rsp->gp_state) < GP_PASSED);
>  
>  	spin_lock_irq(&rsp->rss_lock);
>  	if (!--rsp->gp_count) {
>  		if (rsp->gp_state == GP_PASSED) {
>  			WRITE_ONCE(rsp->gp_state, GP_EXIT);
>  			rcu_sync_call(rsp);
> -		} else if (rsp->gp_state == GP_EXIT) {
> -			WRITE_ONCE(rsp->gp_state, GP_REPLAY);
>  		}
>  	}
>  	spin_unlock_irq(&rsp->rss_lock);
> -- 
> 2.23.0.581.g78d2f28ef7-goog
> 
