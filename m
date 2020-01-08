Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7820BC282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 13:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 461E620643
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 13:02:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QLaS4+or"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbgAHNCs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 08:02:48 -0500
Received: from merlin.infradead.org ([205.233.59.134]:36626 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgAHNCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 08:02:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=RXfvehcFVw1Nh6t+COz9jrJFT3gPfoC+ft4FWH5Fqh0=; b=QLaS4+ore1Vs3ckMV89u4kwcu
        VuW8rUH3zNVGDoB9e1x8fxxsursBtS5eitYRjPrFpng5SC5A8EjacHrlhelh9O8yQQkOFbLjH8eYs
        tzZLk3mlwMgat/tQOAfk6TzGj8VVfg5TDuaXSZQcrSkcuT9jryQ6kRAWcxpoK+BsyOTvrD5DE0CnT
        R5keSu+W3FVbKnt1mTTRBJslgusvNHRn/pXtJUOi+ElGednQXbi5wzriWbolAN1fWxRHB8OuowDYQ
        OieDV2dtHHP7i2E3q1urMXjgJvnMO6xjffGZP5juxswsbfy2CHPxlCnarOfF9Sfh4i16QYCk4UbWv
        qILm+kV3w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ipAyZ-0002HO-Q9; Wed, 08 Jan 2020 13:02:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 704573012C3;
        Wed,  8 Jan 2020 14:00:37 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 707A420B79C80; Wed,  8 Jan 2020 14:02:10 +0100 (CET)
Date:   Wed, 8 Jan 2020 14:02:10 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     chenying <chen.ying153@zte.com.cn>, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org, xue.zhihong@zte.com.cn,
        wang.yi59@zte.com.cn, jiang.xuexin@zte.com.cn
Subject: Re: [PATCH] fix share rt runtime with offline rq
Message-ID: <20200108130210.GF2844@hirez.programming.kicks-ass.net>
References: <1576894812-36688-1-git-send-email-chen.ying153@zte.com.cn>
 <20191223114030.1800b4c1@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191223114030.1800b4c1@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 23, 2019 at 11:40:30AM -0500, Steven Rostedt wrote:
> >  kernel/sched/rt.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> > index a532558..d20dc86 100644
> > --- a/kernel/sched/rt.c
> > +++ b/kernel/sched/rt.c
> > @@ -648,8 +648,12 @@ static void do_balance_runtime(struct rt_rq *rt_rq)
> >  	rt_period = ktime_to_ns(rt_b->rt_period);
> >  	for_each_cpu(i, rd->span) {
> >  		struct rt_rq *iter = sched_rt_period_rt_rq(rt_b, i);
> > +		struct rq *rq = rq_of_rt_rq(iter);
> >  		s64 diff;
> >  
> > +		if (!rq->online)
> > +			continue;
> > +
> 
> I think this might be papering over the real issue. Perhaps
> rq_offline_rt() needs to be called for CPUs not being brought online?

Yeah, very much that. Something like the below perhaps. But I really
want to rip out the whole RT_CGROUP_SCHED stuff so we can start over.

Perhaps the poster can explain what he's using this stuff for?

---
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 4043abe45459..96a0320cfadb 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -208,7 +208,13 @@ int alloc_rt_sched_group(struct task_group *tg, struct task_group *parent)
 			goto err_free_rq;
 
 		init_rt_rq(rt_rq);
+
+		cpus_read_lock();
 		rt_rq->rt_runtime = tg->rt_bandwidth.rt_runtime;
+		if (!cpu_online(i))
+			rt_rq->rt_runtime = RUNTIME_INF;
+		cpus_read_unlock();
+
 		init_tg_rt_entry(tg, rt_rq, rt_se, i, parent->rt_se[i]);
 	}
 
