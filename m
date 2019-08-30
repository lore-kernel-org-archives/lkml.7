Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFBE3C3A5A4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 10:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99D212073F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 10:41:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BcBhRd6+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbfH3Klz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 06:41:55 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36968 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727434AbfH3Klz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 06:41:55 -0400
Received: by mail-pl1-f196.google.com with SMTP id bj8so3200941plb.4
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 03:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=q05DhHEnCoDT5I56H/M2ahJoXZvDFRVu5ln4bhnllRo=;
        b=BcBhRd6+K28OuQaF/kodze6BvREmM/GdC+mLsdSTUEHy3h+XoM5848sXDzV9efqnh9
         mIIE+QCh8nR6LJ1U+OZgjByjBA+78jm2fMZXz0Wm9nxxnIw7uml339+Zn+of0n/uEwbC
         KWZUF9TgVuYcgT5lk+VJU3cAf5kkrZzNZhJ9iYVC+R3JRHowSYD5n1QAsGFDIkkwXOWg
         UfTTGyeJczSl0/KWSXBiGy+Eoe+HWU3jFVyx9UAcpf/zxK4bmDmNJwqBpscouGfz0gx0
         ZBj8+FB2lqyCM0hfyIQG8o92OcLawF9IUItH2tfbvy0FgPHB9/6/eUCHl3fEKZdp1Hub
         iwjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=q05DhHEnCoDT5I56H/M2ahJoXZvDFRVu5ln4bhnllRo=;
        b=oUkcycNW4BzLqIaRKwJ8zlkIpOeLr2iJJb7EBrB66nrENaJekBxy9K5EkcEiPsKivp
         6406gX7cGFeEt5crEvO2oMOOpTTUxCvYXd8oDa7QJ2PqkHJwjxajiPPYceVvJq9B6wcS
         bLMSSIb07ehEYzixyPkAbQZF/ZVAWj1LUCijBWxpVfWu8gxt2woKxpc0tW8FgNMskEds
         Zxi5NbmUbAkKWQQrTWIJPa0GExxXkPcBnOL4j1xnSgN1WXO0p7HXTNDLwgNb5GzSMs77
         0bySSgoJxAipQP90gI1y2jIyETymBXLbK/hMqR2IzkHs/X2NORhZjJjHr5bhLGfX1F+3
         MbPQ==
X-Gm-Message-State: APjAAAXp5PV0tuYHSmhD6GS6J6Auy/zMlYMDevkNsIC1d2pRYrw+e53d
        lr3uv3R04ffc7DyQpOHdq4M=
X-Google-Smtp-Source: APXvYqxlP3RKIpEy8DvgzIDIAw/CmqfXzCW54gwqdTo8Ke5an4X84CCOGNfT3QKO59B9F7jBS5RC4Q==
X-Received: by 2002:a17:902:c9:: with SMTP id a67mr8892798pla.178.1567161714272;
        Fri, 30 Aug 2019 03:41:54 -0700 (PDT)
Received: from satendra-MM061.ib-wrb304n.setup.in ([103.82.150.183])
        by smtp.gmail.com with ESMTPSA id u10sm5945184pfn.94.2019.08.30.03.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2019 03:41:53 -0700 (PDT)
From:   Satendra Singh Thakur <sst2005@gmail.com>
Cc:     satendrasingh.thakur@hcl.com, tglx@linutronix.de,
        Satendra Singh Thakur <sst2005@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] [semaphore] Removed redundant code from semaphore's down family of function
