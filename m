Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F39C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 13:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C228C2196E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 13:56:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="E1OYAGZ6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbfKLN4m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 08:56:42 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43178 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbfKLN4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 08:56:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0gfyjZf/VkRczcU4sCGbmN62xzhqDkxbH1u5ItJHUYQ=; b=E1OYAGZ6QawAHpMqak+xq8eQs
        t5+/GHeNS20qjAOHLBPkn/1QlFSqcSHKHCC8jJWx3MYZyYWJJt5a7FZ7lIUSeCe7G8xFAUG7pjpu9
        XQoicGVskONd6zSmbJcu01sYOjSA6KzKjlCP2dSC/hGs6KfCMYN+GELNVLNPEqcISgOi9erl9KtB9
        1ne3icNuruSw8v1hr40Dj9q5++l8PoPvb/idRUbIDmLV0GKDaggg8yQSSlZNmsP9QMxUkDqPbGcnv
        9lndRI9Own8SiA6cRxQ9nBEuX6ZNswZVRinqYXxXHeL78lrKPTBUxdGHvQdXfObtjAvrkITFi9IN0
        vyMjkkhXw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iUWeg-0003kt-SK; Tue, 12 Nov 2019 13:56:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B546F300DDD;
        Tue, 12 Nov 2019 14:55:16 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3B99C20187E7C; Tue, 12 Nov 2019 14:56:23 +0100 (CET)
Date:   Tue, 12 Nov 2019 14:56:23 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     mingo@redhat.com, glenn@aurora.tech, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, tglx@linutronix.de,
        luca.abeni@santannapisa.it, c.scordino@evidence.eu.com,
        tommaso.cucinotta@santannapisa.it, bristot@redhat.com
Subject: Re: [PATCH 2/2] sched/deadline: Temporary copy static parameters to
 boosted non-DEADLINE entities
Message-ID: <20191112135623.GU5671@hirez.programming.kicks-ass.net>
References: <20191112075056.19971-1-juri.lelli@redhat.com>
 <20191112075056.19971-3-juri.lelli@redhat.com>
 <20191112105130.GZ4131@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191112105130.GZ4131@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2019 at 11:51:30AM +0100, Peter Zijlstra wrote:

>  	dl_se->deadline = rq_clock(rq) + dl_se->dl_deadline;
> +	dl_se->normal_deadline = dl_se->deadline;

Or rather something like:

static inline dl_set_deadline(struct sched_dl_entity *dl_se, u64 deadline)
{
	dl_se->normal_deadline = deadline;
	/*
	 * We should never update the deadline while boosted,
	 * but if we do, make sure to not change the effective
	 * deadline until deboost.
	 */
	if (WARN_ON_ONCE(dl_se->dl_boosted))
		return;
	dl_se->deadline = dl_se->normal_deadline;
}
