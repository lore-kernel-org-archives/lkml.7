Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D1DEC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 17:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D31C12077B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 17:44:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JVwA2FoW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbfCMRoM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 13:44:12 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37414 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbfCMRoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 13:44:12 -0400
Received: by mail-pg1-f195.google.com with SMTP id q206so2038257pgq.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 10:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=PHiYwjVjk4CRq/ZawQLXKB21ReH1/sTDD0VHZgzrKyA=;
        b=JVwA2FoW7aydj/5UujeMvA2EjXFvewsQNDEtH0sH2gn4WY7/8sOGuRQBFhWLgN4hRA
         JoCpQWTTWOlxCoeZ1AXJHfEVrod0fiVTtPMFRYFdsW3j56pfqp8DSKzOZr5zQRW5aHtp
         w81V7/sNBdIAO0L5zGHeFhBrHbZhC89Wd759tUckeAS58mykdV3hC8ZCEXWtFjYDVmmG
         uoy69ZUzsyMf6b7CYmc/qPZM52QXtQ3IB6cQjg8m34/B/CLT1ecXpgC52B/xkZF2iCty
         /qp8sy2i4MdhxFzaqHwI5bjoWCw9d2gsKjWIcJ9ZqY0n35M7HoA5iFXcJFGNhr/Dpk+l
         sRjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=PHiYwjVjk4CRq/ZawQLXKB21ReH1/sTDD0VHZgzrKyA=;
        b=dVxIUXHO4LSVLJF6mbYgHxwRa9xxbu4RmAjrJYUn6kFCCEP6I3vJXNrcfZkz3DOb2l
         P0tM2R9sLwNFroFsrUQYHPk/oe+29GMS407PQv17zgyXGgWf4Sm2BqIoTm7WAMDKa/Rg
         jbkwesbHDH5YPYahdAJ2r9Ks9tiKvBuUjS9ZmLhm642VOxfJGw6Fk22DO4UcPbp3xAEL
         1GlHoaxcAjEIKJhPg849dTQhg7nSyKR+/rvXzuPZ3mJPziHoo3NzPSueLhX96Agw+MBp
         c0kNNIP27x8kVHQ8f9wai/LVcZb0jKYc3xQNbXY3PD5K3Ibeik5QiKtXYhxo1q24FRq2
         Ai6w==
X-Gm-Message-State: APjAAAWF7YCxcdFbndlPVNXK6WPHtmQQzP3OhCcKavaDoSXci3hxQL7u
        9FwJZQcGlbKPXpJ0zHa0uMVwyGOG7IY=
X-Google-Smtp-Source: APXvYqwF5+nwFmPVe2daHsIUj/BR/dv44OI1kqA8zoI0RwGK5erLZn/jBRxVDqD1Xy9HSWgPMJvOWQ==
X-Received: by 2002:a17:902:765:: with SMTP id 92mr45814327pli.95.1552499051144;
        Wed, 13 Mar 2019 10:44:11 -0700 (PDT)
Received: from bsegall-linux.svl.corp.google.com.localhost ([2620:15c:2cd:202:39d7:98b3:2536:e93f])
        by smtp.gmail.com with ESMTPSA id j4sm19079111pfn.132.2019.03.13.10.44.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Mar 2019 10:44:09 -0700 (PDT)
From:   bsegall@google.com
To:     Phil Auld <pauld@redhat.com>
Cc:     mingo@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC]  sched/fair: hard lockup in sched_cfs_period_timer
References: <xm26ef7mzew2.fsf@bsegall-linux.svl.corp.google.com>
        <20190304190510.GB5366@lorien.usersys.redhat.com>
        <xm268sxtyx5u.fsf@bsegall-linux.svl.corp.google.com>
        <20190305200554.GA8786@pauld.bos.csb>
        <xm261s3lyrrl.fsf@bsegall-linux.svl.corp.google.com>
        <20190306162313.GB8786@pauld.bos.csb>
        <xm26wolbyfe9.fsf@bsegall-linux.svl.corp.google.com>
        <20190309203320.GA24464@lorien.usersys.redhat.com>
        <xm26sgvtxq4m.fsf@bsegall-linux.svl.corp.google.com>
        <20190311202536.GK25201@pauld.bos.csb>
        <20190312135746.GB24002@pauld.bos.csb>
