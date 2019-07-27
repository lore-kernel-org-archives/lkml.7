Return-Path: <SRS0=tJqY=VY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5658C761AB
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 09:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81DA02080C
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 09:23:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728666AbfG0JTG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jul 2019 05:19:06 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:39062 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728264AbfG0JTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 05:19:05 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 6A01527DC68;
        Sat, 27 Jul 2019 10:19:03 +0100 (BST)
Date:   Sat, 27 Jul 2019 11:18:59 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Qii Wang <qii.wang@mediatek.com>
Cc:     Rob Herring <robh@kernel.org>, <bbrezillon@kernel.org>,
        <matthias.bgg@gmail.com>, <mark.rutland@arm.com>,
        <linux-i3c@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <leilk.liu@mediatek.com>,
        <liguo.zhang@mediatek.com>, <xinping.qian@mediatek.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: i3c: Document MediaTek I3C master
 bindings
Message-ID: <20190727111859.315994c3@collabora.com>
In-Reply-To: <1564190613.24702.11.camel@mhfsdcap03>
References: <1562677762-24067-1-git-send-email-qii.wang@mediatek.com>
        <1562677762-24067-2-git-send-email-qii.wang@mediatek.com>
        <20190724202119.GA26566@bogus>
        <1564190613.24702.11.camel@mhfsdcap03>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Jul 2019 09:23:33 +0800
Qii Wang <qii.wang@mediatek.com> wrote:

> On Wed, 2019-07-24 at 14:21 -0600, Rob Herring wrote:
> > On Tue, Jul 09, 2019 at 09:09:21PM +0800, Qii Wang wrote:  
> > > Document MediaTek I3C master DT bindings.
> > > 
> > > Signed-off-by: Qii Wang <qii.wang@mediatek.com>
> > > ---
> > >  .../devicetree/bindings/i3c/mtk,i3c-master.txt     |   48 ++++++++++++++++++++
> > >  1 file changed, 48 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/i3c/mtk,i3c-master.txt
> > > 
> > > diff --git a/Documentation/devicetree/bindings/i3c/mtk,i3c-master.txt b/Documentation/devicetree/bindings/i3c/mtk,i3c-master.txt
> > > new file mode 100644
> > > index 0000000..d32eda6
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/i3c/mtk,i3c-master.txt
> > > @@ -0,0 +1,48 @@
> > > +Bindings for MediaTek I3C master block
> > > +=====================================
> > > +
> > > +Required properties:
> > > +--------------------
> > > +- compatible: shall be "mediatek,i3c-master"  
> > 
> > Needs to be SoC specific.
> >   
> 
> We hope that the SOCs will use the same driver and try to avoid big
> changes. If there are inevitable changes in the future, then we will
> modify the compatible to be SoC specific. cdns,i3c-master.txt is not SoC
> specific either.

The cadence case is a bit different I think. When the driver was
developed there was no SoC integrating this IP. I guess Mediatek knows
already which SoC(s) will embed the I3C master block.

> 
> > > +- reg: physical base address of the controller and apdma base, length of
> > > +  memory mapped region.
> > > +- reg-names: shall be "main" for master controller and "dma" for apdma.
> > > +- interrupts: the interrupt line connected to this I3C master.
> > > +- clocks: shall reference the i3c and apdma clocks.
> > > +- clock-names: shall include "main" and "dma".
> > > +
> > > +Mandatory properties defined by the generic binding (see
> > > +Documentation/devicetree/bindings/i3c/i3c.txt for more details):
> > > +
> > > +- #address-cells: shall be set to 3
> > > +- #size-cells: shall be set to 0
> > > +
> > > +Optional properties defined by the generic binding (see
> > > +Documentation/devicetree/bindings/i3c/i3c.txt for more details):
> > > +
> > > +- i2c-scl-hz
> > > +- i3c-scl-hz
> > > +
> > > +I3C device connected on the bus follow the generic description (see
> > > +Documentation/devicetree/bindings/i3c/i3c.txt for more details).
> > > +
> > > +Example:
> > > +
> > > +	i3c0: i3c@1100d000 {
> > > +		compatible = "mediatek,i3c-master";
> > > +		reg = <0x1100d000 0x1000>,
> > > +		      <0x11000300 0x80>;
> > > +		reg-names = "main", "dma";
> > > +		interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_LOW>;
> > > +		clocks = <&infracfg CLK_INFRA_I3C0>,
> > > +			 <&infracfg CLK_INFRA_AP_DMA>;
> > > +		clock-names = "main", "dma";
> > > +		#address-cells = <3>;
> > > +		#size-cells = <0>;
> > > +		i2c-scl-hz = <100000>;
> > > +
> > > +		nunchuk: nunchuk@52 {
> > > +			compatible = "nintendo,nunchuk";
> > > +			reg = <0x52 0x0 0x10>;
> > > +		};
> > > +	};
> > > -- 
> > > 1.7.9.5
> > >   
> 
> 

