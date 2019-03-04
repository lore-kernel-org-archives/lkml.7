Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDFC1C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 13:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB51F20835
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 13:05:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbfCDNFC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 08:05:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58666 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726196AbfCDNFB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 08:05:01 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DF4CB307AD11;
        Mon,  4 Mar 2019 13:05:00 +0000 (UTC)
Received: from krava (unknown [10.43.17.112])
        by smtp.corp.redhat.com (Postfix) with SMTP id BFED660144;
        Mon,  4 Mar 2019 13:04:58 +0000 (UTC)
Date:   Mon, 4 Mar 2019 14:04:58 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [RFC] perf/x86/rapl: Getting zero on energy-cores event
Message-ID: <20190304130458.GE30476@krava>
References: <20190301114250.GA23459@krava>
 <5fcaf3ae-00d3-f635-74bd-8b81a089133f@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5fcaf3ae-00d3-f635-74bd-8b81a089133f@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Mon, 04 Mar 2019 13:05:01 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2019 at 11:59:40AM -0500, Liang, Kan wrote:
> 
> 
> On 3/1/2019 6:42 AM, Jiri Olsa wrote:
> > hi,
> > I'm getting zero counts for energy-cores event on broadwell-x
> > server (model 0x4f)
> > 
> > I checked intel_rapl powercap driver and it won't export the
> > counter if it rdmsr returns zero on it
> > 
> > the SDM also says the rdmsr returns zero for some models
> > 
> > I made changes on perf rapl pmu below to remove sysfs events
> > if their rdmsr returns zero just to ilustrate the case
> > 
> > I think there's probably better fix, but I'm not sure if
> > there's a reason for zero counters to be exposed..?
> 
> +Stephane, who is the author.
> 
> I'm OK to hide the zero counters.
> 
> 
> > 
> > thoughts? thanks,
> > jirka
> > 
> > 
> > ---
> > diff --git a/arch/x86/events/intel/rapl.c b/arch/x86/events/intel/rapl.c
> > index 94dc564146ca..effb9a9d2368 100644
> > --- a/arch/x86/events/intel/rapl.c
> > +++ b/arch/x86/events/intel/rapl.c
> > @@ -54,6 +54,7 @@
> >   #include <linux/module.h>
> >   #include <linux/slab.h>
> >   #include <linux/perf_event.h>
> > +#include <linux/nospec.h>
> >   #include <asm/cpu_device_id.h>
> >   #include <asm/intel-family.h>
> >   #include "../perf_event.h"
> > @@ -346,10 +347,18 @@ static void rapl_pmu_event_del(struct perf_event *event, int flags)
> >   	rapl_pmu_event_stop(event, PERF_EF_UPDATE);
> >   }
> > +static unsigned int event_msr[NR_RAPL_DOMAINS] = {
> > +	MSR_PP0_ENERGY_STATUS,
> > +	MSR_PKG_ENERGY_STATUS,
> > +	MSR_DRAM_ENERGY_STATUS,
> > +	MSR_PP1_ENERGY_STATUS,
> > +	MSR_PLATFORM_ENERGY_STATUS,
> > +};
> > +
> >   static int rapl_pmu_event_init(struct perf_event *event)
> >   {
> >   	u64 cfg = event->attr.config & RAPL_EVENT_MASK;
> > -	int bit, msr, ret = 0;
> > +	int bit, ret = 0;
> >   	struct rapl_pmu *pmu;
> >   	/* only look at RAPL events */
> > @@ -365,33 +374,12 @@ static int rapl_pmu_event_init(struct perf_event *event)
> >   	event->event_caps |= PERF_EV_CAP_READ_ACTIVE_PKG;
> > -	/*
> > -	 * check event is known (determines counter)
> > -	 */
> > -	switch (cfg) {
> > -	case INTEL_RAPL_PP0:
> > -		bit = RAPL_IDX_PP0_NRG_STAT;
> > -		msr = MSR_PP0_ENERGY_STATUS;
> > -		break;
> > -	case INTEL_RAPL_PKG:
> > -		bit = RAPL_IDX_PKG_NRG_STAT;
> > -		msr = MSR_PKG_ENERGY_STATUS;
> > -		break;
> > -	case INTEL_RAPL_RAM:
> > -		bit = RAPL_IDX_RAM_NRG_STAT;
> > -		msr = MSR_DRAM_ENERGY_STATUS;
> > -		break;
> > -	case INTEL_RAPL_PP1:
> > -		bit = RAPL_IDX_PP1_NRG_STAT;
> > -		msr = MSR_PP1_ENERGY_STATUS;
> > -		break;
> > -	case INTEL_RAPL_PSYS:
> > -		bit = RAPL_IDX_PSYS_NRG_STAT;
> > -		msr = MSR_PLATFORM_ENERGY_STATUS;
> > -		break;
> > -	default:
> > +	if (!cfg || cfg >= NR_RAPL_DOMAINS)
> >   		return -EINVAL;
> > -	}
> > +
> > +	cfg = array_index_nospec(cfg, NR_RAPL_DOMAINS);
> > +	bit = cfg - 1;
> > +
> >   	/* check event supported */
> >   	if (!(rapl_cntr_mask & (1 << bit)))
> >   		return -EINVAL;
> > @@ -406,7 +394,7 @@ static int rapl_pmu_event_init(struct perf_event *event)
> >   		return -EINVAL;
> >   	event->cpu = pmu->cpu;
> >   	event->pmu_private = pmu;
> > -	event->hw.event_base = msr;
> > +	event->hw.event_base = event_msr[bit];
> >   	event->hw.config = cfg;
> >   	event->hw.idx = bit;
> > @@ -435,11 +423,27 @@ static struct attribute_group rapl_pmu_attr_group = {
> >   	.attrs = rapl_pmu_attrs,
> >   };
> > -RAPL_EVENT_ATTR_STR(energy-cores, rapl_cores, "event=0x01");
> > -RAPL_EVENT_ATTR_STR(energy-pkg  ,   rapl_pkg, "event=0x02");
> > -RAPL_EVENT_ATTR_STR(energy-ram  ,   rapl_ram, "event=0x03");
> > -RAPL_EVENT_ATTR_STR(energy-gpu  ,   rapl_gpu, "event=0x04");
> > -RAPL_EVENT_ATTR_STR(energy-psys,   rapl_psys, "event=0x05");
> > +static ssize_t
> > +rapl_event_sysfs_show(struct device *dev, struct device_attribute *attr,
> > +		      char *page)
> > +{
> > +	struct perf_pmu_events_attr *pmu_attr =
> > +		container_of(attr, struct perf_pmu_events_attr, attr);
> > +
> > +	return sprintf(page, "event=%llu\n", pmu_attr->id);
> > +}
> > +
> > +#define RAPL_EVENT_ATTR(_name, v, _id)					\
> > +static struct perf_pmu_events_attr event_attr_##v = {			\
> > +	.attr	= __ATTR(_name, 0444, rapl_event_sysfs_show, NULL),	\
> > +	.id	= RAPL_IDX_##_id##_NRG_STAT,				\
> > +};
> > +
> > +RAPL_EVENT_ATTR(energy-cores,  rapl_cores,  PP0);
> > +RAPL_EVENT_ATTR(energy-pkg  ,    rapl_pkg,  PKG);
> > +RAPL_EVENT_ATTR(energy-ram  ,    rapl_ram,  RAM);
> > +RAPL_EVENT_ATTR(energy-gpu  ,    rapl_gpu,  PP1);
> > +RAPL_EVENT_ATTR(energy-psys ,   rapl_psys, PSYS);
> >   RAPL_EVENT_ATTR_STR(energy-cores.unit, rapl_cores_unit, "Joules");
> >   RAPL_EVENT_ATTR_STR(energy-pkg.unit  ,   rapl_pkg_unit, "Joules");
> > @@ -780,6 +784,59 @@ static const struct x86_cpu_id rapl_cpu_match[] __initconst = {
> >   MODULE_DEVICE_TABLE(x86cpu, rapl_cpu_match);
> > +static void __init remove_name(struct attribute **attrs, const char *name)
> > +{
> > +	struct device_attribute *attr;
> > +	int i, j;
> > +
> > +	for (i = 0; attrs[i]; i++) {
> > +		attr = (struct device_attribute *) attrs[i];
> > +
> > +		if (strncmp(name, attr->attr.name, strlen(name)))
> > +			continue;
> > +
> > +		for (j = i; attrs[j]; j++)
> > +			attrs[j] = attrs[j + 1];
> > +
> > +		/* Check the shifted attr. */
> > +		i--;
> > +	}
> > +}
> > +
> > +static void __init check_events(struct attribute **attrs)
> > +{
> > +	struct perf_pmu_events_attr *pmu_attr;
> > +	struct device_attribute *attr;
> > +	int i, j;
> > +
> > +	for (i = 0; attrs[i]; i++) {
> > +		u64 val = 0;
> > +		u64 bit;
> > +
> > +		attr     = (struct device_attribute *) attrs[i];
> > +		pmu_attr = container_of(attr, struct perf_pmu_events_attr, attr);
> > +
> > +		if (pmu_attr->event_str)
> > +			continue;
> > +
> > +		bit = pmu_attr->id;
> > +
> > +		if (WARN_ON_ONCE(bit >= NR_RAPL_DOMAINS))
> > +			continue;
> > +
> > +		if (!rdmsrl_safe(event_msr[bit], &val) && val)
> > +			continue;
> > +
> > +		remove_name(&attrs[i + 1], attr->attr.name);
> 
> In perf cstate, we check and insert the available events for sysfs attrs
> I think we should use the same way here. It's better to factor out a common
> function for both cstate and rapl.

right, we will need to add some support to add multiple
attributes (for .unit and .scale files) but it seems
doable.. I'll try to put something  together

thanks,
jirka

> 
> 
> Peter,
> 
> The cstate, rapl and uncore are similar. I think it should be the right
> direction to abstract several common functions for them.
> Here, the sysfs attrs is an example.
> The common topology related functions I proposed is another example.
> https://lore.kernel.org/lkml/9631a92f-5b24-26a6-e160-4e4c0b4697c1@linux.intel.com/
> 
> Thanks,
> Kan
