Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A248AC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 06:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B9B021019
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 06:26:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbfEHG0x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 02:26:53 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:19621 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725884AbfEHG0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 02:26:52 -0400
X-UUID: 3f9020aaaf04425997874e36e2301ec3-20190508
X-UUID: 3f9020aaaf04425997874e36e2301ec3-20190508
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1509536441; Wed, 08 May 2019 14:26:45 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 8 May
 2019 14:26:43 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 8 May 2019 14:26:42 +0800
Message-ID: <1557296802.10179.272.camel@mhfsdcap03>
Subject: Re: [v2 PATCH] dt-binding: usb: add usb-role-switch property
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Biju Das <biju.das@bp.renesas.com>,
        Yu Chen <chenyu56@huawei.com>, Min Guo <min.guo@mediatek.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
Date:   Wed, 8 May 2019 14:26:42 +0800
In-Reply-To: <20190507141305.GA19816@kuha.fi.intel.com>
References: <38ff51264e971d5c58940c8435b9d8d274662d50.1557195204.git.chunfeng.yun@mediatek.com>
         <20190507141305.GA19816@kuha.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-05-07 at 17:13 +0300, Heikki Krogerus wrote:
> On Tue, May 07, 2019 at 10:22:58AM +0800, Chunfeng Yun wrote:
> > diff --git a/Documentation/devicetree/bindings/usb/generic.txt b/Documentation/devicetree/bindings/usb/generic.txt
> > index 0a74ab8dfdc2..f5a6ad053ecc 100644
> > --- a/Documentation/devicetree/bindings/usb/generic.txt
> > +++ b/Documentation/devicetree/bindings/usb/generic.txt
> > @@ -30,6 +30,11 @@ Optional properties:
> >  			optional for OTG device.
> >   - adp-disable: tells OTG controllers we want to disable OTG ADP, ADP is
> >  			optional for OTG device.
> > + - usb-role-switch: tells Dual-Role USB controllers we want to handle the role
> > +			switch between host and device according to the state
> > +			detected by the USB connector, typically for Type-C,
> > +			Type-B(micro).
> > +			see connector/usb-connector.txt.
> 
> That does not look correct to me. Firstly, USB role switches are not
> always dual-role USB controllers. 
Thanks for review, I look through some drivers, you are right, some phys
also switch the roles.

> Secondly, stating what determines
> the role irrelevant IMO.
> 
> Since this is a boolean property, the description for it should simply
> explain what does it tell about the capabilities of the device that
> has it. The description should not make any assumptions about the
> users of the property, and since the property is a "generic" USB
> property, I'm not sure it should make any assumptions about the type
> of the device that has the property either. Also, I would really like
> the description to show the type of the property.
Ok I'll add it.

> 
> Why not just say something like this:
> 
> "Boolean property informing that the device is capable of assigning
> the USB data role (USB host or USB device) for a given USB connector."
will modify it.

> 
> 
> thanks,
> 


