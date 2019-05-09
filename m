Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C0CFC04AB2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 18:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E51AE2177E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 18:55:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729193AbfEISzN convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 14:55:13 -0400
Received: from unicorn.mansr.com ([81.2.72.234]:43750 "EHLO unicorn.mansr.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728705AbfEISzJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 14:55:09 -0400
Received: by unicorn.mansr.com (Postfix, from userid 51770)
        id 7734E14180; Thu,  9 May 2019 19:55:06 +0100 (BST)
From:   =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-usb@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Markus Reichl <m.reichl@fivetechno.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Peter Chen <peter.chen@nxp.com>
Subject: Re: [PATCH v3] usb: core: verify devicetree nodes for USB devices
References: <yw1xpnotufti.fsf@mansr.com>
        <CGME20190509084827eucas1p294962744fe70745c50b69a5349b5de68@eucas1p2.samsung.com>
        <20190509084726.5405-1-m.szyprowski@samsung.com>
Date:   Thu, 09 May 2019 19:55:06 +0100
In-Reply-To: <20190509084726.5405-1-m.szyprowski@samsung.com> (Marek
        Szyprowski's message of "Thu, 09 May 2019 10:47:26 +0200")
Message-ID: <yw1xlfzfv4ol.fsf@mansr.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marek Szyprowski <m.szyprowski@samsung.com> writes:

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

This function could be called from anywhere, so that comment seems a bit
misplaced.

> +		if (!of_find_property(node, "compatible", NULL))
> +			continue;

What if there is a node with a "compatible" property for some entirely
different purpose?  Since that won't be caught, why bother with this
test at all?

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
> -- 
> 2.17.1
>

-- 
Måns Rullgård
