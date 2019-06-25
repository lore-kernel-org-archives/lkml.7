Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F6E1C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81D9821670
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:55:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731142AbfFYIz5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 04:55:57 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:13548 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730923AbfFYIzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 04:55:55 -0400
X-UUID: 8a407f64fa044f7c9e5ff29f519f0d6e-20190625
X-UUID: 8a407f64fa044f7c9e5ff29f519f0d6e-20190625
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 2075891572; Tue, 25 Jun 2019 16:55:50 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 25 Jun
 2019 16:55:48 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 25 Jun 2019 16:55:47 +0800
Message-ID: <1561452947.32589.25.camel@mhfsdcap03>
Subject: Re: [PATCH v7 09/10] usb: roles: add USB Type-B GPIO connector
 driver
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
        Linus Walleij <linus.walleij@linaro.org>,
        Yu Chen <chenyu56@huawei.com>,
        "Nagarjuna Kristam" <nkristam@nvidia.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
Date:   Tue, 25 Jun 2019 16:55:47 +0800
In-Reply-To: <20190624095827.GA6501@kuha.fi.intel.com>
References: <1560242680-23844-1-git-send-email-chunfeng.yun@mediatek.com>
         <1560242680-23844-10-git-send-email-chunfeng.yun@mediatek.com>
         <20190624095827.GA6501@kuha.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heikki,

On Mon, 2019-06-24 at 12:58 +0300, Heikki Krogerus wrote:
> Hi Chunfeng,
> 
> On Tue, Jun 11, 2019 at 04:44:39PM +0800, Chunfeng Yun wrote:
> > Due to the requirement of usb-connector.txt binding, the old way
> > using extcon to support USB Dual-Role switch is now deprecated
> > when use Type-B connector.
> > This patch introduces a driver of Type-B connector which typically
> > uses an input GPIO to detect USB ID pin, and try to replace the
> > function provided by extcon-usb-gpio driver
> 
> I'm sorry for asking this so late, but why is this driver a Type-B
> specific driver (I really thought somebody had already asked this
> question)?
It's mainly used for Type-B connector with ID pin. 

> 
> I don't see anything Type-B specific in the driver. 
It's need add another compatible "usb-b-connector" except the driver
provided.

> Basically it looks
> to me like just a gpio based connection detection driver that would
> work fine with for example uAB connectors..
Yes, it is.
> 
> > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > Tested-by: Nagarjuna Kristam <nkristam@nvidia.com>
> > ---
> > v7 changes:
> >   1. remove macro DEV_PMS_OPS suggested by Andy
> >   2. add tested-by Nagarjuna
> > 
> > v6 changes:
> >   1. get usb-role-swtich by usb_role_switch_get()
> > 
> > v5 changes:
> >   1. put usb_role_switch when error happens suggested by Biju
> >   2. don't treat bype-B connector as a virtual device suggested by Rob
> > 
> > v4 changes:
> >   1. remove linux/gpio.h suggested by Linus
> >   2. put node when error happens
> > 
> > v3 changes:
> >   1. treat bype-B connector as a virtual device;
> >   2. change file name again
> > 
> > v2 changes:
> >   1. file name is changed
> >   2. use new compatible
> > ---
> >  drivers/usb/roles/Kconfig           |  11 ++
> >  drivers/usb/roles/Makefile          |   1 +
> >  drivers/usb/roles/typeb-conn-gpio.c | 284 ++++++++++++++++++++++++++++
> 
> ..It also drives me crazy that you've put this driver under this
> folder. It does not create a role switch so ideally it should not go
> under driver/usb/roles/. 
agree:)

> I think a better place for it would be
> drivers/usb/misc/, or actually, maybe it should go under
> drivers/usb/common/?
I'm not sure, but prefer misc/ folder.

Hi Greg, 

would you please give me some suggestions about this?  which folder I
should put the driver into?

> 
> Could you still rename the driver to something like "usb-gpio.c" or
> conn-gpio.c,
I think about the name for a long time before, and have some doubt
whether it's suitable to add typeb into the name.
How about using usb-conn-gpio.c or conn-usb-gpio.c?

Thanks a lot

>  or something else, and also move it under
> drivers/usb/misc/ or drivers/usb/common/?
> 
> >  3 files changed, 296 insertions(+)
> >  create mode 100644 drivers/usb/roles/typeb-conn-gpio.c
> > 
> > diff --git a/drivers/usb/roles/Kconfig b/drivers/usb/roles/Kconfig
> > index f8b31aa67526..d1156e18a81a 100644
> > --- a/drivers/usb/roles/Kconfig
> > +++ b/drivers/usb/roles/Kconfig
> > @@ -26,4 +26,15 @@ config USB_ROLES_INTEL_XHCI
> >  	  To compile the driver as a module, choose M here: the module will
> >  	  be called intel-xhci-usb-role-switch.
> >  
> > +config TYPEB_CONN_GPIO
> > +	tristate "USB Type-B GPIO Connector"
> 
> USB GPIO connection detection driver?
> 
> > +	depends on GPIOLIB
> > +	help
> > +	  The driver supports USB role switch between host and device via GPIO
> > +	  based USB cable detection, used typically if an input GPIO is used
> > +	  to detect USB ID pin.
> > +
> > +	  To compile the driver as a module, choose M here: the module will
> > +	  be called typeb-conn-gpio.ko
> > +
> >  endif # USB_ROLE_SWITCH
> > diff --git a/drivers/usb/roles/Makefile b/drivers/usb/roles/Makefile
> > index 757a7d2797eb..5d5620d9d113 100644
> > --- a/drivers/usb/roles/Makefile
> > +++ b/drivers/usb/roles/Makefile
> > @@ -3,3 +3,4 @@
> >  obj-$(CONFIG_USB_ROLE_SWITCH)		+= roles.o
> >  roles-y					:= class.o
> >  obj-$(CONFIG_USB_ROLES_INTEL_XHCI)	+= intel-xhci-usb-role-switch.o
> > +obj-$(CONFIG_TYPEB_CONN_GPIO)		+= typeb-conn-gpio.o
> > diff --git a/drivers/usb/roles/typeb-conn-gpio.c b/drivers/usb/roles/typeb-conn-gpio.c
> > new file mode 100644
> > index 000000000000..e3fba1656069
> > --- /dev/null
> > +++ b/drivers/usb/roles/typeb-conn-gpio.c
> > @@ -0,0 +1,284 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*


