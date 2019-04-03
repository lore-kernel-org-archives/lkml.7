Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14ED0C10F0B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 09:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8E4620830
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 09:19:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="OMe71v5C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbfDCJTp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 05:19:45 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:35586 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbfDCJTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 05:19:44 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id D731D25B820;
        Wed,  3 Apr 2019 20:19:41 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1554283182; bh=EhCRip9ZHFZIRxTpZn1wcHNuuwjs+DgwLETK8x2aTLI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OMe71v5CaTWJpuIIMeqwQInz13lpRkgRIdO8qEN6Kjv96BxPo0Wy58Xz9BQ1xO8vV
         ISbH+gGjmDlIyLWWyNaj5VrROthQFrRhgW8Vjyt6GRwQe2RInFq9prxvvJ81Iyfd7g
         KVcJirctg/8Lwr7+Vos8r06XR4FnJAbQjqSFkPto=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id DE8DB940361; Wed,  3 Apr 2019 11:19:39 +0200 (CEST)
Date:   Wed, 3 Apr 2019 11:19:39 +0200
From:   Simon Horman <horms@verge.net.au>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     kishon@ti.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 3/3] phy: renesas: rcar-gen3-usb2: enable/disable
 independent irqs
Message-ID: <20190403091939.qguys2dftombenpb@verge.net.au>
References: <1554120083-29990-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1554120083-29990-4-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1554120083-29990-4-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shimoda-san,

On Mon, Apr 01, 2019 at 09:01:23PM +0900, Yoshihiro Shimoda wrote:
> Since the previous code enabled/disabled the irqs both OHCI and EHCI,
> it is possible to cause unexpected interruptions. To avoid this,
> this patch creates multiple phy instances from phandle and
> enables/disables independent irqs by the instances.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

I noted a few nits below but overall this looks good to me.

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

> ---
>  drivers/phy/renesas/phy-rcar-gen3-usb2.c | 181 ++++++++++++++++++++++++++-----
>  1 file changed, 156 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/phy/renesas/phy-rcar-gen3-usb2.c b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
> index 4bdb2ed..bbe0fe5 100644
> --- a/drivers/phy/renesas/phy-rcar-gen3-usb2.c
> +++ b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
> @@ -37,11 +37,8 @@
>  
>  /* INT_ENABLE */
>  #define USB2_INT_ENABLE_UCOM_INTEN	BIT(3)
> -#define USB2_INT_ENABLE_USBH_INTB_EN	BIT(2)
> -#define USB2_INT_ENABLE_USBH_INTA_EN	BIT(1)
> -#define USB2_INT_ENABLE_INIT		(USB2_INT_ENABLE_UCOM_INTEN | \
> -					 USB2_INT_ENABLE_USBH_INTB_EN | \
> -					 USB2_INT_ENABLE_USBH_INTA_EN)
> +#define USB2_INT_ENABLE_USBH_INTB_EN	BIT(2)	/* For EHCI */
> +#define USB2_INT_ENABLE_USBH_INTA_EN	BIT(1)	/* For OHCI */
>  
>  /* USBCTR */
>  #define USB2_USBCTR_DIRPD	BIT(2)
> @@ -78,11 +75,33 @@
>  #define USB2_ADPCTRL_IDPULLUP		BIT(5)	/* 1 = ID sampling is enabled */
>  #define USB2_ADPCTRL_DRVVBUS		BIT(4)
>  
> +#define NUM_OF_PHYS			4
> +#define PHY_INDEX_BOTH_HC		0
> +#define PHY_INDEX_OHCI			1
> +#define PHY_INDEX_EHCI			2
> +#define PHY_INDEX_HSUSB			3

nit: I think the above #defines would be better expressed as an enum.

...

> +static struct phy *rcar_gen3_phy_usb2_xlate(struct device *dev,
> +					    struct of_phandle_args *args)
> +{
> +	struct rcar_gen3_chan *ch = dev_get_drvdata(dev);
> +
> +	if (args->args_count == 0)	/* For old version dts */
> +		return ch->rphys[PHY_INDEX_BOTH_HC].phy;
> +	else if (args->args_count > 1)	/* Prevent invalid args count */
> +		return ERR_PTR(-ENODEV);
> +
> +	if (args->args[0] >= NUM_OF_PHYS)
> +		return ERR_PTR(-ENODEV);
> +
> +	return ch->rphys[args->args[0]].phy;
> +}
> +
> +static enum usb_dr_mode rcar_gen3_get_dr_mode(struct device_node *np)
> +{
> +	enum usb_dr_mode candidate = USB_DR_MODE_UNKNOWN, tmp;

nit: I think that there could be a better name for tmp, f.e. mode
nit: The scope of tmp could be limited to inside the for loop.

> +	int i;
> +
> +	/*
> +	 * If one of device nodes has other dr_mode except UNKNOWN,
> +	 * this function returns UNKNOWN.
> +	 */
> +	for (i = 0; i < NUM_OF_PHYS; i++) {
> +		tmp = of_usb_get_dr_mode_by_phy(np, i);
> +		if (tmp != USB_DR_MODE_UNKNOWN) {
> +			if (candidate == USB_DR_MODE_UNKNOWN)
> +				candidate = tmp;
> +			else if (candidate != tmp)
> +				return USB_DR_MODE_UNKNOWN;
> +		}
> +	}
> +
> +	return candidate;
> +}

...
