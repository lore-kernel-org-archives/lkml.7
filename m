Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 118CBC48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 09:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1E662084B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 09:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561629458;
	bh=eymMH7rhqPovbEEcyDUkxmiLeDNPOUlwlSPI+kUeMSk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sZdBlQweagRiSfKOXlR6+6/MNrdkm+DI4HXfOArohYIAgq5+mVVSlMM4QSrLzDo4z
	 r8/D8WybxaQ8puBtzS3dWPiHANU3cXjMG56XZPHPdPAOEw18r3xjSOoqTdx736MoO3
	 AqKz8f612Nuow9OmBRN1N7XgBIu0NmhuHlFrMbqc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbfF0J5h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 05:57:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:36308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726292AbfF0J5h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 05:57:37 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DCD72082F;
        Thu, 27 Jun 2019 09:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561629455;
        bh=eymMH7rhqPovbEEcyDUkxmiLeDNPOUlwlSPI+kUeMSk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iKw/cvhwFeCnk0FJmt6JSjpNaDz6UuCDoVYhgfgZlQwhZSRSUGIrr8bQjSJ6da6zy
         HUr7ao27x1tJhm7Nece6QDkmTX80BN3RbunJcSHnn7g8xUueeYgtUpCTEFkwK/I0Uk
         UjjzqXq+dDPNkKRvp7MerD93dkjExDudFK2m696o=
Date:   Thu, 27 Jun 2019 10:57:30 +0100
From:   Will Deacon <will@kernel.org>
To:     Ganapatrao Kulkarni <gkulkarni@marvell.com>
Cc:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "Will.Deacon@arm.com" <Will.Deacon@arm.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "jnair@caviumnetworks.com" <jnair@caviumnetworks.com>,
        "Robert.Richter@cavium.com" <Robert.Richter@cavium.com>,
        "Jan.Glauber@cavium.com" <Jan.Glauber@cavium.com>,
        "gklkml16@gmail.com" <gklkml16@gmail.com>
Subject: Re: [PATCH 2/2] drivers/perf: Add CCPI2 PMU support in ThunderX2
 UNCORE driver.
Message-ID: <20190627095730.nf5kkataptfobzue@willie-the-truck>
References: <1560534144-13896-1-git-send-email-gkulkarni@marvell.com>
 <1560534144-13896-3-git-send-email-gkulkarni@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1560534144-13896-3-git-send-email-gkulkarni@marvell.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ganapat,

On Fri, Jun 14, 2019 at 05:42:46PM +0000, Ganapatrao Kulkarni wrote:
> CCPI2 is a low-latency high-bandwidth serial interface for connecting
> ThunderX2 processors. This patch adds support to capture CCPI2 perf events.
> 
> Signed-off-by: Ganapatrao Kulkarni <gkulkarni@marvell.com>
> ---
>  drivers/perf/thunderx2_pmu.c | 179 ++++++++++++++++++++++++++++++-----
>  1 file changed, 157 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/perf/thunderx2_pmu.c b/drivers/perf/thunderx2_pmu.c
> index 43d76c85da56..3791ac9b897d 100644
> --- a/drivers/perf/thunderx2_pmu.c
> +++ b/drivers/perf/thunderx2_pmu.c
> @@ -16,7 +16,9 @@
>   * they need to be sampled before overflow(i.e, at every 2 seconds).
>   */
>  
> -#define TX2_PMU_MAX_COUNTERS		4
> +#define TX2_PMU_DMC_L3C_MAX_COUNTERS	4

I find it odd that you rename this...

> +#define TX2_PMU_CCPI2_MAX_COUNTERS	8
> +
>  #define TX2_PMU_DMC_CHANNELS		8
>  #define TX2_PMU_L3_TILES		16
>  
> @@ -28,11 +30,22 @@
>    */
>  #define DMC_EVENT_CFG(idx, val)		((val) << (((idx) * 8) + 1))
>  
> +#define GET_EVENTID_CCPI2(ev)		((ev->hw.config) & 0x1ff)
> +/* bits[3:0] to select counters, starts from 8, bit[3] set always. */
> +#define GET_COUNTERID_CCPI2(ev)		((ev->hw.idx) & 0x7)
> +#define CCPI2_COUNTER_OFFSET		8


... but leave GET_EVENTID alone, even though it only applies to DMC/L3C
events. Saying that, if you have the event you can figure out its type,
so could you avoid the need for additional macros entirely and just use
the correct masks based on the corresponding PMU type? That might also
avoid some of the conditional control flow you're introducing elsewhere.

