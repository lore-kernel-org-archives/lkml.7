Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D93AC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 14:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1003420651
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 14:29:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbfHSO3R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 10:29:17 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5158 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726314AbfHSO3R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 10:29:17 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 90E4EABBEAC6BB8EC53D;
        Mon, 19 Aug 2019 22:29:13 +0800 (CST)
Received: from [127.0.0.1] (10.184.12.158) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Mon, 19 Aug 2019
 22:29:07 +0800
Subject: Re: [PATCH v2 01/12] irqchip/gic: Rework gic_configure_irq to take
 the full ICFGR base
To:     Marc Zyngier <maz@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        John Garry <john.garry@huawei.com>,
        <linux-kernel@vger.kernel.org>,
        "Shameerali Kolothum Thodi" <shameerali.kolothum.thodi@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <20190806100121.240767-1-maz@kernel.org>
 <20190806100121.240767-2-maz@kernel.org>
From:   Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <a601236c-8128-ca7a-667f-12a4b7cefb89@huawei.com>
Date:   Mon, 19 Aug 2019 22:26:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <20190806100121.240767-2-maz@kernel.org>
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

On 2019/8/6 18:01, Marc Zyngier wrote:
> gic_configure_irq is currently passed the (re)distributor address,
> to which it applies an a fixed offset to get to the configuration
> registers. This offset is constant across all GICs, or rather it was
> until to v3.1...
> 
> An easy way out is for the individual drivers to pass the base
> address of the configuration register for the considered interrupt.
> At the same time, move part of the error handling back to the
> individual drivers, as things are about to change on that front.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>   drivers/irqchip/irq-gic-common.c | 14 +++++---------
>   drivers/irqchip/irq-gic-v3.c     | 11 ++++++++++-
>   drivers/irqchip/irq-gic.c        | 10 +++++++++-
>   drivers/irqchip/irq-hip04.c      |  7 ++++++-
>   4 files changed, 30 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-gic-common.c b/drivers/irqchip/irq-gic-common.c
> index b0a8215a13fc..6900b6f0921c 100644
> --- a/drivers/irqchip/irq-gic-common.c
> +++ b/drivers/irqchip/irq-gic-common.c
> @@ -63,7 +63,7 @@ int gic_configure_irq(unsigned int irq, unsigned int type,
>   	 * for "irq", depending on "type".
>   	 */
>   	raw_spin_lock_irqsave(&irq_controller_lock, flags);
> -	val = oldval = readl_relaxed(base + GIC_DIST_CONFIG + confoff);
> +	val = oldval = readl_relaxed(base + confoff);
>   	if (type & IRQ_TYPE_LEVEL_MASK)
>   		val &= ~confmask;
>   	else if (type & IRQ_TYPE_EDGE_BOTH)
> @@ -83,14 +83,10 @@ int gic_configure_irq(unsigned int irq, unsigned int type,
>   	 * does not allow us to set the configuration or we are in a
>   	 * non-secure mode, and hence it may not be catastrophic.
>   	 */
> -	writel_relaxed(val, base + GIC_DIST_CONFIG + confoff);
> -	if (readl_relaxed(base + GIC_DIST_CONFIG + confoff) != val) {
> -		if (WARN_ON(irq >= 32))
> -			ret = -EINVAL;

Since this WARN_ON is dropped, the comment above should also be updated.
But what is the reason for deleting it?  (It may give us some points
when we fail to set type for SPIs.)


Thanks,
zenghui

> -		else
> -			pr_warn("GIC: PPI%d is secure or misconfigured\n",
> -				irq - 16);
> -	}
> +	writel_relaxed(val, base + confoff);
> +	if (readl_relaxed(base + confoff) != val)
> +		ret = -EINVAL;
> +
>   	raw_spin_unlock_irqrestore(&irq_controller_lock, flags);
>   
>   	if (sync_access)
> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> index 96d927f0f91a..b250e69908f8 100644
> --- a/drivers/irqchip/irq-gic-v3.c
> +++ b/drivers/irqchip/irq-gic-v3.c
> @@ -407,6 +407,7 @@ static int gic_set_type(struct irq_data *d, unsigned int type)
>   	unsigned int irq = gic_irq(d);
>   	void (*rwp_wait)(void);
>   	void __iomem *base;
> +	int ret;
>   
>   	/* Interrupt configuration for SGIs can't be changed */
>   	if (irq < 16)
> @@ -425,7 +426,15 @@ static int gic_set_type(struct irq_data *d, unsigned int type)
>   		rwp_wait = gic_dist_wait_for_rwp;
>   	}
>   
> -	return gic_configure_irq(irq, type, base, rwp_wait);
> +
> +	ret = gic_configure_irq(irq, type, base + GICD_ICFGR, rwp_wait);
> +	if (ret && irq < 32) {
> +		/* Misconfigured PPIs are usually not fatal */
> +		pr_warn("GIC: PPI%d is secure or misconfigured\n", irq - 16);
> +		ret = 0;
> +	}
> +
> +	return ret;
>   }
>   
>   static int gic_irq_set_vcpu_affinity(struct irq_data *d, void *vcpu)
> diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
> index e45f45e68720..ab48760acabb 100644
> --- a/drivers/irqchip/irq-gic.c
> +++ b/drivers/irqchip/irq-gic.c
> @@ -291,6 +291,7 @@ static int gic_set_type(struct irq_data *d, unsigned int type)
>   {
>   	void __iomem *base = gic_dist_base(d);
>   	unsigned int gicirq = gic_irq(d);
> +	int ret;
>   
>   	/* Interrupt configuration for SGIs can't be changed */
>   	if (gicirq < 16)
> @@ -301,7 +302,14 @@ static int gic_set_type(struct irq_data *d, unsigned int type)
>   			    type != IRQ_TYPE_EDGE_RISING)
>   		return -EINVAL;
>   
> -	return gic_configure_irq(gicirq, type, base, NULL);
> +	ret = gic_configure_irq(gicirq, type, base + GIC_DIST_CONFIG, NULL);
> +	if (ret && gicirq < 32) {
> +		/* Misconfigured PPIs are usually not fatal */
> +		pr_warn("GIC: PPI%d is secure or misconfigured\n", gicirq - 16);
> +		ret = 0;
> +	}
> +
> +	return ret;
>   }
>   
>   static int gic_irq_set_vcpu_affinity(struct irq_data *d, void *vcpu)
> diff --git a/drivers/irqchip/irq-hip04.c b/drivers/irqchip/irq-hip04.c
> index cf705827599c..1626131834a6 100644
> --- a/drivers/irqchip/irq-hip04.c
> +++ b/drivers/irqchip/irq-hip04.c
> @@ -130,7 +130,12 @@ static int hip04_irq_set_type(struct irq_data *d, unsigned int type)
>   
>   	raw_spin_lock(&irq_controller_lock);
>   
> -	ret = gic_configure_irq(irq, type, base, NULL);
> +	ret = gic_configure_irq(irq, type, base + GIC_DIST_CONFIG, NULL);
> +	if (ret && irq < 32) {
> +		/* Misconfigured PPIs are usually not fatal */
> +		pr_warn("GIC: PPI%d is secure or misconfigured\n", irq - 16);
> +		ret = 0;
> +	}
>   
>   	raw_spin_unlock(&irq_controller_lock);
>   
> 

