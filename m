Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5AF6C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 09:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97BA223A61
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 09:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559639687;
	bh=jRInVvoH/Jp1WAAgsg3CtkKKgWZbOrkmzFm+ATVyo4g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SsZk7dTgdmSoBOfAUhNX8AhNSnalJNcYDZa4kOwhoOIGkcy39y8Z9HU2dRpMTdFhI
	 PyoCqGATz/xXmAlKUR6cshk6VXNm2907xmcHAU7bOtsYCmwcWa3aQs4PmO1X89faFr
	 /mZ5bf3GxMo+Mk39vdzuTKxfylPdMEuPJL85k+d0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbfFDJOr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 05:14:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:48704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726948AbfFDJOq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 05:14:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4270D21976;
        Tue,  4 Jun 2019 09:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559639685;
        bh=jRInVvoH/Jp1WAAgsg3CtkKKgWZbOrkmzFm+ATVyo4g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ItT/JG4j7Zw1Qmygon0KfYYZbV5gsZ0jmQm7Wq34OweZyE9lEUG9ikxPolTdHn/6+
         z3COdTJE5fN+MdHQ3HW4VnNmQ7yWQdfWxapfzxMzMiiHjO+WKC1SIku9tlhVJWgcPh
         Qft/vN8ZHEvD9vPc2rBKJyRY4xZRXicaqJKcbeQk=
Date:   Tue, 4 Jun 2019 11:14:43 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Felipe Balbi <felipe.balbi@linux.intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v4] usb: create usb_debug_root for gadget only
Message-ID: <20190604091443.GA458@kroah.com>
References: <1559633647-29040-1-git-send-email-chunfeng.yun@mediatek.com>
 <20190604073706.GA25045@kroah.com>
 <1559638754.8487.71.camel@mhfsdcap03>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559638754.8487.71.camel@mhfsdcap03>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04, 2019 at 04:59:14PM +0800, Chunfeng Yun wrote:
> On Tue, 2019-06-04 at 09:37 +0200, Greg Kroah-Hartman wrote:
> > On Tue, Jun 04, 2019 at 03:34:07PM +0800, Chunfeng Yun wrote:
> > > When CONFIG_USB is not set, and CONFIG_USB_GADGET is set,
> > > there is an issue, e.g.:
> > > 
> > > drivers/usb/mtu3/mtu3_debugfs.o: in function 'ssusb_debugfs_create_root':
> > > mtu3_debugfs.c:(.text+0xba3): undefined reference to 'usb_debug_root'
> > > 
> > > usb_debug_root is currently only built when host is supported
> > > (CONFIG_USB is set), for convenience, we also want it created when
> > > gadget only is enabled, this patch try to support it.
> > > 
> > > Reported-by: Randy Dunlap <rdunlap@infradead.org>
> > > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > > ---
> > > v4:
> > >   move common API into common.c suggested by Felipe
> > > 
> > > v3:
> > >   1. still create usb_debug_root for gadget only
> > >   2. abandon mtu3's change
> > >   3. drop acked-by Randy
> > > 
> > > v2(resend): add acked-by Randy
> > > 
> > > v1: fix mtu3's build error, replace usb_debug_root by NULL;
> > > ---
> > >  drivers/usb/common/common.c   | 26 ++++++++++++++++++++++++++
> > >  drivers/usb/core/usb.c        | 16 ++++------------
> > >  drivers/usb/gadget/udc/core.c |  3 +++
> > >  include/linux/usb.h           |  2 ++
> > >  4 files changed, 35 insertions(+), 12 deletions(-)
> > > 
> > > diff --git a/drivers/usb/common/common.c b/drivers/usb/common/common.c
> > > index 18f5dcf58b0d..c52e9c9f58ec 100644
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
> > > @@ -139,6 +140,31 @@ enum usb_dr_mode usb_get_dr_mode(struct device *dev)
> > >  }
> > >  EXPORT_SYMBOL_GPL(usb_get_dr_mode);
> > >  
> > > +struct dentry *usb_debug_root;
> > > +EXPORT_SYMBOL_GPL(usb_debug_root);
> > > +
> > > +static atomic_t usb_debug_root_refcnt = ATOMIC_INIT(0);
> > 
> > Ick, no.
> > 
> > > +
> > > +struct dentry *usb_debugfs_init(void)
> > > +{
> > > +	if (!usb_debug_root)
> > > +		usb_debug_root = debugfs_create_dir("usb", NULL);
> > > +
> > > +	atomic_inc(&usb_debug_root_refcnt);
> > > +
> > > +	return usb_debug_root;
> > > +}
> > > +EXPORT_SYMBOL_GPL(usb_debugfs_init);
> > > +
> > > +void usb_debugfs_cleanup(void)
> > > +{
> > > +	if (atomic_dec_and_test(&usb_debug_root_refcnt)) {
> > > +		debugfs_remove_recursive(usb_debug_root);
> > > +		usb_debug_root = NULL;
> > > +	}
> > > +}
> > > +EXPORT_SYMBOL_GPL(usb_debugfs_cleanup);
> > 
> > Only remove the debugfs subdir if the usbcore module is removed. 
> Both usbcore module and gadget module will use this "usb" subdir now.
> Gadget module may still use it when remove usbcore module.

Did you try to remove the usb-common module with the udc gadget module
remaining loaded with this change in place?  I think you will find that
it is impossible given that the udc gadget module now depends on a
symbol in the usb-common code.

So again, just use the module reference counting logic to drive this
functionality, don't create an atomic variable that duplicates the
logic we already have in place today.

thanks,

greg k-h
