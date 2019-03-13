Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0EB6C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 20:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B01B32177E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 20:26:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kDU3dku8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbfCMU04 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 16:26:56 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:32802 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbfCMU0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 16:26:54 -0400
Received: by mail-pf1-f195.google.com with SMTP id i19so2194199pfd.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 13:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=vfQDGtDuI2pUZ3xg/Qy5HKyynIL0XD94qLG7Comcyus=;
        b=kDU3dku8r05e+7L0NLsm+VXdjCrqK7dYLuN174iJ8OJEOtfY4THldOleOf0UlcdbVh
         jdPO7F18mqotor9Q5WbO7vsqTOkyiKwfeNRoI4o6GsLDkMLdmGY+3QE4rvDB6A2LrHHP
         CC7FXJVeWbQhjlxXITe8SpvSXYz6jgI8ti3JS1qIpWzGXQznDyFQZE66pE3iM3QeHcjr
         LMLNew2oBejEMEBayK08H+5S1tzMOtUEsdyK2jHMOYVeubL+2DQ7AXV7/vb/J92ibTss
         xSMrpy7GGT3mxDE7V+ah57pXbiyopqGZjLB+/bSzMWQ1F4Ie3Vh2fchajJ1qbbW+kkMd
         h3zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=vfQDGtDuI2pUZ3xg/Qy5HKyynIL0XD94qLG7Comcyus=;
        b=QvFYwG5H1J7dk38pJhf0Xl2Q9/QrYCRWGxwOvZs27zDY0jOifpEfl5uL1uKC6f6tY2
         KJA5+R2vXU6tFZ11PUlvHatNbdKC3OeAL+md/F/ZtriEcrPcXvaKi5OAPq+SVpxwPaXa
         copjpkL806+y8RsmgpmDTtmXkk47GMGtKQlAbUfbqybHivlnRGah5OcFByA4Jv4WAqoP
         5m/vofm7Y16HNi2m9NqxcVIowU9QBqZhALn4LWufId+9rM2hHXYM8+vRPbqSuTUaNvFw
         IaS0gYUDubqifrFXyIwwqMhH2HYPASrm2N2zC5rjGLRduv1Kd8t6MgByQeRIut/AiPgP
         832g==
X-Gm-Message-State: APjAAAX+a6+KV0vKwvj5LKrRdclJ0WKdVgWfdalnHQfRnulBR4opKoUq
        4C2iZVm/NocTrA/1cR0wTQHEZuSA03w=
X-Google-Smtp-Source: APXvYqz6QWOlgVFIvIL+ZQtVJucOF3xLuHFc/QSZt8HFIvLjagyI5IwvH2jGyRJJxvu8sMcoh/uJGQ==
X-Received: by 2002:a17:902:f83:: with SMTP id 3mr49204695plz.125.1552508813427;
        Wed, 13 Mar 2019 13:26:53 -0700 (PDT)
Received: from bsegall-linux.svl.corp.google.com.localhost ([2620:15c:2cd:202:39d7:98b3:2536:e93f])
        by smtp.gmail.com with ESMTPSA id d86sm27014763pfm.18.2019.03.13.13.26.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Mar 2019 13:26:52 -0700 (PDT)
From:   bsegall@google.com
To:     Phil Auld <pauld@redhat.com>
Cc:     mingo@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC]  sched/fair: hard lockup in sched_cfs_period_timer
References: <xm268sxtyx5u.fsf@bsegall-linux.svl.corp.google.com>
        <20190305200554.GA8786@pauld.bos.csb>
        <xm261s3lyrrl.fsf@bsegall-linux.svl.corp.google.com>
        <20190306162313.GB8786@pauld.bos.csb>
        <xm26wolbyfe9.fsf@bsegall-linux.svl.corp.google.com>
        <20190309203320.GA24464@lorien.usersys.redhat.com>
        <xm26sgvtxq4m.fsf@bsegall-linux.svl.corp.google.com>
        <20190311202536.GK25201@pauld.bos.csb>
        <20190312135746.GB24002@pauld.bos.csb>
        <xm26ef7ay8ie.fsf@bsegall-linux.svl.corp.google.com>
        <20190313185026.GD24002@pauld.bos.csb>
Date:   Wed, 13 Mar 2019 13:26:51 -0700
In-Reply-To: <20190313185026.GD24002@pauld.bos.csb> (Phil Auld's message of
        "Wed, 13 Mar 2019 14:50:26 -0400")
Message-ID: <xm26a7hyy0z8.fsf@bsegall-linux.svl.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Phil Auld <pauld@redhat.com> writes:

> On Wed, Mar 13, 2019 at 10:44:09AM -0700 bsegall@google.com wrote:
>> Phil Auld <pauld@redhat.com> writes:
>> 
>> > On Mon, Mar 11, 2019 at 04:25:36PM -0400 Phil Auld wrote:
>> >> On Mon, Mar 11, 2019 at 10:44:25AM -0700 bsegall@google.com wrote:
>> >> > Letting it spin for 100ms and then only increasing by 6% seems extremely
>> >> > generous. If we went this route I'd probably say "after looping N
>> >> > times, set the period to time taken / N + X%" where N is like 8 or
>> >> > something. I think I'd probably perfer something like this to the
>> >> > previous "just abort and let it happen again next interrupt" one.
>> >> 
>> >> Okay. I'll try to spin something up that does this. It may be a little 
>> >> trickier to keep the quota proportional to the new period. I think that's 
>> >> important since we'll be changing the user's setting.
>> >> 
>> >> Do you mean to have it break when it hits N and recalculates the period or 
>> >> reset the counter and keep going?
>> >> 
>> >
>> > Let me know what you think of the below. It's working nicely. I like your 
>> > suggestion to limit it quickly based on number of loops and use that to 
>> > scale up. I think it is best to break out and let it fire again if needed. 
>> > The warning fires once, very occasionally twice, and then things are quiet.
>> >
>> > If that looks reasonable I'll do some more testing and spin it up as a real 
>> > patch submission. 
>> 
>> Yeah, this looks reasonable. I should probably see how unreasonable the
>> other thing would be, but if your previous periods were kinda small (and
>> it's just that the machine crashing isn't an ok failure mode) I suppose
>> it's not a big deal.
>> 
>
> I posted it a little while ago. The periods were tiny (~2000us vs a minimum 
> of 1000) and with 2500 mostly unused child cgroups (I didn't narrow that 
> down much but it did reproduce still with 1250 children).  That's why I was 
> thinking edge case. It also requires a fairly small quota and load to make 
> sure cfs_rqs get throttled.

