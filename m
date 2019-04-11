Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D844BC10F11
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 01:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A95C5217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 01:06:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbfDKBGH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 21:06:07 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:61644 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725782AbfDKBGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 21:06:07 -0400
X-UUID: 0ac7dc869424441dab17ec1c9647182c-20190411
X-UUID: 0ac7dc869424441dab17ec1c9647182c-20190411
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1897485948; Thu, 11 Apr 2019 09:06:01 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 11 Apr
 2019 09:05:59 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 11 Apr 2019 09:05:59 +0800
Message-ID: <1554944759.10179.182.camel@mhfsdcap03>
Subject: Re: [v3 PATCH 6/6] usb: mtu3: register a USB Role Switch for dual
 role mode
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
Date:   Thu, 11 Apr 2019 09:05:59 +0800
In-Reply-To: <20190410102415.GH20058@kuha.fi.intel.com>
References: <1554257354-7440-1-git-send-email-chunfeng.yun@mediatek.com>
         <1554257354-7440-7-git-send-email-chunfeng.yun@mediatek.com>
         <20190410102415.GH20058@kuha.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-04-10 at 13:24 +0300, Heikki Krogerus wrote:
> On Wed, Apr 03, 2019 at 10:09:14AM +0800, Chunfeng Yun wrote:
> > +static int ssusb_role_sw_register(struct otg_switch_mtk *otg_sx)
> > +{
> > +	struct usb_role_switch_desc role_sx_desc = { 0 };
> > +	struct ssusb_mtk *ssusb =
> > +		container_of(otg_sx, struct ssusb_mtk, otg_switch);
> > +
> > +	if (!otg_sx->role_sw_used)
> > +		return 0;
> > +
> > +	role_sx_desc.set = ssusb_role_sw_set;
> > +	role_sx_desc.get = ssusb_role_sw_get;
> 
>         role_sw_desc.fwnode = dev_fwnode(ssusb->dev);
Ok, thanks

> 
> > +	otg_sx->role_sw = usb_role_switch_register(ssusb->dev, &role_sx_desc);
> > +
> > +	return PTR_ERR_OR_ZERO(otg_sx->role_sw);
> > +}
> 
> thanks,
> 


