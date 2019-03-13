Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DEF3C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 21:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFB152077B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 21:10:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbfCMVKg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 17:10:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49940 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726263AbfCMVKf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 17:10:35 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D07F03092663;
        Wed, 13 Mar 2019 21:10:34 +0000 (UTC)
Received: from pauld.bos.csb (dhcp-17-51.bos.redhat.com [10.18.17.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8A55B5C57A;
        Wed, 13 Mar 2019 21:10:32 +0000 (UTC)
Date:   Wed, 13 Mar 2019 17:10:30 -0400
From:   Phil Auld <pauld@redhat.com>
To:     bsegall@google.com
Cc:     mingo@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC]  sched/fair: hard lockup in sched_cfs_period_timer
Message-ID: <20190313211030.GE24002@pauld.bos.csb>
References: <xm261s3lyrrl.fsf@bsegall-linux.svl.corp.google.com>
 <20190306162313.GB8786@pauld.bos.csb>
 <xm26wolbyfe9.fsf@bsegall-linux.svl.corp.google.com>
 <20190309203320.GA24464@lorien.usersys.redhat.com>
 <xm26sgvtxq4m.fsf@bsegall-linux.svl.corp.google.com>
 <20190311202536.GK25201@pauld.bos.csb>
 <20190312135746.GB24002@pauld.bos.csb>
 <xm26ef7ay8ie.fsf@bsegall-linux.svl.corp.google.com>
 <20190313185026.GD24002@pauld.bos.csb>
 <xm26a7hyy0z8.fsf@bsegall-linux.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xm26a7hyy0z8.fsf@bsegall-linux.svl.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Wed, 13 Mar 2019 21:10:34 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 01:26:51PM -0700 bsegall@google.com wrote:
> Phil Auld <pauld@redhat.com> writes:
> 
> > On Wed, Mar 13, 2019 at 10:44:09AM -0700 bsegall@google.com wrote:
> >> Phil Auld <pauld@redhat.com> writes:
> >> 
> >> > On Mon, Mar 11, 2019 at 04:25:36PM -0400 Phil Auld wrote:
> >> >> On Mon, Mar 11, 2019 at 10:44:25AM -0700 bsegall@google.com wrote:
> >> >> > Letting it spin for 100ms and then only increasing by 6% seems extremely
> >> >> > generous. If we went this route I'd probably say "after looping N
> >> >> > times, set the period to time taken / N + X%" where N is like 8 or
> >> >> > something. I think I'd probably perfer something like this to the
> >> >> > previous "just abort and let it happen again next interrupt" one.
> >> >> 
> >> >> Okay. I'll try to spin something up that does this. It may be a little 
> >> >> trickier to keep the quota proportional to the new period. I think that's 
> >> >> important since we'll be changing the user's setting.
> >> >> 
> >> >> Do you mean to have it break when it hits N and recalculates the period or 
> >> >> reset the counter and keep going?
> >> >> 
> >> >
> >> > Let me know what you think of the below. It's working nicely. I like your 
> >> > suggestion to limit it quickly based on number of loops and use that to 
> >> > scale up. I think it is best to break out and let it fire again if needed. 
> >> > The warning fires once, very occasionally twice, and then things are quiet.
> >> >
> >> > If that looks reasonable I'll do some more testing and spin it up as a real 
> >> > patch submission. 
> >> 
> >> Yeah, this looks reasonable. I should probably see how unreasonable the
> >> other thing would be, but if your previous periods were kinda small (and
> >> it's just that the machine crashing isn't an ok failure mode) I suppose
> >> it's not a big deal.
> >> 
> >
> > I posted it a little while ago. The periods were tiny (~2000us vs a minimum 
> > of 1000) and with 2500 mostly unused child cgroups (I didn't narrow that 
> > down much but it did reproduce still with 1250 children).  That's why I was 
> > thinking edge case. It also requires a fairly small quota and load to make 
> > sure cfs_rqs get throttled.
> 
> Ok, yeah, that's below the level where I'm too worried about it. It's
> still bad to spend a ms in IRQ in the case of tons of child cgroups, but
> 1-2ms periods are definitely way less than what is really sensible for cfsb.
> 

The original case in the wild was 17ms.  In order to make it trigger reliably 
on upstream it needed to be reduced a fair bit. 

I considered a raise in the minimum but was concerned that would be effectively 
an API breakage. And it also could then fail with a more cgroups. 


> >
> > I'm still wrapping my head around the scheduler code but I'd be happy to 
> > try it the other way if you can give me a bit more description of what
> > you have in mind. Also happy to test a patch with my repro.
> 
> Eh, I was more saying to myself, though I'm a bit busy.
> 
> The idea is that the only reason for the walk_tg_from is that we need
> two pieces of information for every cfs_rq: a) if it is currently
> throttled, and b) how much total time it has spent throttled. We
> currently update these for all children during throttle/unthrottle
> rather than have the children search through their ancestors to avoid
> the cost when doing other work. However, all children who don't have a
> quota set will all have identical throttle_count, and all children who
> have never had a quota set will have identical throttle time (I
> previously hadn't thought of the additional restriction required for the
> second case here). Thus we could share the data structure for all these
> identical cases, and then only have to look at children who have quota
> set, or have in the past. Setting things up to walk this sort of reduced
> tree of "tgs/cfs_rqs that have ever used cfs_b" would be a pain and
> mirror the existing tg tree setup, but be possible.
> 
> This would be no help if the children sometimes have a quota (say if
> only a few ever use it at a time but eventually all of them do, or they
> do initially during some setup or something), and would just make things
> worse with additional memory/cache pressure.

