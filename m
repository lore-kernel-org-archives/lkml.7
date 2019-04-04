Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2564AC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 10:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7F4E204EC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 10:46:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729434AbfDDKqy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 06:46:54 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57880 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726694AbfDDKqy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 06:46:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E660CA78;
        Thu,  4 Apr 2019 03:46:53 -0700 (PDT)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4734E3F557;
        Thu,  4 Apr 2019 03:46:52 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] perf/arm-ccn: Remove broken race mitigation
To:     robin.murphy@arm.com, will.deacon@arm.com
Cc:     mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        bigeasy@linutronix.de, peterz@infradead.org,
        clabbe.montjoie@gmail.com, Meng.Li@windriver.com
References: <cover.1554310292.git.robin.murphy@arm.com>
 <49087b08f2685bed112dfc90b97ae59b8de8f6cf.1554310292.git.robin.murphy@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <2cbf5e2c-8a79-f2da-680f-ce20792ae2af@arm.com>
Date:   Thu, 4 Apr 2019 11:46:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <49087b08f2685bed112dfc90b97ae59b8de8f6cf.1554310292.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On 03/04/2019 18:10, Robin Murphy wrote:
> Like arm-cci, arm-ccn has the same issue of disabling preemption around
> operations which can take mutexes. Again, remove the definite bug by
> simply not trying to fight the theoretical races. And since we are
> touching the hotplug handling code, take the opportunity to streamline
> it, as there's really no need to store a full-sized cpumask to keep
> track of a single CPU ID.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>   drivers/perf/arm-ccn.c | 23 +++++++++++------------
>   1 file changed, 11 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/perf/arm-ccn.c b/drivers/perf/arm-ccn.c
> index 2ae76026e947..a0214308b0cd 100644
> --- a/drivers/perf/arm-ccn.c
> +++ b/drivers/perf/arm-ccn.c

>   	/* Pick one CPU which we will use to collect data from CCN... */
> -	cpumask_set_cpu(get_cpu(), &ccn->dt.cpu);
> +	ccn->dt.cpu = raw_smp_processor_id();
>   
>   	/* Also make sure that the overflow interrupt is handled by this CPU */
>   	if (ccn->irq) {
> -		err = irq_set_affinity_hint(ccn->irq, &ccn->dt.cpu);
> +		err = irq_set_affinity_hint(ccn->irq, cpumask_of(ccn->dt.cpu));
>   		if (err) {
>   			dev_err(ccn->dev, "Failed to set interrupt affinity!\n");
>   			goto error_set_affinity;
>   		}
>   	}
>   
> +	cpuhp_state_add_instance_nocalls(CPUHP_AP_PERF_ARM_CCN_ONLINE,
> +					 &ccn->dt.node);
> +
>   	err = perf_pmu_register(&ccn->dt.pmu, name, -1);
>   	if (err)
>   		goto error_pmu_register;

Should we not remove the above instance, in case we fail to register
the PMU ? Similarly for the CCI driver, we may have to reset the g_cci_pmu
if we fail.

Cheers
Suzuki


>   
> -	cpuhp_state_add_instance_nocalls(CPUHP_AP_PERF_ARM_CCN_ONLINE,
> -					 &ccn->dt.node);
> -	put_cpu();
>   	return 0;
>   
>   error_pmu_register:
>   error_set_affinity:
> -	put_cpu();
>   error_choose_name:
>   	ida_simple_remove(&arm_ccn_pmu_ida, ccn->dt.id);
>   	for (i = 0; i < ccn->num_xps; i++)
> 
