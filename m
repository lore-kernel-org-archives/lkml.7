Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CCB4FA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 13:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AC832168B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 13:30:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405354AbfJPNav (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 09:30:51 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4219 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388342AbfJPNau (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 09:30:50 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 1ED8C5D4AE5A087F7F66;
        Wed, 16 Oct 2019 21:30:47 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.179) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Wed, 16 Oct 2019
 21:30:37 +0800
Subject: Re: [PATCH v6 2/2] drivers/perf: Add CCPI2 PMU support in ThunderX2
 UNCORE driver.
To:     Ganapatrao Prabhakerrao Kulkarni <gkulkarni@marvell.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <1571218608-15933-1-git-send-email-gkulkarni@marvell.com>
 <1571218608-15933-3-git-send-email-gkulkarni@marvell.com>
CC:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        Jan Glauber <jglauber@marvell.com>,
        "Jayachandran Chandrasekharan Nair" <jnair@marvell.com>,
        "gklkml16@gmail.com" <gklkml16@gmail.com>,
        Robert Richter <rrichter@marvell.com>,
        "will@kernel.org" <will@kernel.org>,
        Zhangshaokun <zhangshaokun@hisilicon.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <b8e1a637-faf4-4567-7d3e-a4f13dfa1cf0@huawei.com>
Date:   Wed, 16 Oct 2019 14:30:30 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <1571218608-15933-3-git-send-email-gkulkarni@marvell.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.179]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> +TX2_EVENT_ATTR(req_pktsent, CCPI2_EVENT_REQ_PKT_SENT);
> +TX2_EVENT_ATTR(snoop_pktsent, CCPI2_EVENT_SNOOP_PKT_SENT);
> +TX2_EVENT_ATTR(data_pktsent, CCPI2_EVENT_DATA_PKT_SENT);
> +TX2_EVENT_ATTR(gic_pktsent, CCPI2_EVENT_GIC_PKT_SENT);
> +
> +static struct attribute *ccpi2_pmu_events_attrs[] = {
> +	&tx2_pmu_event_attr_req_pktsent.attr.attr,
> +	&tx2_pmu_event_attr_snoop_pktsent.attr.attr,
> +	&tx2_pmu_event_attr_data_pktsent.attr.attr,
> +	&tx2_pmu_event_attr_gic_pktsent.attr.attr,
> +	NULL,
> +};

Hi Ganapatrao,

Have you considered adding these as uncore pmu-events in the perf tool?

Some advantages I see:
- perf list is not swamped with all these uncore events per PMU
For the Hisi uncore events, we get 100s of events (>600 on the board I 
just tested, which is crazy)
- can add more description in the JSON files
- less stuff in the kernel

> +
>  static const struct attribute_group l3c_pmu_events_attr_group = {
>  	.name = "events",
>  	.attrs = l3c_pmu_events_attrs,
> @@ -174,6 +240,11 @@ static const struct attribute_group dmc_pmu_events_attr_group = {
>  	.attrs = dmc_pmu_events_attrs,
>  };

[...]

>  		tx2_pmu->attr_groups = l3c_pmu_attr_groups;
>  		tx2_pmu->name = devm_kasprintf(dev, GFP_KERNEL,
>  				"uncore_l3c_%d", tx2_pmu->node);
> @@ -665,10 +846,13 @@ static struct tx2_uncore_pmu *tx2_uncore_pmu_init_dev(struct device *dev,
>  		tx2_pmu->stop_event = uncore_stop_event_l3c;
>  		break;
>  	case PMU_TYPE_DMC:
> -		tx2_pmu->max_counters = TX2_PMU_MAX_COUNTERS;
> +		tx2_pmu->max_counters = TX2_PMU_DMC_L3C_MAX_COUNTERS;
> +		tx2_pmu->counters_mask = 0x3;
>  		tx2_pmu->prorate_factor = TX2_PMU_DMC_CHANNELS;
>  		tx2_pmu->max_events = DMC_EVENT_MAX;
> +		tx2_pmu->events_mask = 0x1f;
>  		tx2_pmu->hrtimer_interval = TX2_PMU_HRTIMER_INTERVAL;
> +		tx2_pmu->hrtimer_callback = tx2_hrtimer_callback;
>  		tx2_pmu->attr_groups = dmc_pmu_attr_groups;
>  		tx2_pmu->name = devm_kasprintf(dev, GFP_KERNEL,
>  				"uncore_dmc_%d", tx2_pmu->node);
> @@ -676,6 +860,21 @@ static struct tx2_uncore_pmu *tx2_uncore_pmu_init_dev(struct device *dev,
>  		tx2_pmu->start_event = uncore_start_event_dmc;
>  		tx2_pmu->stop_event = uncore_stop_event_dmc;
>  		break;
> +	case PMU_TYPE_CCPI2:
> +		/* CCPI2 has 8 counters */
> +		tx2_pmu->max_counters = TX2_PMU_CCPI2_MAX_COUNTERS;
> +		tx2_pmu->counters_mask = 0x7;
> +		tx2_pmu->prorate_factor = 1;
> +		tx2_pmu->max_events = CCPI2_EVENT_MAX;
> +		tx2_pmu->events_mask = 0x1ff;
> +		tx2_pmu->attr_groups = ccpi2_pmu_attr_groups;
> +		tx2_pmu->name = devm_kasprintf(dev, GFP_KERNEL,
> +				"uncore_ccpi2_%d", tx2_pmu->node);

Do you need to check this for name == NULL?

> +		tx2_pmu->init_cntr_base = init_cntr_base_ccpi2;
> +		tx2_pmu->start_event = uncore_start_event_ccpi2;
> +		tx2_pmu->stop_event = uncore_stop_event_ccpi2;
> +		tx2_pmu->hrtimer_callback = NULL;
> +		break;
>  	case PMU_TYPE_INVALID:
>  		devm_kfree(dev, tx2_pmu);
>  		return NULL;
> @@ -744,7 +943,9 @@ static int tx2_uncore_pmu_offline_cpu(unsigned int cpu,
>  	if (cpu != tx2_pmu->cpu)
>  		return 0;
>
> -	hrtimer_cancel(&tx2_pmu->hrtimer);
> +	if (tx2_pmu->hrtimer_callback)
> +		hrtimer_cancel(&tx2_pmu->hrtimer);
> +
>  	cpumask_copy(&cpu_online_mask_temp, cpu_online_mask);
>  	cpumask_clear_cpu(cpu, &cpu_online_mask_temp);
>  	new_cpu = cpumask_any_and(
>

Thanks,
John


