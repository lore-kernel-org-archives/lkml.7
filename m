Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECEE7C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 08:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81CD221783
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 08:04:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DwTHwMy/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503781AbfIXIE0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 04:04:26 -0400
Received: from mail-eopbgr10085.outbound.protection.outlook.com ([40.107.1.85]:10325
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2394727AbfIXIE0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 04:04:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eBR+VeF3aXxL7SW59y9Ud63KyaWuaXfHBiIuM3kSWPLHfqJv/1eljFql52saohEYoRpPXflJuFpse5L2gLG6WUuwsV3kmiyI/FQilht6vXKqLW6b4jSNmOfZOQfcuRsgurKK+AZrWX1iQ6YjZfUW6+4hPXm5YBdhwsEPDWtNh2nHNtTyibpVCYdH3KjohLotL2c/fCEUGLGu4fPMvIHc7hNkor4yTMgdVj/fVsYcXVa6GvxpTUQOWD9jaUi+cjF39m8vwhOPd/V2ocRfd4rbqMerIkuLYveTzDRoJ4cTVzMnf8wOKeMowrXguDiVLHwWyH5Vxv+FhRRwxlEQnpo0bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DFx+leXEwNuS1Wv2uwm6w0myY2T4QCiHS3WEwnBwTBg=;
 b=Cq2tny77onMktIfCs5wG3omF/Tdc4xT3VGGYT9Lc993+VeFudRfQ3JFxukbIfC/Fcz7xeejQCKZQIrdR3O+bcLMn75430oite64LoUdCOK5bPeZVvuAdlpeuFnWMHeOOHvvjvzwJHnURgsSV3RKh/tIs5j1mOL+DXvQ/w4xphQucW8UB6cP4BGu8tPzm3E9tr6dZLPqfozkyT5xVpQrQl2OwMefsuci13t81FnVxhYUrys4Gr1tmMW2OT6QpCR6yfDJPGv+NzMrp+Az5mtd1UGcEa5XbzV596KLjI+8pQHkquu2m/gz+8iRMV7Js0rfsohlu1vnLcaO80ri0gwWfbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DFx+leXEwNuS1Wv2uwm6w0myY2T4QCiHS3WEwnBwTBg=;
 b=DwTHwMy/k2cVxd98+vW+eIFPmwIJe3Qps69D6TXGmWx+ds/TcZ/HrBv3CheoGK9PKhDK4mMmp4AmL892gO0sz1GQJT5Gbwh/cLihJgaPmbPmOzLG5X4h3pgDL8bjCNSrxtVbFMiN/TO4mx9CYHN5OrgyXRljd1odmS1LveNY5Yc=
Received: from VI1PR04MB6237.eurprd04.prod.outlook.com (20.179.24.74) by
 VI1PR04MB6896.eurprd04.prod.outlook.com (52.133.245.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.21; Tue, 24 Sep 2019 08:03:56 +0000
Received: from VI1PR04MB6237.eurprd04.prod.outlook.com
 ([fe80::c887:7d43:1e17:9485]) by VI1PR04MB6237.eurprd04.prod.outlook.com
 ([fe80::c887:7d43:1e17:9485%7]) with mapi id 15.20.2284.023; Tue, 24 Sep 2019
 08:03:56 +0000
From:   Laurentiu Palcu <laurentiu.palcu@nxp.com>
To:     Ying Liu <gnuiyl@gmail.com>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: Re: [PATCH 3/5] drm/imx: Add initial support for DCSS on iMX8MQ
Thread-Topic: Re: [PATCH 3/5] drm/imx: Add initial support for DCSS on iMX8MQ
Thread-Index: AQHVcq6d9R1BYaC25kmxwGmUJFM30A==
Date:   Tue, 24 Sep 2019 08:03:56 +0000
Message-ID: <20190924080355.GC25260@fsr-ub1664-121>
References: <1569248002-2485-1-git-send-email-laurentiu.palcu@nxp.com>
 <1569248002-2485-4-git-send-email-laurentiu.palcu@nxp.com>
 <CAOcKUNUWrswJ0jZc5SkvYv68wSqL6Js9X0Mey6_w-OmzLyvVRQ@mail.gmail.com>
In-Reply-To: <CAOcKUNUWrswJ0jZc5SkvYv68wSqL6Js9X0Mey6_w-OmzLyvVRQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=laurentiu.palcu@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 788a5b7b-ae7c-48b9-8352-08d740c5bff6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB6896;
x-ms-traffictypediagnostic: VI1PR04MB6896:|VI1PR04MB6896:
x-ms-exchange-purlcount: 2
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB6896A6DB71B8BE12139E467DFF840@VI1PR04MB6896.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 0170DAF08C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(136003)(376002)(39860400002)(366004)(346002)(396003)(199004)(189003)(45080400002)(6306002)(14444005)(256004)(66066001)(5024004)(1411001)(6246003)(6512007)(99286004)(33656002)(25786009)(102836004)(229853002)(6436002)(76176011)(186003)(486006)(26005)(30864003)(6116002)(3846002)(4326008)(7416002)(1076003)(11346002)(6506007)(33716001)(316002)(54906003)(476003)(53546011)(2906002)(6916009)(81166006)(86362001)(9686003)(5660300002)(6486002)(66476007)(305945005)(8936002)(8676002)(66446008)(66556008)(64756008)(66946007)(91956017)(76116006)(446003)(44832011)(81156014)(478600001)(14454004)(71190400001)(71200400001)(966005)(7736002)(32563001)(569006);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB6896;H:VI1PR04MB6237.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:3;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: VsXQq5TtZL9hPjY36o853uAkPOmaHqTSUwcoEgETrakoUHQdbA9RtP0Kcsp8j45EBjF9GaYB+4QKiaamecENI7e4kHnIhN6o0NxNyq65GUZgYXIDIfR51aavleBtbGFGJf8D6s57lStygX/xmwbca7GNZH2f1r9UOvsO6/O9qmi2I9daXGMPJ+lKy0qHsXHlzKU5c8kB0nE30lisKvxIoa6WzkfGGwPVvAlXUNswdgJYCxf/dNzmRO1KkEmR7M6usYYx3KtOXhr3nszO+JCx8GMvYzcnvhuZwHLiZ3HXlpBDjsEpGqIlDfj1gavbTckFB/mF77n6PMVSGEeeLkWLeVX+pl02TitFVHfx+wiB3l45LSouvSgGCXInBya0UYHSDf/o28LGVEljVC2AjE/LCKhL47RuoOlK+XEsIUOblUg=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <639AC896023707479242B9ACBA926D99@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 788a5b7b-ae7c-48b9-8352-08d740c5bff6
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2019 08:03:56.7054
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vqju3ejIOfRPo3L32cU5QqU6FTvUOGgSEw9f6EJS4TSfSTmKmKkXH4caJ5zZE29SzzQyLRkKWcT/SJu0cd08UA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6896
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Sep 24, 2019 at 11:56:07AM +0800, Ying Liu wrote:
> Hi,
>=20
> On Mon, Sep 23, 2019 at 10:22 PM Laurentiu Palcu
> <laurentiu.palcu@nxp.com> wrote:
> >
> > This adds initial support for iMX8MQ's Display Controller Subsystem (DC=
SS).
> > Some of its capabilities include:
> >  * 4K@60fps;
> >  * HDR10;
> >  * one graphics and 2 video pipelines;
> >  * on-the-fly decompression of compressed video and graphics;
> >
> > The reference manual can be found here:
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fwww=
.nxp.com%2Fwebapp%2FDownload%3FcolCode%3DIMX8MDQLQRM&amp;data=3D02%7C01%7Cl=
aurentiu.palcu%40nxp.com%7C94b752dadd2e413c70d008d740a32979%7C686ea1d3bc2b4=
c6fa92cd99c5c301635%7C0%7C0%7C637048941849367464&amp;sdata=3DrsFNo5MGwdFGTA=
heU8YrJeRLvThpwbGG9bC9hKxCsm0%3D&amp;reserved=3D0
> >
> > The current patch adds only basic functionality: one primary plane for
> > graphics, linear, tiled and super-tiled buffers support (no graphics
> > decompression yet), no HDR10 and no video planes.
> >
> > Video planes support and HDR10 will be added in subsequent patches once
> > per-plane de-gamma/CSC/gamma support is in.
> >
> > Signed-off-by: Laurentiu Palcu <laurentiu.palcu@nxp.com>
> > ---
> >  drivers/gpu/drm/imx/Kconfig            |   2 +
> >  drivers/gpu/drm/imx/Makefile           |   1 +
> >  drivers/gpu/drm/imx/dcss/Kconfig       |   7 +
> >  drivers/gpu/drm/imx/dcss/Makefile      |   6 +
> >  drivers/gpu/drm/imx/dcss/dcss-blkctl.c |  75 +++
> >  drivers/gpu/drm/imx/dcss/dcss-crtc.c   | 223 +++++++++
> >  drivers/gpu/drm/imx/dcss/dcss-ctxld.c  | 447 ++++++++++++++++++
> >  drivers/gpu/drm/imx/dcss/dcss-dev.c    | 286 ++++++++++++
> >  drivers/gpu/drm/imx/dcss/dcss-dev.h    | 195 ++++++++
> >  drivers/gpu/drm/imx/dcss/dcss-dpr.c    | 552 ++++++++++++++++++++++
> >  drivers/gpu/drm/imx/dcss/dcss-drv.c    | 182 ++++++++
> >  drivers/gpu/drm/imx/dcss/dcss-dtg.c    | 438 +++++++++++++++++
> >  drivers/gpu/drm/imx/dcss/dcss-kms.c    | 321 +++++++++++++
> >  drivers/gpu/drm/imx/dcss/dcss-kms.h    |  52 +++
> >  drivers/gpu/drm/imx/dcss/dcss-plane.c  | 418 +++++++++++++++++
> >  drivers/gpu/drm/imx/dcss/dcss-scaler.c | 830 +++++++++++++++++++++++++=
++++++++
> >  drivers/gpu/drm/imx/dcss/dcss-ss.c     | 179 +++++++
> >  17 files changed, 4214 insertions(+)
> >  create mode 100644 drivers/gpu/drm/imx/dcss/Kconfig
> >  create mode 100644 drivers/gpu/drm/imx/dcss/Makefile
> >  create mode 100644 drivers/gpu/drm/imx/dcss/dcss-blkctl.c
> >  create mode 100644 drivers/gpu/drm/imx/dcss/dcss-crtc.c
> >  create mode 100644 drivers/gpu/drm/imx/dcss/dcss-ctxld.c
> >  create mode 100644 drivers/gpu/drm/imx/dcss/dcss-dev.c
> >  create mode 100644 drivers/gpu/drm/imx/dcss/dcss-dev.h
> >  create mode 100644 drivers/gpu/drm/imx/dcss/dcss-dpr.c
>=20
> DPR embedded in i.MX8QM & i.MX8QXP SoCs has
> compatible register definitions with the one in i.MX8MQ.
> Together with PRG(Prefetch Resolve Gasket), DPR serves
> the display controller DPU of i.MX8QM & i.MX8QXP SoCs
> as the prefetch engine.  IMHO, there should be a separate
> DPR driver which stands out side of the dcss directory and
> has DT compatible strings for i.MX8MQ, i.MX8QM and
> i.MX8QXP SoCs.

Yes, DPR is pretty much the same for those platforms, register wise.
However, DCSS will do all DPR programming through the context loader
engine (DCSS specific), whereas DPU does not. DPU's DPR can handle VPU
tiled formats, whereas DCSS's does not. For that, DCSS has a DTRC
(decompression and tile to raster conversion) module in front of DPR,
hence the DPR programming needs some adjustments when
tiled/tiled-compressed video buffers are used.

Your idea is great, when it comes to removing some code duplication.
But if, after this process, we end up with an overly complicated piece
of code that needs to address different platform particularities, I'd
prefer to keep things separate. The code will be easier to read and
maintain.

Thanks,
laurentiu


>=20
> >  create mode 100644 drivers/gpu/drm/imx/dcss/dcss-drv.c
> >  create mode 100644 drivers/gpu/drm/imx/dcss/dcss-dtg.c
> >  create mode 100644 drivers/gpu/drm/imx/dcss/dcss-kms.c
> >  create mode 100644 drivers/gpu/drm/imx/dcss/dcss-kms.h
> >  create mode 100644 drivers/gpu/drm/imx/dcss/dcss-plane.c
> >  create mode 100644 drivers/gpu/drm/imx/dcss/dcss-scaler.c
> >  create mode 100644 drivers/gpu/drm/imx/dcss/dcss-ss.c
> >
> > diff --git a/drivers/gpu/drm/imx/Kconfig b/drivers/gpu/drm/imx/Kconfig
> > index 207bf74..6231048 100644
> > --- a/drivers/gpu/drm/imx/Kconfig
> > +++ b/drivers/gpu/drm/imx/Kconfig
> > @@ -39,3 +39,5 @@ config DRM_IMX_HDMI
> >         depends on DRM_IMX
> >         help
> >           Choose this if you want to use HDMI on i.MX6.
> > +
> > +source "drivers/gpu/drm/imx/dcss/Kconfig"
> > diff --git a/drivers/gpu/drm/imx/Makefile b/drivers/gpu/drm/imx/Makefil=
e
> > index 21cdcc2..b644def 100644
> > --- a/drivers/gpu/drm/imx/Makefile
> > +++ b/drivers/gpu/drm/imx/Makefile
> > @@ -9,3 +9,4 @@ obj-$(CONFIG_DRM_IMX_TVE) +=3D imx-tve.o
> >  obj-$(CONFIG_DRM_IMX_LDB) +=3D imx-ldb.o
> >
> >  obj-$(CONFIG_DRM_IMX_HDMI) +=3D dw_hdmi-imx.o
> > +obj-$(CONFIG_DRM_IMX_DCSS) +=3D dcss/
> > diff --git a/drivers/gpu/drm/imx/dcss/Kconfig b/drivers/gpu/drm/imx/dcs=
s/Kconfig
> > new file mode 100644
> > index 00000000..6399c12
> > --- /dev/null
> > +++ b/drivers/gpu/drm/imx/dcss/Kconfig
> > @@ -0,0 +1,7 @@
> > +config DRM_IMX_DCSS
> > +       tristate "i.MX8MQ DCSS"
> > +       select RESET_CONTROLLER
> > +       select IMX_IRQSTEER
> > +       help
> > +         Choose this if you have a NXP i.MX8MQ based system and want t=
o use the
> > +         Display Controller Subsystem. This option enables DCSS suppor=
t.
> > diff --git a/drivers/gpu/drm/imx/dcss/Makefile b/drivers/gpu/drm/imx/dc=
ss/Makefile
> > new file mode 100644
> > index 00000000..8c7c8da
> > --- /dev/null
> > +++ b/drivers/gpu/drm/imx/dcss/Makefile
> > @@ -0,0 +1,6 @@
> > +imx-dcss-objs :=3D dcss-drv.o dcss-dev.o dcss-blkctl.o dcss-ctxld.o dc=
ss-dtg.o \
> > +                                dcss-ss.o dcss-dpr.o dcss-scaler.o dcs=
s-kms.o dcss-crtc.o \
> > +                                dcss-plane.o
> > +
> > +obj-$(CONFIG_DRM_IMX_DCSS) +=3D imx-dcss.o
> > +
> > diff --git a/drivers/gpu/drm/imx/dcss/dcss-blkctl.c b/drivers/gpu/drm/i=
mx/dcss/dcss-blkctl.c
> > new file mode 100644
> > index 00000000..ee7ffa1
> > --- /dev/null
> > +++ b/drivers/gpu/drm/imx/dcss/dcss-blkctl.c
> > @@ -0,0 +1,75 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright 2019 NXP.
> > + */
> > +
> > +#include <linux/device.h>
> > +#include <linux/of.h>
> > +
> > +#include "dcss-dev.h"
> > +
> > +#define DCSS_BLKCTL_RESET_CTRL         0x00
> > +#define   B_CLK_RESETN                 BIT(0)
> > +#define   APB_CLK_RESETN               BIT(1)
> > +#define   P_CLK_RESETN                 BIT(2)
> > +#define   RTR_CLK_RESETN               BIT(3)
> > +#define DCSS_BLKCTL_CONTROL0           0x10
> > +#define   HDMI_MIPI_CLK_SEL            BIT(0)
> > +#define   DISPMIX_REFCLK_SEL_POS       4
> > +#define   DISPMIX_REFCLK_SEL_MASK      GENMASK(5, 4)
> > +#define   DISPMIX_PIXCLK_SEL           BIT(8)
> > +#define   HDMI_SRC_SECURE_EN           BIT(16)
> > +
> > +struct dcss_blkctl {
> > +       struct device *dev;
> > +       void __iomem *base_reg;
> > +
> > +       bool hdmi_output;
> > +};
> > +
> > +void dcss_blkctl_cfg(struct dcss_blkctl *blkctl)
> > +{
> > +       if (blkctl->hdmi_output)
> > +               dcss_writel(0, blkctl->base_reg + DCSS_BLKCTL_CONTROL0)=
;
> > +       else
> > +               dcss_writel(DISPMIX_PIXCLK_SEL,
> > +                           blkctl->base_reg + DCSS_BLKCTL_CONTROL0);
> > +
> > +       dcss_set(B_CLK_RESETN | APB_CLK_RESETN | P_CLK_RESETN | RTR_CLK=
_RESETN,
> > +                blkctl->base_reg + DCSS_BLKCTL_RESET_CTRL);
> > +}
> > +
> > +int dcss_blkctl_init(struct dcss_dev *dcss, unsigned long blkctl_base)
> > +{
> > +       struct dcss_blkctl *blkctl;
> > +
> > +       blkctl =3D devm_kzalloc(dcss->dev, sizeof(*blkctl), GFP_KERNEL)=
;
> > +       if (!blkctl)
> > +               return -ENOMEM;
> > +
> > +       blkctl->base_reg =3D devm_ioremap(dcss->dev, blkctl_base, SZ_4K=
);
> > +       if (!blkctl->base_reg) {
> > +               dev_err(dcss->dev, "unable to remap BLK CTRL base\n");
> > +               devm_kfree(dcss->dev, blkctl);
> > +               return -ENOMEM;
> > +       }
> > +
> > +       dcss->blkctl =3D blkctl;
> > +       blkctl->dev =3D dcss->dev;
> > +       blkctl->hdmi_output =3D dcss->hdmi_output;
> > +
> > +       dcss_blkctl_cfg(blkctl);
> > +
> > +       return 0;
> > +}
> > +
> > +void dcss_blkctl_exit(struct dcss_blkctl *blkctl)
> > +{
> > +       dcss_clr(P_CLK_RESETN | RTR_CLK_RESETN,
> > +                blkctl->base_reg + DCSS_BLKCTL_RESET_CTRL);
> > +
> > +       if (blkctl->base_reg)
> > +               devm_iounmap(blkctl->dev, blkctl->base_reg);
> > +
> > +       devm_kfree(blkctl->dev, blkctl);
> > +}
> > diff --git a/drivers/gpu/drm/imx/dcss/dcss-crtc.c b/drivers/gpu/drm/imx=
/dcss/dcss-crtc.c
> > new file mode 100644
> > index 00000000..6abb40c
> > --- /dev/null
> > +++ b/drivers/gpu/drm/imx/dcss/dcss-crtc.c
> > @@ -0,0 +1,223 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright 2019 NXP.
> > + */
> > +
> > +#include <drm/drmP.h>
> > +#include <drm/drm_atomic_helper.h>
> > +#include <linux/pm_runtime.h>
> > +
> > +#include "dcss-dev.h"
> > +#include "dcss-kms.h"
> > +
> > +static int dcss_enable_vblank(struct drm_crtc *crtc)
> > +{
> > +       struct dcss_crtc *dcss_crtc =3D container_of(crtc, struct dcss_=
crtc,
> > +                                                  base);
> > +       struct dcss_dev *dcss =3D crtc->dev->dev_private;
> > +
> > +       if (dcss_crtc->irq_enabled)
> > +               return 0;
> > +
> > +       dcss_crtc->irq_enabled =3D true;
> > +
> > +       dcss_dtg_vblank_irq_enable(dcss->dtg, true);
> > +
> > +       dcss_dtg_ctxld_kick_irq_enable(dcss->dtg, true);
> > +
> > +       enable_irq(dcss_crtc->irq);
> > +
> > +       return 0;
> > +}
> > +
> > +static void dcss_disable_vblank(struct drm_crtc *crtc)
> > +{
> > +       struct dcss_crtc *dcss_crtc =3D container_of(crtc, struct dcss_=
crtc,
> > +                                                  base);
> > +       struct dcss_dev *dcss =3D dcss_crtc->base.dev->dev_private;
> > +
> > +       disable_irq_nosync(dcss_crtc->irq);
> > +
> > +       dcss_dtg_vblank_irq_enable(dcss->dtg, false);
> > +
> > +       dcss_dtg_ctxld_kick_irq_enable(dcss->dtg, false);
> > +
> > +       dcss_crtc->irq_enabled =3D false;
> > +}
> > +
> > +static const struct drm_crtc_funcs dcss_crtc_funcs =3D {
> > +       .set_config =3D drm_atomic_helper_set_config,
> > +       .destroy =3D drm_crtc_cleanup,
> > +       .page_flip =3D drm_atomic_helper_page_flip,
> > +       .reset =3D drm_atomic_helper_crtc_reset,
> > +       .atomic_duplicate_state =3D drm_atomic_helper_crtc_duplicate_st=
ate,
> > +       .atomic_destroy_state =3D drm_atomic_helper_crtc_destroy_state,
> > +       .enable_vblank =3D dcss_enable_vblank,
> > +       .disable_vblank =3D dcss_disable_vblank,
> > +};
> > +
> > +static void dcss_crtc_atomic_begin(struct drm_crtc *crtc,
> > +                                  struct drm_crtc_state *old_crtc_stat=
e)
> > +{
> > +       drm_crtc_vblank_on(crtc);
> > +
> > +       spin_lock_irq(&crtc->dev->event_lock);
> > +       if (crtc->state->event) {
> > +               WARN_ON(drm_crtc_vblank_get(crtc));
> > +               drm_crtc_arm_vblank_event(crtc, crtc->state->event);
> > +               crtc->state->event =3D NULL;
> > +       }
> > +       spin_unlock_irq(&crtc->dev->event_lock);
> > +}
> > +
> > +static void dcss_crtc_atomic_flush(struct drm_crtc *crtc,
> > +                                  struct drm_crtc_state *old_crtc_stat=
e)
> > +{
> > +       struct dcss_crtc *dcss_crtc =3D container_of(crtc, struct dcss_=
crtc,
> > +                                                  base);
> > +       struct dcss_dev *dcss =3D dcss_crtc->base.dev->dev_private;
> > +
> > +       if (dcss_dtg_is_enabled(dcss->dtg))
> > +               dcss_ctxld_enable(dcss->ctxld);
> > +}
> > +
> > +static void dcss_crtc_atomic_enable(struct drm_crtc *crtc,
> > +                                   struct drm_crtc_state *old_crtc_sta=
te)
> > +{
> > +       struct dcss_crtc *dcss_crtc =3D container_of(crtc, struct dcss_=
crtc,
> > +                                                  base);
> > +       struct dcss_dev *dcss =3D dcss_crtc->base.dev->dev_private;
> > +       struct drm_display_mode *mode =3D &crtc->state->adjusted_mode;
> > +       struct videomode vm;
> > +
> > +       drm_display_mode_to_videomode(mode, &vm);
> > +
> > +       pm_runtime_get_sync(dcss->dev);
> > +
> > +       dcss_dtg_ctxld_kick_irq_enable(dcss->dtg, true);
> > +
> > +       vm.pixelclock =3D mode->crtc_clock * 1000;
> > +
> > +       dcss_dtg_sync_set(dcss->dtg, &vm);
> > +
> > +       dcss_ss_subsam_set(dcss->ss);
> > +       dcss_ss_sync_set(dcss->ss, &vm, mode->flags & DRM_MODE_FLAG_PHS=
YNC,
> > +                        mode->flags & DRM_MODE_FLAG_PVSYNC);
> > +
> > +       dcss_dtg_css_set(dcss->dtg);
> > +
> > +       dcss_ss_enable(dcss->ss);
> > +       dcss_dtg_enable(dcss->dtg, true, NULL);
> > +       dcss_ctxld_enable(dcss->ctxld);
> > +
> > +       reinit_completion(&dcss_crtc->en_completion);
> > +       wait_for_completion_timeout(&dcss_crtc->en_completion,
> > +                                   msecs_to_jiffies(500));
> > +}
> > +
> > +static void dcss_crtc_atomic_disable(struct drm_crtc *crtc,
> > +                                    struct drm_crtc_state *old_crtc_st=
ate)
> > +{
> > +       struct dcss_crtc *dcss_crtc =3D container_of(crtc, struct dcss_=
crtc,
> > +                                                  base);
> > +       struct dcss_dev *dcss =3D dcss_crtc->base.dev->dev_private;
> > +
> > +       drm_atomic_helper_disable_planes_on_crtc(old_crtc_state, false)=
;
> > +
> > +       spin_lock_irq(&crtc->dev->event_lock);
> > +       if (crtc->state->event) {
> > +               drm_crtc_send_vblank_event(crtc, crtc->state->event);
> > +               crtc->state->event =3D NULL;
> > +       }
> > +       spin_unlock_irq(&crtc->dev->event_lock);
> > +
> > +       dcss_dtg_ctxld_kick_irq_enable(dcss->dtg, true);
> > +
> > +       dcss_ss_disable(dcss->ss);
> > +       dcss_dtg_enable(dcss->dtg, false, &dcss_crtc->dis_completion);
> > +       dcss_ctxld_enable(dcss->ctxld);
> > +
> > +       reinit_completion(&dcss_crtc->dis_completion);
> > +       wait_for_completion_timeout(&dcss_crtc->dis_completion,
> > +                                   msecs_to_jiffies(100));
> > +
> > +       drm_crtc_vblank_off(crtc);
> > +
> > +       dcss_dtg_ctxld_kick_irq_enable(dcss->dtg, false);
> > +
> > +       pm_runtime_put_sync(dcss->dev);
> > +}
> > +
> > +static const struct drm_crtc_helper_funcs dcss_helper_funcs =3D {
> > +       .atomic_begin =3D dcss_crtc_atomic_begin,
> > +       .atomic_flush =3D dcss_crtc_atomic_flush,
> > +       .atomic_enable =3D dcss_crtc_atomic_enable,
> > +       .atomic_disable =3D dcss_crtc_atomic_disable,
> > +};
> > +
> > +static irqreturn_t dcss_crtc_irq_handler(int irq, void *dev_id)
> > +{
> > +       struct dcss_crtc *dcss_crtc =3D dev_id;
> > +       struct dcss_dev *dcss =3D dcss_crtc->base.dev->dev_private;
> > +
> > +       if (!dcss_dtg_vblank_irq_valid(dcss->dtg))
> > +               return IRQ_HANDLED;
> > +
> > +       complete(&dcss_crtc->en_completion);
> > +
> > +       if (dcss_ctxld_is_flushed(dcss->ctxld))
> > +               drm_crtc_handle_vblank(&dcss_crtc->base);
> > +
> > +       dcss_dtg_vblank_irq_clear(dcss->dtg);
> > +
> > +       return IRQ_HANDLED;
> > +}
> > +
> > +int dcss_crtc_init(struct dcss_crtc *crtc, struct drm_device *drm)
> > +{
> > +       struct dcss_dev *dcss =3D drm->dev_private;
> > +       struct platform_device *pdev =3D to_platform_device(dcss->dev);
> > +       int ret;
> > +
> > +       crtc->plane[0] =3D dcss_plane_init(drm, drm_crtc_mask(&crtc->ba=
se),
> > +                                        DRM_PLANE_TYPE_PRIMARY, 0);
> > +       if (IS_ERR(crtc->plane[0]))
> > +               return PTR_ERR(crtc->plane[0]);
> > +
> > +       crtc->base.port =3D dcss->of_port;
> > +
> > +       drm_crtc_helper_add(&crtc->base, &dcss_helper_funcs);
> > +       ret =3D drm_crtc_init_with_planes(drm, &crtc->base, &crtc->plan=
e[0]->base,
> > +                                       NULL, &dcss_crtc_funcs, NULL);
> > +       if (ret) {
> > +               dev_err(dcss->dev, "failed to init crtc\n");
> > +               return ret;
> > +       }
> > +
> > +       crtc->irq =3D platform_get_irq_byname(pdev, "vblank");
> > +       if (crtc->irq < 0) {
> > +               dev_err(dcss->dev, "unable to get vblank interrupt\n");
> > +               return crtc->irq;
> > +       }
> > +
> > +       init_completion(&crtc->en_completion);
> > +       init_completion(&crtc->dis_completion);
> > +
> > +       ret =3D devm_request_irq(dcss->dev, crtc->irq, dcss_crtc_irq_ha=
ndler,
> > +                              IRQF_TRIGGER_RISING, "dcss_drm", crtc);
> > +       if (ret) {
> > +               dev_err(dcss->dev, "irq request failed with %d.\n", ret=
);
> > +               return ret;
> > +       }
> > +
> > +       disable_irq(crtc->irq);
> > +
> > +       return 0;
> > +}
> > +
> > +void dcss_crtc_deinit(struct dcss_crtc *crtc, struct drm_device *drm)
> > +{
> > +       struct dcss_dev *dcss =3D drm->dev_private;
> > +
> > +       devm_free_irq(dcss->dev, crtc->irq, crtc);
> > +}
> > diff --git a/drivers/gpu/drm/imx/dcss/dcss-ctxld.c b/drivers/gpu/drm/im=
x/dcss/dcss-ctxld.c
> > new file mode 100644
> > index 00000000..4fe35b2b
> > --- /dev/null
> > +++ b/drivers/gpu/drm/imx/dcss/dcss-ctxld.c
> > @@ -0,0 +1,447 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright 2019 NXP.
> > + */
> > +
> > +#include <linux/delay.h>
> > +#include <linux/dma-mapping.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/platform_device.h>
> > +
> > +#include "dcss-dev.h"
> > +
> > +#define DCSS_CTXLD_DEVNAME             "dcss_ctxld"
> > +
> > +#define DCSS_CTXLD_CONTROL_STATUS      0x0
> > +#define   CTXLD_ENABLE                 BIT(0)
> > +#define   ARB_SEL                      BIT(1)
> > +#define   RD_ERR_EN                    BIT(2)
> > +#define   DB_COMP_EN                   BIT(3)
> > +#define   SB_HP_COMP_EN                        BIT(4)
> > +#define   SB_LP_COMP_EN                        BIT(5)
> > +#define   DB_PEND_SB_REC_EN            BIT(6)
> > +#define   SB_PEND_DISP_ACTIVE_EN       BIT(7)
> > +#define   AHB_ERR_EN                   BIT(8)
> > +#define   RD_ERR                       BIT(16)
> > +#define   DB_COMP                      BIT(17)
> > +#define   SB_HP_COMP                   BIT(18)
> > +#define   SB_LP_COMP                   BIT(19)
> > +#define   DB_PEND_SB_REC               BIT(20)
> > +#define   SB_PEND_DISP_ACTIVE          BIT(21)
> > +#define   AHB_ERR                      BIT(22)
> > +#define DCSS_CTXLD_DB_BASE_ADDR                0x10
> > +#define DCSS_CTXLD_DB_COUNT            0x14
> > +#define DCSS_CTXLD_SB_BASE_ADDR                0x18
> > +#define DCSS_CTXLD_SB_COUNT            0x1C
> > +#define   SB_HP_COUNT_POS              0
> > +#define   SB_HP_COUNT_MASK             0xffff
> > +#define   SB_LP_COUNT_POS              16
> > +#define   SB_LP_COUNT_MASK             0xffff0000
> > +#define DCSS_AHB_ERR_ADDR              0x20
> > +
> > +#define CTXLD_IRQ_NAME                 "ctx_ld"
> > +#define CTXLD_IRQ_COMPLETION           (DB_COMP | SB_HP_COMP | SB_LP_C=
OMP)
> > +#define CTXLD_IRQ_ERROR                        (RD_ERR | DB_PEND_SB_RE=
C | AHB_ERR)
> > +
> > +/* The following sizes are in context loader entries, 8 bytes each. */
> > +#define CTXLD_DB_CTX_ENTRIES           1024    /* max 65536 */
> > +#define CTXLD_SB_LP_CTX_ENTRIES                10240   /* max 65536 */
> > +#define CTXLD_SB_HP_CTX_ENTRIES                20000   /* max 65536 */
> > +#define CTXLD_SB_CTX_ENTRIES           (CTXLD_SB_LP_CTX_ENTRIES + \
> > +                                        CTXLD_SB_HP_CTX_ENTRIES)
> > +
> > +/* Sizes, in entries, of the DB, SB_HP and SB_LP context regions. */
> > +static u16 dcss_ctxld_ctx_size[3] =3D {
> > +       CTXLD_DB_CTX_ENTRIES,
> > +       CTXLD_SB_HP_CTX_ENTRIES,
> > +       CTXLD_SB_LP_CTX_ENTRIES
> > +};
> > +
> > +/* this represents an entry in the context loader map */
> > +struct dcss_ctxld_item {
> > +       u32 val;
> > +       u32 ofs;
> > +};
> > +
> > +#define CTX_ITEM_SIZE                  sizeof(struct dcss_ctxld_item)
> > +
> > +struct dcss_ctxld {
> > +       struct device *dev;
> > +       void __iomem *ctxld_reg;
> > +       int irq;
> > +       bool irq_en;
> > +
> > +       struct dcss_ctxld_item *db[2];
> > +       struct dcss_ctxld_item *sb_hp[2];
> > +       struct dcss_ctxld_item *sb_lp[2];
> > +
> > +       dma_addr_t db_paddr[2];
> > +       dma_addr_t sb_paddr[2];
> > +
> > +       u16 ctx_size[2][3]; /* holds the sizes of DB, SB_HP and SB_LP c=
tx */
> > +       u8 current_ctx;
> > +
> > +       bool in_use;
> > +       bool armed;
> > +
> > +       spinlock_t lock; /* protects concurent access to private data *=
/
> > +
> > +       void (*dtg_disable_cb)(void *data);
> > +       void *dtg_disable_data;
> > +};
> > +
> > +static int __dcss_ctxld_enable(struct dcss_ctxld *ctxld);
> > +
> > +static irqreturn_t dcss_ctxld_irq_handler(int irq, void *data)
> > +{
> > +       struct dcss_ctxld *ctxld =3D data;
> > +       u32 irq_status;
> > +
> > +       irq_status =3D dcss_readl(ctxld->ctxld_reg + DCSS_CTXLD_CONTROL=
_STATUS);
> > +
> > +       if (irq_status & CTXLD_IRQ_COMPLETION &&
> > +           !(irq_status & CTXLD_ENABLE) && ctxld->in_use) {
> > +               ctxld->in_use =3D false;
> > +
> > +               if (ctxld->dtg_disable_cb) {
> > +                       ctxld->dtg_disable_cb(ctxld->dtg_disable_data);
> > +                       ctxld->dtg_disable_cb =3D NULL;
> > +                       ctxld->dtg_disable_data =3D NULL;
> > +               }
> > +       } else if (irq_status & CTXLD_IRQ_ERROR) {
> > +               /*
> > +                * Except for throwing an error message and clearing th=
e status
> > +                * register, there's not much we can do here.
> > +                */
> > +               dev_err(ctxld->dev, "ctxld: error encountered: %08x\n",
> > +                       irq_status);
> > +               dev_err(ctxld->dev, "ctxld: db=3D%d, sb_hp=3D%d, sb_lp=
=3D%d\n",
> > +                       ctxld->ctx_size[ctxld->current_ctx ^ 1][CTX_DB]=
,
> > +                       ctxld->ctx_size[ctxld->current_ctx ^ 1][CTX_SB_=
HP],
> > +                       ctxld->ctx_size[ctxld->current_ctx ^ 1][CTX_SB_=
LP]);
> > +       }
> > +
> > +       dcss_clr(irq_status & (CTXLD_IRQ_ERROR | CTXLD_IRQ_COMPLETION),
> > +                ctxld->ctxld_reg + DCSS_CTXLD_CONTROL_STATUS);
> > +
> > +       return IRQ_HANDLED;
> > +}
> > +
> > +static int dcss_ctxld_irq_config(struct dcss_ctxld *ctxld,
> > +                                struct platform_device *pdev)
> > +{
> > +       int ret;
> > +
> > +       ctxld->irq =3D platform_get_irq_byname(pdev, CTXLD_IRQ_NAME);
> > +       if (ctxld->irq < 0) {
> > +               dev_err(ctxld->dev, "ctxld: can't get irq number\n");
> > +               return ctxld->irq;
> > +       }
> > +
> > +       ret =3D devm_request_irq(ctxld->dev, ctxld->irq,
> > +                              dcss_ctxld_irq_handler,
> > +                              IRQF_ONESHOT | IRQF_TRIGGER_HIGH,
> > +                              DCSS_CTXLD_DEVNAME, ctxld);
> > +       if (ret) {
> > +               dev_err(ctxld->dev, "ctxld: irq request failed.\n");
> > +               return ret;
> > +       }
> > +
> > +       ctxld->irq_en =3D true;
> > +
> > +       return 0;
> > +}
> > +
> > +void dcss_ctxld_hw_cfg(struct dcss_ctxld *ctxld)
> > +{
> > +       dcss_writel(RD_ERR_EN | SB_HP_COMP_EN |
> > +                   DB_PEND_SB_REC_EN | AHB_ERR_EN | RD_ERR | AHB_ERR,
> > +                   ctxld->ctxld_reg + DCSS_CTXLD_CONTROL_STATUS);
> > +}
> > +
> > +static void dcss_ctxld_free_ctx(struct dcss_ctxld *ctxld)
> > +{
> > +       struct dcss_ctxld_item *ctx;
> > +       int i;
> > +
> > +       for (i =3D 0; i < 2; i++) {
> > +               if (ctxld->db[i]) {
> > +                       dmam_free_coherent(ctxld->dev,
> > +                                          CTXLD_DB_CTX_ENTRIES * sizeo=
f(*ctx),
> > +                                          ctxld->db[i], ctxld->db_padd=
r[i]);
> > +                       ctxld->db[i] =3D NULL;
> > +                       ctxld->db_paddr[i] =3D 0;
> > +               }
> > +
> > +               if (ctxld->sb_hp[i]) {
> > +                       dmam_free_coherent(ctxld->dev,
> > +                                          CTXLD_SB_CTX_ENTRIES * sizeo=
f(*ctx),
> > +                                          ctxld->sb_hp[i], ctxld->sb_p=
addr[i]);
> > +                       ctxld->sb_hp[i] =3D NULL;
> > +                       ctxld->sb_paddr[i] =3D 0;
> > +               }
> > +       }
> > +}
> > +
> > +static int dcss_ctxld_alloc_ctx(struct dcss_ctxld *ctxld)
> > +{
> > +       struct dcss_ctxld_item *ctx;
> > +       int i;
> > +       dma_addr_t dma_handle;
> > +
> > +       for (i =3D 0; i < 2; i++) {
> > +               ctx =3D dmam_alloc_coherent(ctxld->dev,
> > +                                         CTXLD_DB_CTX_ENTRIES * sizeof=
(*ctx),
> > +                                         &dma_handle, GFP_KERNEL);
> > +               if (!ctx)
> > +                       return -ENOMEM;
> > +
> > +               ctxld->db[i] =3D ctx;
> > +               ctxld->db_paddr[i] =3D dma_handle;
> > +
> > +               ctx =3D dmam_alloc_coherent(ctxld->dev,
> > +                                         CTXLD_SB_CTX_ENTRIES * sizeof=
(*ctx),
> > +                                         &dma_handle, GFP_KERNEL);
> > +               if (!ctx)
> > +                       return -ENOMEM;
> > +
> > +               ctxld->sb_hp[i] =3D ctx;
> > +               ctxld->sb_lp[i] =3D ctx + CTXLD_SB_HP_CTX_ENTRIES;
> > +
> > +               ctxld->sb_paddr[i] =3D dma_handle;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +int dcss_ctxld_init(struct dcss_dev *dcss, unsigned long ctxld_base)
> > +{
> > +       struct dcss_ctxld *ctxld;
> > +       int ret;
> > +
> > +       ctxld =3D devm_kzalloc(dcss->dev, sizeof(struct dcss_ctxld),
> > +                            GFP_KERNEL);
> > +       if (!ctxld)
> > +               return -ENOMEM;
> > +
> > +       dcss->ctxld =3D ctxld;
> > +       ctxld->dev =3D dcss->dev;
> > +
> > +       spin_lock_init(&ctxld->lock);
> > +
> > +       ret =3D dcss_ctxld_alloc_ctx(ctxld);
> > +       if (ret) {
> > +               dev_err(dcss->dev, "ctxld: cannot allocate context memo=
ry.\n");
> > +               goto err;
> > +       }
> > +
> > +       ctxld->ctxld_reg =3D devm_ioremap(dcss->dev, ctxld_base, SZ_4K)=
;
> > +       if (!ctxld->ctxld_reg) {
> > +               dev_err(dcss->dev, "ctxld: unable to remap ctxld base\n=
");
> > +               ret =3D -ENOMEM;
> > +               goto err;
> > +       }
> > +
> > +       ret =3D dcss_ctxld_irq_config(ctxld, to_platform_device(dcss->d=
ev));
> > +       if (ret)
> > +               goto err_irq;
> > +
> > +       dcss_ctxld_hw_cfg(ctxld);
> > +
> > +       return 0;
> > +
> > +err_irq:
> > +       devm_iounmap(ctxld->dev, ctxld->ctxld_reg);
> > +
> > +err:
> > +       dcss_ctxld_free_ctx(ctxld);
> > +       devm_kfree(ctxld->dev, ctxld);
> > +
> > +       return ret;
> > +}
> > +
> > +void dcss_ctxld_exit(struct dcss_ctxld *ctxld)
> > +{
> > +       devm_free_irq(ctxld->dev, ctxld->irq, ctxld);
> > +
> > +       if (ctxld->ctxld_reg)
> > +               devm_iounmap(ctxld->dev, ctxld->ctxld_reg);
> > +
> > +       dcss_ctxld_free_ctx(ctxld);
> > +       devm_kfree(ctxld->dev, ctxld);
> > +}
> > +
> > +static int __dcss_ctxld_enable(struct dcss_ctxld *ctxld)
> > +{
> > +       int curr_ctx =3D ctxld->current_ctx;
> > +       u32 db_base, sb_base, sb_count;
> > +       u32 sb_hp_cnt, sb_lp_cnt, db_cnt;
> > +       struct dcss_dev *dcss =3D dcss_drv_dev_to_dcss(ctxld->dev);
> > +
> > +       dcss_dpr_write_sysctrl(dcss->dpr);
> > +
> > +       dcss_scaler_write_sclctrl(dcss->scaler);
> > +
> > +       sb_hp_cnt =3D ctxld->ctx_size[curr_ctx][CTX_SB_HP];
> > +       sb_lp_cnt =3D ctxld->ctx_size[curr_ctx][CTX_SB_LP];
> > +       db_cnt =3D ctxld->ctx_size[curr_ctx][CTX_DB];
> > +
> > +       /* make sure SB_LP context area comes after SB_HP */
> > +       if (sb_lp_cnt &&
> > +           ctxld->sb_lp[curr_ctx] !=3D ctxld->sb_hp[curr_ctx] + sb_hp_=
cnt) {
> > +               struct dcss_ctxld_item *sb_lp_adjusted;
> > +
> > +               sb_lp_adjusted =3D ctxld->sb_hp[curr_ctx] + sb_hp_cnt;
> > +
> > +               memcpy(sb_lp_adjusted, ctxld->sb_lp[curr_ctx],
> > +                      sb_lp_cnt * CTX_ITEM_SIZE);
> > +       }
> > +
> > +       db_base =3D db_cnt ? ctxld->db_paddr[curr_ctx] : 0;
> > +
> > +       dcss_writel(db_base, ctxld->ctxld_reg + DCSS_CTXLD_DB_BASE_ADDR=
);
> > +       dcss_writel(db_cnt, ctxld->ctxld_reg + DCSS_CTXLD_DB_COUNT);
> > +
> > +       if (sb_hp_cnt)
> > +               sb_count =3D ((sb_hp_cnt << SB_HP_COUNT_POS) & SB_HP_CO=
UNT_MASK) |
> > +                          ((sb_lp_cnt << SB_LP_COUNT_POS) & SB_LP_COUN=
T_MASK);
> > +       else
> > +               sb_count =3D (sb_lp_cnt << SB_HP_COUNT_POS) & SB_HP_COU=
NT_MASK;
> > +
> > +       sb_base =3D sb_count ? ctxld->sb_paddr[curr_ctx] : 0;
> > +
> > +       dcss_writel(sb_base, ctxld->ctxld_reg + DCSS_CTXLD_SB_BASE_ADDR=
);
> > +       dcss_writel(sb_count, ctxld->ctxld_reg + DCSS_CTXLD_SB_COUNT);
> > +
> > +       /* enable the context loader */
> > +       dcss_set(CTXLD_ENABLE, ctxld->ctxld_reg + DCSS_CTXLD_CONTROL_ST=
ATUS);
> > +
> > +       ctxld->in_use =3D true;
> > +
> > +       /*
> > +        * Toggle the current context to the alternate one so that any =
updates
> > +        * in the modules' settings take place there.
> > +        */
> > +       ctxld->current_ctx ^=3D 1;
> > +
> > +       ctxld->ctx_size[ctxld->current_ctx][CTX_DB] =3D 0;
> > +       ctxld->ctx_size[ctxld->current_ctx][CTX_SB_HP] =3D 0;
> > +       ctxld->ctx_size[ctxld->current_ctx][CTX_SB_LP] =3D 0;
> > +
> > +       return 0;
> > +}
> > +
> > +int dcss_ctxld_enable(struct dcss_ctxld *ctxld)
> > +{
> > +       unsigned long flags;
> > +
> > +       spin_lock_irqsave(&ctxld->lock, flags);
> > +       ctxld->armed =3D true;
> > +       spin_unlock_irqrestore(&ctxld->lock, flags);
> > +
> > +       return 0;
> > +}
> > +
> > +void dcss_ctxld_kick(struct dcss_ctxld *ctxld)
> > +{
> > +       unsigned long flags;
> > +
> > +       spin_lock_irqsave(&ctxld->lock, flags);
> > +       if (ctxld->armed && !ctxld->in_use) {
> > +               ctxld->armed =3D false;
> > +               __dcss_ctxld_enable(ctxld);
> > +       }
> > +       spin_unlock_irqrestore(&ctxld->lock, flags);
> > +}
> > +
> > +void dcss_ctxld_write_irqsafe(struct dcss_ctxld *ctxld, u32 ctx_id, u3=
2 val,
> > +                             u32 reg_ofs)
> > +{
> > +       int curr_ctx =3D ctxld->current_ctx;
> > +       struct dcss_ctxld_item *ctx[] =3D {
> > +               [CTX_DB] =3D ctxld->db[curr_ctx],
> > +               [CTX_SB_HP] =3D ctxld->sb_hp[curr_ctx],
> > +               [CTX_SB_LP] =3D ctxld->sb_lp[curr_ctx]
> > +       };
> > +       int item_idx =3D ctxld->ctx_size[curr_ctx][ctx_id];
> > +
> > +       if (item_idx + 1 > dcss_ctxld_ctx_size[ctx_id]) {
> > +               WARN_ON(1);
> > +               return;
> > +       }
> > +
> > +       ctx[ctx_id][item_idx].val =3D val;
> > +       ctx[ctx_id][item_idx].ofs =3D reg_ofs;
> > +       ctxld->ctx_size[curr_ctx][ctx_id] +=3D 1;
> > +}
> > +
> > +void dcss_ctxld_write(struct dcss_ctxld *ctxld, u32 ctx_id,
> > +                     u32 val, u32 reg_ofs)
> > +{
> > +       unsigned long flags;
> > +
> > +       spin_lock_irqsave(&ctxld->lock, flags);
> > +       dcss_ctxld_write_irqsafe(ctxld, ctx_id, val, reg_ofs);
> > +       spin_unlock_irqrestore(&ctxld->lock, flags);
> > +}
> > +
> > +bool dcss_ctxld_is_flushed(struct dcss_ctxld *ctxld)
> > +{
> > +       return ctxld->ctx_size[ctxld->current_ctx][CTX_DB] =3D=3D 0 &&
> > +               ctxld->ctx_size[ctxld->current_ctx][CTX_SB_HP] =3D=3D 0=
 &&
> > +               ctxld->ctx_size[ctxld->current_ctx][CTX_SB_LP] =3D=3D 0=
;
> > +}
> > +
> > +int dcss_ctxld_resume(struct dcss_ctxld *ctxld)
> > +{
> > +       dcss_ctxld_hw_cfg(ctxld);
> > +
> > +       if (!ctxld->irq_en) {
> > +               enable_irq(ctxld->irq);
> > +               ctxld->irq_en =3D true;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +int dcss_ctxld_suspend(struct dcss_ctxld *ctxld)
> > +{
> > +       int ret =3D 0;
> > +       int wait_time_ms =3D 0;
> > +       unsigned long flags;
> > +
> > +       dcss_ctxld_kick(ctxld);
> > +
> > +       while (ctxld->in_use && wait_time_ms < 500) {
> > +               msleep(20);
> > +               wait_time_ms +=3D 20;
> > +       }
> > +
> > +       if (wait_time_ms > 500)
> > +               return -ETIMEDOUT;
> > +
> > +       spin_lock_irqsave(&ctxld->lock, flags);
> > +
> > +       if (ctxld->irq_en) {
> > +               disable_irq_nosync(ctxld->irq);
> > +               ctxld->irq_en =3D false;
> > +       }
> > +
> > +       /* reset context region and sizes */
> > +       ctxld->current_ctx =3D 0;
> > +       ctxld->ctx_size[0][CTX_DB] =3D 0;
> > +       ctxld->ctx_size[0][CTX_SB_HP] =3D 0;
> > +       ctxld->ctx_size[0][CTX_SB_LP] =3D 0;
> > +
> > +       spin_unlock_irqrestore(&ctxld->lock, flags);
> > +
> > +       return ret;
> > +}
> > +
> > +void dcss_ctxld_register_dtg_disable_cb(struct dcss_ctxld *ctxld,
> > +                                       void (*cb)(void *),
> > +                                       void *data)
> > +{
> > +       ctxld->dtg_disable_cb =3D cb;
> > +       ctxld->dtg_disable_data =3D data;
> > +}
> > diff --git a/drivers/gpu/drm/imx/dcss/dcss-dev.c b/drivers/gpu/drm/imx/=
dcss/dcss-dev.c
> > new file mode 100644
> > index 00000000..265bf3c
> > --- /dev/null
> > +++ b/drivers/gpu/drm/imx/dcss/dcss-dev.c
> > @@ -0,0 +1,286 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright 2019 NXP.
> > + */
> > +
> > +#include <linux/clk.h>
> > +#include <linux/of_device.h>
> > +#include <linux/of_graph.h>
> > +#include <linux/pm_runtime.h>
> > +#include <drm/drm_modeset_helper.h>
> > +
> > +#include "dcss-dev.h"
> > +
> > +static void dcss_clocks_enable(struct dcss_dev *dcss)
> > +{
> > +       if (dcss->clks_on)
> > +               return;
> > +
> > +       clk_prepare_enable(dcss->axi_clk);
> > +       clk_prepare_enable(dcss->apb_clk);
> > +       clk_prepare_enable(dcss->rtrm_clk);
> > +       clk_prepare_enable(dcss->dtrc_clk);
> > +       clk_prepare_enable(dcss->pix_clk);
> > +
> > +       dcss->clks_on =3D true;
> > +}
> > +
> > +static void dcss_clocks_disable(struct dcss_dev *dcss)
> > +{
> > +       if (!dcss->clks_on)
> > +               return;
> > +
> > +       clk_disable_unprepare(dcss->pix_clk);
> > +       clk_disable_unprepare(dcss->dtrc_clk);
> > +       clk_disable_unprepare(dcss->rtrm_clk);
> > +       clk_disable_unprepare(dcss->apb_clk);
> > +       clk_disable_unprepare(dcss->axi_clk);
> > +
> > +       dcss->clks_on =3D false;
> > +}
> > +
> > +static int dcss_submodules_init(struct dcss_dev *dcss)
> > +{
> > +       int ret =3D 0;
> > +       u32 base_addr =3D dcss->start_addr;
> > +       const struct dcss_type_data *devtype =3D dcss->devtype;
> > +
> > +       dcss_clocks_enable(dcss);
> > +
> > +       ret =3D dcss_blkctl_init(dcss, base_addr + devtype->blkctl_ofs)=
;
> > +       if (ret)
> > +               return ret;
> > +
> > +       ret =3D dcss_ctxld_init(dcss, base_addr + devtype->ctxld_ofs);
> > +       if (ret)
> > +               goto ctxld_err;
> > +
> > +       ret =3D dcss_dtg_init(dcss, base_addr + devtype->dtg_ofs);
> > +       if (ret)
> > +               goto dtg_err;
> > +
> > +       ret =3D dcss_ss_init(dcss, base_addr + devtype->ss_ofs);
> > +       if (ret)
> > +               goto ss_err;
> > +
> > +       ret =3D dcss_dpr_init(dcss, base_addr + devtype->dpr_ofs);
> > +       if (ret)
> > +               goto dpr_err;
> > +
> > +       ret =3D dcss_scaler_init(dcss, base_addr + devtype->scaler_ofs)=
;
> > +       if (ret)
> > +               goto scaler_err;
> > +
> > +       return 0;
> > +
> > +scaler_err:
> > +       dcss_dpr_exit(dcss->dpr);
> > +
> > +dpr_err:
> > +       dcss_ss_exit(dcss->ss);
> > +
> > +ss_err:
> > +       dcss_dtg_exit(dcss->dtg);
> > +
> > +dtg_err:
> > +       dcss_ctxld_exit(dcss->ctxld);
> > +
> > +ctxld_err:
> > +       dcss_blkctl_exit(dcss->blkctl);
> > +
> > +       dcss_clocks_disable(dcss);
> > +
> > +       return ret;
> > +}
> > +
> > +static void dcss_submodules_stop(struct dcss_dev *dcss)
> > +{
> > +       dcss_clocks_enable(dcss);
> > +       dcss_scaler_exit(dcss->scaler);
> > +       dcss_dpr_exit(dcss->dpr);
> > +       dcss_ss_exit(dcss->ss);
> > +       dcss_dtg_exit(dcss->dtg);
> > +       dcss_ctxld_exit(dcss->ctxld);
> > +       dcss_blkctl_exit(dcss->blkctl);
> > +       dcss_clocks_disable(dcss);
> > +}
> > +
> > +static int dcss_clks_init(struct dcss_dev *dcss)
> > +{
> > +       int i;
> > +       struct {
> > +               const char *id;
> > +               struct clk **clk;
> > +       } clks[] =3D {
> > +               {"apb",   &dcss->apb_clk},
> > +               {"axi",   &dcss->axi_clk},
> > +               {"pix",   &dcss->pix_clk},
> > +               {"rtrm",  &dcss->rtrm_clk},
> > +               {"dtrc",  &dcss->dtrc_clk},
> > +       };
> > +
> > +       for (i =3D 0; i < ARRAY_SIZE(clks); i++) {
> > +               *clks[i].clk =3D devm_clk_get(dcss->dev, clks[i].id);
> > +               if (IS_ERR(*clks[i].clk)) {
> > +                       dev_err(dcss->dev, "failed to get %s clock\n",
> > +                               clks[i].id);
> > +                       return PTR_ERR(*clks[i].clk);
> > +               }
> > +       }
> > +
> > +       dcss->clks_on =3D false;
> > +
> > +       return 0;
> > +}
> > +
> > +static void dcss_clks_release(struct dcss_dev *dcss)
> > +{
> > +       devm_clk_put(dcss->dev, dcss->dtrc_clk);
> > +       devm_clk_put(dcss->dev, dcss->rtrm_clk);
> > +       devm_clk_put(dcss->dev, dcss->pix_clk);
> > +       devm_clk_put(dcss->dev, dcss->axi_clk);
> > +       devm_clk_put(dcss->dev, dcss->apb_clk);
> > +}
> > +
> > +struct dcss_dev *dcss_dev_create(struct device *dev, bool hdmi_output)
> > +{
> > +       struct platform_device *pdev =3D to_platform_device(dev);
> > +       int ret;
> > +       struct resource *res;
> > +       struct dcss_dev *dcss;
> > +       const struct dcss_type_data *devtype;
> > +
> > +       devtype =3D of_device_get_match_data(dev);
> > +       if (!devtype) {
> > +               dev_err(dev, "no device match found\n");
> > +               return ERR_PTR(-ENODEV);
> > +       }
> > +
> > +       res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +       if (!res) {
> > +               dev_err(dev, "cannot get memory resource\n");
> > +               return ERR_PTR(-EINVAL);
> > +       }
> > +
> > +       dcss =3D devm_kzalloc(dev, sizeof(struct dcss_dev), GFP_KERNEL)=
;
> > +       if (!dcss)
> > +               return ERR_PTR(-ENOMEM);
> > +
> > +       dcss->dev =3D dev;
> > +       dcss->devtype =3D devtype;
> > +       dcss->hdmi_output =3D hdmi_output;
> > +
> > +       ret =3D dcss_clks_init(dcss);
> > +       if (ret) {
> > +               dev_err(dev, "clocks initialization failed\n");
> > +               goto err;
> > +       }
> > +
> > +       dcss->of_port =3D of_graph_get_port_by_id(dev->of_node, 0);
> > +       if (!dcss->of_port) {
> > +               dev_err(dev, "no port@0 node in %s\n", dev->of_node->fu=
ll_name);
> > +               ret =3D -ENODEV;
> > +               goto clks_err;
> > +       }
> > +
> > +       dcss->start_addr =3D res->start;
> > +
> > +       ret =3D dcss_submodules_init(dcss);
> > +       if (ret) {
> > +               dev_err(dev, "submodules initialization failed\n");
> > +               goto clks_err;
> > +       }
> > +
> > +       pm_runtime_enable(dev);
> > +
> > +       return dcss;
> > +
> > +clks_err:
> > +       dcss_clks_release(dcss);
> > +
> > +err:
> > +       devm_kfree(dcss->dev, dcss);
> > +
> > +       return ERR_PTR(ret);
> > +}
> > +
> > +void dcss_dev_destroy(struct dcss_dev *dcss)
> > +{
> > +       pm_runtime_disable(dcss->dev);
> > +
> > +       dcss_submodules_stop(dcss);
> > +
> > +       dcss_clks_release(dcss);
> > +
> > +       devm_kfree(dcss->dev, dcss);
> > +}
> > +
> > +#ifdef CONFIG_PM_SLEEP
> > +int dcss_dev_suspend(struct device *dev)
> > +{
> > +       struct dcss_dev *dcss =3D dcss_drv_dev_to_dcss(dev);
> > +       int ret;
> > +
> > +       drm_mode_config_helper_suspend(dcss_drv_dev_to_drm(dev));
> > +
> > +       if (pm_runtime_suspended(dev))
> > +               return 0;
> > +
> > +       ret =3D dcss_ctxld_suspend(dcss->ctxld);
> > +       if (ret)
> > +               return ret;
> > +
> > +       dcss_clocks_disable(dcss);
> > +
> > +       return 0;
> > +}
> > +
> > +int dcss_dev_resume(struct device *dev)
> > +{
> > +       struct dcss_dev *dcss =3D dcss_drv_dev_to_dcss(dev);
> > +
> > +       if (pm_runtime_suspended(dev)) {
> > +               drm_mode_config_helper_resume(dcss_drv_dev_to_drm(dev))=
;
> > +               return 0;
> > +       }
> > +
> > +       dcss_clocks_enable(dcss);
> > +
> > +       dcss_blkctl_cfg(dcss->blkctl);
> > +
> > +       dcss_ctxld_resume(dcss->ctxld);
> > +
> > +       drm_mode_config_helper_resume(dcss_drv_dev_to_drm(dev));
> > +
> > +       return 0;
> > +}
> > +#endif /* CONFIG_PM_SLEEP */
> > +
> > +#ifdef CONFIG_PM
> > +int dcss_dev_runtime_suspend(struct device *dev)
> > +{
> > +       struct dcss_dev *dcss =3D dcss_drv_dev_to_dcss(dev);
> > +       int ret;
> > +
> > +       ret =3D dcss_ctxld_suspend(dcss->ctxld);
> > +       if (ret)
> > +               return ret;
> > +
> > +       dcss_clocks_disable(dcss);
> > +
> > +       return 0;
> > +}
> > +
> > +int dcss_dev_runtime_resume(struct device *dev)
> > +{
> > +       struct dcss_dev *dcss =3D dcss_drv_dev_to_dcss(dev);
> > +
> > +       dcss_clocks_enable(dcss);
> > +
> > +       dcss_blkctl_cfg(dcss->blkctl);
> > +
> > +       dcss_ctxld_resume(dcss->ctxld);
> > +
> > +       return 0;
> > +}
> > +#endif /* CONFIG_PM */
> > diff --git a/drivers/gpu/drm/imx/dcss/dcss-dev.h b/drivers/gpu/drm/imx/=
dcss/dcss-dev.h
> > new file mode 100644
> > index 00000000..15c5de3
> > --- /dev/null
> > +++ b/drivers/gpu/drm/imx/dcss/dcss-dev.h
> > @@ -0,0 +1,195 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright 2019 NXP.
> > + */
> > +
> > +#ifndef __DCSS_PRV_H__
> > +#define __DCSS_PRV_H__
> > +
> > +#include <drm/drm_fourcc.h>
> > +#include <linux/io.h>
> > +#include <video/videomode.h>
> > +
> > +#define SET                    0x04
> > +#define CLR                    0x08
> > +#define TGL                    0x0C
> > +
> > +#define dcss_writel(v, c)      writel((v), (c))
> > +#define dcss_readl(c)          readl(c)
> > +#define dcss_set(v, c)         writel((v), (c) + SET)
> > +#define dcss_clr(v, c)         writel((v), (c) + CLR)
> > +#define dcss_toggle(v, c)      writel((v), (c) + TGL)
> > +
> > +static inline void dcss_update(u32 v, u32 m, void __iomem *c)
> > +{
> > +       writel((readl(c) & ~(m)) | (v), (c));
> > +}
> > +
> > +#define DCSS_DBG_REG(reg)      {.name =3D #reg, .ofs =3D reg}
> > +
> > +enum {
> > +       DCSS_IMX8MQ =3D 0,
> > +};
> > +
> > +struct dcss_type_data {
> > +       const char *name;
> > +       u32 blkctl_ofs;
> > +       u32 ctxld_ofs;
> > +       u32 rdsrc_ofs;
> > +       u32 wrscl_ofs;
> > +       u32 dtg_ofs;
> > +       u32 scaler_ofs;
> > +       u32 ss_ofs;
> > +       u32 dpr_ofs;
> > +       u32 dtrc_ofs;
> > +       u32 dec400d_ofs;
> > +       u32 hdr10_ofs;
> > +};
> > +
> > +struct dcss_debug_reg {
> > +       char *name;
> > +       u32 ofs;
> > +};
> > +
> > +enum dcss_ctxld_ctx_type {
> > +       CTX_DB,
> > +       CTX_SB_HP, /* high-priority */
> > +       CTX_SB_LP, /* low-priority  */
> > +};
> > +
> > +struct dcss_dev {
> > +       struct device *dev;
> > +       const struct dcss_type_data *devtype;
> > +       struct device_node *of_port;
> > +
> > +       u32 start_addr;
> > +
> > +       struct dcss_blkctl *blkctl;
> > +       struct dcss_ctxld *ctxld;
> > +       struct dcss_dpr *dpr;
> > +       struct dcss_dtg *dtg;
> > +       struct dcss_ss *ss;
> > +       struct dcss_hdr10 *hdr10;
> > +       struct dcss_scaler *scaler;
> > +       struct dcss_dtrc *dtrc;
> > +       struct dcss_dec400d *dec400d;
> > +       struct dcss_wrscl *wrscl;
> > +       struct dcss_rdsrc *rdsrc;
> > +
> > +       struct clk *apb_clk;
> > +       struct clk *axi_clk;
> > +       struct clk *pix_clk;
> > +       struct clk *rtrm_clk;
> > +       struct clk *dtrc_clk;
> > +       struct clk *pll_src_clk;
> > +       struct clk *pll_phy_ref_clk;
> > +
> > +       void (*dcss_disable_callback)(void *data);
> > +
> > +       bool clks_on;
> > +       bool hdmi_output;
> > +};
> > +
> > +enum dcss_color_space {
> > +       DCSS_COLORSPACE_RGB,
> > +       DCSS_COLORSPACE_YUV,
> > +       DCSS_COLORSPACE_UNKNOWN,
> > +};
> > +
> > +struct dcss_dev *dcss_drv_dev_to_dcss(struct device *dev);
> > +struct drm_device *dcss_drv_dev_to_drm(struct device *dev);
> > +struct dcss_dev *dcss_dev_create(struct device *dev, bool mipi_output)=
;
> > +void dcss_dev_destroy(struct dcss_dev *dcss);
> > +int dcss_dev_runtime_suspend(struct device *dev);
> > +int dcss_dev_runtime_resume(struct device *dev);
> > +int dcss_dev_suspend(struct device *dev);
> > +int dcss_dev_resume(struct device *dev);
> > +
> > +/* BLKCTL */
> > +int dcss_blkctl_init(struct dcss_dev *dcss, unsigned long blkctl_base)=
;
> > +void dcss_blkctl_cfg(struct dcss_blkctl *blkctl);
> > +void dcss_blkctl_exit(struct dcss_blkctl *blkctl);
> > +
> > +/* CTXLD */
> > +int dcss_ctxld_init(struct dcss_dev *dcss, unsigned long ctxld_base);
> > +void dcss_ctxld_exit(struct dcss_ctxld *ctxld);
> > +void dcss_ctxld_write(struct dcss_ctxld *ctxld, u32 ctx_id,
> > +                     u32 val, u32 reg_idx);
> > +int dcss_ctxld_resume(struct dcss_ctxld *dcss_ctxld);
> > +int dcss_ctxld_suspend(struct dcss_ctxld *dcss_ctxld);
> > +void dcss_ctxld_write_irqsafe(struct dcss_ctxld *ctlxd, u32 ctx_id, u3=
2 val,
> > +                             u32 reg_ofs);
> > +void dcss_ctxld_kick(struct dcss_ctxld *ctxld);
> > +bool dcss_ctxld_is_flushed(struct dcss_ctxld *ctxld);
> > +int dcss_ctxld_enable(struct dcss_ctxld *ctxld);
> > +void dcss_ctxld_register_dtg_disable_cb(struct dcss_ctxld *ctxld,
> > +                                       void (*cb)(void *),
> > +                                       void *data);
> > +
> > +/* DPR */
> > +enum dcss_tile_type {
> > +       TILE_LINEAR =3D 0,
> > +       TILE_GPU_STANDARD,
> > +       TILE_GPU_SUPER,
> > +       TILE_VPU_YUV420,
> > +       TILE_VPU_VP9,
> > +};
> > +
> > +enum dcss_pix_size {
> > +       PIX_SIZE_8,
> > +       PIX_SIZE_16,
> > +       PIX_SIZE_32,
> > +};
> > +
> > +int dcss_dpr_init(struct dcss_dev *dcss, unsigned long dpr_base);
> > +void dcss_dpr_exit(struct dcss_dpr *dpr);
> > +void dcss_dpr_write_sysctrl(struct dcss_dpr *dpr);
> > +void dcss_dpr_set_res(struct dcss_dpr *dpr, int ch_num, u32 xres, u32 =
yres);
> > +void dcss_dpr_addr_set(struct dcss_dpr *dpr, int ch_num, u32 luma_base=
_addr,
> > +                      u32 chroma_base_addr, u16 pitch);
> > +void dcss_dpr_enable(struct dcss_dpr *dpr, int ch_num, bool en);
> > +void dcss_dpr_format_set(struct dcss_dpr *dpr, int ch_num,
> > +                        const struct drm_format_info *format, u64 modi=
fier);
> > +void dcss_dpr_set_rotation(struct dcss_dpr *dpr, int ch_num, u32 rotat=
ion);
> > +
> > +/* DTG */
> > +int dcss_dtg_init(struct dcss_dev *dcss, unsigned long dtg_base);
> > +void dcss_dtg_exit(struct dcss_dtg *dtg);
> > +bool dcss_dtg_vblank_irq_valid(struct dcss_dtg *dtg);
> > +void dcss_dtg_vblank_irq_enable(struct dcss_dtg *dtg, bool en);
> > +void dcss_dtg_vblank_irq_clear(struct dcss_dtg *dtg);
> > +void dcss_dtg_sync_set(struct dcss_dtg *dtg, struct videomode *vm);
> > +void dcss_dtg_css_set(struct dcss_dtg *dtg);
> > +void dcss_dtg_enable(struct dcss_dtg *dtg, bool en,
> > +                    struct completion *dis_completion);
> > +bool dcss_dtg_is_enabled(struct dcss_dtg *dtg);
> > +void dcss_dtg_ctxld_kick_irq_enable(struct dcss_dtg *dtg, bool en);
> > +bool dcss_dtg_global_alpha_changed(struct dcss_dtg *dtg, int ch_num, i=
nt alpha);
> > +void dcss_dtg_plane_alpha_set(struct dcss_dtg *dtg, int ch_num,
> > +                             const struct drm_format_info *format, int=
 alpha);
> > +void dcss_dtg_plane_pos_set(struct dcss_dtg *dtg, int ch_num,
> > +                           int px, int py, int pw, int ph);
> > +void dcss_dtg_ch_enable(struct dcss_dtg *dtg, int ch_num, bool en);
> > +
> > +/* SUBSAM */
> > +int dcss_ss_init(struct dcss_dev *dcss, unsigned long subsam_base);
> > +void dcss_ss_exit(struct dcss_ss *ss);
> > +void dcss_ss_enable(struct dcss_ss *ss);
> > +void dcss_ss_disable(struct dcss_ss *ss);
> > +void dcss_ss_subsam_set(struct dcss_ss *ss);
> > +void dcss_ss_sync_set(struct dcss_ss *ss, struct videomode *vm,
> > +                     bool phsync, bool pvsync);
> > +
> > +/* SCALER */
> > +int dcss_scaler_init(struct dcss_dev *dcss, unsigned long scaler_base)=
;
> > +void dcss_scaler_exit(struct dcss_scaler *scl);
> > +void dcss_scaler_setup(struct dcss_scaler *scl, int ch_num,
> > +                      const struct drm_format_info *format,
> > +                      int src_xres, int src_yres, int dst_xres, int ds=
t_yres,
> > +                      u32 vrefresh_hz);
> > +void dcss_scaler_ch_enable(struct dcss_scaler *scl, int ch_num, bool e=
n);
> > +int dcss_scaler_get_min_max_ratios(struct dcss_scaler *scl, int ch_num=
,
> > +                                  int *min, int *max);
> > +void dcss_scaler_write_sclctrl(struct dcss_scaler *scl);
> > +
> > +#endif /* __DCSS_PRV_H__ */
> > diff --git a/drivers/gpu/drm/imx/dcss/dcss-dpr.c b/drivers/gpu/drm/imx/=
dcss/dcss-dpr.c
> > new file mode 100644
> > index 00000000..dbc7169
> > --- /dev/null
> > +++ b/drivers/gpu/drm/imx/dcss/dcss-dpr.c
> > @@ -0,0 +1,552 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright 2019 NXP.
> > + */
> > +
> > +#include <linux/device.h>
> > +
> > +#include "dcss-dev.h"
> > +
> > +#define DCSS_DPR_SYSTEM_CTRL0                  0x000
> > +#define   RUN_EN                               BIT(0)
> > +#define   SOFT_RESET                           BIT(1)
> > +#define   REPEAT_EN                            BIT(2)
> > +#define   SHADOW_LOAD_EN                       BIT(3)
> > +#define   SW_SHADOW_LOAD_SEL                   BIT(4)
> > +#define   BCMD2AXI_MSTR_ID_CTRL                        BIT(16)
> > +#define DCSS_DPR_IRQ_MASK                      0x020
> > +#define DCSS_DPR_IRQ_MASK_STATUS               0x030
> > +#define DCSS_DPR_IRQ_NONMASK_STATUS            0x040
> > +#define   IRQ_DPR_CTRL_DONE                    BIT(0)
> > +#define   IRQ_DPR_RUN                          BIT(1)
> > +#define   IRQ_DPR_SHADOW_LOADED                        BIT(2)
> > +#define   IRQ_AXI_READ_ERR                     BIT(3)
> > +#define   DPR2RTR_YRGB_FIFO_OVFL               BIT(4)
> > +#define   DPR2RTR_UV_FIFO_OVFL                 BIT(5)
> > +#define   DPR2RTR_FIFO_LD_BUF_RDY_YRGB_ERR     BIT(6)
> > +#define   DPR2RTR_FIFO_LD_BUF_RDY_UV_ERR       BIT(7)
> > +#define DCSS_DPR_MODE_CTRL0                    0x050
> > +#define   RTR_3BUF_EN                          BIT(0)
> > +#define   RTR_4LINE_BUF_EN                     BIT(1)
> > +#define   TILE_TYPE_POS                                2
> > +#define   TILE_TYPE_MASK                       GENMASK(4, 2)
> > +#define   YUV_EN                               BIT(6)
> > +#define   COMP_2PLANE_EN                       BIT(7)
> > +#define   PIX_SIZE_POS                         8
> > +#define   PIX_SIZE_MASK                                GENMASK(9, 8)
> > +#define   PIX_LUMA_UV_SWAP                     BIT(10)
> > +#define   PIX_UV_SWAP                          BIT(11)
> > +#define   B_COMP_SEL_POS                       12
> > +#define   B_COMP_SEL_MASK                      GENMASK(13, 12)
> > +#define   G_COMP_SEL_POS                       14
> > +#define   G_COMP_SEL_MASK                      GENMASK(15, 14)
> > +#define   R_COMP_SEL_POS                       16
> > +#define   R_COMP_SEL_MASK                      GENMASK(17, 16)
> > +#define   A_COMP_SEL_POS                       18
> > +#define   A_COMP_SEL_MASK                      GENMASK(19, 18)
> > +#define DCSS_DPR_FRAME_CTRL0                   0x070
> > +#define   HFLIP_EN                             BIT(0)
> > +#define   VFLIP_EN                             BIT(1)
> > +#define   ROT_ENC_POS                          2
> > +#define   ROT_ENC_MASK                         GENMASK(3, 2)
> > +#define   ROT_FLIP_ORDER_EN                    BIT(4)
> > +#define   PITCH_POS                            16
> > +#define   PITCH_MASK                           GENMASK(31, 16)
> > +#define DCSS_DPR_FRAME_1P_CTRL0                        0x090
> > +#define DCSS_DPR_FRAME_1P_PIX_X_CTRL           0x0A0
> > +#define DCSS_DPR_FRAME_1P_PIX_Y_CTRL           0x0B0
> > +#define DCSS_DPR_FRAME_1P_BASE_ADDR            0x0C0
> > +#define DCSS_DPR_FRAME_2P_CTRL0                        0x0E0
> > +#define DCSS_DPR_FRAME_2P_PIX_X_CTRL           0x0F0
> > +#define DCSS_DPR_FRAME_2P_PIX_Y_CTRL           0x100
> > +#define DCSS_DPR_FRAME_2P_BASE_ADDR            0x110
> > +#define DCSS_DPR_STATUS_CTRL0                  0x130
> > +#define   STATUS_MUX_SEL_MASK                  GENMASK(2, 0)
> > +#define   STATUS_SRC_SEL_POS                   16
> > +#define   STATUS_SRC_SEL_MASK                  GENMASK(18, 16)
> > +#define DCSS_DPR_STATUS_CTRL1                  0x140
> > +#define DCSS_DPR_RTRAM_CTRL0                   0x200
> > +#define   NUM_ROWS_ACTIVE                      BIT(0)
> > +#define   THRES_HIGH_POS                       1
> > +#define   THRES_HIGH_MASK                      GENMASK(3, 1)
> > +#define   THRES_LOW_POS                                4
> > +#define   THRES_LOW_MASK                       GENMASK(6, 4)
> > +#define   ABORT_SEL                            BIT(7)
> > +
> > +struct dcss_dpr_ch {
> > +       struct dcss_dpr *dpr;
> > +       void __iomem *base_reg;
> > +       u32 base_ofs;
> > +
> > +       struct drm_format_info format;
> > +       enum dcss_pix_size pix_size;
> > +       enum dcss_tile_type tile;
> > +       bool rtram_4line_en;
> > +       bool rtram_3buf_en;
> > +
> > +       u32 frame_ctrl;
> > +       u32 mode_ctrl;
> > +       u32 sys_ctrl;
> > +       u32 rtram_ctrl;
> > +
> > +       bool sys_ctrl_chgd;
> > +
> > +       u32 pitch;
> > +
> > +       int ch_num;
> > +       int irq;
> > +};
> > +
> > +struct dcss_dpr {
> > +       struct device *dev;
> > +       struct dcss_ctxld *ctxld;
> > +       u32  ctx_id;
> > +
> > +       struct dcss_dpr_ch ch[3];
> > +};
> > +
> > +static void dcss_dpr_write(struct dcss_dpr_ch *ch, u32 val, u32 ofs)
> > +{
> > +       struct dcss_dpr *dpr =3D ch->dpr;
> > +
> > +       dcss_ctxld_write(dpr->ctxld, dpr->ctx_id, val, ch->base_ofs + o=
fs);
> > +}
> > +
> > +static int dcss_dpr_ch_init_all(struct dcss_dpr *dpr, unsigned long dp=
r_base)
> > +{
> > +       struct dcss_dpr_ch *ch;
> > +       int i;
> > +
> > +       for (i =3D 0; i < 3; i++) {
> > +               ch =3D &dpr->ch[i];
> > +
> > +               ch->base_ofs =3D dpr_base + i * 0x1000;
>=20
> Same with i.MX8QM & i.MX8QXP, every DPR instance has three channels.
> Each channel has it's own register space.
> For i.MX8QM & i.MX8QXP SoCs, the connection between DPR channel
> and PRG(s) can be reflected in device tree.  So, it would be good if the
> DPR driver wraps one single DPR channel only.
>=20
> Regards,
> Liu Ying
>=20
> > +
> > +               ch->base_reg =3D devm_ioremap(dpr->dev, ch->base_ofs, S=
Z_4K);
> > +               if (!ch->base_reg) {
> > +                       dev_err(dpr->dev, "dpr: unable to remap ch %d b=
ase\n",
> > +                               i);
> > +                       return -ENOMEM;
> > +               }
> > +
> > +               ch->dpr =3D dpr;
> > +               ch->ch_num =3D i;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +int dcss_dpr_init(struct dcss_dev *dcss, unsigned long dpr_base)
> > +{
> > +       struct dcss_dpr *dpr;
> > +
> > +       dpr =3D devm_kzalloc(dcss->dev, sizeof(struct dcss_dpr), GFP_KE=
RNEL);
> > +       if (!dpr)
> > +               return -ENOMEM;
> > +
> > +       dcss->dpr =3D dpr;
> > +       dpr->dev =3D dcss->dev;
> > +       dpr->ctxld =3D dcss->ctxld;
> > +       dpr->ctx_id =3D CTX_SB_HP;
> > +
> > +       if (dcss_dpr_ch_init_all(dpr, dpr_base)) {
> > +               int i;
> > +
> > +               for (i =3D 0; i < 3; i++) {
> > +                       if (dpr->ch[i].base_reg)
> > +                               devm_iounmap(dpr->dev, dpr->ch[i].base_=
reg);
> > +               }
> > +
> > +               devm_kfree(dpr->dev, dpr);
> > +
> > +               return -ENOMEM;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +void dcss_dpr_exit(struct dcss_dpr *dpr)
> > +{
> > +       int ch_no;
> > +
> > +       /* stop DPR on all channels */
> > +       for (ch_no =3D 0; ch_no < 3; ch_no++) {
> > +               struct dcss_dpr_ch *ch =3D &dpr->ch[ch_no];
> > +
> > +               dcss_writel(0, ch->base_reg + DCSS_DPR_SYSTEM_CTRL0);
> > +
> > +               if (ch->base_reg)
> > +                       devm_iounmap(dpr->dev, ch->base_reg);
> > +       }
> > +
> > +       devm_kfree(dpr->dev, dpr);
> > +}
> > +
> > +static u32 dcss_dpr_x_pix_wide_adjust(struct dcss_dpr_ch *ch, u32 pix_=
wide,
> > +                                     u32 pix_format)
> > +{
> > +       u8 pix_in_64byte_map[3][5] =3D {
> > +               /* LIN, GPU_STD, GPU_SUP, VPU_YUV420, VPU_VP9 */
> > +               {   64,       8,       8,          8,     16}, /* PIX_S=
IZE_8  */
> > +               {   32,       8,       8,          8,      8}, /* PIX_S=
IZE_16 */
> > +               {   16,       4,       4,          8,      8}, /* PIX_S=
IZE_32 */
> > +       };
> > +       u32 offset;
> > +       u32 div_64byte_mod, pix_in_64byte;
> > +
> > +       pix_in_64byte =3D pix_in_64byte_map[ch->pix_size][ch->tile];
> > +
> > +       if (pix_format =3D=3D DRM_FORMAT_P010)
> > +               pix_wide =3D pix_wide * 10 / 8;
> > +
> > +       div_64byte_mod =3D pix_wide % pix_in_64byte;
> > +       offset =3D (div_64byte_mod =3D=3D 0) ? 0 : (pix_in_64byte - div=
_64byte_mod);
> > +
> > +       return pix_wide + offset;
> > +}
> > +
> > +static u32 dcss_dpr_y_pix_high_adjust(struct dcss_dpr_ch *ch, u32 pix_=
high,
> > +                                     u32 pix_format)
> > +{
> > +       u8 num_rows_buf =3D ch->rtram_4line_en ? 4 : 8;
> > +       u32 offset, pix_y_mod;
> > +
> > +       pix_y_mod =3D pix_high % num_rows_buf;
> > +       offset =3D pix_y_mod ? (num_rows_buf - pix_y_mod) : 0;
> > +
> > +       return pix_high + offset;
> > +}
> > +
> > +void dcss_dpr_set_res(struct dcss_dpr *dpr, int ch_num, u32 xres, u32 =
yres)
> > +{
> > +       struct dcss_dpr_ch *ch =3D &dpr->ch[ch_num];
> > +       u32 pix_format =3D ch->format.format;
> > +       u32 gap =3D DCSS_DPR_FRAME_2P_BASE_ADDR - DCSS_DPR_FRAME_1P_BAS=
E_ADDR;
> > +       int plane, max_planes =3D 1;
> > +       u32 pix_x_wide, pix_y_high;
> > +
> > +       if (pix_format =3D=3D DRM_FORMAT_NV12 ||
> > +           pix_format =3D=3D DRM_FORMAT_NV21)
> > +               max_planes =3D 2;
> > +
> > +       for (plane =3D 0; plane < max_planes; plane++) {
> > +               yres =3D plane =3D=3D 1 ? yres >> 1 : yres;
> > +
> > +               pix_x_wide =3D dcss_dpr_x_pix_wide_adjust(ch, xres, pix=
_format);
> > +               pix_y_high =3D dcss_dpr_y_pix_high_adjust(ch, yres, pix=
_format);
> > +
> > +               if (plane =3D=3D 0)
> > +                       ch->pitch =3D pix_x_wide;
> > +
> > +               dcss_dpr_write(ch, pix_x_wide,
> > +                              DCSS_DPR_FRAME_1P_PIX_X_CTRL + plane * g=
ap);
> > +               dcss_dpr_write(ch, pix_y_high,
> > +                              DCSS_DPR_FRAME_1P_PIX_Y_CTRL + plane * g=
ap);
> > +
> > +               dcss_dpr_write(ch, 2, DCSS_DPR_FRAME_1P_CTRL0 + plane *=
 gap);
> > +       }
> > +}
> > +
> > +void dcss_dpr_addr_set(struct dcss_dpr *dpr, int ch_num, u32 luma_base=
_addr,
> > +                      u32 chroma_base_addr, u16 pitch)
> > +{
> > +       struct dcss_dpr_ch *ch =3D &dpr->ch[ch_num];
> > +
> > +       dcss_dpr_write(ch, luma_base_addr, DCSS_DPR_FRAME_1P_BASE_ADDR)=
;
> > +
> > +       dcss_dpr_write(ch, chroma_base_addr, DCSS_DPR_FRAME_2P_BASE_ADD=
R);
> > +
> > +       ch->frame_ctrl &=3D ~PITCH_MASK;
> > +       ch->frame_ctrl |=3D (((u32)pitch << PITCH_POS) & PITCH_MASK);
> > +}
> > +
> > +static void dcss_dpr_argb_comp_sel(struct dcss_dpr_ch *ch, int a_sel, =
int r_sel,
> > +                                  int g_sel, int b_sel)
> > +{
> > +       u32 sel;
> > +
> > +       sel =3D ((a_sel << A_COMP_SEL_POS) & A_COMP_SEL_MASK) |
> > +             ((r_sel << R_COMP_SEL_POS) & R_COMP_SEL_MASK) |
> > +             ((g_sel << G_COMP_SEL_POS) & G_COMP_SEL_MASK) |
> > +             ((b_sel << B_COMP_SEL_POS) & B_COMP_SEL_MASK);
> > +
> > +       ch->mode_ctrl &=3D ~(A_COMP_SEL_MASK | R_COMP_SEL_MASK |
> > +                          G_COMP_SEL_MASK | B_COMP_SEL_MASK);
> > +       ch->mode_ctrl |=3D sel;
> > +}
> > +
> > +static void dcss_dpr_pix_size_set(struct dcss_dpr_ch *ch,
> > +                                 const struct drm_format_info *format)
> > +{
> > +       u32 val;
> > +
> > +       switch (format->format) {
> > +       case DRM_FORMAT_NV12:
> > +       case DRM_FORMAT_NV21:
> > +               val =3D 0;
> > +               break;
> > +
> > +       case DRM_FORMAT_UYVY:
> > +       case DRM_FORMAT_VYUY:
> > +       case DRM_FORMAT_YUYV:
> > +       case DRM_FORMAT_YVYU:
> > +               val =3D 1;
> > +               break;
> > +
> > +       default:
> > +               val =3D 2;
> > +               break;
> > +       }
> > +
> > +       ch->pix_size =3D val;
> > +
> > +       ch->mode_ctrl &=3D ~PIX_SIZE_MASK;
> > +       ch->mode_ctrl |=3D ((val << PIX_SIZE_POS) & PIX_SIZE_MASK);
> > +}
> > +
> > +static void dcss_dpr_uv_swap(struct dcss_dpr_ch *ch, bool swap)
> > +{
> > +       ch->mode_ctrl &=3D ~PIX_UV_SWAP;
> > +       ch->mode_ctrl |=3D (swap ? PIX_UV_SWAP : 0);
> > +}
> > +
> > +static void dcss_dpr_y_uv_swap(struct dcss_dpr_ch *ch, bool swap)
> > +{
> > +       ch->mode_ctrl &=3D ~PIX_LUMA_UV_SWAP;
> > +       ch->mode_ctrl |=3D (swap ? PIX_LUMA_UV_SWAP : 0);
> > +}
> > +
> > +static void dcss_dpr_2plane_en(struct dcss_dpr_ch *ch, bool en)
> > +{
> > +       ch->mode_ctrl &=3D ~COMP_2PLANE_EN;
> > +       ch->mode_ctrl |=3D (en ? COMP_2PLANE_EN : 0);
> > +}
> > +
> > +static void dcss_dpr_yuv_en(struct dcss_dpr_ch *ch, bool en)
> > +{
> > +       ch->mode_ctrl &=3D ~YUV_EN;
> > +       ch->mode_ctrl |=3D (en ? YUV_EN : 0);
> > +}
> > +
> > +void dcss_dpr_enable(struct dcss_dpr *dpr, int ch_num, bool en)
> > +{
> > +       struct dcss_dpr_ch *ch =3D &dpr->ch[ch_num];
> > +       u32 sys_ctrl;
> > +
> > +       sys_ctrl =3D (en ? REPEAT_EN | RUN_EN : 0);
> > +
> > +       if (en) {
> > +               dcss_dpr_write(ch, ch->mode_ctrl, DCSS_DPR_MODE_CTRL0);
> > +               dcss_dpr_write(ch, ch->frame_ctrl, DCSS_DPR_FRAME_CTRL0=
);
> > +               dcss_dpr_write(ch, ch->rtram_ctrl, DCSS_DPR_RTRAM_CTRL0=
);
> > +       }
> > +
> > +       if (ch->sys_ctrl !=3D sys_ctrl)
> > +               ch->sys_ctrl_chgd =3D true;
> > +
> > +       ch->sys_ctrl =3D sys_ctrl;
> > +}
> > +
> > +struct rgb_comp_sel {
> > +       u32 drm_format;
> > +       int a_sel;
> > +       int r_sel;
> > +       int g_sel;
> > +       int b_sel;
> > +};
> > +
> > +static struct rgb_comp_sel comp_sel_map[] =3D {
> > +       {DRM_FORMAT_ARGB8888, 3, 2, 1, 0},
> > +       {DRM_FORMAT_XRGB8888, 3, 2, 1, 0},
> > +       {DRM_FORMAT_ABGR8888, 3, 0, 1, 2},
> > +       {DRM_FORMAT_XBGR8888, 3, 0, 1, 2},
> > +       {DRM_FORMAT_RGBA8888, 0, 3, 2, 1},
> > +       {DRM_FORMAT_RGBX8888, 0, 3, 2, 1},
> > +       {DRM_FORMAT_BGRA8888, 0, 1, 2, 3},
> > +       {DRM_FORMAT_BGRX8888, 0, 1, 2, 3},
> > +};
> > +
> > +static int to_comp_sel(u32 pix_fmt, int *a_sel, int *r_sel, int *g_sel=
,
> > +                      int *b_sel)
> > +{
> > +       int i;
> > +
> > +       for (i =3D 0; i < ARRAY_SIZE(comp_sel_map); i++) {
> > +               if (comp_sel_map[i].drm_format =3D=3D pix_fmt) {
> > +                       *a_sel =3D comp_sel_map[i].a_sel;
> > +                       *r_sel =3D comp_sel_map[i].r_sel;
> > +                       *g_sel =3D comp_sel_map[i].g_sel;
> > +                       *b_sel =3D comp_sel_map[i].b_sel;
> > +
> > +                       return 0;
> > +               }
> > +       }
> > +
> > +       return -1;
> > +}
> > +
> > +static void dcss_dpr_rtram_set(struct dcss_dpr_ch *ch, u32 pix_format)
> > +{
> > +       u32 val, mask;
> > +
> > +       switch (pix_format) {
> > +       case DRM_FORMAT_NV21:
> > +       case DRM_FORMAT_NV12:
> > +       case DRM_FORMAT_P010:
> > +               ch->rtram_3buf_en =3D true;
> > +               ch->rtram_4line_en =3D false;
> > +               break;
> > +
> > +       default:
> > +               ch->rtram_3buf_en =3D true;
> > +               ch->rtram_4line_en =3D true;
> > +               break;
> > +       }
> > +
> > +       val =3D (ch->rtram_4line_en ? RTR_4LINE_BUF_EN : 0);
> > +       val |=3D (ch->rtram_3buf_en ? RTR_3BUF_EN : 0);
> > +       mask =3D RTR_4LINE_BUF_EN | RTR_3BUF_EN;
> > +
> > +       ch->mode_ctrl &=3D ~mask;
> > +       ch->mode_ctrl |=3D (val & mask);
> > +
> > +       val =3D (ch->rtram_4line_en ? 0 : NUM_ROWS_ACTIVE);
> > +       val |=3D (3 << THRES_LOW_POS) & THRES_LOW_MASK;
> > +       val |=3D (4 << THRES_HIGH_POS) & THRES_HIGH_MASK;
> > +       mask =3D THRES_LOW_MASK | THRES_HIGH_MASK | NUM_ROWS_ACTIVE;
> > +
> > +       ch->rtram_ctrl &=3D ~mask;
> > +       ch->rtram_ctrl |=3D (val & mask);
> > +}
> > +
> > +static void dcss_dpr_setup_components(struct dcss_dpr_ch *ch,
> > +                                     const struct drm_format_info *for=
mat)
> > +{
> > +       int a_sel, r_sel, g_sel, b_sel;
> > +       bool uv_swap, y_uv_swap;
> > +
> > +       switch (format->format) {
> > +       case DRM_FORMAT_YVYU:
> > +               uv_swap =3D true;
> > +               y_uv_swap =3D true;
> > +               break;
> > +
> > +       case DRM_FORMAT_VYUY:
> > +       case DRM_FORMAT_NV21:
> > +               uv_swap =3D true;
> > +               y_uv_swap =3D false;
> > +               break;
> > +
> > +       case DRM_FORMAT_YUYV:
> > +               uv_swap =3D false;
> > +               y_uv_swap =3D true;
> > +               break;
> > +
> > +       default:
> > +               uv_swap =3D false;
> > +               y_uv_swap =3D false;
> > +               break;
> > +       }
> > +
> > +       dcss_dpr_uv_swap(ch, uv_swap);
> > +
> > +       dcss_dpr_y_uv_swap(ch, y_uv_swap);
> > +
> > +       if (!format->is_yuv) {
> > +               if (!to_comp_sel(format->format, &a_sel, &r_sel,
> > +                                &g_sel, &b_sel)) {
> > +                       dcss_dpr_argb_comp_sel(ch, a_sel, r_sel, g_sel,=
 b_sel);
> > +               } else {
> > +                       dcss_dpr_argb_comp_sel(ch, 3, 2, 1, 0);
> > +               }
> > +       } else {
> > +               dcss_dpr_argb_comp_sel(ch, 0, 0, 0, 0);
> > +       }
> > +}
> > +
> > +static void dcss_dpr_tile_set(struct dcss_dpr_ch *ch, uint64_t modifie=
r)
> > +{
> > +       switch (ch->ch_num) {
> > +       case 0:
> > +               switch (modifier) {
> > +               case DRM_FORMAT_MOD_LINEAR:
> > +                       ch->tile =3D TILE_LINEAR;
> > +                       break;
> > +               case DRM_FORMAT_MOD_VIVANTE_TILED:
> > +                       ch->tile =3D TILE_GPU_STANDARD;
> > +                       break;
> > +               case DRM_FORMAT_MOD_VIVANTE_SUPER_TILED:
> > +                       ch->tile =3D TILE_GPU_SUPER;
> > +                       break;
> > +               default:
> > +                       WARN_ON(1);
> > +                       break;
> > +               }
> > +               break;
> > +       case 1:
> > +       case 2:
> > +               ch->tile =3D TILE_LINEAR;
> > +               break;
> > +       default:
> > +               WARN_ON(1);
> > +               return;
> > +       }
> > +
> > +       ch->mode_ctrl &=3D ~TILE_TYPE_MASK;
> > +       ch->mode_ctrl |=3D ((ch->tile << TILE_TYPE_POS) & TILE_TYPE_MAS=
K);
> > +}
> > +
> > +void dcss_dpr_format_set(struct dcss_dpr *dpr, int ch_num,
> > +                        const struct drm_format_info *format, u64 modi=
fier)
> > +{
> > +       struct dcss_dpr_ch *ch =3D &dpr->ch[ch_num];
> > +
> > +       ch->format =3D *format;
> > +
> > +       dcss_dpr_yuv_en(ch, format->is_yuv);
> > +
> > +       dcss_dpr_pix_size_set(ch, format);
> > +
> > +       dcss_dpr_setup_components(ch, format);
> > +
> > +       dcss_dpr_2plane_en(ch, format->num_planes =3D=3D 2);
> > +
> > +       dcss_dpr_rtram_set(ch, format->format);
> > +
> > +       dcss_dpr_tile_set(ch, modifier);
> > +}
> > +
> > +/* This function will be called from interrupt context. */
> > +void dcss_dpr_write_sysctrl(struct dcss_dpr *dpr)
> > +{
> > +       int chnum;
> > +
> > +       for (chnum =3D 0; chnum < 3; chnum++) {
> > +               struct dcss_dpr_ch *ch =3D &dpr->ch[chnum];
> > +
> > +               if (ch->sys_ctrl_chgd) {
> > +                       dcss_ctxld_write_irqsafe(dpr->ctxld, dpr->ctx_i=
d,
> > +                                                ch->sys_ctrl,
> > +                                                ch->base_ofs +
> > +                                                DCSS_DPR_SYSTEM_CTRL0)=
;
> > +                       ch->sys_ctrl_chgd =3D false;
> > +               }
> > +       }
> > +}
> > +
> > +void dcss_dpr_set_rotation(struct dcss_dpr *dpr, int ch_num, u32 rotat=
ion)
> > +{
> > +       struct dcss_dpr_ch *ch =3D &dpr->ch[ch_num];
> > +
> > +       ch->frame_ctrl &=3D ~(HFLIP_EN | VFLIP_EN | ROT_ENC_MASK);
> > +
> > +       ch->frame_ctrl |=3D rotation & DRM_MODE_REFLECT_X ? HFLIP_EN : =
0;
> > +       ch->frame_ctrl |=3D rotation & DRM_MODE_REFLECT_Y ? VFLIP_EN : =
0;
> > +
> > +       if (rotation & DRM_MODE_ROTATE_90)
> > +               ch->frame_ctrl |=3D 1 << ROT_ENC_POS;
> > +       else if (rotation & DRM_MODE_ROTATE_180)
> > +               ch->frame_ctrl |=3D 2 << ROT_ENC_POS;
> > +       else if (rotation & DRM_MODE_ROTATE_270)
> > +               ch->frame_ctrl |=3D 3 << ROT_ENC_POS;
> > +}
> > diff --git a/drivers/gpu/drm/imx/dcss/dcss-drv.c b/drivers/gpu/drm/imx/=
dcss/dcss-drv.c
> > new file mode 100644
> > index 00000000..7ea131d
> > --- /dev/null
> > +++ b/drivers/gpu/drm/imx/dcss/dcss-drv.c
> > @@ -0,0 +1,182 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright 2019 NXP.
> > + */
> > +
> > +#include <linux/module.h>
> > +#include <linux/kernel.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/component.h>
> > +#include <drm/drm_of.h>
> > +#include <drm/drmP.h>
> > +
> > +#include "dcss-dev.h"
> > +#include "dcss-kms.h"
> > +
> > +struct dcss_drv {
> > +       struct dcss_dev *dcss;
> > +       struct dcss_kms_dev *kms;
> > +
> > +       bool is_componentized;
> > +};
> > +
> > +struct dcss_dev *dcss_drv_dev_to_dcss(struct device *dev)
> > +{
> > +       struct dcss_drv *mdrv =3D dev_get_drvdata(dev);
> > +
> > +       return mdrv ? mdrv->dcss : NULL;
> > +}
> > +
> > +struct drm_device *dcss_drv_dev_to_drm(struct device *dev)
> > +{
> > +       struct dcss_drv *mdrv =3D dev_get_drvdata(dev);
> > +
> > +       return mdrv ? &mdrv->kms->base : NULL;
> > +}
> > +
> > +static int dcss_drv_init(struct device *dev, bool componentized)
> > +{
> > +       struct dcss_drv *mdrv;
> > +       int err =3D 0;
> > +
> > +       mdrv =3D devm_kzalloc(dev, sizeof(*mdrv), GFP_KERNEL);
> > +       if (!mdrv)
> > +               return -ENOMEM;
> > +
> > +       mdrv->is_componentized =3D componentized;
> > +
> > +       mdrv->dcss =3D dcss_dev_create(dev, componentized);
> > +       if (IS_ERR(mdrv->dcss)) {
> > +               err =3D PTR_ERR(mdrv->dcss);
> > +               goto err;
> > +       }
> > +
> > +       dev_set_drvdata(dev, mdrv);
> > +
> > +       mdrv->kms =3D dcss_kms_attach(mdrv->dcss, componentized);
> > +       if (IS_ERR(mdrv->kms)) {
> > +               err =3D PTR_ERR(mdrv->kms);
> > +               goto dcss_shutoff;
> > +       }
> > +
> > +       return 0;
> > +
> > +dcss_shutoff:
> > +       dcss_dev_destroy(mdrv->dcss);
> > +
> > +       dev_set_drvdata(dev, NULL);
> > +
> > +err:
> > +       devm_kfree(dev, mdrv);
> > +       return err;
> > +}
> > +
> > +static void dcss_drv_deinit(struct device *dev, bool componentized)
> > +{
> > +       struct dcss_drv *mdrv =3D dev_get_drvdata(dev);
> > +
> > +       if (!mdrv)
> > +               return;
> > +
> > +       dcss_kms_detach(mdrv->kms, componentized);
> > +       dcss_dev_destroy(mdrv->dcss);
> > +
> > +       dev_set_drvdata(dev, NULL);
> > +}
> > +
> > +static int dcss_drv_bind(struct device *dev)
> > +{
> > +       return dcss_drv_init(dev, true);
> > +}
> > +
> > +static void dcss_drv_unbind(struct device *dev)
> > +{
> > +       return dcss_drv_deinit(dev, true);
> > +}
> > +
> > +static const struct component_master_ops dcss_master_ops =3D {
> > +       .bind   =3D dcss_drv_bind,
> > +       .unbind =3D dcss_drv_unbind,
> > +};
> > +
> > +static int compare_of(struct device *dev, void *data)
> > +{
> > +       return dev->of_node =3D=3D data;
> > +}
> > +
> > +static int dcss_drv_platform_probe(struct platform_device *pdev)
> > +{
> > +       struct device *dev =3D &pdev->dev;
> > +       struct component_match *match =3D NULL;
> > +       struct device_node *remote;
> > +
> > +       if (!dev->of_node)
> > +               return -ENODEV;
> > +
> > +       remote =3D of_graph_get_remote_node(dev->of_node, 0, 0);
> > +       if (!remote)
> > +               return -ENODEV;
> > +
> > +       if (of_device_is_compatible(remote, "fsl,imx8mq-nwl-dsi")) {
> > +               of_node_put(remote);
> > +               return dcss_drv_init(dev, false);
> > +       }
> > +
> > +       drm_of_component_match_add(dev, &match, compare_of, remote);
> > +       of_node_put(remote);
> > +
> > +       return component_master_add_with_match(dev, &dcss_master_ops, m=
atch);
> > +}
> > +
> > +static int dcss_drv_platform_remove(struct platform_device *pdev)
> > +{
> > +       struct dcss_drv *mdrv =3D dev_get_drvdata(&pdev->dev);
> > +
> > +       if (mdrv->is_componentized)
> > +               component_master_del(&pdev->dev, &dcss_master_ops);
> > +       else
> > +               dcss_drv_deinit(&pdev->dev, false);
> > +
> > +       return 0;
> > +}
> > +
> > +static struct dcss_type_data dcss_types[] =3D {
> > +       [DCSS_IMX8MQ] =3D {
> > +               .name =3D "DCSS_IMX8MQ",
> > +               .blkctl_ofs =3D 0x2F000,
> > +               .ctxld_ofs =3D 0x23000,
> > +               .dtg_ofs =3D 0x20000,
> > +               .scaler_ofs =3D 0x1C000,
> > +               .ss_ofs =3D 0x1B000,
> > +               .dpr_ofs =3D 0x18000,
> > +       },
> > +};
> > +
> > +static const struct of_device_id dcss_of_match[] =3D {
> > +       { .compatible =3D "nxp,imx8mq-dcss", .data =3D &dcss_types[DCSS=
_IMX8MQ], },
> > +       {},
> > +};
> > +
> > +MODULE_DEVICE_TABLE(of, dcss_of_match);
> > +
> > +static const struct dev_pm_ops dcss_dev_pm =3D {
> > +       SET_SYSTEM_SLEEP_PM_OPS(dcss_dev_suspend, dcss_dev_resume)
> > +       SET_RUNTIME_PM_OPS(dcss_dev_runtime_suspend,
> > +                          dcss_dev_runtime_resume, NULL)
> > +};
> > +
> > +static struct platform_driver dcss_platform_driver =3D {
> > +       .probe  =3D dcss_drv_platform_probe,
> > +       .remove =3D dcss_drv_platform_remove,
> > +       .driver =3D {
> > +               .name =3D "imx-dcss",
> > +               .of_match_table =3D dcss_of_match,
> > +               .pm =3D &dcss_dev_pm,
> > +       },
> > +};
> > +
> > +module_platform_driver(dcss_platform_driver);
> > +
> > +MODULE_AUTHOR("Laurentiu Palcu <laurentiu.palcu@nxp.com>");
> > +MODULE_DESCRIPTION("DCSS driver for i.MX8MQ");
> > +MODULE_LICENSE("GPL v2");
> > diff --git a/drivers/gpu/drm/imx/dcss/dcss-dtg.c b/drivers/gpu/drm/imx/=
dcss/dcss-dtg.c
> > new file mode 100644
> > index 00000000..c83b3bb
> > --- /dev/null
> > +++ b/drivers/gpu/drm/imx/dcss/dcss-dtg.c
> > @@ -0,0 +1,438 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright 2019 NXP.
> > + */
> > +
> > +#include <linux/clk.h>
> > +#include <linux/delay.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/of.h>
> > +#include <linux/platform_device.h>
> > +
> > +#include "dcss-dev.h"
> > +
> > +#define DCSS_DTG_TC_CONTROL_STATUS                     0x00
> > +#define   CH3_EN                                       BIT(0)
> > +#define   CH2_EN                                       BIT(1)
> > +#define   CH1_EN                                       BIT(2)
> > +#define   OVL_DATA_MODE                                        BIT(3)
> > +#define   BLENDER_VIDEO_ALPHA_SEL                      BIT(7)
> > +#define   DTG_START                                    BIT(8)
> > +#define   DBY_MODE_EN                                  BIT(9)
> > +#define   CH1_ALPHA_SEL                                        BIT(10)
> > +#define   CSS_PIX_COMP_SWAP_POS                                12
> > +#define   CSS_PIX_COMP_SWAP_MASK                       GENMASK(14, 12)
> > +#define   DEFAULT_FG_ALPHA_POS                         24
> > +#define   DEFAULT_FG_ALPHA_MASK                                GENMASK=
(31, 24)
> > +#define DCSS_DTG_TC_DTG                                        0x04
> > +#define DCSS_DTG_TC_DISP_TOP                           0x08
> > +#define DCSS_DTG_TC_DISP_BOT                           0x0C
> > +#define DCSS_DTG_TC_CH1_TOP                            0x10
> > +#define DCSS_DTG_TC_CH1_BOT                            0x14
> > +#define DCSS_DTG_TC_CH2_TOP                            0x18
> > +#define DCSS_DTG_TC_CH2_BOT                            0x1C
> > +#define DCSS_DTG_TC_CH3_TOP                            0x20
> > +#define DCSS_DTG_TC_CH3_BOT                            0x24
> > +#define   TC_X_POS                                     0
> > +#define   TC_X_MASK                                    GENMASK(12, 0)
> > +#define   TC_Y_POS                                     16
> > +#define   TC_Y_MASK                                    GENMASK(28, 16)
> > +#define DCSS_DTG_TC_CTXLD                              0x28
> > +#define   TC_CTXLD_DB_Y_POS                            0
> > +#define   TC_CTXLD_DB_Y_MASK                           GENMASK(12, 0)
> > +#define   TC_CTXLD_SB_Y_POS                            16
> > +#define   TC_CTXLD_SB_Y_MASK                           GENMASK(28, 16)
> > +#define DCSS_DTG_TC_CH1_BKRND                          0x2C
> > +#define DCSS_DTG_TC_CH2_BKRND                          0x30
> > +#define   BKRND_R_Y_COMP_POS                           20
> > +#define   BKRND_R_Y_COMP_MASK                          GENMASK(29, 20)
> > +#define   BKRND_G_U_COMP_POS                           10
> > +#define   BKRND_G_U_COMP_MASK                          GENMASK(19, 10)
> > +#define   BKRND_B_V_COMP_POS                           0
> > +#define   BKRND_B_V_COMP_MASK                          GENMASK(9, 0)
> > +#define DCSS_DTG_BLENDER_DBY_RANGEINV                  0x38
> > +#define DCSS_DTG_BLENDER_DBY_RANGEMIN                  0x3C
> > +#define DCSS_DTG_BLENDER_DBY_BDP                       0x40
> > +#define DCSS_DTG_BLENDER_BKRND_I                       0x44
> > +#define DCSS_DTG_BLENDER_BKRND_P                       0x48
> > +#define DCSS_DTG_BLENDER_BKRND_T                       0x4C
> > +#define DCSS_DTG_LINE0_INT                             0x50
> > +#define DCSS_DTG_LINE1_INT                             0x54
> > +#define DCSS_DTG_BG_ALPHA_DEFAULT                      0x58
> > +#define DCSS_DTG_INT_STATUS                            0x5C
> > +#define DCSS_DTG_INT_CONTROL                           0x60
> > +#define DCSS_DTG_TC_CH3_BKRND                          0x64
> > +#define DCSS_DTG_INT_MASK                              0x68
> > +#define   LINE0_IRQ                                    BIT(0)
> > +#define   LINE1_IRQ                                    BIT(1)
> > +#define   LINE2_IRQ                                    BIT(2)
> > +#define   LINE3_IRQ                                    BIT(3)
> > +#define DCSS_DTG_LINE2_INT                             0x6C
> > +#define DCSS_DTG_LINE3_INT                             0x70
> > +#define DCSS_DTG_DBY_OL                                        0x74
> > +#define DCSS_DTG_DBY_BL                                        0x78
> > +#define DCSS_DTG_DBY_EL                                        0x7C
> > +
> > +struct dcss_dtg {
> > +       struct device *dev;
> > +       struct dcss_ctxld *ctxld;
> > +       void __iomem *base_reg;
> > +       u32 base_ofs;
> > +
> > +       u32 ctx_id;
> > +
> > +       bool in_use;
> > +
> > +       u32 dis_ulc_x;
> > +       u32 dis_ulc_y;
> > +
> > +       u32 control_status;
> > +       u32 alpha;
> > +
> > +       int ctxld_kick_irq;
> > +       bool ctxld_kick_irq_en;
> > +
> > +       struct clk *pix_clk;
> > +       struct clk *pll_src_clk;
> > +       struct clk *pll_phy_ref_clk;
> > +
> > +       /*
> > +        * This will be passed on by DRM CRTC so that we can signal whe=
n DTG has
> > +        * been successfully stopped. Otherwise, any modesetting while =
DTG is
> > +        * still ON may result in unpredictable behavior.
> > +        */
> > +       struct completion *dis_completion;
> > +};
> > +
> > +static void dcss_dtg_write(struct dcss_dtg *dtg, u32 val, u32 ofs)
> > +{
> > +       if (!dtg->in_use)
> > +               dcss_writel(val, dtg->base_reg + ofs);
> > +
> > +       dcss_ctxld_write(dtg->ctxld, dtg->ctx_id, val, dtg->base_ofs + =
ofs);
> > +}
> > +
> > +static irqreturn_t dcss_dtg_irq_handler(int irq, void *data)
> > +{
> > +       struct dcss_dtg *dtg =3D data;
> > +       u32 status;
> > +
> > +       status =3D dcss_readl(dtg->base_reg + DCSS_DTG_INT_STATUS);
> > +
> > +       if (!(status & LINE0_IRQ))
> > +               return IRQ_HANDLED;
> > +
> > +       dcss_ctxld_kick(dtg->ctxld);
> > +
> > +       dcss_writel(status & LINE0_IRQ, dtg->base_reg + DCSS_DTG_INT_CO=
NTROL);
> > +
> > +       return IRQ_HANDLED;
> > +}
> > +
> > +static int dcss_dtg_irq_config(struct dcss_dtg *dtg,
> > +                              struct platform_device *pdev)
> > +{
> > +       int ret;
> > +
> > +       dtg->ctxld_kick_irq =3D platform_get_irq_byname(pdev, "ctxld_ki=
ck");
> > +       if (dtg->ctxld_kick_irq < 0) {
> > +               dev_err(dtg->dev, "dtg: can't get line2 irq number\n");
> > +               return dtg->ctxld_kick_irq;
> > +       }
> > +
> > +       ret =3D devm_request_irq(dtg->dev, dtg->ctxld_kick_irq,
> > +                              dcss_dtg_irq_handler,
> > +                              IRQF_TRIGGER_HIGH,
> > +                              "dcss_ctxld_kick", dtg);
> > +       if (ret) {
> > +               dev_err(dtg->dev, "dtg: irq request failed.\n");
> > +               return ret;
> > +       }
> > +
> > +       disable_irq(dtg->ctxld_kick_irq);
> > +
> > +       dtg->ctxld_kick_irq_en =3D false;
> > +
> > +       dcss_update(LINE0_IRQ, LINE0_IRQ, dtg->base_reg + DCSS_DTG_INT_=
MASK);
> > +
> > +       return 0;
> > +}
> > +
> > +int dcss_dtg_init(struct dcss_dev *dcss, unsigned long dtg_base)
> > +{
> > +       int ret =3D 0;
> > +       struct dcss_dtg *dtg;
> > +
> > +       dtg =3D devm_kzalloc(dcss->dev, sizeof(*dtg), GFP_KERNEL);
> > +       if (!dtg)
> > +               return -ENOMEM;
> > +
> > +       dcss->dtg =3D dtg;
> > +       dtg->dev =3D dcss->dev;
> > +       dtg->ctxld =3D dcss->ctxld;
> > +
> > +       dtg->base_reg =3D devm_ioremap(dcss->dev, dtg_base, SZ_4K);
> > +       if (!dtg->base_reg) {
> > +               dev_err(dcss->dev, "dtg: unable to remap dtg base\n");
> > +               ret =3D -ENOMEM;
> > +               goto err_ioremap;
> > +       }
> > +
> > +       dtg->base_ofs =3D dtg_base;
> > +       dtg->ctx_id =3D CTX_DB;
> > +
> > +       dtg->pix_clk =3D dcss->pix_clk;
> > +       dtg->pll_src_clk =3D dcss->pll_src_clk;
> > +       dtg->pll_phy_ref_clk =3D dcss->pll_phy_ref_clk;
> > +
> > +       dtg->alpha =3D 255;
> > +
> > +       dtg->control_status |=3D OVL_DATA_MODE | BLENDER_VIDEO_ALPHA_SE=
L |
> > +               ((dtg->alpha << DEFAULT_FG_ALPHA_POS) & DEFAULT_FG_ALPH=
A_MASK);
> > +
> > +       ret =3D dcss_dtg_irq_config(dtg, to_platform_device(dcss->dev))=
;
> > +       if (ret)
> > +               goto err_irq;
> > +
> > +       return 0;
> > +
> > +err_irq:
> > +       devm_iounmap(dtg->dev, dtg->base_reg);
> > +
> > +err_ioremap:
> > +       devm_kfree(dtg->dev, dtg);
> > +
> > +       return ret;
> > +}
> > +
> > +void dcss_dtg_exit(struct dcss_dtg *dtg)
> > +{
> > +       /* stop DTG */
> > +       dcss_writel(DTG_START, dtg->base_reg + DCSS_DTG_TC_CONTROL_STAT=
US);
> > +
> > +       devm_free_irq(dtg->dev, dtg->ctxld_kick_irq, dtg);
> > +
> > +       if (dtg->base_reg)
> > +               devm_iounmap(dtg->dev, dtg->base_reg);
> > +
> > +       devm_kfree(dtg->dev, dtg);
> > +}
> > +
> > +void dcss_dtg_sync_set(struct dcss_dtg *dtg, struct videomode *vm)
> > +{
> > +       u16 dtg_lrc_x, dtg_lrc_y;
> > +       u16 dis_ulc_x, dis_ulc_y;
> > +       u16 dis_lrc_x, dis_lrc_y;
> > +       u32 sb_ctxld_trig, db_ctxld_trig;
> > +       u32 pixclock =3D vm->pixelclock;
> > +       u32 actual_clk;
> > +
> > +       dtg_lrc_x =3D vm->hfront_porch + vm->hback_porch + vm->hsync_le=
n +
> > +                   vm->hactive - 1;
> > +       dtg_lrc_y =3D vm->vfront_porch + vm->vback_porch + vm->vsync_le=
n +
> > +                   vm->vactive - 1;
> > +       dis_ulc_x =3D vm->hsync_len + vm->hback_porch - 1;
> > +       dis_ulc_y =3D vm->vsync_len + vm->vfront_porch + vm->vback_porc=
h - 1;
> > +       dis_lrc_x =3D vm->hsync_len + vm->hback_porch + vm->hactive - 1=
;
> > +       dis_lrc_y =3D vm->vsync_len + vm->vfront_porch + vm->vback_porc=
h +
> > +                   vm->vactive - 1;
> > +
> > +       clk_disable_unprepare(dtg->pix_clk);
> > +       clk_set_rate(dtg->pix_clk, vm->pixelclock);
> > +       clk_prepare_enable(dtg->pix_clk);
> > +
> > +       actual_clk =3D clk_get_rate(dtg->pix_clk);
> > +       if (pixclock !=3D actual_clk) {
> > +               dev_info(dtg->dev,
> > +                        "Pixel clock set to %u kHz instead of %u kHz.\=
n",
> > +                        (actual_clk / 1000), (pixclock / 1000));
> > +       }
> > +
> > +       msleep(50);
> > +
> > +       dcss_dtg_write(dtg, ((dtg_lrc_y << TC_Y_POS) | dtg_lrc_x),
> > +                      DCSS_DTG_TC_DTG);
> > +       dcss_dtg_write(dtg, ((dis_ulc_y << TC_Y_POS) | dis_ulc_x),
> > +                      DCSS_DTG_TC_DISP_TOP);
> > +       dcss_dtg_write(dtg, ((dis_lrc_y << TC_Y_POS) | dis_lrc_x),
> > +                      DCSS_DTG_TC_DISP_BOT);
> > +
> > +       dtg->dis_ulc_x =3D dis_ulc_x;
> > +       dtg->dis_ulc_y =3D dis_ulc_y;
> > +
> > +       sb_ctxld_trig =3D ((0 * dis_lrc_y / 100) << TC_CTXLD_SB_Y_POS) =
&
> > +                                                       TC_CTXLD_SB_Y_M=
ASK;
> > +       db_ctxld_trig =3D ((99 * dis_lrc_y / 100) << TC_CTXLD_DB_Y_POS)=
 &
> > +                                                       TC_CTXLD_DB_Y_M=
ASK;
> > +
> > +       dcss_dtg_write(dtg, sb_ctxld_trig | db_ctxld_trig, DCSS_DTG_TC_=
CTXLD);
> > +
> > +       /* vblank trigger */
> > +       dcss_dtg_write(dtg, 0, DCSS_DTG_LINE1_INT);
> > +
> > +       /* CTXLD trigger */
> > +       dcss_dtg_write(dtg, ((90 * dis_lrc_y) / 100) << 16, DCSS_DTG_LI=
NE0_INT);
> > +}
> > +
> > +void dcss_dtg_plane_pos_set(struct dcss_dtg *dtg, int ch_num,
> > +                           int px, int py, int pw, int ph)
> > +{
> > +       u16 p_ulc_x, p_ulc_y;
> > +       u16 p_lrc_x, p_lrc_y;
> > +
> > +       p_ulc_x =3D dtg->dis_ulc_x + px;
> > +       p_ulc_y =3D dtg->dis_ulc_y + py;
> > +       p_lrc_x =3D p_ulc_x + pw;
> > +       p_lrc_y =3D p_ulc_y + ph;
> > +
> > +       if (!px && !py && !pw && !ph) {
> > +               dcss_dtg_write(dtg, 0, DCSS_DTG_TC_CH1_TOP + 0x8 * ch_n=
um);
> > +               dcss_dtg_write(dtg, 0, DCSS_DTG_TC_CH1_BOT + 0x8 * ch_n=
um);
> > +       } else {
> > +               dcss_dtg_write(dtg, ((p_ulc_y << TC_Y_POS) | p_ulc_x),
> > +                              DCSS_DTG_TC_CH1_TOP + 0x8 * ch_num);
> > +               dcss_dtg_write(dtg, ((p_lrc_y << TC_Y_POS) | p_lrc_x),
> > +                              DCSS_DTG_TC_CH1_BOT + 0x8 * ch_num);
> > +       }
> > +}
> > +
> > +bool dcss_dtg_global_alpha_changed(struct dcss_dtg *dtg, int ch_num, i=
nt alpha)
> > +{
> > +       if (ch_num)
> > +               return false;
> > +
> > +       return alpha !=3D dtg->alpha;
> > +}
> > +
> > +void dcss_dtg_plane_alpha_set(struct dcss_dtg *dtg, int ch_num,
> > +                             const struct drm_format_info *format, int=
 alpha)
> > +{
> > +       u32 alpha_val;
> > +
> > +       /* we care about alpha only when channel 0 is concerned */
> > +       if (ch_num)
> > +               return;
> > +
> > +       alpha_val =3D (alpha << DEFAULT_FG_ALPHA_POS) & DEFAULT_FG_ALPH=
A_MASK;
> > +
> > +       /*
> > +        * Use global alpha if pixel format does not have alpha channel=
 or the
> > +        * user explicitly chose to use global alpha (i.e. alpha is not=
 OPAQUE).
> > +        */
> > +       if (!format->has_alpha || alpha !=3D 255) {
> > +               dtg->control_status &=3D ~(CH1_ALPHA_SEL | DEFAULT_FG_A=
LPHA_MASK);
> > +               dtg->control_status |=3D alpha_val;
> > +       } else { /* use per-pixel alpha otherwise */
> > +               dtg->control_status |=3D CH1_ALPHA_SEL;
> > +       }
> > +
> > +       dtg->alpha =3D alpha;
> > +}
> > +
> > +void dcss_dtg_css_set(struct dcss_dtg *dtg)
> > +{
> > +       dtg->control_status |=3D
> > +                       (0x5 << CSS_PIX_COMP_SWAP_POS) & CSS_PIX_COMP_S=
WAP_MASK;
> > +}
> > +
> > +static void dcss_dtg_disable_callback(void *data)
> > +{
> > +       struct dcss_dtg *dtg =3D data;
> > +
> > +       dtg->control_status &=3D ~DTG_START;
> > +
> > +       dcss_writel(dtg->control_status,
> > +                   dtg->base_reg + DCSS_DTG_TC_CONTROL_STATUS);
> > +
> > +       dtg->in_use =3D false;
> > +
> > +       complete(dtg->dis_completion);
> > +}
> > +
> > +void dcss_dtg_enable(struct dcss_dtg *dtg, bool en,
> > +                    struct completion *dis_completion)
> > +{
> > +       if (!en) {
> > +               dtg->dis_completion =3D dis_completion;
> > +               dcss_ctxld_register_dtg_disable_cb(dtg->ctxld,
> > +                                                  dcss_dtg_disable_cal=
lback,
> > +                                                  dtg);
> > +               return;
> > +       }
> > +
> > +       dtg->dis_completion =3D NULL;
> > +
> > +       dtg->control_status |=3D DTG_START;
> > +
> > +       dcss_dtg_write(dtg, dtg->control_status, DCSS_DTG_TC_CONTROL_ST=
ATUS);
> > +
> > +       dtg->in_use =3D true;
> > +}
> > +
> > +bool dcss_dtg_is_enabled(struct dcss_dtg *dtg)
> > +{
> > +       return dtg->in_use;
> > +}
> > +
> > +void dcss_dtg_ch_enable(struct dcss_dtg *dtg, int ch_num, bool en)
> > +{
> > +       u32 ch_en_map[] =3D {CH1_EN, CH2_EN, CH3_EN};
> > +       u32 control_status;
> > +
> > +       control_status =3D dtg->control_status & ~ch_en_map[ch_num];
> > +       control_status |=3D en ? ch_en_map[ch_num] : 0;
> > +
> > +       if (dtg->control_status !=3D control_status)
> > +               dcss_dtg_write(dtg, control_status, DCSS_DTG_TC_CONTROL=
_STATUS);
> > +
> > +       dtg->control_status =3D control_status;
> > +}
> > +
> > +void dcss_dtg_vblank_irq_enable(struct dcss_dtg *dtg, bool en)
> > +{
> > +       u32 status;
> > +
> > +       dcss_update(LINE1_IRQ, LINE1_IRQ, dtg->base_reg + DCSS_DTG_INT_=
MASK);
> > +
> > +       if (en) {
> > +               status =3D dcss_readl(dtg->base_reg + DCSS_DTG_INT_STAT=
US);
> > +               dcss_writel(status & LINE1_IRQ,
> > +                           dtg->base_reg + DCSS_DTG_INT_CONTROL);
> > +       }
> > +}
> > +
> > +void dcss_dtg_ctxld_kick_irq_enable(struct dcss_dtg *dtg, bool en)
> > +{
> > +       u32 status;
> > +
> > +       if (en) {
> > +               status =3D dcss_readl(dtg->base_reg + DCSS_DTG_INT_STAT=
US);
> > +
> > +               if (!dtg->ctxld_kick_irq_en) {
> > +                       dcss_writel(status & LINE0_IRQ,
> > +                                   dtg->base_reg + DCSS_DTG_INT_CONTRO=
L);
> > +                       enable_irq(dtg->ctxld_kick_irq);
> > +                       dtg->ctxld_kick_irq_en =3D true;
> > +                       return;
> > +               }
> > +
> > +               return;
> > +       }
> > +
> > +       if (!dtg->ctxld_kick_irq_en)
> > +               return;
> > +
> > +       disable_irq_nosync(dtg->ctxld_kick_irq);
> > +       dtg->ctxld_kick_irq_en =3D false;
> > +}
> > +
> > +void dcss_dtg_vblank_irq_clear(struct dcss_dtg *dtg)
> > +{
> > +       dcss_update(LINE1_IRQ, LINE1_IRQ, dtg->base_reg + DCSS_DTG_INT_=
CONTROL);
> > +}
> > +
> > +bool dcss_dtg_vblank_irq_valid(struct dcss_dtg *dtg)
> > +{
> > +       return !!(dcss_readl(dtg->base_reg + DCSS_DTG_INT_STATUS) & LIN=
E1_IRQ);
> > +}
> > +
> > diff --git a/drivers/gpu/drm/imx/dcss/dcss-kms.c b/drivers/gpu/drm/imx/=
dcss/dcss-kms.c
> > new file mode 100644
> > index 00000000..d3bc889
> > --- /dev/null
> > +++ b/drivers/gpu/drm/imx/dcss/dcss-kms.c
> > @@ -0,0 +1,321 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright 2019 NXP.
> > + */
> > +
> > +#include <drm/drm_atomic.h>
> > +#include <drm/drm_atomic_helper.h>
> > +#include <drm/drm_fb_helper.h>
> > +#include <drm/drm_gem_cma_helper.h>
> > +#include <drm/drm_gem_framebuffer_helper.h>
> > +#include <drm/drm_of.h>
> > +#include <drm/drm_probe_helper.h>
> > +#include <drm/drmP.h>
> > +#include <linux/component.h>
> > +
> > +#include "dcss-dev.h"
> > +#include "dcss-kms.h"
> > +
> > +DEFINE_DRM_GEM_CMA_FOPS(dcss_cma_fops);
> > +
> > +struct dcss_drm_commit {
> > +       struct work_struct work;
> > +       struct drm_device *drm;
> > +       struct drm_atomic_state *state;
> > +};
> > +
> > +static void dcss_drm_atomic_commit_tail(struct dcss_drm_commit *commit=
)
> > +{
> > +       struct drm_atomic_state *state =3D commit->state;
> > +       struct drm_device *drm =3D commit->drm;
> > +       struct dcss_kms_dev *kms =3D container_of(drm, struct dcss_kms_=
dev, base);
> > +
> > +       drm_atomic_helper_wait_for_fences(drm, state, false);
> > +
> > +       drm_atomic_helper_wait_for_dependencies(state);
> > +
> > +       drm_atomic_helper_commit_modeset_disables(drm, state);
> > +
> > +       drm_atomic_helper_commit_modeset_enables(drm, state);
> > +
> > +       drm_atomic_helper_commit_planes(drm, state,
> > +                                       DRM_PLANE_COMMIT_ACTIVE_ONLY);
> > +
> > +       drm_atomic_helper_commit_hw_done(state);
> > +
> > +       drm_atomic_helper_wait_for_vblanks(drm, state);
> > +
> > +       drm_atomic_helper_cleanup_planes(drm, state);
> > +
> > +       drm_atomic_helper_commit_cleanup_done(state);
> > +
> > +       drm_atomic_state_put(state);
> > +
> > +       spin_lock(&kms->commit.wait.lock);
> > +       kms->commit.pending =3D false;
> > +       wake_up_all_locked(&kms->commit.wait);
> > +       spin_unlock(&kms->commit.wait.lock);
> > +
> > +       kfree(commit);
> > +}
> > +
> > +static void dcss_commit_work(struct work_struct *work)
> > +{
> > +       struct dcss_drm_commit *commit =3D container_of(work,
> > +                                                     struct dcss_drm_c=
ommit,
> > +                                                     work);
> > +
> > +       dcss_drm_atomic_commit_tail(commit);
> > +}
> > +
> > +static int dcss_drm_atomic_commit(struct drm_device *drm,
> > +                                 struct drm_atomic_state *state,
> > +                                 bool nonblock)
> > +{
> > +       int ret;
> > +       struct dcss_kms_dev *kms =3D container_of(drm, struct dcss_kms_=
dev, base);
> > +       struct dcss_drm_commit *commit;
> > +
> > +       if (state->async_update) {
> > +               ret =3D drm_atomic_helper_prepare_planes(drm, state);
> > +               if (ret)
> > +                       return ret;
> > +
> > +               drm_atomic_helper_async_commit(drm, state);
> > +               drm_atomic_helper_cleanup_planes(drm, state);
> > +
> > +               return 0;
> > +       }
> > +
> > +       commit =3D kzalloc(sizeof(*commit), GFP_KERNEL);
> > +       if (!commit)
> > +               return -ENOMEM;
> > +
> > +       commit->drm =3D drm;
> > +       commit->state =3D state;
> > +
> > +       ret =3D drm_atomic_helper_setup_commit(state, nonblock);
> > +       if (ret)
> > +               goto err_free;
> > +
> > +       INIT_WORK(&commit->work, dcss_commit_work);
> > +
> > +       ret =3D drm_atomic_helper_prepare_planes(drm, state);
> > +       if (ret)
> > +               goto err_free;
> > +
> > +       if (!nonblock) {
> > +               ret =3D drm_atomic_helper_wait_for_fences(drm, state, t=
rue);
> > +               if (ret)
> > +                       goto err;
> > +       }
> > +
> > +       spin_lock(&kms->commit.wait.lock);
> > +       ret =3D wait_event_interruptible_locked(kms->commit.wait,
> > +                                             !kms->commit.pending);
> > +       if (ret =3D=3D 0)
> > +               kms->commit.pending =3D true;
> > +       spin_unlock(&kms->commit.wait.lock);
> > +
> > +       if (ret)
> > +               goto err;
> > +
> > +       ret =3D drm_atomic_helper_swap_state(state, true);
> > +       if (ret)
> > +               goto err;
> > +
> > +       drm_atomic_state_get(state);
> > +       if (nonblock)
> > +               queue_work(kms->commit_wq, &commit->work);
> > +       else
> > +               dcss_drm_atomic_commit_tail(commit);
> > +
> > +       return 0;
> > +
> > +err:
> > +       drm_atomic_helper_cleanup_planes(drm, state);
> > +
> > +err_free:
> > +       kfree(commit);
> > +       return ret;
> > +}
> > +
> > +const struct drm_mode_config_funcs dcss_drm_mode_config_funcs =3D {
> > +       .fb_create =3D drm_gem_fb_create,
> > +       .output_poll_changed =3D drm_fb_helper_output_poll_changed,
> > +       .atomic_check =3D drm_atomic_helper_check,
> > +       .atomic_commit =3D dcss_drm_atomic_commit,
> > +};
> > +
> > +static struct drm_driver dcss_kms_driver =3D {
> > +       .driver_features        =3D DRIVER_MODESET | DRIVER_GEM | DRIVE=
R_ATOMIC,
> > +       .gem_free_object_unlocked =3D drm_gem_cma_free_object,
> > +       .gem_vm_ops             =3D &drm_gem_cma_vm_ops,
> > +       .dumb_create            =3D drm_gem_cma_dumb_create,
> > +
> > +       .prime_handle_to_fd     =3D drm_gem_prime_handle_to_fd,
> > +       .prime_fd_to_handle     =3D drm_gem_prime_fd_to_handle,
> > +       .gem_prime_import       =3D drm_gem_prime_import,
> > +       .gem_prime_export       =3D drm_gem_prime_export,
> > +       .gem_prime_get_sg_table =3D drm_gem_cma_prime_get_sg_table,
> > +       .gem_prime_import_sg_table =3D drm_gem_cma_prime_import_sg_tabl=
e,
> > +       .gem_prime_vmap         =3D drm_gem_cma_prime_vmap,
> > +       .gem_prime_vunmap       =3D drm_gem_cma_prime_vunmap,
> > +       .gem_prime_mmap         =3D drm_gem_cma_prime_mmap,
> > +       .fops                   =3D &dcss_cma_fops,
> > +       .name                   =3D "imx-dcss",
> > +       .desc                   =3D "i.MX8MQ Display Subsystem",
> > +       .date                   =3D "20190917",
> > +       .major                  =3D 1,
> > +       .minor                  =3D 0,
> > +       .patchlevel             =3D 0,
> > +};
> > +
> > +static const struct drm_mode_config_helper_funcs dcss_mode_config_help=
ers =3D {
> > +       .atomic_commit_tail =3D drm_atomic_helper_commit_tail_rpm,
> > +};
> > +
> > +static void dcss_kms_mode_config_init(struct dcss_kms_dev *kms)
> > +{
> > +       struct drm_mode_config *config =3D &kms->base.mode_config;
> > +
> > +       drm_mode_config_init(&kms->base);
> > +
> > +       config->min_width =3D 1;
> > +       config->min_height =3D 1;
> > +       config->max_width =3D 4096;
> > +       config->max_height =3D 4096;
> > +       config->allow_fb_modifiers =3D true;
> > +       config->normalize_zpos =3D true;
> > +
> > +       config->funcs =3D &dcss_drm_mode_config_funcs;
> > +       config->helper_private =3D &dcss_mode_config_helpers;
> > +}
> > +
> > +static const struct drm_encoder_funcs dcss_kms_simple_encoder_funcs =
=3D {
> > +       .destroy =3D drm_encoder_cleanup,
> > +};
> > +
> > +static int dcss_kms_setup_encoder(struct dcss_kms_dev *kms)
> > +{
> > +       struct drm_device *ddev =3D &kms->base;
> > +       struct drm_encoder *encoder =3D &kms->encoder;
> > +       struct drm_crtc *crtc =3D (struct drm_crtc *)&kms->crtc;
> > +       struct drm_panel *panel;
> > +       struct drm_bridge *bridge;
> > +       int ret;
> > +
> > +       ret =3D drm_of_find_panel_or_bridge(ddev->dev->of_node, 0, 0,
> > +                                         &panel, &bridge);
> > +       if (ret)
> > +               return ret;
> > +
> > +       if (!bridge) {
> > +               dev_err(ddev->dev, "No bridge found %d.\n", ret);
> > +               return -ENODEV;
> > +       }
> > +
> > +       encoder->possible_crtcs =3D drm_crtc_mask(crtc);
> > +
> > +       ret =3D drm_encoder_init(&kms->base, encoder,
> > +                              &dcss_kms_simple_encoder_funcs,
> > +                              DRM_MODE_ENCODER_NONE, NULL);
> > +       if (ret) {
> > +               dev_err(ddev->dev, "Failed initializing encoder %d.\n",=
 ret);
> > +               return ret;
> > +       }
> > +
> > +       return drm_bridge_attach(encoder, bridge, NULL);
> > +}
> > +
> > +struct dcss_kms_dev *dcss_kms_attach(struct dcss_dev *dcss, bool compo=
nentized)
> > +{
> > +       struct dcss_kms_dev *kms =3D kzalloc(sizeof(*kms), GFP_KERNEL);
> > +       struct drm_device *drm;
> > +       struct dcss_crtc *crtc;
> > +       int ret;
> > +
> > +       if (!kms)
> > +               return ERR_PTR(-ENOMEM);
> > +
> > +       drm =3D &kms->base;
> > +       crtc =3D &kms->crtc;
> > +       ret =3D drm_dev_init(drm, &dcss_kms_driver, dcss->dev);
> > +       if (ret)
> > +               goto free_kms;
> > +
> > +       drm->dev_private =3D dcss;
> > +
> > +       dcss_kms_mode_config_init(kms);
> > +
> > +       ret =3D drm_vblank_init(drm, 1);
> > +       if (ret)
> > +               goto cleanup_mode_config;
> > +
> > +       drm->irq_enabled =3D true;
> > +
> > +       ret =3D dcss_crtc_init(crtc, drm);
> > +       if (ret)
> > +               goto cleanup_mode_config;
> > +
> > +       kms->commit_wq =3D alloc_ordered_workqueue("dcss_nonblock_commi=
t_wq", 0);
> > +       if (!kms->commit_wq) {
> > +               ret =3D -ENOMEM;
> > +               goto cleanup_crtc;
> > +       }
> > +
> > +       init_waitqueue_head(&kms->commit.wait);
> > +
> > +       if (componentized)
> > +               ret =3D component_bind_all(dcss->dev, kms);
> > +       else
> > +               ret =3D dcss_kms_setup_encoder(kms);
> > +
> > +       if (ret)
> > +               goto cleanup_wq;
> > +
> > +       drm_mode_config_reset(drm);
> > +
> > +       drm_kms_helper_poll_init(drm);
> > +
> > +       ret =3D drm_dev_register(drm, 0);
> > +       if (ret)
> > +               goto cleanup_wq;
> > +
> > +       drm_fbdev_generic_setup(drm, 32);
> > +
> > +       return kms;
> > +
> > +cleanup_wq:
> > +       drm_kms_helper_poll_fini(drm);
> > +       destroy_workqueue(kms->commit_wq);
> > +
> > +cleanup_crtc:
> > +       dcss_crtc_deinit(crtc, drm);
> > +
> > +cleanup_mode_config:
> > +       drm_mode_config_cleanup(drm);
> > +
> > +free_kms:
> > +       kfree(kms);
> > +       return ERR_PTR(ret);
> > +}
> > +
> > +void dcss_kms_detach(struct dcss_kms_dev *kms, bool componentized)
> > +{
> > +       struct drm_device *drm =3D &kms->base;
> > +       struct dcss_dev *dcss =3D drm->dev_private;
> > +
> > +       drm_dev_unregister(drm);
> > +       drm_kms_helper_poll_fini(drm);
> > +       drm_atomic_helper_shutdown(drm);
> > +       drm_crtc_vblank_off(&kms->crtc.base);
> > +       drm->irq_enabled =3D false;
> > +       drm_mode_config_cleanup(drm);
> > +       destroy_workqueue(kms->commit_wq);
> > +       dcss_crtc_deinit(&kms->crtc, drm);
> > +       if (componentized)
> > +               component_unbind_all(dcss->dev, drm);
> > +       drm->dev_private =3D NULL;
> > +       drm_dev_put(drm);
> > +}
> > diff --git a/drivers/gpu/drm/imx/dcss/dcss-kms.h b/drivers/gpu/drm/imx/=
dcss/dcss-kms.h
> > new file mode 100644
> > index 00000000..6297005
> > --- /dev/null
> > +++ b/drivers/gpu/drm/imx/dcss/dcss-kms.h
> > @@ -0,0 +1,52 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright 2019 NXP.
> > + */
> > +
> > +#ifndef _DCSS_KMS_H_
> > +#define _DCSS_KMS_H_
> > +
> > +#include <drm/drm_encoder.h>
> > +
> > +struct dcss_plane {
> > +       struct drm_plane base;
> > +
> > +       int ch_num;
> > +};
> > +
> > +struct dcss_crtc {
> > +       struct drm_crtc         base;
> > +       struct drm_crtc_state   *state;
> > +
> > +       struct dcss_plane       *plane[3];
> > +
> > +       int                     irq;
> > +       bool                    irq_enabled;
> > +
> > +       struct completion en_completion;
> > +       struct completion dis_completion;
> > +};
> > +
> > +struct commit {
> > +       wait_queue_head_t wait;
> > +       bool pending;
> > +};
> > +
> > +struct dcss_kms_dev {
> > +       struct drm_device base;
> > +       struct dcss_crtc crtc;
> > +       struct drm_encoder encoder;
> > +       struct workqueue_struct *commit_wq;
> > +       struct commit commit;
> > +};
> > +
> > +struct dcss_kms_dev *dcss_kms_attach(struct dcss_dev *dcss, bool compo=
nentized);
> > +void dcss_kms_detach(struct dcss_kms_dev *kms, bool componentized);
> > +int dcss_crtc_init(struct dcss_crtc *crtc, struct drm_device *drm);
> > +void dcss_crtc_deinit(struct dcss_crtc *crtc, struct drm_device *drm);
> > +struct dcss_plane *dcss_plane_init(struct drm_device *drm,
> > +                                  unsigned int possible_crtcs,
> > +                                  enum drm_plane_type type,
> > +                                  unsigned int zpos);
> > +
> > +#endif
> > diff --git a/drivers/gpu/drm/imx/dcss/dcss-plane.c b/drivers/gpu/drm/im=
x/dcss/dcss-plane.c
> > new file mode 100644
> > index 00000000..cb18c3e
> > --- /dev/null
> > +++ b/drivers/gpu/drm/imx/dcss/dcss-plane.c
> > @@ -0,0 +1,418 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright 2019 NXP.
> > + */
> > +
> > +#include <drm/drm_atomic.h>
> > +#include <drm/drm_atomic_helper.h>
> > +#include <drm/drm_fb_cma_helper.h>
> > +#include <drm/drm_gem_framebuffer_helper.h>
> > +#include <drm/drm_gem_cma_helper.h>
> > +
> > +#include "dcss-dev.h"
> > +#include "dcss-kms.h"
> > +
> > +static const u32 dcss_common_formats[] =3D {
> > +       /* RGB */
> > +       DRM_FORMAT_ARGB8888,
> > +       DRM_FORMAT_XRGB8888,
> > +       DRM_FORMAT_ABGR8888,
> > +       DRM_FORMAT_XBGR8888,
> > +       DRM_FORMAT_RGBA8888,
> > +       DRM_FORMAT_RGBX8888,
> > +       DRM_FORMAT_BGRA8888,
> > +       DRM_FORMAT_BGRX8888,
> > +       DRM_FORMAT_XRGB2101010,
> > +       DRM_FORMAT_XBGR2101010,
> > +       DRM_FORMAT_RGBX1010102,
> > +       DRM_FORMAT_BGRX1010102,
> > +       DRM_FORMAT_ARGB2101010,
> > +       DRM_FORMAT_ABGR2101010,
> > +       DRM_FORMAT_RGBA1010102,
> > +       DRM_FORMAT_BGRA1010102,
> > +
> > +       /* YUV444 */
> > +       DRM_FORMAT_AYUV,
> > +
> > +       /* YUV422 */
> > +       DRM_FORMAT_UYVY,
> > +       DRM_FORMAT_VYUY,
> > +       DRM_FORMAT_YUYV,
> > +       DRM_FORMAT_YVYU,
> > +
> > +       /* YUV420 */
> > +       DRM_FORMAT_NV12,
> > +       DRM_FORMAT_NV21,
> > +};
> > +
> > +static const u64 dcss_video_format_modifiers[] =3D {
> > +       DRM_FORMAT_MOD_LINEAR,
> > +       DRM_FORMAT_MOD_INVALID,
> > +};
> > +
> > +static const u64 dcss_graphics_format_modifiers[] =3D {
> > +       DRM_FORMAT_MOD_VIVANTE_TILED,
> > +       DRM_FORMAT_MOD_VIVANTE_SUPER_TILED,
> > +       DRM_FORMAT_MOD_LINEAR,
> > +       DRM_FORMAT_MOD_INVALID,
> > +};
> > +
> > +static inline struct dcss_plane *to_dcss_plane(struct drm_plane *p)
> > +{
> > +       return container_of(p, struct dcss_plane, base);
> > +}
> > +
> > +static inline bool dcss_plane_fb_is_linear(const struct drm_framebuffe=
r *fb)
> > +{
> > +       return ((fb->flags & DRM_MODE_FB_MODIFIERS) =3D=3D 0) ||
> > +              ((fb->flags & DRM_MODE_FB_MODIFIERS) !=3D 0 &&
> > +               fb->modifier =3D=3D DRM_FORMAT_MOD_LINEAR);
> > +}
> > +
> > +static void dcss_plane_destroy(struct drm_plane *plane)
> > +{
> > +       struct dcss_plane *dcss_plane =3D container_of(plane, struct dc=
ss_plane,
> > +                                                    base);
> > +
> > +       drm_plane_cleanup(plane);
> > +       kfree(dcss_plane);
> > +}
> > +
> > +static bool dcss_plane_format_mod_supported(struct drm_plane *plane,
> > +                                           u32 format,
> > +                                           u64 modifier)
> > +{
> > +       switch (plane->type) {
> > +       case DRM_PLANE_TYPE_PRIMARY:
> > +               switch (format) {
> > +               case DRM_FORMAT_ARGB8888:
> > +               case DRM_FORMAT_XRGB8888:
> > +               case DRM_FORMAT_ARGB2101010:
> > +                       return modifier =3D=3D DRM_FORMAT_MOD_LINEAR ||
> > +                              modifier =3D=3D DRM_FORMAT_MOD_VIVANTE_T=
ILED ||
> > +                              modifier =3D=3D DRM_FORMAT_MOD_VIVANTE_S=
UPER_TILED;
> > +               default:
> > +                       return modifier =3D=3D DRM_FORMAT_MOD_LINEAR;
> > +               }
> > +               break;
> > +       case DRM_PLANE_TYPE_OVERLAY:
> > +               return modifier =3D=3D DRM_FORMAT_MOD_LINEAR;
> > +       default:
> > +               return false;
> > +       }
> > +}
> > +
> > +static const struct drm_plane_funcs dcss_plane_funcs =3D {
> > +       .update_plane           =3D drm_atomic_helper_update_plane,
> > +       .disable_plane          =3D drm_atomic_helper_disable_plane,
> > +       .destroy                =3D dcss_plane_destroy,
> > +       .reset                  =3D drm_atomic_helper_plane_reset,
> > +       .atomic_duplicate_state =3D drm_atomic_helper_plane_duplicate_s=
tate,
> > +       .atomic_destroy_state   =3D drm_atomic_helper_plane_destroy_sta=
te,
> > +       .format_mod_supported   =3D dcss_plane_format_mod_supported,
> > +};
> > +
> > +static bool dcss_plane_can_rotate(const struct drm_format_info *format=
,
> > +                                 bool mod_present, u64 modifier,
> > +                                 unsigned int rotation)
> > +{
> > +       bool linear_format =3D !mod_present ||
> > +                            (mod_present && modifier =3D=3D DRM_FORMAT=
_MOD_LINEAR);
> > +       u32 supported_rotation =3D DRM_MODE_ROTATE_0;
> > +
> > +       if (!format->is_yuv && linear_format)
> > +               supported_rotation =3D DRM_MODE_ROTATE_0 | DRM_MODE_ROT=
ATE_180 |
> > +                                    DRM_MODE_REFLECT_MASK;
> > +       else if (!format->is_yuv &&
> > +                modifier =3D=3D DRM_FORMAT_MOD_VIVANTE_TILED)
> > +               supported_rotation =3D DRM_MODE_ROTATE_MASK |
> > +                                    DRM_MODE_REFLECT_MASK;
> > +       else if (format->is_yuv && linear_format &&
> > +                (format->format =3D=3D DRM_FORMAT_NV12 ||
> > +                 format->format =3D=3D DRM_FORMAT_NV21))
> > +               supported_rotation =3D DRM_MODE_ROTATE_0 | DRM_MODE_ROT=
ATE_180 |
> > +                                    DRM_MODE_REFLECT_MASK;
> > +
> > +       return !!(rotation & supported_rotation);
> > +}
> > +
> > +static bool dcss_plane_is_source_size_allowed(u16 src_w, u16 src_h, u3=
2 pix_fmt)
> > +{
> > +       if (src_w < 64 &&
> > +           (pix_fmt =3D=3D DRM_FORMAT_NV12 || pix_fmt =3D=3D DRM_FORMA=
T_NV21))
> > +               return false;
> > +       else if (src_w < 32 &&
> > +                (pix_fmt =3D=3D DRM_FORMAT_UYVY || pix_fmt =3D=3D DRM_=
FORMAT_VYUY ||
> > +                 pix_fmt =3D=3D DRM_FORMAT_YUYV || pix_fmt =3D=3D DRM_=
FORMAT_YVYU))
> > +               return false;
> > +
> > +       return src_w >=3D 16 && src_h >=3D 8;
> > +}
> > +
> > +static int dcss_plane_atomic_check(struct drm_plane *plane,
> > +                                  struct drm_plane_state *state)
> > +{
> > +       struct dcss_plane *dcss_plane =3D to_dcss_plane(plane);
> > +       struct dcss_dev *dcss =3D plane->dev->dev_private;
> > +       struct drm_framebuffer *fb =3D state->fb;
> > +       bool is_primary_plane =3D plane->type =3D=3D DRM_PLANE_TYPE_PRI=
MARY;
> > +       struct drm_gem_cma_object *cma_obj;
> > +       struct drm_crtc_state *crtc_state;
> > +       int hdisplay, vdisplay;
> > +       int min, max;
> > +       int ret;
> > +
> > +       if (!fb || !state->crtc)
> > +               return 0;
> > +
> > +       cma_obj =3D drm_fb_cma_get_gem_obj(fb, 0);
> > +       WARN_ON(!cma_obj);
> > +
> > +       crtc_state =3D drm_atomic_get_existing_crtc_state(state->state,
> > +                                                       state->crtc);
> > +
> > +       hdisplay =3D crtc_state->adjusted_mode.hdisplay;
> > +       vdisplay =3D crtc_state->adjusted_mode.vdisplay;
> > +
> > +       if (!dcss_plane_is_source_size_allowed(state->src_w >> 16,
> > +                                              state->src_h >> 16,
> > +                                              fb->format->format)) {
> > +               DRM_DEBUG_KMS("Source plane size is not allowed!\n");
> > +               return -EINVAL;
> > +       }
> > +
> > +       dcss_scaler_get_min_max_ratios(dcss->scaler, dcss_plane->ch_num=
,
> > +                                      &min, &max);
> > +
> > +       ret =3D drm_atomic_helper_check_plane_state(state, crtc_state,
> > +                                                 min, max, !is_primary=
_plane,
> > +                                                 false);
> > +       if (ret)
> > +               return ret;
> > +
> > +       if (!state->visible)
> > +               return 0;
> > +
> > +       if (!dcss_plane_can_rotate(fb->format,
> > +                                  !!(fb->flags & DRM_MODE_FB_MODIFIERS=
),
> > +                                  fb->modifier,
> > +                                  state->rotation)) {
> > +               DRM_DEBUG_KMS("requested rotation is not allowed!\n");
> > +               return -EINVAL;
> > +       }
> > +
> > +       if ((state->crtc_x < 0 || state->crtc_y < 0 ||
> > +            state->crtc_x + state->crtc_w > hdisplay ||
> > +            state->crtc_y + state->crtc_h > vdisplay) &&
> > +           !dcss_plane_fb_is_linear(fb)) {
> > +               DRM_DEBUG_KMS("requested cropping operation is not allo=
wed!\n");
> > +               return -EINVAL;
> > +       }
> > +
> > +       if ((fb->flags & DRM_MODE_FB_MODIFIERS) &&
> > +           !plane->funcs->format_mod_supported(plane,
> > +                               fb->format->format,
> > +                               fb->modifier)) {
> > +               DRM_DEBUG_KMS("Invalid modifier: %llx", fb->modifier);
> > +               return -EINVAL;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static void dcss_plane_atomic_set_base(struct dcss_plane *dcss_plane)
> > +{
> > +       struct drm_plane *plane =3D &dcss_plane->base;
> > +       struct drm_plane_state *state =3D plane->state;
> > +       struct dcss_dev *dcss =3D plane->dev->dev_private;
> > +       struct drm_framebuffer *fb =3D state->fb;
> > +       const struct drm_format_info *format =3D fb->format;
> > +       struct drm_gem_cma_object *cma_obj =3D drm_fb_cma_get_gem_obj(f=
b, 0);
> > +       unsigned long p1_ba =3D 0, p2_ba =3D 0;
> > +
> > +       if (!format->is_yuv ||
> > +           format->format =3D=3D DRM_FORMAT_NV12 ||
> > +           format->format =3D=3D DRM_FORMAT_NV21)
> > +               p1_ba =3D cma_obj->paddr + fb->offsets[0] +
> > +                       fb->pitches[0] * (state->src.y1 >> 16) +
> > +                       format->char_per_block[0] * (state->src.x1 >> 1=
6);
> > +       else if (format->format =3D=3D DRM_FORMAT_UYVY ||
> > +                format->format =3D=3D DRM_FORMAT_VYUY ||
> > +                format->format =3D=3D DRM_FORMAT_YUYV ||
> > +                format->format =3D=3D DRM_FORMAT_YVYU)
> > +               p1_ba =3D cma_obj->paddr + fb->offsets[0] +
> > +                       fb->pitches[0] * (state->src.y1 >> 16) +
> > +                       2 * format->char_per_block[0] * (state->src.x1 =
>> 17);
> > +
> > +       if (format->format =3D=3D DRM_FORMAT_NV12 ||
> > +           format->format =3D=3D DRM_FORMAT_NV21)
> > +               p2_ba =3D cma_obj->paddr + fb->offsets[1] +
> > +                       (((fb->pitches[1] >> 1) * (state->src.y1 >> 17)=
 +
> > +                       (state->src.x1 >> 17)) << 1);
> > +
> > +       dcss_dpr_addr_set(dcss->dpr, dcss_plane->ch_num, p1_ba, p2_ba,
> > +                         fb->pitches[0]);
> > +}
> > +
> > +static bool dcss_plane_needs_setup(struct drm_plane_state *state,
> > +                                  struct drm_plane_state *old_state)
> > +{
> > +       struct drm_framebuffer *fb =3D state->fb;
> > +       struct drm_framebuffer *old_fb =3D old_state->fb;
> > +
> > +       return state->crtc_x !=3D old_state->crtc_x ||
> > +              state->crtc_y !=3D old_state->crtc_y ||
> > +              state->crtc_w !=3D old_state->crtc_w ||
> > +              state->crtc_h !=3D old_state->crtc_h ||
> > +              state->src_x  !=3D old_state->src_x  ||
> > +              state->src_y  !=3D old_state->src_y  ||
> > +              state->src_w  !=3D old_state->src_w  ||
> > +              state->src_h  !=3D old_state->src_h  ||
> > +              fb->format->format !=3D old_fb->format->format ||
> > +              fb->modifier  !=3D old_fb->modifier ||
> > +              state->rotation !=3D old_state->rotation;
> > +}
> > +
> > +static void dcss_plane_atomic_update(struct drm_plane *plane,
> > +                                    struct drm_plane_state *old_state)
> > +{
> > +       struct drm_plane_state *state =3D plane->state;
> > +       struct dcss_plane *dcss_plane =3D to_dcss_plane(plane);
> > +       struct dcss_dev *dcss =3D plane->dev->dev_private;
> > +       struct drm_framebuffer *fb =3D state->fb;
> > +       u32 pixel_format;
> > +       struct drm_crtc_state *crtc_state;
> > +       bool modifiers_present;
> > +       u32 src_w, src_h, dst_w, dst_h;
> > +       struct drm_rect src, dst;
> > +       bool enable =3D true;
> > +
> > +       if (!fb || !state->crtc || !state->visible)
> > +               return;
> > +
> > +       pixel_format =3D state->fb->format->format;
> > +       crtc_state =3D state->crtc->state;
> > +       modifiers_present =3D !!(fb->flags & DRM_MODE_FB_MODIFIERS);
> > +
> > +       if (old_state->fb && !drm_atomic_crtc_needs_modeset(crtc_state)=
 &&
> > +           !dcss_plane_needs_setup(state, old_state)) {
> > +               dcss_plane_atomic_set_base(dcss_plane);
> > +               return;
> > +       }
> > +
> > +       src =3D plane->state->src;
> > +       dst =3D plane->state->dst;
> > +
> > +       /*
> > +        * The width and height after clipping.
> > +        */
> > +       src_w =3D drm_rect_width(&src) >> 16;
> > +       src_h =3D drm_rect_height(&src) >> 16;
> > +       dst_w =3D drm_rect_width(&dst);
> > +       dst_h =3D drm_rect_height(&dst);
> > +
> > +       if (plane->type =3D=3D DRM_PLANE_TYPE_OVERLAY &&
> > +           modifiers_present && fb->modifier =3D=3D DRM_FORMAT_MOD_LIN=
EAR)
> > +               modifiers_present =3D false;
> > +
> > +       dcss_dpr_format_set(dcss->dpr, dcss_plane->ch_num, state->fb->f=
ormat,
> > +                           modifiers_present ? fb->modifier :
> > +                                               DRM_FORMAT_MOD_LINEAR);
> > +       dcss_dpr_set_res(dcss->dpr, dcss_plane->ch_num, src_w, src_h);
> > +       dcss_dpr_set_rotation(dcss->dpr, dcss_plane->ch_num,
> > +                             state->rotation);
> > +
> > +       dcss_plane_atomic_set_base(dcss_plane);
> > +
> > +       dcss_scaler_setup(dcss->scaler, dcss_plane->ch_num,
> > +                         state->fb->format, src_w, src_h,
> > +                         dst_w, dst_h,
> > +                         drm_mode_vrefresh(&crtc_state->mode));
> > +
> > +       dcss_dtg_plane_pos_set(dcss->dtg, dcss_plane->ch_num,
> > +                              dst.x1, dst.y1, dst_w, dst_h);
> > +       dcss_dtg_plane_alpha_set(dcss->dtg, dcss_plane->ch_num,
> > +                                fb->format, state->alpha >> 8);
> > +
> > +       if (!dcss_plane->ch_num && (state->alpha >> 8) =3D=3D 0)
> > +               enable =3D false;
> > +
> > +       dcss_dpr_enable(dcss->dpr, dcss_plane->ch_num, enable);
> > +       dcss_scaler_ch_enable(dcss->scaler, dcss_plane->ch_num, enable)=
;
> > +
> > +       if (!enable)
> > +               dcss_dtg_plane_pos_set(dcss->dtg, dcss_plane->ch_num,
> > +                                      0, 0, 0, 0);
> > +
> > +       dcss_dtg_ch_enable(dcss->dtg, dcss_plane->ch_num, enable);
> > +}
> > +
> > +static void dcss_plane_atomic_disable(struct drm_plane *plane,
> > +                                     struct drm_plane_state *old_state=
)
> > +{
> > +       struct dcss_plane *dcss_plane =3D to_dcss_plane(plane);
> > +       struct dcss_dev *dcss =3D plane->dev->dev_private;
> > +
> > +       dcss_dpr_enable(dcss->dpr, dcss_plane->ch_num, false);
> > +       dcss_scaler_ch_enable(dcss->scaler, dcss_plane->ch_num, false);
> > +       dcss_dtg_plane_pos_set(dcss->dtg, dcss_plane->ch_num, 0, 0, 0, =
0);
> > +       dcss_dtg_ch_enable(dcss->dtg, dcss_plane->ch_num, false);
> > +}
> > +
> > +static const struct drm_plane_helper_funcs dcss_plane_helper_funcs =3D=
 {
> > +       .prepare_fb =3D drm_gem_fb_prepare_fb,
> > +       .atomic_check =3D dcss_plane_atomic_check,
> > +       .atomic_update =3D dcss_plane_atomic_update,
> > +       .atomic_disable =3D dcss_plane_atomic_disable,
> > +};
> > +
> > +struct dcss_plane *dcss_plane_init(struct drm_device *drm,
> > +                                  unsigned int possible_crtcs,
> > +                                  enum drm_plane_type type,
> > +                                  unsigned int zpos)
> > +{
> > +       struct dcss_plane *dcss_plane;
> > +       const u64 *format_modifiers =3D dcss_video_format_modifiers;
> > +       int ret;
> > +
> > +       if (zpos > 2)
> > +               return ERR_PTR(-EINVAL);
> > +
> > +       dcss_plane =3D kzalloc(sizeof(*dcss_plane), GFP_KERNEL);
> > +       if (!dcss_plane) {
> > +               DRM_ERROR("failed to allocate plane\n");
> > +               return ERR_PTR(-ENOMEM);
> > +       }
> > +
> > +       if (type =3D=3D DRM_PLANE_TYPE_PRIMARY)
> > +               format_modifiers =3D dcss_graphics_format_modifiers;
> > +
> > +       ret =3D drm_universal_plane_init(drm, &dcss_plane->base, possib=
le_crtcs,
> > +                                      &dcss_plane_funcs, dcss_common_f=
ormats,
> > +                                      ARRAY_SIZE(dcss_common_formats),
> > +                                      format_modifiers, type, NULL);
> > +       if (ret) {
> > +               DRM_ERROR("failed to initialize plane\n");
> > +               kfree(dcss_plane);
> > +               return ERR_PTR(ret);
> > +       }
> > +
> > +       drm_plane_helper_add(&dcss_plane->base, &dcss_plane_helper_func=
s);
> > +
> > +       ret =3D drm_plane_create_zpos_immutable_property(&dcss_plane->b=
ase, zpos);
> > +       if (ret)
> > +               return ERR_PTR(ret);
> > +
> > +       drm_plane_create_rotation_property(&dcss_plane->base,
> > +                                          DRM_MODE_ROTATE_0,
> > +                                          DRM_MODE_ROTATE_0   |
> > +                                          DRM_MODE_ROTATE_90  |
> > +                                          DRM_MODE_ROTATE_180 |
> > +                                          DRM_MODE_ROTATE_270 |
> > +                                          DRM_MODE_REFLECT_X  |
> > +                                          DRM_MODE_REFLECT_Y);
> > +
> > +       dcss_plane->ch_num =3D zpos;
> > +
> > +       return dcss_plane;
> > +}
> > diff --git a/drivers/gpu/drm/imx/dcss/dcss-scaler.c b/drivers/gpu/drm/i=
mx/dcss/dcss-scaler.c
> > new file mode 100644
> > index 00000000..3e317f4
> > --- /dev/null
> > +++ b/drivers/gpu/drm/imx/dcss/dcss-scaler.c
> > @@ -0,0 +1,830 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright 2019 NXP.
> > + *
> > + * Scaling algorithms were contributed by Dzung Hoang <dzung.hoang@nxp=
.com>
> > + */
> > +
> > +#include <linux/device.h>
> > +
> > +#include "dcss-dev.h"
> > +
> > +#define DCSS_SCALER_CTRL                       0x00
> > +#define   SCALER_EN                            BIT(0)
> > +#define   REPEAT_EN                            BIT(4)
> > +#define   SCALE2MEM_EN                         BIT(8)
> > +#define   MEM2OFIFO_EN                         BIT(12)
> > +#define DCSS_SCALER_OFIFO_CTRL                 0x04
> > +#define   OFIFO_LOW_THRES_POS                  0
> > +#define   OFIFO_LOW_THRES_MASK                 GENMASK(9, 0)
> > +#define   OFIFO_HIGH_THRES_POS                 16
> > +#define   OFIFO_HIGH_THRES_MASK                        GENMASK(25, 16)
> > +#define   UNDERRUN_DETECT_CLR                  BIT(26)
> > +#define   LOW_THRES_DETECT_CLR                 BIT(27)
> > +#define   HIGH_THRES_DETECT_CLR                        BIT(28)
> > +#define   UNDERRUN_DETECT_EN                   BIT(29)
> > +#define   LOW_THRES_DETECT_EN                  BIT(30)
> > +#define   HIGH_THRES_DETECT_EN                 BIT(31)
> > +#define DCSS_SCALER_SDATA_CTRL                 0x08
> > +#define   YUV_EN                               BIT(0)
> > +#define   RTRAM_8LINES                         BIT(1)
> > +#define   Y_UV_BYTE_SWAP                       BIT(4)
> > +#define   A2R10G10B10_FORMAT_POS               8
> > +#define   A2R10G10B10_FORMAT_MASK              GENMASK(11, 8)
> > +#define DCSS_SCALER_BIT_DEPTH                  0x0C
> > +#define   LUM_BIT_DEPTH_POS                    0
> > +#define   LUM_BIT_DEPTH_MASK                   GENMASK(1, 0)
> > +#define   CHR_BIT_DEPTH_POS                    4
> > +#define   CHR_BIT_DEPTH_MASK                   GENMASK(5, 4)
> > +#define DCSS_SCALER_SRC_FORMAT                 0x10
> > +#define DCSS_SCALER_DST_FORMAT                 0x14
> > +#define   FORMAT_MASK                          GENMASK(1, 0)
> > +#define DCSS_SCALER_SRC_LUM_RES                        0x18
> > +#define DCSS_SCALER_SRC_CHR_RES                        0x1C
> > +#define DCSS_SCALER_DST_LUM_RES                        0x20
> > +#define DCSS_SCALER_DST_CHR_RES                        0x24
> > +#define   WIDTH_POS                            0
> > +#define   WIDTH_MASK                           GENMASK(11, 0)
> > +#define   HEIGHT_POS                           16
> > +#define   HEIGHT_MASK                          GENMASK(27, 16)
> > +#define DCSS_SCALER_V_LUM_START                        0x48
> > +#define   V_START_MASK                         GENMASK(15, 0)
> > +#define DCSS_SCALER_V_LUM_INC                  0x4C
> > +#define   V_INC_MASK                           GENMASK(15, 0)
> > +#define DCSS_SCALER_H_LUM_START                        0x50
> > +#define   H_START_MASK                         GENMASK(18, 0)
> > +#define DCSS_SCALER_H_LUM_INC                  0x54
> > +#define   H_INC_MASK                           GENMASK(15, 0)
> > +#define DCSS_SCALER_V_CHR_START                        0x58
> > +#define DCSS_SCALER_V_CHR_INC                  0x5C
> > +#define DCSS_SCALER_H_CHR_START                        0x60
> > +#define DCSS_SCALER_H_CHR_INC                  0x64
> > +#define DCSS_SCALER_COEF_VLUM                  0x80
> > +#define DCSS_SCALER_COEF_HLUM                  0x140
> > +#define DCSS_SCALER_COEF_VCHR                  0x200
> > +#define DCSS_SCALER_COEF_HCHR                  0x300
> > +
> > +struct dcss_scaler_ch {
> > +       void __iomem *base_reg;
> > +       u32 base_ofs;
> > +       struct dcss_scaler *scl;
> > +
> > +       u32 sdata_ctrl;
> > +       u32 scaler_ctrl;
> > +
> > +       bool scaler_ctrl_chgd;
> > +
> > +       u32 c_vstart;
> > +       u32 c_hstart;
> > +};
> > +
> > +struct dcss_scaler {
> > +       struct device *dev;
> > +
> > +       struct dcss_ctxld *ctxld;
> > +       u32 ctx_id;
> > +
> > +       struct dcss_scaler_ch ch[3];
> > +};
> > +
> > +/* scaler coefficients generator */
> > +#define PSC_FRAC_BITS 30
> > +#define PSC_FRAC_SCALE BIT(PSC_FRAC_BITS)
> > +#define PSC_BITS_FOR_PHASE 4
> > +#define PSC_NUM_PHASES 16
> > +#define PSC_STORED_PHASES (PSC_NUM_PHASES / 2 + 1)
> > +#define PSC_NUM_TAPS 7
> > +#define PSC_NUM_TAPS_RGBA 5
> > +#define PSC_COEFF_PRECISION 10
> > +#define PSC_PHASE_FRACTION_BITS 13
> > +#define PSC_PHASE_MASK (PSC_NUM_PHASES - 1)
> > +#define PSC_Q_FRACTION 19
> > +#define PSC_Q_ROUND_OFFSET (1 << (PSC_Q_FRACTION - 1))
> > +
> > +/**
> > + * mult_q() - Performs fixed-point multiplication.
> > + * @A: multiplier
> > + * @B: multiplicand
> > + */
> > +static int mult_q(int A, int B)
> > +{
> > +       int result;
> > +       s64 temp;
> > +
> > +       temp =3D (int64_t)A * (int64_t)B;
> > +       temp +=3D PSC_Q_ROUND_OFFSET;
> > +       result =3D (int)(temp >> PSC_Q_FRACTION);
> > +       return result;
> > +}
> > +
> > +/**
> > + * div_q() - Performs fixed-point division.
> > + * @A: dividend
> > + * @B: divisor
> > + */
> > +static int div_q(int A, int B)
> > +{
> > +       int result;
> > +       s64 temp;
> > +
> > +       temp =3D (int64_t)A << PSC_Q_FRACTION;
> > +       if ((temp >=3D 0 && B >=3D 0) || (temp < 0 && B < 0))
> > +               temp +=3D B / 2;
> > +       else
> > +               temp -=3D B / 2;
> > +
> > +       result =3D (int)(temp / B);
> > +       return result;
> > +}
> > +
> > +/**
> > + * exp_approx_q() - Compute approximation to exp(x) function using Tay=
lor
> > + *                 series.
> > + * @x: fixed-point argument of exp function
> > + */
> > +static int exp_approx_q(int x)
> > +{
> > +       int sum =3D 1 << PSC_Q_FRACTION;
> > +       int term =3D 1 << PSC_Q_FRACTION;
> > +
> > +       term =3D mult_q(term, div_q(x, 1 << PSC_Q_FRACTION));
> > +       sum +=3D term;
> > +       term =3D mult_q(term, div_q(x, 2 << PSC_Q_FRACTION));
> > +       sum +=3D term;
> > +       term =3D mult_q(term, div_q(x, 3 << PSC_Q_FRACTION));
> > +       sum +=3D term;
> > +       term =3D mult_q(term, div_q(x, 4 << PSC_Q_FRACTION));
> > +       sum +=3D term;
> > +
> > +       return sum;
> > +}
> > +
> > +/**
> > + * dcss_scaler_gaussian_filter() - Generate gaussian prototype filter.
> > + * @fc_q: fixed-point cutoff frequency normalized to range [0, 1]
> > + * @use_5_taps: indicates whether to use 5 taps or 7 taps
> > + * @coef: output filter coefficients
> > + */
> > +static void dcss_scaler_gaussian_filter(int fc_q, bool use_5_taps,
> > +                                       bool phase0_identity,
> > +                                       int coef[][PSC_NUM_TAPS])
> > +{
> > +       int sigma_q, g0_q, g1_q, g2_q;
> > +       int tap_cnt1, tap_cnt2, tap_idx, phase_cnt;
> > +       int mid;
> > +       int phase;
> > +       int i;
> > +       int taps;
> > +
> > +       if (use_5_taps)
> > +               for (phase =3D 0; phase < PSC_STORED_PHASES; phase++) {
> > +                       coef[phase][0] =3D 0;
> > +                       coef[phase][PSC_NUM_TAPS - 1] =3D 0;
> > +               }
> > +
> > +       /* seed coefficient scanner */
> > +       taps =3D use_5_taps ? PSC_NUM_TAPS_RGBA : PSC_NUM_TAPS;
> > +       mid =3D (PSC_NUM_PHASES * taps) / 2 - 1;
> > +       phase_cnt =3D (PSC_NUM_PHASES * (PSC_NUM_TAPS + 1)) / 2;
> > +       tap_cnt1 =3D (PSC_NUM_PHASES * PSC_NUM_TAPS) / 2;
> > +       tap_cnt2 =3D (PSC_NUM_PHASES * PSC_NUM_TAPS) / 2;
> > +
> > +       /* seed gaussian filter generator */
> > +       sigma_q =3D div_q(PSC_Q_ROUND_OFFSET, fc_q);
> > +       g0_q =3D 1 << PSC_Q_FRACTION;
> > +       g1_q =3D exp_approx_q(div_q(-PSC_Q_ROUND_OFFSET,
> > +                                 mult_q(sigma_q, sigma_q)));
> > +       g2_q =3D mult_q(g1_q, g1_q);
> > +       coef[phase_cnt & PSC_PHASE_MASK][tap_cnt1 >> PSC_BITS_FOR_PHASE=
] =3D g0_q;
> > +
> > +       for (i =3D 0; i < mid; i++) {
> > +               phase_cnt++;
> > +               tap_cnt1--;
> > +               tap_cnt2++;
> > +
> > +               g0_q =3D mult_q(g0_q, g1_q);
> > +               g1_q =3D mult_q(g1_q, g2_q);
> > +
> > +               if ((phase_cnt & PSC_PHASE_MASK) <=3D 8) {
> > +                       tap_idx =3D tap_cnt1 >> PSC_BITS_FOR_PHASE;
> > +                       coef[phase_cnt & PSC_PHASE_MASK][tap_idx] =3D g=
0_q;
> > +               }
> > +               if (((-phase_cnt) & PSC_PHASE_MASK) <=3D 8) {
> > +                       tap_idx =3D tap_cnt2 >> PSC_BITS_FOR_PHASE;
> > +                       coef[(-phase_cnt) & PSC_PHASE_MASK][tap_idx] =
=3D g0_q;
> > +               }
> > +       }
> > +
> > +       phase_cnt++;
> > +       tap_cnt1--;
> > +       coef[phase_cnt & PSC_PHASE_MASK][tap_cnt1 >> PSC_BITS_FOR_PHASE=
] =3D 0;
> > +
> > +       /* override phase 0 with identity filter if specified */
> > +       if (phase0_identity)
> > +               for (i =3D 0; i < PSC_NUM_TAPS; i++)
> > +                       coef[0][i] =3D i =3D=3D (PSC_NUM_TAPS >> 1) ?
> > +                                               (1 << PSC_COEFF_PRECISI=
ON) : 0;
> > +
> > +       /* normalize coef */
> > +       for (phase =3D 0; phase < PSC_STORED_PHASES; phase++) {
> > +               int sum =3D 0;
> > +               s64 ll_temp;
> > +
> > +               for (i =3D 0; i < PSC_NUM_TAPS; i++)
> > +                       sum +=3D coef[phase][i];
> > +               for (i =3D 0; i < PSC_NUM_TAPS; i++) {
> > +                       ll_temp =3D coef[phase][i];
> > +                       ll_temp <<=3D PSC_COEFF_PRECISION;
> > +                       ll_temp +=3D sum >> 1;
> > +                       ll_temp /=3D sum;
> > +                       coef[phase][i] =3D (int)ll_temp;
> > +               }
> > +       }
> > +}
> > +
> > +/**
> > + * dcss_scaler_filter_design() - Compute filter coefficients using
> > + *                              Gaussian filter.
> > + * @src_length: length of input
> > + * @dst_length: length of output
> > + * @use_5_taps: 0 for 7 taps per phase, 1 for 5 taps
> > + * @coef: output coefficients
> > + */
> > +static void dcss_scaler_filter_design(int src_length, int dst_length,
> > +                                     bool use_5_taps, bool phase0_iden=
tity,
> > +                                     int coef[][PSC_NUM_TAPS])
> > +{
> > +       int fc_q;
> > +
> > +       /* compute cutoff frequency */
> > +       if (dst_length >=3D src_length)
> > +               fc_q =3D div_q(1, PSC_NUM_PHASES);
> > +       else
> > +               fc_q =3D div_q(dst_length, src_length * PSC_NUM_PHASES)=
;
> > +
> > +       /* compute gaussian filter coefficients */
> > +       dcss_scaler_gaussian_filter(fc_q, use_5_taps, phase0_identity, =
coef);
> > +}
> > +
> > +static void dcss_scaler_write(struct dcss_scaler_ch *ch, u32 val, u32 =
ofs)
> > +{
> > +       struct dcss_scaler *scl =3D ch->scl;
> > +
> > +       dcss_ctxld_write(scl->ctxld, scl->ctx_id, val, ch->base_ofs + o=
fs);
> > +}
> > +
> > +static int dcss_scaler_ch_init_all(struct dcss_scaler *scl,
> > +                                  unsigned long scaler_base)
> > +{
> > +       struct dcss_scaler_ch *ch;
> > +       int i;
> > +
> > +       for (i =3D 0; i < 3; i++) {
> > +               ch =3D &scl->ch[i];
> > +
> > +               ch->base_ofs =3D scaler_base + i * 0x400;
> > +
> > +               ch->base_reg =3D devm_ioremap(scl->dev, ch->base_ofs, S=
Z_4K);
> > +               if (!ch->base_reg) {
> > +                       dev_err(scl->dev, "scaler: unable to remap ch b=
ase\n");
> > +                       return -ENOMEM;
> > +               }
> > +
> > +               ch->scl =3D scl;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +int dcss_scaler_init(struct dcss_dev *dcss, unsigned long scaler_base)
> > +{
> > +       struct dcss_scaler *scaler;
> > +
> > +       scaler =3D devm_kzalloc(dcss->dev, sizeof(*scaler), GFP_KERNEL)=
;
> > +       if (!scaler)
> > +               return -ENOMEM;
> > +
> > +       dcss->scaler =3D scaler;
> > +       scaler->dev =3D dcss->dev;
> > +       scaler->ctxld =3D dcss->ctxld;
> > +       scaler->ctx_id =3D CTX_SB_HP;
> > +
> > +       if (dcss_scaler_ch_init_all(scaler, scaler_base)) {
> > +               int i;
> > +
> > +               for (i =3D 0; i < 3; i++) {
> > +                       if (scaler->ch[i].base_reg)
> > +                               devm_iounmap(scaler->dev,
> > +                                            scaler->ch[i].base_reg);
> > +               }
> > +
> > +               devm_kfree(scaler->dev, scaler);
> > +
> > +               return -ENOMEM;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +void dcss_scaler_exit(struct dcss_scaler *scl)
> > +{
> > +       int ch_no;
> > +
> > +       for (ch_no =3D 0; ch_no < 3; ch_no++) {
> > +               struct dcss_scaler_ch *ch =3D &scl->ch[ch_no];
> > +
> > +               dcss_writel(0, ch->base_reg + DCSS_SCALER_CTRL);
> > +
> > +               if (ch->base_reg)
> > +                       devm_iounmap(scl->dev, ch->base_reg);
> > +       }
> > +
> > +       devm_kfree(scl->dev, scl);
> > +}
> > +
> > +void dcss_scaler_ch_enable(struct dcss_scaler *scl, int ch_num, bool e=
n)
> > +{
> > +       struct dcss_scaler_ch *ch =3D &scl->ch[ch_num];
> > +       u32 scaler_ctrl;
> > +
> > +       scaler_ctrl =3D en ? SCALER_EN | REPEAT_EN : 0;
> > +
> > +       if (en)
> > +               dcss_scaler_write(ch, ch->sdata_ctrl, DCSS_SCALER_SDATA=
_CTRL);
> > +
> > +       if (ch->scaler_ctrl !=3D scaler_ctrl)
> > +               ch->scaler_ctrl_chgd =3D true;
> > +
> > +       ch->scaler_ctrl =3D scaler_ctrl;
> > +}
> > +
> > +static void dcss_scaler_yuv_enable(struct dcss_scaler_ch *ch, bool en)
> > +{
> > +       ch->sdata_ctrl &=3D ~YUV_EN;
> > +       ch->sdata_ctrl |=3D en ? YUV_EN : 0;
> > +}
> > +
> > +static void dcss_scaler_rtr_8lines_enable(struct dcss_scaler_ch *ch, b=
ool en)
> > +{
> > +       ch->sdata_ctrl &=3D ~RTRAM_8LINES;
> > +       ch->sdata_ctrl |=3D en ? RTRAM_8LINES : 0;
> > +}
> > +
> > +static void dcss_scaler_bit_depth_set(struct dcss_scaler_ch *ch, int d=
epth)
> > +{
> > +       u32 val;
> > +
> > +       val =3D depth =3D=3D 30 ? 2 : 0;
> > +
> > +       dcss_scaler_write(ch,
> > +                         ((val << CHR_BIT_DEPTH_POS) & CHR_BIT_DEPTH_M=
ASK) |
> > +                         ((val << LUM_BIT_DEPTH_POS) & LUM_BIT_DEPTH_M=
ASK),
> > +                         DCSS_SCALER_BIT_DEPTH);
> > +}
> > +
> > +enum buffer_format {
> > +       BUF_FMT_YUV420,
> > +       BUF_FMT_YUV422,
> > +       BUF_FMT_ARGB8888_YUV444,
> > +};
> > +
> > +enum chroma_location {
> > +       PSC_LOC_HORZ_0_VERT_1_OVER_4 =3D 0,
> > +       PSC_LOC_HORZ_1_OVER_4_VERT_1_OVER_4 =3D 1,
> > +       PSC_LOC_HORZ_0_VERT_0 =3D 2,
> > +       PSC_LOC_HORZ_1_OVER_4_VERT_0 =3D 3,
> > +       PSC_LOC_HORZ_0_VERT_1_OVER_2 =3D 4,
> > +       PSC_LOC_HORZ_1_OVER_4_VERT_1_OVER_2 =3D 5
> > +};
> > +
> > +static void dcss_scaler_format_set(struct dcss_scaler_ch *ch,
> > +                                  enum buffer_format src_fmt,
> > +                                  enum buffer_format dst_fmt)
> > +{
> > +       dcss_scaler_write(ch, src_fmt, DCSS_SCALER_SRC_FORMAT);
> > +       dcss_scaler_write(ch, dst_fmt, DCSS_SCALER_DST_FORMAT);
> > +}
> > +
> > +static void dcss_scaler_res_set(struct dcss_scaler_ch *ch,
> > +                               int src_xres, int src_yres,
> > +                               int dst_xres, int dst_yres,
> > +                               u32 pix_format, enum buffer_format dst_=
format)
> > +{
> > +       u32 lsrc_xres, lsrc_yres, csrc_xres, csrc_yres;
> > +       u32 ldst_xres, ldst_yres, cdst_xres, cdst_yres;
> > +       bool src_is_444 =3D true;
> > +
> > +       lsrc_xres =3D src_xres;
> > +       csrc_xres =3D src_xres;
> > +       lsrc_yres =3D src_yres;
> > +       csrc_yres =3D src_yres;
> > +       ldst_xres =3D dst_xres;
> > +       cdst_xres =3D dst_xres;
> > +       ldst_yres =3D dst_yres;
> > +       cdst_yres =3D dst_yres;
> > +
> > +       if (pix_format =3D=3D DRM_FORMAT_UYVY || pix_format =3D=3D DRM_=
FORMAT_VYUY ||
> > +           pix_format =3D=3D DRM_FORMAT_YUYV || pix_format =3D=3D DRM_=
FORMAT_YVYU) {
> > +               csrc_xres >>=3D 1;
> > +               src_is_444 =3D false;
> > +       } else if (pix_format =3D=3D DRM_FORMAT_NV12 ||
> > +                  pix_format =3D=3D DRM_FORMAT_NV21) {
> > +               csrc_xres >>=3D 1;
> > +               csrc_yres >>=3D 1;
> > +               src_is_444 =3D false;
> > +       }
> > +
> > +       if (dst_format =3D=3D BUF_FMT_YUV422)
> > +               cdst_xres >>=3D 1;
> > +
> > +       /* for 4:4:4 to 4:2:2 conversion, source height should be 1 les=
s */
> > +       if (src_is_444 && dst_format =3D=3D BUF_FMT_YUV422) {
> > +               lsrc_yres--;
> > +               csrc_yres--;
> > +       }
> > +
> > +       dcss_scaler_write(ch, (((lsrc_yres - 1) << HEIGHT_POS) & HEIGHT=
_MASK) |
> > +                              (((lsrc_xres - 1) << WIDTH_POS) & WIDTH_=
MASK),
> > +                         DCSS_SCALER_SRC_LUM_RES);
> > +       dcss_scaler_write(ch, (((csrc_yres - 1) << HEIGHT_POS) & HEIGHT=
_MASK) |
> > +                              (((csrc_xres - 1) << WIDTH_POS) & WIDTH_=
MASK),
> > +                         DCSS_SCALER_SRC_CHR_RES);
> > +       dcss_scaler_write(ch, (((ldst_yres - 1) << HEIGHT_POS) & HEIGHT=
_MASK) |
> > +                              (((ldst_xres - 1) << WIDTH_POS) & WIDTH_=
MASK),
> > +                         DCSS_SCALER_DST_LUM_RES);
> > +       dcss_scaler_write(ch, (((cdst_yres - 1) << HEIGHT_POS) & HEIGHT=
_MASK) |
> > +                              (((cdst_xres - 1) << WIDTH_POS) & WIDTH_=
MASK),
> > +                         DCSS_SCALER_DST_CHR_RES);
> > +}
> > +
> > +#define max_downscale(ratio)           ((ratio) << 16)
> > +#define max_upscale(ratio)             ((1 << 16) / (ratio))
> > +
> > +struct dcss_scaler_ratios {
> > +       int downscale;
> > +       int upscale;
> > +};
> > +
> > +static const struct dcss_scaler_ratios dcss_scaler_ratios[] =3D {
> > +       {max_downscale(3), max_upscale(8)},
> > +       {max_downscale(5), max_upscale(8)},
> > +       {max_downscale(5), max_upscale(8)},
> > +};
> > +
> > +static void dcss_scaler_fractions_set(struct dcss_scaler_ch *ch,
> > +                                     int src_xres, int src_yres,
> > +                                     int dst_xres, int dst_yres,
> > +                                     u32 src_format, u32 dst_format,
> > +                                     enum chroma_location src_chroma_l=
oc)
> > +{
> > +       int src_c_xres, src_c_yres, dst_c_xres, dst_c_yres;
> > +       u32 l_vinc, l_hinc, c_vinc, c_hinc;
> > +       u32 c_vstart, c_hstart;
> > +
> > +       src_c_xres =3D src_xres;
> > +       src_c_yres =3D src_yres;
> > +       dst_c_xres =3D dst_xres;
> > +       dst_c_yres =3D dst_yres;
> > +
> > +       c_vstart =3D 0;
> > +       c_hstart =3D 0;
> > +
> > +       /* adjustments for source chroma location */
> > +       if (src_format =3D=3D BUF_FMT_YUV420) {
> > +               /* vertical input chroma position adjustment */
> > +               switch (src_chroma_loc) {
> > +               case PSC_LOC_HORZ_0_VERT_1_OVER_4:
> > +               case PSC_LOC_HORZ_1_OVER_4_VERT_1_OVER_4:
> > +                       /*
> > +                        * move chroma up to first luma line
> > +                        * (1/4 chroma input line spacing)
> > +                        */
> > +                       c_vstart -=3D (1 << (PSC_PHASE_FRACTION_BITS - =
2));
> > +                       break;
> > +               case PSC_LOC_HORZ_0_VERT_1_OVER_2:
> > +               case PSC_LOC_HORZ_1_OVER_4_VERT_1_OVER_2:
> > +                       /*
> > +                        * move chroma up to first luma line
> > +                        * (1/2 chroma input line spacing)
> > +                        */
> > +                       c_vstart -=3D (1 << (PSC_PHASE_FRACTION_BITS - =
1));
> > +                       break;
> > +               default:
> > +                       break;
> > +               }
> > +               /* horizontal input chroma position adjustment */
> > +               switch (src_chroma_loc) {
> > +               case PSC_LOC_HORZ_1_OVER_4_VERT_1_OVER_4:
> > +               case PSC_LOC_HORZ_1_OVER_4_VERT_0:
> > +               case PSC_LOC_HORZ_1_OVER_4_VERT_1_OVER_2:
> > +                       /* move chroma left 1/4 chroma input sample spa=
cing */
> > +                       c_hstart -=3D (1 << (PSC_PHASE_FRACTION_BITS - =
2));
> > +                       break;
> > +               default:
> > +                       break;
> > +               }
> > +       }
> > +
> > +       /* adjustments to chroma resolution */
> > +       if (src_format =3D=3D BUF_FMT_YUV420) {
> > +               src_c_xres >>=3D 1;
> > +               src_c_yres >>=3D 1;
> > +       } else if (src_format =3D=3D BUF_FMT_YUV422) {
> > +               src_c_xres >>=3D 1;
> > +       }
> > +
> > +       if (dst_format =3D=3D BUF_FMT_YUV422)
> > +               dst_c_xres >>=3D 1;
> > +
> > +       l_vinc =3D ((src_yres << 13) + (dst_yres >> 1)) / dst_yres;
> > +       c_vinc =3D ((src_c_yres << 13) + (dst_c_yres >> 1)) / dst_c_yre=
s;
> > +       l_hinc =3D ((src_xres << 13) + (dst_xres >> 1)) / dst_xres;
> > +       c_hinc =3D ((src_c_xres << 13) + (dst_c_xres >> 1)) / dst_c_xre=
s;
> > +
> > +       /* save chroma start phase */
> > +       ch->c_vstart =3D c_vstart;
> > +       ch->c_hstart =3D c_hstart;
> > +
> > +       dcss_scaler_write(ch, 0, DCSS_SCALER_V_LUM_START);
> > +       dcss_scaler_write(ch, l_vinc, DCSS_SCALER_V_LUM_INC);
> > +
> > +       dcss_scaler_write(ch, 0, DCSS_SCALER_H_LUM_START);
> > +       dcss_scaler_write(ch, l_hinc, DCSS_SCALER_H_LUM_INC);
> > +
> > +       dcss_scaler_write(ch, c_vstart, DCSS_SCALER_V_CHR_START);
> > +       dcss_scaler_write(ch, c_vinc, DCSS_SCALER_V_CHR_INC);
> > +
> > +       dcss_scaler_write(ch, c_hstart, DCSS_SCALER_H_CHR_START);
> > +       dcss_scaler_write(ch, c_hinc, DCSS_SCALER_H_CHR_INC);
> > +}
> > +
> > +int dcss_scaler_get_min_max_ratios(struct dcss_scaler *scl, int ch_num=
,
> > +                                  int *min, int *max)
> > +{
> > +       *min =3D dcss_scaler_ratios[ch_num].upscale;
> > +       *max =3D dcss_scaler_ratios[ch_num].downscale;
> > +
> > +       return 0;
> > +}
> > +
> > +static void dcss_scaler_program_5_coef_set(struct dcss_scaler_ch *ch,
> > +                                          int base_addr,
> > +                                          int coef[][PSC_NUM_TAPS])
> > +{
> > +       int i, phase;
> > +
> > +       for (i =3D 0; i < PSC_STORED_PHASES; i++) {
> > +               dcss_scaler_write(ch, ((coef[i][1] & 0xfff) << 16 |
> > +                                      (coef[i][2] & 0xfff) << 4  |
> > +                                      (coef[i][3] & 0xf00) >> 8),
> > +                                 base_addr + i * sizeof(u32));
> > +               dcss_scaler_write(ch, ((coef[i][3] & 0x0ff) << 20 |
> > +                                      (coef[i][4] & 0xfff) << 8  |
> > +                                      (coef[i][5] & 0xff0) >> 4),
> > +                                 base_addr + 0x40 + i * sizeof(u32));
> > +               dcss_scaler_write(ch, ((coef[i][5] & 0x00f) << 24),
> > +                                 base_addr + 0x80 + i * sizeof(u32));
> > +       }
> > +
> > +       /* reverse both phase and tap orderings */
> > +       for (phase =3D (PSC_NUM_PHASES >> 1) - 1;
> > +                       i < PSC_NUM_PHASES; i++, phase--) {
> > +               dcss_scaler_write(ch, ((coef[phase][5] & 0xfff) << 16 |
> > +                                      (coef[phase][4] & 0xfff) << 4  |
> > +                                      (coef[phase][3] & 0xf00) >> 8),
> > +                                 base_addr + i * sizeof(u32));
> > +               dcss_scaler_write(ch, ((coef[phase][3] & 0x0ff) << 20 |
> > +                                      (coef[phase][2] & 0xfff) << 8  |
> > +                                      (coef[phase][1] & 0xff0) >> 4),
> > +                                 base_addr + 0x40 + i * sizeof(u32));
> > +               dcss_scaler_write(ch, ((coef[phase][1] & 0x00f) << 24),
> > +                                 base_addr + 0x80 + i * sizeof(u32));
> > +       }
> > +}
> > +
> > +static void dcss_scaler_program_7_coef_set(struct dcss_scaler_ch *ch,
> > +                                          int base_addr,
> > +                                          int coef[][PSC_NUM_TAPS])
> > +{
> > +       int i, phase;
> > +
> > +       for (i =3D 0; i < PSC_STORED_PHASES; i++) {
> > +               dcss_scaler_write(ch, ((coef[i][0] & 0xfff) << 16 |
> > +                                      (coef[i][1] & 0xfff) << 4  |
> > +                                      (coef[i][2] & 0xf00) >> 8),
> > +                                 base_addr + i * sizeof(u32));
> > +               dcss_scaler_write(ch, ((coef[i][2] & 0x0ff) << 20 |
> > +                                      (coef[i][3] & 0xfff) << 8  |
> > +                                      (coef[i][4] & 0xff0) >> 4),
> > +                                 base_addr + 0x40 + i * sizeof(u32));
> > +               dcss_scaler_write(ch, ((coef[i][4] & 0x00f) << 24 |
> > +                                      (coef[i][5] & 0xfff) << 12 |
> > +                                      (coef[i][6] & 0xfff)),
> > +                                 base_addr + 0x80 + i * sizeof(u32));
> > +       }
> > +
> > +       /* reverse both phase and tap orderings */
> > +       for (phase =3D (PSC_NUM_PHASES >> 1) - 1;
> > +                       i < PSC_NUM_PHASES; i++, phase--) {
> > +               dcss_scaler_write(ch, ((coef[phase][6] & 0xfff) << 16 |
> > +                                      (coef[phase][5] & 0xfff) << 4  |
> > +                                      (coef[phase][4] & 0xf00) >> 8),
> > +                                 base_addr + i * sizeof(u32));
> > +               dcss_scaler_write(ch, ((coef[phase][4] & 0x0ff) << 20 |
> > +                                      (coef[phase][3] & 0xfff) << 8  |
> > +                                      (coef[phase][2] & 0xff0) >> 4),
> > +                                 base_addr + 0x40 + i * sizeof(u32));
> > +               dcss_scaler_write(ch, ((coef[phase][2] & 0x00f) << 24 |
> > +                                      (coef[phase][1] & 0xfff) << 12 |
> > +                                      (coef[phase][0] & 0xfff)),
> > +                                 base_addr + 0x80 + i * sizeof(u32));
> > +       }
> > +}
> > +
> > +static void dcss_scaler_yuv_coef_set(struct dcss_scaler_ch *ch,
> > +                                    enum buffer_format src_format,
> > +                                    enum buffer_format dst_format,
> > +                                    bool use_5_taps,
> > +                                    int src_xres, int src_yres, int ds=
t_xres,
> > +                                    int dst_yres)
> > +{
> > +       int coef[PSC_STORED_PHASES][PSC_NUM_TAPS];
> > +       bool program_5_taps =3D use_5_taps ||
> > +                             (dst_format =3D=3D BUF_FMT_YUV422 &&
> > +                              src_format =3D=3D BUF_FMT_ARGB8888_YUV44=
4);
> > +
> > +       /* horizontal luma */
> > +       dcss_scaler_filter_design(src_xres, dst_xres, false,
> > +                                 src_xres =3D=3D dst_xres, coef);
> > +       dcss_scaler_program_7_coef_set(ch, DCSS_SCALER_COEF_HLUM, coef)=
;
> > +
> > +       /* vertical luma */
> > +       dcss_scaler_filter_design(src_yres, dst_yres, program_5_taps,
> > +                                 src_yres =3D=3D dst_yres, coef);
> > +
> > +       if (program_5_taps)
> > +               dcss_scaler_program_5_coef_set(ch, DCSS_SCALER_COEF_VLU=
M, coef);
> > +       else
> > +               dcss_scaler_program_7_coef_set(ch, DCSS_SCALER_COEF_VLU=
M, coef);
> > +
> > +       /* adjust chroma resolution */
> > +       if (src_format !=3D BUF_FMT_ARGB8888_YUV444)
> > +               src_xres >>=3D 1;
> > +       if (src_format =3D=3D BUF_FMT_YUV420)
> > +               src_yres >>=3D 1;
> > +       if (dst_format !=3D BUF_FMT_ARGB8888_YUV444)
> > +               dst_xres >>=3D 1;
> > +       if (dst_format =3D=3D BUF_FMT_YUV420) /* should not happen */
> > +               dst_yres >>=3D 1;
> > +
> > +       /* horizontal chroma */
> > +       dcss_scaler_filter_design(src_xres, dst_xres, false,
> > +                                 (src_xres =3D=3D dst_xres) && (ch->c_=
hstart =3D=3D 0),
> > +                                 coef);
> > +
> > +       dcss_scaler_program_7_coef_set(ch, DCSS_SCALER_COEF_HCHR, coef)=
;
> > +
> > +       /* vertical chroma */
> > +       dcss_scaler_filter_design(src_yres, dst_yres, program_5_taps,
> > +                                 (src_yres =3D=3D dst_yres) && (ch->c_=
vstart =3D=3D 0),
> > +                                 coef);
> > +       if (program_5_taps)
> > +               dcss_scaler_program_5_coef_set(ch, DCSS_SCALER_COEF_VCH=
R, coef);
> > +       else
> > +               dcss_scaler_program_7_coef_set(ch, DCSS_SCALER_COEF_VCH=
R, coef);
> > +}
> > +
> > +static void dcss_scaler_rgb_coef_set(struct dcss_scaler_ch *ch,
> > +                                    int src_xres, int src_yres, int ds=
t_xres,
> > +                                    int dst_yres)
> > +{
> > +       int coef[PSC_STORED_PHASES][PSC_NUM_TAPS];
> > +
> > +       /* horizontal RGB */
> > +       dcss_scaler_filter_design(src_xres, dst_xres, false,
> > +                                 src_xres =3D=3D dst_xres, coef);
> > +       dcss_scaler_program_7_coef_set(ch, DCSS_SCALER_COEF_HLUM, coef)=
;
> > +
> > +       /* vertical RGB */
> > +       dcss_scaler_filter_design(src_yres, dst_yres, false,
> > +                                 src_yres =3D=3D dst_yres, coef);
> > +       dcss_scaler_program_7_coef_set(ch, DCSS_SCALER_COEF_VLUM, coef)=
;
> > +}
> > +
> > +static void dcss_scaler_set_rgb10_order(struct dcss_scaler_ch *ch,
> > +                                       const struct drm_format_info *f=
ormat)
> > +{
> > +       u32 a2r10g10b10_format;
> > +
> > +       if (format->is_yuv)
> > +               return;
> > +
> > +       ch->sdata_ctrl &=3D ~A2R10G10B10_FORMAT_MASK;
> > +
> > +       if (format->depth !=3D 30)
> > +               return;
> > +
> > +       switch (format->format) {
> > +       case DRM_FORMAT_ARGB2101010:
> > +       case DRM_FORMAT_XRGB2101010:
> > +               a2r10g10b10_format =3D 0;
> > +               break;
> > +
> > +       case DRM_FORMAT_ABGR2101010:
> > +       case DRM_FORMAT_XBGR2101010:
> > +               a2r10g10b10_format =3D 5;
> > +               break;
> > +
> > +       case DRM_FORMAT_RGBA1010102:
> > +       case DRM_FORMAT_RGBX1010102:
> > +               a2r10g10b10_format =3D 6;
> > +               break;
> > +
> > +       case DRM_FORMAT_BGRA1010102:
> > +       case DRM_FORMAT_BGRX1010102:
> > +               a2r10g10b10_format =3D 11;
> > +               break;
> > +
> > +       default:
> > +               a2r10g10b10_format =3D 0;
> > +               break;
> > +       }
> > +
> > +       ch->sdata_ctrl |=3D a2r10g10b10_format << A2R10G10B10_FORMAT_PO=
S;
> > +}
> > +
> > +void dcss_scaler_setup(struct dcss_scaler *scl, int ch_num,
> > +                      const struct drm_format_info *format,
> > +                      int src_xres, int src_yres, int dst_xres, int ds=
t_yres,
> > +                      u32 vrefresh_hz)
> > +{
> > +       struct dcss_scaler_ch *ch =3D &scl->ch[ch_num];
> > +       unsigned int pixel_depth =3D 0;
> > +       bool rtr_8line_en =3D false;
> > +       bool use_5_taps =3D false;
> > +       enum buffer_format src_format =3D BUF_FMT_ARGB8888_YUV444;
> > +       enum buffer_format dst_format =3D BUF_FMT_ARGB8888_YUV444;
> > +       u32 pix_format =3D format->format;
> > +
> > +       if (format->is_yuv) {
> > +               dcss_scaler_yuv_enable(ch, true);
> > +
> > +               if (pix_format =3D=3D DRM_FORMAT_NV12 ||
> > +                   pix_format =3D=3D DRM_FORMAT_NV21 ||
> > +                   pix_format =3D=3D DRM_FORMAT_P010) {
> > +                       rtr_8line_en =3D true;
> > +                       src_format =3D BUF_FMT_YUV420;
> > +               } else if (pix_format =3D=3D DRM_FORMAT_UYVY ||
> > +                          pix_format =3D=3D DRM_FORMAT_VYUY ||
> > +                          pix_format =3D=3D DRM_FORMAT_YUYV ||
> > +                          pix_format =3D=3D DRM_FORMAT_YVYU) {
> > +                       src_format =3D BUF_FMT_YUV422;
> > +               }
> > +
> > +               use_5_taps =3D !rtr_8line_en;
> > +               if (pix_format =3D=3D DRM_FORMAT_P010)
> > +                       pixel_depth =3D 30;
> > +
> > +       } else {
> > +               dcss_scaler_yuv_enable(ch, false);
> > +
> > +               pixel_depth =3D format->depth;
> > +       }
> > +
> > +       dcss_scaler_fractions_set(ch, src_xres, src_yres, dst_xres,
> > +                                 dst_yres, src_format, dst_format,
> > +                                 PSC_LOC_HORZ_0_VERT_1_OVER_4);
> > +
> > +       if (format->is_yuv)
> > +               dcss_scaler_yuv_coef_set(ch, src_format, dst_format,
> > +                                        use_5_taps, src_xres, src_yres=
,
> > +                                        dst_xres, dst_yres);
> > +       else
> > +               dcss_scaler_rgb_coef_set(ch, src_xres, src_yres,
> > +                                        dst_xres, dst_yres);
> > +
> > +       dcss_scaler_rtr_8lines_enable(ch, rtr_8line_en);
> > +       dcss_scaler_bit_depth_set(ch, pixel_depth);
> > +       dcss_scaler_set_rgb10_order(ch, format);
> > +       dcss_scaler_format_set(ch, src_format, dst_format);
> > +       dcss_scaler_res_set(ch, src_xres, src_yres, dst_xres, dst_yres,
> > +                           pix_format, dst_format);
> > +}
> > +
> > +/* This function will be called from interrupt context. */
> > +void dcss_scaler_write_sclctrl(struct dcss_scaler *scl)
> > +{
> > +       int chnum;
> > +
> > +       for (chnum =3D 0; chnum < 3; chnum++) {
> > +               struct dcss_scaler_ch *ch =3D &scl->ch[chnum];
> > +
> > +               if (ch->scaler_ctrl_chgd) {
> > +                       dcss_ctxld_write_irqsafe(scl->ctxld, scl->ctx_i=
d,
> > +                                                ch->scaler_ctrl,
> > +                                                ch->base_ofs +
> > +                                                DCSS_SCALER_CTRL);
> > +                       ch->scaler_ctrl_chgd =3D false;
> > +               }
> > +       }
> > +}
> > diff --git a/drivers/gpu/drm/imx/dcss/dcss-ss.c b/drivers/gpu/drm/imx/d=
css/dcss-ss.c
> > new file mode 100644
> > index 00000000..65a05c2
> > --- /dev/null
> > +++ b/drivers/gpu/drm/imx/dcss/dcss-ss.c
> > @@ -0,0 +1,179 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright 2019 NXP.
> > + */
> > +
> > +#include <linux/device.h>
> > +
> > +#include "dcss-dev.h"
> > +
> > +#define DCSS_SS_SYS_CTRL                       0x00
> > +#define   RUN_EN                               BIT(0)
> > +#define DCSS_SS_DISPLAY                                0x10
> > +#define   LRC_X_POS                            0
> > +#define   LRC_X_MASK                           GENMASK(12, 0)
> > +#define   LRC_Y_POS                            16
> > +#define   LRC_Y_MASK                           GENMASK(28, 16)
> > +#define DCSS_SS_HSYNC                          0x20
> > +#define DCSS_SS_VSYNC                          0x30
> > +#define   SYNC_START_POS                       0
> > +#define   SYNC_START_MASK                      GENMASK(12, 0)
> > +#define   SYNC_END_POS                         16
> > +#define   SYNC_END_MASK                                GENMASK(28, 16)
> > +#define   SYNC_POL                             BIT(31)
> > +#define DCSS_SS_DE_ULC                         0x40
> > +#define   ULC_X_POS                            0
> > +#define   ULC_X_MASK                           GENMASK(12, 0)
> > +#define   ULC_Y_POS                            16
> > +#define   ULC_Y_MASK                           GENMASK(28, 16)
> > +#define   ULC_POL                              BIT(31)
> > +#define DCSS_SS_DE_LRC                         0x50
> > +#define DCSS_SS_MODE                           0x60
> > +#define   PIPE_MODE_POS                                0
> > +#define   PIPE_MODE_MASK                       GENMASK(1, 0)
> > +#define DCSS_SS_COEFF                          0x70
> > +#define   HORIZ_A_POS                          0
> > +#define   HORIZ_A_MASK                         GENMASK(3, 0)
> > +#define   HORIZ_B_POS                          4
> > +#define   HORIZ_B_MASK                         GENMASK(7, 4)
> > +#define   HORIZ_C_POS                          8
> > +#define   HORIZ_C_MASK                         GENMASK(11, 8)
> > +#define   HORIZ_H_NORM_POS                     12
> > +#define   HORIZ_H_NORM_MASK                    GENMASK(14, 12)
> > +#define   VERT_A_POS                           16
> > +#define   VERT_A_MASK                          GENMASK(19, 16)
> > +#define   VERT_B_POS                           20
> > +#define   VERT_B_MASK                          GENMASK(23, 20)
> > +#define   VERT_C_POS                           24
> > +#define   VERT_C_MASK                          GENMASK(27, 24)
> > +#define   VERT_H_NORM_POS                      28
> > +#define   VERT_H_NORM_MASK                     GENMASK(30, 28)
> > +#define DCSS_SS_CLIP_CB                                0x80
> > +#define DCSS_SS_CLIP_CR                                0x90
> > +#define   CLIP_MIN_POS                         0
> > +#define   CLIP_MIN_MASK                                GENMASK(9, 0)
> > +#define   CLIP_MAX_POS                         0
> > +#define   CLIP_MAX_MASK                                GENMASK(23, 16)
> > +#define DCSS_SS_INTER_MODE                     0xA0
> > +#define   INT_EN                               BIT(0)
> > +#define   VSYNC_SHIFT                          BIT(1)
> > +
> > +struct dcss_ss {
> > +       struct device *dev;
> > +       void __iomem *base_reg;
> > +       u32 base_ofs;
> > +
> > +       struct dcss_ctxld *ctxld;
> > +       u32 ctx_id;
> > +
> > +       bool in_use;
> > +};
> > +
> > +static void dcss_ss_write(struct dcss_ss *ss, u32 val, u32 ofs)
> > +{
> > +       if (!ss->in_use)
> > +               dcss_writel(val, ss->base_reg + ofs);
> > +
> > +       dcss_ctxld_write(ss->ctxld, ss->ctx_id, val,
> > +                        ss->base_ofs + ofs);
> > +}
> > +
> > +int dcss_ss_init(struct dcss_dev *dcss, unsigned long ss_base)
> > +{
> > +       struct dcss_ss *ss;
> > +
> > +       ss =3D devm_kzalloc(dcss->dev, sizeof(*ss), GFP_KERNEL);
> > +       if (!ss)
> > +               return -ENOMEM;
> > +
> > +       dcss->ss =3D ss;
> > +       ss->dev =3D dcss->dev;
> > +       ss->ctxld =3D dcss->ctxld;
> > +
> > +       ss->base_reg =3D devm_ioremap(dcss->dev, ss_base, SZ_4K);
> > +       if (!ss->base_reg) {
> > +               dev_err(dcss->dev, "ss: unable to remap ss base\n");
> > +               devm_kfree(ss->dev, ss);
> > +               return -ENOMEM;
> > +       }
> > +
> > +       ss->base_ofs =3D ss_base;
> > +       ss->ctx_id =3D CTX_SB_HP;
> > +
> > +       return 0;
> > +}
> > +
> > +void dcss_ss_exit(struct dcss_ss *ss)
> > +{
> > +       /* stop SS */
> > +       dcss_writel(0, ss->base_reg + DCSS_SS_SYS_CTRL);
> > +
> > +       if (ss->base_reg)
> > +               devm_iounmap(ss->dev, ss->base_reg);
> > +
> > +       devm_kfree(ss->dev, ss);
> > +}
> > +
> > +void dcss_ss_subsam_set(struct dcss_ss *ss)
> > +{
> > +       dcss_ss_write(ss, 0x41614161, DCSS_SS_COEFF);
> > +       dcss_ss_write(ss, 0, DCSS_SS_MODE);
> > +       dcss_ss_write(ss, 0x03ff0000, DCSS_SS_CLIP_CB);
> > +       dcss_ss_write(ss, 0x03ff0000, DCSS_SS_CLIP_CR);
> > +}
> > +
> > +void dcss_ss_sync_set(struct dcss_ss *ss, struct videomode *vm,
> > +                     bool phsync, bool pvsync)
> > +{
> > +       u16 lrc_x, lrc_y;
> > +       u16 hsync_start, hsync_end;
> > +       u16 vsync_start, vsync_end;
> > +       u16 de_ulc_x, de_ulc_y;
> > +       u16 de_lrc_x, de_lrc_y;
> > +
> > +       lrc_x =3D vm->hfront_porch + vm->hback_porch + vm->hsync_len +
> > +               vm->hactive - 1;
> > +       lrc_y =3D vm->vfront_porch + vm->vback_porch + vm->vsync_len +
> > +               vm->vactive - 1;
> > +
> > +       dcss_ss_write(ss, (lrc_y << LRC_Y_POS) | lrc_x, DCSS_SS_DISPLAY=
);
> > +
> > +       hsync_start =3D vm->hfront_porch + vm->hback_porch + vm->hsync_=
len +
> > +                     vm->hactive - 1;
> > +       hsync_end =3D vm->hsync_len - 1;
> > +
> > +       dcss_ss_write(ss, (phsync ? SYNC_POL : 0) |
> > +                     ((u32)hsync_end << SYNC_END_POS) | hsync_start,
> > +                     DCSS_SS_HSYNC);
> > +
> > +       vsync_start =3D vm->vfront_porch - 1;
> > +       vsync_end =3D vm->vfront_porch + vm->vsync_len - 1;
> > +
> > +       dcss_ss_write(ss, (pvsync ? SYNC_POL : 0) |
> > +                     ((u32)vsync_end << SYNC_END_POS) | vsync_start,
> > +                     DCSS_SS_VSYNC);
> > +
> > +       de_ulc_x =3D vm->hsync_len + vm->hback_porch - 1;
> > +       de_ulc_y =3D vm->vsync_len + vm->vfront_porch + vm->vback_porch=
;
> > +
> > +       dcss_ss_write(ss, SYNC_POL | ((u32)de_ulc_y << ULC_Y_POS) | de_=
ulc_x,
> > +                     DCSS_SS_DE_ULC);
> > +
> > +       de_lrc_x =3D vm->hsync_len + vm->hback_porch + vm->hactive - 1;
> > +       de_lrc_y =3D vm->vsync_len + vm->vfront_porch + vm->vback_porch=
 +
> > +                  vm->vactive - 1;
> > +
> > +       dcss_ss_write(ss, (de_lrc_y << LRC_Y_POS) | de_lrc_x, DCSS_SS_D=
E_LRC);
> > +}
> > +
> > +void dcss_ss_enable(struct dcss_ss *ss)
> > +{
> > +       dcss_ss_write(ss, RUN_EN, DCSS_SS_SYS_CTRL);
> > +       ss->in_use =3D true;
> > +}
> > +
> > +void dcss_ss_disable(struct dcss_ss *ss)
> > +{
> > +       dcss_ss_write(ss, 0, DCSS_SS_SYS_CTRL);
> > +       ss->in_use =3D false;
> > +}
>=20
> > --
> > 2.7.4
> >
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flis=
ts.freedesktop.org%2Fmailman%2Flistinfo%2Fdri-devel&amp;data=3D02%7C01%7Cla=
urentiu.palcu%40nxp.com%7C94b752dadd2e413c70d008d740a32979%7C686ea1d3bc2b4c=
6fa92cd99c5c301635%7C0%7C0%7C637048941849367464&amp;sdata=3DeLdnYtMSu7o86ge=
Kr2wwIlfReLX9EmnGDQXNSuBGebU%3D&amp;reserved=3D0=
