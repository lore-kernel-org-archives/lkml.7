Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2726C46470
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 07:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A23C82553D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 07:31:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbfE3Hbu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 03:31:50 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:5027 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726027AbfE3Hbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 03:31:50 -0400
X-UUID: b68e1545f7d44cc9bb1f86ad0f0b3d3b-20190530
X-UUID: b68e1545f7d44cc9bb1f86ad0f0b3d3b-20190530
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1253275830; Thu, 30 May 2019 15:31:40 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 30 May
 2019 15:31:39 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 30 May 2019 15:31:39 +0800
Message-ID: <1559201499.8487.40.camel@mhfsdcap03>
Subject: Re: [v3 PATCH] usb: create usb_debug_root for gadget only
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Felipe Balbi <felipe.balbi@linux.intel.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Date:   Thu, 30 May 2019 15:31:39 +0800
In-Reply-To: <87k1ebj8vt.fsf@linux.intel.com>
References: <cffd6d75f69e4d908c8f39b8a60ddae27d6b7c88.1559028752.git.chunfeng.yun@mediatek.com>
         <87k1ebj8vt.fsf@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Felipe,
On Tue, 2019-05-28 at 11:11 +0300, Felipe Balbi wrote:
> Hi,
> 
> Chunfeng Yun <chunfeng.yun@mediatek.com> writes:
> > diff --git a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
> > index 7fcb9f782931..88b3ee03a12d 100644
> > --- a/drivers/usb/core/usb.c
> > +++ b/drivers/usb/core/usb.c
> > @@ -1190,7 +1190,7 @@ EXPORT_SYMBOL_GPL(usb_debug_root);
> >  
> >  static void usb_debugfs_init(void)
> >  {
> > -	usb_debug_root = debugfs_create_dir("usb", NULL);
> > +	usb_debug_root = debugfs_create_dir(USB_DEBUG_ROOT_NAME, NULL);
> >  	debugfs_create_file("devices", 0444, usb_debug_root, NULL,
> >  			    &usbfs_devices_fops);
> >  }
> 
> might be a better idea to move this to usb common. Then have a function
> which can be called by both host and gadget to maybe create the
> directory:
> 
> static struct dentry *usb_debug_root;
> 
> struct dentry *usb_debugfs_init(void)
> {
> 	if (!usb_debug_root)
>         	usb_debug_root = debugfs_create_dir("usb", NULL);
> 
> 	return usb_debug_root;
> }
> 
> 
> Then usb core would be updated to something like:
> 
> static void usb_core_debugfs_init(void)
> {
> 	struct dentry *root = usb_debugfs_init();
> 
> 	debugfs_create_file("devices", 0444, root, NULL, &usbfs_devices_fops);
> }
> 
I find a problem when move usb_debugfs_init() and usb_debugfs_cleanup()
into usb common, it's easy to create "usb" directory, but difficult to
cleanup it:

common/common.c

struct dentry *usb_debugfs_init(void)
{
    if (!usb_debug_root)
        usb_debug_root = debugfs_create_dir("usb", NULL);

    return usb_debug_root;
}

void usb_debugfs_cleanup(void)
{
    debugfs_remove_recursive(usb_debug_root);
    usb_debug_root = NULL;
}

core/usb.c

static void usb_core_debugfs_init(void)
{
    struct dentry *root = usb_debugfs_init();

    debugfs_create_file("devices", 0444, root, NULL,
&usbfs_devices_fops);
}

static int __init usb_init(void)
{
    ...
    usb_core_debugfs_init();
    ...
}

static void __exit usb_exit(void)
{
    ...
    usb_debugfs_cleanup();
    // will be error, gadget may use it.
    ...
}

gadget/udc/core.c

static int __init usb_udc_init(void)
{
    ...
    usb_debugfs_init();
    ...
}

static void __exit usb_udc_exit(void)
{
    ...
    usb_debugfs_cleanup();
    // can't cleanup in fact, usb core may use it.
}

How to handle this case? introduce a reference count? do you have any
suggestion?

Thanks a lot





