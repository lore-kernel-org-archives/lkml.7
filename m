Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC40DC5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 19:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C55562075C
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 19:15:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732070AbfKFTP3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 14:15:29 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45099 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727208AbfKFTP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 14:15:29 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iSQm6-0001pl-Sj; Wed, 06 Nov 2019 20:15:27 +0100
Date:   Wed, 6 Nov 2019 20:15:25 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Eric Dumazet <edumazet@google.com>
cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        syzbot <syzkaller@googlegroups.com>
Subject: Re: [PATCH] hrtimer: Annotate lockless access to timer->state
In-Reply-To: <CANn89iK12QGBagUiNr+j-ToawJ9J1behtySyL9vLattYPAD-7w@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1911062002490.1869@nanos.tec.linutronix.de>
References: <20191106174804.74723-1-edumazet@google.com> <alpine.DEB.2.21.1911061908070.1869@nanos.tec.linutronix.de> <CANn89iK12QGBagUiNr+j-ToawJ9J1behtySyL9vLattYPAD-7w@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Nov 2019, Eric Dumazet wrote:
> On Wed, Nov 6, 2019 at 10:09 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > On Wed, 6 Nov 2019, Eric Dumazet wrote:
> > > @@ -1013,8 +1013,9 @@ static void __remove_hrtimer(struct hrtimer *timer,
> > >  static inline int
> > >  remove_hrtimer(struct hrtimer *timer, struct hrtimer_clock_base *base, bool restart)
> > >  {
> > > -     if (hrtimer_is_queued(timer)) {
> > > -             u8 state = timer->state;
> > > +     u8 state = timer->state;
> >
> > Shouldn't that be a read once then at least for consistency sake?
> 
> We own the lock here, this is not really needed ?
> 
> Note they are other timer->state reads I chose to leave unchanged.
> 
> But no big deal if you prefer I can add a READ_ONCE()

Nah. I can add it myself if at all.

I know that the READ_ONCE() is not required there, but I really hate to
twist my brain when staring at code why some places use it and some not.

So at least some commentry helps to avoid that. Something like the
below. If you have no objections I just queue the patch with this folded
in.

Thanks,

	tglx

8<-------------
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -456,12 +456,18 @@ extern u64 hrtimer_next_event_without(co
 
 extern bool hrtimer_active(const struct hrtimer *timer);
 
-/*
- * Helper function to check, whether the timer is on one of the queues
+/**
+ * hrtimer_is_queued = check, whether the timer is on one of the queues
+ * @timer:	Timer to check
+ *
+ * Returns: True if the timer is queued, false otherwise
+ *
+ * The function can be used lockless, but it gives only a momentary snapshot.
  */
-static inline int hrtimer_is_queued(struct hrtimer *timer)
+static inline bool hrtimer_is_queued(struct hrtimer *timer)
 {
-	return READ_ONCE(timer->state) & HRTIMER_STATE_ENQUEUED;
+	/* The READ_ONCE pairs with the update functions of timer->state */
+	return !!READ_ONCE(timer->state) & HRTIMER_STATE_ENQUEUED;
 }
 
 /*
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -966,6 +966,7 @@ static int enqueue_hrtimer(struct hrtime
 
 	base->cpu_base->active_bases |= 1 << base->index;
 
+	/* Pairs with the lockless read in hrtimer_is_queued() */
 	WRITE_ONCE(timer->state, HRTIMER_STATE_ENQUEUED);
 
 	return timerqueue_add(&base->active, &timer->node);
@@ -988,6 +989,7 @@ static void __remove_hrtimer(struct hrti
 	struct hrtimer_cpu_base *cpu_base = base->cpu_base;
 	u8 state = timer->state;
 
+	/* Pairs with the lockless read in hrtimer_is_queued() */
 	WRITE_ONCE(timer->state, newstate);
 	if (!(state & HRTIMER_STATE_ENQUEUED))
 		return;
