Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E888AC06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 17:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E32A420989
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 17:29:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="X3u0nH0m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbfGBR3E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 13:29:04 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52794 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbfGBR3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 13:29:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KZ9VwrqG/IRp4jX6fSDNnOQ7RxZe+lhI8MIeh/ntJvc=; b=X3u0nH0mK7iK5vfuzWUwfEpES
        inDQvv1lBCUsjKB9eKo35Yw9CvUt/spXfQq3ez0zMFuh6Kd26gxFAPM3VPrb3pr0HOROcOSmRGeMj
        /N1wjvNRqZKuVrVsX+aMCbOs8Hre3/hmcNkYCD+j4/Lr079GgQaFcAI2n4fC2zYRWFZpOJQsIYcdj
        Uu76KcdxP3OZfFfe8iRE1bsKntUg231W694I2dFFrOngjF+MuKuPhnBYAZsE/RdxTCJArO1L9Lwbo
        m/3WiFDm41OEv7QNJFZw56lvfIkdRkkkUz75ft1KiCCmMPoVliVvQhQfttZjwvx5m4RGbtYIx1qAl
        xQsgjWMow==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hiMaL-0005w3-Tk; Tue, 02 Jul 2019 17:28:54 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DCFE4207B53F0; Tue,  2 Jul 2019 19:28:51 +0200 (CEST)
Date:   Tue, 2 Jul 2019 19:28:51 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     subhra mazumdar <subhra.mazumdar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
        prakash.sangappa@oracle.com, dhaval.giani@oracle.com,
        daniel.lezcano@linaro.org, vincent.guittot@linaro.org,
        viresh.kumar@linaro.org, tim.c.chen@linux.intel.com,
        mgorman@techsingularity.net, Paul Turner <pjt@google.com>
Subject: Re: [RFC PATCH 2/3] sched: change scheduler to give preference to
 soft affinity CPUs
Message-ID: <20190702172851.GA3436@hirez.programming.kicks-ass.net>
References: <20190626224718.21973-1-subhra.mazumdar@oracle.com>
 <20190626224718.21973-3-subhra.mazumdar@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626224718.21973-3-subhra.mazumdar@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 03:47:17PM -0700, subhra mazumdar wrote:
> The soft affinity CPUs present in the cpumask cpus_preferred is used by the
> scheduler in two levels of search. First is in determining wake affine
> which choses the LLC domain and secondly while searching for idle CPUs in
> LLC domain. In the first level it uses cpus_preferred to prune out the
> search space. In the second level it first searches the cpus_preferred and
> then cpus_allowed. Using affinity_unequal flag it breaks early to avoid
> any overhead in the scheduler fast path when soft affinity is not used.
> This only changes the wake up path of the scheduler, the idle balancing
> is unchanged; together they achieve the "softness" of scheduling.

I really dislike this implementation.

I thought the idea was to remain work conserving (in so far as that
we're that anyway), so changing select_idle_sibling() doesn't make sense
to me. If there is idle, we use it.

Same for newidle; which you already retained.

This then leaves regular balancing, and for that we can fudge with
can_migrate_task() and nr_balance_failed or something.

And I also really don't want a second utilization tipping point; we
already have the overloaded thing.

I also still dislike how you never looked into the numa balancer, which
already has peferred_nid stuff.
