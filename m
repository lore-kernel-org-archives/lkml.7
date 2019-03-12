Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F1CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 13:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6E702087C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 13:57:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbfCLN5t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 09:57:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57218 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725917AbfCLN5t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 09:57:49 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 007053084029;
        Tue, 12 Mar 2019 13:57:49 +0000 (UTC)
Received: from pauld.bos.csb (dhcp-17-51.bos.redhat.com [10.18.17.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 759281796F;
        Tue, 12 Mar 2019 13:57:48 +0000 (UTC)
Date:   Tue, 12 Mar 2019 09:57:46 -0400
From:   Phil Auld <pauld@redhat.com>
To:     bsegall@google.com
Cc:     mingo@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC]  sched/fair: hard lockup in sched_cfs_period_timer
Message-ID: <20190312135746.GB24002@pauld.bos.csb>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311202536.GK25201@pauld.bos.csb>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Tue, 12 Mar 2019 13:57:49 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 04:25:36PM -0400 Phil Auld wrote:
> On Mon, Mar 11, 2019 at 10:44:25AM -0700 bsegall@google.com wrote:
> > Letting it spin for 100ms and then only increasing by 6% seems extremely
> > generous. If we went this route I'd probably say "after looping N
> > times, set the period to time taken / N + X%" where N is like 8 or
> > something. I think I'd probably perfer something like this to the
> > previous "just abort and let it happen again next interrupt" one.
> 
> Okay. I'll try to spin something up that does this. It may be a little 
> trickier to keep the quota proportional to the new period. I think that's 
> important since we'll be changing the user's setting.
> 
> Do you mean to have it break when it hits N and recalculates the period or 
> reset the counter and keep going?
> 

Let me know what you think of the below. It's working nicely. I like your 
suggestion to limit it quickly based on number of loops and use that to 
scale up. I think it is best to break out and let it fire again if needed. 
The warning fires once, very occasionally twice, and then things are quiet.

If that looks reasonable I'll do some more testing and spin it up as a real 
patch submission. 

Cheers,
Phil
---

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 310d0637fe4b..54b30adfc89e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4859,19 +4859,51 @@ static enum hrtimer_restart sched_cfs_slack_timer(struct hrtimer *timer)
 	return HRTIMER_NORESTART;
 }
 
+extern const u64 max_cfs_quota_period;
+int cfs_period_autotune_loop_limit   = 8;
+int cfs_period_autotune_cushion_pct  = 15; /* percentage added to period recalculation */
+
 static enum hrtimer_restart sched_cfs_period_timer(struct hrtimer *timer)
 {
 	struct cfs_bandwidth *cfs_b =
 		container_of(timer, struct cfs_bandwidth, period_timer);
+	s64 nsstart, nsnow, new_period;
 	int overrun;
 	int idle = 0;
+	int count = 0;
 
 	raw_spin_lock(&cfs_b->lock);
+	nsstart = ktime_to_ns(hrtimer_cb_get_time(timer));
 	for (;;) {
 		overrun = hrtimer_forward_now(timer, cfs_b->period);
 		if (!overrun)
 			break;
 
+		if (++count > cfs_period_autotune_loop_limit) {
+			ktime_t old_period = ktime_to_ns(cfs_b->period);
+
+			nsnow = ktime_to_ns(hrtimer_cb_get_time(timer));
+			new_period = (nsnow - nsstart)/cfs_period_autotune_loop_limit;
+
+			/*  Make sure new period will be larger than old. */
+			if (new_period < old_period) {
+				new_period = old_period;
+			}
+			new_period += (new_period *  cfs_period_autotune_cushion_pct) / 100;
+
+			if (new_period >  max_cfs_quota_period)
+				new_period = max_cfs_quota_period;
+
+			cfs_b->period = ns_to_ktime(new_period);
+			cfs_b->quota += (cfs_b->quota * ((new_period - old_period) * 100)/old_period)/100;
+			pr_warn_ratelimited(
+				"cfs_period_timer[cpu%d]: period too short, scaling up (new cfs_period_us %lld, cfs_quota_us = %lld)\n",
+				smp_processor_id(), cfs_b->period/NSEC_PER_USEC, cfs_b->quota/NSEC_PER_USEC);
+
+			idle = 0;
+			break;
+		}
+
 		idle = do_sched_cfs_period_timer(cfs_b, overrun);
 	}
 	if (idle)


-- 
