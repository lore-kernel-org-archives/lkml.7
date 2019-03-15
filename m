Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23913C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 09:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB7E921872
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 09:33:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728748AbfCOJdI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 05:33:08 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:27427 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727734AbfCOJdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 05:33:07 -0400
X-UUID: d2543c6e789445dd85f0a8f32260a88c-20190315
X-UUID: d2543c6e789445dd85f0a8f32260a88c-20190315
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1849929349; Fri, 15 Mar 2019 17:33:02 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 15 Mar
 2019 17:33:00 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 15 Mar 2019 17:33:00 +0800
Message-ID: <1552642379.10179.138.camel@mhfsdcap03>
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
Date:   Fri, 15 Mar 2019 17:32:59 +0800
In-Reply-To: <20190315092644.GG7752@kuha.fi.intel.com>
References: <1552635513-2378-1-git-send-email-chunfeng.yun@mediatek.com>
         <1552635513-2378-5-git-send-email-chunfeng.yun@mediatek.com>
         <20190315081835.GD7752@kuha.fi.intel.com>
         <1552641204.10179.133.camel@mhfsdcap03>
         <20190315092644.GG7752@kuha.fi.intel.com>
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
On Fri, 2019-03-15 at 11:26 +0200, Heikki Krogerus wrote:
> Hi Chunfeng,
> 
> On Fri, Mar 15, 2019 at 05:13:24PM +0800, Chunfeng Yun wrote:
> > I encounter a build error when CONFIG_USB_ROLE_SWITCH is not enabled,
> > 
> > drivers/usb/mtu3/mtu3_dr.o: In function `ssusb_role_sw_register':
> > ./drivers/usb/mtu3/mtu3_dr.c:460: undefined reference to
> > `usb_role_switch_register'
> > drivers/usb/mtu3/mtu3_dr.o: In function `ssusb_otg_switch_exit':
> > ./drivers/usb/mtu3/mtu3_dr.c:491: undefined reference to
> > `usb_role_switch_unregister'
> 
> So you need to add dependency on USB_ROLE_SWITCH, right?
Yes

> 
> --- a/drivers/usb/mtu3/Kconfig
> +++ b/drivers/usb/mtu3/Kconfig
> @@ -43,6 +43,7 @@ config USB_MTU3_DUAL_ROLE
>         bool "Dual Role mode"
>         depends on ((USB=y || USB=USB_MTU3) && (USB_GADGET=y || USB_GADGET=USB_MTU3))
>         depends on (EXTCON=y || EXTCON=USB_MTU3)
> +       depends on USB_ROLE_SWITCH
>         help
>           This is the default mode of working of MTU3 controller where
>           both host and gadget features are enabled.
> 
> > the following patch has fixed the issue, but seems not get into kernel,
> > [v3,08/12] usb: roles: Add usb role switch notifier.
> > https://patchwork.kernel.org/patch/10836525/
> 
> I don't understand how that fixes the problem? That patch will in any
> case be targeting v5.2. We are in the middle of merge window, so
> nothing is happening until v5.1-rc1 is tagged.
It provides some dummy inline functions when USB_ROLE_SWITCH is not
enabled, this will avoid build error

> 
> 
> thanks,
> 


