Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E4DC4CECD
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 13:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3208420830
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 13:45:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="QIIYsStJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387485AbfIPNpv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 09:45:51 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:38647 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727806AbfIPNpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 09:45:50 -0400
Received: by mail-qt1-f193.google.com with SMTP id j31so16526718qta.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 06:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P5h2jTgNwK61IulutQ0mEg7l1+pDhg85QDrcu4fe7jw=;
        b=QIIYsStJA3oxqkuF17Zn5f7VSMtpyYx3WcfJQ+ELXJP58Wwga4EvVZHQj8K5V5bTsl
         v05tmpBiyT/ulkcueOo1m13L98Xq+r8zMZ6tTLxz+sFvjrb/UczLvkoDOciROj8dRugt
         TqL5XYlLpx7D5txF14n8kg0N6uH+NGt7UyM4SDbGpmNCXItKBapNVWJDrV3xbgN7Elvz
         kaCjrOrGObwptI5xV1l8tL2bvnB7uYoesqrtt3GM5ctZ6wqEgmsMi/UdDOvtDNCg1pdE
         JWd8Qlfb928cF54aQhL4mdJ5TyvpU+8Q1mTopGw1ocPbGoVnmFZyxUtqKbJ7Cvxq50Ae
         EYdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P5h2jTgNwK61IulutQ0mEg7l1+pDhg85QDrcu4fe7jw=;
        b=QxFF6MjUj9KqUlKZUdKjKo61GRePXXmPwYByddbaYkpKRrOZh7fcMkxnE4L8NaDWJy
         u+KR9e+TxNblp2XyqrwuVxoc3vlqDv3pksNk3pyypX0nHfA9fagPGJkjhqDHqaGBeLPT
         Wn95oEz4uKTvlFWeDOnAL7qFN1c7m3Qnps/phds6+tGza/Mnh1rZj/o06s2A5Ot9KAPa
         sZEX+wOL/DiArZEl8A5xcveeD8aHmS/viUyrt9nwVrZzmevLkC65vLd5jwmJjfmZ2rHe
         ry4kAv6vQnCTOrFnbkCFIFjdOvyY2+02Ku+QWIVkXizcq+K1OHV7FkKq0+LT8JhpXN7r
         PulA==
X-Gm-Message-State: APjAAAUuk5HWlvcdcEgIn1zg6gaZcjUt8oU0owqgbyTCWnsncNUGaRMD
        5gu/OI3YJso3OJK28jSVWf3rKw==
X-Google-Smtp-Source: APXvYqzok22S9Kgx8/ql3jKq5ugcb1ZTkSFNLgFtzfY1JIIi9HTrxeU2LReC9fWEFlNTZ10Vk4RNgA==
X-Received: by 2002:aed:2469:: with SMTP id s38mr17397532qtc.190.1568641548742;
        Mon, 16 Sep 2019 06:45:48 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id 29sm19189092qkp.86.2019.09.16.06.45.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Sep 2019 06:45:47 -0700 (PDT)
Message-ID: <1568641545.5576.150.camel@lca.pw>
Subject: Re: [PATCH -next v2] sched/fair: fix -Wunused-but-set-variable
 warnings
From:   Qian Cai <cai@lca.pw>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, bsegall@google.com, chiluk+linux@indeed.com,
        pauld@redhat.com, linux-kernel@vger.kernel.org
Date:   Mon, 16 Sep 2019 09:45:45 -0400
In-Reply-To: <1568149081.5576.136.camel@lca.pw>
References: <1566326455-8038-1-git-send-email-cai@lca.pw>
         <1567515806.5576.41.camel@lca.pw>
         <20190903141554.GS2349@hirez.programming.kicks-ass.net>
         <1568149081.5576.136.camel@lca.pw>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo, I saw you sent a pull request to Linus including the commit introduced the
warnings,

https://lkml.org/lkml/2019/9/16/309

but seems not yet picked up the fix here,

https://lore.kernel.org/lkml/20190903141554.GS2349@hirez.programming.kicks-ass.n
et/

