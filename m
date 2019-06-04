Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED4F8C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 08:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D159C2408B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 08:59:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbfFDI7o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 04:59:44 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:16020 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726809AbfFDI7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 04:59:43 -0400
X-UUID: 1bdeac7911f34a77a95a97ed6e439c8d-20190604
X-UUID: 1bdeac7911f34a77a95a97ed6e439c8d-20190604
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1422628494; Tue, 04 Jun 2019 16:59:16 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS33N1.mediatek.inc
 (172.27.4.75) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 4 Jun
 2019 16:59:15 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 4 Jun 2019 16:59:14 +0800
Message-ID: <1559638754.8487.71.camel@mhfsdcap03>
Subject: Re: [PATCH v4] usb: create usb_debug_root for gadget only
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Felipe Balbi <felipe.balbi@linux.intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Tue, 4 Jun 2019 16:59:14 +0800
In-Reply-To: <20190604073706.GA25045@kroah.com>
References: <1559633647-29040-1-git-send-email-chunfeng.yun@mediatek.com>
         <20190604073706.GA25045@kroah.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-06-04 at 09:37 +0200, Greg Kroah-Hartman wrote:
> On Tue, Jun 04, 2019 at 03:34:07PM +0800, Chunfeng Yun wrote:
> > When CONFIG_USB is not set, and CONFIG_USB_GADGET is set,
> > there is an issue, e.g.:
> > 
> > drivers/usb/mtu3/mtu3_debugfs.o: in function 'ssusb_debugfs_create_root':
> > mtu3_debugfs.c:(.text+0xba3): undefined reference to 'usb_debug_root'
> > 
> > usb_debug_root is currently only built when host is supported
> > (CONFIG_USB is set), for convenience, we also want it created when
> > gadget only is enabled, this patch try to support it.
> > 
> > Reported-by: Randy Dunlap <rdunlap@infradead.org>
> > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > ---
> > v4:
> >   move common API into common.c suggested by Felipe
> > 
> > v3:
> >   1. still create usb_debug_root for gadget only
> >   2. abandon mtu3's change
> >   3. drop acked-by Randy
> > 
> > v2(resend): add acked-by Randy
> > 
> > v1: fix mtu3's build error, replace usb_debug_root by NULL;
> > ---
> >  drivers/usb/common/common.c   | 26 ++++++++++++++++++++++++++
> >  drivers/usb/core/usb.c        | 16 ++++------------
> >  drivers/usb/gadget/udc/core.c |  3 +++
> >  include/linux/usb.h           |  2 ++
> >  4 files changed, 35 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/usb/common/common.c b/drivers/usb/common/common.c
> > index 18f5dcf58b0d..c52e9c9f58ec 100644
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
> > @@ -139,6 +140,31 @@ enum usb_dr_mode usb_get_dr_mode(struct device *dev)
> >  }
> >  EXPORT_SYMBOL_GPL(usb_get_dr_mode);
> >  
> > +struct dentry *usb_debug_root;
> > +EXPORT_SYMBOL_GPL(usb_debug_root);
> > +
> > +static atomic_t usb_debug_root_refcnt = ATOMIC_INIT(0);
> 
> Ick, no.
> 
> > +
> > +struct dentry *usb_debugfs_init(void)
> > +{
> > +	if (!usb_debug_root)
> > +		usb_debug_root = debugfs_create_dir("usb", NULL);
> > +
> > +	atomic_inc(&usb_debug_root_refcnt);
> > +
> > +	return usb_debug_root;
> > +}
> > +EXPORT_SYMBOL_GPL(usb_debugfs_init);
> > +
> > +void usb_debugfs_cleanup(void)
> > +{
> > +	if (atomic_dec_and_test(&usb_debug_root_refcnt)) {
> > +		debugfs_remove_recursive(usb_debug_root);
> > +		usb_debug_root = NULL;
> > +	}
> > +}
> > +EXPORT_SYMBOL_GPL(usb_debugfs_cleanup);
> 
> Only remove the debugfs subdir if the usbcore module is removed. 
Both usbcore module and gadget module will use this "usb" subdir now.
Gadget module may still use it when remove usbcore module.

>  Create
> the debugfs subdir when the usbcore module is loaded.  No need for any
> reference counting of any sort at all.  No need to overthink this :)
> 
> thanks,
> 
> greg k-h


