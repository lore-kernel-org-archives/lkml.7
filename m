Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C54C5DF60
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 20:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF59121929
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 20:21:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729655AbfKEUV5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 15:21:57 -0500
Received: from foss.arm.com ([217.140.110.172]:59566 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725806AbfKEUV4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 15:21:56 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3D778311;
        Tue,  5 Nov 2019 12:21:56 -0800 (PST)
Received: from localhost (e108754-lin.cambridge.arm.com [10.1.199.68])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D00C83F719;
        Tue,  5 Nov 2019 12:21:55 -0800 (PST)
Date:   Tue, 5 Nov 2019 20:21:54 +0000
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        rui.zhang@intel.com, edubezval@gmail.com, qperret@google.com,
        linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, daniel.lezcano@linaro.org
Subject: Re: [Patch v5 2/6] sched/fair: Add infrastructure to store and
 update  instantaneous thermal pressure
Message-ID: <20191105202037.GA17494@e108754-lin>
References: <1572979786-20361-1-git-send-email-thara.gopinath@linaro.org>
 <1572979786-20361-3-git-send-email-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1572979786-20361-3-git-send-email-thara.gopinath@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thara,

On Tuesday 05 Nov 2019 at 13:49:42 (-0500), Thara Gopinath wrote:
[...]
> +static void trigger_thermal_pressure_average(struct rq *rq)
> +{
> +#ifdef CONFIG_SMP
> +	update_thermal_load_avg(rq_clock_task(rq), rq,
> +				per_cpu(thermal_pressure, cpu_of(rq)));
> +#endif
> +}

Why did you decide to keep trigger_thermal_pressure_average and not
call update_thermal_load_avg directly?

For !CONFIG_SMP you already have an update_thermal_load_avg function
that does nothing, in kernel/sched/pelt.h, so you don't need that
ifdef. 

Thanks,
Ionela.

> +
>  /*
>   * All the scheduling class methods:
>   */
> -- 
> 2.1.4
> 
