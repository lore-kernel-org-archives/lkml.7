Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B3E3C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDBE32147C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:25:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728590AbfCKUZk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 16:25:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:25643 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727796AbfCKUZk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 16:25:40 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4B749C05FBC5;
        Mon, 11 Mar 2019 20:25:39 +0000 (UTC)
Received: from pauld.bos.csb (dhcp-17-51.bos.redhat.com [10.18.17.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BDF756013C;
        Mon, 11 Mar 2019 20:25:38 +0000 (UTC)
Date:   Mon, 11 Mar 2019 16:25:37 -0400
From:   Phil Auld <pauld@redhat.com>
To:     bsegall@google.com
Cc:     mingo@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC]  sched/fair: hard lockup in sched_cfs_period_timer
Message-ID: <20190311202536.GK25201@pauld.bos.csb>
References: <20190301145209.GA9304@pauld.bos.csb>
 <xm26ef7mzew2.fsf@bsegall-linux.svl.corp.google.com>
 <20190304190510.GB5366@lorien.usersys.redhat.com>
 <xm268sxtyx5u.fsf@bsegall-linux.svl.corp.google.com>
 <20190305200554.GA8786@pauld.bos.csb>
 <xm261s3lyrrl.fsf@bsegall-linux.svl.corp.google.com>
 <20190306162313.GB8786@pauld.bos.csb>
 <xm26wolbyfe9.fsf@bsegall-linux.svl.corp.google.com>
 <20190309203320.GA24464@lorien.usersys.redhat.com>
 <xm26sgvtxq4m.fsf@bsegall-linux.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xm26sgvtxq4m.fsf@bsegall-linux.svl.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Mon, 11 Mar 2019 20:25:39 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 10:44:25AM -0700 bsegall@google.com wrote:
> Phil Auld <pauld@redhat.com> writes:
> 
> > On Wed, Mar 06, 2019 at 11:25:02AM -0800 bsegall@google.com wrote:
> >> Phil Auld <pauld@redhat.com> writes:
> >> 
> >> > On Tue, Mar 05, 2019 at 12:45:34PM -0800 bsegall@google.com wrote:
> >> >> Phil Auld <pauld@redhat.com> writes:
> >> >> 
> >> >> > Interestingly, if I limit the number of child cgroups to the number of 
> >> >> > them I'm actually putting processes into (16 down from 2500) the problem
> >> >> > does not reproduce.
> >> >> 
> >> >> That is indeed interesting, and definitely not something we'd want to
> >> >> matter. (Particularly if it's not root->a->b->c...->throttled_cgroup or
> >> >> root->throttled->a->...->thread vs root->throttled_cgroup, which is what
> >> >> I was originally thinking of)
> >> >> 
> >> >
> >> > The locking may be a red herring.
> >> >
> >> > The setup is root->throttled->a where a is 1-2500. There are 4 threads in
> >> > each of the first 16 a groups.  The parent, throttled, is where the 
> >> > cfs_period/quota_us are set. 
> >> >
> >> > I wonder if the problem is the walk_tg_tree_from() call in unthrottle_cfs_rq(). 
> >> >
> >> > The distribute_cfg_runtime looks to be O(n * m) where n is number of 
> >> > throttled cfs_rqs and m is the number of child cgroups. But I'm not 
> >> > completely clear on how the hierarchical cgroups play together here. 
> >> >
> >> > I'll pull on this thread some. 
> >> >
> >> > Thanks for your input.
> >> >
> >> >
> >> > Cheers,
> >> > Phil
> >> 
> >> Yeah, that isn't under the cfs_b lock, but is still part of distribute
> >> (and under rq lock, which might also matter). I was thinking too much
> >> about just the cfs_b regions. I'm not sure there's any good general
> >> optimization there.
> >>
> >
> > It's really an edge case, but the watchdog NMI is pretty painful.
> >
> >> I suppose cfs_rqs (tgs/cfs_bs?) could have "nearest
> >> ancestor with a quota" pointer and ones with quota could have
> >> "descendants with quota" list, parallel to the children/parent lists of
> >> tgs. Then throttle/unthrottle would only have to visit these lists, and
> >> child cgroups/cfs_rqs without their own quotas would just check
> >> cfs_rq->nearest_quota_cfs_rq->throttle_count. throttled_clock_task_time
> >> can also probably be tracked there.
> >
> > That seems like it would add a lot of complexity for this edge case. Maybe
> > it would be acceptible to use the safety valve like my first example, or
> > something like the below which will tune the period up until it doesn't
> > overrun for ever.  The down side of this one is it does change the user's
> > settings, but that could be preferable to an NMI crash.
> 
> Yeah, I'm not sure what solution is best here, but one of the solutions
> should be done.
> 
> >
> > Cheers,
> > Phil
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 310d0637fe4b..78f9e28adc7b 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -4859,16 +4859,42 @@ static enum hrtimer_restart sched_cfs_slack_timer(struct hrtimer *timer)
> >  	return HRTIMER_NORESTART;
> >  }
> >  
> > +extern const u64 max_cfs_quota_period;
> > +s64 cfs_quota_period_autotune_thresh = 100 * NSEC_PER_MSEC;
> > +int cfs_quota_period_autotune_shift  = 4; /* 100 / 16 = 6.25% */
> 
> Letting it spin for 100ms and then only increasing by 6% seems extremely
> generous. If we went this route I'd probably say "after looping N
> times, set the period to time taken / N + X%" where N is like 8 or
> something. I think I'd probably perfer something like this to the
> previous "just abort and let it happen again next interrupt" one.

