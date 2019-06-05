Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E31C282DE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 08:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A32E208C0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 08:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559721604;
	bh=6Tay8/CJ4xgbrxlKxpcTnSD08W3NG/ziSH9l0+5goPg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BhmwtKO0d2Qi4L5fF9xt2blzZnvpJonVAnppVDdr5g0jRgNwMNcVl+9M5Qmy4g59H
	 2uEIElng3bktcFhjs8wAgbs+/XHf3M2F81JsQQ1OR7RFGnt850ncMVFtE4jM+7s80x
	 wDk2kWSQ7YhTtXa24nfG6Zgi8o1tLvP8UvC5NOkE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfFEIAD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 04:00:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:33230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725294AbfFEIAC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 04:00:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA2482083E;
        Wed,  5 Jun 2019 08:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559721601;
        bh=6Tay8/CJ4xgbrxlKxpcTnSD08W3NG/ziSH9l0+5goPg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LN8j8xrINtrTZO5aw1TTy8Xy1k3lfhlaMfAuNfT7/y1XbmBnmc7qpEe2OeOI05wK8
         Lzj9rbTebg2CTlJ/x4/mdzCL8cU2d0h2iHOgQ9byRSg1DbZXUs/0rA/EBW1pYl/v1y
         ZLQZ72Ds+5oUQJo71E8ESrVGoJZFrMrmBBOiBwbE=
Date:   Wed, 5 Jun 2019 09:59:58 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Talel Shenhar <talel@amazon.com>
Cc:     nicolas.ferre@microchip.com, jason@lakedaemon.net,
        marc.zyngier@arm.com, mark.rutland@arm.com,
        mchehab+samsung@kernel.org, robh+dt@kernel.org,
        davem@davemloft.net, shawn.lin@rock-chips.com, tglx@linutronix.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dwmw@amazon.co.uk, benh@kernel.crashing.org, jonnyc@amazon.com,
        hhhawa@amazon.com, ronenk@amazon.com, hanochu@amazon.com,
        barakw@amazon.com
Subject: Re: [PATCH 3/3] irqchip: al-fic: Introducing support for MSI-X
Message-ID: <20190605075958.GB9693@kroah.com>
References: <1559717653-11258-1-git-send-email-talel@amazon.com>
 <1559717653-11258-4-git-send-email-talel@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559717653-11258-4-git-send-email-talel@amazon.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 05, 2019 at 09:54:13AM +0300, Talel Shenhar wrote:
> The FIC supports either a (single) wired output, or generation of an MSI-X
> interrupt per input (for cases where it is embedded in a PCIe device,
> hence, allowing the PCIe drivers to call this API).
> This patch introduces the support for allowing the configuration of MSI-X
> instead of a wire interrupt.
> 
> Signed-off-by: Talel Shenhar <talel@amazon.com>
> ---
>  drivers/irqchip/irq-al-fic.c   | 48 +++++++++++++++++++++++++++++++++++++++---
>  include/linux/irqchip/al-fic.h |  2 ++
>  2 files changed, 47 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-al-fic.c b/drivers/irqchip/irq-al-fic.c
> index d881d42..e49b912 100644
> --- a/drivers/irqchip/irq-al-fic.c
> +++ b/drivers/irqchip/irq-al-fic.c
> @@ -19,6 +19,7 @@
>  #define AL_FIC_MASK		0x10
>  #define AL_FIC_CONTROL		0x28
>  
> +#define CONTROL_AUTO_CLEAR	BIT(2)
>  #define CONTROL_TRIGGER_RISING	BIT(3)
>  #define CONTROL_MASK_MSI_X	BIT(5)
>  
> @@ -193,9 +194,11 @@ struct irq_domain *al_fic_wire_get_domain(struct al_fic *fic)
>  }
>  EXPORT_SYMBOL_GPL(al_fic_wire_get_domain);
>  
> -static void al_fic_hw_init(struct al_fic *fic)
> +static void al_fic_hw_init(struct al_fic *fic,
> +			   int use_msi)
>  {
> -	u32 control = CONTROL_MASK_MSI_X;
> +	u32 control = (use_msi ? (CONTROL_AUTO_CLEAR | CONTROL_TRIGGER_RISING) :
> +		       CONTROL_MASK_MSI_X);
>  
>  	/* mask out all interrupts */
>  	writel(0xFFFFFFFF, fic->base + AL_FIC_MASK);
> @@ -240,7 +243,7 @@ struct al_fic *al_fic_wire_init(struct device_node *node,
>  	fic->parent_irq = parent_irq;
>  	fic->name = (name ?: "al-fic-wire");
>  
> -	al_fic_hw_init(fic);
> +	al_fic_hw_init(fic, false);
>  
>  	ret = al_fic_register(node, fic);
>  	if (ret) {
> @@ -260,6 +263,45 @@ struct al_fic *al_fic_wire_init(struct device_node *node,
>  EXPORT_SYMBOL_GPL(al_fic_wire_init);
>  
>  /**
> + * al_fic_msi_x_init() - initialize and configure fic in msi-x mode
> + * @base: mmio to fic register
> + * @name: name of the fic
> + *
> + * This API will configure the fic hardware to to work in msi-x mode.
> + * msi-x fic is to be configured for fics that are embedded inside AL PCIE EP.
> + * Those kind of fic are aware of the fact that they live inside PCIE and
> + * familiar with the MSI-X table which is configured as part of
> + * pci_enable_msix_range() and friends.
> + * Interrupt can be generated based on a positive edge or level - configuration
> + * is to be determined based on connected hardware to this fic.
> + *
> + * Returns pointer to fic context or ERR_PTR in case of error.
> + */
> +struct al_fic *al_fic_msi_x_init(void __iomem *base,
> +				 const char *name)
> +{
> +	struct al_fic *fic;
> +
> +	if (!base)
> +		return ERR_PTR(-EINVAL);
> +
> +	fic = kzalloc(sizeof(*fic), GFP_KERNEL);
> +	if (!fic)
> +		return ERR_PTR(-ENOMEM);
> +
> +	fic->base = base;
> +	fic->name = (name ?: "al-fic-full-fledged");
> +
> +	al_fic_hw_init(fic, true);
> +
> +	pr_debug("%s initialized successfully in Full-Fledged mode\n",
> +		 fic->name);
> +
> +	return fic;
> +}
> +EXPORT_SYMBOL_GPL(al_fic_msi_x_init);
> +
> +/**
>   * al_fic_cleanup() - free all resources allocated by fic
>   * @fic: pointer to fic context
>   *
> diff --git a/include/linux/irqchip/al-fic.h b/include/linux/irqchip/al-fic.h
> index 0833749..a2e89ff 100644
> --- a/include/linux/irqchip/al-fic.h
> +++ b/include/linux/irqchip/al-fic.h
> @@ -16,6 +16,8 @@ struct al_fic *al_fic_wire_init(struct device_node *node,
>  				void __iomem *base,
>  				const char *name,
>  				unsigned int parent_irq);
> +struct al_fic *al_fic_msi_x_init(void __iomem *base,
> +				 const char *name);

Who uses this new function?

thanks,

greg k-h
