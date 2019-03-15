Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD302C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 09:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8BA92184C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 09:13:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728701AbfCOJNf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 05:13:35 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:55309 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728585AbfCOJNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 05:13:35 -0400
X-UUID: d383aaa5e3e846b7abdd938ddc4f778f-20190315
X-UUID: d383aaa5e3e846b7abdd938ddc4f778f-20190315
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1329379927; Fri, 15 Mar 2019 17:13:27 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 15 Mar
 2019 17:13:26 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 15 Mar 2019 17:13:24 +0800
Message-ID: <1552641204.10179.133.camel@mhfsdcap03>
Subject: Re: [PATCH v2 4/6] usb: roles: add API to get usb_role_switch by
 node
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
CC:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Li Jun <jun.li@nxp.com>,
        Badhri Jagan Sridharan <badhri@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Min Guo <min.guo@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Fri, 15 Mar 2019 17:13:24 +0800
In-Reply-To: <20190315081835.GD7752@kuha.fi.intel.com>
References: <1552635513-2378-1-git-send-email-chunfeng.yun@mediatek.com>
         <1552635513-2378-5-git-send-email-chunfeng.yun@mediatek.com>
         <20190315081835.GD7752@kuha.fi.intel.com>
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
On Fri, 2019-03-15 at 10:18 +0200, Heikki Krogerus wrote:
> On Fri, Mar 15, 2019 at 03:38:31PM +0800, Chunfeng Yun wrote:
> > Add usb_role_switch_get_by_node() to make easier to get
> > usb_role_switch by node which register it.
> > It's useful when there is not device_connection registered
> > between two drivers and only knows the node which register
> > usb_role_switch.
> > 
> > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > ---
> >  drivers/usb/roles/class.c | 30 ++++++++++++++++++++++++++++++
> >  include/linux/usb/role.h  |  1 +
> >  2 files changed, 31 insertions(+)
> > 
> > diff --git a/drivers/usb/roles/class.c b/drivers/usb/roles/class.c
> > index 99116af07f1d..284b19856dc4 100644
> > --- a/drivers/usb/roles/class.c
> > +++ b/drivers/usb/roles/class.c
> > @@ -11,6 +11,7 @@
> >  #include <linux/device.h>
> >  #include <linux/module.h>
> >  #include <linux/mutex.h>
> > +#include <linux/of.h>
> >  #include <linux/slab.h>
> >  
> >  static struct class *role_class;
> > @@ -121,6 +122,35 @@ struct usb_role_switch *usb_role_switch_get(struct device *dev)
> >  }
> >  EXPORT_SYMBOL_GPL(usb_role_switch_get);
> >  
> > +static int __switch_match_node(struct device *dev, const void *node)
> > +{
> > +	return dev->parent->of_node == (const struct device_node *)node;
> > +}
> 
> Andy already pointed out that you need to use fwnodes.
> 
> Rule of thumb: You always use fwnodes. Only if there is something that
> can't be done with fwnodes you use DT or ACPI nodes directly.
> 
> In this case there is absolutely nothing that would prevent you from
> using fwnodes.
> 
Got it, will fix it in next version.

BTW:

I encounter a build error when CONFIG_USB_ROLE_SWITCH is not enabled,

drivers/usb/mtu3/mtu3_dr.o: In function `ssusb_role_sw_register':
./drivers/usb/mtu3/mtu3_dr.c:460: undefined reference to
`usb_role_switch_register'
drivers/usb/mtu3/mtu3_dr.o: In function `ssusb_otg_switch_exit':
./drivers/usb/mtu3/mtu3_dr.c:491: undefined reference to
`usb_role_switch_unregister'

the following patch has fixed the issue, but seems not get into kernel,
[v3,08/12] usb: roles: Add usb role switch notifier.
https://patchwork.kernel.org/patch/10836525/

What should I do if I add a new API? Thanks

> 
> thanks,
> 


