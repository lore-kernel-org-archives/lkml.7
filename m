Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D74ACA9EC3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 08:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 260682083E
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 08:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572512158;
	bh=bwH2lGBSgTbwBF/XaBAjPMDyWxkpYJ4k5ZkDsu7mIzI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=RSAKHMeW/fDFewaZ833JKB6X2jlGIYRw7h75QXuZobyFEHrRe70naalIN24oMQJ5U
	 dgJ1ufAvoQGZqs9nwGfIChXqnipNS29vnzPsjLN+pa3a2tQCFDJzJwxMeIwgp8eF/0
	 CNqMO2cF2Vxy9s9A2D5i+FN0E8foe8jcSJY7B22Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbfJaIz5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 04:55:57 -0400
Received: from mga11.intel.com ([192.55.52.93]:45690 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727005AbfJaIz4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 04:55:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Oct 2019 01:55:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,250,1569308400"; 
   d="scan'208";a="190558319"
Received: from pipin.fi.intel.com (HELO pipin) ([10.237.72.175])
  by orsmga007.jf.intel.com with ESMTP; 31 Oct 2019 01:55:53 -0700
From:   Felipe Balbi <balbi@kernel.org>
To:     Roger Quadros <rogerq@ti.com>, gregkh@linuxfoundation.org
Cc:     pawell@cadence.com, peter.chen@nxp.com, nsekhar@ti.com,
        kurahul@cadence.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v2] usb: cdns3: gadget: Fix g_audio use case when connected to Super-Speed host
In-Reply-To: <20191030121607.21739-1-rogerq@ti.com>
References: <20191029151514.28495-1-rogerq@ti.com> <20191030121607.21739-1-rogerq@ti.com>
Date:   Thu, 31 Oct 2019 10:55:52 +0200
Message-ID: <87pnide1k7.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Roger Quadros <rogerq@ti.com> writes:

> Take into account gadget driver's speed limit when programming
> controller speed.
>
> Fixes: commit 7733f6c32e36 ("usb: cdns3: Add Cadence USB3 DRD Driver")
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> Acked-by: Peter Chen <peter.chen@nxp.com>
> ---
>
> Changelog:
> v2
> - Add Fixes line
>
>  drivers/usb/cdns3/gadget.c | 31 ++++++++++++++++++++++++++-----
>  1 file changed, 26 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
> index 40dad4e8d0dc..1c724c20d468 100644
> --- a/drivers/usb/cdns3/gadget.c
> +++ b/drivers/usb/cdns3/gadget.c
> @@ -2338,9 +2338,35 @@ static int cdns3_gadget_udc_start(struct usb_gadget *gadget,
>  {
>  	struct cdns3_device *priv_dev = gadget_to_cdns3_device(gadget);
>  	unsigned long flags;
> +	enum usb_device_speed max_speed = driver->max_speed;
>  
>  	spin_lock_irqsave(&priv_dev->lock, flags);
>  	priv_dev->gadget_driver = driver;
> +
> +	/* limit speed if necessary */
> +	max_speed = min(driver->max_speed, gadget->max_speed);
> +
> +	switch (max_speed) {
> +	case USB_SPEED_FULL:
> +		writel(USB_CONF_SFORCE_FS, &priv_dev->regs->usb_conf);
> +		writel(USB_CONF_USB3DIS, &priv_dev->regs->usb_conf);
> +		break;
> +	case USB_SPEED_HIGH:
> +		writel(USB_CONF_USB3DIS, &priv_dev->regs->usb_conf);
> +		break;
> +	case USB_SPEED_SUPER:
> +		break;
> +	default:
> +		dev_err(priv_dev->dev,
> +			"invalid maximum_speed parameter %d\n",
> +			max_speed);
> +		/* fall through */
> +	case USB_SPEED_UNKNOWN:
> +		/* default to superspeed */
> +		max_speed = USB_SPEED_SUPER;
> +		break;
> +	}

I had suggested some simplification for this case statement.

-- 
balbi
