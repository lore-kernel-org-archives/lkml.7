Return-Path: <SRS0=c662=XX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C55C388F3
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Sep 2019 03:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AF182146E
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Sep 2019 03:14:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728513AbfI1DNW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 23:13:22 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3167 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725990AbfI1DNV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 23:13:21 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 55649E13E901CAD785BF;
        Sat, 28 Sep 2019 11:13:19 +0800 (CST)
Received: from [127.0.0.1] (10.184.12.158) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Sat, 28 Sep 2019
 11:13:10 +0800
Subject: Re: [PATCH 31/35] irqchip/gic-v4.1: Eagerly vmap vPEs
To:     Marc Zyngier <maz@kernel.org>, <kvmarm@lists.cs.columbia.edu>,
        <linux-kernel@vger.kernel.org>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20190923182606.32100-1-maz@kernel.org>
 <20190923182606.32100-32-maz@kernel.org>
From:   Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <82576f6e-3736-8069-bbf2-7744fbea9ed2@huawei.com>
Date:   Sat, 28 Sep 2019 11:11:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <20190923182606.32100-32-maz@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.184.12.158]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/9/24 2:26, Marc Zyngier wrote:
> Now that we have HW-accelerated SGIs being delivered to VPEs, it
> becomes required to map the VPEs on all ITSs instead of relying
> on the lazy approach that we would use when using the ITS-list
> mechanism.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>   drivers/irqchip/irq-gic-v3-its.c | 39 +++++++++++++++++++++++++-------
>   1 file changed, 31 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index 4aae9582182b..a1e8c4c2598a 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -1417,12 +1417,31 @@ static int its_irq_set_irqchip_state(struct irq_data *d,
>   	return 0;
>   }
>   
> +/*
> + * Two favourable cases:
> + *
> + * (a) Either we have a GICv4.1, and all vPEs have to be mapped at all times
> + *     for vSGI delivery
> + *
> + * (b) Or the ITSs do not use a list map, meaning that VMOVP is cheap enough
> + *     and we're better off mapping all VPEs always
> + *
> + * If neither (a) nor (b) is true, then we map VLPIs on demand.
                                                  ^^^^^
vPEs

> + *
> + */
> +static bool gic_requires_eager_mapping(void)
> +{
> +	if (!its_list_map || gic_rdists->has_rvpeid)
> +		return true;
> +
> +	return false;
> +}
> +
>   static void its_map_vm(struct its_node *its, struct its_vm *vm)
>   {
>   	unsigned long flags;
>   
> -	/* Not using the ITS list? Everything is always mapped. */
> -	if (!its_list_map)
> +	if (gic_requires_eager_mapping())
>   		return;
>   
>   	raw_spin_lock_irqsave(&vmovp_lock, flags);
> @@ -1456,7 +1475,7 @@ static void its_unmap_vm(struct its_node *its, struct its_vm *vm)
>   	unsigned long flags;
>   
>   	/* Not using the ITS list? Everything is always mapped. */
> -	if (!its_list_map)
> +	if (gic_requires_eager_mapping())
>   		return;
>   
>   	raw_spin_lock_irqsave(&vmovp_lock, flags);
> @@ -3957,8 +3976,12 @@ static int its_vpe_irq_domain_activate(struct irq_domain *domain,
>   	struct its_vpe *vpe = irq_data_get_irq_chip_data(d);
>   	struct its_node *its;
>   
> -	/* If we use the list map, we issue VMAPP on demand... */
> -	if (its_list_map)
> +	/*
> +	 * If we use the list map, we issue VMAPP on demand... Unless
> +	 * we're on a GICv4.1 and we eagerly map the VPE on all ITSs
> +	 * so that VSGIs can work.
> +	 */
> +	if (!gic_requires_eager_mapping())
>   		return 0;
>   
>   	/* Map the VPE to the first possible CPU */
> @@ -3984,10 +4007,10 @@ static void its_vpe_irq_domain_deactivate(struct irq_domain *domain,
>   	struct its_node *its;
>   
>   	/*
> -	 * If we use the list map, we unmap the VPE once no VLPIs are
> -	 * associated with the VM.
> +	 * If we use the list map on GICv4.0, we unmap the VPE once no
> +	 * VLPIs are associated with the VM.
>   	 */
> -	if (its_list_map)
> +	if (!gic_requires_eager_mapping())
>   		return;
>   
>   	list_for_each_entry(its, &its_nodes, entry) {
> 


Thanks,
zenghui

