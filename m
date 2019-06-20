Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E22CAC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 19:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA1672084E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 19:43:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbfFTTnS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 15:43:18 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:44604 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726002AbfFTTnS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 15:43:18 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id A23C0FB06;
        Thu, 20 Jun 2019 21:43:15 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id v9DpMwBc1fMx; Thu, 20 Jun 2019 21:43:14 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 087FA47322; Thu, 20 Jun 2019 21:43:14 +0200 (CEST)
Date:   Thu, 20 Jun 2019 21:43:13 +0200
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Thierry Reding <treding@nvidia.com>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Johan Hovold <johan@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>, Li Jun <jun.li@nxp.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        Robert Chiras <robert.chiras@nxp.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH v11 2/2] phy: Add driver for mixel mipi dphy found on
 NXP's i.MX8 SoCs
Message-ID: <20190620194313.GA13015@bogon.m.sigxcpu.org>
References: <cover.1557657814.git.agx@sigxcpu.org>
 <2000bc4564175abd7966207a5e9fbb9bb7d82059.1557657814.git.agx@sigxcpu.org>
 <CAOMZO5BaFYJxh1v46n2mdPyc+-jg6LgvoGR1rTE+yHZg_0Z8PA@mail.gmail.com>
 <69fcb327-8b51-df9e-12d9-d75751974bce@ti.com>
 <9a872f5b-1544-32a0-bd93-1d6333468114@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9a872f5b-1544-32a0-bd93-1d6333468114@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Thu, Jun 20, 2019 at 02:18:53PM +0530, Kishon Vijay Abraham I wrote:
> Hi,
> 
> On 24/05/19 9:31 PM, Kishon Vijay Abraham I wrote:
> > Hi,
> > 
> > On 24/05/19 5:53 PM, Fabio Estevam wrote:
> >> Hi Kishon,
> >>
> >> On Sun, May 12, 2019 at 7:49 AM Guido Günther <agx@sigxcpu.org> wrote:
> >>>
> >>> This adds support for the Mixel DPHY as found on i.MX8 CPUs but since
> >>> this is an IP core it will likely be found on others in the future. So
> >>> instead of adding this to the nwl host driver make it a generic PHY
> >>> driver.
> >>>
> >>> The driver supports the i.MX8MQ. Support for i.MX8QM and i.MX8QXP can be
> >>> added once the necessary system controller bits are in via
> >>> mixel_dphy_devdata.
> >>>
> >>> Signed-off-by: Guido Günther <agx@sigxcpu.org>
> >>> Co-developed-by: Robert Chiras <robert.chiras@nxp.com>
> >>> Signed-off-by: Robert Chiras <robert.chiras@nxp.com>
> >>> Reviewed-by: Fabio Estevam <festevam@gmail.com>
> >>> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> >>
> >> Would you have any comments on this series, please?
> > 
> > I don't have any comments. I'll queue this once I start queuing patches for the
> > next merge window.
> 
> Can you fix the following checkpatch warning and repost?
> WARNING: quoted string split across lines
> #420: FILE: drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c:280:
> +	dev_dbg(&phy->dev, "hs_prepare: %u, clk_prepare: %u, "
> +		"hs_zero: %u, clk_zero: %u, "
> 
> WARNING: quoted string split across lines
> #421: FILE: drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c:281:
> +		"hs_zero: %u, clk_zero: %u, "
> +		"hs_trail: %u, clk_trail: %u, "
> 
> WARNING: quoted string split across lines
> #422: FILE: drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c:282:
> +		"hs_trail: %u, clk_trail: %u, "
> +		"rxhs_settle: %u\n",

Fixed in v12.
Thanks,
 -- Guido