Ok, yeah, that's below the level where I'm too worried about it. It's
still bad to spend a ms in IRQ in the case of tons of child cgroups, but
1-2ms periods are definitely way less than what is really sensible for cfsb.

>
> I'm still wrapping my head around the scheduler code but I'd be happy to 
> try it the other way if you can give me a bit more description of what
> you have in mind. Also happy to test a patch with my repro.

Eh, I was more saying to myself, though I'm a bit busy.

The idea is that the only reason for the walk_tg_from is that we need
two pieces of information for every cfs_rq: a) if it is currently
throttled, and b) how much total time it has spent throttled. We
currently update these for all children during throttle/unthrottle
rather than have the children search through their ancestors to avoid
the cost when doing other work. However, all children who don't have a
quota set will all have identical throttle_count, and all children who
have never had a quota set will have identical throttle time (I
previously hadn't thought of the additional restriction required for the
second case here). Thus we could share the data structure for all these
identical cases, and then only have to look at children who have quota
set, or have in the past. Setting things up to walk this sort of reduced
tree of "tgs/cfs_rqs that have ever used cfs_b" would be a pain and
mirror the existing tg tree setup, but be possible.

This would be no help if the children sometimes have a quota (say if
only a few ever use it at a time but eventually all of them do, or they
do initially during some setup or something), and would just make things
worse with additional memory/cache pressure.

>
>
> Cheers,
> Phil
>
>
>> >
>> > Cheers,
>> > Phil
>> > ---
>> >
>> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> > index 310d0637fe4b..54b30adfc89e 100644
>> > --- a/kernel/sched/fair.c
>> > +++ b/kernel/sched/fair.c
>> > @@ -4859,19 +4859,51 @@ static enum hrtimer_restart sched_cfs_slack_timer(struct hrtimer *timer)
>> >  	return HRTIMER_NORESTART;
>> >  }
>> >  
>> > +extern const u64 max_cfs_quota_period;
>> > +int cfs_period_autotune_loop_limit   = 8;
>> > +int cfs_period_autotune_cushion_pct  = 15; /* percentage added to period recalculation */
>> > +
>> >  static enum hrtimer_restart sched_cfs_period_timer(struct hrtimer *timer)
>> >  {
>> >  	struct cfs_bandwidth *cfs_b =
>> >  		container_of(timer, struct cfs_bandwidth, period_timer);
>> > +	s64 nsstart, nsnow, new_period;
>> >  	int overrun;
>> >  	int idle = 0;
>> > +	int count = 0;
>> >  
>> >  	raw_spin_lock(&cfs_b->lock);
>> > +	nsstart = ktime_to_ns(hrtimer_cb_get_time(timer));
>> >  	for (;;) {
>> >  		overrun = hrtimer_forward_now(timer, cfs_b->period);
>> >  		if (!overrun)
>> >  			break;
>> >  
>> > +		if (++count > cfs_period_autotune_loop_limit) {
>> > +			ktime_t old_period = ktime_to_ns(cfs_b->period);
>> > +
>> > +			nsnow = ktime_to_ns(hrtimer_cb_get_time(timer));
>> > +			new_period = (nsnow - nsstart)/cfs_period_autotune_loop_limit;
>> > +
>> > +			/*  Make sure new period will be larger than old. */
>> > +			if (new_period < old_period) {
>> > +				new_period = old_period;
>> > +			}
>> > +			new_period += (new_period *  cfs_period_autotune_cushion_pct) / 100;
>> 
>> This ordering means that it will always increase by at least 15%. This
>> is a bit odd but probably a good thing; I'd just change the comment to
>> make it clear this is deliberate.
>> 
>> > +
>> > +			if (new_period >  max_cfs_quota_period)
>> > +				new_period = max_cfs_quota_period;
>> > +
>> > +			cfs_b->period = ns_to_ktime(new_period);
>> > +			cfs_b->quota += (cfs_b->quota * ((new_period - old_period) * 100)/old_period)/100;
>> 
>> In general it makes sense to do fixed point via 1024 or something that
>> can be optimized into shifts (and a larger number is better in general
>> for better precision).
>> 
>> > +			pr_warn_ratelimited(
>> > +				"cfs_period_timer[cpu%d]: period too short, scaling up (new cfs_period_us %lld, cfs_quota_us = %lld)\n",
>> > +				smp_processor_id(), cfs_b->period/NSEC_PER_USEC, cfs_b->quota/NSEC_PER_USEC);
>> > +
>> > +			idle = 0;
>> > +			break;
>> > +		}
>> > +
>> >  		idle = do_sched_cfs_period_timer(cfs_b, overrun);
>> >  	}
>> >  	if (idle)
