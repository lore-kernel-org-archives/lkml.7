Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C83ECA9EA1
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 09:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BAAF222BD
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 09:11:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633061AbfJRJLH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 05:11:07 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:64173 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2390299AbfJRJLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 05:11:07 -0400
X-UUID: 0b296a3532bf45c79b434c6dda51c59b-20191018
X-UUID: 0b296a3532bf45c79b434c6dda51c59b-20191018
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <min.guo@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 29892557; Fri, 18 Oct 2019 17:10:57 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 18 Oct
 2019 17:10:56 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 18 Oct 2019 17:10:55 +0800
Message-ID: <1571389858.28949.13.camel@mhfsdcap03>
Subject: Re: [PATCH v8 6/6] usb: musb: Add support for MediaTek musb
 controller
From:   Min Guo <min.guo@mediatek.com>
To:     Tony Lindgren <tony@atomide.com>
CC:     Bin Liu <b-liu@ti.com>, Rob Herring <robh+dt@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Alan Stern" <stern@rowland.harvard.edu>,
        <chunfeng.yun@mediatek.com>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <hdegoede@redhat.com>,
        Yonglong Wu <yonglong.wu@mediatek.com>
Date:   Fri, 18 Oct 2019 17:10:58 +0800
In-Reply-To: <20191017163433.GN5610@atomide.com>
References: <20191017094126.29045-1-min.guo@mediatek.com>
         <20191017094126.29045-7-min.guo@mediatek.com>
         <20191017163433.GN5610@atomide.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: 13098244CDB25E873947D08018311C68E73616178ECC778BC1294947B6B966362000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Thu, 2019-10-17 at 09:34 -0700, Tony Lindgren wrote:
> Hi,
> 
> Just few comments for future changes that might help below.
> 
> * min.guo@mediatek.com <min.guo@mediatek.com> [191017 09:42]:
> > --- /dev/null
> > +++ b/drivers/usb/musb/mediatek.c
> > +static int musb_usb_role_sx_set(struct device *dev, enum usb_role role)
> > +{
> > +	struct mtk_glue *glue = dev_get_drvdata(dev);
> > +	struct musb *musb = glue->musb;
> > +	u8 devctl = readb(musb->mregs + MUSB_DEVCTL);
> > +	enum usb_role new_role;
> > +
> > +	if (role == glue->role)
> > +		return 0;
> > +
> > +	switch (role) {
> > +	case USB_ROLE_HOST:
> > +		musb->xceiv->otg->state = OTG_STATE_A_WAIT_VRISE;
> > +		glue->phy_mode = PHY_MODE_USB_HOST;
> > +		new_role = USB_ROLE_HOST;
> > +		if (glue->role == USB_ROLE_NONE)
> > +			phy_power_on(glue->phy);
> > +
> > +		devctl |= MUSB_DEVCTL_SESSION;
> > +		musb_writeb(musb->mregs, MUSB_DEVCTL, devctl);
> > +		MUSB_HST_MODE(musb);
> > +		break;
> > +	case USB_ROLE_DEVICE:
> > +		musb->xceiv->otg->state = OTG_STATE_B_IDLE;
> > +		glue->phy_mode = PHY_MODE_USB_DEVICE;
> > +		new_role = USB_ROLE_DEVICE;
> > +		devctl &= ~MUSB_DEVCTL_SESSION;
> > +		musb_writeb(musb->mregs, MUSB_DEVCTL, devctl);
> > +		if (glue->role == USB_ROLE_NONE)
> > +			phy_power_on(glue->phy);
> > +
> > +		MUSB_DEV_MODE(musb);
> > +		break;
> > +	case USB_ROLE_NONE:
> > +		glue->phy_mode = PHY_MODE_USB_OTG;
> > +		new_role = USB_ROLE_NONE;
> > +		devctl &= ~MUSB_DEVCTL_SESSION;
> > +		musb_writeb(musb->mregs, MUSB_DEVCTL, devctl);
> > +		if (glue->role != USB_ROLE_NONE)
> > +			phy_power_off(glue->phy);
> > +
> > +		break;
> > +	default:
> > +		dev_err(glue->dev, "Invalid State\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	glue->role = new_role;
> > +	phy_set_mode(glue->phy, glue->phy_mode);
> > +
> > +	return 0;
> > +}
> 
> For the role change, I recently posted a patch "[PATCH 4/7] usb: musb:
> Add musb_set_host and peripheral and use them for omap2430". That
> should work for you looking at the code above, so later on you might
> want to change to use that. Probably best done as a follow-up patch
> to avoid adding extra dependencies to your series.
OK, thanks. I will try this patch.

> Please also note that musb core attempts to do things automagically
> on it's own. So trying to force mode in general does not work reliably.
> This is because VBUS may not yet have risen for example.
VBUS control is through a GPIO on MediaTek musb controller. The host/device switching method is to use the driver of gpio-usb-b-connector, it sets the debounce of GPIO, the link of patch is as follows:
	Usb: roles: add USB Type-B GPIO connector driver
	Https://patchwork.kernel.org/patch/10966361/

> The role change is best done based on the USB PHY as then usually
> musb has already switched to the right mode automatically :)
Considering the use of type-c connector later, the foce phy method is used.

> > +static const struct musb_platform_ops mtk_musb_ops = {
> > +	.quirks = MUSB_DMA_INVENTRA,
> > +	.init = mtk_musb_init,
> > +	.get_toggle = mtk_musb_get_toggle,
> > +	.set_toggle = mtk_musb_set_toggle,
> > +	.exit = mtk_musb_exit,
> > +#ifdef CONFIG_USB_INVENTRA_DMA
> > +	.dma_init = musbhs_dma_controller_create_noirq,
> > +	.dma_exit = musbhs_dma_controller_destroy,
> > +#endif
> > +	.clearb = mtk_musb_clearb,
> > +	.clearw = mtk_musb_clearw,
> > +	.busctl_offset = mtk_musb_busctl_offset,
> > +	.set_mode = mtk_musb_set_mode,
> > +};
> 
> So you may want to consider getting rid of .set_mode completely
> and rely on USB PHY calls instead.
> 
> In some cases you need to use struct phy_companion for set_vbus
> depending how things are wired.
> 
> Regards,
> 
> Tony


