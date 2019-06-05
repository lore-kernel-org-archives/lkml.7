Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C56AC282DE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 07:50:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6953920866
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 07:50:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbfFEHuj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 03:50:39 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:48125 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725294AbfFEHuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 03:50:39 -0400
X-UUID: 3bcae11531cc4d9c8364f18a8d0872fc-20190605
X-UUID: 3bcae11531cc4d9c8364f18a8d0872fc-20190605
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1696416894; Wed, 05 Jun 2019 15:50:33 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 5 Jun
 2019 15:50:32 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 5 Jun 2019 15:50:31 +0800
Message-ID: <1559721031.8487.99.camel@mhfsdcap03>
Subject: Re: [PATCH] USB: move usb debugfs directory creation to the usb
 common core
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Felipe Balbi <felipe.balbi@linux.intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Wed, 5 Jun 2019 15:50:31 +0800
In-Reply-To: <20190604115919.GA24346@kroah.com>
References: <20190604093258.GB30054@kroah.com>
         <20190604115919.GA24346@kroah.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-06-04 at 13:59 +0200, Greg Kroah-Hartman wrote:
> On Tue, Jun 04, 2019 at 11:32:58AM +0200, Greg Kroah-Hartman wrote:
> > The USB gadget subsystem wants to use the USB debugfs root directory, so
> > move it to the common "core" USB code so that it is properly initialized
> > and removed as needed.
> > 
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > 
> > ---
> > 
> > This should be the "correct" version of this, Chunfeng, can you test
> > this to verify it works for you?
> > 
> > 
> > diff --git a/drivers/usb/common/common.c b/drivers/usb/common/common.c
> > index 18f5dcf58b0d..3b5e4263ffef 100644
> > --- a/drivers/usb/common/common.c
> > +++ b/drivers/usb/common/common.c
> > @@ -15,6 +15,7 @@
> >  #include <linux/usb/of.h>
> >  #include <linux/usb/otg.h>
> >  #include <linux/of_platform.h>
> > +#include <linux/debugfs.h>
> >  
> >  static const char *const ep_type_names[] = {
> >  	[USB_ENDPOINT_XFER_CONTROL] = "ctrl",
> > @@ -291,4 +292,21 @@ struct device *usb_of_get_companion_dev(struct device *dev)
> >  EXPORT_SYMBOL_GPL(usb_of_get_companion_dev);
> >  #endif
> >  
> > +struct dentry *usb_debug_root;
> > +EXPORT_SYMBOL_GPL(usb_debug_root);
> > +
> > +static int usb_common_init(void)
> > +{
> > +	usb_debug_root = debugfs_create_dir("usb", NULL);
> > +	return 0;
> > +}
> > +
> > +static void usb_common_exit(void)
> > +{
> > +	debugfs_remove_recursive(usb_debug_root);
> > +}
> > +
> > +module_init(usb_common_init);
I tested this patch.

Here use module_init() indeed have a race as Felipe said before.
usbcore uses subsys_initcall(), and have a higher priority than
module_init(), so when usbcore tries to create "devices" file,
usb_debug_root is not created.

after I replace it by postcore_initcall() (debugfs uses
core_initcall()), test two cases:

1. buildin usbcore/udc-core

    "usb" directory is created, and usb/devices file is also created by
usbcore

2. build both usbcore and gadget as ko

    usbcore.ko, udc-core.ko and usb-common.ko are created. 

   2.1 
       insmod usb-common.ko   // "usb" directory is created
       insmod usb-core.ko   // usb/devices file is created

   2.2
       rmmod usb-common.ko  // failed, usb_common is in use by usb-core

   2.3 
       rmmod usb-core.ko   // usb/devices file is destroyed
       rmmod usb-common.ko  // usb directory is destroyed

   2.4 
       insmod usb-common.ko   // "usb" directory is created
       insmod udc-core.ko

   2.5
       rmmod usb-common.ko  // failed, usb_common is in use by udc-core

   2.6 
       rmmod udc-core.ko
       rmmod usb-common.ko  // usb directory is destroyed

they are all in line with expectations


> > +module_exit(usb_common_exit);
> > +
> >  MODULE_LICENSE("GPL");
> > diff --git a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
> > index 7fcb9f782931..f3d6b1ab80cb 100644
> > --- a/drivers/usb/core/usb.c
> > +++ b/drivers/usb/core/usb.c
> > @@ -1185,19 +1185,17 @@ static struct notifier_block usb_bus_nb = {
> >  	.notifier_call = usb_bus_notify,
> >  };
> >  
> > -struct dentry *usb_debug_root;
> > -EXPORT_SYMBOL_GPL(usb_debug_root);
> > +static struct dentry *usb_devices_root;
> >  
> >  static void usb_debugfs_init(void)
> >  {
> > -	usb_debug_root = debugfs_create_dir("usb", NULL);
> > -	debugfs_create_file("devices", 0444, usb_debug_root, NULL,
> > -			    &usbfs_devices_fops);
> > +	usb_devices_root = debugfs_create_file("devices", 0444, usb_debug_root,
> > +					       NULL, &usbfs_devices_fops);
> >  }
> >  
> >  static void usb_debugfs_cleanup(void)
> >  {
> > -	debugfs_remove_recursive(usb_debug_root);
> > +	debugfs_remove_recursive(usb_devices_root);
> 
> That should just be debugfs_remove();
> 
> I'll fix it up after someone tests this :)
> 
> thanks,
> 
> greg k-h


