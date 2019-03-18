Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A540CC10F0D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 17:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 734AC2133F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 17:14:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jyNUanH4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbfCRRO0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 13:14:26 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44766 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbfCRROZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 13:14:25 -0400
Received: by mail-pf1-f195.google.com with SMTP id a3so11690775pff.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 10:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=bBmgVAjFdmfqGUqUdMvk9AKQpYUsjO12/gYbDmtCG98=;
        b=jyNUanH4Doua+xbdyy0ni7nURdyoqk2DwTxm7Xo0rS+Uxf6sXenew1ad7l6nei8yhV
         uDQG2QwFg5ZLREkMlUKj8LM78weI5FKzbC7vwnd9zY/TvP7zKbA5BiDTFtQKVzhgAkD8
         Hq9CjoW5RidJ0+gX0Ws1qEhh5K3uK0sv+OIZyeY8rqC8my2SUPoNssqxQPyRZkoH05++
         0gO2XEOBKhe9F3sh0YWAzHpJ720jYALVopuBbp6998NDMCbc/b49NSRuUCROXOfnWJ9g
         zpe8jHyHp8WVERvo/1MC1ISlrRykD1PuEp3TpqPnE2DSh2PdVww+meLEs9UDIyfD0Ste
         V/QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=bBmgVAjFdmfqGUqUdMvk9AKQpYUsjO12/gYbDmtCG98=;
        b=DJ608MBrs4HkEQMorQdnCTBjgv2SOpgD8TIb7/tmH/R2Ln2ynsdqGQjxuHQL+ResUR
         ue1/ZMA9u5j9RMsdbk1X8hH9FJQGINcn4Y6vtiBb4XTTcdf8pHILDKOBtOsSyCnmUjkv
         VLLQDTapsRtBst8jQC1O17KR6NFtuqcFhiOo7iIeZm/Pz7zo7cFsI4ZiD2IcXlNQ3WdT
         5lI7VPLZYpndDW6mcSBeZ+Yl5nvgvjSyN2Jb1v/7O9TaidyRq4wBGb721x3DCieaiQo2
         MHdMmTq7wz3hhdEakgN/mbHxDd8zhckVKBvZtCOxDomNmGjv8UivJwo6TS8SGvPuy9Rg
         8Sqg==
X-Gm-Message-State: APjAAAW5pt1ey5yVBdBxfi87TBhJsrW8KOhLa9AqFbWn6Sy4lM2QYFHC
        HUkcPKhtaXEK2KO42h9EAN26dA==
X-Google-Smtp-Source: APXvYqzuMzjQrHhS1LDHxQRUOSZ1YVX+8McTxC8DJ0AOfEg79mlxjvKZGu6TgvOgsZYQ63bs20obvg==
X-Received: by 2002:a63:1f52:: with SMTP id q18mr3611044pgm.134.1552929264541;
        Mon, 18 Mar 2019 10:14:24 -0700 (PDT)
Received: from bsegall-linux.svl.corp.google.com.localhost ([2620:15c:2cd:202:39d7:98b3:2536:e93f])
        by smtp.gmail.com with ESMTPSA id 202sm12281063pfc.86.2019.03.18.10.14.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Mar 2019 10:14:23 -0700 (PDT)
From:   bsegall@google.com
To:     Phil Auld <pauld@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH] sched/fair: Limit sched_cfs_period_timer loop to avoid hard lockup
References: <20190313150826.16862-1-pauld@redhat.com>
        <20190315101150.GV5996@hirez.programming.kicks-ass.net>
        <20190315153042.GF27131@pauld.bos.csb>
        <20190315160347.GZ5996@hirez.programming.kicks-ass.net>
        <20190318132916.GA15377@pauld.bos.csb>
Date:   Mon, 18 Mar 2019 10:14:22 -0700
In-Reply-To: <20190318132916.GA15377@pauld.bos.csb> (Phil Auld's message of
        "Mon, 18 Mar 2019 09:29:17 -0400")
