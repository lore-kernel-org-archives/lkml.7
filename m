Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A16CAC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 22:56:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 623E722DD6
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 22:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566341771;
	bh=2Zpa60hZVRQkazDf3ZZKLh1oujn1zayH94geVq+MgWs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=natVHaUOwmKjY0vNdZwsCgkdZWcFNuM6pMFJzS5gndcHNIKV04xXIwj6cuVxKi8uN
	 8naMMLsPrDiV/uTrSuDTr16l1wiCBxc5pXjrc4i//cpKFigyQWWwNGZN7RGMGBUz3e
	 C+sBjusbdisKyHwlEf3lwQCN8IM5kID+y2UADcRU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbfHTW4K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 18:56:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:38054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726141AbfHTW4J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 18:56:09 -0400
Received: from localhost (lfbn-ncy-1-174-150.w83-194.abo.wanadoo.fr [83.194.254.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0EEA220C01;
        Tue, 20 Aug 2019 22:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566341768;
        bh=2Zpa60hZVRQkazDf3ZZKLh1oujn1zayH94geVq+MgWs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gdYM/OLSRFSC9hWj88mWZ+XyEW/Ug41z/uGV8QHl8E3/N8PfBouncPkCqyqaeRxV8
         +MjNpwqhVahjVysERJDiJlRelWwNZMjtyzO+JS9k4sKHcDiH5/uZDsOfPLO5qFaCsG
         KbuefywUaxckDJM7HI7zsYGS2eREGuNcjVsuMz1Y=
Date:   Wed, 21 Aug 2019 00:56:06 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: Re: [patch 04/44] posix-cpu-timers: Fixup stale comment
Message-ID: <20190820225604.GI2093@lenoir>
References: <20190819143141.221906747@linutronix.de>
 <20190819143801.747233612@linutronix.de>
 <20190820142658.GG2093@lenoir>
 <alpine.DEB.2.21.1908201946320.2223@nanos.tec.linutronix.de>
 <20190820204803.GH2093@lenoir>
 <alpine.DEB.2.21.1908202331080.2223@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1908202331080.2223@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2019 at 11:43:26PM +0200, Thomas Gleixner wrote:
> On Tue, 20 Aug 2019, Frederic Weisbecker wrote:
> No it can't do that throughout posix_cpu_timer_del() because exit_itimers()
> can only look at current->signal->posix_timers which does not contain the
> posix timers owned by a different task/process.
> 
> We could of course invoke posix_cpu_timers_exit() from exit_itimers() but
> does that buy anything?
>  
> > It would make things more simple to delete the timer off the target from
> > the same caller and place and we could remove posix_cpu_timers_exit*().
> 
> We can't. The foreign owned cpu timers are not in cur->signal->posix_timers
> so how should we invoke posix_cpu_timer_del() on them. Only the owner task
> can. The only thing the exiting task can do is to remove the foreign timer
> from it's expiry list which has nothing to do with cur->signal->posix_timers.

That's exactly what I'm proposing. I think you're misunderstanding me.

I want the owner to handle all the list deletion work from the target.

Ok let's imagine a timer $ITIMER, owned by task $OWNER and whose target is task $TARGET.

So it's enqueued on $OWNER->signal->posix_timers and $TARGET->cputime_expires.

Two scenarios can happen:

1) $TARGET exits first and is released. So it calls posix_cpu_timers_exit()
   which deletes $ITIMER from $TARGET->cputime_expires.

   Later on, $OWNER exits and calls exit_itimers() -> timer_delete_hook($ITIMER)
   -> posix_cpu_timer_del($ITIMER). It finds $TARGET as the target of $ITIMER but no
   more sighand. So it returns.

2) $OWNER exits first and calls exit_itimer() -> timer_delete_hook($ITIMER)
   -> posix_cpu_timer_del($ITIMER). It finds $TARGET as the target of $ITIMER and it
   finds a sighand to lock. So it deletes $ITIMER from $TARGET->cputime_expires
   (see list_del(&timer->it.cpu.entry)).


So I propose to change the behaviour of case 1) so that $TARGET doesn't call
posix_cpu_timers_exit(). We instead wait for $OWNER to exit and call
exit_itimers()  -> timer_delete_hook($ITIMER) -> posix_cpu_timer_del($ITIMER).
It is going to find $TARGET as the target of $ITIMER but no more sighand. Then
finally it removes $ITIMER from $TARGET->cputime_expires.
We basically do the same thing as in 2) but without locking sighand since it's NULL
on $TARGET at this time.

I hope I'm less confusing (if not confused).

Thanks.