Date:   Fri, 30 Aug 2019 16:10:10 +0530
Message-Id: <20190830104011.15568-1-sst2005@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190826142557.GM2386@hirez.programming.kicks-ass.net>
References: <20190826142557.GM2386@hirez.programming.kicks-ass.net>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Aug 2019 16:25:57 +0200, Peter Zijlstra wrote:
>On Mon, Aug 26, 2019 at 04:14:36PM +0200, Peter Zijlstra wrote:
> > (XXX, we should probably move the schedule_timeout() thing into its own
> > patch)
>
> A better version here...
>
> ---
> Subject: sched,time: Allow better constprop/DCE for schedule_timeout()
> 
> If timeout is constant and MAX_SCHEDULE_TIMEOUT, it would be nice to
> allow to optimize away everything timeout.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
> include/linux/sched.h | 13 ++++++++++++-
> kernel/time/timer.c   | 52 ++++++++++++++++++++++++---------------------------
> 2 files changed, 36 insertions(+), 29 deletions(-)
>
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index f0edee94834a..6003e96bce52 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -214,7 +214,18 @@ extern void scheduler_tick(void);
> 
> #define	MAX_SCHEDULE_TIMEOUT		LONG_MAX
> 
> -extern long schedule_timeout(long timeout);
> +extern long __schedule_timeout(long timeout);
> +
> +static inline long schedule_timeout(long timeout)
> +{
> +	if (__builtin_constant_p(timeout) && timeout == MAX_SCHEDULE_TIMEOUT) {
> +		schedule();
> +		return timeout;
> +	}
> +
> +	return __schedule_timeout(timeout);
> +}
> +
> extern long schedule_timeout_interruptible(long timeout);
> extern long schedule_timeout_killable(long timeout);
> extern long schedule_timeout_uninterruptible(long timeout);
> diff --git a/kernel/time/timer.c b/kernel/time/timer.c
> index 0e315a2e77ae..912ae56b96b8 100644
> --- a/kernel/time/timer.c
> +++ b/kernel/time/timer.c
> @@ -1851,38 +1851,34 @@ static void process_timeout(struct timer_list *t)
>  * jiffies will be returned.  In all cases the return value is guaranteed
>  * to be non-negative.
>  */
> -signed long __sched schedule_timeout(signed long timeout)
> +signed long __sched __schedule_timeout(signed long timeout)
> {
> 	struct process_timer timer;
> 	unsigned long expire;
> 
> -	switch (timeout)
> -	{
> -	case MAX_SCHEDULE_TIMEOUT:
> -		/*
> -		 * These two special cases are useful to be comfortable
> -		 * in the caller. Nothing more. We could take
> -		 * MAX_SCHEDULE_TIMEOUT from one of the negative value
> -		 * but I' d like to return a valid offset (>=0) to allow
> -		 * the caller to do everything it want with the retval.
> -		 */
> +	/*
> +	 * We could take MAX_SCHEDULE_TIMEOUT from one of the negative values,
> +	 * but I'd like to return a valid offset (>= 0) to allow the caller to
> +	 * do everything it wants with the retval.
> +	 */
> +	if (timeout == MAX_SCHEDULE_TIMEOUT) {
> 		schedule();
> -		goto out;
Hi Mr Peter,
I have a suggestion here:
The condition timeout == MAX_SCHEDULE_TIMEOUT is already handled in
schedule_timeout function and  same conditon is handled again in __schedule_timeout.
Currently, no other function calls __schedule_timeout except schedule_timeout.
Therefore, it seems this condition will never become true.

This conditon will only be true when __schedule_timeout is called directly from kernel
with timeout = MAX_SCHEDULE_TIMEOUT. This case may be rare. Therefore, we can modify it as

if (unlikely(timeout == MAX_SCHEDULE_TIMEOUT))

Please let me know your comments.
Thanks
Satendra
> -	default:
> -		/*
> -		 * Another bit of PARANOID. Note that the retval will be
> -		 * 0 since no piece of kernel is supposed to do a check
> -		 * for a negative retval of schedule_timeout() (since it
> -		 * should never happens anyway). You just have the printk()
> -		 * that will tell you if something is gone wrong and where.
> -		 */
> -		if (timeout < 0) {
> -			printk(KERN_ERR "schedule_timeout: wrong timeout "
> +		return timeout;
> +	}
> +
> +	/*
> +	 * Another bit of PARANOID. Note that the retval will be 0 since no
> +	 * piece of kernel is supposed to do a check for a negative retval of
> +	 * schedule_timeout() (since it should never happens anyway). You just
> +	 * have the printk() that will tell you if something is gone wrong and
> +	 * where.
> +	 */
> +	if (timeout < 0) {
> +		printk(KERN_ERR "schedule_timeout: wrong timeout "
> 				"value %lx\n", timeout);
> -			dump_stack();
> -			current->state = TASK_RUNNING;
> -			goto out;
> -		}
> +		dump_stack();
> +		current->state = TASK_RUNNING;
> +		goto out;
> 	}
> 
> 	expire = timeout + jiffies;
> @@ -1898,10 +1894,10 @@ signed long __sched schedule_timeout(signed long timeout)
> 
> 	timeout = expire - jiffies;
> 
> - out:
> +out:
> 	return timeout < 0 ? 0 : timeout;
> }
> -EXPORT_SYMBOL(schedule_timeout);
> +EXPORT_SYMBOL(__schedule_timeout);
>
> /*
>  * We can use __set_current_state() here because schedule_timeout() calls