Okay. I'll try to spin something up that does this. It may be a little 
trickier to keep the quota proportional to the new period. I think that's 
important since we'll be changing the user's setting.

Do you mean to have it break when it hits N and recalculates the period or 
reset the counter and keep going?



Cheers,
Phil

> 
> > +
> >  static enum hrtimer_restart sched_cfs_period_timer(struct hrtimer *timer)
> >  {
> >  	struct cfs_bandwidth *cfs_b =
> >  		container_of(timer, struct cfs_bandwidth, period_timer);
> > +	s64 nsprev, nsnow, new_period;
> > +	ktime_t now;
> >  	int overrun;
> >  	int idle = 0;
> >  
> >  	raw_spin_lock(&cfs_b->lock);
> > +	nsprev = ktime_to_ns(hrtimer_cb_get_time(timer));
> >  	for (;;) {
> > -		overrun = hrtimer_forward_now(timer, cfs_b->period);
> > +		/* 
> > +		 * Note this reverts the change to use hrtimer_forward_now, which avoids calling hrtimer_cb_get_time
> > +		 * for a value we already have
> > +		 */
> > +		now = hrtimer_cb_get_time(timer);
> > +		nsnow = ktime_to_ns(now);
> > +		if (nsnow - nsprev >= cfs_quota_period_autotune_thresh) {
> > +			new_period = ktime_to_ns(cfs_b->period);
> > +			new_period += new_period >> cfs_quota_period_autotune_shift;
> > +			if (new_period <= max_cfs_quota_period) {
> > +				cfs_b->period = ns_to_ktime(new_period);
> > +				cfs_b->quota += cfs_b->quota >> cfs_quota_period_autotune_shift;
> > +				pr_warn_ratelimited(
> > +					"cfs_period_timer [cpu%d] : Running too long, scaling up (new period %lld, new quota = %lld)\n", 
> > +					smp_processor_id(), cfs_b->period/NSEC_PER_USEC, cfs_b->quota/NSEC_PER_USEC);
> > +			}
> > +			nsprev = nsnow;
> > +		}
> > +
> > +		overrun = hrtimer_forward(timer, now, cfs_b->period);
> >  		if (!overrun)
> >  			break;

-- 
