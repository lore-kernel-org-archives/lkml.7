Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D60C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 13:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FA37206A5
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 13:50:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbfLPNu3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 08:50:29 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7253 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727579AbfLPNu3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 08:50:29 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 33520A48BA882C891ECE;
        Mon, 16 Dec 2019 21:50:27 +0800 (CST)
Received: from [127.0.0.1] (10.133.216.73) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Mon, 16 Dec 2019
 21:50:21 +0800
Subject: Re: [PATCH] irq-gic-v3: fix NULL dereference of disabled redist_base
To:     Marc Zyngier <maz@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <wanghaibin.wang@huawei.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
References: <20191216062745.63397-1-guoheyi@huawei.com>
 <36a042f6bcea5b5d5bfd9f6e6f01d6f5@www.loen.fr>
From:   Guoheyi <guoheyi@huawei.com>
Message-ID: <c1447d9f-df4a-db07-adae-7e7e6c0f6455@huawei.com>
Date:   Mon, 16 Dec 2019 21:50:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <36a042f6bcea5b5d5bfd9f6e6f01d6f5@www.loen.fr>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.133.216.73]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2019/12/16 19:14, Marc Zyngier 写道:
> Hi Heyi,
>
> On 2019-12-16 06:27, Heyi Guo wrote:
>> If we use ACPI MADT GICC structure to pass single redistributor base,
>> and mark some GICC as disabled, we'll get below call trace during
>> boot:
>>
>> [    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
>> [    0.000000] GICv3: 256 SPIs implemented
>> [    0.000000] GICv3: 0 Extended SPIs implemented
>> [    0.000000] GICv3: Distributor has no Range Selector support
>> [    0.000000] Unable to handle kernel paging request at virtual
>> address 000000000000ffe8
>> [    0.000000] Mem abort info:
>> [    0.000000]   ESR = 0x96000004
>> [    0.000000]   EC = 0x25: DABT (current EL), IL = 32 bits
>> [    0.000000]   SET = 0, FnV = 0
>> [    0.000000]   EA = 0, S1PTW = 0
>> [    0.000000] Data abort info:
>> [    0.000000]   ISV = 0, ISS = 0x00000004
>> [    0.000000]   CM = 0, WnR = 0
>> [    0.000000] [000000000000ffe8] user address but active_mm is swapper
>> [    0.000000] Internal error: Oops: 96000004 [#1] SMP
>> [    0.000000] Modules linked in:
>> [    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.5.0-rc1 #5
>> [    0.000000] pstate: 20000085 (nzCv daIf -PAN -UAO)
>> [    0.000000] pc : gic_iterate_rdists+0x58/0x130
>> [    0.000000] lr : gic_iterate_rdists+0x80/0x130
>> [    0.000000] sp : ffff8000113d3cb0
>> [    0.000000] x29: ffff8000113d3cb0 x28: 0000000000000000
>> [    0.000000] x27: 0000000000000000 x26: 0000000000000018
>> [    0.000000] x25: 000000000000ffe8 x24: 000000000000003f
>> [    0.000000] x23: ffff800010588040 x22: 00000000000005e8
>> [    0.000000] x21: ffff8000113df7d0 x20: 0000030f00003f11
>> [    0.000000] x19: 0000000000000000 x18: ffffffffffffffff
>> [    0.000000] x17: 0000000014aeb8dc x16: 00000000c3ba0ccf
>> [    0.000000] x15: ffff8000113d9908 x14: ffff8000913d3a37
>> [    0.000000] x13: ffff8000113d3a45 x12: ffff800011402000
>> [    0.000000] x11: ffff8000113d39d0 x10: ffff8000113db980
>> [    0.000000] x9 : 00000000ffffffd0 x8 : ffff8000106dca98
>> [    0.000000] x7 : 000000000000005b x6 : 0000000000000000
>> [    0.000000] x5 : 0000000000000000 x4 : ffff8000128c0000
>> [    0.000000] x3 : ffff8000128a0000 x2 : ffff0003fc3c7000
>> [    0.000000] x1 : 0000000000000001 x0 : 000000000000ffe8
>> [    0.000000] Call trace:
>> [    0.000000]  gic_iterate_rdists+0x58/0x130
>> [    0.000000]  gic_init_bases+0x200/0x4b4
>> [    0.000000]  gic_acpi_init+0x148/0x284
>> [    0.000000]  acpi_match_madt+0x4c/0x84
>> [    0.000000]  acpi_table_parse_entries_array+0x188/0x278
>> [    0.000000]  acpi_table_parse_entries+0x70/0x98
>> [    0.000000]  acpi_table_parse_madt+0x40/0x50
>> [    0.000000]  __acpi_probe_device_table+0x88/0xe4
>> [    0.000000]  irqchip_init+0x38/0x40
>> [    0.000000]  init_IRQ+0x168/0x19c
>> [    0.000000]  start_kernel+0x328/0x508
>> [    0.000000] Code: f90017b6 9b3a7f16 f8766853 8b190260 (b9400000)
>> [    0.000000] ---[ end trace ae5cf232d924bfc1 ]---
>> [    0.000000] Kernel panic - not syncing: Fatal exception
>> [    0.000000] Rebooting in 3 seconds..
>>
>> In this case, nr_redist_regions counts all GICC structures but only
>> enabled ones have redistributor mapped. So add check to avoid NULL
>> deference of redist_base.
>>
>> Signed-off-by: Heyi Guo <guoheyi@huawei.com>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Jason Cooper <jason@lakedaemon.net>
>> Cc: Marc Zyngier <maz@kernel.org>
>> ---
>>  drivers/irqchip/irq-gic-v3.c | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
>> index d6218012097b..bd9d55cadef9 100644
>> --- a/drivers/irqchip/irq-gic-v3.c
>> +++ b/drivers/irqchip/irq-gic-v3.c
>> @@ -781,6 +781,13 @@ static int gic_iterate_rdists(int (*fn)(struct
>> redist_region *, void __iomem *))
>>          u64 typer;
>>          u32 reg;
>>
>> +        /*
>> +         * redist_base may be NULL if we use single_redist and some 
>> GICC
>> +         * structure is disabled.
>> +         */
>> +        if (!ptr)
>> +            continue;
>> +
>>          reg = readl_relaxed(ptr + GICR_PIDR2) & GIC_PIDR2_ARCH_MASK;
>>          if (reg != GIC_PIDR2_ARCH_GICv3 &&
>>              reg != GIC_PIDR2_ARCH_GICv4) { /* We're in trouble... */
>
> This feels like the wrong fix. The redistributor region array should
> be completely populated, and there is an assumption all over this driver
> that there is no junk in these structures.


Oh, I thought the place holder for disabled GICR in nr_redist_regions 
were for some special reason, like CPU hotplug. Now I know I was wrong :)


>
> You're seeing this because we don't track the number of *enabled* rdists,
> and allocate the number of regions based on the number of overall GICC
> entries instead of the number of enabled redistributors.
>
> How about this instead?

It looks good to me, and works fine in my case.

Thanks,

Heyi


>
>         M.
>
> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> index 3a1866682dd0..9b26a860340b 100644
> --- a/drivers/irqchip/irq-gic-v3.c
> +++ b/drivers/irqchip/irq-gic-v3.c
> @@ -1861,6 +1861,7 @@ static struct
>      struct redist_region *redist_regs;
>      u32 nr_redist_regions;
>      bool single_redist;
> +    int enabled_rdists;
>      u32 maint_irq;
>      int maint_irq_mode;
>      phys_addr_t vcpu_base;
> @@ -1955,8 +1956,10 @@ static int __init gic_acpi_match_gicc(union 
> acpi_subtable_headers *header,
>       * If GICC is enabled and has valid gicr base address, then it means
>       * GICR base is presented via GICC
>       */
> -    if ((gicc->flags & ACPI_MADT_ENABLED) && gicc->gicr_base_address)
> +    if ((gicc->flags & ACPI_MADT_ENABLED) && gicc->gicr_base_address) {
> +        acpi_data.enabled_rdists++;
>          return 0;
> +    }
>
>      /*
>       * It's perfectly valid firmware can pass disabled GICC entry, 
> driver
> @@ -1986,8 +1989,10 @@ static int __init 
> gic_acpi_count_gicr_regions(void)
>
>      count = acpi_table_parse_madt(ACPI_MADT_TYPE_GENERIC_INTERRUPT,
>                        gic_acpi_match_gicc, 0);
> -    if (count > 0)
> +    if (count > 0) {
>          acpi_data.single_redist = true;
> +        count = acpi_data.enabled_rdists;
> +    }
>
>      return count;
>  }
>

