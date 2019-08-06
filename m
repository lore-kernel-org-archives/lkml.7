Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B97C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 07:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 505EA206A2
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 07:48:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732154AbfHFHso (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 03:48:44 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:28502 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726834AbfHFHso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 03:48:44 -0400
X-UUID: 099a8d38323041caabbea4e9280874c5-20190806
X-UUID: 099a8d38323041caabbea4e9280874c5-20190806
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 69678135; Tue, 06 Aug 2019 15:48:33 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 6 Aug
 2019 15:48:31 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 6 Aug 2019 15:48:30 +0800
Message-ID: <1565077710.23705.21.camel@mhfsdcap03>
Subject: Re: [PATCH v8 00/11] add USB GPIO based connection detection driver
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Biju Das <biju.das@bp.renesas.com>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Li Jun <jun.li@nxp.com>,
        Badhri Jagan Sridharan <badhri@google.com>,
        "Heikki Krogerus" <heikki.krogerus@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Min Guo <min.guo@mediatek.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-usb <linux-usb@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Date:   Tue, 6 Aug 2019 15:48:30 +0800
In-Reply-To: <CACRpkdaBT24JPH_VsKtgp6fjWtVuqM50rXkDVYKmLHgR5hdJzA@mail.gmail.com>
References: <1563958245-6321-1-git-send-email-chunfeng.yun@mediatek.com>
         <CACRpkdaBT24JPH_VsKtgp6fjWtVuqM50rXkDVYKmLHgR5hdJzA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: 5974D75886B44E4363446BA9394912791E53F3E9496FF92EBA64D74B9A80C30C2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-08-05 at 12:06 +0200, Linus Walleij wrote:
> On Wed, Jul 24, 2019 at 10:51 AM Chunfeng Yun <chunfeng.yun@mediatek.com> wrote:
> 
> > Because the USB Connector is introduced and the requirement of
> > usb-connector.txt binding, the old way using extcon to support
> > USB Dual-Role switch is now deprecated, meanwhile there is no
> > available common driver when use Type-B connector, typically
> > using an input GPIO to detect USB ID pin.
> 
> However while this was going on,
> drivers/extcon/extcon-fsa9480.c was merged and that detects
> not only GPIO on the USB port but multiplexed usecases such
> as UART over the USB micro PHY (and no that UART is not
> a USB UART, but an actual RX/TX over D-/D+).
> 
> That driver also measure a whole slew of funny resistance
> values on the ID pin, that is how it does its job.
I look into the spec of fsa9480, it indeed detect many USB accessories.
But this driver is used for simplest cases that only uses micro
receptacle with id-pin/vbus-pin

> 
> But for just "hey I'm plugged in" we can surely keep this
> ID on GPIO detection in the USB subsystem.
Sorry, you mean provide a common API? could you please describe more
clearer about your suggestion?


Introducing a single driver using usb_role_switch will help to keep
transparent for USB controller driver, no matter it uses type-c or micro

Thanks a lot
> 
> I just get a bit insecure about how we should ideally
> handle these "funny-PHY's".

> 
> Yours,
> Linus Walleij


