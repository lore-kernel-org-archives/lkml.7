Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35586ECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 16:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E8B621A49
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 16:34:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408237AbfJQQel (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 12:34:41 -0400
Received: from muru.com ([72.249.23.125]:37814 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730640AbfJQQel (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 12:34:41 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id C458C804F;
        Thu, 17 Oct 2019 16:35:10 +0000 (UTC)
Date:   Thu, 17 Oct 2019 09:34:33 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     min.guo@mediatek.com
Cc:     Bin Liu <b-liu@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        chunfeng.yun@mediatek.com, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, hdegoede@redhat.com,
        Yonglong Wu <yonglong.wu@mediatek.com>
Subject: Re: [PATCH v8 6/6] usb: musb: Add support for MediaTek musb
 controller
Message-ID: <20191017163433.GN5610@atomide.com>
References: <20191017094126.29045-1-min.guo@mediatek.com>
 <20191017094126.29045-7-min.guo@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191017094126.29045-7-min.guo@mediatek.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Just few comments for future changes that might help below.

* min.guo@mediatek.com <min.guo@mediatek.com> [191017 09:42]:
> --- /dev/null
> +++ b/drivers/usb/musb/mediatek.c
> +static int musb_usb_role_sx_set(struct device *dev, enum usb_role role)
> +{
> +	struct mtk_glue *glue = dev_get_drvdata(dev);
> +	struct musb *musb = glue->musb;
> +	u8 devctl = readb(musb->mregs + MUSB_DEVCTL);
> +	enum usb_role new_role;
> +
> +	if (role == glue->role)
> +		return 0;
> +
> +	switch (role) {
> +	case USB_ROLE_HOST:
> +		musb->xceiv->otg->state = OTG_STATE_A_WAIT_VRISE;
> +		glue->phy_mode = PHY_MODE_USB_HOST;
> +		new_role = USB_ROLE_HOST;
> +		if (glue->role == USB_ROLE_NONE)
> +			phy_power_on(glue->phy);
> +
> +		devctl |= MUSB_DEVCTL_SESSION;
> +		musb_writeb(musb->mregs, MUSB_DEVCTL, devctl);
> +		MUSB_HST_MODE(musb);
> +		break;
> +	case USB_ROLE_DEVICE:
> +		musb->xceiv->otg->state = OTG_STATE_B_IDLE;
> +		glue->phy_mode = PHY_MODE_USB_DEVICE;
> +		new_role = USB_ROLE_DEVICE;
> +		devctl &= ~MUSB_DEVCTL_SESSION;
> +		musb_writeb(musb->mregs, MUSB_DEVCTL, devctl);
> +		if (glue->role == USB_ROLE_NONE)
> +			phy_power_on(glue->phy);
> +
> +		MUSB_DEV_MODE(musb);
> +		break;
> +	case USB_ROLE_NONE:
> +		glue->phy_mode = PHY_MODE_USB_OTG;
> +		new_role = USB_ROLE_NONE;
> +		devctl &= ~MUSB_DEVCTL_SESSION;
> +		musb_writeb(musb->mregs, MUSB_DEVCTL, devctl);
> +		if (glue->role != USB_ROLE_NONE)
> +			phy_power_off(glue->phy);
> +
> +		break;
> +	default:
> +		dev_err(glue->dev, "Invalid State\n");
> +		return -EINVAL;
> +	}
> +
> +	glue->role = new_role;
> +	phy_set_mode(glue->phy, glue->phy_mode);
> +
> +	return 0;
> +}

For the role change, I recently posted a patch "[PATCH 4/7] usb: musb:
Add musb_set_host and peripheral and use them for omap2430". That
should work for you looking at the code above, so later on you might
want to change to use that. Probably best done as a follow-up patch
to avoid adding extra dependencies to your series.

Please also note that musb core attempts to do things automagically
on it's own. So trying to force mode in general does not work reliably.
This is because VBUS may not yet have risen for example.

The role change is best done based on the USB PHY as then usually
musb has already switched to the right mode automatically :)

> +static const struct musb_platform_ops mtk_musb_ops = {
> +	.quirks = MUSB_DMA_INVENTRA,
> +	.init = mtk_musb_init,
> +	.get_toggle = mtk_musb_get_toggle,
> +	.set_toggle = mtk_musb_set_toggle,
> +	.exit = mtk_musb_exit,
> +#ifdef CONFIG_USB_INVENTRA_DMA
> +	.dma_init = musbhs_dma_controller_create_noirq,
> +	.dma_exit = musbhs_dma_controller_destroy,
> +#endif
> +	.clearb = mtk_musb_clearb,
> +	.clearw = mtk_musb_clearw,
> +	.busctl_offset = mtk_musb_busctl_offset,
> +	.set_mode = mtk_musb_set_mode,
> +};

So you may want to consider getting rid of .set_mode completely
and rely on USB PHY calls instead.

In some cases you need to use struct phy_companion for set_vbus
depending how things are wired.

Regards,

Tony
