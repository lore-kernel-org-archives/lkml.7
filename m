Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61175C3A5A3
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 06:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37F3321721
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 06:22:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbfH3GWu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 02:22:50 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:44507 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726090AbfH3GWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 02:22:49 -0400
X-UUID: 9c6850f9bd614fb3a57d21a7a3a9077a-20190830
X-UUID: 9c6850f9bd614fb3a57d21a7a3a9077a-20190830
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1531351212; Fri, 30 Aug 2019 14:22:36 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS32DR.mediatek.inc
 (172.27.6.104) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 30 Aug
 2019 14:22:34 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 30 Aug 2019 14:22:34 +0800
Message-ID: <1567146149.7317.40.camel@mhfsdcap03>
Subject: Re: [PATCH 02/11] dt-bindings: phy-mtk-tphy: make the ref clock
 optional
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     Kishon Vijay Abraham I <kishon@ti.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Date:   Fri, 30 Aug 2019 14:22:29 +0800
In-Reply-To: <20190829192550.GA29881@bogus>
References: <e99c0d7a55869a4425250c601b80a3331c9d0976.1566542696.git.chunfeng.yun@mediatek.com>
         <a31d78484b64f853a16e7dcb16fae9fc0de45ebb.1566542696.git.chunfeng.yun@mediatek.com>
         <20190829192550.GA29881@bogus>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: 98DB08F7F53AF6863050E9819BDD5FA46007C836A76BD5835C75A269FC4EE4DF2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-08-29 at 14:25 -0500, Rob Herring wrote:
> On Fri, Aug 23, 2019 at 03:00:09PM +0800, Chunfeng Yun wrote:
> > Make the ref clock optional, then we no need refer to a fixed-clock
> > in DTS anymore when the clock of USB3 PHY comes from oscillator
> > directly
> > 
> > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > ---
> >  .../devicetree/bindings/phy/phy-mtk-tphy.txt        | 13 +++++++------
> >  1 file changed, 7 insertions(+), 6 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/phy/phy-mtk-tphy.txt b/Documentation/devicetree/bindings/phy/phy-mtk-tphy.txt
> > index d5b327f85fa2..1c18bf10b2fe 100644
> > --- a/Documentation/devicetree/bindings/phy/phy-mtk-tphy.txt
> > +++ b/Documentation/devicetree/bindings/phy/phy-mtk-tphy.txt
> > @@ -34,12 +34,6 @@ Optional properties (controller (parent) node):
> >  
> >  Required properties (port (child) node):
> >  - reg		: address and length of the register set for the port.
> > -- clocks	: a list of phandle + clock-specifier pairs, one for each
> > -		  entry in clock-names
> > -- clock-names	: must contain
> > -		  "ref": 48M reference clock for HighSpeed analog phy; and 26M
> > -			reference clock for SuperSpeed analog phy, sometimes is
> > -			24M, 25M or 27M, depended on platform.
> >  - #phy-cells	: should be 1 (See second example)
> >  		  cell after port phandle is phy type from:
> >  			- PHY_TYPE_USB2
> > @@ -48,6 +42,13 @@ Required properties (port (child) node):
> >  			- PHY_TYPE_SATA
> >  
> >  Optional properties (PHY_TYPE_USB2 port (child) node):
> > +- clocks	: a list of phandle + clock-specifier pairs, one for each
> > +		  entry in clock-names
> > +- clock-names	: may contain
> > +		  "ref": 48M reference clock for HighSpeed anolog phy; and 26M
> > +			reference clock for SuperSpeed anolog phy, sometimes is
> > +			24M, 25M or 27M, depended on platform.
> 
> How do you know the frequency when it is not present?
It's always present, but sometimes it's always on by default (e.g. 48Mhz
of U2 PHY), or comes from oscillator directly  (e.g. 26Mhz of U3 PHY),
so not controlled by CCF, of course we can use a fixed-clock in latter
case, it's useful to make it optional for these two cases.

Thanks

> 
> > +
> >  - mediatek,eye-src	: u32, the value of slew rate calibrate
> >  - mediatek,eye-vrt	: u32, the selection of VRT reference voltage
> >  - mediatek,eye-term	: u32, the selection of HS_TX TERM reference voltage
> > -- 
> > 2.23.0
> > 