Let's see if there is any traction for the current patch then. 


Interstingly 5.0+ seems to be a bit slower in do_sched_cfs_period_timer() than
the v5.0 tagged tree. 

The test runs once with the initial values (period 2170) for 30 seconds, then
resets them to half that and runs for 30s. Then it gets below min and fails so 
it cleans up and starts over. 

Usually there's 1-2 for the first 30s and 1 for the 2nd. Followed by an idle 
which usually means a CPU switch. The new cfs_period_us is the average over 
the 8 loops (modulo the 15% increase).  The small one seem to be in the first 
run probably before the throttled list gets full enough. HW, test and userspace
are all the same. 

This is 5.0+ (HEAD) from today:
[  249.081068] cfs_period_timer[cpu40]: period too short, scaling up (new cfs_period_us 20388, cfs_quota_us = 1174481)
[  286.184298] cfs_period_timer[cpu21]: period too short, scaling up (new cfs_period_us 12367, cfs_quota_us = 712423)
[  316.247071] cfs_period_timer[cpu12]: period too short, scaling up (new cfs_period_us 15670, cfs_quota_us = 902688)
[  353.118799] cfs_period_timer[cpu1]: period too short, scaling up (new cfs_period_us 9189, cfs_quota_us = 529375)
[  353.568433] cfs_period_timer[cpu1]: period too short, scaling up (new cfs_period_us 20875, cfs_quota_us = 1202477)
[  383.226669] cfs_period_timer[cpu1]: period too short, scaling up (new cfs_period_us 17195, cfs_quota_us = 990533)
[  420.331071] cfs_period_timer[cpu3]: period too short, scaling up (new cfs_period_us 16409, cfs_quota_us = 945243)
[  450.363500] cfs_period_timer[cpu3]: period too short, scaling up (new cfs_period_us 17041, cfs_quota_us = 981681)
[  487.198213] cfs_period_timer[cpu6]: period too short, scaling up (new cfs_period_us 7886, cfs_quota_us = 454289)
[  487.991057] cfs_period_timer[cpu6]: period too short, scaling up (new cfs_period_us 12848, cfs_quota_us = 740132)
[  517.290409] cfs_period_timer[cpu6]: period too short, scaling up (new cfs_period_us 15257, cfs_quota_us = 878867)
[  554.135046] cfs_period_timer[cpu7]: period too short, scaling up (new cfs_period_us 4689, cfs_quota_us = 270154)
[  554.393260] cfs_period_timer[cpu7]: period too short, scaling up (new cfs_period_us 19964, cfs_quota_us = 1150044)
[  584.263253] cfs_period_timer[cpu7]: period too short, scaling up (new cfs_period_us 17543, cfs_quota_us = 1010544)
[  621.359747] cfs_period_timer[cpu7]: period too short, scaling up (new cfs_period_us 4331, cfs_quota_us = 249533)
[  621.955802] cfs_period_timer[cpu7]: period too short, scaling up (new cfs_period_us 15284, cfs_quota_us = 880459)


