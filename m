Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A76BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 20:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 020012077B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 20:52:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="b4n5K4bp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbfCMUwu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 16:52:50 -0400
Received: from merlin.infradead.org ([205.233.59.134]:54686 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbfCMUwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 16:52:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=GuHM5VtsuT2QzC+XxvSuatbRUReMLfv3sQaupc2Og28=; b=b4n5K4bpk4mCjAHenCZXDbwXb
        y3LuIQICCH53Hc+zym+5hDcgQJIiCQnMLe5nA7TZg9b497lIopqCOwvp6rohXG3XX7nyLQ0AB/DrN
        ei4NHDze10bJOrrcmPPJozVkdPnAOhmVBcbwJ/mtGl1R9mwRAMSH1I6XmI3/DGtKF7kCRSGEEUq2O
        0W9B1Cvk8/x3JDVNJMzmOc3m+8SK5j3MgejNbGnbACBGOdzHWabBhHIqF8mXa7QYZq1EoYWsjecL+
        fUKMRtENtPylNRn2GBVRlTRsYwStcjdRDJJqmFOAcNfH+URrwjnue021mCOInGRziMJRGfj9E7JDD
        +Dn05pfqQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h4Are-0000CC-6D; Wed, 13 Mar 2019 20:52:38 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2F55E9826C0; Wed, 13 Mar 2019 21:52:35 +0100 (CET)
Date:   Wed, 13 Mar 2019 21:52:35 +0100
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
Subject: Re: [PATCH v7 06/15] sched/core: uclamp: Reset uclamp values on
 RESET_ON_FORK
Message-ID: <20190313205235.GX2482@worktop.programming.kicks-ass.net>
References: <20190208100554.32196-1-patrick.bellasi@arm.com>
 <20190208100554.32196-7-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190208100554.32196-7-patrick.bellasi@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2019 at 10:05:45AM +0000, Patrick Bellasi wrote:
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 070caa1f72eb..8b282616e9c9 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1071,7 +1071,7 @@ static void __setscheduler_uclamp(struct task_struct *p,
>  	}
>  }
>  
> -static void uclamp_fork(struct task_struct *p)
> +static void uclamp_fork(struct task_struct *p, bool reset)
>  {
>  	unsigned int clamp_id;
>  
> @@ -1080,6 +1080,17 @@ static void uclamp_fork(struct task_struct *p)

IIRC there's an early return here if the class doesn't have uclamp
support, which I think is wrong now. You want the reset irrespective of
whether the class supports it, no?

>  
>  	for (clamp_id = 0; clamp_id < UCLAMP_CNT; ++clamp_id)
>  		p->uclamp[clamp_id].active = false;
> +
> +	if (likely(!reset))
> +		return;
> +
> +	for (clamp_id = 0; clamp_id < UCLAMP_CNT; ++clamp_id) {
> +		unsigned int clamp_value = uclamp_none(clamp_id);
> +
> +		p->uclamp[clamp_id].user_defined = false;
> +		p->uclamp[clamp_id].value = clamp_value;
> +		p->uclamp[clamp_id].bucket_id = uclamp_bucket_id(clamp_value);
> +	}
>  }


