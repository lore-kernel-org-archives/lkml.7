Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DCEBC31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 12:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 627B420657
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 12:24:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qDV9zLZM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbfFQMYy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 08:24:54 -0400
Received: from merlin.infradead.org ([205.233.59.134]:60712 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfFQMYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 08:24:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ogBWW673hHbNRpyPPNuCdeL95hTbjPj0Y1iyd8f4B90=; b=qDV9zLZM+exdC+5gLlvAskNoS
        Pfm+u+Hf/zBCInkojkxzbNcIy1/6dISzvoL2sEukNZVvZNmxzc/a/LfixZL6/BGraSQD0OpwtzYjf
        rhO3u80gpUL9NeL2z1HuPhj5NKNGTyavzAtgBS5SQKDsAilDy9g3GSr2lfZXzIfnldH1pHT5A+2Nq
        CtBmTN0BYipdrUqhrImwujHgV2QtEYpHRWGVSBaS/CD8g4Lb4BoRUaMnwq7uU+IC8+Su8grgxp7mK
        AwxdQneNr049LBTF3VvFwvY3IjTkGLhEdrZzk3ptKZI8xX5mV/0Sj6eTqvbBygV3paIgFLmMdyDoD
        UehD9HIHw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hcqgr-0007EJ-JZ; Mon, 17 Jun 2019 12:24:50 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 15DCE201D1C97; Mon, 17 Jun 2019 14:24:48 +0200 (CEST)
Date:   Mon, 17 Jun 2019 14:24:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        tglx@linutronix.de, John Ogness <john.ogness@linutronix.de>,
        richard@nod.at
Subject: Re: [PATCH] sched: Document =?utf-8?Q?that?=
 =?utf-8?Q?_RT_task_priorities_are_1=E2=80=A699?=
Message-ID: <20190617122448.GA3436@hirez.programming.kicks-ass.net>
References: <20190403210821.10916-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190403210821.10916-1-bigeasy@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 11:08:21PM +0200, Sebastian Andrzej Siewior wrote:
> John identified three files which claim that RT task priorities start at
> zero. As far as I understand, 0 is used for DL and has nothing to do
> wihich RT priorities as identified by the RT policy.
> 
> Correct the comment, valid RT priorities are in the range from 1 to 99.

It all depends on what view I'm afraid. User priorities go from 1-99, as
per sched_get_priority_{min,max}(), but Kernel priority is:

 kernel_prio := MAX_RT_PRIO-1 - user_prio

and that then gives [0-98], where 0 is max and 98 is min (see
__sched_setscheduler() and normal_prio()).

And DL uses kernel prio -1 (there is no user prio equivalent).

Nice maps to:

 kernel_prio := MAX_RT_PRIO + (MAX_NICE - MIN_NICE + 1) / 2 + user_nice

which is: [100-139].

Which then, as derRichard says, leaves (kernel) 99 unaccounted for.


> Reported-by: John Ogness <john.ogness@linutronix.de>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  Documentation/scheduler/sched-rt-group.txt | 2 +-
>  include/linux/sched/prio.h                 | 2 +-
>  kernel/sched/cpupri.h                      | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/scheduler/sched-rt-group.txt b/Documentation/scheduler/sched-rt-group.txt
> index d8fce3e784574..23f8f8465a775 100644
> --- a/Documentation/scheduler/sched-rt-group.txt
> +++ b/Documentation/scheduler/sched-rt-group.txt
> @@ -175,7 +175,7 @@ get their allocated time.
>  
>  Implementing SCHED_EDF might take a while to complete. Priority Inheritance is
>  the biggest challenge as the current linux PI infrastructure is geared towards
> -the limited static priority levels 0-99. With deadline scheduling you need to
> +the limited static priority levels 1-99. With deadline scheduling you need to
>  do deadline inheritance (since priority is inversely proportional to the
>  deadline delta (deadline - now)).
>  

This might be correct,.. but I feel we should strive to delete
everything rt groups.

> diff --git a/include/linux/sched/prio.h b/include/linux/sched/prio.h
> index 7d64feafc408e..6986c32356842 100644
> --- a/include/linux/sched/prio.h
> +++ b/include/linux/sched/prio.h
> @@ -8,7 +8,7 @@
>  
>  /*
>   * Priority of a process goes from 0..MAX_PRIO-1, valid RT
> - * priority is 0..MAX_RT_PRIO-1, and SCHED_NORMAL/SCHED_BATCH
> + * priority is 1..MAX_RT_PRIO-1, and SCHED_NORMAL/SCHED_BATCH
>   * tasks are in the range MAX_RT_PRIO..MAX_PRIO-1. Priority
>   * values are inverted: lower p->prio value means higher priority.
>   *

So that comment talks about kernel prio, and there, as we've shown, 0 is
an actual valid RR/FIFO priority (in fact, the highest).

> diff --git a/kernel/sched/cpupri.h b/kernel/sched/cpupri.h
> index 7dc20a3232e72..40257a97fb8f2 100644
> --- a/kernel/sched/cpupri.h
> +++ b/kernel/sched/cpupri.h
> @@ -5,7 +5,7 @@
>  #define CPUPRI_INVALID		-1
>  #define CPUPRI_IDLE		 0
>  #define CPUPRI_NORMAL		 1
> -/* values 2-101 are RT priorities 0-99 */
> +/* values 2-101 are RT priorities 1-99 */

Again, this is kernel prios, not user prios.

>  struct cpupri_vec {
>  	atomic_t		count;
> -- 
> 2.20.1
> 
