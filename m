Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7741BC5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58BC02084D
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:11:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbfKGTLO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 14:11:14 -0500
Received: from gloria.sntech.de ([185.11.138.130]:46252 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725851AbfKGTLO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 14:11:14 -0500
Received: from ip5f5a6266.dynamic.kabel-deutschland.de ([95.90.98.102] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko.stuebner@theobroma-systems.com>)
        id 1iSnBK-0004qp-Rm; Thu, 07 Nov 2019 20:10:58 +0100
From:   Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     dri-devel@lists.freedesktop.org, a.hajda@samsung.com,
        hjc@rock-chips.com, robh+dt@kernel.org, mark.rutland@arm.com,
        narmstrong@baylibre.com, jonas@kwiboo.se, jernej.skrabec@siol.net,
        philippe.cornu@st.com, yannick.fertre@st.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        christoph.muellner@theobroma-systems.com
Subject: Re: [PATCH 2/3] drm/rockchip: add ability to handle external dphys in mipi-dsi
Date:   Thu, 07 Nov 2019 20:10:57 +0100
Message-ID: <1772103.UzfIEELiUT@phil>
In-Reply-To: <20191106130557.GF4878@pendragon.ideasonboard.com>
References: <20191106112650.8365-1-heiko.stuebner@theobroma-systems.com> <20191106112650.8365-2-heiko.stuebner@theobroma-systems.com> <20191106130557.GF4878@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

Am Mittwoch, 6. November 2019, 14:05:57 CET schrieb Laurent Pinchart:
> On Wed, Nov 06, 2019 at 12:26:49PM +0100, Heiko Stuebner wrote:
> > While the common case is that the dsi controller uses an internal dphy,
> > accessed through the phy registers inside the dsi controller, there is
> > also the possibility to use a separate dphy from a different vendor.
> > 
> > One such case is the Rockchip px30 that uses a Innosilicon Mipi dphy,
> > so add the support for handling such a constellation, including the pll
> > also getting generated inside that external phy.
> > 
> > Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
> > ---
> >  .../display/rockchip/dw_mipi_dsi_rockchip.txt |  7 ++-
> >  .../gpu/drm/rockchip/dw-mipi-dsi-rockchip.c   | 54 ++++++++++++++++++-
> >  2 files changed, 57 insertions(+), 4 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/display/rockchip/dw_mipi_dsi_rockchip.txt b/Documentation/devicetree/bindings/display/rockchip/dw_mipi_dsi_rockchip.txt
> > index ce4c1fc9116c..8b25156a9dcf 100644
> > --- a/Documentation/devicetree/bindings/display/rockchip/dw_mipi_dsi_rockchip.txt
> > +++ b/Documentation/devicetree/bindings/display/rockchip/dw_mipi_dsi_rockchip.txt
> > @@ -8,8 +8,9 @@ Required properties:
> >  	      "rockchip,rk3399-mipi-dsi", "snps,dw-mipi-dsi".
> >  - reg: Represent the physical address range of the controller.
> >  - interrupts: Represent the controller's interrupt to the CPU(s).
> > -- clocks, clock-names: Phandles to the controller's pll reference
> > -  clock(ref) and APB clock(pclk). For RK3399, a phy config clock
> > +- clocks, clock-names: Phandles to the controller's and APB clock(pclk)
> > +  and either a pll reference clock(ref) (internal dphy) or pll clock(pll)
> > +  (when connected to an external phy). For RK3399, a phy config clock
> 
> Why does external PHY clock need to be specified here ? Shouldn't it be
> handled by the PHY instead ?

You're completely right and it seems I didn't "see the forest  for the trees",
as there actually exists the phy_configure_* structs to transfer parameters
to an external phy in a correct way.

I'll revise my approach (and the phy driver) accordingly.

Thanks for the push in the right direction :-)
Heiko



