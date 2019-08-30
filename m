Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB44C3A5A3
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 06:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A139821721
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 06:24:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbfH3GYH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 02:24:07 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:8318 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726978AbfH3GYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 02:24:07 -0400
X-UUID: 26dd957eabfa4ed9b9597dce4e283d37-20190830
X-UUID: 26dd957eabfa4ed9b9597dce4e283d37-20190830
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 239738293; Fri, 30 Aug 2019 14:24:00 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS32DR.mediatek.inc
 (172.27.6.104) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 30 Aug
 2019 14:23:56 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 30 Aug 2019 14:23:56 +0800
Message-ID: <1567146231.7317.41.camel@mhfsdcap03>
Subject: Re: [PATCH 04/11] dt-bindings: phy-mtk-tphy: add a new reference
 clock
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     Kishon Vijay Abraham I <kishon@ti.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Date:   Fri, 30 Aug 2019 14:23:51 +0800
In-Reply-To: <20190829200503.GA2542@bogus>
References: <e99c0d7a55869a4425250c601b80a3331c9d0976.1566542696.git.chunfeng.yun@mediatek.com>
         <f6ee7d33103b43b2f1e1331c23c36057ef20b20d.1566542697.git.chunfeng.yun@mediatek.com>
         <20190829200503.GA2542@bogus>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: 9D29D17FAA54D1AE255DE995E26BF8FEA1AEFE9EE094F78B2839206ECE2E9EEE2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-08-29 at 15:05 -0500, Rob Herring wrote:
> On Fri, Aug 23, 2019 at 03:00:11PM +0800, Chunfeng Yun wrote:
> > Usually the digital and anolog phys use the same reference clock,
> > but on some platforms, they are separated, so add another optional
> > clock to support it.
> > In order to keep the clock names consistent with PHY IP's, use
> > the da_ref for anolog phy and ref clock for digital phy.
> > 
> > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > ---
> >  Documentation/devicetree/bindings/phy/phy-mtk-tphy.txt | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/phy/phy-mtk-tphy.txt b/Documentation/devicetree/bindings/phy/phy-mtk-tphy.txt
> > index dbc143ed5999..ed9a2641f204 100644
> > --- a/Documentation/devicetree/bindings/phy/phy-mtk-tphy.txt
> > +++ b/Documentation/devicetree/bindings/phy/phy-mtk-tphy.txt
> > @@ -41,9 +41,12 @@ Optional properties (PHY_TYPE_USB2 port (child) node):
> >  - clocks	: a list of phandle + clock-specifier pairs, one for each
> >  		  entry in clock-names
> >  - clock-names	: may contain
> > -		  "ref": 48M reference clock for HighSpeed anolog phy; and 26M
> > -			reference clock for SuperSpeed anolog phy, sometimes is
> > +		  "ref": 48M reference clock for HighSpeed (digital) phy; and 26M
> > +			reference clock for SuperSpeed (digital) phy, sometimes is
> >  			24M, 25M or 27M, depended on platform.
> > +		  "da_ref": the reference clock of anolog phy, used if the clocks
> > +			of anolog and digital phys are separated, otherwise uses
> 
> s/amolog/analog/
will fix it
> 
> > +			"ref" clock only if need.
> 
> needed.
also here

Thanks a lot

> 
> >  
> >  - mediatek,eye-src	: u32, the value of slew rate calibrate
> >  - mediatek,eye-vrt	: u32, the selection of VRT reference voltage
> > -- 
> > 2.23.0
> > 


