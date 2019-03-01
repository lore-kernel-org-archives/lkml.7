Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0536C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 16:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEC7620840
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 16:59:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389324AbfCAQ7r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 11:59:47 -0500
Received: from mga17.intel.com ([192.55.52.151]:38832 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728493AbfCAQ7q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 11:59:46 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Mar 2019 08:59:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,428,1544515200"; 
   d="scan'208";a="121870014"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 01 Mar 2019 08:59:44 -0800
Received: from [10.254.83.214] (kliang2-mobl1.ccr.corp.intel.com [10.254.83.214])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 499A65805B4;
        Fri,  1 Mar 2019 08:59:43 -0800 (PST)
Subject: Re: [RFC] perf/x86/rapl: Getting zero on energy-cores event
To:     Jiri Olsa <jolsa@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc:     Vince Weaver <vincent.weaver@maine.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Stephane Eranian <eranian@google.com>
References: <20190301114250.GA23459@krava>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <5fcaf3ae-00d3-f635-74bd-8b81a089133f@linux.intel.com>
Date:   Fri, 1 Mar 2019 11:59:40 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.2
MIME-Version: 1.0
In-Reply-To: <20190301114250.GA23459@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/1/2019 6:42 AM, Jiri Olsa wrote:
> hi,
> I'm getting zero counts for energy-cores event on broadwell-x
> server (model 0x4f)
> 
> I checked intel_rapl powercap driver and it won't export the
> counter if it rdmsr returns zero on it
> 
> the SDM also says the rdmsr returns zero for some models
> 
> I made changes on perf rapl pmu below to remove sysfs events
> if their rdmsr returns zero just to ilustrate the case
> 
> I think there's probably better fix, but I'm not sure if
> there's a reason for zero counters to be exposed..?

+Stephane, who is the author.

I'm OK to hide the zero counters.


> 
> thoughts? thanks,
> jirka
> 
> 
> ---
> diff --git a/arch/x86/events/intel/rapl.c b/arch/x86/events/intel/rapl.c
> index 94dc564146ca..effb9a9d2368 100644
> --- a/arch/x86/events/intel/rapl.c
> +++ b/arch/x86/events/intel/rapl.c
> @@ -54,6 +54,7 @@
>   #include <linux/module.h>
>   #include <linux/slab.h>
>   #include <linux/perf_event.h>
> +#include <linux/nospec.h>
>   #include <asm/cpu_device_id.h>
>   #include <asm/intel-family.h>
>   #include "../perf_event.h"
> @@ -346,10 +347,18 @@ static void rapl_pmu_event_del(struct perf_event *event, int flags)
>   	rapl_pmu_event_stop(event, PERF_EF_UPDATE);
>   }
>   
> +static unsigned int event_msr[NR_RAPL_DOMAINS] = {
> +	MSR_PP0_ENERGY_STATUS,
> +	MSR_PKG_ENERGY_STATUS,
> +	MSR_DRAM_ENERGY_STATUS,
> +	MSR_PP1_ENERGY_STATUS,
> +	MSR_PLATFORM_ENERGY_STATUS,
> +};
> +
>   static int rapl_pmu_event_init(struct perf_event *event)
>   {
>   	u64 cfg = event->attr.config & RAPL_EVENT_MASK;
> -	int bit, msr, ret = 0;
> +	int bit, ret = 0;
>   	struct rapl_pmu *pmu;
>   
>   	/* only look at RAPL events */
> @@ -365,33 +374,12 @@ static int rapl_pmu_event_init(struct perf_event *event)
>   
>   	event->event_caps |= PERF_EV_CAP_READ_ACTIVE_PKG;
>   
> -	/*
> -	 * check event is known (determines counter)
> -	 */
> -	switch (cfg) {
> -	case INTEL_RAPL_PP0:
> -		bit = RAPL_IDX_PP0_NRG_STAT;
> -		msr = MSR_PP0_ENERGY_STATUS;
> -		break;
> -	case INTEL_RAPL_PKG:
> -		bit = RAPL_IDX_PKG_NRG_STAT;
> -		msr = MSR_PKG_ENERGY_STATUS;
> -		break;
> -	case INTEL_RAPL_RAM:
> -		bit = RAPL_IDX_RAM_NRG_STAT;
> -		msr = MSR_DRAM_ENERGY_STATUS;
> -		break;
> -	case INTEL_RAPL_PP1:
> -		bit = RAPL_IDX_PP1_NRG_STAT;
> -		msr = MSR_PP1_ENERGY_STATUS;
> -		break;
> -	case INTEL_RAPL_PSYS:
> -		bit = RAPL_IDX_PSYS_NRG_STAT;
> -		msr = MSR_PLATFORM_ENERGY_STATUS;
> -		break;
> -	default:
> +	if (!cfg || cfg >= NR_RAPL_DOMAINS)
>   		return -EINVAL;
> -	}
> +
> +	cfg = array_index_nospec(cfg, NR_RAPL_DOMAINS);
> +	bit = cfg - 1;
> +
>   	/* check event supported */
>   	if (!(rapl_cntr_mask & (1 << bit)))
>   		return -EINVAL;
> @@ -406,7 +394,7 @@ static int rapl_pmu_event_init(struct perf_event *event)
>   		return -EINVAL;
>   	event->cpu = pmu->cpu;
>   	event->pmu_private = pmu;
> -	event->hw.event_base = msr;
> +	event->hw.event_base = event_msr[bit];
>   	event->hw.config = cfg;
>   	event->hw.idx = bit;
>   
> @@ -435,11 +423,27 @@ static struct attribute_group rapl_pmu_attr_group = {
>   	.attrs = rapl_pmu_attrs,
>   };
>   
> -RAPL_EVENT_ATTR_STR(energy-cores, rapl_cores, "event=0x01");
> -RAPL_EVENT_ATTR_STR(energy-pkg  ,   rapl_pkg, "event=0x02");
> -RAPL_EVENT_ATTR_STR(energy-ram  ,   rapl_ram, "event=0x03");
> -RAPL_EVENT_ATTR_STR(energy-gpu  ,   rapl_gpu, "event=0x04");
> -RAPL_EVENT_ATTR_STR(energy-psys,   rapl_psys, "event=0x05");
> +static ssize_t
> +rapl_event_sysfs_show(struct device *dev, struct device_attribute *attr,
> +		      char *page)
> +{
> +	struct perf_pmu_events_attr *pmu_attr =
> +		container_of(attr, struct perf_pmu_events_attr, attr);
> +
> +	return sprintf(page, "event=%llu\n", pmu_attr->id);
> +}
> +
> +#define RAPL_EVENT_ATTR(_name, v, _id)					\
> +static struct perf_pmu_events_attr event_attr_##v = {			\
> +	.attr	= __ATTR(_name, 0444, rapl_event_sysfs_show, NULL),	\
> +	.id	= RAPL_IDX_##_id##_NRG_STAT,				\
> +};
> +
> +RAPL_EVENT_ATTR(energy-cores,  rapl_cores,  PP0);
> +RAPL_EVENT_ATTR(energy-pkg  ,    rapl_pkg,  PKG);
> +RAPL_EVENT_ATTR(energy-ram  ,    rapl_ram,  RAM);
> +RAPL_EVENT_ATTR(energy-gpu  ,    rapl_gpu,  PP1);
> +RAPL_EVENT_ATTR(energy-psys ,   rapl_psys, PSYS);
>   
>   RAPL_EVENT_ATTR_STR(energy-cores.unit, rapl_cores_unit, "Joules");
>   RAPL_EVENT_ATTR_STR(energy-pkg.unit  ,   rapl_pkg_unit, "Joules");
> @@ -780,6 +784,59 @@ static const struct x86_cpu_id rapl_cpu_match[] __initconst = {
>   
>   MODULE_DEVICE_TABLE(x86cpu, rapl_cpu_match);
>   
> +static void __init remove_name(struct attribute **attrs, const char *name)
> +{
> +	struct device_attribute *attr;
> +	int i, j;
> +
> +	for (i = 0; attrs[i]; i++) {
> +		attr = (struct device_attribute *) attrs[i];
> +
> +		if (strncmp(name, attr->attr.name, strlen(name)))
> +			continue;
> +
> +		for (j = i; attrs[j]; j++)
> +			attrs[j] = attrs[j + 1];
> +
> +		/* Check the shifted attr. */
> +		i--;
> +	}
> +}
> +
> +static void __init check_events(struct attribute **attrs)
> +{
> +	struct perf_pmu_events_attr *pmu_attr;
> +	struct device_attribute *attr;
> +	int i, j;
> +
> +	for (i = 0; attrs[i]; i++) {
> +		u64 val = 0;
> +		u64 bit;
> +
> +		attr     = (struct device_attribute *) attrs[i];
> +		pmu_attr = container_of(attr, struct perf_pmu_events_attr, attr);
> +
> +		if (pmu_attr->event_str)
> +			continue;
> +
> +		bit = pmu_attr->id;
> +
> +		if (WARN_ON_ONCE(bit >= NR_RAPL_DOMAINS))
> +			continue;
> +
> +		if (!rdmsrl_safe(event_msr[bit], &val) && val)
> +			continue;
> +
> +		remove_name(&attrs[i + 1], attr->attr.name);

In perf cstate, we check and insert the available events for sysfs attrs
I think we should use the same way here. It's better to factor out a 
common function for both cstate and rapl.


Peter,

The cstate, rapl and uncore are similar. I think it should be the right 
direction to abstract several common functions for them.
Here, the sysfs attrs is an example.
The common topology related functions I proposed is another example.
https://lore.kernel.org/lkml/9631a92f-5b24-26a6-e160-4e4c0b4697c1@linux.intel.com/

Thanks,
Kan
