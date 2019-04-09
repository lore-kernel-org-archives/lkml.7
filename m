Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UPPERCASE_50_75,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19135C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 12:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8ADA20880
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 12:03:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LIoVJTzx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbfDIMDv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 08:03:51 -0400
Received: from merlin.infradead.org ([205.233.59.134]:42686 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbfDIMDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 08:03:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=UZleY8Pna256GYmyOGSkJOpZ/+HNzckf5aIj1OwDUW8=; b=LIoVJTzxRXSk31wAJmHTn7ZK5
        wfKnIinATnC1Zfwzr0LXN+FIjUKm7cy8GZbXk7Ba4257Z29sITd+awIlZdyDXLh27EFEIYxiA5TXQ
        HL1nhMEXerNRPvsC4t0VcEAQ2zX89zCgm+1KxdCdsNgbhXLPhjXUTq8MdHi164Js9NiltFxrx/MTH
        JIkK/gg2yyTHW4M2Ej0gZwFmmgvZBpWyx3AzQGFZNbQ4KRarhix7sc1eBln04tKy9lGnAiGIiGdvc
        brnkbPmdPHm8bGK1fLVDu3WfhxHSJyXOZq/9DQnHOzk5zCKwJjrAwSuZ1X3+M2iTzNSvO89ZE3pZy
        yMoCRAXUg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hDpTY-00077R-Aj; Tue, 09 Apr 2019 12:03:40 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4AE20201F29A4; Tue,  9 Apr 2019 14:03:37 +0200 (CEST)
Date:   Tue, 9 Apr 2019 14:03:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "David S . Miller" <davem@davemloft.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Ingo Molnar <mingo@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 14/37] locking/lockdep: Define per vector softirq lock
 usage states
Message-ID: <20190409120337.GZ12232@hirez.programming.kicks-ass.net>
References: <20190228171242.32144-1-frederic@kernel.org>
 <20190228171242.32144-15-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190228171242.32144-15-frederic@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 06:12:19PM +0100, Frederic Weisbecker wrote:

