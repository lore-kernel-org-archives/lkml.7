Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7DB5C10F11
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 03:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D81421850
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 03:11:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbfDKDLZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 23:11:25 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:19919 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726247AbfDKDLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 23:11:24 -0400
X-UUID: fe850397add14cafb76e7970b5182ae8-20190411
X-UUID: fe850397add14cafb76e7970b5182ae8-20190411
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1926004032; Thu, 11 Apr 2019 11:11:12 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 11 Apr
 2019 11:11:10 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 11 Apr 2019 11:11:09 +0800
Message-ID: <1554952269.10179.185.camel@mhfsdcap03>
Subject: Re: [v3 PATCH 4/6] usb: roles: add API to get usb_role_switch by
 node
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Li Jun <jun.li@nxp.com>,
        "Badhri Jagan Sridharan" <badhri@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Min Guo <min.guo@mediatek.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Thu, 11 Apr 2019 11:11:09 +0800
In-Reply-To: <20190410102239.GG20058@kuha.fi.intel.com>
References: <1554257354-7440-1-git-send-email-chunfeng.yun@mediatek.com>
         <1554257354-7440-5-git-send-email-chunfeng.yun@mediatek.com>
         <20190410102239.GG20058@kuha.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-04-10 at 13:22 +0300, Heikki Krogerus wrote:
> On Wed, Apr 03, 2019 at 10:09:12AM +0800, Chunfeng Yun wrote:
> > Add fwnode_usb_role_switch_get() to make easier to get
> > usb_role_switch by fwnode which register it.
> > It's useful when there is not device_connection registered
> > between two drivers and only knows the fwnode which register
> > usb_role_switch.
> > 
> > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > ---
> > v3 changes:
> >   1. use fwnodes instead of node suggested by Andy
> >   2. rebuild the API suggested by Heikki
> > 
> > v2 no changes
> > ---
> >  drivers/usb/roles/class.c | 31 +++++++++++++++++++++++++++++++
> >  include/linux/usb/role.h  |  2 ++
> >  2 files changed, 33 insertions(+)
> > 
> > diff --git a/drivers/usb/roles/class.c b/drivers/usb/roles/class.c
> > index f45d8df5cfb8..5ecb57f8960b 100644
> > --- a/drivers/usb/roles/class.c
> > +++ b/drivers/usb/roles/class.c
> > @@ -12,6 +12,7 @@
> >  #include <linux/device.h>
> >  #include <linux/module.h>
> >  #include <linux/mutex.h>
> > +#include <linux/of.h>
> >  #include <linux/slab.h>
> >  
> >  static struct class *role_class;
> > @@ -135,6 +136,36 @@ struct usb_role_switch *usb_role_switch_get(struct device *dev)
> >  }
> >  EXPORT_SYMBOL_GPL(usb_role_switch_get);
> >  
> > +static int __switch_match_fwnode(struct device *dev, const void *fwnode)
> > +{
> > +	return dev_fwnode(dev->parent) == (const struct fwnode_handle *)fwnode;
> > +}
> 
> I don't think this is actually needed. 
Yes, you are right

> Why not just assign the
> parent's fwnode for the mux as well?
will do it in next version

> 
> I'll add an example to the patch 6/6 in this series.
> 
> > +/**
> > + * fwnode_usb_role_switch_get - Find USB role switch by it's parent fwnode
> > + * @fwnode: The fwnode that register USB role switch
> > + *
> > + * Finds and returns role switch registered by @fwnode. The reference count
> > + * for the found switch is incremented.
> > + */
> > +struct usb_role_switch *
> > +fwnode_usb_role_switch_get(struct fwnode_handle *fwnode)
> > +{
> > +	struct usb_role_switch *sw;
> > +	struct device *dev;
> > +
> > +	dev = class_find_device(role_class, NULL, fwnode,
> > +				__switch_match_fwnode);
> 
> So here you can then reuse switch_fwnode_match():
> 
> 	dev = class_find_device(role_class, NULL, fwnode, switch_fwnode_match);
I make a fast test, it works, thanks a lot Heikki

> 
> > +	if (!dev)
> > +		return ERR_PTR(-EPROBE_DEFER);
> > +
> > +	sw = to_role_switch(dev);
> > +	WARN_ON(!try_module_get(sw->dev.parent->driver->owner));
> > +
> > +	return sw;
> > +}
> > +EXPORT_SYMBOL_GPL(fwnode_usb_role_switch_get);
> > +
> >  /**
> >   * usb_role_switch_put - Release handle to a switch
> >   * @sw: USB Role Switch
> > diff --git a/include/linux/usb/role.h b/include/linux/usb/role.h
> > index c05ffa6abda9..d21cd55d9e45 100644
> > --- a/include/linux/usb/role.h
> > +++ b/include/linux/usb/role.h
> > @@ -46,6 +46,8 @@ int usb_role_switch_set_role(struct usb_role_switch *sw, enum usb_role role);
> >  enum usb_role usb_role_switch_get_role(struct usb_role_switch *sw);
> >  struct usb_role_switch *usb_role_switch_get(struct device *dev);
> >  void usb_role_switch_put(struct usb_role_switch *sw);
> > +struct usb_role_switch *
> > +fwnode_usb_role_switch_get(struct fwnode_handle *fwnode);
> >  
> >  struct usb_role_switch *
> >  usb_role_switch_register(struct device *parent,
> > -- 
> > 2.20.1
> 
> thanks,
> 


