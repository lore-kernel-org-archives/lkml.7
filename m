Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D9CEC04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 19:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D675F2085A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 19:13:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbfEITNx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 15:13:53 -0400
Received: from smtp.math.uni-bielefeld.de ([129.70.45.10]:59793 "EHLO
        smtp.math.uni-bielefeld.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726749AbfEITNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 15:13:53 -0400
X-Greylist: delayed 565 seconds by postgrey-1.27 at vger.kernel.org; Thu, 09 May 2019 15:13:51 EDT
Received: from [192.168.0.100] (pC19F56B0.dip0.t-ipconnect.de [193.159.86.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by smtp.math.uni-bielefeld.de (Postfix) with ESMTPSA id E19545F595;
        Thu,  9 May 2019 21:04:23 +0200 (CEST)
Subject: Re: [PATCH v3] usb: core: verify devicetree nodes for USB devices
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-usb@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mans Rullgard <mans@mansr.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Markus Reichl <m.reichl@fivetechno.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Peter Chen <peter.chen@nxp.com>
References: <yw1xpnotufti.fsf@mansr.com>
 <CGME20190509084827eucas1p294962744fe70745c50b69a5349b5de68@eucas1p2.samsung.com>
 <20190509084726.5405-1-m.szyprowski@samsung.com>
From:   Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Openpgp: preference=signencrypt
Autocrypt: addr=tjakobi@math.uni-bielefeld.de; prefer-encrypt=mutual; keydata=
 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
 24xKzP1yWf7TCvc+DT6gUl4T65RXUQyTeJ0=
Message-ID: <bb437e5d-65b4-80b3-8112-76799c4dfbab@math.uni-bielefeld.de>
Date:   Thu, 9 May 2019 21:04:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Firefox/52.0 SeaMonkey/2.49.9.1
MIME-Version: 1.0
In-Reply-To: <20190509084726.5405-1-m.szyprowski@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Marek,

I can confirm that this restores USB operation on my X2, so you can my Tested-by
if you want.

With best wishes,
Tobias


Marek Szyprowski wrote:
> Commit 69bec7259853 ("USB: core: let USB device know device node")
> added support for attaching devicetree node for USB devices. The mentioned
> commit however identifies the given USB device node only by the 'reg'
> property in the host controller children nodes. The USB device node
> however also has to have a 'compatible' property as described in
> Documentation/devicetree/bindings/usb/usb-device.txt. Lack for the
> 'compatible' property check might result in assigning a devicetree node,
> which is not intended to be the proper node for the given USB device.
> 
> This is important especially when USB host controller has child-nodes for
> other purposes. For example, Exynos EHCI and OHCI drivers already define
> child-nodes for each physical root hub port and assigns respective PHY
> controller and parameters for them. Those binding predates support for
> USB devicetree nodes.
> 
> Checking for the proper compatibility string allows to mitigate the
> conflict between USB device devicetree nodes and the bindings for USB
> controllers with child nodes. It also fixes the side-effect of the other
> commits, like 01fdf179f4b0 ("usb: core: skip interfaces disabled in
> devicetree"), which incorrectly disables some devices on Exynos based
> boards.
> 
> Reported-by: Markus Reichl <m.reichl@fivetechno.de>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
> v3:
> - replaced ad hoc checks by proper test for proper value of the
>   compatible string in drivers/usb/core/of.c
> v2: https://lkml.org/lkml/2019/5/8/321
> v1: https://lkml.org/lkml/2019/5/7/715
> ---
>  drivers/usb/core/hub.c |  3 +++
>  drivers/usb/core/of.c  | 31 +++++++++++++++++++++++++++++++
>  include/linux/usb/of.h |  2 ++
>  3 files changed, 36 insertions(+)
> 
> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index 2f94568ba385..6f2438522d09 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -22,6 +22,7 @@
>  #include <linux/usb.h>
>  #include <linux/usbdevice_fs.h>
>  #include <linux/usb/hcd.h>
> +#include <linux/usb/of.h>
>  #include <linux/usb/otg.h>
>  #include <linux/usb/quirks.h>
>  #include <linux/workqueue.h>
> @@ -5023,6 +5024,8 @@ static void hub_port_connect(struct usb_hub *hub, int port1, u16 portstatus,
>  		if (status < 0)
>  			goto loop;
>  
> +		usb_of_validate_device_node(udev);
> +
>  		if (udev->quirks & USB_QUIRK_DELAY_INIT)
>  			msleep(2000);
>  
> diff --git a/drivers/usb/core/of.c b/drivers/usb/core/of.c
> index 651708d8c908..2b6f16753edc 100644
> --- a/drivers/usb/core/of.c
> +++ b/drivers/usb/core/of.c
> @@ -30,6 +30,12 @@ struct device_node *usb_of_get_device_node(struct usb_device *hub, int port1)
>  	for_each_child_of_node(hub->dev.of_node, node) {
>  		if (of_property_read_u32(node, "reg", &reg))
>  			continue;
> +		/*
> +		 * idVendor and idProduct are not yet known, so check only
> +		 * a presence of the compatible property.
> +		 */
> +		if (!of_find_property(node, "compatible", NULL))
> +			continue;
>  
>  		if (reg == port1)
>  			return node;
> @@ -39,6 +45,31 @@ struct device_node *usb_of_get_device_node(struct usb_device *hub, int port1)
>  }
>  EXPORT_SYMBOL_GPL(usb_of_get_device_node);
>  
> +/**
> + * usb_of_validate_device_node() - validate dt node of the probed USB device
> + * @udev: USB device
> + *
> + * Validate devicetree node for the USB device. Compatible string must match
> + * device's idVendor and idProduct, otherwise the of_node will be put and set
> + * to NULL.
> + */
> +void usb_of_validate_device_node(struct usb_device *udev)
> +{
> +	char compatible[13];
> +
> +	if (!udev->dev.of_node)
> +		return;
> +
> +	snprintf(compatible, sizeof(compatible), "usb%x,%x",
> +		 le16_to_cpu(udev->descriptor.idVendor),
> +		 le16_to_cpu(udev->descriptor.idProduct));
> +
> +	if (of_device_is_compatible(udev->dev.of_node, compatible) == 0) {
> +		of_node_put(udev->dev.of_node);
> +		udev->dev.of_node = NULL;
> +	}
> +}
> +
>  /**
>   * usb_of_has_combined_node() - determine whether a device has a combined node
>   * @udev: USB device
> diff --git a/include/linux/usb/of.h b/include/linux/usb/of.h
> index dba55ccb9b53..9969efda03ad 100644
> --- a/include/linux/usb/of.h
> +++ b/include/linux/usb/of.h
> @@ -24,6 +24,7 @@ bool usb_of_has_combined_node(struct usb_device *udev);
>  struct device_node *usb_of_get_interface_node(struct usb_device *udev,
>  		u8 config, u8 ifnum);
>  struct device *usb_of_get_companion_dev(struct device *dev);
> +void usb_of_validate_device_node(struct usb_device *udev);
>  #else
>  static inline enum usb_dr_mode
>  of_usb_get_dr_mode_by_phy(struct device_node *np, int arg0)
> @@ -57,6 +58,7 @@ static inline struct device *usb_of_get_companion_dev(struct device *dev)
>  {
>  	return NULL;
>  }
> +static inline void usb_of_validate_device_node(struct usb_device *udev) { }
>  #endif
>  
>  #if IS_ENABLED(CONFIG_OF) && IS_ENABLED(CONFIG_USB_SUPPORT)
> 

