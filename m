Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 445EFC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 14:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 102F12147C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 14:10:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="itajYF3T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbfCMOKP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 10:10:15 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58730 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbfCMOKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 10:10:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0U/xQi9K7IvDGR4nV1QNS9lG0XQYKLj9vkt1l56gZ3I=; b=itajYF3T4vLAdSA3BYtBabzKP
        OL1/FjmO74Y5V/4GVFX4tg95Cqomkh04qhLQmeQc6AEX/GS3YkzVNscZ1ibrMmBk14pOduH7naQrV
        Mutmrn1vq7yS6CADmRPO/AQP38JhE9DUoizC+DEcP4Qazb6aRxx789OCqBKHeLp8KmBc23aSUx42I
        ZwoTr60rOzig3KV/qDcDu0ElenRkNHsQ8HXcAmo+czoa62cM/WuIw8WCAL1IbSiJY+qsXpBaDF22o
        8cBIgY+4KU0jyRATjXf8BTXblWSnq4uaxJJapv/EsLutyPqO1joQBXo/hYbBMmTmPpZ8ztNbxH98R
        N6Qn5kFlA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h44a9-0004jO-Nf; Wed, 13 Mar 2019 14:10:09 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 404D72028B0E8; Wed, 13 Mar 2019 15:10:08 +0100 (CET)
Date:   Wed, 13 Mar 2019 15:10:08 +0100
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
Subject: Re: [PATCH v7 02/15] sched/core: uclamp: Enforce last task UCLAMP_MAX
Message-ID: <20190313141008.GF5922@hirez.programming.kicks-ass.net>
References: <20190208100554.32196-1-patrick.bellasi@arm.com>
 <20190208100554.32196-3-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190208100554.32196-3-patrick.bellasi@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2019 at 10:05:41AM +0000, Patrick Bellasi wrote:
> +uclamp_idle_value(struct rq *rq, unsigned int clamp_id, unsigned int clamp_value)
> +{
> +	/*
> +	 * Avoid blocked utilization pushing up the frequency when we go
> +	 * idle (which drops the max-clamp) by retaining the last known
> +	 * max-clamp.
> +	 */
> +	if (clamp_id == UCLAMP_MAX) {
> +		rq->uclamp_flags |= UCLAMP_FLAG_IDLE;
> +		return clamp_value;
> +	}
> +
> +	return uclamp_none(UCLAMP_MIN);

That's a very complicated way or writing: return 0, right?

> +}
