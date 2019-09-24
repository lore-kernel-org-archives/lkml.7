Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D4BC432C2
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 10:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAB902146E
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 10:24:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504460AbfIXKYR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 06:24:17 -0400
Received: from foss.arm.com ([217.140.110.172]:57096 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405224AbfIXKYR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 06:24:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6662E142F;
        Tue, 24 Sep 2019 03:24:16 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D19463F67D;
        Tue, 24 Sep 2019 03:24:15 -0700 (PDT)
Date:   Tue, 24 Sep 2019 11:24:14 +0100
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
Subject: Re: [PATCH 04/35] irqchip/gic-v3: Detect GICv4.1 supporting RVPEID
Message-ID: <20190924102413.GN9720@e119886-lin.cambridge.arm.com>
References: <20190923182606.32100-1-maz@kernel.org>
 <20190923182606.32100-5-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190923182606.32100-5-maz@kernel.org>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 07:25:35PM +0100, Marc Zyngier wrote:
> GICv4.1 supports the RVPEID ("Residency per vPE ID"), which allows for
> a much efficient way of making virtual CPUs resident (to allow direct
> injection of interrupts).
> 
> The functionnality needs to be discovered on each and every redistributor
> in the system, and disabled if the settings are inconsistent.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  drivers/irqchip/irq-gic-v3.c       | 21 ++++++++++++++++++---
>  include/linux/irqchip/arm-gic-v3.h |  2 ++
>  2 files changed, 20 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> index 422664ac5f53..0b545e2c3498 100644
> --- a/drivers/irqchip/irq-gic-v3.c
> +++ b/drivers/irqchip/irq-gic-v3.c
> @@ -849,8 +849,21 @@ static int __gic_update_rdist_properties(struct redist_region *region,
>  					 void __iomem *ptr)
>  {
>  	u64 typer = gic_read_typer(ptr + GICR_TYPER);
> +
>  	gic_data.rdists.has_vlpis &= !!(typer & GICR_TYPER_VLPIS);
> -	gic_data.rdists.has_direct_lpi &= !!(typer & GICR_TYPER_DirectLPIS);
> +
> +	/* RVPEID implies some form of DirectLPI, no matter what the doc says... :-/ */

I think the doc says, RVPEID is *always* 1 for GICv4.1 (and presumably beyond)
and when RVPEID==1 then DirectLPI is *always* 0 - but that's OK because for
GICv4.1 support for direct LPIs is mandatory.

> +	gic_data.rdists.has_rvpeid &= !!(typer & GICR_TYPER_RVPEID);
> +	gic_data.rdists.has_direct_lpi &= (!!(typer & GICR_TYPER_DirectLPIS) |
> +					   gic_data.rdists.has_rvpeid);
> +
> +	/* Detect non-sensical configurations */
> +	if (WARN_ON_ONCE(gic_data.rdists.has_rvpeid && !gic_data.rdists.has_vlpis)) {

How feasible is the following suitation? All the redistributors in the system has
vlpis=0, and only the first redistributor has rvpeid=1 (with the remaining ones
rvpeid=0). If we evaluate this WARN_ON_ONCE on each call to
__gic_update_rdist_properties we end up without direct LPI support, however if we
evaluated this after iterating through all the redistributors then we'd end up
with direct LPI support and a non-essential WARN.

Should we do the WARN after iterating through all the redistributors once we
know what the final values of these flags will be, perhaps in
gic_update_rdist_properties?

> +		gic_data.rdists.has_direct_lpi = false;
> +		gic_data.rdists.has_vlpis = false;
> +		gic_data.rdists.has_rvpeid = false;
> +	}
> +
>  	gic_data.ppi_nr = min(GICR_TYPER_NR_PPIS(typer), gic_data.ppi_nr);
>  
>  	return 1;
> @@ -863,9 +876,10 @@ static void gic_update_rdist_properties(void)
>  	if (WARN_ON(gic_data.ppi_nr == UINT_MAX))
>  		gic_data.ppi_nr = 0;
>  	pr_info("%d PPIs implemented\n", gic_data.ppi_nr);
> -	pr_info("%sVLPI support, %sdirect LPI support\n",
> +	pr_info("%sVLPI support, %sdirect LPI support, %sRVPEID support\n",
>  		!gic_data.rdists.has_vlpis ? "no " : "",
> -		!gic_data.rdists.has_direct_lpi ? "no " : "");
> +		!gic_data.rdists.has_direct_lpi ? "no " : "",
> +		!gic_data.rdists.has_rvpeid ? "no " : "");
>  }
>  
>  /* Check whether it's single security state view */
> @@ -1546,6 +1560,7 @@ static int __init gic_init_bases(void __iomem *dist_base,
>  						 &gic_data);
>  	irq_domain_update_bus_token(gic_data.domain, DOMAIN_BUS_WIRED);
>  	gic_data.rdists.rdist = alloc_percpu(typeof(*gic_data.rdists.rdist));
> +	gic_data.rdists.has_rvpeid = true;
>  	gic_data.rdists.has_vlpis = true;
>  	gic_data.rdists.has_direct_lpi = true;
>  
> diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
> index 5cc10cf7cb3e..b34e0c113697 100644
> --- a/include/linux/irqchip/arm-gic-v3.h
> +++ b/include/linux/irqchip/arm-gic-v3.h
> @@ -234,6 +234,7 @@
>  #define GICR_TYPER_VLPIS		(1U << 1)
>  #define GICR_TYPER_DirectLPIS		(1U << 3)
>  #define GICR_TYPER_LAST			(1U << 4)
> +#define GICR_TYPER_RVPEID		(1U << 7)
>  
>  #define GIC_V3_REDIST_SIZE		0x20000
>  
> @@ -613,6 +614,7 @@ struct rdists {
>  	u64			flags;
>  	u32			gicd_typer;
>  	bool			has_vlpis;
> +	bool			has_rvpeid;
>  	bool			has_direct_lpi;
>  };
>  
> -- 
> 2.20.1
> 
