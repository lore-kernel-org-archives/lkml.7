Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 696A8C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 11:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37F1A2189D
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 11:41:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LcF4Tuib"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbfH1Llq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 07:41:46 -0400
Received: from merlin.infradead.org ([205.233.59.134]:46880 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbfH1Llq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 07:41:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=fSpXTrdVOEeAcGqJ/E8uEG2rEskhj76ysPzyL1f5x5k=; b=LcF4TuibbU0aSbD8g6vKz9skG
        OLOHH+OFA2YKSygO7iRvI26fp0M+s/cd6B8IYLahcNo8OfleJbJpDQcavY/ES79CdnrGf2L5HiTOb
        ewEWIpWdHTbQpof+VjB+tIRLJTK8ZiWmXQCb6e0id66925+4bxxy8FZXvritpCCoVwYb4t4NqYlh1
        94XV4UHs+tbphyDypJ2J5qgQPCqnIaVQIlPl/FrCCQjGYh8kyulu/OLs8NIx3mVvr+u6Hh0tlQvML
        l1g7YwEfqPQqkCQTu858ywvKyzauOjMUoDyfBbKUE5oVD/zpSRryzTMIBbCUQaiYEG6Rf/oc2+CkE
        vfPoBGs9A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i2wKW-0001k4-Mo; Wed, 28 Aug 2019 11:41:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 06086307594;
        Wed, 28 Aug 2019 13:41:00 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BFF45201A38CA; Wed, 28 Aug 2019 13:41:34 +0200 (CEST)
Date:   Wed, 28 Aug 2019 13:41:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Liangyan <liangyan.peng@linux.alibaba.com>,
        Ingo Molnar <mingo@redhat.com>,
        Ben Segall <bsegall@google.com>, linux-kernel@vger.kernel.org,
        shanpeic@linux.alibaba.com, xlpang@linux.alibaba.com
Subject: Re: [PATCH v3] sched/fair: don't assign runtime for throttled cfs_rq
Message-ID: <20190828114134.GH2369@hirez.programming.kicks-ass.net>
References: <20190826121633.6538-1-liangyan.peng@linux.alibaba.com>
 <71df56cc-529b-aefb-2905-48e02de5cf86@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71df56cc-529b-aefb-2905-48e02de5cf86@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 11:16:52AM +0100, Valentin Schneider wrote:
> On 26/08/2019 13:16, Liangyan wrote:
> > do_sched_cfs_period_timer() will refill cfs_b runtime and call
> > distribute_cfs_runtime to unthrottle cfs_rq, sometimes cfs_b->runtime
> > will allocate all quota to one cfs_rq incorrectly, then other cfs_rqs
> > attached to this cfs_b can't get runtime and will be throttled.
> > 
> > We find that one throttled cfs_rq has non-negative
> > cfs_rq->runtime_remaining and cause an unexpetced cast from s64 to u64
> > in snippet: distribute_cfs_runtime() {
> > runtime = -cfs_rq->runtime_remaining + 1; }.
> > The runtime here will change to a large number and consume all
> > cfs_b->runtime in this cfs_b period.
> > 
> > According to Ben Segall, the throttled cfs_rq can have
> > account_cfs_rq_runtime called on it because it is throttled before
> > idle_balance, and the idle_balance calls update_rq_clock to add time
> > that is accounted to the task.
> > 
> > This commit prevents cfs_rq to be assgined new runtime if it has been
> > throttled until that distribute_cfs_runtime is called.
> > 
> > Signed-off-by: Liangyan <liangyan.peng@linux.alibaba.com>
> > Reviewed-by: Ben Segall <bsegall@google.com>
> > Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
> 
> @Peter/Ingo, if we care about it I believe it can't hurt to strap
> 
> Cc: <stable@vger.kernel.org>
> Fixes: d3d9dc330236 ("sched: Throttle entities exceeding their allowed bandwidth")
> 
> to the thing.

OK, done.
