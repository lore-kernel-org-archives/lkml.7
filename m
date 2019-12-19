Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 557C8C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 10:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24BA1206D8
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 10:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MLID+4Fx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbfLSKEi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 05:04:38 -0500
Received: from merlin.infradead.org ([205.233.59.134]:45194 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbfLSKEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 05:04:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1l7uuKGr2NOR3EhCkUs5vFIbMfnYNMqwWjDhUMuanOk=; b=MLID+4FxR89rG1VIqbQ6iofIC
        J+dGT2KlNXnDE0oZIQtuxo7/aPEUMb5VVD+9PGpJiOUwR2+yTK4+xsIboDaleFWWzSLHOTRopnN7B
        ABoINCdGyeV1F5oD2XNhg8JG8Z7Z9RCv9Ut3IoVIxmZ6To0nzjngfUsuJMAkcgPUpwk8Q/EnWuf1V
        /gPbNEwg+93Z9DXSHW6JlatleYVkrFz0d3i7eoNNCUEwDajR6pJaA7GveT+bozZASHgSrGN9D2wzw
        vOWNMqS6CkmAdBmk1dDEpdsalCfHAt8Eqz/74qK7WlBFNbKArS88VouPWPJECH90uLAa8WxywttZ4
        Hb4OD6/bA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ihsfR-0006DX-15; Thu, 19 Dec 2019 10:04:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8C6F0300DB7;
        Thu, 19 Dec 2019 11:02:57 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0C1012B291C45; Thu, 19 Dec 2019 11:04:21 +0100 (CET)
Date:   Thu, 19 Dec 2019 11:04:21 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@kernel.org>, pauld@redhat.com,
        valentin.schneider@arm.com, srikar@linux.vnet.ibm.com,
        quentin.perret@arm.com, dietmar.eggemann@arm.com,
        Morten.Rasmussen@arm.com, hdanton@sina.com, parth@linux.ibm.com,
        riel@surriel.com, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched, fair: Allow a small degree of load imbalance
 between SD_NUMA domains
Message-ID: <20191219100421.GZ2844@hirez.programming.kicks-ass.net>
References: <20191218154402.GF3178@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191218154402.GF3178@techsingularity.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2019 at 03:44:02PM +0000, Mel Gorman wrote:
> @@ -8690,6 +8686,38 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
>  		env->migration_type = migrate_task;
>  		env->imbalance = max_t(long, 0, (local->idle_cpus -
>  						 busiest->idle_cpus) >> 1);
> +
> +out_spare:
> +		/*
> +		 * Whether balancing the number of running tasks or the number
> +		 * of idle CPUs, consider allowing some degree of imbalance if
> +		 * migrating between NUMA domains.
> +		 */
> +		if (env->sd->flags & SD_NUMA) {
> +			unsigned int imbalance_adj, imbalance_max;
> +
> +			/*
> +			 * imbalance_adj is the allowable degree of imbalance
> +			 * to exist between two NUMA domains. It's calculated
> +			 * relative to imbalance_pct with a minimum of two
> +			 * tasks or idle CPUs.
> +			 */
> +			imbalance_adj = (busiest->group_weight *
> +				(env->sd->imbalance_pct - 100) / 100) >> 1;
> +			imbalance_adj = max(imbalance_adj, 2U);

The '2' here comes from a 'pair of communicating tasks' right? Perhaps
more clearly detail that in the comment, such that when we're looking at
this code again in a few years time, we're not left wondering wtf that 2
is about :-)

> +
> +			/*
> +			 * Ignore imbalance unless busiest sd is close to 50%
> +			 * utilisation. At that point balancing for memory
> +			 * bandwidth and potentially avoiding unnecessary use
> +			 * of HT siblings is as relevant as memory locality.
> +			 */
> +			imbalance_max = (busiest->group_weight >> 1) - imbalance_adj;
> +			if (env->imbalance <= imbalance_adj &&
> +			    busiest->sum_nr_running < imbalance_max) {
> +				env->imbalance = 0;
> +			}
> +		}
>  		return;
>  	}
>  
> 
> -- 
> Mel Gorman
> SUSE Labs
