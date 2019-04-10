Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A1EC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 10:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FE8C20830
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 10:31:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730049AbfDJKbn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 06:31:43 -0400
Received: from foss.arm.com ([217.140.101.70]:51482 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729778AbfDJKbm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 06:31:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3A7EB15AB;
        Wed, 10 Apr 2019 03:31:42 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.194.71])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 069ED3F59C;
        Wed, 10 Apr 2019 03:31:40 -0700 (PDT)
Date:   Wed, 10 Apr 2019 11:31:38 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, Dietmar.Eggemann@arm.com,
        morten.rasmussen@arm.com
Subject: Re: [PATCH 1/2] sched/topology: build_sched_groups: Skip duplicate
 group rewrites
Message-ID: <20190410103137.hip56n52dvg6lxsq@e107158-lin.cambridge.arm.com>
References: <20190409173546.4747-1-valentin.schneider@arm.com>
 <20190409173546.4747-2-valentin.schneider@arm.com>
 <20190410092723.d4j4ctccogprtptg@e107158-lin.cambridge.arm.com>
 <ab929846-4f05-0ce9-c159-7f560a7edfca@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ab929846-4f05-0ce9-c159-7f560a7edfca@arm.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/10/19 11:17, Valentin Schneider wrote:
> On 10/04/2019 10:27, Qais Yousef wrote:
> [...]
> >> @@ -1066,9 +1067,14 @@ static struct sched_group *get_group(int cpu, struct sd_data *sdd)
> >>  	sg = *per_cpu_ptr(sdd->sg, cpu);
> >>  	sg->sgc = *per_cpu_ptr(sdd->sgc, cpu);
> >>  
> >> -	/* For claim_allocations: */
> >> -	atomic_inc(&sg->ref);
> >> -	atomic_inc(&sg->sgc->ref);
> >> +	/* Increase refcounts for claim_allocations: */
> >> +	already_visited = atomic_inc_return(&sg->ref) > 1;
> >> +	/* sgc visits should follow a similar trend as sg */
> >> +	WARN_ON(already_visited != (atomic_inc_return(&sg->sgc->ref) > 1));
> > 
> > NIT: I think it would be better to not have any side effect of calling
> > WARN_ON(). Ie: do the atomic_inc_return() outside the WARN_ON() condition.
> > Having two bool already_visited_sg and already_visited_sgc will make the code
> > more readable too.
> > 
> 
> I agree it's not the nicest reading flow there is. It's already gone in
> tip/sched/core but if needed I can resend with this extra separation.

It was just a nit from my side. So for me it's not worth a resend if it's
already accepted.

--
Qais Yousef