> @@ -35,7 +41,7 @@ struct lock_usage {
>  /*
>   * Usage-state bitmasks:
>   */
> -#define __LOCKF(__STATE)	LOCKF_##__STATE = (1 << LOCK_##__STATE),
> +#define __LOCKF(__STATE)	LOCKF_##__STATE = (1ULL << LOCK_##__STATE),
>  
>  enum {
>  #define LOCKDEP_STATE(__STATE)						\
> @@ -48,11 +54,40 @@ enum {
>  	__LOCKF(USED)
>  };
>  
> +#define LOCKF_ENABLED_SOFTIRQ \
> +	(LOCKF_ENABLED_HI_SOFTIRQ | LOCKF_ENABLED_TIMER_SOFTIRQ | \
> +	LOCKF_ENABLED_NET_TX_SOFTIRQ | LOCKF_ENABLED_NET_RX_SOFTIRQ | \
> +	LOCKF_ENABLED_BLOCK_SOFTIRQ | LOCKF_ENABLED_IRQ_POLL_SOFTIRQ | \
> +	LOCKF_ENABLED_TASKLET_SOFTIRQ | LOCKF_ENABLED_SCHED_SOFTIRQ | \
> +	 LOCKF_ENABLED_HRTIMER_SOFTIRQ | LOCKF_ENABLED_RCU_SOFTIRQ)
>  #define LOCKF_ENABLED_IRQ (LOCKF_ENABLED_HARDIRQ | LOCKF_ENABLED_SOFTIRQ)
> +
> +
> +#define LOCKF_USED_IN_SOFTIRQ \
> +	(LOCKF_USED_IN_HI_SOFTIRQ | LOCKF_USED_IN_TIMER_SOFTIRQ | \
> +	LOCKF_USED_IN_NET_TX_SOFTIRQ | LOCKF_USED_IN_NET_RX_SOFTIRQ | \
> +	LOCKF_USED_IN_BLOCK_SOFTIRQ | LOCKF_USED_IN_IRQ_POLL_SOFTIRQ | \
> +	LOCKF_USED_IN_TASKLET_SOFTIRQ | LOCKF_USED_IN_SCHED_SOFTIRQ | \
> +	 LOCKF_USED_IN_HRTIMER_SOFTIRQ | LOCKF_USED_IN_RCU_SOFTIRQ)
>  #define LOCKF_USED_IN_IRQ (LOCKF_USED_IN_HARDIRQ | LOCKF_USED_IN_SOFTIRQ)
>  
> +
> +#define LOCKF_ENABLED_SOFTIRQ_READ \
> +	(LOCKF_ENABLED_HI_SOFTIRQ_READ | LOCKF_ENABLED_TIMER_SOFTIRQ_READ | \
> +	LOCKF_ENABLED_NET_TX_SOFTIRQ_READ | LOCKF_ENABLED_NET_RX_SOFTIRQ_READ | \
> +	LOCKF_ENABLED_BLOCK_SOFTIRQ_READ | LOCKF_ENABLED_IRQ_POLL_SOFTIRQ_READ | \
> +	LOCKF_ENABLED_TASKLET_SOFTIRQ_READ | LOCKF_ENABLED_SCHED_SOFTIRQ_READ | \
> +	 LOCKF_ENABLED_HRTIMER_SOFTIRQ_READ | LOCKF_ENABLED_RCU_SOFTIRQ_READ)
>  #define LOCKF_ENABLED_IRQ_READ \
>  		(LOCKF_ENABLED_HARDIRQ_READ | LOCKF_ENABLED_SOFTIRQ_READ)
> +
> +
> +#define LOCKF_USED_IN_SOFTIRQ_READ \
> +	(LOCKF_USED_IN_HI_SOFTIRQ_READ | LOCKF_USED_IN_TIMER_SOFTIRQ_READ | \
> +	LOCKF_USED_IN_NET_TX_SOFTIRQ_READ | LOCKF_USED_IN_NET_RX_SOFTIRQ_READ | \
> +	LOCKF_USED_IN_BLOCK_SOFTIRQ_READ | LOCKF_USED_IN_IRQ_POLL_SOFTIRQ_READ | \
> +	LOCKF_USED_IN_TASKLET_SOFTIRQ_READ | LOCKF_USED_IN_SCHED_SOFTIRQ_READ | \
> +	 LOCKF_USED_IN_HRTIMER_SOFTIRQ_READ | LOCKF_USED_IN_RCU_SOFTIRQ_READ)
>  #define LOCKF_USED_IN_IRQ_READ \
>  		(LOCKF_USED_IN_HARDIRQ_READ | LOCKF_USED_IN_SOFTIRQ_READ)
>  
> diff --git a/kernel/locking/lockdep_states.h b/kernel/locking/lockdep_states.h
> index 35ca09f2ed0b..34ff569d2024 100644
> --- a/kernel/locking/lockdep_states.h
> +++ b/kernel/locking/lockdep_states.h
> @@ -5,4 +5,6 @@
>   * you add one, or come up with a nice dynamic solution.
>   */
>  LOCKDEP_STATE(HARDIRQ)
> -LOCKDEP_STATE(SOFTIRQ)
> +#define SOFTIRQ_VECTOR(__SVEC) LOCKDEP_STATE(__SVEC##_SOFTIRQ)
> +#include <linux/softirq_vector.h>
> +#undef SOFTIRQ_VECTOR

Would something like the below help?

---
Subject: locking/lockdep: Generate LOCKF_ bit composites
From: Peter Zijlstra <peterz@infradead.org>
Date: Tue Apr  9 13:59:03 CEST 2019

Instead of open-coding the bitmasks, generate them using the
lockdep_states.h header.

This prepares for additional states, which would make the manual masks
tedious and error prone.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/locking/lockdep_internals.h |   28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

--- a/kernel/locking/lockdep_internals.h
+++ b/kernel/locking/lockdep_internals.h
@@ -42,13 +42,29 @@ enum {
 	__LOCKF(USED)
 };
 
-#define LOCKF_ENABLED_IRQ (LOCKF_ENABLED_HARDIRQ | LOCKF_ENABLED_SOFTIRQ)
-#define LOCKF_USED_IN_IRQ (LOCKF_USED_IN_HARDIRQ | LOCKF_USED_IN_SOFTIRQ)
+#define LOCKDEP_STATE(__STATE)	LOCKF_ENABLED_##__STATE |
+static const u64 LOCKF_ENABLED_IRQ =
+#include "lockdep_states.h"
+	0;
+#undef LOCKDEP_STATE
 
-#define LOCKF_ENABLED_IRQ_READ \
-		(LOCKF_ENABLED_HARDIRQ_READ | LOCKF_ENABLED_SOFTIRQ_READ)
-#define LOCKF_USED_IN_IRQ_READ \
-		(LOCKF_USED_IN_HARDIRQ_READ | LOCKF_USED_IN_SOFTIRQ_READ)
+#define LOCKDEP_STATE(__STATE)	LOCKF_USED_IN_##__STATE |
+static const u64 LOCKF_USED_IN_IRQ =
+#include "lockdep_states.h"
+	0;
+#undef LOCKDEP_STATE
+
+#define LOCKDEP_STATE(__STATE)	LOCKF_ENABLED_##__STATE##_READ |
+static const u64 LOCKF_ENABLED_IRQ_READ =
+#include "lockdep_states.h"
+	0;
+#undef LOCKDEP_STATE
+
+#define LOCKDEP_STATE(__STATE)	LOCKF_USED_IN_##__STATE##_READ |
+static const u64 LOCKF_USED_IN_IRQ_READ =
+#include "lockdep_states.h"
+	0;
+#undef LOCKDEP_STATE
 
 /*
  * CONFIG_LOCKDEP_SMALL is defined for sparc. Sparc requires .text,
