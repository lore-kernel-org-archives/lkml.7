Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE58CCA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 11:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FFFC20874
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 11:46:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbfJ3LqM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 07:46:12 -0400
Received: from mga17.intel.com ([192.55.52.151]:19266 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726065AbfJ3LqL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 07:46:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Oct 2019 04:46:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,247,1569308400"; 
   d="scan'208";a="283529510"
Received: from pipin.fi.intel.com (HELO pipin) ([10.237.72.175])
  by orsmga001.jf.intel.com with ESMTP; 30 Oct 2019 04:46:08 -0700
From:   Felipe Balbi <felipe.balbi@linux.intel.com>
To:     Roger Quadros <rogerq@ti.com>, gregkh@linuxfoundation.org
Cc:     pawell@cadence.com, peter.chen@nxp.com, nsekhar@ti.com,
        kurahul@cadence.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH] usb: cdns3: gadget: Fix g_audio use case when connected to Super-Speed host
In-Reply-To: <20191029151514.28495-1-rogerq@ti.com>
References: <20191029151514.28495-1-rogerq@ti.com>
Date:   Wed, 30 Oct 2019 13:46:07 +0200
Message-ID: <87y2x2e9s0.fsf@gmail.com>
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
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
> Hi Greg,
>
> Please apply this for -rc.

if you want this in -rc, you should have a Fixes line there.

> Without this, g_audio is broken on cdns3 USB controller is
> connected to a Super-Speed host.
>
> cheers,
> -roger
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

seems like this can be simplified a little:

	switch (max_speed) {
        case USB_SPEED_FULL:
        	writel(USB_CONF_SFORCE_FS, &priv_dev->regs->usb_conf);
                /* fallthrough */
        case USB_SPEED_HIGH:
		writel(USB_CONF_USB3DIS, &priv_dev->regs->usb_conf);
                /* fallthrough */
	case USB_SPEED_SUPER:
		break;

	[...]

		
-- 
balbi
