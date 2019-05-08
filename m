Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE67C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 11:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 972D0214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 11:46:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728208AbfEHLqf convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 07:46:35 -0400
Received: from unicorn.mansr.com ([81.2.72.234]:35024 "EHLO unicorn.mansr.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727545AbfEHLqf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 07:46:35 -0400
Received: by unicorn.mansr.com (Postfix, from userid 51770)
        id 2C80F149B7; Wed,  8 May 2019 12:46:33 +0100 (BST)
From:   =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-usb@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Markus Reichl <m.reichl@fivetechno.de>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v2] usb: core: verify devicetree nodes for disabled interfaces
References: <106fc58c-1a4f-6605-41d7-b6031c5751a3@samsung.com>
        <CGME20190508104442eucas1p2ebdffa348465f2c28177601014614853@eucas1p2.samsung.com>
        <20190508104434.3409-1-m.szyprowski@samsung.com>
Date:   Wed, 08 May 2019 12:46:33 +0100
In-Reply-To: <20190508104434.3409-1-m.szyprowski@samsung.com> (Marek
        Szyprowski's message of "Wed, 08 May 2019 12:44:34 +0200")
Message-ID: <yw1xtve5uq1y.fsf@mansr.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marek Szyprowski <m.szyprowski@samsung.com> writes:

> Commit 01fdf179f4b0 ("usb: core: skip interfaces disabled in devicetree")
> add support for disabling given USB device interface by adding nodes to
> the USB host controller device. The mentioned commit however identifies
> the given USB interface node only by the 'reg' property in the host
> controller children nodes and then checks for their the 'status'. The USB
> device interface nodes however also has to have a 'compatible' property as
> described in Documentation/devicetree/bindings/usb/usb-device.txt. This is
> important, because USB host controller might have child-nodes for other
> purposes. For example, Exynos EHCI and OHCI drivers already define
> child-nodes for each physical root hub port and assigns respective PHY
> controller and parameters for them. This conflicts with the proposed
> approach and verifying for the presence of the compatible property fixes
> this issue without changing the bindings and the way the PHY controllers
> are handled by Exynos EHCI/OHCI drivers.
>
> Reported-by: Markus Reichl <m.reichl@fivetechno.de>
> Fixes: 01fdf179f4b0 ("usb: core: skip interfaces disabled in devicetree")
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/usb/core/message.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/usb/core/message.c b/drivers/usb/core/message.c
> index e844bb7b5676..6f7d047392bd 100644
> --- a/drivers/usb/core/message.c
> +++ b/drivers/usb/core/message.c
> @@ -2009,6 +2009,7 @@ int usb_set_configuration(struct usb_device *dev, int configuration)
>  		struct usb_interface *intf = cp->interface[i];
>
>  		if (intf->dev.of_node &&
> +		    of_find_property(intf->dev.of_node, "compatible", NULL) &&
>  		    !of_device_is_available(intf->dev.of_node)) {
>  			dev_info(&dev->dev, "skipping disabled interface %d\n",
>  				 intf->cur_altsetting->desc.bInterfaceNumber);
> -- 

I don't think this is the right approach.  We don't want to be adding
such checks everywhere the of_node is used.  A better way might be to
not set of_node at all in the absence of a proper "compatible" string.

Then there's the problem of how to resolve the incompatibility between
the generic USB and Exynos bindings.  One possible fix could be to use
a child node of the controller node to represent the root hub.  Since
the driver currently doesn't work at all if a devicetree has nodes for
USB devices, there should be no compatibility concerns.

-- 
Måns Rullgård
