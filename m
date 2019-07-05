Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B9BAC46499
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 11:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62531218CD
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 11:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562326048;
	bh=LEEDjkG3dbCcARsXiTFH04ZPn/aQjCdDpJ7cBnwl+Q4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EjzkzG+ZWi71whu9ekAs1gofllKy9jLhzfYWHUi4ZVwtYwD2b0CzGh4IYstq1lv8o
	 GEd5AHSlSg0meMdxJYZwfEDzWDaK+cLKqlACbn4m5cmeKEnWma8NfD9dAzwSKxiI+K
	 1FlYGLnibOGK0eKWiX3TtTGzwodzz0Zvx8pwSWuU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728239AbfGEL11 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 07:27:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:39496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727665AbfGEL11 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 07:27:27 -0400
Received: from localhost (83-84-126-242.cable.dynamic.v4.ziggo.nl [83.84.126.242])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 213C021852;
        Fri,  5 Jul 2019 11:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562326046;
        bh=LEEDjkG3dbCcARsXiTFH04ZPn/aQjCdDpJ7cBnwl+Q4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=y9S8zd3NbMt+JeDJsSkAJ/mCX/0WMbBZgI5M4FbdKw8ElHa9kDYTRsY4EqJNDyyNZ
         3L6nFKJiQwuXMbrwCCAHc+6T/krx5xxF+Iagt9S1M3LEih96OI+vnxI5e2Ki4kQrdW
         0uDloP2MvVjihfkVl2pUBHQdjmqVuwaRW0pb94Jk=
Date:   Fri, 5 Jul 2019 13:27:24 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pawel Laszczak <pawell@cadence.com>
Cc:     devicetree@vger.kernel.org, felipe.balbi@linux.intel.com,
        linux-usb@vger.kernel.org, hdegoede@redhat.com,
        heikki.krogerus@linux.intel.com, robh+dt@kernel.org, rogerq@ti.com,
        linux-kernel@vger.kernel.org, jbergsagel@ti.com, nsekhar@ti.com,
        nm@ti.com, sureshp@cadence.com, peter.chen@nxp.com,
        jpawar@cadence.com, kurahul@cadence.com
Subject: Re: [PATCH v9 2/6] usb:gadget Separated decoding functions from dwc3
 driver.
Message-ID: <20190705112724.GA4294@kroah.com>
References: <1562324238-16655-1-git-send-email-pawell@cadence.com>
 <1562324238-16655-3-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1562324238-16655-3-git-send-email-pawell@cadence.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 05, 2019 at 11:57:14AM +0100, Pawel Laszczak wrote:
> Patch moves some decoding functions from driver/usb/dwc3/debug.h driver
> to driver/usb/gadget/debug.c file. These moved functions include:
>     dwc3_decode_get_status
>     dwc3_decode_set_clear_feature
>     dwc3_decode_set_address
>     dwc3_decode_get_set_descriptor
>     dwc3_decode_get_configuration
>     dwc3_decode_set_configuration
>     dwc3_decode_get_intf
>     dwc3_decode_set_intf
>     dwc3_decode_synch_frame
>     dwc3_decode_set_sel
>     dwc3_decode_set_isoch_delay
>     dwc3_decode_ctrl
> 
> These functions are used also in inroduced cdns3 driver.
> 
> All functions prefixes were changed from dwc3 to usb.
> Also, function's parameters has been extended according to the name
> of fields in standard SETUP packet.
> Additionally, patch adds usb_decode_ctrl function to
> include/linux/usb/gadget.h file.

No it does not :(

> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> ---
>  drivers/usb/common/Makefile |   5 +
>  drivers/usb/common/debug.c  | 268 ++++++++++++++++++++++++++++++++++++
>  drivers/usb/dwc3/debug.h    | 252 ---------------------------------
>  drivers/usb/dwc3/trace.h    |   2 +-
>  include/linux/usb/ch9.h     |  25 ++++
>  5 files changed, 299 insertions(+), 253 deletions(-)
>  create mode 100644 drivers/usb/common/debug.c
> 
> diff --git a/drivers/usb/common/Makefile b/drivers/usb/common/Makefile
> index 0a7c45e85481..cdc66b59a6f0 100644
> --- a/drivers/usb/common/Makefile
> +++ b/drivers/usb/common/Makefile
> @@ -5,6 +5,11 @@
>  
>  obj-$(CONFIG_USB_COMMON)	  += usb-common.o
>  usb-common-y			  += common.o
> +
> +ifneq ($(CONFIG_TRACING),)
> +	usb-common-y		  += debug.o
> +endif

So only enable this if tracing is not emabled?  Or if enabled?  I'm
confused, isn't there an easier way to write this?

thanks,

greg k-h
