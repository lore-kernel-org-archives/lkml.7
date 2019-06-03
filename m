Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 505BCC28CC6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 16:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29E4423F94
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 16:23:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="QGgQrPwV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729191AbfFCQXO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 12:23:14 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46507 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727162AbfFCQXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 12:23:13 -0400
Received: by mail-pf1-f195.google.com with SMTP id y11so10880210pfm.13
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 09:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JANRXtNq/OlXEVUckmhj0Gl/WVjY8ue45Pv7dcHW6sM=;
        b=QGgQrPwVRdf1FporyJuiYg8dww4nmTS56JSFMbwI0B2HL2g870kOaQE9Ywt0x006N6
         PjQFzmPuMSqVgpLiHGQiHxKi+RNegLkeQbj9M/kqEAraRxIHkA9uTMK+9MY40yM1oNUU
         5RSFX82A4bupgDJL3ID6O1kJCNBQ58xyApRr93QMRGu7ilTUQKe3S+1NMJg8dP1ccaFA
         H9LgGRGjK46Hz1/8qSOzwXc4iBACaNU/zFlTIHtoP7vs7a5etSrbMcZ3Xa4KVMiZdd7M
         27X98Iw/B26uLHcsFuTvb75LvBV0snxsJTFjnQkkPdtn8eciopq44UTkUBjqPGHN3ZFh
         JbLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JANRXtNq/OlXEVUckmhj0Gl/WVjY8ue45Pv7dcHW6sM=;
        b=doyUWv0izmqgBU2ekISB12cDkGh1ea8NR9KoR/qCevuEZ2VL/cUeP2dX0oXNFWm652
         whMRClDoWAPrvR1c8HxkX92FtnsasWvaCGf8dL2m5f6wqdhq7nP4iQKjx9OXGxDl8tXq
         2q5FjhmAyWUQbOSA2eOmsh8z+Pj/it95slDLGz6Up/N9N8wXiAuM2frWSjrsk+4g6r3F
         QApPt49I1VjOzEeNQyAk4oPJxyaQ7NzROvQs4FTcTNcCXG4Zlu/aw3n/bl6ESgtom7kA
         JoKlBRiOrSZPlATSQXHuMVkYoz94IGq8IsIEAHHLtszDgMl2bAFnqwxZ9jZog8hz+bfW
         U/iw==
X-Gm-Message-State: APjAAAXqsxBxuHgmByqvLyVI+HTi9g9q318sDpmED7J+9qQizamPkWGs
        QpomVQzAsYfyNyDWzMNzPiY8GTghTkIaEA==
X-Google-Smtp-Source: APXvYqwCufEoyFE7wi6ZCH5aXURbYNyTbhnYSnr2KtWTknjUQ1XLoDXrpTilRUIYKKwXpC5/rlOvWQ==
X-Received: by 2002:a17:90a:195e:: with SMTP id 30mr31687487pjh.116.1559578991519;
        Mon, 03 Jun 2019 09:23:11 -0700 (PDT)
Received: from [192.168.1.158] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id d10sm16947450pgh.43.2019.06.03.09.23.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 09:23:10 -0700 (PDT)
Subject: Re: [PATCH] block: fix a crash in do_task_dead()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Qian Cai <cai@lca.pw>, akpm@linux-foundation.org, hch@lst.de,
        oleg@redhat.com, gkohli@codeaurora.org, mingo@redhat.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1559161526-618-1-git-send-email-cai@lca.pw>
 <20190530080358.GG2623@hirez.programming.kicks-ass.net>
 <82e88482-1b53-9423-baad-484312957e48@kernel.dk>
 <20190603123705.GB3419@hirez.programming.kicks-ass.net>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9a75cc4f-bd14-1d98-6653-b49a2842dd16@kernel.dk>
Date:   Mon, 3 Jun 2019 10:23:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190603123705.GB3419@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/3/19 6:37 AM, Peter Zijlstra wrote:
> On Fri, May 31, 2019 at 03:12:13PM -0600, Jens Axboe wrote:
>> On 5/30/19 2:03 AM, Peter Zijlstra wrote:
> 
>>> What is the purpose of that patch ?! The Changelog doesn't mention any
>>> benefit or performance gain. So why not revert that?
>>
>> Yeah that is actually pretty weak. There are substantial performance
>> gains for small IOs using this trick, the changelog should have
>> included those. I guess that was left on the list...
> 
> OK. I've looked at the try_to_wake_up() path for these exact
> conditions and we're certainly sub-optimal there, and I think we can put
> much of this special case in there. Please see below.
> 
>> I know it's not super kosher, your patch, but I don't think it's that
>> bad hidden in a generic helper.
> 
> How about the thing that Oleg proposed? That is, not set a waiter when
> we know the loop is polling? That would avoid the need for this
> alltogether, it would also avoid any set_current_state() on the wait
> side of things.
> 
> Anyway, Oleg, do you see anything blatantly buggered with this patch?
> 
> (the stats were already dodgy for rq-stats, this patch makes them dodgy
> for task-stats too)
> 
> ---
>   kernel/sched/core.c | 38 ++++++++++++++++++++++++++++++++------
>   1 file changed, 32 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 102dfcf0a29a..474aa4c8e9d2 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1990,6 +1990,28 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
>   	unsigned long flags;
>   	int cpu, success = 0;
>   
> +	if (p == current) {
> +		/*
> +		 * We're waking current, this means 'p->on_rq' and 'task_cpu(p)
> +		 * == smp_processor_id()'. Together this means we can special
> +		 * case the whole 'p->on_rq && ttwu_remote()' case below
> +		 * without taking any locks.
> +		 *
> +		 * In particular:
> +		 *  - we rely on Program-Order guarantees for all the ordering,
> +		 *  - we're serialized against set_special_state() by virtue of
> +		 *    it disabling IRQs (this allows not taking ->pi_lock).
> +		 */
> +		if (!(p->state & state))
> +			goto out;
> +
> +		success = 1;
> +		trace_sched_waking(p);
> +		p->state = TASK_RUNNING;
> +		trace_sched_woken(p);
> +		goto out;
> +	}
> +
>   	/*
>   	 * If we are going to wake up a thread waiting for CONDITION we
>   	 * need to ensure that CONDITION=1 done by the caller can not be
> @@ -1999,7 +2021,7 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
>   	raw_spin_lock_irqsave(&p->pi_lock, flags);
>   	smp_mb__after_spinlock();
>   	if (!(p->state & state))
> -		goto out;
> +		goto unlock;
>   
>   	trace_sched_waking(p);
>   
> @@ -2029,7 +2051,7 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
>   	 */
>   	smp_rmb();
>   	if (p->on_rq && ttwu_remote(p, wake_flags))
> -		goto stat;
> +		goto unlock;
>   
>   #ifdef CONFIG_SMP
>   	/*
> @@ -2089,12 +2111,16 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
>   #endif /* CONFIG_SMP */
>   
>   	ttwu_queue(p, cpu, wake_flags);
> -stat:
> -	ttwu_stat(p, cpu, wake_flags);
> -out:
> +unlock:
>   	raw_spin_unlock_irqrestore(&p->pi_lock, flags);
>   
> -	return success;
> +out:
> +	if (success) {
> +		ttwu_stat(p, cpu, wake_flags);
> +		return true;
> +	}
> +
> +	return false;
>   }
>   
>   /**

Let me run some tests with this vs mainline vs blk wakeup hack removed.


-- 
Jens Axboe

