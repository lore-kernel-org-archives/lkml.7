Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E044C282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 08:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65EC220870
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 08:15:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbfDHIPI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 04:15:08 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:41342 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725925AbfDHIPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 04:15:07 -0400
X-UUID: a12c7051fe814e918f451ced37b549b9-20190408
X-UUID: a12c7051fe814e918f451ced37b549b9-20190408
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1838518430; Mon, 08 Apr 2019 16:14:56 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 8 Apr
 2019 16:14:55 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 8 Apr 2019 16:14:54 +0800
Message-ID: <1554711294.10179.178.camel@mhfsdcap03>
Subject: Re: [v3 PATCH 5/6] usb: roles: add USB Type-B GPIO connector driver
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Linus Walleij <linus.walleij@linaro.org>
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
        Alan Stern <stern@rowland.harvard.edu>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Date:   Mon, 8 Apr 2019 16:14:54 +0800
In-Reply-To: <CACRpkdatNdzZ+97pZNBudyPNVtQDLKU_o31MSe=T7kJzWtaWUg@mail.gmail.com>
References: <1554257354-7440-1-git-send-email-chunfeng.yun@mediatek.com>
         <1554257354-7440-6-git-send-email-chunfeng.yun@mediatek.com>
         <CACRpkdatNdzZ+97pZNBudyPNVtQDLKU_o31MSe=T7kJzWtaWUg@mail.gmail.com>
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
On Thu, 2019-04-04 at 23:35 +0700, Linus Walleij wrote:
> On Wed, Apr 3, 2019 at 9:09 AM Chunfeng Yun <chunfeng.yun@mediatek.com> wrote:
> 
> > Due to the requirement of usb-connector.txt binding, the old way
> > using extcon to support USB Dual-Role switch is now deprecated
> > when use Type-B connector.
> > This patch introduces a driver of Type-B connector which typically
> > uses an input GPIO to detect USB ID pin, and try to replace the
> > function provided by extcon-usb-gpio driver
> >
> > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> (...)
> > +#include <linux/gpio.h>
> 
> If you need this include in a consumer, something is wrong. Just delete it,
Ok
> 
> > +       info->id_gpiod = devm_gpiod_get_from_of_node(
> > +                               dev, child, "id-gpios", 0, GPIOD_IN, "idpin");
> 
> This is OK if the child does not have any Linux device (struct platform_device
> etc) created from it. Is this the case?
Yes, it is.

Thanks

> 
> Yours,
> Linus Walleij