>  #define L3C_COUNTER_CTL			0xA8
>  #define L3C_COUNTER_DATA		0xAC
>  #define DMC_COUNTER_CTL			0x234
>  #define DMC_COUNTER_DATA		0x240
>  
> +#define CCPI2_PERF_CTL			0x108
> +#define CCPI2_COUNTER_CTL		0x10C
> +#define CCPI2_COUNTER_SEL		0x12c
> +#define CCPI2_COUNTER_DATA_L		0x130
> +#define CCPI2_COUNTER_DATA_H		0x134
> +
>  /* L3C event IDs */
>  #define L3_EVENT_READ_REQ		0xD
>  #define L3_EVENT_WRITEBACK_REQ		0xE
> @@ -51,9 +64,16 @@
>  #define DMC_EVENT_READ_TXNS		0xF
>  #define DMC_EVENT_MAX			0x10
>  
> +#define CCPI2_EVENT_REQ_PKT_SENT	0x3D
> +#define CCPI2_EVENT_SNOOP_PKT_SENT	0x65
> +#define CCPI2_EVENT_DATA_PKT_SENT	0x105
> +#define CCPI2_EVENT_GIC_PKT_SENT	0x12D
> +#define CCPI2_EVENT_MAX			0x200
> +
>  enum tx2_uncore_type {
>  	PMU_TYPE_L3C,
>  	PMU_TYPE_DMC,
> +	PMU_TYPE_CCPI2,
>  	PMU_TYPE_INVALID,
>  };
>  
> @@ -73,8 +93,8 @@ struct tx2_uncore_pmu {
>  	u32 max_events;
>  	u64 hrtimer_interval;
>  	void __iomem *base;
> -	DECLARE_BITMAP(active_counters, TX2_PMU_MAX_COUNTERS);
> -	struct perf_event *events[TX2_PMU_MAX_COUNTERS];
> +	DECLARE_BITMAP(active_counters, TX2_PMU_CCPI2_MAX_COUNTERS);
> +	struct perf_event *events[TX2_PMU_DMC_L3C_MAX_COUNTERS];

Hmm, that looks very odd. Why are they now different sizes?

>  	struct device *dev;
>  	struct hrtimer hrtimer;
>  	const struct attribute_group **attr_groups;
> @@ -92,7 +112,21 @@ static inline struct tx2_uncore_pmu *pmu_to_tx2_pmu(struct pmu *pmu)
>  	return container_of(pmu, struct tx2_uncore_pmu, pmu);
>  }
>  
> -PMU_FORMAT_ATTR(event,	"config:0-4");
> +#define TX2_PMU_FORMAT_ATTR(_var, _name, _format)			\
> +static ssize_t								\
> +__tx2_pmu_##_var##_show(struct device *dev,				\
> +			       struct device_attribute *attr,		\
> +			       char *page)				\
> +{									\
> +	BUILD_BUG_ON(sizeof(_format) >= PAGE_SIZE);			\
> +	return sprintf(page, _format "\n");				\
> +}									\
> +									\
> +static struct device_attribute format_attr_##_var =			\
> +	__ATTR(_name, 0444, __tx2_pmu_##_var##_show, NULL)
> +
> +TX2_PMU_FORMAT_ATTR(event, event, "config:0-4");
> +TX2_PMU_FORMAT_ATTR(event_ccpi2, event, "config:0-9");

This doesn't look right. Can perf deal with overlapping fields? It seems
wrong that we'd allow the user to specify both, for example.

>  
>  static struct attribute *l3c_pmu_format_attrs[] = {
>  	&format_attr_event.attr,
> @@ -104,6 +138,11 @@ static struct attribute *dmc_pmu_format_attrs[] = {
>  	NULL,
>  };
>  
> +static struct attribute *ccpi2_pmu_format_attrs[] = {
> +	&format_attr_event_ccpi2.attr,
> +	NULL,
> +};
> +
>  static const struct attribute_group l3c_pmu_format_attr_group = {
>  	.name = "format",
>  	.attrs = l3c_pmu_format_attrs,
> @@ -114,6 +153,11 @@ static const struct attribute_group dmc_pmu_format_attr_group = {
>  	.attrs = dmc_pmu_format_attrs,
>  };
>  
> +static const struct attribute_group ccpi2_pmu_format_attr_group = {
> +	.name = "format",
> +	.attrs = ccpi2_pmu_format_attrs,
> +};
> +
>  /*
>   * sysfs event attributes
>   */
> @@ -164,6 +208,19 @@ static struct attribute *dmc_pmu_events_attrs[] = {
>  	NULL,
>  };
>  
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
> +
>  static const struct attribute_group l3c_pmu_events_attr_group = {
>  	.name = "events",
>  	.attrs = l3c_pmu_events_attrs,
> @@ -174,6 +231,11 @@ static const struct attribute_group dmc_pmu_events_attr_group = {
>  	.attrs = dmc_pmu_events_attrs,
>  };
>  
> +static const struct attribute_group ccpi2_pmu_events_attr_group = {
> +	.name = "events",
> +	.attrs = ccpi2_pmu_events_attrs,
> +};
> +
>  /*
>   * sysfs cpumask attributes
>   */
> @@ -213,6 +275,13 @@ static const struct attribute_group *dmc_pmu_attr_groups[] = {
>  	NULL
>  };
>  
> +static const struct attribute_group *ccpi2_pmu_attr_groups[] = {
> +	&ccpi2_pmu_format_attr_group,
> +	&pmu_cpumask_attr_group,
> +	&ccpi2_pmu_events_attr_group,
> +	NULL
> +};
> +
>  static inline u32 reg_readl(unsigned long addr)
>  {
>  	return readl((void __iomem *)addr);
> @@ -265,6 +334,17 @@ static void init_cntr_base_dmc(struct perf_event *event,
>  		+ DMC_COUNTER_DATA + (0xc * GET_COUNTERID(event));
>  }
>  
> +static void init_cntr_base_ccpi2(struct perf_event *event,
> +		struct tx2_uncore_pmu *tx2_pmu)
> +{
> +
> +	struct hw_perf_event *hwc = &event->hw;
> +
> +	hwc->config_base = (unsigned long)tx2_pmu->base
> +		+ CCPI2_COUNTER_CTL + (4 * GET_COUNTERID_CCPI2(event));
> +	hwc->event_base =  (unsigned long)tx2_pmu->base;
> +}
> +
>  static void uncore_start_event_l3c(struct perf_event *event, int flags)
>  {
>  	u32 val;
> @@ -312,6 +392,29 @@ static void uncore_stop_event_dmc(struct perf_event *event)
>  	reg_writel(val, hwc->config_base);
>  }
>  
> +static void uncore_start_event_ccpi2(struct perf_event *event, int flags)
> +{
> +	u32 val;
> +	struct hw_perf_event *hwc = &event->hw;
> +
> +	/* Bit [09:00] to set event id, set level and type to 1 */
> +	val = reg_readl(hwc->config_base);
> +	reg_writel((val & ~0xFFF) | (3 << 10) |
> +			GET_EVENTID_CCPI2(event), hwc->config_base);
> +	/* reset[4], enable[0] and start[1] counters */
> +	reg_writel(0x13, hwc->event_base + CCPI2_PERF_CTL);
> +	local64_set(&event->hw.prev_count, 0ULL);
> +}
> +
> +static void uncore_stop_event_ccpi2(struct perf_event *event)
> +{
> +	struct hw_perf_event *hwc = &event->hw;
> +
> +	/* disable and stop counter */
> +	reg_writel(0, hwc->event_base + CCPI2_PERF_CTL);

How come you need to clear the event register here? You don't do that for
the DMC/L3C paths.

> +	reg_writel(0, hwc->config_base);

When starting event you're careful to update this using a read-modify-write
sequence. Why is it safe to zero the whole thing when stopping?

> +}
> +
>  static void tx2_uncore_event_update(struct perf_event *event)
>  {
>  	s64 prev, delta, new = 0;
> @@ -323,12 +426,20 @@ static void tx2_uncore_event_update(struct perf_event *event)
>  	tx2_pmu = pmu_to_tx2_pmu(event->pmu);
>  	type = tx2_pmu->type;
>  	prorate_factor = tx2_pmu->prorate_factor;
> -
> -	new = reg_readl(hwc->event_base);
> -	prev = local64_xchg(&hwc->prev_count, new);
> -
> -	/* handles rollover of 32 bit counter */
> -	delta = (u32)(((1UL << 32) - prev) + new);
> +	if (type == PMU_TYPE_CCPI2) {
> +		reg_writel(CCPI2_COUNTER_OFFSET + GET_COUNTERID_CCPI2(event),
> +					hwc->event_base + CCPI2_COUNTER_SEL);
> +		new = reg_readl(hwc->event_base + CCPI2_COUNTER_DATA_L);
> +		new |= (u64)reg_readl(hwc->event_base +
> +				CCPI2_COUNTER_DATA_H) << 32;

Can you not access the event register using a 64-bit read?

> +		prev = local64_xchg(&hwc->prev_count, new);
> +		delta = new - prev;
> +	} else {
> +		new = reg_readl(hwc->event_base);
> +		prev = local64_xchg(&hwc->prev_count, new);
> +		/* handles rollover of 32 bit counter */
> +		delta = (u32)(((1UL << 32) - prev) + new);
> +	}
>  
>  	/* DMC event data_transfers granularity is 16 Bytes, convert it to 64 */
>  	if (type == PMU_TYPE_DMC &&
> @@ -351,6 +462,7 @@ static enum tx2_uncore_type get_tx2_pmu_type(struct acpi_device *adev)
>  	} devices[] = {
>  		{"CAV901D", PMU_TYPE_L3C},
>  		{"CAV901F", PMU_TYPE_DMC},
> +		{"CAV901E", PMU_TYPE_CCPI2},
>  		{"", PMU_TYPE_INVALID}
>  	};
>  
> @@ -380,7 +492,8 @@ static bool tx2_uncore_validate_event(struct pmu *pmu,
>   * Make sure the group of events can be scheduled at once
>   * on the PMU.
>   */
> -static bool tx2_uncore_validate_event_group(struct perf_event *event)
> +static bool tx2_uncore_validate_event_group(struct perf_event *event,
> +		int max_counters)
>  {
>  	struct perf_event *sibling, *leader = event->group_leader;
>  	int counters = 0;
> @@ -403,7 +516,7 @@ static bool tx2_uncore_validate_event_group(struct perf_event *event)
>  	 * If the group requires more counters than the HW has,
>  	 * it cannot ever be scheduled.
>  	 */
> -	return counters <= TX2_PMU_MAX_COUNTERS;
> +	return counters <= max_counters;
>  }
>  
>  
> @@ -439,7 +552,7 @@ static int tx2_uncore_event_init(struct perf_event *event)
>  	hwc->config = event->attr.config;
>  
>  	/* Validate the group */
> -	if (!tx2_uncore_validate_event_group(event))
> +	if (!tx2_uncore_validate_event_group(event, tx2_pmu->max_counters))
>  		return -EINVAL;
>  
>  	return 0;
> @@ -457,7 +570,8 @@ static void tx2_uncore_event_start(struct perf_event *event, int flags)
>  	perf_event_update_userpage(event);
>  
>  	/* Start timer for first event */
> -	if (bitmap_weight(tx2_pmu->active_counters,
> +	if (tx2_pmu->type != PMU_TYPE_CCPI2 &&
> +			bitmap_weight(tx2_pmu->active_counters,
>  				tx2_pmu->max_counters) == 1) {
>  		hrtimer_start(&tx2_pmu->hrtimer,
>  			ns_to_ktime(tx2_pmu->hrtimer_interval),
> @@ -495,7 +609,8 @@ static int tx2_uncore_event_add(struct perf_event *event, int flags)
>  	if (hwc->idx < 0)
>  		return -EAGAIN;
>  
> -	tx2_pmu->events[hwc->idx] = event;
> +	if (tx2_pmu->type != PMU_TYPE_CCPI2)
> +		tx2_pmu->events[hwc->idx] = event;
>  	/* set counter control and data registers base address */
>  	tx2_pmu->init_cntr_base(event, tx2_pmu);
>  
> @@ -514,10 +629,14 @@ static void tx2_uncore_event_del(struct perf_event *event, int flags)
>  	tx2_uncore_event_stop(event, PERF_EF_UPDATE);
>  
>  	/* clear the assigned counter */
> -	free_counter(tx2_pmu, GET_COUNTERID(event));
> +	if (tx2_pmu->type == PMU_TYPE_CCPI2)
> +		free_counter(tx2_pmu, GET_COUNTERID_CCPI2(event));
> +	else
> +		free_counter(tx2_pmu, GET_COUNTERID(event));
>  
>  	perf_event_update_userpage(event);
> -	tx2_pmu->events[hwc->idx] = NULL;
> +	if (tx2_pmu->type != PMU_TYPE_CCPI2)
> +		tx2_pmu->events[hwc->idx] = NULL;
>  	hwc->idx = -1;
>  }
>  
> @@ -580,8 +699,12 @@ static int tx2_uncore_pmu_add_dev(struct tx2_uncore_pmu *tx2_pmu)
>  			cpu_online_mask);
>  
>  	tx2_pmu->cpu = cpu;
> -	hrtimer_init(&tx2_pmu->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> -	tx2_pmu->hrtimer.function = tx2_hrtimer_callback;
> +	/* CCPI2 counters are 64 bit counters. */
> +	if (tx2_pmu->type != PMU_TYPE_CCPI2) {
> +		hrtimer_init(&tx2_pmu->hrtimer,
> +				CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> +		tx2_pmu->hrtimer.function = tx2_hrtimer_callback;
> +	}

So I take it the CCPI2 also doesn't have an IRQ, and therefore you can't
hook up sampling events?

Will
