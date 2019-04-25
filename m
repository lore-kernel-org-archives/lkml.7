Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0462C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 16:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65D2E20693
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 16:41:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729646AbfDYQk6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 12:40:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44494 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728090AbfDYQk6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 12:40:58 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id ADEB9DC8E8;
        Thu, 25 Apr 2019 16:40:57 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.38])
        by smtp.corp.redhat.com (Postfix) with SMTP id 5EAE160C70;
        Thu, 25 Apr 2019 16:40:55 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 25 Apr 2019 18:40:56 +0200 (CEST)
Date:   Thu, 25 Apr 2019 18:40:54 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] rcu/sync: simplify the state machine
Message-ID: <20190425164054.GA21309@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Thu, 25 Apr 2019 16:40:57 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let me finally try to close the gestalt ;)

This version doesn't add the new features yet, and it doesn't remove the
"must die" rcu_sync_enter_start(). But with this patch we are ready, just
I think that this should come as a separate change.

To simplify the review, see the the most important parts of the code with
the patch applied below.

Oleg.
-------------------------------------------------------------------------------

struct rcu_sync {
	int			gp_state;
	int			gp_count;
	wait_queue_head_t	gp_wait;

	struct rcu_head		cb_head;
};

enum { GP_IDLE = 0, GP_ENTER, GP_PASSED, GP_EXIT, GP_REPLAY };

#define	rss_lock	gp_wait.lock

static void rcu_sync_call(struct rcu_sync *rsp)
{
	call_rcu(&rsp->cb_head, rcu_sync_func);
}

static void rcu_sync_func(struct rcu_head *rcu)
{
	struct rcu_sync *rsp = container_of(rcu, struct rcu_sync, cb_head);
	unsigned long flags;

	WARN_ON_ONCE(rsp->gp_state == GP_IDLE);
	WARN_ON_ONCE(rsp->gp_state == GP_PASSED);

	spin_lock_irqsave(&rsp->rss_lock, flags);
	if (rsp->gp_count) {
		/*
		 * We're at least a GP after the GP_IDLE->GP_ENTER transition.
		 */
		rsp->gp_state = GP_PASSED;
		wake_up_locked(&rsp->gp_wait);
	} else if (rsp->gp_state == GP_REPLAY) {
		/*
		 * A new rcu_sync_exit() has happened; requeue the callback to
		 * catch a later GP.
		 */
		rsp->gp_state = GP_EXIT;
		rcu_sync_call(rsp);
	} else {
		/*
		 * We're at least a GP after the last rcu_sync_exit(); eveybody
		 * will now have observed the write side critical section.
		 * Let 'em rip!.
		 */
		rsp->gp_state = GP_IDLE;
	}
	spin_unlock_irqrestore(&rsp->rss_lock, flags);
}

void rcu_sync_enter(struct rcu_sync *rsp)
{
	int gp_state;

	spin_lock_irq(&rsp->rss_lock);
	gp_state = rsp->gp_state;
	if (gp_state == GP_IDLE) {
		rsp->gp_state = GP_ENTER;
		WARN_ON_ONCE(rsp->gp_count);
		/*
		 * Note that we could simply do rcu_sync_call(rsp) here and
		 * avoid the "if (gp_state == GP_IDLE)" block below.
		 *
		 * However, synchronize_rcu() can be faster if rcu_expedited
		 * or rcu_blocking_is_gp() is true.
		 *
		 * Another reason is that we can't wait for rcu callback if
		 * we are called at early boot time but this shouldn't happen.
		 */
	}
	rsp->gp_count++;
	spin_unlock_irq(&rsp->rss_lock);

	if (gp_state == GP_IDLE) {
		/*
		 * See the comment above, this simply does the "synchronous"
		 * call_rcu(rcu_sync_func) which does GP_ENTER -> GP_PASSED.
		 */
		synchronize_rcu();
		rcu_sync_func(&rsp->cb_head);
		/* Not really needed, wait_event() would see GP_PASSED. */
		return;
	}

	wait_event(rsp->gp_wait, rsp->gp_state >= GP_PASSED);
}

void rcu_sync_exit(struct rcu_sync *rsp)
{
	WARN_ON_ONCE(rsp->gp_state == GP_IDLE);
	WARN_ON_ONCE(rsp->gp_count == 0);

	spin_lock_irq(&rsp->rss_lock);
	if (!--rsp->gp_count) {
		if (rsp->gp_state == GP_PASSED) {
			rsp->gp_state = GP_EXIT;
			rcu_sync_call(rsp);
		} else if (rsp->gp_state == GP_EXIT) {
			rsp->gp_state = GP_REPLAY;
		}
	}
	spin_unlock_irq(&rsp->rss_lock);
}

