Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00CE1C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 12:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2FAB218FD
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 12:36:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbfCUMg1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 08:36:27 -0400
Received: from foss.arm.com ([217.140.101.70]:55382 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727986AbfCUMg1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 08:36:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F49D80D;
        Thu, 21 Mar 2019 05:36:26 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C1FFE3F614;
        Thu, 21 Mar 2019 05:36:23 -0700 (PDT)
Subject: Re: [PATCH v6 4/4] perf/smmuv3_pmu: Enable HiSilicon Erratum
 162001800 quirk
To:     Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        lorenzo.pieralisi@arm.com
Cc:     andrew.murray@arm.com, jean-philippe.brucker@arm.com,
        will.deacon@arm.com, mark.rutland@arm.com, guohanjun@huawei.com,
        john.garry@huawei.com, pabba@codeaurora.org,
        vkilari@codeaurora.org, rruigrok@codeaurora.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linuxarm@huawei.com,
        neil.m.leeder@gmail.com
References: <20190204121324.11460-1-shameerali.kolothum.thodi@huawei.com>
 <20190204121324.11460-5-shameerali.kolothum.thodi@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <ac16c8c7-02e6-5837-5887-737d7ebdcbea@arm.com>
Date:   Thu, 21 Mar 2019 12:36:22 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190204121324.11460-5-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/02/2019 12:13, Shameer Kolothum wrote:
> HiSilicon erratum 162001800 describes the limitation of
> SMMUv3 PMCG implementation on HiSilicon Hip08 platforms.
> 
> On these platforms, the PMCG event counter registers
> (SMMU_PMCG_EVCNTRn) are read only and as a result it
> is not possible to set the initial counter period value
> on event monitor start.
> 
> To work around this, the current value of the counter
> is read and used for delta calculations. OEM information
> from ACPI header is used to identify the affected hardware
> platforms.
> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>   drivers/acpi/arm64/iort.c     | 16 ++++++++++++++-
>   drivers/perf/arm_smmuv3_pmu.c | 48 ++++++++++++++++++++++++++++++++++++-------
>   include/linux/acpi_iort.h     |  1 +
>   3 files changed, 57 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index e2c9b26..4dc68de 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -1366,9 +1366,23 @@ static void __init arm_smmu_v3_pmcg_init_resources(struct resource *res,
>   				       ACPI_EDGE_SENSITIVE, &res[2]);
>   }
>   
> +static struct acpi_platform_list pmcg_plat_info[] __initdata = {
> +	/* HiSilicon Hip08 Platform */
> +	{"HISI  ", "HIP08   ", 0, ACPI_SIG_IORT, greater_than_or_equal, 0,
> +	 IORT_SMMU_V3_PMCG_HISI_HIP08},
> +	{ }
> +};
> +
>   static int __init arm_smmu_v3_pmcg_add_platdata(struct platform_device *pdev)
>   {
> -	u32 model = IORT_SMMU_V3_PMCG_GENERIC;
> +	u32 model;
> +	int idx;
> +
> +	idx = acpi_match_platform_list(pmcg_plat_info);
> +	if (idx >= 0)
> +		model = pmcg_plat_info[idx].data;
> +	else
> +		model = IORT_SMMU_V3_PMCG_GENERIC;
>   
>   	return platform_device_add_data(pdev, &model, sizeof(model));
>   }
> diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.c
> index eeb9dee..95a3ed0 100644
> --- a/drivers/perf/arm_smmuv3_pmu.c
> +++ b/drivers/perf/arm_smmuv3_pmu.c
> @@ -35,6 +35,7 @@
>    */
>   
>   #include <linux/acpi.h>
> +#include <linux/acpi_iort.h>
>   #include <linux/bitfield.h>
>   #include <linux/bitops.h>
>   #include <linux/cpuhotplug.h>
> @@ -93,6 +94,8 @@
>   
>   #define SMMU_PMCG_PA_SHIFT              12
>   
> +#define SMMU_PMCG_EVCNTR_RDONLY         BIT(0)
> +
>   static int cpuhp_state_num;
>   
>   struct smmu_pmu {
> @@ -107,6 +110,7 @@ struct smmu_pmu {
>   	struct device *dev;
>   	void __iomem *reg_base;
>   	void __iomem *reloc_base;
> +	u32 options;

Super-nit: can we put options the other side of counter_mask so as to 
not waste 8 whole bytes on padding? ;)

Otherwise, nothing stands out to my eye, so

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

Cheers,
Robin.

>   	u64 counter_mask;
>   	bool global_filter;
>   	u32 global_filter_span;
> @@ -222,15 +226,27 @@ static void smmu_pmu_set_period(struct smmu_pmu *smmu_pmu,
>   	u32 idx = hwc->idx;
>   	u64 new;
>   
> -	/*
> -	 * We limit the max period to half the max counter value of the counter
> -	 * size, so that even in the case of extreme interrupt latency the
> -	 * counter will (hopefully) not wrap past its initial value.
> -	 */
> -	new = smmu_pmu->counter_mask >> 1;
> +	if (smmu_pmu->options & SMMU_PMCG_EVCNTR_RDONLY) {
> +		/*
> +		 * On platforms that require this quirk, if the counter starts
> +		 * at < half_counter value and wraps, the current logic of
> +		 * handling the overflow may not work. It is expected that,
> +		 * those platforms will have full 64 counter bits implemented
> +		 * so that such a possibility is remote(eg: HiSilicon HIP08).
> +		 */
> +		new = smmu_pmu_counter_get_value(smmu_pmu, idx);
> +	} else {
> +		/*
> +		 * We limit the max period to half the max counter value
> +		 * of the counter size, so that even in the case of extreme
> +		 * interrupt latency the counter will (hopefully) not wrap
> +		 * past its initial value.
> +		 */
> +		new = smmu_pmu->counter_mask >> 1;
> +		smmu_pmu_counter_set_value(smmu_pmu, idx, new);
> +	}
>   
>   	local64_set(&hwc->prev_count, new);
> -	smmu_pmu_counter_set_value(smmu_pmu, idx, new);
>   }
>   
>   static void smmu_pmu_set_event_filter(struct perf_event *event,
> @@ -674,6 +690,22 @@ static void smmu_pmu_reset(struct smmu_pmu *smmu_pmu)
>   		       smmu_pmu->reloc_base + SMMU_PMCG_OVSCLR0);
>   }
>   
> +static void smmu_pmu_get_acpi_options(struct smmu_pmu *smmu_pmu)
> +{
> +	u32 model;
> +
> +	model = *(u32 *)dev_get_platdata(smmu_pmu->dev);
> +
> +	switch (model) {
> +	case IORT_SMMU_V3_PMCG_HISI_HIP08:
> +		/* HiSilicon Erratum 162001800 */
> +		smmu_pmu->options |= SMMU_PMCG_EVCNTR_RDONLY;
> +		break;
> +	}
> +
> +	dev_notice(smmu_pmu->dev, "option mask 0x%x\n", smmu_pmu->options);
> +}
> +
>   static int smmu_pmu_probe(struct platform_device *pdev)
>   {
>   	struct smmu_pmu *smmu_pmu;
> @@ -752,6 +784,8 @@ static int smmu_pmu_probe(struct platform_device *pdev)
>   		return -EINVAL;
>   	}
>   
> +	smmu_pmu_get_acpi_options(smmu_pmu);
> +
>   	/* Pick one CPU to be the preferred one to use */
>   	smmu_pmu->on_cpu = get_cpu();
>   	WARN_ON(irq_set_affinity(smmu_pmu->irq, cpumask_of(smmu_pmu->on_cpu)));
> diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
> index 832bd6a..bdb6912 100644
> --- a/include/linux/acpi_iort.h
> +++ b/include/linux/acpi_iort.h
> @@ -31,6 +31,7 @@
>    * that, this is not part of the IORT specification.
>    */
>   #define IORT_SMMU_V3_PMCG_GENERIC        0x00000000 /* Generic SMMUv3 PMCG */
> +#define IORT_SMMU_V3_PMCG_HISI_HIP08     0x00000001 /* HiSilicon HIP08 PMCG */
>   
>   int iort_register_domain_token(int trans_id, phys_addr_t base,
>   			       struct fwnode_handle *fw_node);
> 
