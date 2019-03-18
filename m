Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB5F1C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 13:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2E2520850
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 13:29:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727627AbfCRN3U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 09:29:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47630 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726643AbfCRN3T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 09:29:19 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 458963082E63;
        Mon, 18 Mar 2019 13:29:19 +0000 (UTC)
Received: from pauld.bos.csb (dhcp-17-51.bos.redhat.com [10.18.17.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B63D719C71;
        Mon, 18 Mar 2019 13:29:18 +0000 (UTC)
Date:   Mon, 18 Mar 2019 09:29:17 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Ben Segall <bsegall@google.com>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH] sched/fair: Limit sched_cfs_period_timer loop to avoid
 hard lockup
Message-ID: <20190318132916.GA15377@pauld.bos.csb>
References: <20190313150826.16862-1-pauld@redhat.com>
 <20190315101150.GV5996@hirez.programming.kicks-ass.net>
 <20190315153042.GF27131@pauld.bos.csb>
 <20190315160347.GZ5996@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190315160347.GZ5996@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Mon, 18 Mar 2019 13:29:19 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2019 at 05:03:47PM +0100 Peter Zijlstra wrote:
> On Fri, Mar 15, 2019 at 11:30:42AM -0400, Phil Auld wrote:
> 
> >> I'll rework the maths in the averaged version and post v2 if that makes sense.
> > 
> > It may have the extra timer fetch, although maybe I could rework it so that it used the 
> > nsstart time the first time and did not need to do it twice in a row. I had originally
> > reverted the hrtimer_forward_now() to hrtimer_forward() but put that back. 
> 
> Sure; but remember, simpler is often better, esp. for code that
> typically 'never' runs.

I reworked it to the below. This settles a bit faster. The average is sort of squishy because
it's 3 samples divided by 4.  And if we stay in a single call after updating the period the "average"
will be even less accurate. 

It settles at a larger value faster so produces fewer messages and none of the callback supressed ones.
The added complexity may not be worth it, though.

I think this or your version, either one, would work.  

What needs to happen now to get one of them to land somewhere? Should I just repost one with my 
signed-off and let you add whatever other tags?  And if so do you have a preference for which one?  

Also, Ben, thoughts?

Cheers,
Phil

--

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ea74d43924b2..297fd228fdb0 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4885,6 +4885,8 @@ static enum hrtimer_restart sched_cfs_slack_timer(struct hrtimer *timer)
 	return HRTIMER_NORESTART;
 }
 
+extern const u64 max_cfs_quota_period;
+
 static enum hrtimer_restart sched_cfs_period_timer(struct hrtimer *timer)
 {
 	struct cfs_bandwidth *cfs_b =
@@ -4892,14 +4894,46 @@ static enum hrtimer_restart sched_cfs_period_timer(struct hrtimer *timer)
 	unsigned long flags;
 	int overrun;
 	int idle = 0;
+	int count = 0;
+	u64 start, now;
 
 	raw_spin_lock_irqsave(&cfs_b->lock, flags);
+	now = start = ktime_to_ns(hrtimer_cb_get_time(timer));
 	for (;;) {
-		overrun = hrtimer_forward_now(timer, cfs_b->period);
+		overrun = hrtimer_forward(timer, now, cfs_b->period);
 		if (!overrun)
 			break;
 
+		if (++count > 3) {
+			u64 new, old = ktime_to_ns(cfs_b->period);
+
+                        /* rough average of the time each loop is taking
+			  * really should be (n-s)/3 but this is easier for the machine
+			  */
+			new = (now - start) >> 2; 
+			if (new < old)
+				new = old;
+			new = (new * 147) / 128; /* ~115% */
+			new = min(new, max_cfs_quota_period);
+
+			cfs_b->period = ns_to_ktime(new);
+
+			/* since max is 1s, this is limited to 1e9^2, which fits in u64 */
+			cfs_b->quota *= new;
+			cfs_b->quota /= old;
+
+			pr_warn_ratelimited(
+	"cfs_period_timer[cpu%d]: period too short, scaling up (new cfs_period_us %lld, cfs_quota_us = %lld)\n",
+				smp_processor_id(),
+				new/NSEC_PER_USEC,
+				cfs_b->quota/NSEC_PER_USEC);
+
+			/* reset count so we don't come right back in here */
+			count = 0;
+		}
+
 		idle = do_sched_cfs_period_timer(cfs_b, overrun, flags);
+		now = ktime_to_ns(hrtimer_cb_get_time(timer));
 	}
 	if (idle)
 		cfs_b->period_active = 0;



-- 
