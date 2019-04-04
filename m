Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEBD0C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 15:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8801E20882
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 15:30:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728682AbfDDPa1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 11:30:27 -0400
Received: from foss.arm.com ([217.140.101.70]:34246 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725904AbfDDPa0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 11:30:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 05BCD169E;
        Thu,  4 Apr 2019 08:30:26 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 584253F59C;
        Thu,  4 Apr 2019 08:30:23 -0700 (PDT)
Date:   Thu, 4 Apr 2019 16:30:20 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc:     lorenzo.pieralisi@arm.com, robin.murphy@arm.com,
        andrew.murray@arm.com, jean-philippe.brucker@arm.com,
        mark.rutland@arm.com, guohanjun@huawei.com, john.garry@huawei.com,
        pabba@codeaurora.org, vkilari@codeaurora.org,
        rruigrok@codeaurora.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxarm@huawei.com, neil.m.leeder@gmail.com
Subject: Re: [PATCH v7 2/4] perf/smmuv3: Add arm64 smmuv3 pmu driver
Message-ID: <20190404153020.GD27558@fuggles.cambridge.arm.com>
References: <20190326151753.19384-1-shameerali.kolothum.thodi@huawei.com>
 <20190326151753.19384-3-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190326151753.19384-3-shameerali.kolothum.thodi@huawei.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 03:17:51PM +0000, Shameer Kolothum wrote:
> From: Neil Leeder <nleeder@codeaurora.org>
> 
> Adds a new driver to support the SMMUv3 PMU and add it into the
> perf events framework.
> 
> Each SMMU node may have multiple PMUs associated with it, each of
> which may support different events.
> 
> SMMUv3 PMCG devices are named as smmuv3_pmcg_<phys_addr_page> where
> <phys_addr_page> is the physical page address of the SMMU PMCG
> wrapped to 4K boundary. For example, the PMCG at 0xff88840000 is
> named smmuv3_pmcg_ff88840
> 
> Filtering by stream id is done by specifying filtering parameters
> with the event. options are:
>    filter_enable    - 0 = no filtering, 1 = filtering enabled
>    filter_span      - 0 = exact match, 1 = pattern match
>    filter_stream_id - pattern to filter against
> 
> Example: perf stat -e smmuv3_pmcg_ff88840/transaction,filter_enable=1,
>                        filter_span=1,filter_stream_id=0x42/ -a netperf
> 
> Applies filter pattern 0x42 to transaction events, which means events
> matching stream ids 0x42 & 0x43 are counted as only upper StreamID
> bits are required to match the given filter. Further filtering
> information is available in the SMMU documentation.
> 
> SMMU events are not attributable to a CPU, so task mode and sampling
> are not supported.
> 
> Signed-off-by: Neil Leeder <nleeder@codeaurora.org>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/perf/Kconfig          |   9 +
>  drivers/perf/Makefile         |   1 +
>  drivers/perf/arm_smmuv3_pmu.c | 776 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 786 insertions(+)
>  create mode 100644 drivers/perf/arm_smmuv3_pmu.c

[...]

> +static int smmu_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
> +{
> +	struct smmu_pmu *smmu_pmu;
> +	unsigned int target;
> +
> +	smmu_pmu = hlist_entry_safe(node, struct smmu_pmu, node);
> +	if (cpu != smmu_pmu->on_cpu)
> +		return 0;
> +
> +	target = cpumask_any_but(cpu_online_mask, cpu);
> +	if (target >= nr_cpu_ids)
> +		return 0;
> +
> +	perf_pmu_migrate_context(&smmu_pmu->pmu, cpu, target);
> +	smmu_pmu->on_cpu = target;
> +	WARN_ON(irq_set_affinity(smmu_pmu->irq, cpumask_of(target)));

I'm going to make this (and the other invocation) use
irq_set_affinity_hint() instead, so that we can build this driver as a
module with the appropriate Kconfig tweak.

Will
