Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD5ACA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 11:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 471C020656
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 11:52:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730456AbfKALwI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 07:52:08 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5249 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726957AbfKALwI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 07:52:08 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E978E5D73C6E77742B42;
        Fri,  1 Nov 2019 19:52:05 +0800 (CST)
Received: from [127.0.0.1] (10.173.222.27) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Fri, 1 Nov 2019
 19:51:56 +0800
Subject: Re: [PATCH v2 19/36] irqchip/gic-v4.1: Add VPE INVALL callback
To:     Marc Zyngier <maz@kernel.org>, <kvmarm@lists.cs.columbia.edu>,
        <linux-kernel@vger.kernel.org>
CC:     Eric Auger <eric.auger@redhat.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Andrew Murray" <Andrew.Murray@arm.com>,
        Jayachandran C <jnair@marvell.com>,
        "Robert Richter" <rrichter@marvell.com>
References: <20191027144234.8395-1-maz@kernel.org>
 <20191027144234.8395-20-maz@kernel.org>
From:   Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <28e29c2d-a35a-6a67-c65d-7ab61d33b21b@huawei.com>
Date:   Fri, 1 Nov 2019 19:51:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191027144234.8395-20-maz@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.222.27]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 2019/10/27 22:42, Marc Zyngier wrote:
> GICv4.1 redistributors have a VPE-aware INVALL register. Progress!
> We can now emulate a guest-requested INVALL without emiting a
> VINVALL command.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>

Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>

> ---
>   drivers/irqchip/irq-gic-v3-its.c   | 14 ++++++++++++++
>   include/linux/irqchip/arm-gic-v3.h |  3 +++
>   2 files changed, 17 insertions(+)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index f7effd453729..10bd156aa042 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -3511,6 +3511,19 @@ static void its_vpe_4_1_deschedule(struct its_vpe *vpe,
>   	}
>   }
>   
> +static void its_vpe_4_1_invall(struct its_vpe *vpe)
> +{
> +	void __iomem *rdbase;
> +	u64 val;
> +
> +	val  = GICR_INVLPIR_V;
> +	val |= FIELD_PREP(GICR_INVLPIR_VPEID, vpe->vpe_id);

Can we use GICR_INVALL_V/VPEID instead, and ...

> +
> +	/* Target the redistributor this vPE is currently known on */
> +	rdbase = per_cpu_ptr(gic_rdists->rdist, vpe->col_idx)->rd_base;
> +	gic_write_lpir(val, rdbase + GICR_INVALLR);
> +}
> +
>   static int its_vpe_4_1_set_vcpu_affinity(struct irq_data *d, void *vcpu_info)
>   {
>   	struct its_vpe *vpe = irq_data_get_irq_chip_data(d);
> @@ -3526,6 +3539,7 @@ static int its_vpe_4_1_set_vcpu_affinity(struct irq_data *d, void *vcpu_info)
>   		return 0;
>   
>   	case INVALL_VPE:
> +		its_vpe_4_1_invall(vpe);
>   		return 0;
>   
>   	default:
> diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
> index 6fd89d77b2b2..b69f60792554 100644
> --- a/include/linux/irqchip/arm-gic-v3.h
> +++ b/include/linux/irqchip/arm-gic-v3.h
> @@ -247,6 +247,9 @@
>   #define GICR_TYPER_COMMON_LPI_AFF	GENMASK_ULL(25, 24)
>   #define GICR_TYPER_AFFINITY		GENMASK_ULL(63, 32)
>   
> +#define GICR_INVLPIR_VPEID		GENMASK_ULL(47, 32)
> +#define GICR_INVLPIR_V			GENMASK_ULL(63, 63)
> +

... define them here:

#define GICR_INVALL_VPEID		GICR_INVLPIR_VPEID
#define GICR_INVALL_V			GICR_INVLPIR_V


Thanks,
Zenghui

>   #define GIC_V3_REDIST_SIZE		0x20000
>   
>   #define LPI_PROP_GROUP1			(1 << 1)
> 