On Tue, 2019-09-10 at 16:58 -0400, Qian Cai wrote:
> On Tue, 2019-09-03 at 16:15 +0200, Peter Zijlstra wrote:
> > On Tue, Sep 03, 2019 at 09:03:26AM -0400, Qian Cai wrote:
> > > Ingo or Peter, please take a look at this trivial patch. Still see the warning
> > > in linux-next every day.
> > > 
> > > On Tue, 2019-08-20 at 14:40 -0400, Qian Cai wrote:
> > > > The linux-next commit "sched/fair: Fix low cpu usage with high
> > > > throttling by removing expiration of cpu-local slices" [1] introduced a
> > > > few compilation warnings,
> > > > 
> > > > kernel/sched/fair.c: In function '__refill_cfs_bandwidth_runtime':
> > > > kernel/sched/fair.c:4365:6: warning: variable 'now' set but not used
> > > > [-Wunused-but-set-variable]
> > > > kernel/sched/fair.c: In function 'start_cfs_bandwidth':
> > > > kernel/sched/fair.c:4992:6: warning: variable 'overrun' set but not used
> > > > [-Wunused-but-set-variable]
> > > > 
> > > > Also, __refill_cfs_bandwidth_runtime() does no longer update the
> > > > expiration time, so fix the comments accordingly.
> > > > 
> > > > [1] https://lore.kernel.org/lkml/1558121424-2914-1-git-send-email-chiluk+linux
> > > > @indeed.com/
> > > > 
> > > > Signed-off-by: Qian Cai <cai@lca.pw>
> > 
> > Rewrote the Changelog like so:
> 
> Looks good. I suppose it still need Ingo to pick it up, as today's tip/auto-
> latest still show those warnings.
> 
> > 
> > ---
> > Subject: sched/fair: Fix -Wunused-but-set-variable warnings
> > From: Qian Cai <cai@lca.pw>
> > Date: Tue, 20 Aug 2019 14:40:55 -0400
> > 
> > Commit de53fd7aedb1 ("sched/fair: Fix low cpu usage with high
> > throttling by removing expiration of cpu-local slices") introduced a
> > few compilation warnings:
> > 
> >   kernel/sched/fair.c: In function '__refill_cfs_bandwidth_runtime':
> >   kernel/sched/fair.c:4365:6: warning: variable 'now' set but not used [-Wunused-but-set-variable]
> >   kernel/sched/fair.c: In function 'start_cfs_bandwidth':
> >   kernel/sched/fair.c:4992:6: warning: variable 'overrun' set but not used [-Wunused-but-set-variable]
> > 
> > Also, __refill_cfs_bandwidth_runtime() does no longer update the
> > expiration time, so fix the comments accordingly.
> > 
> > Fixes: de53fd7aedb1 ("sched/fair: Fix low cpu usage with high throttling by removing expiration of cpu-local slices")
> > Signed-off-by: Qian Cai <cai@lca.pw>
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Reviewed-by: Ben Segall <bsegall@google.com>
> > Reviewed-by: Dave Chiluk <chiluk+linux@indeed.com>
> > Cc: mingo@redhat.com
> > Cc: pauld@redhat.com
> > Link: https://lkml.kernel.org/r/1566326455-8038-1-git-send-email-cai@lca.pw
> > ---
> >  kernel/sched/fair.c |   19 ++++++-------------
> >  1 file changed, 6 insertions(+), 13 deletions(-)
> > 
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -4386,21 +4386,16 @@ static inline u64 sched_cfs_bandwidth_sl
> >  }
> >  
> >  /*
> > - * Replenish runtime according to assigned quota and update expiration time.
> > - * We use sched_clock_cpu directly instead of rq->clock to avoid adding
> > - * additional synchronization around rq->lock.
> > + * Replenish runtime according to assigned quota. We use sched_clock_cpu
> > + * directly instead of rq->clock to avoid adding additional synchronization
> > + * around rq->lock.
> >   *
> >   * requires cfs_b->lock
> >   */
> >  void __refill_cfs_bandwidth_runtime(struct cfs_bandwidth *cfs_b)
> >  {
> > -	u64 now;
> > -
> > -	if (cfs_b->quota == RUNTIME_INF)
> > -		return;
> > -
> > -	now = sched_clock_cpu(smp_processor_id());
> > -	cfs_b->runtime = cfs_b->quota;
> > +	if (cfs_b->quota != RUNTIME_INF)
> > +		cfs_b->runtime = cfs_b->quota;
> >  }
> >  
> >  static inline struct cfs_bandwidth *tg_cfs_bandwidth(struct task_group *tg)
> > @@ -5021,15 +5016,13 @@ static void init_cfs_rq_runtime(struct c
> >  
> >  void start_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
> >  {
> > -	u64 overrun;
> > -
> >  	lockdep_assert_held(&cfs_b->lock);
> >  
> >  	if (cfs_b->period_active)
> >  		return;
> >  
> >  	cfs_b->period_active = 1;
> > -	overrun = hrtimer_forward_now(&cfs_b->period_timer, cfs_b->period);
> > +	hrtimer_forward_now(&cfs_b->period_timer, cfs_b->period);
> >  	hrtimer_start_expires(&cfs_b->period_timer, HRTIMER_MODE_ABS_PINNED);
> >  }
> >  
