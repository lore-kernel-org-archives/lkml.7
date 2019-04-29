Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F219C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 07:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41A2C2053B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 07:13:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbfD2HNN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 03:13:13 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:52017 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726846AbfD2HNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 03:13:12 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04446;MF=aaron.lu@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0TQUwxLd_1556521981;
Received: from aaronlu(mailfrom:aaron.lu@linux.alibaba.com fp:SMTPD_---0TQUwxLd_1556521981)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 29 Apr 2019 15:13:08 +0800
Date:   Mon, 29 Apr 2019 15:13:01 +0800
From:   Aaron Lu <aaron.lu@linux.alibaba.com>
To:     Vineeth Remanan Pillai <vpillai@digitalocean.com>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, subhra.mazumdar@oracle.com,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v2 13/17] sched: Add core wide task selection and
 scheduling.
Message-ID: <20190429071259.GA15100@aaronlu>
References: <cover.1556025155.git.vpillai@digitalocean.com>
 <edd4c014e69b68b90160766c6049f2ed922793c7.1556025155.git.vpillai@digitalocean.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <edd4c014e69b68b90160766c6049f2ed922793c7.1556025155.git.vpillai@digitalocean.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 04:18:18PM +0000, Vineeth Remanan Pillai wrote:
> +// XXX fairness/fwd progress conditions
> +static struct task_struct *
> +pick_task(struct rq *rq, const struct sched_class *class, struct task_struct *max)
> +{
> +	struct task_struct *class_pick, *cookie_pick;
> +	unsigned long cookie = 0UL;
> +
> +	/*
> +	 * We must not rely on rq->core->core_cookie here, because we fail to reset
> +	 * rq->core->core_cookie on new picks, such that we can detect if we need
> +	 * to do single vs multi rq task selection.
> +	 */
> +
> +	if (max && max->core_cookie) {
> +		WARN_ON_ONCE(rq->core->core_cookie != max->core_cookie);
> +		cookie = max->core_cookie;
> +	}
> +
> +	class_pick = class->pick_task(rq);
> +	if (!cookie)
> +		return class_pick;
> +
> +	cookie_pick = sched_core_find(rq, cookie);
> +	if (!class_pick)
> +		return cookie_pick;
> +
> +	/*
> +	 * If class > max && class > cookie, it is the highest priority task on
> +	 * the core (so far) and it must be selected, otherwise we must go with
> +	 * the cookie pick in order to satisfy the constraint.
> +	 */
> +	if (cpu_prio_less(cookie_pick, class_pick) && core_prio_less(max, class_pick))

It apapears to me the cpu_prio_less(cookie_pick, class_pick) isn't
needed.

If cookie_pick is idle task, then cpu_prio_less(cookie_pick, class_pick)
is always true;
If cookie_pick is not idle task and has the same sched class as
class_pick, then class_pick is the best candidate to run accoring to
their sched class. In this case, cpu_prio_less(cookie_pick, class_pick)
shouldn't return false or it feels like a bug;
If cookie_pick is not idle task and has a different sched class as
class_pick:
 - if cookie_pick's sched class has higher priority than class_pick's
   sched class, then cookie_pick should have been selected in previous
   sched class iteration; and since its cookie matches with max,
   everything should have been finished already;
 - if cookie_pick's sched class has lower priority than class_pick's
   sched class, then cpu_prio_less(cookie_pick, class_pick) will still
   returns true.

So looks like cpu_prio_less(cookie_pick, class_pick) should always
return true and thus not needed.

> +		return class_pick;
> +
> +	return cookie_pick;
> +}
