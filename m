Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 070B8C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 13:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C59572085A
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 13:27:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Z2gr8MtT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbfCNN1i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 09:27:38 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53472 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbfCNN1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 09:27:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=yT9EaSYi20IjGFg2GYcyPsUPRxIjYqpT0Z2um99l8Zw=; b=Z2gr8MtTnkExs0ba2F6U6LDF+
        ZDsF2DxS1zc3hMssj2b96/Pv0VtlgR62+KAj4O/kX3joH857xUyVC1pahDPwCsHg+dcy0sIz75ZNY
        YsHVHfnohSbk13n55M+LjmLqzUCrNcPhXabIGmkRgPFuTKLkh/eqaGwsiVEdj/1Muk6K5F9Uwhot9
        dO10InyZJM5bIIWB4t/T+hIxq7oAT04b6iH/qtMomrhwlrFObKrlRRxqfh4FYnKoVdkvvRu7d+waL
        8b6790c5abYZSEgnZKrlOFrm7Tfy7q8l5IQA6WY10vbXKsKOJTJ3rJVgfCCySi9231OacFRLYkHJj
        x43qlecWg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h4QOS-0004Uo-6g; Thu, 14 Mar 2019 13:27:32 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B6A84203C000B; Thu, 14 Mar 2019 14:27:30 +0100 (CET)
Date:   Thu, 14 Mar 2019 14:27:30 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-api@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v7 01/15] sched/core: uclamp: Add CPU's clamp buckets
 refcounting
Message-ID: <20190314132730.GI5996@hirez.programming.kicks-ass.net>
References: <20190208100554.32196-1-patrick.bellasi@arm.com>
 <20190208100554.32196-2-patrick.bellasi@arm.com>
 <20190313135238.GC5922@hirez.programming.kicks-ass.net>
 <20190313155954.jse2tyn5iqxm6wle@e110439-lin>
 <20190313193056.GP2482@worktop.programming.kicks-ass.net>
 <20190314110330.rshrdeoxgzt6pk5a@e110439-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190314110330.rshrdeoxgzt6pk5a@e110439-lin>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2019 at 11:03:30AM +0000, Patrick Bellasi wrote:

> void uclamp_rq_dec_id(struct rq *rq, int clamp_id, int bucket_id) {
>     if (__builtin_expect(!!(rq->uclamp[clamp_id].bucket[bucket_id].tasks), 1))
>         return;
>     rq->uclamp[clamp_id].bucket[bucket_id].tasks--;
> }
> ---8<---
> 
> generates something like:
> 
> ---8<---
> uclamp_rq_dec_id:
>         sxtw    x1, w1
>         add     x3, x1, x1, lsl 1
>         lsl     x3, x3, 2
>         sub     x3, x3, x1
>         lsl     x3, x3, 2
>         add     x2, x3, x2, sxtw 3
>         add     x0, x0, x2
>         ldr     w1, [x0, 8]
>         cbz     w1, .L4
>         ret
> .L4:
>         mov     w1, -1
>         str     w1, [x0, 8]
>         ret
> ---8<---
> 
> 
> which looks "sane" and quite expected, isn't it?

Yep, thanks! Sometimes I worry about silly things.
