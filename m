Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11713C2D0BF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 19:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB26E2077B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 19:53:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Gt9zLh2w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbfLJTxK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 14:53:10 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:35814 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbfLJTxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 14:53:10 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBAJr32k029399;
        Tue, 10 Dec 2019 13:53:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1576007584;
        bh=yo7sZxfjugdMo8ZFuedB2icaA5L7ymj3/COg0IqvRm0=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=Gt9zLh2wwit4Fz3gxo8h5LFl0P6nDAAQn8RSp5Ct9uDjRhN0aT3opw2Yuo+n1/XTm
         9t2Fcrua7foIVe3OCoKtAZFz6d2XvqHwzc8p2zr9TocsuATjMmE0fjHf8IOE6UcsZO
         wEydWZWtxy74Gmd4DoXa2gbq9h0qZwgZHBRpzE24=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBAJr2oc100175;
        Tue, 10 Dec 2019 13:53:03 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 10
 Dec 2019 13:53:03 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 10 Dec 2019 13:53:03 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBAJr3Qp054301;
        Tue, 10 Dec 2019 13:53:03 -0600
Date:   Tue, 10 Dec 2019 13:52:30 -0600
From:   Bin Liu <b-liu@ti.com>
To:     Paul Cercueil <paul@crapouillou.net>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>, <od@zcrc.me>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 7/7] usb: musb: jz4740: Disable pullup at init
Message-ID: <20191210195230.GA16429@iaqt7>
Mail-Followup-To: Bin Liu <b-liu@ti.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>, od@zcrc.me,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191210171110.62141-1-paul@crapouillou.net>
 <20191210171110.62141-7-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20191210171110.62141-7-paul@crapouillou.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Dec 10, 2019 at 06:11:10PM +0100, Paul Cercueil wrote:
> The pullup may be already enabled before the driver is initialized.
> It has to be disabled at init time, as we cannot guarantee that a gadget
> driver will be bound to the UDC.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
> 
> Notes:
>     v3: New patch
> 
>  drivers/usb/musb/jz4740.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/usb/musb/jz4740.c b/drivers/usb/musb/jz4740.c
> index f948eca654f3..1af9e4053312 100644
> --- a/drivers/usb/musb/jz4740.c
> +++ b/drivers/usb/musb/jz4740.c
> @@ -75,6 +75,7 @@ static const struct musb_hdrc_config jz4740_musb_config = {
>  static int jz4740_musb_init(struct musb *musb)
>  {
>  	struct device *dev = musb->controller->parent;
> +	u8 power;
>  	int err;
>  
>  	if (dev->of_node)
> @@ -97,6 +98,14 @@ static int jz4740_musb_init(struct musb *musb)
>  	musb->isr = jz4740_musb_interrupt;
>  	musb->dma_share_usb_irq = true;
>  
> +	/*
> +	 * If the SoC booted from USB the pullup might still be set.
> +	 * Disable it until a gadget is bound.
> +	 */
> +	power = musb_readb(musb->mregs, MUSB_POWER);
> +	power &= ~MUSB_POWER_SOFTCONN;
> +	musb_writeb(musb->mregs, MUSB_POWER, power);
> +
>  	return 0;
>  }

It is preferred the glue drivers don't touch the controller core
registers if possible. Please try the following patch instead.

-Bin.

------------- >8 ------------
t a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 683b719c5026..2f9105e8ea38 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -2317,6 +2317,9 @@ musb_init_controller(struct device *dev, int nIrq, void __iomem *ctrl)
        musb_disable_interrupts(musb);
        musb_writeb(musb->mregs, MUSB_DEVCTL, 0);

+       /* MUSB_POWER_SOFTCONN might be already set, jz4740 does this. */
+       musb_writeb(musb->mregs, MUSB_POWER, 0);
+
        /* Init IRQ workqueue before request_irq */
        INIT_DELAYED_WORK(&musb->irq_work, musb_irq_work);
        INIT_DELAYED_WORK(&musb->deassert_reset_work, musb_deassert_reset);
