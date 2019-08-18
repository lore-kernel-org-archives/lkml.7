Return-Path: <SRS0=w4Fx=WO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B3E5C3A589
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 23:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 197FA2186A
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 23:39:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="uWZVQoYX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbfHRXi6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Aug 2019 19:38:58 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36428 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbfHRXi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 19:38:58 -0400
Received: by mail-pg1-f195.google.com with SMTP id l21so47752pgm.3
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2019 16:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ex0+B/0MyZlrag4/iLvu7HvXkBlO9jBl5Bqsp34vfZY=;
        b=uWZVQoYXMMzcs5yWltDLWls+ALlFK+zyeSsu1yJ/R+Wqt2p0gQBUkfACtSi7eoE3au
         sNz/NXkLWyXfbViupqZMlS6G+myEteZCTdl2Z2Z5kF7QF75R9oW3mOH/jgRnhTDx00IC
         VHYu9oXQcfDvu+163Iim/fBD9xz+21xoTP6zs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ex0+B/0MyZlrag4/iLvu7HvXkBlO9jBl5Bqsp34vfZY=;
        b=MAQliqmvxkc4QVvZ9ueRtJfFiDFKaLeB8JUYgb4l0zhB3HXk4tfA11hCj/nc6u1468
         hmleKiND2MyRGySMJgyk6E3/E6XbhG15/IQQLJ85Ei02uWqITEth4st9gNMXjOQilRx7
         1EG1TE98ZVlb/lPHhvUqz9MB8wZIiuLstM+VsQhMNz2LGLE4TTb3w6hqwBK9vwWwBFHw
         AqrioJ2vfHz3u38Yl+PqR0nFgklYXr+mqotJrix7uhtUDgVbXnvbuIgrtpxm6WeNe1Cd
         sFQkF1FjZEus9/k07cdUqfqm9moNGl35vzRkL3CLBxo5lUVW7BPUItIEN18nffxLWNe5
         pG9w==
X-Gm-Message-State: APjAAAV0N4DKO3ANLi8agIW/loKiFw+8pvgGMa9Sx4uscXuqxFM1ruX9
        cMQ+OXOnQCDVw7g1lLrT+r+nHg==
X-Google-Smtp-Source: APXvYqyykx/M1/CX8VuMpIqVznZ1kng1DE0Frf8Q42CS2bbptq8LXwr8IDd6BvEkalCwfPESVRyhPw==
X-Received: by 2002:a17:90a:d151:: with SMTP id t17mr18049797pjw.60.1566171536796;
        Sun, 18 Aug 2019 16:38:56 -0700 (PDT)
Received: from localhost ([172.19.216.18])
        by smtp.gmail.com with ESMTPSA id r4sm15726628pfl.127.2019.08.18.16.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2019 16:38:55 -0700 (PDT)
Date:   Sun, 18 Aug 2019 19:38:39 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC v2] rcu/tree: Try to invoke_rcu_core() if in_irq() during
 unlock
Message-ID: <20190818233839.GA160903@google.com>
References: <20190818214948.GA134430@google.com>
 <20190818221210.GP28441@linux.ibm.com>
 <20190818223230.GA143857@google.com>
 <20190818223511.GB143857@google.com>
 <20190818233135.GQ28441@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190818233135.GQ28441@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 18, 2019 at 04:31:35PM -0700, Paul E. McKenney wrote:
> On Sun, Aug 18, 2019 at 06:35:11PM -0400, Joel Fernandes wrote:
> > On Sun, Aug 18, 2019 at 06:32:30PM -0400, Joel Fernandes wrote:
> > > On Sun, Aug 18, 2019 at 03:12:10PM -0700, Paul E. McKenney wrote:
> > > > On Sun, Aug 18, 2019 at 05:49:48PM -0400, Joel Fernandes (Google) wrote:
> > > > > When we're in hard interrupt context in rcu_read_unlock_special(), we
> > > > > can still benefit from invoke_rcu_core() doing wake ups of rcuc
> > > > > threads when the !use_softirq parameter is passed.  This is safe
> > > > > to do so because:
> > > > > 
> > > > > 1. We avoid the scheduler deadlock issues thanks to the deferred_qs bit
> > > > > introduced in commit 23634ebc1d94 ("rcu: Check for wakeup-safe
> > > > > conditions in rcu_read_unlock_special()") by checking for the same in
> > > > > this patch.
> > > > > 
> > > > > 2. in_irq() implies in_interrupt() which implies raising softirq will
> > > > > not do any wake ups.
> > > > > 
> > > > > The rcuc thread which is awakened will run when the interrupt returns.
> > > > > 
> > > > > We also honor 25102de ("rcu: Only do rcu_read_unlock_special() wakeups
> > > > > if expedited") thus doing the rcuc awakening only when none of the
> > > > > following are true:
> > > > >   1. Critical section is blocking an expedited GP.
> > > > >   2. A nohz_full CPU.
> > > > > If neither of these cases are true (exp == false), then the "else" block
> > > > > will run to do the irq_work stuff.
> > > > > 
> > > > > This commit is based on a partial revert of d143b3d1cd89 ("rcu: Simplify
> > > > > rcu_read_unlock_special() deferred wakeups") with an additional in_irq()
> > > > > check added.
> > > > > 
> > > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > > 
> > > > OK, I will bite...  If it is safe to wake up an rcuc kthread, why
> > > > is it not safe to do raise_softirq()?
> > > 
> > > Because raise_softirq should not be done and/or doesn't do anything
> > > if use_softirq == false. In fact, RCU_SOFTIRQ doesn't even existing if
> > > use_softirq == false. The "else if" condition of this patch uses for
> > > use_softirq.
> > > 
> > > Or, did I miss your point?
> 
> I am concerned that added "else if" condition might not be sufficient
> to eliminate all possible cases of the caller holding a scheduler lock,
> which could result in deadlock in the ensuing wakeup.  Might be me missing
> something, but such deadlocks have been a recurring problem in the past.

I thought that was the whole point of the
rcu_read_unlock_special.b.deferred_qs bit that was introduced in
23634ebc1d94. We are checking that bit in the "else if" here as well. So this
should be no less immune to scheduler deadlocks any more than the preceding
"else if" where we are checking this bit.

> Also, your commit log's point #2 is "in_irq() implies in_interrupt()
> which implies raising softirq will not do any wake ups."  This mention
> of softirq seems a bit odd, given that we are going to wake up a rcuc
> kthread.  Of course, this did nothing to quell my suspicions.  ;-)

Yes, I should delete this #2 from the changelog since it is not very relevant
(I feel now). My point with #2 was that even if were to raise a softirq
(which we are not), a scheduler wakeup of ksoftirqd is impossible in this
path anyway since in_irq() implies in_interrupt().

thanks,

 - Joel


> 							Thanx, Paul
> 
> > > > And from the nit department, looks like some whitespace damage on the
> > > > comments.
> > > 
> > > I will fix all of these in the change log, it was just a quick RFC I sent
> > > with the idea, tagged as RFC and not yet for merging. I should also remove
> > > the comment about " in_irq() implies in_interrupt() which implies raising
> > > softirq" from the changelog since this patch is only concerned with the rcuc
> > > kthread.
> > 
> > Ah, I see you mean the comments on the code. Perhaps something went wrong
> > when I did 'git revert' on the original patch, or some such. Anyway, please
> > consider this as RFC-grade only. And hopefully I have been writing better
> > change logs (really trying!!).
> > 
> > thanks,
> > 
> >  - Joel
> > 
