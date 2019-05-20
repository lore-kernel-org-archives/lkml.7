Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E01BBC04AB4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 02:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3D4C2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 02:39:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730113AbfETCjT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 May 2019 22:39:19 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:35115 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727720AbfETCjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 May 2019 22:39:19 -0400
X-UUID: e9d19da9f5d54130adf050cc20d5151b-20190520
X-UUID: e9d19da9f5d54130adf050cc20d5151b-20190520
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 849597756; Mon, 20 May 2019 10:39:15 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 20 May
 2019 10:39:13 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 20 May 2019 10:39:11 +0800
Message-ID: <1558319951.10179.352.camel@mhfsdcap03>
Subject: Re: [PATCH v5 4/6] usb: roles: add API to get usb_role_switch by
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
        Min Guo <min.guo@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Biju Das <biju.das@bp.renesas.com>,
        Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 20 May 2019 10:39:11 +0800
In-Reply-To: <20190517130511.GA1887@kuha.fi.intel.com>
References: <1557823643-8616-1-git-send-email-chunfeng.yun@mediatek.com>
         <1557823643-8616-5-git-send-email-chunfeng.yun@mediatek.com>
         <20190517103736.GA1490@kuha.fi.intel.com>
         <20190517130511.GA1887@kuha.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Fri, 2019-05-17 at 16:05 +0300, Heikki Krogerus wrote:
> Hi,
> 
> On Fri, May 17, 2019 at 01:37:36PM +0300, Heikki Krogerus wrote:
> > On Tue, May 14, 2019 at 04:47:21PM +0800, Chunfeng Yun wrote:
> > > Add fwnode_usb_role_switch_get() to make easier to get
> > > usb_role_switch by fwnode which register it.
> > > It's useful when there is not device_connection registered
> > > between two drivers and only knows the fwnode which register
> > > usb_role_switch.
> > > 
> > > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > > Tested-by: Biju Das <biju.das@bp.renesas.com>
> > 
> > Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> 
> Hold on. I just noticed Rob's comment on patch 2/6, where he points out
> that you don't need to use device graph since the controller is the
> parent of the connector. Doesn't that mean you don't really need this
> API?
No, I still need it. 
The change is about the way how to get fwnode;
when use device graph, get fwnode by of_graph_get_remote_node();
but now will get fwnode by of_get_parent();

> 
> > > ---
> > > v5 changes:
> > >  1. remove linux/of.h suggested by Biju
> > >  2. add tested by Biju
> > > 
> > > Note: still depends on [1]
> > >  [1]: [v6,08/13] usb: roles: Introduce stubs for the exiting functions in role.h
> > >       https://patchwork.kernel.org/patch/10909971/
> > > 
> > > v4 changes:
> > >   1. use switch_fwnode_match() to find fwnode suggested by Heikki
> > >   2. this patch now depends on [1]
> > > 
> > >  [1] [v6,08/13] usb: roles: Introduce stubs for the exiting functions in role.h
> > >     https://patchwork.kernel.org/patch/10909971/
> > > 
> > > v3 changes:
> > >   1. use fwnodes instead of node suggested by Andy
> > >   2. rebuild the API suggested by Heikki
> > > 
> > > v2 no changes
> > > ---
> > >  drivers/usb/roles/class.c | 24 ++++++++++++++++++++++++
> > >  include/linux/usb/role.h  |  8 ++++++++
> > >  2 files changed, 32 insertions(+)
> > > 
> > > diff --git a/drivers/usb/roles/class.c b/drivers/usb/roles/class.c
> > > index f45d8df5cfb8..4a1f09a41ec0 100644
> > > --- a/drivers/usb/roles/class.c
> > > +++ b/drivers/usb/roles/class.c
> > > @@ -135,6 +135,30 @@ struct usb_role_switch *usb_role_switch_get(struct device *dev)
> > >  }
> > >  EXPORT_SYMBOL_GPL(usb_role_switch_get);
> > >  
> > > +/**
> > > + * fwnode_usb_role_switch_get - Find USB role switch by it's parent fwnode
> > > + * @fwnode: The fwnode that register USB role switch
> > > + *
> > > + * Finds and returns role switch registered by @fwnode. The reference count
> > > + * for the found switch is incremented.
> > > + */
> > > +struct usb_role_switch *
> > > +fwnode_usb_role_switch_get(struct fwnode_handle *fwnode)
> > > +{
> > > +	struct usb_role_switch *sw;
> > > +	struct device *dev;
> > > +
> > > +	dev = class_find_device(role_class, NULL, fwnode, switch_fwnode_match);
> > > +	if (!dev)
> > > +		return ERR_PTR(-EPROBE_DEFER);
> > > +
> > > +	sw = to_role_switch(dev);
> > > +	WARN_ON(!try_module_get(sw->dev.parent->driver->owner));
> > > +
> > > +	return sw;
> > > +}
> > > +EXPORT_SYMBOL_GPL(fwnode_usb_role_switch_get);
> 
> This function only basically converts the fwnode to usb_role_switch,
> but I would actually prefer that we walked through the device graph
> here instead of expecting the caller to do that.
> 
> So this function should probable be called fwnode_to_usb_role_switch()
> and not fwnode_usb_role_switch_get(), but I guess you don't need it
> at all, right?
> 
> 
> thanks,
> 


