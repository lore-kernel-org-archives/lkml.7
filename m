Return-Path: <SRS0=c662=XX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8719C4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Sep 2019 02:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88E9C21655
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Sep 2019 02:29:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbfI1CYY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 22:24:24 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:58164 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725990AbfI1CYX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 22:24:23 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6D27871ACCD5290A275B;
        Sat, 28 Sep 2019 10:24:21 +0800 (CST)
Received: from [127.0.0.1] (10.184.12.158) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Sat, 28 Sep 2019
 10:24:11 +0800
Subject: Re: [PATCH 24/35] irqchip/gic-v4.1: Add initial SGI configuration
To:     Marc Zyngier <maz@kernel.org>, <kvmarm@lists.cs.columbia.edu>,
        <linux-kernel@vger.kernel.org>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20190923182606.32100-1-maz@kernel.org>
 <20190923182606.32100-25-maz@kernel.org>
From:   Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <4ad002e2-1b3c-3420-98a5-0bedf067cfd9@huawei.com>
Date:   Sat, 28 Sep 2019 10:20:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <20190923182606.32100-25-maz@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.184.12.158]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 2019/9/24 2:25, Marc Zyngier wrote:
> The GICv4.1 ITS has yet another new command (VSGI) which allows
> a VPE-targeted SGI to be configured (or have its pending state
> cleared). Add support for this command and plumb it into the
> activate irqdomain callback so that it is ready to be used.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>   drivers/irqchip/irq-gic-v3-its.c   | 88 ++++++++++++++++++++++++++++++
>   include/linux/irqchip/arm-gic-v3.h |  3 +-
>   2 files changed, 90 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index 69c26be709be..5234b9eef8ad 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c

[...]

> @@ -3574,6 +3628,38 @@ static struct irq_chip its_vpe_4_1_irq_chip = {
>   	.irq_set_vcpu_affinity	= its_vpe_4_1_set_vcpu_affinity,
>   };
>   
> +static struct its_node *find_4_1_its(void)
> +{
> +	static struct its_node *its = NULL;
> +
> +	if (!its) {
> +		list_for_each_entry(its, &its_nodes, entry) {
> +			if (is_v4_1(its))
> +				return its;
> +		}
> +
> +		/* Oops? */
> +		its = NULL;
> +	}
> +
> +	return its;
> +}
> +
> +static void its_configure_sgi(struct irq_data *d, bool clear)
> +{
> +	struct its_vpe *vpe = irq_data_get_irq_chip_data(d);
> +	struct its_cmd_desc desc;
> +
> +	desc.its_vsgi_cmd.vpe = vpe;
> +	desc.its_vsgi_cmd.sgi = d->hwirq;
> +	desc.its_vsgi_cmd.priority = vpe->sgi_config[d->hwirq].priority;
> +	desc.its_vsgi_cmd.enable = vpe->sgi_config[d->hwirq].enabled;
> +	desc.its_vsgi_cmd.group = vpe->sgi_config[d->hwirq].group;
> +	desc.its_vsgi_cmd.clear = clear;
> +
> +	its_send_single_vcommand(find_4_1_its(), its_build_vsgi_cmd, &desc);

I can't follow the logic in find_4_1_its().  We simply use the first ITS
with GICv4.1 support, but what if the vPE is not mapped on this ITS?
We will fail the valid_vpe() check when building this command and will
have no effect on HW in the end?


Thanks,
zenghui

> +}
> +
>   static int its_sgi_set_affinity(struct irq_data *d,
>   				const struct cpumask *mask_val,
>   				bool force)
> @@ -3619,6 +3705,8 @@ static void its_sgi_irq_domain_free(struct irq_domain *domain,
>   static int its_sgi_irq_domain_activate(struct irq_domain *domain,
>   				       struct irq_data *d, bool reserve)
>   {
> +	/* Write out the initial SGI configuration */
> +	its_configure_sgi(d, false);
>   	return 0;
>   }
>   
> diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
> index 5f3278cbf247..c73176d3ab2b 100644
> --- a/include/linux/irqchip/arm-gic-v3.h
> +++ b/include/linux/irqchip/arm-gic-v3.h
> @@ -497,8 +497,9 @@
>   #define GITS_CMD_VMAPTI			GITS_CMD_GICv4(GITS_CMD_MAPTI)
>   #define GITS_CMD_VMOVI			GITS_CMD_GICv4(GITS_CMD_MOVI)
>   #define GITS_CMD_VSYNC			GITS_CMD_GICv4(GITS_CMD_SYNC)
> -/* VMOVP and INVDB are the odd ones, as they dont have a physical counterpart */
> +/* VMOVP, VSGI and INVDB are the odd ones, as they dont have a physical counterpart */
>   #define GITS_CMD_VMOVP			GITS_CMD_GICv4(2)
> +#define GITS_CMD_VSGI			GITS_CMD_GICv4(3)
>   #define GITS_CMD_INVDB			GITS_CMD_GICv4(0xe)
>   
>   /*
> 

