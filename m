Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51889C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 12:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E5DC20840
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 12:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565699426;
	bh=0I7ATeXt7w4ddB3YVDDEftjVJR5fs+9vPsJx53S8d+w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=aTWjVkDNz9PDd73q0V50VsgU1Dr7MgNrpokwQpVRznkG3qiu90rAdzRb02+SnnoVn
	 dbo5a6/3OO9WvmhxULopjdCcZyZ9BcWRYfAsLRH/6x4TFHB23WKS2F9Qhb70Jo9q5h
	 7mMVy4e9AxjKSQ2ahb5VImp697JAI4zpegiPPR74=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbfHMMaY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 08:30:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:47834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726903AbfHMMaX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 08:30:23 -0400
Received: from localhost (lfbn-ncy-1-174-150.w83-194.abo.wanadoo.fr [83.194.254.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D76BC2067D;
        Tue, 13 Aug 2019 12:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565699422;
        bh=0I7ATeXt7w4ddB3YVDDEftjVJR5fs+9vPsJx53S8d+w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CXaUJivcYneepu+r62Nj97SyLpXnMF3NsnHndVCZnCIAzKlhdtJOJC8rkpvs8Fgpw
         SVEyqmXrj70RmcwiWCnvw6T4GiOAjTTgsaMQ5vKMlng59cppq6uXmu4kV0pb9OfdDb
         +6nw0O3mriBV+sb0SDiYaqQ7oi0yh/RXYnsJKEyk=
Date:   Tue, 13 Aug 2019 14:30:19 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: Re: [PATCH RFC tip/core/rcu 14/14] rcu/nohz: Make multi_cpu_stop()
 enable tick on all online CPUs
Message-ID: <20190813123016.GA11455@lenoir>
References: <20190802151435.GA1081@linux.ibm.com>
 <20190802151501.13069-14-paulmck@linux.ibm.com>
 <20190812210232.GA3648@lenoir>
 <20190812232316.GT28441@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190812232316.GT28441@linux.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2019 at 04:23:16PM -0700, Paul E. McKenney wrote:
> On Mon, Aug 12, 2019 at 11:02:33PM +0200, Frederic Weisbecker wrote:
> > On Fri, Aug 02, 2019 at 08:15:01AM -0700, Paul E. McKenney wrote:
> > Looks like it's not the right fix but, should you ever need to set an
> > all-CPUs (system wide) tick dependency in the future, you can use tick_set_dep().
> 
> Indeed, I have dropped this patch, but I now do something similar in
> RCU's CPU-hotplug notifiers.  Which does have an effect, especially on
> the system that isn't subject to the insane-latency cpu_relax().
> 
> Plus I am having to put a similar workaround into RCU's quiescent-state
> forcing logic.
> 
> But how should this really be done?
> 
> Isn't there some sort of monitoring of nohz_full CPUs for accounting
> purposes?  If so, would it make sense for this monitoring to check for
> long-duration kernel execution and enable the tick in this case?  The
> RCU dyntick machinery can be used to remotely detect the long-duration
> kernel execution using something like the following:
> 
> 	int nohz_in_kernel_snap = rcu_dynticks_snap_cpu(cpu);
> 
> 	...
> 
> 	if (rcu_dynticks_in_eqs_cpu(cpu, nohz_in_kernel_snap)
> 		nohz_in_kernel_snap = rcu_dynticks_snap_cpu(cpu);
> 	else
> 		/* Turn on the tick! */
> 
> I would supply rcu_dynticks_snap_cpu() and rcu_dynticks_in_eqs_cpu(),
> which would be simple wrappers around RCU's private rcu_dynticks_snap()
> and rcu_dynticks_in_eqs() functions.
> 
> Would this make sense as a general solution, or am I missing a corner
> case or three?

Oh I see. Until now we considered than running into the kernel (between user/guest/idle)
is supposed to be short but there can be specific places where it doesn't apply.

I'm wondering if, more than just providing wrappers, this shouldn't be entirely
driven by RCU using the tick_set_dep_cpu()/tick_clear_dep_cpu() at appropriate timings.

I don't want to sound like I'm trying to put all the work on you :p  It's just that
the tick shouldn't know much about RCU, it's rather RCU that is a client for the tick and
is probably better suited to determine when a CPU becomes annoying with its extended grace
period.

Arming a CPU timer could also be an alternative to tick_set_dep_cpu() for that.

What do you think?
