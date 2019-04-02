Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC974C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 19:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF2DE2082C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 19:14:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730453AbfDBTOc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 15:14:32 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55830 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729966AbfDBTOc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 15:14:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9CA7680D;
        Tue,  2 Apr 2019 12:14:31 -0700 (PDT)
Received: from [192.168.100.242] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B1A773F68F;
        Tue,  2 Apr 2019 12:14:30 -0700 (PDT)
Subject: Re: [PATCH 3/4] arm_pmu: acpi: spe: Add initial MADT/SPE probing
To:     John Garry <john.garry@huawei.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, will.deacon@arm.com, rjw@rjwysocki.net,
        lenb@kernel.org, mark.rutland@arm.com, sudeep.holla@arm.com,
        james.morse@arm.com, lorenzo.pieralisi@arm.com, linuxarm@huawei.com
References: <20190326223938.5365-1-jeremy.linton@arm.com>
 <20190326223938.5365-4-jeremy.linton@arm.com>
 <2b53e957-6d36-fdfe-20e4-1664108c07ef@huawei.com>
From:   Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <b9081589-9c18-d298-e109-ca1d98627456@arm.com>
Date:   Tue, 2 Apr 2019 14:14:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <2b53e957-6d36-fdfe-20e4-1664108c07ef@huawei.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

First thanks for taking a look at this, second sorry about the delay...

On 3/28/19 7:40 AM, John Garry wrote:
> On 26/03/2019 22:39, Jeremy Linton wrote:
>> ACPI 6.3 adds additional fields to the MADT GICC
>> structure to describe SPE PPI's. We pick these out
>> of the cached reference to the madt_gicc structure
>> similarly to the core PMU code. We then create a platform
>> device referring to the IRQ and let the user/module loader
>> decide whether to load the SPE driver.
>>
>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>> ---
>>  arch/arm64/include/asm/acpi.h |  3 ++
>>  drivers/perf/arm_pmu_acpi.c   | 69 +++++++++++++++++++++++++++++++++++
>>  2 files changed, 72 insertions(+)
>>
>> diff --git a/arch/arm64/include/asm/acpi.h 
>> b/arch/arm64/include/asm/acpi.h
>> index 7628efbe6c12..d10399b9f998 100644
>> --- a/arch/arm64/include/asm/acpi.h
>> +++ b/arch/arm64/include/asm/acpi.h
>> @@ -41,6 +41,9 @@
>>      (!(entry) || (entry)->header.length < ACPI_MADT_GICC_MIN_LENGTH || \
>>      (unsigned long)(entry) + (entry)->header.length > (end))
>>
>> +#define ACPI_MADT_GICC_SPE  (ACPI_OFFSET(struct 
>> acpi_madt_generic_interrupt, \
>> +    spe_interrupt) + sizeof(u16))
>> +
>>  /* Basic configuration for ACPI */
>>  #ifdef    CONFIG_ACPI
>>  pgprot_t __acpi_get_mem_attribute(phys_addr_t addr);
>> diff --git a/drivers/perf/arm_pmu_acpi.c b/drivers/perf/arm_pmu_acpi.c
>> index 0f197516d708..a2418108eab2 100644
>> --- a/drivers/perf/arm_pmu_acpi.c
>> +++ b/drivers/perf/arm_pmu_acpi.c
>> @@ -74,6 +74,73 @@ static void arm_pmu_acpi_unregister_irq(int cpu)
>>      acpi_unregister_gsi(gsi);
>>  }
>>
>> +static struct resource spe_resources[] = {
>> +    {
>> +        /* irq */
>> +        .flags          = IORESOURCE_IRQ,
>> +    }
>> +};
>> +
>> +static struct platform_device spe_dev = {
>> +    .name = "arm,spe-v1",
>> +    .id = -1,
>> +    .resource = spe_resources,
>> +    .num_resources = ARRAY_SIZE(spe_resources)
>> +};
>> +
>> +/*
>> + * For lack of a better place,
> 
> It seems that the kernel Image size can now increase due to this part of 
> SPE support even if ARM_SPE_PMU config is disabled.

That is true, but it should be fairly small.

> 
> And I don't even think that ARM_SPE_PMU depends on ARM_PMU (which 
> ARM_PMU_ACPI depends on).

Well I don't think we want the generic SPE_PMU dependent on ACPI. So 
this chunk of code could be wrapped in a SPE_PMU_ACPI block, and made 
dependent on PMU_ACPI. OTOH, It seems a little trivial for that, and 
maybe just tweaking the PMU_ACPI documentation to mention that it also 
enables ACPI/SPE is a better plan.

Opinions?


> 
> Thanks,
> John
> 
> hook the normal PMU MADT walk
>> + * and create a SPE device if we detect a recent MADT with
>> + * a homogeneous PPI mapping.
>> + */
>> +static int arm_spe_acpi_parse_irqs(void)
>> +{
>> +    int cpu, ret, irq;
>> +    int hetid;
>> +    u16 gsi = 0;
>> +    bool first = true;
>> +
>> +    struct acpi_madt_generic_interrupt *gicc;
>> +
>> +    /*
>> +     * sanity check all the GICC tables for the same interrupt number
>> +     * for now we only support homogeneous ACPI/SPE machines.
>> +     */
>> +    for_each_possible_cpu(cpu) {
>> +        gicc = acpi_cpu_get_madt_gicc(cpu);
>> +
>> +        if (gicc->header.length < ACPI_MADT_GICC_SPE)
>> +            return -ENODEV;
>> +        if (first) {
>> +            gsi = gicc->spe_interrupt;
>> +            if (!gsi)
>> +                return -ENODEV;
>> +            hetid = find_acpi_cpu_topology_hetero_id(cpu);
>> +            first = false;
>> +        } else if ((gsi != gicc->spe_interrupt) ||
>> +               (hetid != find_acpi_cpu_topology_hetero_id(cpu))) {
>> +            pr_warn("ACPI: SPE must be homogeneous\n");
>> +            return -EINVAL;
>> +        }
>> +    }
>> +
>> +    irq = acpi_register_gsi(NULL, gsi, ACPI_LEVEL_SENSITIVE,
>> +                ACPI_ACTIVE_HIGH);
>> +    if (irq < 0) {
>> +        pr_warn("ACPI: SPE Unable to register interrupt: %d\n", gsi);
>> +        return irq;
>> +    }
>> +
>> +    spe_resources[0].start = irq;
>> +    ret = platform_device_register(&spe_dev);
>> +    if (ret < 0) {
>> +        pr_warn("ACPI: SPE: Unable to register device\n");
>> +        acpi_unregister_gsi(gsi);
>> +    }
>> +
>> +    return ret;
>> +}
>> +
>>  static int arm_pmu_acpi_parse_irqs(void)
>>  {
>>      int irq, cpu, irq_cpu, err;
>> @@ -279,6 +346,8 @@ static int arm_pmu_acpi_init(void)
>>      if (acpi_disabled)
>>          return 0;
>>
>> +    arm_spe_acpi_parse_irqs(); /* failures are expected */
>> +
>>      ret = arm_pmu_acpi_parse_irqs();
>>      if (ret)
>>          return ret;
>>
> 
> 