This is v5.0:
[  105.859929] cfs_period_timer[cpu28]: period too short, scaling up (new cfs_period_us 6575, cfs_quota_us = 378757)
[  123.370507] cfs_period_timer[cpu28]: period too short, scaling up (new cfs_period_us 10336, cfs_quota_us = 595413)
[  135.866776] cfs_period_timer[cpu28]: period too short, scaling up (new cfs_period_us 11857, cfs_quota_us = 683030)
[  173.345169] cfs_period_timer[cpu33]: period too short, scaling up (new cfs_period_us 5155, cfs_quota_us = 296991)
[  182.912922] cfs_period_timer[cpu33]: period too short, scaling up (new cfs_period_us 10832, cfs_quota_us = 624006)
[  203.422465] cfs_period_timer[cpu33]: period too short, scaling up (new cfs_period_us 12305, cfs_quota_us = 708816)
[  240.946232] cfs_period_timer[cpu31]: period too short, scaling up (new cfs_period_us 11883, cfs_quota_us = 684559)
[  270.899190] cfs_period_timer[cpu31]: period too short, scaling up (new cfs_period_us 12185, cfs_quota_us = 701929)
[  308.251577] cfs_period_timer[cpu15]: period too short, scaling up (new cfs_period_us 11063, cfs_quota_us = 637318)
[  338.267753] cfs_period_timer[cpu15]: period too short, scaling up (new cfs_period_us 12288, cfs_quota_us = 707873)
[  375.636986] cfs_period_timer[cpu35]: period too short, scaling up (new cfs_period_us 7252, cfs_quota_us = 417748)
[  405.697730] cfs_period_timer[cpu35]: period too short, scaling up (new cfs_period_us 12585, cfs_quota_us = 724956)
[  443.173459] cfs_period_timer[cpu36]: period too short, scaling up (new cfs_period_us 8081, cfs_quota_us = 465516)
[  473.224266] cfs_period_timer[cpu36]: period too short, scaling up (new cfs_period_us 12703, cfs_quota_us = 731788)
[  510.600851] cfs_period_timer[cpu32]: period too short, scaling up (new cfs_period_us 10613, cfs_quota_us = 611382)
[  540.625699] cfs_period_timer[cpu32]: period too short, scaling up (new cfs_period_us 11961, cfs_quota_us = 689002)


Cheers,
Phil

> 
> >
> >
> > Cheers,
> > Phil
> >
> >
> >> >
> >> > Cheers,
> >> > Phil
> >> > ---
> >> >
> >> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >> > index 310d0637fe4b..54b30adfc89e 100644
> >> > --- a/kernel/sched/fair.c
> >> > +++ b/kernel/sched/fair.c
> >> > @@ -4859,19 +4859,51 @@ static enum hrtimer_restart sched_cfs_slack_timer(struct hrtimer *timer)
> >> >  	return HRTIMER_NORESTART;
> >> >  }
> >> >  
> >> > +extern const u64 max_cfs_quota_period;
> >> > +int cfs_period_autotune_loop_limit   = 8;
> >> > +int cfs_period_autotune_cushion_pct  = 15; /* percentage added to period recalculation */
> >> > +
> >> >  static enum hrtimer_restart sched_cfs_period_timer(struct hrtimer *timer)
> >> >  {
> >> >  	struct cfs_bandwidth *cfs_b =
> >> >  		container_of(timer, struct cfs_bandwidth, period_timer);
> >> > +	s64 nsstart, nsnow, new_period;
> >> >  	int overrun;
> >> >  	int idle = 0;
> >> > +	int count = 0;
> >> >  
> >> >  	raw_spin_lock(&cfs_b->lock);
> >> > +	nsstart = ktime_to_ns(hrtimer_cb_get_time(timer));
> >> >  	for (;;) {
> >> >  		overrun = hrtimer_forward_now(timer, cfs_b->period);
> >> >  		if (!overrun)
> >> >  			break;
> >> >  
> >> > +		if (++count > cfs_period_autotune_loop_limit) {
> >> > +			ktime_t old_period = ktime_to_ns(cfs_b->period);
> >> > +
> >> > +			nsnow = ktime_to_ns(hrtimer_cb_get_time(timer));
> >> > +			new_period = (nsnow - nsstart)/cfs_period_autotune_loop_limit;
> >> > +
> >> > +			/*  Make sure new period will be larger than old. */
> >> > +			if (new_period < old_period) {
> >> > +				new_period = old_period;
> >> > +			}
> >> > +			new_period += (new_period *  cfs_period_autotune_cushion_pct) / 100;
> >> 
> >> This ordering means that it will always increase by at least 15%. This
> >> is a bit odd but probably a good thing; I'd just change the comment to
> >> make it clear this is deliberate.
> >> 
> >> > +
> >> > +			if (new_period >  max_cfs_quota_period)
> >> > +				new_period = max_cfs_quota_period;
> >> > +
> >> > +			cfs_b->period = ns_to_ktime(new_period);
> >> > +			cfs_b->quota += (cfs_b->quota * ((new_period - old_period) * 100)/old_period)/100;
> >> 
> >> In general it makes sense to do fixed point via 1024 or something that
> >> can be optimized into shifts (and a larger number is better in general
> >> for better precision).
> >> 
> >> > +			pr_warn_ratelimited(
> >> > +				"cfs_period_timer[cpu%d]: period too short, scaling up (new cfs_period_us %lld, cfs_quota_us = %lld)\n",
> >> > +				smp_processor_id(), cfs_b->period/NSEC_PER_USEC, cfs_b->quota/NSEC_PER_USEC);
> >> > +
> >> > +			idle = 0;
> >> > +			break;
> >> > +		}
> >> > +
> >> >  		idle = do_sched_cfs_period_timer(cfs_b, overrun);
> >> >  	}
> >> >  	if (idle)

-- 
