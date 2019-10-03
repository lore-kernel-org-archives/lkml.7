Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE2EC32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 11:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33B532086A
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 11:43:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730252AbfJCLnX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 07:43:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:34032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730027AbfJCLnX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 07:43:23 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05D0320830;
        Thu,  3 Oct 2019 11:43:20 +0000 (UTC)
Date:   Thu, 3 Oct 2019 07:43:19 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     paulmck@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E . McKenney" <paulmck@linux.ibm.com>
Subject: Re: [PATCH tip/core/rcu 4/8] rcu: Ensure that ->rcu_urgent_qs is
 set before resched IPI
Message-ID: <20191003074319.2df342dd@gandalf.local.home>
In-Reply-To: <20191003013305.12854-4-paulmck@kernel.org>
References: <20191003013243.GA12705@paulmck-ThinkPad-P72>
        <20191003013305.12854-4-paulmck@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  2 Oct 2019 18:33:01 -0700
paulmck@kernel.org wrote:

> From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> 
> The RCU-specific resched_cpu() function sends a resched IPI to the
> specified CPU, which can be used to force the tick on for a given
> nohz_full CPU.  This is needed when this nohz_full CPU is looping in the
> kernel while blocking the current grace period.  However, for the tick
> to actually be forced on in all cases, that CPU's rcu_data structure's
> ->rcu_urgent_qs flag must be set beforehand.  This commit therefore  
> causes rcu_implicit_dynticks_qs() to set this flag prior to invoking
> resched_cpu() on a holdout nohz_full CPU.

Should this be marked for stable?

-- Steve

> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
> ---
>  kernel/rcu/tree.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 8110514..0d83b19 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -1073,6 +1073,7 @@ static int rcu_implicit_dynticks_qs(struct rcu_data *rdp)
>  	if (tick_nohz_full_cpu(rdp->cpu) &&
>  		   time_after(jiffies,
>  			      READ_ONCE(rdp->last_fqs_resched) + jtsq * 3)) {
> +		WRITE_ONCE(*ruqp, true);
>  		resched_cpu(rdp->cpu);
>  		WRITE_ONCE(rdp->last_fqs_resched, jiffies);
>  	}

