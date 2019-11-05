Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3CF1C010CF
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 12:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B571D2190F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 12:43:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fBDfxUqB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388632AbfKEMn4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 07:43:56 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37824 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388222AbfKEMn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 07:43:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=BYqT6LFVheeUgdVWoeMKnOo/JvbMJ1xDalHrtoiDp60=; b=fBDfxUqB95k7m5LR/S0Lb3l37
        flXq5AWYITPgOIrUWH+dcz2mDYKSsnRDIRZXy+AL7n2HNihEosFB8AZBwNF+Qm/Js83ghARuvZ2CE
        q5JJlBtP1C2KK96PxgJWtrZ0ccKM5e71JIm+yZNP62vmVM0nLKr34s3+yG87gh4AQmyK+iIglO0E/
        f9uNHnu8L1UdICXp1BImi5MPGgbuwV/Qnwy4LcSE/eC6zRO99eluwuJ9YiRnJMSA5ipFd+8Q11kCZ
        RF0yYoyL8MvLCnyB5BkQ3+n9mFGRjWh5o4ztwxxDc07WQUgl+gkBzFIXB5c6YzMhV+M4zficdDUPU
        RiE6ISnkg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iRyBe-0001qB-1v; Tue, 05 Nov 2019 12:43:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 51A53301747;
        Tue,  5 Nov 2019 13:42:48 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F326A20247BC3; Tue,  5 Nov 2019 13:43:51 +0100 (CET)
Date:   Tue, 5 Nov 2019 13:43:51 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Scott Wood <swood@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] timers/nohz: Update nohz load even if tick already
 stopped
Message-ID: <20191105124351.GN4131@hirez.programming.kicks-ass.net>
References: <20191028150716.22890-1-frederic@kernel.org>
 <20191029100506.GJ4114@hirez.programming.kicks-ass.net>
 <52d963553deda810113accd8d69b6dffdb37144f.camel@redhat.com>
 <20191030133130.GY4097@hirez.programming.kicks-ass.net>
 <813ed21938aa47b15f35f8834ffd98ad4dd27771.camel@redhat.com>
 <alpine.DEB.2.21.1911042315390.17054@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1911050042250.17054@nanos.tec.linutronix.de>
 <7b782bc880a29eb7d37f2c2aff73c43e7f7d032f.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b782bc880a29eb7d37f2c2aff73c43e7f7d032f.camel@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 05, 2019 at 01:30:58AM -0600, Scott Wood wrote:
> The warning is due to kernel/sched/idle.c not updating curr->se.exec_start.

Ah, indeed so.

> While debugging I noticed an issue with a particular load pattern.  The CPU
> goes non-nohz for a brief time at an interval very close to twice 
> tick_period.  When the tick is started, the timer expiration is more than
> tick_period in the past, so hrtimer_forward() tries to catch up by adding
> 2*tick_period to the expiration.  Then the tick is stopped before that new
> expiration, and when the tick is woken up the expiry is again advanced by
> 2*tick_period with the timer never actually running.  sched_tick_remote()
> does fire every second, but there are streaks of several seconds where it
> keeps catching the CPU in a non-nohz state, so neither the normal nor remote
> ticks are calling calc_load_nohz_remote().
> 
> Is there a reason to not just remove the hrtimer_forward() from
> tick_nohz_restart(), letting the timer fire if it's in the past, which will
> take care of doing hrtimer_forward()?

I'll have to look into that. I always get confused by all that nohz code
:/

> As for the warning in sched_tick_remote(), it seems like a test for time
> since the last tick on this cpu (remote or otherwise) would be better than
> relying on curr->se.exec_start, in order to detect things like this.

I don't think we have a timestamp that is shared between the remote and
local tick. Also, there is a reason this warning uses the task time
accounting, there used to be (as in, I can't find it in a hurry) code
that could not deal with >u32 (~4s) clock updates.

The below should have idle keep the timestamp up-to-date. Keeping
accurate idle->se.sum_exec_runtime doesn't seem too interesting, the
idle code already keeps track of total idle times.

---

--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -381,6 +381,7 @@ static void put_prev_task_idle(struct rq
 
 static void set_next_task_idle(struct rq *rq, struct task_struct *next)
 {
+	curr->se.exec_start = rq_clock_task(rq);
 	update_idle_core(rq);
 	schedstat_inc(rq->sched_goidle);
 }
@@ -417,6 +418,7 @@ dequeue_task_idle(struct rq *rq, struct
  */
 static void task_tick_idle(struct rq *rq, struct task_struct *curr, int queued)
 {
+	curr->se.exec_start = rq_clock_task(rq);
 }
 
 static void switched_to_idle(struct rq *rq, struct task_struct *p)
