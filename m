Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D7B2C282DE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 08:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60CAB20866
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 08:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559724740;
	bh=33U2EKfjRS7h+XMGkmD3adAxfr6fGPYO5U7ZjaS/GaY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=G1IIZZ9ZWB7TVV/8jrVeIGK7nwUKSwTcXoOCzP4JHKtWCqBZ50cCdr6BfZvNPOumq
	 CW2j8gyLOO4P+1XxTIdTNUdySsx7TikJcgODj18ILJ3Q8C59cFND40hpZcD/2+PZWh
	 2EHL1JqzumwFatwk3lvV3ogywprWC6xW564qWcuQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfFEIwT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 04:52:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:57048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726690AbfFEIwT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 04:52:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01A322075C;
        Wed,  5 Jun 2019 08:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559724738;
        bh=33U2EKfjRS7h+XMGkmD3adAxfr6fGPYO5U7ZjaS/GaY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jg8LNDdI0PoUYPg/zVrHza4ANwwsNV4xpyvG90wnOrXz6LjtnDwRiaa5W+ti7SflB
         7ATBvjKJU2WdvbuNwRTWRQPx0hbf1OrcQiHrmNoWTdDl+jVvYwWMzvNGvfBN/4HMx2
         44ObQkLWTyjt8JccrcHrk/wdy3CfHRaHp+UMDTTo=
Date:   Wed, 5 Jun 2019 10:52:16 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Felipe Balbi <felipe.balbi@linux.intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] USB: move usb debugfs directory creation to the usb
 common core
Message-ID: <20190605085216.GB26984@kroah.com>
References: <20190604093258.GB30054@kroah.com>
 <20190604115919.GA24346@kroah.com>
 <1559721031.8487.99.camel@mhfsdcap03>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559721031.8487.99.camel@mhfsdcap03>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 05, 2019 at 03:50:31PM +0800, Chunfeng Yun wrote:
> On Tue, 2019-06-04 at 13:59 +0200, Greg Kroah-Hartman wrote:
> > On Tue, Jun 04, 2019 at 11:32:58AM +0200, Greg Kroah-Hartman wrote:
> > > The USB gadget subsystem wants to use the USB debugfs root directory, so
> > > move it to the common "core" USB code so that it is properly initialized
> > > and removed as needed.
> > > 
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > 
> > > ---
> > > 
> > > This should be the "correct" version of this, Chunfeng, can you test
> > > this to verify it works for you?
> > > 
> > > 
> > > diff --git a/drivers/usb/common/common.c b/drivers/usb/common/common.c
> > > index 18f5dcf58b0d..3b5e4263ffef 100644
> > > --- a/drivers/usb/common/common.c
> > > +++ b/drivers/usb/common/common.c
> > > @@ -15,6 +15,7 @@
> > >  #include <linux/usb/of.h>
> > >  #include <linux/usb/otg.h>
> > >  #include <linux/of_platform.h>
> > > +#include <linux/debugfs.h>
> > >  
> > >  static const char *const ep_type_names[] = {
> > >  	[USB_ENDPOINT_XFER_CONTROL] = "ctrl",
> > > @@ -291,4 +292,21 @@ struct device *usb_of_get_companion_dev(struct device *dev)
> > >  EXPORT_SYMBOL_GPL(usb_of_get_companion_dev);
> > >  #endif
> > >  
> > > +struct dentry *usb_debug_root;
> > > +EXPORT_SYMBOL_GPL(usb_debug_root);
> > > +
> > > +static int usb_common_init(void)
> > > +{
> > > +	usb_debug_root = debugfs_create_dir("usb", NULL);
> > > +	return 0;
> > > +}
> > > +
> > > +static void usb_common_exit(void)
> > > +{
> > > +	debugfs_remove_recursive(usb_debug_root);
> > > +}
> > > +
> > > +module_init(usb_common_init);
> I tested this patch.
> 
> Here use module_init() indeed have a race as Felipe said before.
> usbcore uses subsys_initcall(), and have a higher priority than
> module_init(), so when usbcore tries to create "devices" file,
> usb_debug_root is not created.

Ah, let me fix that, it should have the same init level and I'll ensure
it comes first in the linking.

> after I replace it by postcore_initcall() (debugfs uses
> core_initcall()), test two cases:
> 
> 1. buildin usbcore/udc-core
> 
>     "usb" directory is created, and usb/devices file is also created by
> usbcore
> 
> 2. build both usbcore and gadget as ko
> 
>     usbcore.ko, udc-core.ko and usb-common.ko are created. 
> 
>    2.1 
>        insmod usb-common.ko   // "usb" directory is created
>        insmod usb-core.ko   // usb/devices file is created
> 
>    2.2
>        rmmod usb-common.ko  // failed, usb_common is in use by usb-core
> 
>    2.3 
>        rmmod usb-core.ko   // usb/devices file is destroyed
>        rmmod usb-common.ko  // usb directory is destroyed
> 
>    2.4 
>        insmod usb-common.ko   // "usb" directory is created
>        insmod udc-core.ko
> 
>    2.5
>        rmmod usb-common.ko  // failed, usb_common is in use by udc-core
> 
>    2.6 
>        rmmod udc-core.ko
>        rmmod usb-common.ko  // usb directory is destroyed
> 
> they are all in line with expectations

Wonderful!

Let me fix up the init level, and the build issue tha kbuild found, and
post a v2 patch.

thanks,

greg k-h