Message-ID: <xm264l80xfyp.fsf@bsegall-linux.svl.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Phil Auld <pauld@redhat.com> writes:

> On Fri, Mar 15, 2019 at 05:03:47PM +0100 Peter Zijlstra wrote:
>> On Fri, Mar 15, 2019 at 11:30:42AM -0400, Phil Auld wrote:
>> 
>> >> I'll rework the maths in the averaged version and post v2 if that makes sense.
>> > 
>> > It may have the extra timer fetch, although maybe I could rework it so that it used the 
>> > nsstart time the first time and did not need to do it twice in a row. I had originally
>> > reverted the hrtimer_forward_now() to hrtimer_forward() but put that back. 
>> 
>> Sure; but remember, simpler is often better, esp. for code that
>> typically 'never' runs.
>
> I reworked it to the below. This settles a bit faster. The average is sort of squishy because
> it's 3 samples divided by 4.  And if we stay in a single call after updating the period the "average"
> will be even less accurate. 
>
> It settles at a larger value faster so produces fewer messages and none of the callback supressed ones.
> The added complexity may not be worth it, though.
>
> I think this or your version, either one, would work.  
>
> What needs to happen now to get one of them to land somewhere? Should I just repost one with my 
> signed-off and let you add whatever other tags?  And if so do you have a preference for which one?  
>
> Also, Ben, thoughts?

It would probably make sense to have it just be ++count > 4 then I
think? But otherwise yeah, I'm fine with either.

>
> Cheers,
> Phil
>
> --
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index ea74d43924b2..297fd228fdb0 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4885,6 +4885,8 @@ static enum hrtimer_restart sched_cfs_slack_timer(struct hrtimer *timer)
>  	return HRTIMER_NORESTART;
>  }
>  
> +extern const u64 max_cfs_quota_period;
> +
>  static enum hrtimer_restart sched_cfs_period_timer(struct hrtimer *timer)
>  {
>  	struct cfs_bandwidth *cfs_b =
> @@ -4892,14 +4894,46 @@ static enum hrtimer_restart sched_cfs_period_timer(struct hrtimer *timer)
>  	unsigned long flags;
>  	int overrun;
>  	int idle = 0;
> +	int count = 0;
> +	u64 start, now;
>  
>  	raw_spin_lock_irqsave(&cfs_b->lock, flags);
> +	now = start = ktime_to_ns(hrtimer_cb_get_time(timer));
>  	for (;;) {
> -		overrun = hrtimer_forward_now(timer, cfs_b->period);
> +		overrun = hrtimer_forward(timer, now, cfs_b->period);
>  		if (!overrun)
>  			break;
>  
> +		if (++count > 3) {
> +			u64 new, old = ktime_to_ns(cfs_b->period);
> +
> +                        /* rough average of the time each loop is taking
> +			  * really should be (n-s)/3 but this is easier for the machine
> +			  */
> +			new = (now - start) >> 2; 
> +			if (new < old)
> +				new = old;
> +			new = (new * 147) / 128; /* ~115% */
> +			new = min(new, max_cfs_quota_period);
> +
> +			cfs_b->period = ns_to_ktime(new);
> +
> +			/* since max is 1s, this is limited to 1e9^2, which fits in u64 */
> +			cfs_b->quota *= new;
> +			cfs_b->quota /= old;
> +
> +			pr_warn_ratelimited(
> +	"cfs_period_timer[cpu%d]: period too short, scaling up (new cfs_period_us %lld, cfs_quota_us = %lld)\n",
> +				smp_processor_id(),
> +				new/NSEC_PER_USEC,
> +				cfs_b->quota/NSEC_PER_USEC);
> +
> +			/* reset count so we don't come right back in here */
> +			count = 0;
> +		}
> +
>  		idle = do_sched_cfs_period_timer(cfs_b, overrun, flags);
> +		now = ktime_to_ns(hrtimer_cb_get_time(timer));
>  	}
>  	if (idle)
>  		cfs_b->period_active = 0;
