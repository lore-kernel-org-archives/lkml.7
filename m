Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B84D5C46460
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 08:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92D54206B8
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 08:37:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbfFEIhR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 04:37:17 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:8564 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726777AbfFEIhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 04:37:16 -0400
X-UUID: a9760f9322f44717a95caaf2b6654d0c-20190605
X-UUID: a9760f9322f44717a95caaf2b6654d0c-20190605
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 447371291; Wed, 05 Jun 2019 16:37:10 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 5 Jun
 2019 16:37:08 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 5 Jun 2019 16:37:08 +0800
Message-ID: <1559723828.8487.103.camel@mhfsdcap03>
Subject: Re: [PATCH] USB: move usb debugfs directory creation to the usb
 common core
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Felipe Balbi <felipe.balbi@linux.intel.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Wed, 5 Jun 2019 16:37:08 +0800
In-Reply-To: <871s08ebjn.fsf@linux.intel.com>
References: <20190604093258.GB30054@kroah.com>
         <87tvd5illh.fsf@linux.intel.com> <20190604124349.GA10203@kroah.com>
         <871s08ebjn.fsf@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-06-05 at 10:28 +0300, Felipe Balbi wrote:
> Hi,
> 
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> >> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> >> > diff --git a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
> >> > index 7fcb9f782931..f3d6b1ab80cb 100644
> >> > --- a/drivers/usb/core/usb.c
> >> > +++ b/drivers/usb/core/usb.c
> >> > @@ -1185,19 +1185,17 @@ static struct notifier_block usb_bus_nb = {
> >> >  	.notifier_call = usb_bus_notify,
> >> >  };
> >> >  
> >> > -struct dentry *usb_debug_root;
> >> > -EXPORT_SYMBOL_GPL(usb_debug_root);
> >> > +static struct dentry *usb_devices_root;
> >> >  
> >> >  static void usb_debugfs_init(void)
> >> >  {
> >> > -	usb_debug_root = debugfs_create_dir("usb", NULL);
> >> > -	debugfs_create_file("devices", 0444, usb_debug_root, NULL,
> >> > -			    &usbfs_devices_fops);
> >> > +	usb_devices_root = debugfs_create_file("devices", 0444, usb_debug_root,
> >> 
> >> don't we have a race now? Can usbcore ever probe before usb common?
> >
> > How can that happen if usb_debug_root is in usb common?  The module
> > loader will not let that happen.  Or it shouldn't :)
> 
> argh, indeed. The very fact that usbcore tries to resolve usb_debug_root
> already forces a dependency :-p
When build as module, usbcore depend on usb-common, but when buildin,
usbcore init before usb-common (use module_init)

> 


