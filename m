Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6594CC28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 12:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CFA6206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 12:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559738416;
	bh=qdAUBbULazBNhStl1AcZ7Kv55Zf3/V9JNzSigkm1w7M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YzUsIXtpZKfp8gSQKiZwXgZgT8WknkEQf6eHkBoaYiC7lqqhqeqEW1nMSAH8kEnYu
	 FioRz7BkIwjuSGNSNm2iYZFxQugid/zqBmSC2QOLJ3ilxTuIUscVtnpN1shj9umywo
	 yiHA5b2t+688hxzjchJi10Pow+hdbiGY2aslMu6c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbfFEMkP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 08:40:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:44494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727273AbfFEMkP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 08:40:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1AE4C206BB;
        Wed,  5 Jun 2019 12:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559738413;
        bh=qdAUBbULazBNhStl1AcZ7Kv55Zf3/V9JNzSigkm1w7M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d+brviXoxz8rR+sa6s+nEnzxEORtvoSYychevSjfk+wLUWBEPtzNRxqQVfhQpZBCH
         nsrd7ag0lwuGki2SLtp21v2dlF9Z/igkVJeTqH1rw1VIBnseo0+90PB5RZLzcWFvBD
         CP24WIcSjTIE83sXdlJ1xmviw6Mu1b5JboF/7eb0=
Date:   Wed, 5 Jun 2019 14:40:11 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Felipe Balbi <felipe.balbi@linux.intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2] USB: move usb debugfs directory creation to the usb
 common core
Message-ID: <20190605124011.GB17558@kroah.com>
References: <20190605092816.GA23758@kroah.com>
 <1559732515.8487.106.camel@mhfsdcap03>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559732515.8487.106.camel@mhfsdcap03>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 05, 2019 at 07:01:55PM +0800, Chunfeng Yun wrote:
> Hi Greg,
> On Wed, 2019-06-05 at 11:28 +0200, Greg Kroah-Hartman wrote:
> > The USB gadget subsystem wants to use the USB debugfs root directory, so
> > move it to the common "core" USB code so that it is properly initialized
> > and removed as needed.
> > 
> > In order to properly do this, we need to load the common code before the
> > usb core code, when everything is linked into the kernel, so reorder the
> > link order of the code.
> > 
> > Also as the usb common code has the possibility of the led trigger logic
> > to be merged into it, handle the build option properly by only having
> > one module init/exit function and have the common code initialize the
> > led trigger if needed.
> > 
> > Reported-by: From: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > Cc: Felipe Balbi <felipe.balbi@linux.intel.com>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> > 
> > Chunfeng, can you test this version to verify it works for you when
> > building the code into the kernel?
> > 
> > v2: handle led common code link error reported by kbuild
> >     handle subsys_initcall issue pointed out by Chunfeng
> > 
> >  drivers/usb/Makefile        |  3 +--
> >  drivers/usb/common/common.c | 21 +++++++++++++++++++++
> >  drivers/usb/common/common.h | 14 ++++++++++++++
> >  drivers/usb/common/led.c    |  9 +++------
> >  drivers/usb/core/usb.c      | 10 ++++------
> >  5 files changed, 43 insertions(+), 14 deletions(-)
> >  create mode 100644 drivers/usb/common/common.h
> > 
> > diff --git a/drivers/usb/Makefile b/drivers/usb/Makefile
> > index 7d1b8c82b208..ecc2de1ffaae 100644
> > --- a/drivers/usb/Makefile
> > +++ b/drivers/usb/Makefile
> > @@ -5,6 +5,7 @@
> >  
> >  # Object files in subdirectories
> >  
> > +obj-$(CONFIG_USB_COMMON)	+= common/
> >  obj-$(CONFIG_USB)		+= core/
> >  obj-$(CONFIG_USB_SUPPORT)	+= phy/
> >  
> > @@ -60,8 +61,6 @@ obj-$(CONFIG_USB_CHIPIDEA)	+= chipidea/
> >  obj-$(CONFIG_USB_RENESAS_USBHS)	+= renesas_usbhs/
> >  obj-$(CONFIG_USB_GADGET)	+= gadget/
> >  
> > -obj-$(CONFIG_USB_COMMON)	+= common/
> > -
> >  obj-$(CONFIG_USBIP_CORE)	+= usbip/
> >  
> >  obj-$(CONFIG_TYPEC)		+= typec/
> > diff --git a/drivers/usb/common/common.c b/drivers/usb/common/common.c
> > index 18f5dcf58b0d..84a4423aaddf 100644
> > --- a/drivers/usb/common/common.c
> > +++ b/drivers/usb/common/common.c
> > @@ -15,6 +15,8 @@
> >  #include <linux/usb/of.h>
> >  #include <linux/usb/otg.h>
> >  #include <linux/of_platform.h>
> > +#include <linux/debugfs.h>
> > +#include "common.h"
> >  
> >  static const char *const ep_type_names[] = {
> >  	[USB_ENDPOINT_XFER_CONTROL] = "ctrl",
> > @@ -291,4 +293,23 @@ struct device *usb_of_get_companion_dev(struct device *dev)
> >  EXPORT_SYMBOL_GPL(usb_of_get_companion_dev);
> >  #endif
> >  
> > +struct dentry *usb_debug_root;
> > +EXPORT_SYMBOL_GPL(usb_debug_root);
> > +
> > +static int usb_common_init(void)
> > +{
> > +	usb_debug_root = debugfs_create_dir("usb", NULL);
> > +	ledtrig_usb_init();
> > +	return 0;
> > +}
> > +
> > +static void usb_common_exit(void)
> > +{
> > +	ledtrig_usb_exit();
> > +	debugfs_remove_recursive(usb_debug_root);
> > +}
> > +
> When enable CONFIG_LED_TRIGGER, there is a warning
> 
>  MODPOST vmlinux.o
> WARNING: vmlinux.o(.text+0x68e300): Section mismatch in reference from
> the function usb_common_init() to the
> function .init.text:ledtrig_usb_init()
> The function usb_common_init() references
> the function __init ledtrig_usb_init().
> This is often because usb_common_init lacks a __init
> annotation or the annotation of ledtrig_usb_init is wrong.
> 
> WARNING: vmlinux.o(.text+0x68e318): Section mismatch in reference from
> the function usb_common_exit() to the
> function .exit.text:ledtrig_usb_exit()
> The function usb_common_exit() references a function in an exit section.
> Often the function ledtrig_usb_exit() has valid usage outside the exit
> section
> and the fix is to remove the __exit annotation of ledtrig_usb_exit.
> 
> seems need add __init and __exit for usb_common_init/exit

Yes, you are right, I'll go add those markings to those functions, good
catch.

greg k-h
