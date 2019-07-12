Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 044F6C742AB
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 06:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBE54208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 06:33:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726020AbfGLGdj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 02:33:39 -0400
Received: from lgeamrelo13.lge.com ([156.147.23.53]:34777 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725562AbfGLGdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 02:33:39 -0400
Received: from unknown (HELO lgeamrelo02.lge.com) (156.147.1.126)
        by 156.147.23.53 with ESMTP; 12 Jul 2019 15:33:36 +0900
X-Original-SENDERIP: 156.147.1.126
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO X58A-UD3R) (10.177.222.33)
        by 156.147.1.126 with ESMTP; 12 Jul 2019 15:33:36 +0900
X-Original-SENDERIP: 10.177.222.33
X-Original-MAILFROM: byungchul.park@lge.com
Date:   Fri, 12 Jul 2019 15:32:40 +0900
From:   Byungchul Park <byungchul.park@lge.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@lge.com
Subject: Re: [PATCH] rcu: Make jiffies_till_sched_qs writable
Message-ID: <20190712063240.GD7702@X58A-UD3R>
References: <20190708125013.GG26519@linux.ibm.com>
 <20190708130359.GA42888@google.com>
 <20190709055815.GA19459@X58A-UD3R>
 <20190709124102.GR26519@linux.ibm.com>
 <20190710012025.GA20711@X58A-UD3R>
 <20190711123052.GI26519@linux.ibm.com>
 <20190711130849.GA212044@google.com>
 <20190711150215.GK26519@linux.ibm.com>
 <20190711164818.GA260447@google.com>
 <20190711195839.GA163275@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190711195839.GA163275@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 11, 2019 at 03:58:39PM -0400, Joel Fernandes wrote:
> Hmm, speaking of grace period durations, it seems to me the maximum grace
> period ever is recorded in rcu_state.gp_max. However it is not read from
> anywhere.
> 
> Any idea why it was added but not used?
> 
> I am interested in dumping this value just for fun, and seeing what I get.
> 
> I wonder also it is useful to dump it in rcutorture/rcuperf to find any
> issues, or even expose it in sys/proc fs to see what worst case grace periods
> look like.

Hi,

	commit ae91aa0adb14dc33114d566feca2f7cb7a96b8b7
	rcu: Remove debugfs tracing

removed all debugfs tracing, gp_max also included.

And you sounds great. And even looks not that hard to add it like,

:)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index ad9dc86..86095ff 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1658,8 +1658,10 @@ static void rcu_gp_cleanup(void)
 	raw_spin_lock_irq_rcu_node(rnp);
 	rcu_state.gp_end = jiffies;
 	gp_duration = rcu_state.gp_end - rcu_state.gp_start;
-	if (gp_duration > rcu_state.gp_max)
+	if (gp_duration > rcu_state.gp_max) {
 		rcu_state.gp_max = gp_duration;
+		trace_rcu_grace_period(something something);
+	}
 
 	/*
 	 * We know the grace period is complete, but to everyone else

Thanks,
Byungchul

