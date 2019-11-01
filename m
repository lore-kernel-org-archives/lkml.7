Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA3BCA9ED0
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 11:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A92B208E3
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 11:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572609297;
	bh=3kTe0v/+oHNZ4O5bBDx3tGuPTcjhQsGAwsgnkmqWoXo=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=Fq/IcMr8EANjxzwUffILn4GMjwBeDb1aJdGyvWEB23WeFnhTygllMHT6iVspkmGm2
	 oOWU3MRTAER4NntIoelY9kEtheXE9pxDcQG9yz6xBrARGtOJg82rm3ro+hqX31p4LC
	 UcEUPM4tJRjCj26pK5tD40oRpGJc0sZ/lhdz3DmI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730487AbfKALy4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 07:54:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:57472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726957AbfKALyz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 07:54:55 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9AD6520656;
        Fri,  1 Nov 2019 11:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572609294;
        bh=3kTe0v/+oHNZ4O5bBDx3tGuPTcjhQsGAwsgnkmqWoXo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=T18i3ERM5qIvkvnkrn0+/sZD1jzJwCETNpllGBNL5vG2zdH1ytf/11HZztVVFUSUb
         m9Tg4q8fTIomboBtYViB/SW3m09EeeVAyH04VkSYfpfR7OQYrls62Z0oTOVFI/8yNO
         5c8gIY/CMWxSl3dZRY8yZaEEOPQA4Q9VCaeikF38=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 62B283522AF9; Fri,  1 Nov 2019 04:54:54 -0700 (PDT)
Date:   Fri, 1 Nov 2019 04:54:54 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Lai Jiangshan <laijs@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: Re: [PATCH 05/11] rcu: clean all rcu_read_unlock_special after
 report qs
Message-ID: <20191101115454.GA17910@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191031100806.1326-1-laijs@linux.alibaba.com>
 <20191031100806.1326-6-laijs@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191031100806.1326-6-laijs@linux.alibaba.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2019 at 10:08:00AM +0000, Lai Jiangshan wrote:
> rcu_preempt_deferred_qs_irqrestore() is always called when
> ->rcu_read_lock_nesting <= 0 and there is nothing to prevent it
> from reporting qs if needed which means ->rcu_read_unlock_special
> is better to be clearred after the function. But in some cases,
> it leaves exp_hint (for example, after rcu_note_context_switch()),
> which is harmess since it is just a hint, but it may also intruduce
> unneeded rcu_read_unlock_special() later.
> 
> The new code write to exp_hint without WRITE_ONCE() since the
> writing is protected by irq.
> 
> Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>

This does look good, thank you!

Though for a rather different reason that called out in the commit log.
Note that .exp_hint is in task_struct, and thus follows the task, and is
currently unconditionally cleared by the next rcu_read_unlock_special(),
which will be invoked because .exp_hint is non-zero.  So if
rcu_note_context_switch() leaves .exp_hint set, that is all to the good
because the next rcu_read_unlock() executed by this task once resumed,
and because that rcu_read_unlock() might be transitioning to a quiescent
state required in order for the expedited grace period to end.

Nevertheless, clearing .exp_hint in rcu_preempt_deferred_qs_irqrestore()
instead of rcu_read_unlock_special() is a good thing.  This is because
in the case where it is not possible to arrange an event immediately
following reenabling, it is good to enable any rcu_read_unlock()s that
might be executed to help us out.

Or am I missing something here?

> ---
>  kernel/rcu/tree_plugin.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index 9fe8138ed3c3..bb3bcdb5c9b8 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -439,6 +439,7 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
>  	 * t->rcu_read_unlock_special cannot change.
>  	 */
>  	special = t->rcu_read_unlock_special;
> +	t->rcu_read_unlock_special.b.exp_hint = false;

Interrupts are disabled by this time, so yes, it is safe for this to be
a simple assignment.

>  	t->rcu_read_unlock_special.b.deferred_qs = false;
>  	if (special.b.need_qs) {
>  		rcu_qs();
> @@ -626,7 +627,6 @@ static void rcu_read_unlock_special(struct task_struct *t)
>  		local_irq_restore(flags);
>  		return;
>  	}
> -	WRITE_ONCE(t->rcu_read_unlock_special.b.exp_hint, false);

And reaching the above assignment is inevitable at this point,
so this assignment can go.

But can't we also get rid of the assignment under the preceding "if"
statement?  Please see below for a version of your patch that includes
this proposed change along with an updated commit log.  Please let me
know if I have messed anything up.

>  	rcu_preempt_deferred_qs_irqrestore(t, flags);
>  }

------------------------------------------------------------------------

commit 6e3f2b1d6aba24ad6ae8deb2ce98b93d527227ae
Author: Lai Jiangshan <laijs@linux.alibaba.com>
Date:   Fri Nov 1 04:06:22 2019 -0700

    rcu: Clear .exp_hint only when deferred quiescent state has been reported
    
    Currently, the .exp_hint flag is cleared in rcu_read_unlock_special(),
    which works, but which can also prevent subsequent rcu_read_unlock() calls
    from helping expedite the quiescent state needed by an ongoing expedited
    RCU grace period.  This commit therefore defers clearing of .exp_hint
    from rcu_read_unlock_special() to rcu_preempt_deferred_qs_irqrestore(),
    thus ensuring that intervening calls to rcu_read_unlock() have a chance
    to help end the expedited grace period.
    
    Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index d4c4824..677ee1c 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -439,6 +439,7 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
 	 * t->rcu_read_unlock_special cannot change.
 	 */
 	special = t->rcu_read_unlock_special;
+	t->rcu_read_unlock_special.b.exp_hint = false;
 	rdp = this_cpu_ptr(&rcu_data);
 	if (!special.s && !rdp->exp_deferred_qs) {
 		local_irq_restore(flags);
@@ -610,7 +611,6 @@ static void rcu_read_unlock_special(struct task_struct *t)
 		struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 		struct rcu_node *rnp = rdp->mynode;
 
-		t->rcu_read_unlock_special.b.exp_hint = false;
 		exp = (t->rcu_blocked_node && t->rcu_blocked_node->exp_tasks) ||
 		      (rdp->grpmask & rnp->expmask) ||
 		      tick_nohz_full_cpu(rdp->cpu);
@@ -640,7 +640,6 @@ static void rcu_read_unlock_special(struct task_struct *t)
 		local_irq_restore(flags);
 		return;
 	}
-	WRITE_ONCE(t->rcu_read_unlock_special.b.exp_hint, false);
 	rcu_preempt_deferred_qs_irqrestore(t, flags);
 }
 
