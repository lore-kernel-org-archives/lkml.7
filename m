Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51057C7618E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 12:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A65521901
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 12:51:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="UZjZjBDC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389995AbfGWMvM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 08:51:12 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:50720 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731298AbfGWMvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 08:51:11 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x6NCon3h006938;
        Tue, 23 Jul 2019 07:50:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1563886249;
        bh=52qhupjxn+B9564HmbrwKDqCkUUSaUEP+bThbTNl/c0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=UZjZjBDCXQuig05ZYJEjPWaewnRPvtT3Brk3gwsAVHFCFV3inMgDhXKM2d9g537G1
         DFvHo603gc3fRcBRH9iEEaJ2AeGyV18Ss+VKwkp0ADfjDUR0BA7zi3o/ephrxrU7tP
         9vlavdAdchooy/tIjKH0d5GiVg6XkbuOYgPD1unU=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x6NConV4066007
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 23 Jul 2019 07:50:49 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 23
 Jul 2019 07:50:49 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 23 Jul 2019 07:50:49 -0500
Received: from [172.24.190.117] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x6NCokSH027318;
        Tue, 23 Jul 2019 07:50:47 -0500
Subject: Re: [PATCH 4/9] irqchip/gic-v3: Add ESPI range support
To:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20190723104437.154403-1-maz@kernel.org>
 <20190723104437.154403-5-maz@kernel.org>
From:   Lokesh Vutla <lokeshvutla@ti.com>
Message-ID: <a54dfa07-2f3b-def7-fec4-b6dab2bcd84c@ti.com>
Date:   Tue, 23 Jul 2019 18:20:05 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190723104437.154403-5-maz@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/07/19 4:14 PM, Marc Zyngier wrote:
> Add the required support for the ESPI range, which behave exactly like
> the SPIs of old, only with new funky INTIDs.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  drivers/irqchip/irq-gic-v3.c       | 85 ++++++++++++++++++++++++------
>  include/linux/irqchip/arm-gic-v3.h | 17 +++++-
>  2 files changed, 85 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> index 2371e0a70215..d328a8de533f 100644
> --- a/drivers/irqchip/irq-gic-v3.c
> +++ b/drivers/irqchip/irq-gic-v3.c
> @@ -51,13 +51,16 @@ struct gic_chip_data {
>  	u32			nr_redist_regions;
>  	u64			flags;
>  	bool			has_rss;
> -	unsigned int		irq_nr;
>  	struct partition_desc	*ppi_descs[16];
>  };
>  
>  static struct gic_chip_data gic_data __read_mostly;
>  static DEFINE_STATIC_KEY_TRUE(supports_deactivate_key);
>  
> +#define GIC_ID_NR	(1U << GICD_TYPER_ID_BITS(gic_data.rdists.gicd_typer))
> +#define GIC_LINE_NR	GICD_TYPER_SPIS(gic_data.rdists.gicd_typer)
> +#define GIC_ESPI_NR	GICD_TYPER_ESPIS(gic_data.rdists.gicd_typer)
> +
>  /*
>   * The behaviours of RPR and PMR registers differ depending on the value of
>   * SCR_EL3.FIQ, and the behaviour of non-secure priority registers of the
> @@ -100,6 +103,7 @@ static DEFINE_PER_CPU(bool, has_rss);
>  enum gic_intid_range {
>  	PPI_RANGE,
>  	SPI_RANGE,
> +	ESPI_RANGE,
>  	LPI_RANGE,
>  	__INVALID_RANGE__
>  };
> @@ -111,6 +115,8 @@ static enum gic_intid_range __get_intid_range(irq_hw_number_t hwirq)
>  		return PPI_RANGE;
>  	case 32 ... 1019:
>  		return SPI_RANGE;
> +	case ESPI_BASE_INTID ... 8191:

as per dt documentation, shouldn't the range be
	case ESPI_BASE_INTID ... 5119:

> +		return ESPI_RANGE;
>  	case 8192 ... GENMASK(23, 0):
>  		return LPI_RANGE;
>  	default:
> @@ -141,6 +147,7 @@ static inline void __iomem *gic_dist_base(struct irq_data *d)
>  		return gic_data_rdist_sgi_base();
>  
>  	case SPI_RANGE:
> +	case ESPI_RANGE:
>  		/* SPI -> dist_base */
>  		return gic_data.dist_base;
>  
> @@ -234,6 +241,31 @@ static u32 convert_offset_index(struct irq_data *d, u32 offset, u32 *index)
>  	case SPI_RANGE:
>  		*index = d->hwirq;
>  		return offset;
> +	case ESPI_RANGE:
> +		*index = d->hwirq - ESPI_BASE_INTID;
> +		switch (offset) {
> +		case GICD_ISENABLER:
> +			return GICD_ISENABLERnE;
> +		case GICD_ICENABLER:
> +			return GICD_ICENABLERnE;
> +		case GICD_ISPENDR:
> +			return GICD_ISPENDRnE;
> +		case GICD_ICPENDR:
> +			return GICD_ICPENDRnE;
> +		case GICD_ISACTIVER:
> +			return GICD_ISACTIVERnE;
> +		case GICD_ICACTIVER:
> +			return GICD_ICACTIVERnE;
> +		case GICD_IPRIORITYR:
> +			return GICD_IPRIORITYRnE;
> +		case GICD_ICFGR:
> +			return GICD_ICFGRnE;
> +		case GICD_IROUTER:
> +			return GICD_IROUTERnE;
> +		default:
> +			break;
> +		}
> +		break;
>  	default:
>  		break;
>  	}
> @@ -316,7 +348,7 @@ static int gic_irq_set_irqchip_state(struct irq_data *d,
>  {
>  	u32 reg;
>  
> -	if (d->hwirq >= gic_data.irq_nr) /* PPI/SPI only */
> +	if (d->hwirq >= 8192) /* PPI/SPI only */
>  		return -EINVAL;
>  
>  	switch (which) {
> @@ -343,7 +375,7 @@ static int gic_irq_set_irqchip_state(struct irq_data *d,
>  static int gic_irq_get_irqchip_state(struct irq_data *d,
>  				     enum irqchip_irq_state which, bool *val)
>  {
> -	if (d->hwirq >= gic_data.irq_nr) /* PPI/SPI only */
> +	if (d->hwirq >= 8192) /* PPI/SPI only */
>  		return -EINVAL;
>  
>  	switch (which) {
> @@ -567,7 +599,12 @@ static asmlinkage void __exception_irq_entry gic_handle_irq(struct pt_regs *regs
>  		gic_arch_enable_irqs();
>  	}
>  
> -	if (likely(irqnr > 15 && irqnr < 1020) || irqnr >= 8192) {
> +	/* Check for special IDs first */
> +	if ((irqnr >= 1020 && irqnr <= 1023))
> +		return;

May be I am missing something here, what is special about these 4 interrupts? or
you meant to check for reserved range here?

Thanks and regards,
Lokesh


