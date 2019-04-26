Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A75C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 07:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 893EC206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 07:16:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726013AbfDZHQq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 03:16:46 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:5904 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725893AbfDZHQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 03:16:46 -0400
X-UUID: e68ea29a041c48dba8209f091923ef2b-20190426
X-UUID: e68ea29a041c48dba8209f091923ef2b-20190426
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 635092751; Fri, 26 Apr 2019 15:16:38 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 26 Apr
 2019 15:16:36 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 26 Apr 2019 15:16:35 +0800
Message-ID: <1556262995.10179.209.camel@mhfsdcap03>
Subject: RE: [PATCH v4 4/6] usb: roles: add API to get usb_role_switch by
 node
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Biju Das <biju.das@bp.renesas.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Li Jun <jun.li@nxp.com>,
        "Badhri Jagan Sridharan" <badhri@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Min Guo <min.guo@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 26 Apr 2019 15:16:35 +0800
In-Reply-To: <OSBPR01MB210350ED8C36423BBF4A8FDFB83E0@OSBPR01MB2103.jpnprd01.prod.outlook.com>
References: <1556261237-13823-1-git-send-email-chunfeng.yun@mediatek.com>
         <1556261237-13823-5-git-send-email-chunfeng.yun@mediatek.com>
         <OSBPR01MB210350ED8C36423BBF4A8FDFB83E0@OSBPR01MB2103.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Biju,
On Fri, 2019-04-26 at 07:02 +0000, Biju Das wrote:
> Hi Chunfeng Yun,
> 
> Thanks for the patch.
> 
> > Subject: [PATCH v4 4/6] usb: roles: add API to get usb_role_switch by node
> > 
> > Add fwnode_usb_role_switch_get() to make easier to get usb_role_switch
> > by fwnode which register it.
> > It's useful when there is not device_connection registered between two
> > drivers and only knows the fwnode which register usb_role_switch.
> > 
> > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> Tested-by: Biju Das <biju.das@bp.renesas.com>
> > ---
> > v4 changes:
> >   1. use switch_fwnode_match() to find fwnode suggested by Heikki
> >   2. this patch now depends on [1]
> > 
> >  [1] [v6,08/13] usb: roles: Introduce stubs for the exiting functions in role.h
> >     https://patchwork.kernel.org/patch/10909971/
> > 
> > v3 changes:
> >   1. use fwnodes instead of node suggested by Andy
> >   2. rebuild the API suggested by Heikki
> > 
> > v2 no changes
> > ---
> >  drivers/usb/roles/class.c | 25 +++++++++++++++++++++++++
> > include/linux/usb/role.h  |  8 ++++++++
> >  2 files changed, 33 insertions(+)
> > 
> > diff --git a/drivers/usb/roles/class.c b/drivers/usb/roles/class.c index
> > f45d8df5cfb8..994fcb979795 100644
> > --- a/drivers/usb/roles/class.c
> > +++ b/drivers/usb/roles/class.c
> > @@ -12,6 +12,7 @@
> >  #include <linux/device.h>
> >  #include <linux/module.h>
> >  #include <linux/mutex.h>
> > +#include <linux/of.h>
> 
> Is it required?
Forgot to remove it after using fwnode instead of node, will remove it
in next version

Thanks a lot

> 
> >  #include <linux/slab.h>
> > 
> >  static struct class *role_class;
> > @@ -135,6 +136,30 @@ struct usb_role_switch *usb_role_switch_get(struct
> > device *dev)  }  EXPORT_SYMBOL_GPL(usb_role_switch_get);
> > 
> > +/**
> > + * fwnode_usb_role_switch_get - Find USB role switch by it's parent
> > +fwnode
> > + * @fwnode: The fwnode that register USB role switch
> > + *
> > + * Finds and returns role switch registered by @fwnode. The reference
> > +count
> > + * for the found switch is incremented.
> > + */
> > +struct usb_role_switch *
> > +fwnode_usb_role_switch_get(struct fwnode_handle *fwnode) {
> > +	struct usb_role_switch *sw;
> > +	struct device *dev;
> > +
> > +	dev = class_find_device(role_class, NULL, fwnode,
> > switch_fwnode_match);
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
> > diff --git a/include/linux/usb/role.h b/include/linux/usb/role.h index
> > da2b9641b877..35d460f9ec40 100644
> > --- a/include/linux/usb/role.h
> > +++ b/include/linux/usb/role.h
> > @@ -48,6 +48,8 @@ int usb_role_switch_set_role(struct usb_role_switch
> > *sw, enum usb_role role);  enum usb_role usb_role_switch_get_role(struct
> > usb_role_switch *sw);  struct usb_role_switch *c(struct
> > device *dev);  void usb_role_switch_put(struct usb_role_switch *sw);
> > +struct usb_role_switch *
> > +fwnode_usb_role_switch_get(struct fwnode_handle *fwnode);
> 
> >  struct usb_role_switch *
> >  usb_role_switch_register(struct device *parent, @@ -72,6 +74,12 @@ static
> > inline struct usb_role_switch *usb_role_switch_get(struct device *dev)
> > 
> >  static inline void usb_role_switch_put(struct usb_role_switch *sw) { }
> > 
> > +static inline struct usb_role_switch *
> > +fwnode_usb_role_switch_get(struct fwnode_handle *fwnode) {
> > +	return ERR_PTR(-ENODEV);
> > +}
> > +
> 
> >  static inline struct usb_role_switch *
> >  usb_role_switch_register(struct device *parent,
> >  			 const struct usb_role_switch_desc *desc)
> > --
> > 2.21.0
> 


