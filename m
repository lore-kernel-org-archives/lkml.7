Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57FF0C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32A7C2087C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:26:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729321AbfDPQ0t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 12:26:49 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59180 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726230AbfDPQ0t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 12:26:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9E4D980D;
        Tue, 16 Apr 2019 09:26:48 -0700 (PDT)
Received: from [10.37.12.3] (unknown [10.37.12.3])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 52A753F59C;
        Tue, 16 Apr 2019 09:26:46 -0700 (PDT)
Subject: Re: [PATCH v3 2/2] perf/arm-ccn: Clean up CPU hotplug handling
To:     robin.murphy@arm.com, will.deacon@arm.com
Cc:     mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        bigeasy@linutronix.de, peterz@infradead.org,
        clabbe.montjoie@gmail.com, Meng.Li@windriver.com
References: <cover.1555427430.git.robin.murphy@arm.com>
 <918d9bb287b1086d62415030139204aab44c2221.1555427430.git.robin.murphy@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <aa07acc9-dd1a-8953-279e-b98cdc035665@arm.com>
Date:   Tue, 16 Apr 2019 17:29:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <918d9bb287b1086d62415030139204aab44c2221.1555427430.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/16/2019 04:24 PM, Robin Murphy wrote:
> Like arm-cci, arm-ccn has the same issue of disabling preemption around
> operations which can take mutexes. Again, remove the definite bug by
> simply not trying to fight the theoretical races. And since we are
> touching the hotplug handling code, take the opportunity to streamline
> it, as there's really no need to store a full-sized cpumask to keep
> track of a single CPU ID.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>   drivers/perf/arm-ccn.c | 25 +++++++++++++------------
>   1 file changed, 13 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/perf/arm-ccn.c b/drivers/perf/arm-ccn.c
> index 2ae76026e947..0bb52d9bdcf7 100644
> --- a/drivers/perf/arm-ccn.c
> +++ b/drivers/perf/arm-ccn.c
> @@ -167,7 +167,7 @@ struct arm_ccn_dt {
>   
>   	struct hrtimer hrtimer;
>   
> -	cpumask_t cpu;
> +	unsigned int cpu;
>   	struct hlist_node node;
>   
>   	struct pmu pmu;
> @@ -559,7 +559,7 @@ static ssize_t arm_ccn_pmu_cpumask_show(struct device *dev,
>   {
>   	struct arm_ccn *ccn = pmu_to_arm_ccn(dev_get_drvdata(dev));
>   
> -	return cpumap_print_to_pagebuf(true, buf, &ccn->dt.cpu);
> +	return cpumap_print_to_pagebuf(true, buf, cpumask_of(ccn->dt.cpu));
>   }
>   
>   static struct device_attribute arm_ccn_pmu_cpumask_attr =
> @@ -759,7 +759,7 @@ static int arm_ccn_pmu_event_init(struct perf_event *event)
>   	 * mitigate this, we enforce CPU assignment to one, selected
>   	 * processor (the one described in the "cpumask" attribute).
>   	 */
> -	event->cpu = cpumask_first(&ccn->dt.cpu);
> +	event->cpu = ccn->dt.cpu;
>   
>   	node_xp = CCN_CONFIG_NODE(event->attr.config);
>   	type = CCN_CONFIG_TYPE(event->attr.config);
> @@ -1215,15 +1215,15 @@ static int arm_ccn_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
>   	struct arm_ccn *ccn = container_of(dt, struct arm_ccn, dt);
>   	unsigned int target;
>   
> -	if (!cpumask_test_and_clear_cpu(cpu, &dt->cpu))
> +	if (cpu != dt->cpu)
>   		return 0;
>   	target = cpumask_any_but(cpu_online_mask, cpu);
>   	if (target >= nr_cpu_ids)
>   		return 0;
>   	perf_pmu_migrate_context(&dt->pmu, cpu, target);
> -	cpumask_set_cpu(target, &dt->cpu);
> +	dt->cpu = target;
>   	if (ccn->irq)
> -		WARN_ON(irq_set_affinity_hint(ccn->irq, &dt->cpu) != 0);
> +		WARN_ON(irq_set_affinity_hint(ccn->irq, cpumask_of(dt->cpu)));
>   	return 0;
>   }
>   
> @@ -1299,29 +1299,30 @@ static int arm_ccn_pmu_init(struct arm_ccn *ccn)
>   	}
>   
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
>   
> -	cpuhp_state_add_instance_nocalls(CPUHP_AP_PERF_ARM_CCN_ONLINE,
> -					 &ccn->dt.node);
> -	put_cpu();
>   	return 0;
>   
>   error_pmu_register:
> +	cpuhp_state_remove_instance_nocalls(CPUHP_AP_PERF_ARM_CCN_ONLINE,
> +					    &ccn->dt.node);
>   error_set_affinity:
> -	put_cpu();

Super minor nit: We don't need the error_set_affinity label anymore, as
we don't do anything here. Otherwise:

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
