Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D7AC33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 19:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56FED2072C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 19:45:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgAFTpt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 14:45:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:42946 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726657AbgAFTpt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 14:45:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4C53EAD11;
        Mon,  6 Jan 2020 19:45:47 +0000 (UTC)
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     rpenyaev@suse.de
Cc:     akpm@linux-foundation.org, dave@stgolabs.net, jbaron@akamai.com,
        linux-kernel@vger.kernel.org, normalperson@yhbt.net,
        viro@zeniv.linux.org.uk, Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH] fs/epoll: rework safewake for CONFIG_DEBUG_LOCK_ALLOC
Date:   Mon,  6 Jan 2020 11:38:30 -0800
Message-Id: <20200106193830.27224-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <76f656dc7ac92f92682641e22e1c44c4@suse.de>
References: <76f656dc7ac92f92682641e22e1c44c4@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some comments on:

      f6520c52084 (epoll: simplify ep_poll_safewake() for CONFIG_DEBUG_LOCK_ALLOC)

For one this does not play nice with preempt_rt as disabling irq and
then taking a spinlock_t is a no no; the critical region becomes
preemptible. This is particularly important as -rt is being mainlined.

Secondly, it is really ugly compared to what we had before - albeit not
having to deal with all the ep_call_nested() checks, but I doubt this
overhead matters at all with CONFIG_DEBUG_LOCK_ALLOC.

While the current logic avoids nesting by disabling irq during the whole
path, this seems like an overkill under debug. This patch proposes using
this_cpu_inc_return() then taking the irq-safe lock - albeit a possible
irq coming in the middle between these operations and messing up the
subclass. If this is unacceptable, we could always revert the patch,
as this was never a problem in the first place.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---

This is pretty much untested - I wanted to see what is the best way to
address the concerns first.

XXX: I don't think we need get/put_cpu() around the call, this was intended
only for ep_call_nested() tasks_call_list checking afaict.

 fs/eventpoll.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 67a395039268..97d036deff3e 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -558,16 +558,17 @@ static void ep_poll_safewake(wait_queue_head_t *wq)
 	unsigned long flags;
 	int subclass;
 
-	local_irq_save(flags);
-	preempt_disable();
-	subclass = __this_cpu_read(wakeup_nest);
-	spin_lock_nested(&wq->lock, subclass + 1);
-	__this_cpu_inc(wakeup_nest);
+	subclass = this_cpu_inc_return(wakeup_nest);
+	/*
+	 * Careful: while unlikely, an irq can occur here and mess up
+	 * the subclass. The same goes for right before the dec
+	 * operation, but that does not matter.
+	 */
+	spin_lock_irqsave_nested(&wq->lock, flags, subclass + 1);
 	wake_up_locked_poll(wq, POLLIN);
-	__this_cpu_dec(wakeup_nest);
-	spin_unlock(&wq->lock);
-	local_irq_restore(flags);
-	preempt_enable();
+	spin_unlock_irqrestore(&wq->lock, flags);
+
+	this_cpu_dec(wakeup_nest);
 }
 
 #else
-- 
2.16.4

