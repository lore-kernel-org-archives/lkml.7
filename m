Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECCB1C33C99
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 11:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDC832077B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 11:23:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DOgrVJ1j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbgAGLXY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 06:23:24 -0500
Received: from merlin.infradead.org ([205.233.59.134]:49492 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726937AbgAGLXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 06:23:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=pr1OIIiYcGvrLhEd9QEUxm5iIVn4xs+eIhcYzlh+uwg=; b=DOgrVJ1jMcrYC/1BsrDiGjUNj
        3B69F5bffHaKO700mFz0SFBtaFiGyRFTZ86WMxsUUUyPJdNHK5q8/tZvstimdnSYirWtveRhV5xXa
        Y84FWAlbgyi3cWIixYZ5xqv7xu/RCrG5fJUTp8O4ahV20Ioc6h469fgs5+BoMyM8bDMTkaPHa1sSi
        iDc7I5Ra7uDZpiCHID1TjjGRJGWYt9S+7uqNyzmdFJ55+xxDSTygF12P8z1mOROu06XuBXJngAUIC
        pCMfXpsgOBP/ua9PkC52FTHpwYg2ToSZTk1pMfADbPJ0htywnGRlMAtskB3helRE+fbg6ZByV1dwZ
        Yx2OZ8c1A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iomws-0005td-IK; Tue, 07 Jan 2020 11:22:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id ADCF13012C3;
        Tue,  7 Jan 2020 12:21:22 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 368FD20D3D422; Tue,  7 Jan 2020 12:22:55 +0100 (CET)
Date:   Tue, 7 Jan 2020 12:22:55 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@kernel.org>, Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Hillf Danton <hdanton@sina.com>,
        Parth Shah <parth@linux.ibm.com>,
        Rik van Riel <riel@surriel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched, fair: Allow a small degree of load imbalance
 between SD_NUMA domains v2
Message-ID: <20200107112255.GV2827@hirez.programming.kicks-ass.net>
References: <20191220084252.GL3178@techsingularity.net>
 <CAKfTPtDp624geHEnPmHki70L=ZrBuz6zJG3zW0VFy+_S064Etw@mail.gmail.com>
 <20200103143051.GA3027@techsingularity.net>
 <CAKfTPtCGm7-mq3duxi=ugy+mn=Yutw6w9c35+cSHK8aZn7rzNQ@mail.gmail.com>
 <20200106145225.GB3466@techsingularity.net>
 <CAKfTPtBa74nd4VP3+7V51Jv=-UpqNyEocyTzMYwjopCgfWPSXg@mail.gmail.com>
 <20200107095655.GF3466@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200107095655.GF3466@techsingularity.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 07, 2020 at 09:56:55AM +0000, Mel Gorman wrote:

> Much more importantly, doing what you suggest allows an imbalance
> of more CPUs than are backed by a single LLC. On high-end AMD EPYC 2
> machines, busiest->group_weight scaled by imbalance_pct spans multiple L3
> caches. That is going to have side-effects. While I also do not account
> for the LLC group_weight, it's unlikely the cut-off I used would be
> smaller than an LLC cache on a large machine as the cache.
> 
> These two points are why I didn't take the group weight into account.
> 
> Now if you want, I can do what you suggest anyway as long as you are happy
> that the child domain weight is also taken into account and to bound the
> largest possible allowed imbalance to deal with the case of a node having
> multiple small LLC caches. That means that some machines will be using the
> size of the node and some machines will use the size of an LLC. It's less
> predictable overall as some machines will be "special" relative to others
> making it harder to reproduce certain problems locally but it would take
> imbalance_pct into account in a way that you're happy with.
> 
> Also bear in mind that whether LLC is accounted for or not, the final
> result should be halved similar to the other imbalance calculations to
> avoid over or under load balancing.

> +		/* Consider allowing a small imbalance between NUMA groups */
> +		if (env->sd->flags & SD_NUMA) {
> +			struct sched_domain *child = env->sd->child;

This assumes sd-child exists, which should be true for NUMA domains I
suppose.

> +			unsigned int imbalance_adj;
> +
> +			/*
> +			 * Calculate an acceptable degree of imbalance based
> +			 * on imbalance_adj. However, do not allow a greater
> +			 * imbalance than the child domains weight to avoid
> +			 * a case where the allowed imbalance spans multiple
> +			 * LLCs.
> +			 */

That comment is a wee misleading, @child is not an LLC per se. This
could be the NUMA distance 2 domain, in which case @child is the NUMA
distance 1 group.

That said, even then it probably makes sense to ensure you don't idle a
whole smaller distance group.

> +			imbalance_adj = busiest->group_weight * (env->sd->imbalance_pct - 100) / 100;
> +			imbalance_adj = min(imbalance_adj, child->span_weight);
> +			imbalance_adj >>= 1;
> +
> +			/*
> +			 * Ignore small imbalances when the busiest group has
> +			 * low utilisation.
> +			 */
> +			if (busiest->sum_nr_running < imbalance_adj)
> +				env->imbalance = 0;
> +		}
> +
>  		return;
>  	}
>  
