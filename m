Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B80C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 16:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D60021670
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 16:58:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbfD3Q6W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 12:58:22 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:48655 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725930AbfD3Q6W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 12:58:22 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id D1245FB03;
        Tue, 30 Apr 2019 18:58:18 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id m4ARVJI0QoKf; Tue, 30 Apr 2019 18:58:17 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 15AA24027E; Tue, 30 Apr 2019 18:58:17 +0200 (CEST)
Date:   Tue, 30 Apr 2019 18:58:17 +0200
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
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
Subject: Re: [PATCH v9 2/2] phy: Add driver for mixel mipi dphy found on
 NXP's i.MX8 SoCs
Message-ID: <20190430165817.GB29626@bogon.m.sigxcpu.org>
References: <cover.1556633413.git.agx@sigxcpu.org>
 <b999b07673e59c676d2e43a786b635beb056e9bf.1556633413.git.agx@sigxcpu.org>
 <CAOMZO5BerzB94YvJgZoOVYaA3fCsHQiuC5FyVVVRV+ttEg92uQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOMZO5BerzB94YvJgZoOVYaA3fCsHQiuC5FyVVVRV+ttEg92uQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabio,
On Tue, Apr 30, 2019 at 01:24:45PM -0300, Fabio Estevam wrote:
> Hi Guido,
> 
> On Tue, Apr 30, 2019 at 11:40 AM Guido Günther <agx@sigxcpu.org> wrote:
> >
> > This adds support for the Mixel DPHY as found on i.MX8 CPUs but since
> > this is an IP core it will likely be found on others in the future. So
> > instead of adding this to the nwl host driver make it a generic PHY
> > driver.
> >
> > The driver supports the i.MX8MQ. Support for i.MX8QM and i.MX8QXP can be
> > added once the necessary system controller bits are in via
> > mixel_dphy_devdata.
> >
> > Co-authored-by: Robert Chiras <robert.chiras@nxp.com>
> > Signed-off-by: Guido Günther <agx@sigxcpu.org>
> 
> I wish I could test it on a imx8m-evk , but there are some other
> pieces needed such as Northwest Logic driver, mxsfb changes for
> supporting mx8m, OLED panel driver, etc
> 
> Anyway, it looks good to me and I have only a few minor comments:
> 
> > ---
> >  drivers/phy/freescale/Kconfig                 |  11 +
> >  drivers/phy/freescale/Makefile                |   1 +
> >  .../phy/freescale/phy-fsl-imx8-mipi-dphy.c    | 506 ++++++++++++++++++
> >  3 files changed, 518 insertions(+)
> >  create mode 100644 drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c
> >
> > diff --git a/drivers/phy/freescale/Kconfig b/drivers/phy/freescale/Kconfig
> > index 832670b4952b..a111b130f9d2 100644
> > --- a/drivers/phy/freescale/Kconfig
> > +++ b/drivers/phy/freescale/Kconfig
> > @@ -3,3 +3,14 @@ config PHY_FSL_IMX8MQ_USB
> >         depends on OF && HAS_IOMEM
> >         select GENERIC_PHY
> >         default ARCH_MXC && ARM64
> > +
> > +config PHY_MIXEL_MIPI_DPHY
> > +       tristate "Mixel MIPI DSI PHY support"
> > +       depends on OF && HAS_IOMEM
> > +       select GENERIC_PHY
> > +       select GENERIC_PHY_MIPI_DPHY
> > +       select REGMAP_MMIO
> > +       default ARCH_MXC && ARM64
> 
> I don't think that this default is a good idea.
> 
> There are imx8m systems that do not have display, so in this case it
> does not make sense to always force the build of this driver.

O.k. - we can enable this based on imx-nwl later on. I've also addressed
your other comments. Will wait for a v10 for a couple of days in case
there's more feedback.
Thanks,
 -- Guido
