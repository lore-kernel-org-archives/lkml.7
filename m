Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DA63C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 08:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34C5F20679
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 08:11:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rxPQWpq1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730272AbfG3ILk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 04:11:40 -0400
Received: from merlin.infradead.org ([205.233.59.134]:55952 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726870AbfG3ILk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 04:11:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=lqG3hFLeHki6KlZNi6gozV3r9j/aZGFzc0fdJeJSVQ8=; b=rxPQWpq1LSCp6jnJK/v6L8dDR
        SkDfaijqdixP9Xmv7Riil22otsXN/ASK8qonDt1a1WnmCwcZFzOTSgAbcTOGAJ/q0YjwnjWVOAN4J
        aQItm82TxPGN0WVkOpGnPl0gdgabuNsroTPsKVPIGkdefwHCL43Mywg9MUHzTccgCcvBp/fp4Tg4Y
        yb89urip9Lk2Qp+GyN86WBbHtK6btdzda9xLD4lNnQyxBqeCeVecQ6vHWKegBrGJD6R9nuf6igjct
        DKTn0E8lGqly9r6I8JgKv/fXzc1I4FI5mzOw56W98AiFk6F9PGvDdRWJkXs8fM1iS6LW9Cqh9J+Sr
        mV+nqySTw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hsNEB-0005KX-Sn; Tue, 30 Jul 2019 08:11:24 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A37B120D27EAA; Tue, 30 Jul 2019 10:11:22 +0200 (CEST)
Date:   Tue, 30 Jul 2019 10:11:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     mingo@redhat.com, lizefan@huawei.com, hannes@cmpxchg.org,
        axboe@kernel.dk, dennis@kernel.org, dennisszhou@gmail.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Nick Kralevich <nnk@google.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/1] psi: do not require setsched permission from the
 trigger creator
Message-ID: <20190730081122.GH31381@hirez.programming.kicks-ass.net>
References: <20190730013310.162367-1-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730013310.162367-1-surenb@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 06:33:10PM -0700, Suren Baghdasaryan wrote:
> When a process creates a new trigger by writing into /proc/pressure/*
> files, permissions to write such a file should be used to determine whether
> the process is allowed to do so or not. Current implementation would also
> require such a process to have setsched capability. Setting of psi trigger
> thread's scheduling policy is an implementation detail and should not be
> exposed to the user level. Remove the permission check by using _nocheck
> version of the function.
> 
> Suggested-by: Nick Kralevich <nnk@google.com>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  kernel/sched/psi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> index 7acc632c3b82..ed9a1d573cb1 100644
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -1061,7 +1061,7 @@ struct psi_trigger *psi_trigger_create(struct psi_group *group,
>  			mutex_unlock(&group->trigger_lock);
>  			return ERR_CAST(kworker);
>  		}
> -		sched_setscheduler(kworker->task, SCHED_FIFO, &param);
> +		sched_setscheduler_nocheck(kworker->task, SCHED_FIFO, &param);

ARGGH, wtf is there a FIFO-99!! thread here at all !?

>  		kthread_init_delayed_work(&group->poll_work,
>  				psi_poll_work);
>  		rcu_assign_pointer(group->poll_kworker, kworker);
> -- 
> 2.22.0.709.g102302147b-goog
> 
