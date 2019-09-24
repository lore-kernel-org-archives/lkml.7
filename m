Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 646D3C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 10:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BD32214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 10:49:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440743AbfIXKtH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 06:49:07 -0400
Received: from foss.arm.com ([217.140.110.172]:57366 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438486AbfIXKtG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 06:49:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DC5CF142F;
        Tue, 24 Sep 2019 03:49:05 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5507B3F67D;
        Tue, 24 Sep 2019 03:49:05 -0700 (PDT)
Date:   Tue, 24 Sep 2019 11:49:03 +0100
From:   Andrew Murray <andrew.murray@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        Eric Auger <eric.auger@redhat.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH 05/35] irqchip/gic-v3: Add GICv4.1 VPEID size discovery
Message-ID: <20190924104903.GO9720@e119886-lin.cambridge.arm.com>
References: <20190923182606.32100-1-maz@kernel.org>
 <20190923182606.32100-6-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190923182606.32100-6-maz@kernel.org>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 07:25:36PM +0100, Marc Zyngier wrote:
> While GICv4.0 mandates 16 bit worth of VPEIDs, GICv4.1 allows smaller

s/VPEIDs/vPEIDs/

> implementations to be built. Add the required glue to dynamically
> compute the limit.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  drivers/irqchip/irq-gic-v3-its.c   | 11 ++++++++++-
>  drivers/irqchip/irq-gic-v3.c       |  3 +++
>  include/linux/irqchip/arm-gic-v3.h |  5 +++++
>  3 files changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index c94eb287393b..17b77a0b9d97 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -119,7 +119,16 @@ struct its_node {
>  #define ITS_ITT_ALIGN		SZ_256
>  
>  /* The maximum number of VPEID bits supported by VLPI commands */
> -#define ITS_MAX_VPEID_BITS	(16)
> +#define ITS_MAX_VPEID_BITS						\
> +	({								\
> +		int nvpeid = 16;					\
> +		if (gic_rdists->has_rvpeid &&				\

We use rvpeid as a way of determining if this is a GICv4.1, are there any
other means of determining this? If we use it in this way, is there any
benefit to having a has_gicv4_1 type of flag instead?

Also for 'insane' configurations we set has_rvpeid to false, thus preventing
this feature. Does it make sense to do that?

GICD_TYPER2 is reserved in GICv4, however I understand this reads as RES0,
can we just rely on that instead? (We read it below anyway).

> +		    gic_rdists->gicd_typer2 & GICD_TYPER2_VIL)		\
> +			nvpeid = 1 + (gic_rdists->gicd_typer2 &		\
> +				      GICD_TYPER2_VID);			\
> +									\
> +		nvpeid;							\
> +	})
>  #define ITS_MAX_VPEID		(1 << (ITS_MAX_VPEID_BITS))
>  
>  /* Convert page order to size in bytes */
> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> index 0b545e2c3498..fb6360161d6c 100644
> --- a/drivers/irqchip/irq-gic-v3.c
> +++ b/drivers/irqchip/irq-gic-v3.c
> @@ -1556,6 +1556,9 @@ static int __init gic_init_bases(void __iomem *dist_base,
>  
>  	pr_info("%d SPIs implemented\n", GIC_LINE_NR - 32);
>  	pr_info("%d Extended SPIs implemented\n", GIC_ESPI_NR);
> +
> +	gic_data.rdists.gicd_typer2 = readl_relaxed(gic_data.dist_base + GICD_TYPER2);
> +
>  	gic_data.domain = irq_domain_create_tree(handle, &gic_irq_domain_ops,
>  						 &gic_data);
>  	irq_domain_update_bus_token(gic_data.domain, DOMAIN_BUS_WIRED);
> diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
> index b34e0c113697..71730b9def0c 100644
> --- a/include/linux/irqchip/arm-gic-v3.h
> +++ b/include/linux/irqchip/arm-gic-v3.h
> @@ -13,6 +13,7 @@
>  #define GICD_CTLR			0x0000
>  #define GICD_TYPER			0x0004
>  #define GICD_IIDR			0x0008
> +#define GICD_TYPER2			0x000C
>  #define GICD_STATUSR			0x0010
>  #define GICD_SETSPI_NSR			0x0040
>  #define GICD_CLRSPI_NSR			0x0048
> @@ -89,6 +90,9 @@
>  #define GICD_TYPER_ESPIS(typer)						\
>  	(((typer) & GICD_TYPER_ESPI) ? GICD_TYPER_SPIS((typer) >> 27) : 0)
>  
> +#define GICD_TYPER2_VIL			(1U << 7)
> +#define GICD_TYPER2_VID			GENMASK(4, 0)

Given that the 4th bit is reserved for future expansion and values greater
than 0xF are reserved, is there value in changing this to GENMASK(3, 0)?

> +
>  #define GICD_IROUTER_SPI_MODE_ONE	(0U << 31)
>  #define GICD_IROUTER_SPI_MODE_ANY	(1U << 31)
>  
> @@ -613,6 +617,7 @@ struct rdists {
>  	void			*prop_table_va;
>  	u64			flags;
>  	u32			gicd_typer;
> +	u32			gicd_typer2;
>  	bool			has_vlpis;
>  	bool			has_rvpeid;
>  	bool			has_direct_lpi;
> -- 
> 2.20.1
> 
