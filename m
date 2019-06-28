Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAFFFC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 02:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B55E52086D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 02:47:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Analogixsemi.onmicrosoft.com header.i=@Analogixsemi.onmicrosoft.com header.b="dnBKyUYq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727147AbfF1CrV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 22:47:21 -0400
Received: from mail-eopbgr820091.outbound.protection.outlook.com ([40.107.82.91]:41568
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727089AbfF1CrU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 22:47:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Analogixsemi.onmicrosoft.com; s=selector1-Analogixsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h0aQfs3hM5dq3yk3p+3nLXDuX67plqyfQS+VG7fiM2Q=;
 b=dnBKyUYqCG9ojAT9K5dX1kRTDu5u5d2ppWVCi8+Xo7JAmgitH6AidlXbaUsi1b/bEjZ+1R2DV2MZwSLOCVuGj4mBT2V7KS4kzlt8OyKQxrDmEfj57Vf7QFd/dYFf13B7BUDtudrnstBmMAbr4lEEuR3d6szlflWEvs010SyMkjo=
Received: from MN2PR04MB5886.namprd04.prod.outlook.com (20.179.22.213) by
 MN2PR04MB6064.namprd04.prod.outlook.com (20.178.246.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.17; Fri, 28 Jun 2019 02:47:16 +0000
Received: from MN2PR04MB5886.namprd04.prod.outlook.com
 ([fe80::397b:3922:4027:f635]) by MN2PR04MB5886.namprd04.prod.outlook.com
 ([fe80::397b:3922:4027:f635%3]) with mapi id 15.20.2032.016; Fri, 28 Jun 2019
 02:47:15 +0000
From:   Xin Ji <xji@analogixsemi.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sjoerd.simons@collabora.co.uk" <sjoerd.simons@collabora.co.uk>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Sheng Pan <span@analogixsemi.com>
Subject: Re: [PATCH v1] Adjust analogix chip driver location
Thread-Topic: [PATCH v1] Adjust analogix chip driver location
Thread-Index: AQHVLNugE9/A6NeXyUKRWvLnNCDN26avZSmAgAD4qwA=
Date:   Fri, 28 Jun 2019 02:47:15 +0000
Message-ID: <20190628024706.GA15852@xin-VirtualBox>
References: <20190627112939.GA4832@xin-VirtualBox>
 <20190627115705.GB5021@pendragon.ideasonboard.com>
In-Reply-To: <20190627115705.GB5021@pendragon.ideasonboard.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0PR04CA0001.apcprd04.prod.outlook.com
 (2603:1096:203:36::13) To MN2PR04MB5886.namprd04.prod.outlook.com
 (2603:10b6:208:a3::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=xji@analogixsemi.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [114.247.245.252]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ba850830-1590-4269-d1c7-08d6fb72ed9e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR04MB6064;
x-ms-traffictypediagnostic: MN2PR04MB6064:
x-microsoft-antispam-prvs: <MN2PR04MB60643654A34E0DB02EE57AD0C7FC0@MN2PR04MB6064.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:206;
x-forefront-prvs: 00826B6158
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(376002)(366004)(136003)(396003)(346002)(39850400004)(189003)(199004)(99286004)(54906003)(71190400001)(64756008)(33656002)(71200400001)(73956011)(66946007)(256004)(33716001)(6116002)(66446008)(3846002)(66476007)(66556008)(316002)(6436002)(446003)(6486002)(9686003)(6512007)(25786009)(11346002)(486006)(305945005)(7736002)(6916009)(229853002)(5660300002)(107886003)(102836004)(478600001)(6246003)(53936002)(66066001)(68736007)(81156014)(81166006)(386003)(6506007)(8676002)(26005)(4326008)(186003)(8936002)(86362001)(52116002)(476003)(14454004)(1076003)(76176011)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR04MB6064;H:MN2PR04MB5886.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: analogixsemi.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: NEKTT//hZ+3bcmuNUUwAJm05zc+IRf8L0V20DrFmQOJ6hpNjdSjTTa3SpGNHUDoRmyLQKKENTAlXrq1imQ1i+5yVOx92NxjIMM+cRxz6XsTWNruVdhyGRcaimQ+0yp8GrwTi9OHMGz0NPfXS8UAMuDEf8Dt4uZwPn0n4fgGq5XWWNv2/MdwCOt3L5mpYiVW1L8aKoBlurh7YHEilaC8FM0bW/CX8WZA3nFB2lxd4fqASvRQVknisoGDRc5WDWK6l9wP3DoqpE49ord3QLarC/U7ZRN2RGG7HX7y+pPSfc4npDEcRBL8WGQI0z3zORV6EfDjL9AGicQxmAz6oWnrHD91P0jC/on64cmk/HyhXyKeU65lGh7W6rxhDo1I+7rBpXcpIgNySvG0nPdLAXXz0dG7m6jNwh76CmNrT6TRMQp8=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E2924B82224C67428ED1F9DBC2F39F66@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analogixsemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba850830-1590-4269-d1c7-08d6fb72ed9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2019 02:47:15.6962
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b099b0b4-f26c-4cf5-9a0f-d5be9acab205
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xji@analogixsemi.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6064
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 27, 2019 at 07:57:05PM +0800, Laurent Pinchart wrote:
> Hello Xin Ji,
>=20
> Thank you for the patch.
>=20
> On Thu, Jun 27, 2019 at 11:29:47AM +0000, Xin Ji wrote:
> > Move analogix chip ANX78XX bridge driver into "analogix" directory.
> >=20
> > Signed-off-by: Xin Ji <xji@analogixsemi.com>
> > ---
> >  drivers/gpu/drm/bridge/Kconfig                           | 10 --------=
--
> >  drivers/gpu/drm/bridge/Makefile                          |  3 +--
> >  drivers/gpu/drm/bridge/analogix/Kconfig                  | 10 ++++++++=
++
> >  drivers/gpu/drm/bridge/analogix/Makefile                 |  2 ++
> >  drivers/gpu/drm/bridge/{ =3D> analogix}/analogix-anx78xx.c |  0
> >  drivers/gpu/drm/bridge/{ =3D> analogix}/analogix-anx78xx.h |  0
> >  6 files changed, 13 insertions(+), 12 deletions(-)
> >  rename drivers/gpu/drm/bridge/{ =3D> analogix}/analogix-anx78xx.c (100=
%)
> >  rename drivers/gpu/drm/bridge/{ =3D> analogix}/analogix-anx78xx.h (100=
%)
> >=20
> > diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kc=
onfig
> > index ee77746..862789b 100644
> > --- a/drivers/gpu/drm/bridge/Kconfig
> > +++ b/drivers/gpu/drm/bridge/Kconfig
> > @@ -16,16 +16,6 @@ config DRM_PANEL_BRIDGE
> >  menu "Display Interface Bridges"
> >  	depends on DRM && DRM_BRIDGE
> > =20
> > -config DRM_ANALOGIX_ANX78XX
> > -	tristate "Analogix ANX78XX bridge"
> > -	select DRM_KMS_HELPER
> > -	select REGMAP_I2C
> > -	---help---
> > -	  ANX78XX is an ultra-low Full-HD SlimPort transmitter
> > -	  designed for portable devices. The ANX78XX transforms
> > -	  the HDMI output of an application processor to MyDP
> > -	  or DisplayPort.
> > -
> >  config DRM_CDNS_DSI
> >  	tristate "Cadence DPI/DSI bridge"
> >  	select DRM_KMS_HELPER
> > diff --git a/drivers/gpu/drm/bridge/Makefile b/drivers/gpu/drm/bridge/M=
akefile
> > index 4934fcf..02cb4cd 100644
> > --- a/drivers/gpu/drm/bridge/Makefile
> > +++ b/drivers/gpu/drm/bridge/Makefile
> > @@ -1,5 +1,4 @@
> >  # SPDX-License-Identifier: GPL-2.0
> > -obj-$(CONFIG_DRM_ANALOGIX_ANX78XX) +=3D analogix-anx78xx.o
> >  obj-$(CONFIG_DRM_CDNS_DSI) +=3D cdns-dsi.o
> >  obj-$(CONFIG_DRM_DUMB_VGA_DAC) +=3D dumb-vga-dac.o
> >  obj-$(CONFIG_DRM_LVDS_ENCODER) +=3D lvds-encoder.o
> > @@ -12,8 +11,8 @@ obj-$(CONFIG_DRM_SII9234) +=3D sii9234.o
> >  obj-$(CONFIG_DRM_THINE_THC63LVD1024) +=3D thc63lvd1024.o
> >  obj-$(CONFIG_DRM_TOSHIBA_TC358764) +=3D tc358764.o
> >  obj-$(CONFIG_DRM_TOSHIBA_TC358767) +=3D tc358767.o
> > -obj-$(CONFIG_DRM_ANALOGIX_DP) +=3D analogix/
> >  obj-$(CONFIG_DRM_I2C_ADV7511) +=3D adv7511/
> >  obj-$(CONFIG_DRM_TI_SN65DSI86) +=3D ti-sn65dsi86.o
> >  obj-$(CONFIG_DRM_TI_TFP410) +=3D ti-tfp410.o
> >  obj-y +=3D synopsys/
> > +obj-y +=3D analogix/
>=20
> Could you place that line just above the synopsys/ directory, to have
> them alphabetically sorted (this could also be done while applying) ?
> Apart from that the patch looks good to me, so
OK, I'll submit new patch, thanks!
>=20
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>=20
> > diff --git a/drivers/gpu/drm/bridge/analogix/Kconfig b/drivers/gpu/drm/=
bridge/analogix/Kconfig
> > index e930ff9..dfe84f5 100644
> > --- a/drivers/gpu/drm/bridge/analogix/Kconfig
> > +++ b/drivers/gpu/drm/bridge/analogix/Kconfig
> > @@ -1,4 +1,14 @@
> >  # SPDX-License-Identifier: GPL-2.0-only
> > +config DRM_ANALOGIX_ANX78XX
> > +	tristate "Analogix ANX78XX bridge"
> > +	select DRM_KMS_HELPER
> > +	select REGMAP_I2C
> > +	---help---
> > +	  ANX78XX is an ultra-low Full-HD SlimPort transmitter
> > +	  designed for portable devices. The ANX78XX transforms
> > +	  the HDMI output of an application processor to MyDP
> > +	  or DisplayPort.
> > +
> >  config DRM_ANALOGIX_DP
> >  	tristate
> >  	depends on DRM
> > diff --git a/drivers/gpu/drm/bridge/analogix/Makefile b/drivers/gpu/drm=
/bridge/analogix/Makefile
> > index fdbf3fd..d4c54ac 100644
> > --- a/drivers/gpu/drm/bridge/analogix/Makefile
> > +++ b/drivers/gpu/drm/bridge/analogix/Makefile
> > @@ -1,3 +1,5 @@
> >  # SPDX-License-Identifier: GPL-2.0-only
> > +obj-$(CONFIG_DRM_ANALOGIX_ANX78XX) +=3D analogix-anx78xx.o
> > +
> >  analogix_dp-objs :=3D analogix_dp_core.o analogix_dp_reg.o
> >  obj-$(CONFIG_DRM_ANALOGIX_DP) +=3D analogix_dp.o
> > diff --git a/drivers/gpu/drm/bridge/analogix-anx78xx.c b/drivers/gpu/dr=
m/bridge/analogix/analogix-anx78xx.c
> > similarity index 100%
> > rename from drivers/gpu/drm/bridge/analogix-anx78xx.c
> > rename to drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c
> > diff --git a/drivers/gpu/drm/bridge/analogix-anx78xx.h b/drivers/gpu/dr=
m/bridge/analogix/analogix-anx78xx.h
> > similarity index 100%
> > rename from drivers/gpu/drm/bridge/analogix-anx78xx.h
> > rename to drivers/gpu/drm/bridge/analogix/analogix-anx78xx.h
>=20
> --=20
> Regards,
>=20
> Laurent Pinchart
