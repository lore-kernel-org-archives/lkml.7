Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UPPERCASE_50_75,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F17C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 11:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C756206A3
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 11:27:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbfDZL1J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 07:27:09 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:49958 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbfDZL1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 07:27:09 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id E7E0725AD60;
        Fri, 26 Apr 2019 21:27:05 +1000 (AEST)
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id E7CF09403ED; Fri, 26 Apr 2019 13:27:03 +0200 (CEST)
Date:   Fri, 26 Apr 2019 13:27:03 +0200
From:   Simon Horman <horms@verge.net.au>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     "David S . Miller" <davem@davemloft.net>,
        linux-usb@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usbnet: ipheth: Simplify device detection
Message-ID: <20190426112703.lrceujboxox6no3y@verge.net.au>
References: <1556128704-10831-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556128704-10831-1-git-send-email-linux@roeck-us.net>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 10:58:24AM -0700, Guenter Roeck wrote:
> All Apple products use the same protocol for tethering over USB.
> To simplify the code and make it future proof, use
> USB_VENDOR_AND_INTERFACE_INFO() instead of
> USB_DEVICE_AND_INTERFACE_INFO() to automatically detect and support
> all existing and future Apple products using the same interface.

What if future Apple products behave differently?

> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> Tested with various iPads and iPhones up to X. iPhone 6 and later
> up to and including X all use product ID 0x12a8, so this patch is
> not strictly required, but it does simplify the code.
> 
>  drivers/net/usb/ipheth.c | 58 +++---------------------------------------------
>  1 file changed, 3 insertions(+), 55 deletions(-)
> 
> diff --git a/drivers/net/usb/ipheth.c b/drivers/net/usb/ipheth.c
> index 3d8a70d3ea9b..a01a71a7e48d 100644
> --- a/drivers/net/usb/ipheth.c
> +++ b/drivers/net/usb/ipheth.c
> @@ -54,17 +54,6 @@
>  #include <linux/workqueue.h>
>  
>  #define USB_VENDOR_APPLE        0x05ac
> -#define USB_PRODUCT_IPHONE      0x1290
> -#define USB_PRODUCT_IPHONE_3G   0x1292
> -#define USB_PRODUCT_IPHONE_3GS  0x1294
> -#define USB_PRODUCT_IPHONE_4	0x1297
> -#define USB_PRODUCT_IPAD 0x129a
> -#define USB_PRODUCT_IPAD_2	0x12a2
> -#define USB_PRODUCT_IPAD_3	0x12a6
> -#define USB_PRODUCT_IPAD_MINI    0x12ab
> -#define USB_PRODUCT_IPHONE_4_VZW 0x129c
> -#define USB_PRODUCT_IPHONE_4S	0x12a0
> -#define USB_PRODUCT_IPHONE_5	0x12a8
>  
>  #define IPHETH_USBINTF_CLASS    255
>  #define IPHETH_USBINTF_SUBCLASS 253
> @@ -88,50 +77,9 @@
>  #define IPHETH_CARRIER_ON       0x04
>  
>  static const struct usb_device_id ipheth_table[] = {
> -	{ USB_DEVICE_AND_INTERFACE_INFO(
> -		USB_VENDOR_APPLE, USB_PRODUCT_IPHONE,
> -		IPHETH_USBINTF_CLASS, IPHETH_USBINTF_SUBCLASS,
> -		IPHETH_USBINTF_PROTO) },
> -	{ USB_DEVICE_AND_INTERFACE_INFO(
> -		USB_VENDOR_APPLE, USB_PRODUCT_IPHONE_3G,
> -		IPHETH_USBINTF_CLASS, IPHETH_USBINTF_SUBCLASS,
> -		IPHETH_USBINTF_PROTO) },
> -	{ USB_DEVICE_AND_INTERFACE_INFO(
> -		USB_VENDOR_APPLE, USB_PRODUCT_IPHONE_3GS,
> -		IPHETH_USBINTF_CLASS, IPHETH_USBINTF_SUBCLASS,
> -		IPHETH_USBINTF_PROTO) },
> -	{ USB_DEVICE_AND_INTERFACE_INFO(
> -		USB_VENDOR_APPLE, USB_PRODUCT_IPHONE_4,
> -		IPHETH_USBINTF_CLASS, IPHETH_USBINTF_SUBCLASS,
> -		IPHETH_USBINTF_PROTO) },
> -	{ USB_DEVICE_AND_INTERFACE_INFO(
> -		USB_VENDOR_APPLE, USB_PRODUCT_IPAD,
> -		IPHETH_USBINTF_CLASS, IPHETH_USBINTF_SUBCLASS,
> -		IPHETH_USBINTF_PROTO) },
> -	{ USB_DEVICE_AND_INTERFACE_INFO(
> -		USB_VENDOR_APPLE, USB_PRODUCT_IPAD_2,
> -		IPHETH_USBINTF_CLASS, IPHETH_USBINTF_SUBCLASS,
> -		IPHETH_USBINTF_PROTO) },
> -	{ USB_DEVICE_AND_INTERFACE_INFO(
> -		USB_VENDOR_APPLE, USB_PRODUCT_IPAD_3,
> -		IPHETH_USBINTF_CLASS, IPHETH_USBINTF_SUBCLASS,
> -		IPHETH_USBINTF_PROTO) },
> -	{ USB_DEVICE_AND_INTERFACE_INFO(
> -		USB_VENDOR_APPLE, USB_PRODUCT_IPAD_MINI,
> -		IPHETH_USBINTF_CLASS, IPHETH_USBINTF_SUBCLASS,
> -		IPHETH_USBINTF_PROTO) },
> -	{ USB_DEVICE_AND_INTERFACE_INFO(
> -		USB_VENDOR_APPLE, USB_PRODUCT_IPHONE_4_VZW,
> -		IPHETH_USBINTF_CLASS, IPHETH_USBINTF_SUBCLASS,
> -		IPHETH_USBINTF_PROTO) },
> -	{ USB_DEVICE_AND_INTERFACE_INFO(
> -		USB_VENDOR_APPLE, USB_PRODUCT_IPHONE_4S,
> -		IPHETH_USBINTF_CLASS, IPHETH_USBINTF_SUBCLASS,
> -		IPHETH_USBINTF_PROTO) },
> -	{ USB_DEVICE_AND_INTERFACE_INFO(
> -		USB_VENDOR_APPLE, USB_PRODUCT_IPHONE_5,
> -		IPHETH_USBINTF_CLASS, IPHETH_USBINTF_SUBCLASS,
> -		IPHETH_USBINTF_PROTO) },
> +	{ USB_VENDOR_AND_INTERFACE_INFO(USB_VENDOR_APPLE, IPHETH_USBINTF_CLASS,
> +					IPHETH_USBINTF_SUBCLASS,
> +					IPHETH_USBINTF_PROTO) },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(usb, ipheth_table);
> -- 
> 2.7.4
> 