Date:   Wed, 13 Mar 2019 10:44:09 -0700
In-Reply-To: <20190312135746.GB24002@pauld.bos.csb> (Phil Auld's message of
        "Tue, 12 Mar 2019 09:57:46 -0400")
Message-ID: <xm26ef7ay8ie.fsf@bsegall-linux.svl.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Phil Auld <pauld@redhat.com> writes:

> On Mon, Mar 11, 2019 at 04:25:36PM -0400 Phil Auld wrote:
>> On Mon, Mar 11, 2019 at 10:44:25AM -0700 bsegall@google.com wrote:
>> > Letting it spin for 100ms and then only increasing by 6% seems extremely
>> > generous. If we went this route I'd probably say "after looping N
>> > times, set the period to time taken / N + X%" where N is like 8 or
>> > something. I think I'd probably perfer something like this to the
>> > previous "just abort and let it happen again next interrupt" one.
>> 
>> Okay. I'll try to spin something up that does this. It may be a little 
>> trickier to keep the quota proportional to the new period. I think that's 
>> important since we'll be changing the user's setting.
>> 
>> Do you mean to have it break when it hits N and recalculates the period or 
>> reset the counter and keep going?
>> 
>
> Let me know what you think of the below. It's working nicely. I like your 
> suggestion to limit it quickly based on number of loops and use that to 
> scale up. I think it is best to break out and let it fire again if needed. 
> The warning fires once, very occasionally twice, and then things are quiet.
>
> If that looks reasonable I'll do some more testing and spin it up as a real 
> patch submission. 

Yeah, this looks reasonable. I should probably see how unreasonable the
other thing would be, but if your previous periods were kinda small (and
it's just that the machine crashing isn't an ok failure mode) I suppose
it's not a big deal.

>
> Cheers,
> Phil
> ---
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 310d0637fe4b..54b30adfc89e 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4859,19 +4859,51 @@ static enum hrtimer_restart sched_cfs_slack_timer(struct hrtimer *timer)
>  	return HRTIMER_NORESTART;
>  }
>  
> +extern const u64 max_cfs_quota_period;
> +int cfs_period_autotune_loop_limit   = 8;
> +int cfs_period_autotune_cushion_pct  = 15; /* percentage added to period recalculation */
> +
>  static enum hrtimer_restart sched_cfs_period_timer(struct hrtimer *timer)
>  {
>  	struct cfs_bandwidth *cfs_b =
>  		container_of(timer, struct cfs_bandwidth, period_timer);
> +	s64 nsstart, nsnow, new_period;
>  	int overrun;
>  	int idle = 0;
> +	int count = 0;
>  
>  	raw_spin_lock(&cfs_b->lock);
> +	nsstart = ktime_to_ns(hrtimer_cb_get_time(timer));
>  	for (;;) {
>  		overrun = hrtimer_forward_now(timer, cfs_b->period);
>  		if (!overrun)
>  			break;
>  
> +		if (++count > cfs_period_autotune_loop_limit) {
> +			ktime_t old_period = ktime_to_ns(cfs_b->period);
> +
> +			nsnow = ktime_to_ns(hrtimer_cb_get_time(timer));
> +			new_period = (nsnow - nsstart)/cfs_period_autotune_loop_limit;
> +
> +			/*  Make sure new period will be larger than old. */
> +			if (new_period < old_period) {
> +				new_period = old_period;
> +			}
> +			new_period += (new_period *  cfs_period_autotune_cushion_pct) / 100;

This ordering means that it will always increase by at least 15%. This
is a bit odd but probably a good thing; I'd just change the comment to
make it clear this is deliberate.

> +
> +			if (new_period >  max_cfs_quota_period)
> +				new_period = max_cfs_quota_period;
> +
> +			cfs_b->period = ns_to_ktime(new_period);
> +			cfs_b->quota += (cfs_b->quota * ((new_period - old_period) * 100)/old_period)/100;

In general it makes sense to do fixed point via 1024 or something that
can be optimized into shifts (and a larger number is better in general
for better precision).

> +			pr_warn_ratelimited(
> +				"cfs_period_timer[cpu%d]: period too short, scaling up (new cfs_period_us %lld, cfs_quota_us = %lld)\n",
> +				smp_processor_id(), cfs_b->period/NSEC_PER_USEC, cfs_b->quota/NSEC_PER_USEC);
> +
> +			idle = 0;
> +			break;
> +		}
> +
>  		idle = do_sched_cfs_period_timer(cfs_b, overrun);
>  	}
>  	if (idle)
