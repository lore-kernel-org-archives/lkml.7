Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE2DC004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 13:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32B042053B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 13:35:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbfEGNfd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 09:35:33 -0400
Received: from foss.arm.com ([217.140.101.70]:54406 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726295AbfEGNfd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 09:35:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9581580D;
        Tue,  7 May 2019 06:35:32 -0700 (PDT)
Received: from queper01-lin (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 165423F73C;
        Tue,  7 May 2019 06:35:29 -0700 (PDT)
Date:   Tue, 7 May 2019 14:35:28 +0100
From:   Quentin Perret <quentin.perret@arm.com>
To:     Luca Abeni <luca.abeni@santannapisa.it>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>
Subject: Re: [RFC PATCH 2/6] sched/dl: Capacity-aware migrations
Message-ID: <20190507133528.ia4p3medvtg4z5az@queper01-lin>
References: <20190506044836.2914-1-luca.abeni@santannapisa.it>
 <20190506044836.2914-3-luca.abeni@santannapisa.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190506044836.2914-3-luca.abeni@santannapisa.it>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luca,

On Monday 06 May 2019 at 06:48:32 (+0200), Luca Abeni wrote:
> +static inline int dl_task_fit(const struct sched_dl_entity *dl_se,
> +			      int cpu, u64 *c)
> +{
> +	u64 cap = (arch_scale_cpu_capacity(NULL, cpu) * arch_scale_freq_capacity(cpu)) >> SCHED_CAPACITY_SHIFT;

I'm a little bit confused by this use of arch_scale_freq_capacity()
here. IIUC this means you would say a big DL task doesn't fit on a big
CPU just because it happens to be running at a low frequency when this
function is called. Is this what we want ?

If the frequency is low, we can (probably) raise it to accommodate this
DL task so perhaps we should say it fits ?

> +	s64 rel_deadline = dl_se->dl_deadline;
> +	u64 rem_runtime  = dl_se->dl_runtime;
> +
> +	if (c)
> +		*c = cap;
> +
> +	if ((rel_deadline * cap) >> SCHED_CAPACITY_SHIFT < rem_runtime)
> +		return 0;
> +
> +	return 1;
> +}

Thanks,
Quentin
