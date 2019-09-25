Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B1DC432C1
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 04:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8DAB20665
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 04:32:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Analogixsemi.onmicrosoft.com header.i=@Analogixsemi.onmicrosoft.com header.b="id5zm/MF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633948AbfIYEcK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 00:32:10 -0400
Received: from mail-eopbgr810131.outbound.protection.outlook.com ([40.107.81.131]:26942
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2633937AbfIYEcI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 00:32:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AVx2mwyyRq+6cMIlExcrThqd76RxMwcBUfCl4jHDVu4Xh8fLE0u53llCdOQkwkCXHH40dHY4LHJBxj5aVioB/DQwt18xHo8rbGoC5JJvKOlsudtMJQbbR988vfFAHpoGDfMgwM8uH8JOwfcGsUTIV7H1cz1c//zgpE0Su1YHeEIx9EBF9H9ryCu5P8SlK65NeZSuvkq/1E6Kaqd7gckNb2C/sfwXtd39K+zbuAJIP7C9MjF5x4FHX5D0ee9KmCdssuSbdbGYGj26JPCSE5rj1/qJN6G2iaR3x0YE8buXdD+bbbuiVUD+rfkLwkyTkh2grkbqxvDs1wYtTDr83a/94w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CHTPzzG7WzqlJwzrN3HLPQL8iM9flXqwyeBFy88xZls=;
 b=KrXo0B0F4LSUJ0BAqYCwAz8o5eSZvY5B9NJFMEp4/1leYMWh4nJS0jJUCuLkG3Z7lxu64ocgBtCNf+HLKGCiheYmsb08+IXZN0seUyy+sZSDAeU78BvvP5WWxiW/V4zPQgv/oKBo3QwlA/IUwvuwvFAJYHPQK3/1l5zEiUSULVj4hF+BKo7f5RE0VKzVtfyJCuBe5XzzvELmUlRUwXsMrZdp5ew+p0sREZ8KvW//rqwcpppglkHg0yDj6ow5rkgI4fN5mYqPTk0q2YhL0oVSLJ/IRAk5feF6A4Z3WpdKx6NqRSlmxgOt0PV+VjHYEjp+XrSKendOayN0e2F0l2QKIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analogixsemi.com; dmarc=pass action=none
 header.from=analogixsemi.com; dkim=pass header.d=analogixsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Analogixsemi.onmicrosoft.com; s=selector2-Analogixsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CHTPzzG7WzqlJwzrN3HLPQL8iM9flXqwyeBFy88xZls=;
 b=id5zm/MFqZlreQF/MixseV64vVgrE/Ou75LNOpKk2v1tISMIoHDuSvqzmq8zObknYMTDLr5iVA5ZMCdUHaahoasmNp/E6GwCnFAJGsm8q4He1hLuKhYokbBCZ24LXSYpoRzJ9F987YamzLTOtUqr409G9zoXv4AH//205UHWHSU=
Received: from MN2PR04MB5886.namprd04.prod.outlook.com (20.179.22.213) by
 MN2PR04MB5712.namprd04.prod.outlook.com (20.179.21.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Wed, 25 Sep 2019 04:16:56 +0000
Received: from MN2PR04MB5886.namprd04.prod.outlook.com
 ([fe80::8520:f80f:ae9:63cd]) by MN2PR04MB5886.namprd04.prod.outlook.com
 ([fe80::8520:f80f:ae9:63cd%6]) with mapi id 15.20.2284.023; Wed, 25 Sep 2019
 04:16:56 +0000
From:   Xin Ji <xji@analogixsemi.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Sheng Pan <span@analogixsemi.com>
Subject: Re: [PATCH v1 2/2] drm/bridge: anx7625: Add anx7625 MIPI to DP bridge
 driver
Thread-Topic: [PATCH v1 2/2] drm/bridge: anx7625: Add anx7625 MIPI to DP
 bridge driver
Thread-Index: AQHVb3m3O6Kkudc69k2BA5rT6xVhEKc5UIWAgAKAn4A=
Date:   Wed, 25 Sep 2019 04:16:56 +0000
Message-ID: <20190925041647.GA3388@xin-VirtualBox>
References: <cover.1568957788.git.xji@analogixsemi.com>
 <02319a7db948900efe0f945b684221ac076bac48.1568957789.git.xji@analogixsemi.com>
 <20190923140355.GH2959@kadam>
In-Reply-To: <20190923140355.GH2959@kadam>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0PR04CA0009.apcprd04.prod.outlook.com
 (2603:1096:203:36::21) To MN2PR04MB5886.namprd04.prod.outlook.com
 (2603:10b6:208:a3::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=xji@analogixsemi.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [43.252.149.35]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9fea7581-f7dc-48b6-89e4-08d7416f334d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MN2PR04MB5712;
x-ms-traffictypediagnostic: MN2PR04MB5712:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB57128ECACF9C67C86E97EF78C7870@MN2PR04MB5712.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:257;
x-forefront-prvs: 01713B2841
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(346002)(376002)(366004)(39840400004)(396003)(136003)(199004)(189003)(2906002)(256004)(186003)(9686003)(305945005)(86362001)(30864003)(446003)(71190400001)(26005)(6486002)(6512007)(229853002)(5660300002)(6246003)(52116002)(8936002)(107886003)(66946007)(66066001)(14454004)(6436002)(478600001)(25786009)(66556008)(66476007)(66446008)(64756008)(6116002)(54906003)(3846002)(486006)(81166006)(7416002)(6916009)(76176011)(71200400001)(4326008)(561924002)(33716001)(5024004)(476003)(6506007)(386003)(8676002)(11346002)(7736002)(1076003)(316002)(102836004)(81156014)(33656002)(55236004)(99286004)(14444005)(579004)(559001)(569006);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR04MB5712;H:MN2PR04MB5886.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: analogixsemi.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: OJlCuBs4vfktXI6R0jX0ZTK7qWeSVyaVS/IOPTcZXqJPMFYEiCJivQlawrsZc7iRRdU2EIinFnxWv7j3+ivaRd6oxiRLJIaBduToG7EXqhO+Qg+FpJV+xXCaTAfq8jhdhl04Pxq5ubkooVNO8RV3JRrvJtMuHLvdSVNg0w6YfBj2iOSS1pvz3xR5/mY8ulMKPIf690czZB66ri8OoSLQkxfiK9LOefedb0f2nMU/84TSRRbAXwNnuRChBU8IwZgSwZ0giWNZyKt3unSejgd2V8MIBZKtj+EKCvtBw4x8myTfuq4PHVuf2MghqaWvN+Mw5sVnXr6JlDwWu5uVhj0Lh+kMGktVyVUHFeBW4tiHkge2NBqWO9Muz7Vcps3tdEl7TzKzAb4XC0LAfqW09qmFnFLs6022hnhQkngrVnvuY8Y=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <63D33D3DCEAF51458312DF259E126E26@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analogixsemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fea7581-f7dc-48b6-89e4-08d7416f334d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2019 04:16:56.2224
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b099b0b4-f26c-4cf5-9a0f-d5be9acab205
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EnluRwAzXrsLBdWzHLT8P/ZO6uA0vBsMoxgNBKj8FGpnUrkxO557F+CKETOWiuzNVAVt9ka9kdRUDpKDhiWxGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5712
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 05:03:55PM +0300, Dan Carpenter wrote:
> I wish you would think more about the error codes that you're returning.
> Most functions do "ret |=3D frob()." which ORs the error codes together,
> and results in a nonsense negative error code.  But then some functions
> return 1 on error and zero on success which is sometimes a bug,
> sometimes confusing but always ugly.
Hi Dan Carpenter, I'll take more care about return error codes.
As I cannot to check all I2C operation result, so I use "ret |=3D frob()."
to combine them, if one of them has negative return value, I'll pop out err=
or
message and retuan. Anyway I'll use uniform return error code(negative
value as failed, 0 as success).

Thanks,
Xin
>=20
> On Fri, Sep 20, 2019 at 06:07:43AM +0000, Xin Ji wrote:
> > The ANX7625 is an ultra-low power 4K Mobile HD Transmitter designed
> > for portable device. It converts MIPI to DisplayPort 1.3 4K.
> >=20
> > Signed-off-by: Xin Ji <xji@analogixsemi.com>
> > ---
> >  drivers/gpu/drm/bridge/Makefile           |    2 +-
> >  drivers/gpu/drm/bridge/analogix/Kconfig   |    6 +
> >  drivers/gpu/drm/bridge/analogix/Makefile  |    1 +
> >  drivers/gpu/drm/bridge/analogix/anx7625.c | 2085 +++++++++++++++++++++=
++++++++
> >  drivers/gpu/drm/bridge/analogix/anx7625.h |  397 ++++++
> >  5 files changed, 2490 insertions(+), 1 deletion(-)
> >  create mode 100644 drivers/gpu/drm/bridge/analogix/anx7625.c
> >  create mode 100644 drivers/gpu/drm/bridge/analogix/anx7625.h
> >=20
> > diff --git a/drivers/gpu/drm/bridge/Makefile b/drivers/gpu/drm/bridge/M=
akefile
> > index 4934fcf..bcd388a 100644
> > --- a/drivers/gpu/drm/bridge/Makefile
> > +++ b/drivers/gpu/drm/bridge/Makefile
> > @@ -12,8 +12,8 @@ obj-$(CONFIG_DRM_SII9234) +=3D sii9234.o
> >  obj-$(CONFIG_DRM_THINE_THC63LVD1024) +=3D thc63lvd1024.o
> >  obj-$(CONFIG_DRM_TOSHIBA_TC358764) +=3D tc358764.o
> >  obj-$(CONFIG_DRM_TOSHIBA_TC358767) +=3D tc358767.o
> > -obj-$(CONFIG_DRM_ANALOGIX_DP) +=3D analogix/
> >  obj-$(CONFIG_DRM_I2C_ADV7511) +=3D adv7511/
> >  obj-$(CONFIG_DRM_TI_SN65DSI86) +=3D ti-sn65dsi86.o
> >  obj-$(CONFIG_DRM_TI_TFP410) +=3D ti-tfp410.o
> > +obj-y +=3D analogix/
> >  obj-y +=3D synopsys/
> > diff --git a/drivers/gpu/drm/bridge/analogix/Kconfig b/drivers/gpu/drm/=
bridge/analogix/Kconfig
> > index e930ff9..b2f127e 100644
> > --- a/drivers/gpu/drm/bridge/analogix/Kconfig
> > +++ b/drivers/gpu/drm/bridge/analogix/Kconfig
> > @@ -2,3 +2,9 @@
> >  config DRM_ANALOGIX_DP
> >  	tristate
> >  	depends on DRM
> > +
> > +config ANALOGIX_ANX7625
> > +	tristate "Analogix MIPI to DP interface support"
> > +	help
> > +		ANX7625 is an ultra-low power 4K mobile HD transmitter designed
> > +		for portable devices. It converts MIPI/DPI to DisplayPort1.3 4K.
> > diff --git a/drivers/gpu/drm/bridge/analogix/Makefile b/drivers/gpu/drm=
/bridge/analogix/Makefile
> > index fdbf3fd..8a52867 100644
> > --- a/drivers/gpu/drm/bridge/analogix/Makefile
> > +++ b/drivers/gpu/drm/bridge/analogix/Makefile
> > @@ -1,3 +1,4 @@
> >  # SPDX-License-Identifier: GPL-2.0-only
> > +obj-$(CONFIG_ANALOGIX_ANX7625) +=3D anx7625.o
> >  analogix_dp-objs :=3D analogix_dp_core.o analogix_dp_reg.o
> >  obj-$(CONFIG_DRM_ANALOGIX_DP) +=3D analogix_dp.o
> > diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/dr=
m/bridge/analogix/anx7625.c
> > new file mode 100644
> > index 0000000..eceadef
> > --- /dev/null
> > +++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
> > @@ -0,0 +1,2085 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright(c) 2016, Analogix Semiconductor. All rights reserved.
> > + *
> > + */
> > +#include <linux/extcon.h>
> > +#include <linux/gcd.h>
> > +#include <linux/gpio/consumer.h>
> > +#include <linux/i2c.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/iopoll.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/mutex.h>
> > +#include <linux/slab.h>
> > +#include <linux/types.h>
> > +#include <linux/workqueue.h>
> > +
> > +#include <linux/of_gpio.h>
> > +#include <linux/of_graph.h>
> > +#include <linux/of_platform.h>
> > +
> > +#include <drm/drm_atomic_helper.h>
> > +#include <drm/drm_bridge.h>
> > +#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_dp_helper.h>
> > +#include <drm/drm_edid.h>
> > +#include <drm/drm_mipi_dsi.h>
> > +#include <drm/drm_print.h>
> > +#include <drm/drm_probe_helper.h>
> > +
> > +#include <video/display_timing.h>
> > +
> > +#include "anx7625.h"
> > +
> > +/*
> > + * there is a sync issue while access I2C register between AP(CPU) and
> > + * internal firmware(OCM), to avoid the race condition, AP should acce=
ss
> > + * the reserved slave address before slave address occurs changes.
> > + */
> > +static int i2c_access_workaround(struct anx7625_data *ctx,
> > +				 struct i2c_client *client)
> > +{
> > +	u8 offset;
> > +	struct device *dev =3D &client->dev;
> > +	struct i2c_client *last_client =3D ctx->last_client;
> > +	int ret =3D 0;
> > +
> > +	if (client !=3D last_client) {
>=20
> Flip this around:
>=20
> 	if (client =3D=3D last_client)
> 		return 0;
>=20
> > +		ctx->last_client =3D client;
> > +
> > +		if (client =3D=3D ctx->i2c.tcpc_client)
> > +			offset =3D RSVD_00_ADDR;
> > +		else if (client =3D=3D ctx->i2c.tx_p0_client)
> > +			offset =3D RSVD_D1_ADDR;
> > +		else if (client =3D=3D ctx->i2c.tx_p1_client)
> > +			offset =3D RSVD_60_ADDR;
> > +		else if (client =3D=3D ctx->i2c.rx_p0_client)
> > +			offset =3D RSVD_39_ADDR;
> > +		else if (client =3D=3D ctx->i2c.rx_p1_client)
> > +			offset =3D RSVD_7F_ADDR;
> > +		else
> > +			offset =3D RSVD_00_ADDR;
> > +
> > +		ret =3D i2c_smbus_write_byte_data(client, offset, 0x00);
> > +		if (ret < 0)
> > +			DRM_DEV_ERROR(dev,
> > +				      "failed to access i2c id=3D%x\n:%x",
> > +				      client->addr, offset);
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +static int anx7625_reg_read(struct anx7625_data *ctx,
> > +			    struct i2c_client *client, u8 reg_addr)
> > +{
> > +	int ret;
> > +	struct device *dev =3D &client->dev;
> > +
> > +	i2c_access_workaround(ctx, client);
> > +
> > +	ret =3D i2c_smbus_read_byte_data(client, reg_addr);
> > +	if (ret < 0)
> > +		DRM_DEV_ERROR(dev, "read i2c failed id=3D%x:%x\n",
> > +			      client->addr, reg_addr);
> > +
> > +	return ret;
> > +}
> > +
> > +static int anx7625_reg_block_read(struct anx7625_data *ctx,
> > +				  struct i2c_client *client,
> > +				  u8 reg_addr, u8 len, u8 *buf)
> > +{
> > +	int ret;
> > +	struct device *dev =3D &client->dev;
> > +
> > +	i2c_access_workaround(ctx, client);
> > +
> > +	ret =3D i2c_smbus_read_i2c_block_data(client, reg_addr, len, buf);
> > +	if (ret < 0)
> > +		DRM_DEV_ERROR(dev, "read i2c block failed id=3D%x:%x\n",
> > +			      client->addr, reg_addr);
> > +
> > +	return ret;
> > +}
> > +
> > +static int anx7625_reg_write(struct anx7625_data *ctx,
> > +			     struct i2c_client *client,
> > +			     u8 reg_addr, u8 reg_val)
> > +{
> > +	int ret;
> > +	struct device *dev =3D &client->dev;
> > +
> > +	i2c_access_workaround(ctx, client);
> > +
> > +	ret =3D i2c_smbus_write_byte_data(client, reg_addr, reg_val);
> > +
> > +	if (ret < 0)
> > +		DRM_DEV_ERROR(dev, "failed to write i2c id=3D%x\n:%x",
> > +			      client->addr, reg_addr);
> > +
> > +	return ret;
> > +}
> > +
> > +static int anx7625_write_or(struct anx7625_data *ctx,
> > +			    struct i2c_client *client,
> > +			    u8 offset, u8 mask)
> > +{
> > +	int val =3D anx7625_reg_read(ctx, client, offset);
> > +
> > +	return (val < 0) ? val :
> > +		anx7625_reg_write(ctx, client, offset, (val | (mask)));
>=20
>=20
> Write these functions cleaner like this:
>=20
> 	int val;
>=20
> 	val =3D anx7625_reg_read(ctx, client, offset);
> 	if (val < 0)
> 		return val;
>=20
> 	return anx7625_reg_write(ctx, client, offset, (val | (mask)));
>=20
>=20
> > +}
> > +
> > +static int anx7625_write_and(struct anx7625_data *ctx,
> > +			     struct i2c_client *client,
> > +			     u8 offset, u8 mask)
> > +{
> > +	int val =3D anx7625_reg_read(ctx, client, offset);
> > +
> > +	return (val < 0) ? val :
> > +		anx7625_reg_write(ctx, client, offset, (val & (mask)));
> > +}
> > +
> > +static int anx7625_write_and_or(struct anx7625_data *ctx,
> > +				struct i2c_client *client,
> > +				u8 offset, u8 and_mask, u8 or_mask)
> > +{
> > +	int val =3D anx7625_reg_read(ctx, client, offset);
> > +
> > +	return (val < 0) ? val :
> > +		anx7625_reg_write(ctx, client, offset,
> > +				  (val & and_mask) | (or_mask));
> > +}
> > +
> > +static int anx7625_config_bit_matrix(struct anx7625_data *ctx)
> > +{
> > +	int i, ret;
> > +
> > +	ret =3D anx7625_reg_write(ctx, ctx->i2c.tx_p2_client,
> > +				AUDIO_CONTROL_REGISTER, 0x80);
> > +	for (i =3D 0; i < 13; i++)
>                         ^^
> Magic number.
>=20
>=20
> > +		ret |=3D anx7625_reg_write(ctx, ctx->i2c.tx_p2_client,
> > +					 VIDEO_BIT_MATRIX_12 + i,
> > +					 0x18 + i);
> > +
> > +	return ret;
> > +}
> > +
> > +static int anx7625_read_ctrl_status_p0(struct anx7625_data *ctx)
> > +{
> > +	return anx7625_reg_read(ctx, ctx->i2c.rx_p0_client, AP_AUX_CTRL_STATU=
S);
> > +}
> > +
> > +static int wait_aux_op_finish(struct anx7625_data *ctx)
> > +{
> > +	int val;
> > +	int ret;
> > +	struct device *dev =3D &ctx->client->dev;
> > +
> > +	ret =3D readx_poll_timeout(anx7625_read_ctrl_status_p0,
> > +				 ctx, val,
> > +				 (!(val & AP_AUX_CTRL_OP_EN) || (val < 0)),
> > +				 2000,
> > +				 2000 * 150);
> > +	if (ret) {
> > +		DRM_DEV_ERROR(dev, "aux operation failed!\n");
> > +		val =3D -EIO;
>=20
> Return directly:
>=20
> 	if (ret) {
> 		DRM_DEV_ERROR(dev, "aux operation failed!\n");
> 		return ret;
> 	}
>=20
>=20
> > +	} else {
> > +		val =3D anx7625_reg_read(ctx, ctx->i2c.rx_p0_client,
> > +				       AP_AUX_CTRL_STATUS);
> > +		if (val < 0 || (val & 0x0F)) {
> > +			DRM_DEV_ERROR(dev, "aux status %02x\n", val);
> > +			val =3D -EIO;
> > +		}
> > +	}
> > +
> > +	return val;
> > +}
> > +
> > +static int write_dpcd_addr(struct anx7625_data *ctx,
> > +			   u8 addrh, u8 addrm, u8 addrl)
> > +{
> > +	int ret;
> > +
> > +	ret =3D anx7625_reg_write(ctx, ctx->i2c.rx_p0_client,
> > +				AP_AUX_ADDR_7_0, (u8)addrl);
> > +	ret |=3D anx7625_reg_write(ctx, ctx->i2c.rx_p0_client,
> > +				 AP_AUX_ADDR_15_8, (u8)addrm);
> > +	ret |=3D anx7625_reg_write(ctx, ctx->i2c.rx_p0_client,
> > +				 AP_AUX_ADDR_19_16, (u8)addrh);
> > +
> > +	return ret;
> > +}
> > +
> > +static int sp_tx_aux_dpcdread_bytes(struct anx7625_data *ctx,
> > +				    u8 addrh, u8 addrm,
> > +				    u8 addrl, u8 count,
> > +				    u8 *buf)
> > +{
> > +	u8 c;
> > +	int ret;
> > +	struct device *dev =3D &ctx->client->dev;
> > +
> > +	if (WARN_ON(count > (size_t)MAX_DPCD_BUFFER_SIZE))
>=20
> This cast is not required.
>=20
> > +		return -E2BIG;
> > +
> > +	/* command and length */
> > +	c =3D ((count - 1) << 4) | 0x09;
> > +	ret =3D anx7625_reg_write(ctx, ctx->i2c.rx_p0_client, AP_AUX_COMMAND,=
 c);
> > +	/* address */
> > +	ret |=3D write_dpcd_addr(ctx, addrh, addrm, addrl);
> > +	/* aux en */
> > +	ret |=3D anx7625_write_or(ctx, ctx->i2c.rx_p0_client, AP_AUX_CTRL_STA=
TUS,
> > +				AP_AUX_CTRL_OP_EN);
> > +	if (ret < 0) {
> > +		DRM_DEV_ERROR(dev, "aux enable failed.\n");
> > +		return ret;
> > +	}
> > +
> > +	usleep_range(2000, 2100);
> > +
> > +	ret =3D wait_aux_op_finish(ctx);
> > +	if (ret < 0) {
> > +		DRM_DEV_ERROR(dev, "aux read failed\n");
> > +		return ret;
> > +	}
> > +
> > +	return anx7625_reg_block_read(ctx, ctx->i2c.rx_p0_client,
> > +			AP_AUX_BUFF_START, count, buf);
> > +}
> > +
> > +static int anx7625_video_mute_control(struct anx7625_data *ctx,
> > +				      u8 status)
> > +{
> > +	int ret;
> > +
> > +	if (status) { /* mute on */
> > +		/* set mute flag */
> > +		ret =3D anx7625_write_or(ctx, ctx->i2c.rx_p0_client,
> > +				       AP_AV_STATUS, AP_MIPI_MUTE);
> > +		/* clear mipi RX en */
> > +		ret |=3D anx7625_write_and(ctx, ctx->i2c.rx_p0_client,
> > +					 AP_AV_STATUS, (u8)~AP_MIPI_RX_EN);
> > +	} else { /* mute off */
> > +		/* clear mute flag */
> > +		ret =3D anx7625_write_and(ctx, ctx->i2c.rx_p0_client,
> > +					AP_AV_STATUS, (u8)~AP_MIPI_MUTE);
> > +		/* set MIPI RX EN */
> > +		ret |=3D anx7625_write_or(ctx, ctx->i2c.rx_p0_client,
> > +					AP_AV_STATUS, AP_MIPI_RX_EN);
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +static int anx7625_config_audio_input(struct anx7625_data *ctx)
> > +{
> > +	int ret;
> > +
> > +	/* channel num */
> > +	ret =3D anx7625_reg_write(ctx, ctx->i2c.tx_p2_client,
> > +				AUDIO_CHANNEL_STATUS_6, I2S_CH_2 << 5);
> > +	/* layout */
> > +	/* as I2S channel is 2, no need to set layout */
> > +
> > +	/* FS */
> > +	ret |=3D anx7625_write_and_or(ctx, ctx->i2c.tx_p2_client,
> > +				    AUDIO_CHANNEL_STATUS_4,
> > +				    0xf0, AUDIO_FS_48K);
> > +	/* word length */
> > +	ret |=3D anx7625_write_and_or(ctx, ctx->i2c.tx_p2_client,
> > +				    AUDIO_CHANNEL_STATUS_5,
> > +				    0xf0, AUDIO_W_LEN_24_24MAX);
> > +	/* I2S */
> > +	ret |=3D anx7625_write_or(ctx, ctx->i2c.tx_p2_client,
> > +				AUDIO_CHANNEL_STATUS_6, I2S_SLAVE_MODE);
> > +	ret |=3D anx7625_write_and(ctx, ctx->i2c.tx_p2_client,
> > +				 AUDIO_CONTROL_REGISTER, ~TDM_TIMING_MODE);
> > +	/* audio change flag */
> > +	ret |=3D anx7625_write_or(ctx, ctx->i2c.rx_p0_client,
> > +				AP_AV_STATUS, AP_AUDIO_CHG);
> > +
> > +	if (ret < 0)
> > +		DRM_ERROR("failed to config audio.\n");
> > +
> > +	return ret;
> > +}
> > +
> > +/* reduction of fraction a/b */
> > +static void anx7625_reduction_of_a_fraction(unsigned long *a, unsigned=
 long *b)
> > +{
> > +	unsigned long gcd_num;
> > +	unsigned long tmp_a, tmp_b;
> > +	u32 i =3D 1;
> > +
> > +	gcd_num =3D gcd(*a, *b);
> > +	*a /=3D gcd_num;
> > +	*b /=3D gcd_num;
> > +
> > +	tmp_a =3D *a;
> > +	tmp_b =3D *b;
> > +
> > +	while ((*a > MAX_UNSIGNED_24BIT) || (*b > MAX_UNSIGNED_24BIT)) {
> > +		i++;
> > +		*a =3D tmp_a / i;
> > +		*b =3D tmp_b / i;
> > +	}
> > +
> > +	/*
> > +	 * in the end, make a, b larger to have higher ODFC PLL
> > +	 * output frequency accuracy
> > +	 */
> > +	while ((*a < MAX_UNSIGNED_24BIT) && (*b < MAX_UNSIGNED_24BIT)) {
> > +		*a <<=3D 1;
> > +		*b <<=3D 1;
> > +	}
> > +
> > +	*a >>=3D 1;
> > +	*b >>=3D 1;
> > +}
> > +
> > +static int anx7625_calculate_m_n(u32 pixelclock,
> > +				 unsigned long *m,
> > +				 unsigned long *n,
> > +				 u8 *post_divider)
> > +{
> > +	if (pixelclock > PLL_OUT_FREQ_ABS_MAX / POST_DIVIDER_MIN) {
> > +		/* pixel clock frequency is too high */
> > +		DRM_ERROR("pixelclock too high, act(%d), maximum(%lu)\n",
> > +			  pixelclock,
> > +			  PLL_OUT_FREQ_ABS_MAX / POST_DIVIDER_MIN);
> > +		return 1;
>=20
> Returning one on error is ugly.  return -EINVAL;
>=20
> > +	}
> > +
> > +	if (pixelclock < PLL_OUT_FREQ_ABS_MIN / POST_DIVIDER_MAX) {
> > +		/* pixel clock frequency is too low */
> > +		DRM_ERROR("pixelclock too low, act(%d), maximum(%lu)\n",
> > +			  pixelclock,
> > +			  PLL_OUT_FREQ_ABS_MIN / POST_DIVIDER_MAX);
> > +		return 1;
> > +	}
> > +
> > +	*post_divider =3D 1;
> > +
> > +	for (*post_divider =3D 1;
> > +		pixelclock < (PLL_OUT_FREQ_MIN / (*post_divider));)
> > +		*post_divider +=3D 1;
> > +
> > +	if (*post_divider > POST_DIVIDER_MAX) {
> > +		for (*post_divider =3D 1;
> > +			(pixelclock <
> > +			 (PLL_OUT_FREQ_ABS_MIN / (*post_divider)));)
> > +			*post_divider +=3D 1;
> > +
> > +		if (*post_divider > POST_DIVIDER_MAX) {
> > +			DRM_ERROR("cannot find property post_divider(%d)\n",
> > +				  *post_divider);
> > +			return 1;
> > +		}
> > +	}
> > +
> > +	/* patch to improve the accuracy */
> > +	if (*post_divider =3D=3D 7) {
> > +		/* 27,000,000 is not divisible by 7 */
> > +		*post_divider =3D 8;
> > +	} else if (*post_divider =3D=3D 11) {
> > +		/* 27,000,000 is not divisible by 11 */
> > +		*post_divider =3D 12;
> > +	} else if ((*post_divider =3D=3D 13) || (*post_divider =3D=3D 14)) {
> > +		/*27,000,000 is not divisible by 13 or 14*/
> > +		*post_divider =3D 15;
> > +	}
> > +
> > +	if (pixelclock * (*post_divider) > PLL_OUT_FREQ_ABS_MAX) {
> > +		DRM_ERROR("act clock(%u) large than maximum(%lu)\n",
> > +			  pixelclock * (*post_divider),
> > +			  PLL_OUT_FREQ_ABS_MAX);
> > +		return 1;
> > +	}
> > +
> > +	*m =3D pixelclock;
> > +	*n =3D XTAL_FRQ / (*post_divider);
> > +
> > +	anx7625_reduction_of_a_fraction(m, n);
> > +
> > +	return 0;
> > +}
> > +
> > +static int anx7625_odfc_config(struct anx7625_data *ctx,
> > +			       u8 post_divider)
> > +{
> > +	int ret;
> > +
> > +	/* config input reference clock frequency 27MHz/19.2MHz */
> > +	ret =3D anx7625_write_and(ctx, ctx->i2c.rx_p1_client, MIPI_DIGITAL_PL=
L_16,
> > +				~(REF_CLK_27000KHZ << MIPI_FREF_D_IND));
> > +	ret |=3D anx7625_write_or(ctx, ctx->i2c.rx_p1_client, MIPI_DIGITAL_PL=
L_16,
> > +				(REF_CLK_27000KHZ << MIPI_FREF_D_IND));
> > +	/* post divider */
> > +	ret |=3D anx7625_write_and(ctx, ctx->i2c.rx_p1_client,
> > +				 MIPI_DIGITAL_PLL_8, 0x0f);
> > +	ret |=3D anx7625_write_or(ctx, ctx->i2c.rx_p1_client, MIPI_DIGITAL_PL=
L_8,
> > +				post_divider << 4);
> > +
> > +	/* add patch for MIS2-125 (5pcs ANX7625 fail ATE MBIST test) */
> > +	ret |=3D anx7625_write_and(ctx, ctx->i2c.rx_p1_client, MIPI_DIGITAL_P=
LL_7,
> > +				 ~MIPI_PLL_VCO_TUNE_REG_VAL);
> > +
> > +	/* reset ODFC PLL */
> > +	ret |=3D anx7625_write_and(ctx, ctx->i2c.rx_p1_client, MIPI_DIGITAL_P=
LL_7,
> > +				 ~MIPI_PLL_RESET_N);
> > +	ret |=3D anx7625_write_or(ctx, ctx->i2c.rx_p1_client, MIPI_DIGITAL_PL=
L_7,
> > +				MIPI_PLL_RESET_N);
> > +
> > +	if (ret < 0)
> > +		DRM_ERROR("IO error.\n");
> > +
> > +	return ret;
> > +}
> > +
> > +static int anx7625_dsi_video_timing_config(struct anx7625_data *ctx)
> > +{
> > +	struct device *dev =3D &ctx->client->dev;
> > +	unsigned long m, n;
> > +	u16 htotal;
> > +	int ret;
> > +	u8 post_divider =3D 0;
> > +
> > +	ret =3D anx7625_calculate_m_n(ctx->dt.pixelclock.min * 1000,
> > +				    &m, &n, &post_divider);
> > +
> > +	if (ret !=3D 0) {
> > +		DRM_ERROR("cannot get property m n value.\n");
> > +		return -EINVAL;
> > +	}
>=20
> 	if (ret)
> 		return ret;
>=20
> > +
> > +	DRM_DEV_DEBUG_DRIVER(dev, "compute M(%lu), N(%lu), divider(%d).\n",
> > +			     m, n, post_divider);
> > +
> > +	/* configure pixel clock */
> > +	ret =3D anx7625_reg_write(ctx, ctx->i2c.rx_p0_client, PIXEL_CLOCK_L,
> > +				(ctx->dt.pixelclock.min / 1000) & 0xFF);
> > +	ret |=3D anx7625_reg_write(ctx, ctx->i2c.rx_p0_client, PIXEL_CLOCK_H,
> > +				 (ctx->dt.pixelclock.min / 1000) >> 8);
> > +	/* lane count */
> > +	ret |=3D anx7625_write_and(ctx, ctx->i2c.rx_p1_client,
> > +			MIPI_LANE_CTRL_0, 0xfc);
> > +	if (ctx->pdata.dsi_lanes)
> > +		ret |=3D anx7625_write_or(ctx, ctx->i2c.rx_p1_client,
> > +					MIPI_LANE_CTRL_0,
> > +					(ctx->pdata.dsi_lanes - 1));
> > +	else
> > +		ret |=3D anx7625_write_or(ctx, ctx->i2c.rx_p1_client,
> > +					MIPI_LANE_CTRL_0, 3);
> > +
> > +	/* Htotal */
> > +	htotal =3D ctx->dt.hactive.min + ctx->dt.hfront_porch.min +
> > +		ctx->dt.hback_porch.min + ctx->dt.hsync_len.min;
> > +	ret |=3D anx7625_reg_write(ctx, ctx->i2c.rx_p2_client,
> > +			HORIZONTAL_TOTAL_PIXELS_L, htotal & 0xFF);
> > +	ret |=3D anx7625_reg_write(ctx, ctx->i2c.rx_p2_client,
> > +			HORIZONTAL_TOTAL_PIXELS_H, htotal >> 8);
> > +	/* Hactive */
> > +	ret |=3D anx7625_reg_write(ctx, ctx->i2c.rx_p2_client,
> > +			HORIZONTAL_ACTIVE_PIXELS_L, ctx->dt.hactive.min & 0xFF);
> > +	ret |=3D anx7625_reg_write(ctx, ctx->i2c.rx_p2_client,
> > +			HORIZONTAL_ACTIVE_PIXELS_H, ctx->dt.hactive.min >> 8);
> > +	/* HFP */
> > +	ret |=3D anx7625_reg_write(ctx, ctx->i2c.rx_p2_client,
> > +			HORIZONTAL_FRONT_PORCH_L, ctx->dt.hfront_porch.min);
> > +	ret |=3D anx7625_reg_write(ctx, ctx->i2c.rx_p2_client,
> > +			HORIZONTAL_FRONT_PORCH_H,
> > +			ctx->dt.hfront_porch.min >> 8);
> > +	/* HWS */
> > +	ret |=3D anx7625_reg_write(ctx, ctx->i2c.rx_p2_client,
> > +			HORIZONTAL_SYNC_WIDTH_L, ctx->dt.hsync_len.min);
> > +	ret |=3D anx7625_reg_write(ctx, ctx->i2c.rx_p2_client,
> > +			HORIZONTAL_SYNC_WIDTH_H, ctx->dt.hsync_len.min >> 8);
> > +	/* HBP */
> > +	ret |=3D anx7625_reg_write(ctx, ctx->i2c.rx_p2_client,
> > +			HORIZONTAL_BACK_PORCH_L, ctx->dt.hback_porch.min);
> > +	ret |=3D anx7625_reg_write(ctx, ctx->i2c.rx_p2_client,
> > +			HORIZONTAL_BACK_PORCH_H, ctx->dt.hback_porch.min >> 8);
> > +	/* Vactive */
> > +	ret |=3D anx7625_reg_write(ctx, ctx->i2c.rx_p2_client, ACTIVE_LINES_L=
,
> > +			ctx->dt.vactive.min);
> > +	ret |=3D anx7625_reg_write(ctx, ctx->i2c.rx_p2_client, ACTIVE_LINES_H=
,
> > +			ctx->dt.vactive.min >> 8);
> > +	/* VFP */
> > +	ret |=3D anx7625_reg_write(ctx, ctx->i2c.rx_p2_client,
> > +			VERTICAL_FRONT_PORCH, ctx->dt.vfront_porch.min);
> > +	/* VWS */
> > +	ret |=3D anx7625_reg_write(ctx, ctx->i2c.rx_p2_client,
> > +			VERTICAL_SYNC_WIDTH, ctx->dt.vsync_len.min);
> > +	/* VBP */
> > +	ret |=3D anx7625_reg_write(ctx, ctx->i2c.rx_p2_client,
> > +			VERTICAL_BACK_PORCH, ctx->dt.vback_porch.min);
> > +	/* M value */
> > +	ret |=3D anx7625_reg_write(ctx, ctx->i2c.rx_p1_client,
> > +			MIPI_PLL_M_NUM_23_16, (m >> 16) & 0xff);
> > +	ret |=3D anx7625_reg_write(ctx, ctx->i2c.rx_p1_client,
> > +			MIPI_PLL_M_NUM_15_8, (m >> 8) & 0xff);
> > +	ret |=3D anx7625_reg_write(ctx, ctx->i2c.rx_p1_client,
> > +			MIPI_PLL_M_NUM_7_0, (m & 0xff));
> > +	/* N value */
> > +	ret |=3D anx7625_reg_write(ctx, ctx->i2c.rx_p1_client,
> > +			MIPI_PLL_N_NUM_23_16, (n >> 16) & 0xff);
> > +	ret |=3D anx7625_reg_write(ctx, ctx->i2c.rx_p1_client,
> > +			MIPI_PLL_N_NUM_15_8, (n >> 8) & 0xff);
> > +	ret |=3D anx7625_reg_write(ctx, ctx->i2c.rx_p1_client, MIPI_PLL_N_NUM=
_7_0,
> > +			(n & 0xff));
> > +	/* diff */
> > +	ret |=3D anx7625_reg_write(ctx, ctx->i2c.rx_p1_client,
> > +			MIPI_DIGITAL_ADJ_1, 0x37);
> > +
> > +	ret |=3D anx7625_odfc_config(ctx, post_divider - 1);
> > +
> > +	if (ret < 0)
> > +		DRM_ERROR("mipi dsi setup IO error.\n");
> > +
> > +	return ret;
> > +}
> > +
> > +static int anx7625_swap_dsi_lane3(struct anx7625_data *ctx)
> > +{
> > +	int val;
> > +
> > +	/* swap MIPI-DSI data lane 3 P and N */
> > +	val =3D anx7625_reg_read(ctx, ctx->i2c.rx_p1_client, MIPI_SWAP);
> > +	if (val < 0) {
> > +		DRM_ERROR("IO error : access MIPI_SWAP.\n");
> > +		return -EIO;
> > +	}
> > +
> > +	val |=3D (1 << MIPI_SWAP_CH3);
> > +	return anx7625_reg_write(ctx, ctx->i2c.rx_p1_client, MIPI_SWAP, val);
> > +}
> > +
> > +static int anx7625_api_dsi_config(struct anx7625_data *ctx)
> > +
> > +{
> > +	int val, ret;
> > +
> > +	/* swap MIPI-DSI data lane 3 P and N */
> > +	ret =3D anx7625_swap_dsi_lane3(ctx);
> > +	if (ret < 0) {
> > +		DRM_ERROR("IO error : swap dsi lane 3 failed.\n");
> > +		return ret;
> > +	}
> > +
> > +	/* DSI clock settings */
> > +	val =3D (0 << MIPI_HS_PWD_CLK)		|
> > +		(0 << MIPI_HS_RT_CLK)		|
> > +		(0 << MIPI_PD_CLK)		|
> > +		(1 << MIPI_CLK_RT_MANUAL_PD_EN)	|
> > +		(1 << MIPI_CLK_HS_MANUAL_PD_EN)	|
> > +		(0 << MIPI_CLK_DET_DET_BYPASS)	|
> > +		(0 << MIPI_CLK_MISS_CTRL)	|
> > +		(0 << MIPI_PD_LPTX_CH_MANUAL_PD_EN);
> > +	ret =3D anx7625_reg_write(ctx, ctx->i2c.rx_p1_client,
> > +				MIPI_PHY_CONTROL_3, val);
> > +
> > +	/*
> > +	 * Decreased HS prepare timing delay from 160ns to 80ns work with
> > +	 *     a) Dragon board 810 series (Qualcomm AP)
> > +	 *     b) Moving Pixel DSI source (PG3A pattern generator +
> > +	 *	P332 D-PHY Probe) default D-PHY timing
> > +	 *	5ns/step
> > +	 */
> > +	ret |=3D anx7625_reg_write(ctx, ctx->i2c.rx_p1_client,
> > +				 MIPI_TIME_HS_PRPR, 0x10);
> > +
> > +	/* enable DSI mode*/
> > +	ret |=3D anx7625_write_or(ctx, ctx->i2c.rx_p1_client, MIPI_DIGITAL_PL=
L_18,
> > +				SELECT_DSI << MIPI_DPI_SELECT);
> > +
> > +	ret |=3D anx7625_dsi_video_timing_config(ctx);
> > +	if (ret < 0) {
> > +		DRM_ERROR("dsi video timing config failed\n");
> > +		return ret;
> > +	}
> > +
> > +	/* toggle m, n ready */
> > +	ret =3D anx7625_write_and(ctx, ctx->i2c.rx_p1_client, MIPI_DIGITAL_PL=
L_6,
> > +				~(MIPI_M_NUM_READY | MIPI_N_NUM_READY));
> > +	usleep_range(1000, 1100);
> > +	ret |=3D anx7625_write_or(ctx, ctx->i2c.rx_p1_client, MIPI_DIGITAL_PL=
L_6,
> > +				MIPI_M_NUM_READY | MIPI_N_NUM_READY);
> > +
> > +	/* configure integer stable register */
> > +	ret |=3D anx7625_reg_write(ctx, ctx->i2c.rx_p1_client,
> > +				 MIPI_VIDEO_STABLE_CNT, 0x02);
> > +	/* power on MIPI RX */
> > +	ret |=3D anx7625_reg_write(ctx, ctx->i2c.rx_p1_client,
> > +				 MIPI_LANE_CTRL_10, 0x00);
> > +	ret |=3D anx7625_reg_write(ctx, ctx->i2c.rx_p1_client,
> > +				 MIPI_LANE_CTRL_10, 0x80);
> > +
> > +	if (ret < 0)
> > +		DRM_ERROR("IO error : mipi dsi enable init failed.\n");
> > +
> > +	return ret;
> > +}
> > +
> > +static int anx7625_dsi_config(struct anx7625_data *ctx)
> > +{
> > +	struct device *dev =3D &ctx->client->dev;
> > +	int ret;
> > +
> > +	DRM_DEV_DEBUG_DRIVER(dev, "config dsi.\n");
> > +
> > +	/* DSC disable */
> > +	ret =3D anx7625_write_and(ctx, ctx->i2c.rx_p0_client,
> > +				R_DSC_CTRL_0, ~DSC_EN);
> > +
> > +	ret |=3D anx7625_api_dsi_config(ctx);
> > +
> > +	if (ret < 0) {
> > +		DRM_ERROR("IO error : api dsi config error.\n");
> > +	} else {
> > +		/* set MIPI RX EN */
> > +		ret =3D anx7625_write_or(ctx, ctx->i2c.rx_p0_client,
> > +				       AP_AV_STATUS, AP_MIPI_RX_EN);
> > +		/* clear mute flag */
> > +		ret |=3D anx7625_write_and(ctx, ctx->i2c.rx_p0_client,
> > +					 AP_AV_STATUS, (u8)~AP_MIPI_MUTE);
> > +		if (ret < 0)
> > +			DRM_ERROR("IO error : enable mipi rx failed.\n");
> > +		else
> > +			DRM_DEV_DEBUG_DRIVER(dev, "success to config DSI\n");
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +static int anx7625_api_dpi_config(struct anx7625_data *ctx)
> > +{
> > +	u16 freq =3D ctx->dt.pixelclock.min / 1000;
> > +	int ret;
> > +
> > +	/* configure pixel clock */
> > +	ret =3D anx7625_reg_write(ctx, ctx->i2c.rx_p0_client,
> > +				PIXEL_CLOCK_L, freq & 0xFF);
> > +	ret |=3D anx7625_reg_write(ctx, ctx->i2c.rx_p0_client,
> > +				 PIXEL_CLOCK_H, (freq >> 8));
> > +
> > +	/* set DPI mode */
> > +	/* set to DPI PLL module sel */
> > +	ret |=3D anx7625_reg_write(ctx, ctx->i2c.rx_p1_client,
> > +				 MIPI_DIGITAL_PLL_9, 0x20);
> > +	/* power down MIPI */
> > +	ret |=3D anx7625_reg_write(ctx, ctx->i2c.rx_p1_client,
> > +				 MIPI_LANE_CTRL_10, 0x08);
> > +	/* enable DPI mode */
> > +	ret |=3D anx7625_reg_write(ctx, ctx->i2c.rx_p1_client,
> > +				 MIPI_DIGITAL_PLL_18, 0x1C);
> > +	/* set first edge */
> > +	ret |=3D anx7625_reg_write(ctx, ctx->i2c.tx_p2_client,
> > +				 VIDEO_CONTROL_0, 0x05);
> > +	if (ret < 0)
> > +		DRM_ERROR("IO error : dpi phy set failed.\n");
> > +
> > +	return ret;
> > +}
> > +
> > +static int anx7625_dpi_config(struct anx7625_data *ctx)
> > +{
> > +	struct device *dev =3D &ctx->client->dev;
> > +	int ret;
> > +
> > +	DRM_DEV_DEBUG_DRIVER(dev, "config dpi\n");
> > +
> > +	/* DSC disable */
> > +	ret =3D anx7625_write_and(ctx, ctx->i2c.rx_p0_client,
> > +				R_DSC_CTRL_0, ~DSC_EN);
> > +	if (ret < 0) {
> > +		DRM_ERROR("IO error : disable dsc failed.\n");
> > +		return ret;
> > +	}
> > +
> > +	ret =3D anx7625_config_bit_matrix(ctx);
> > +	if (ret < 0) {
> > +		DRM_ERROR("config bit matrix failed.\n");
> > +		return ret;
> > +	}
> > +
> > +	ret =3D anx7625_api_dpi_config(ctx);
> > +	if (ret < 0) {
> > +		DRM_ERROR("mipi phy(dpi) setup failed.\n");
> > +		return ret;
> > +	}
> > +
> > +	/* set MIPI RX EN */
> > +	ret =3D anx7625_write_or(ctx, ctx->i2c.rx_p0_client,
> > +			       AP_AV_STATUS, AP_MIPI_RX_EN);
> > +	/* clear mute flag */
> > +	ret |=3D anx7625_write_and(ctx, ctx->i2c.rx_p0_client,
> > +				 AP_AV_STATUS, (u8)~AP_MIPI_MUTE);
> > +	if (ret < 0)
> > +		DRM_ERROR("IO error : enable mipi rx failed.\n");
> > +
> > +	return ret;
> > +}
> > +
> > +const u8 ANX_OUI[3] =3D { 0x00, 0x22, 0xB9 };
> > +static int is_anx_dongle(struct anx7625_data *ctx)
> > +{
> > +	u8 buf[3];
> > +
> > +	/* 0x0500~0x0502: BRANCH_IEEE_OUI */
> > +	sp_tx_aux_dpcdread_bytes(ctx, 0x00, 0x05, 0x00, sizeof(buf), buf);
> > +	if (memcmp(buf, ANX_OUI, sizeof(buf)) =3D=3D 0)
> > +		return 1;
> > +
> > +	return 0;
> > +}
> > +
> > +static void sp_tx_get_rx_bw(struct anx7625_data *ctx, u8 *bw)
> > +{
> > +	u8 data_buf[4];
> > +	/*
> > +	 * When ANX dongle connected, if CHIP_ID =3D 0x7750, bandwidth is 6.7=
5G,
> > +	 * because ANX7750 DPCD 0x052x was not available.
> > +	 */
> > +	if (is_anx_dongle(ctx)) {
> > +		sp_tx_aux_dpcdread_bytes(ctx, 0x00, 0x05, 0x03, 0x04, data_buf);
> > +		if (data_buf[0] =3D=3D 0x37 && data_buf[1] =3D=3D 0x37 &&
> > +		    data_buf[2] =3D=3D 0x35 && data_buf[3] =3D=3D 0x30) {
> > +			/* 0x19 : 6.75G */
> > +			*bw =3D 0x19;
> > +		} else {
> > +			sp_tx_aux_dpcdread_bytes(ctx, 0x00, 0x05, 0x21, 1, bw);
> > +			/*
> > +			 * some ANX dongle read out value 0,
> > +			 * retry standard register.
> > +			 */
> > +			if (((*bw) =3D=3D 0) || ((*bw) =3D=3D 0xff))
> > +				sp_tx_aux_dpcdread_bytes(ctx, 0x00, 0x00,
> > +							 DPCD_MAX_LINK_RATE,
> > +							 1, bw);
> > +		}
> > +	} else {
> > +		sp_tx_aux_dpcdread_bytes(ctx, 0x00, 0x00,
> > +					 DPCD_MAX_LINK_RATE, 1, bw);
> > +	}
> > +}
> > +
> > +static void anx7625_dp_start(struct anx7625_data *ctx)
> > +{
> > +	int ret;
> > +
> > +	if (!ctx->display_timing_valid) {
> > +		DRM_ERROR("mipi drm haven't set display timing yet.\n");
> > +		return;
> > +	}
> > +
> > +	ret =3D anx7625_config_audio_input(ctx);
> > +	if (ret < 0)
> > +		DRM_ERROR("config audio input failed.\n");
>=20
> return after error?
>=20
> > +
> > +	if (ctx->pdata.dsi_supported)
> > +		ret =3D anx7625_dsi_config(ctx);
> > +	else
> > +		ret =3D anx7625_dpi_config(ctx);
> > +
> > +	if (ret < 0)
> > +		DRM_ERROR("MIPI phy setup error.\n");
> > +}
> > +
> > +static void anx7625_dp_stop(struct anx7625_data *ctx)
> > +{
> > +	struct device *dev =3D &ctx->client->dev;
> > +	int ret;
> > +
> > +	DRM_DEV_DEBUG_DRIVER(dev, "stop dp output\n");
> > +
> > +	/*
> > +	 * video disable: 0x72:08 bit 7 =3D 0;
> > +	 * audio disable: 0x70:87 bit 0 =3D 0;
> > +	 */
> > +	ret =3D anx7625_write_and(ctx, ctx->i2c.tx_p0_client, 0x87, 0xfe);
> > +	ret |=3D anx7625_write_and(ctx, ctx->i2c.tx_p2_client, 0x08, 0x7f);
> > +
> > +	ret |=3D anx7625_video_mute_control(ctx, 1);
> > +	if (ret < 0)
> > +		DRM_ERROR("IO error : mute video failed\n");
> > +}
> > +
> > +static int sp_tx_rst_aux(struct anx7625_data *ctx)
> > +{
> > +	int ret;
> > +
> > +	ret =3D anx7625_write_or(ctx, ctx->i2c.tx_p2_client, RST_CTRL2,
> > +			       AUX_RST);
> > +	ret |=3D anx7625_write_and(ctx, ctx->i2c.tx_p2_client, RST_CTRL2,
> > +				 ~AUX_RST);
> > +	return ret;
> > +}
> > +
> > +static int sp_tx_aux_wr(struct anx7625_data *ctx, u8 offset)
> > +{
> > +	int ret;
> > +
> > +	ret =3D anx7625_reg_write(ctx, ctx->i2c.rx_p0_client,
> > +				AP_AUX_BUFF_START, offset);
> > +	ret |=3D anx7625_reg_write(ctx, ctx->i2c.rx_p0_client,
> > +				 AP_AUX_COMMAND, 0x04);
> > +	ret |=3D anx7625_write_or(ctx, ctx->i2c.rx_p0_client,
> > +				AP_AUX_CTRL_STATUS, AP_AUX_CTRL_OP_EN);
> > +	return (ret | wait_aux_op_finish(ctx));
> > +}
> > +
> > +static int sp_tx_aux_rd(struct anx7625_data *ctx, u8 len_cmd)
> > +{
> > +	int ret;
> > +
> > +	ret =3D anx7625_reg_write(ctx, ctx->i2c.rx_p0_client,
> > +				AP_AUX_COMMAND, len_cmd);
> > +	ret |=3D anx7625_write_or(ctx, ctx->i2c.rx_p0_client,
> > +				AP_AUX_CTRL_STATUS, AP_AUX_CTRL_OP_EN);
> > +	return (ret | wait_aux_op_finish(ctx));
> > +}
> > +
> > +static int sp_tx_get_edid_block(struct anx7625_data *ctx)
> > +{
> > +	int c =3D 0;
> > +	struct device *dev =3D &ctx->client->dev;
> > +
> > +	sp_tx_aux_wr(ctx, 0x7e);
> > +	sp_tx_aux_rd(ctx, 0x01);
> > +	c =3D anx7625_reg_read(ctx, ctx->i2c.rx_p0_client, AP_AUX_BUFF_START)=
;
> > +	if (c < 0) {
> > +		DRM_ERROR("IO error : access AUX BUFF.\n");
> > +		return -EIO;
> > +	}
> > +
> > +	DRM_DEV_DEBUG_DRIVER(dev, " EDID Block =3D %d\n", c + 1);
> > +
> > +	if (c > 3)
> > +		c =3D 1;
> > +
> > +	return c;
> > +}
> > +
> > +static int edid_read(struct anx7625_data *ctx,
> > +		     u8 offset, u8 *pblock_buf)
> > +{
> > +	u8 c, cnt =3D 0;
>                   ^^^
>=20
> "c" needs to be an integer.  "cnt" should be an int too, but it doesn't
> cause a bug either way.  Delete the bogus "cnt" initialization.
>=20
> > +	struct device *dev =3D &ctx->client->dev;
> > +
> > +	c =3D 0;
>         ^^^^^
> Delete.
>=20
> > +	for (cnt =3D 0; cnt < 3; cnt++) {
> > +		sp_tx_aux_wr(ctx, offset);
> > +		/* set I2C read com 0x01 mot =3D 0 and read 16 bytes */
> > +		c =3D sp_tx_aux_rd(ctx, 0xf1);
> > +
> > +		if (c =3D=3D 1) {
>=20
> 1 is a magic number here.  We need to check for negative returns as
> well.
>=20
>=20
> > +			sp_tx_rst_aux(ctx);
> > +			DRM_DEV_DEBUG_DRIVER(dev, "edid read failed, reset!\n");
> > +			cnt++;
> > +		} else {
> > +			anx7625_reg_block_read(ctx, ctx->i2c.rx_p0_client,
> > +					       AP_AUX_BUFF_START,
> > +					       MAX_DPCD_BUFFER_SIZE,
> > +					       pblock_buf);
> > +			return 0;
> > +		}
> > +	}
> > +
> > +	return 1;
> > +}
> > +
> > +static int segments_edid_read(struct anx7625_data *ctx,
> > +			      u8 segment, u8 *buf, u8 offset)
> > +{
> > +	u8 c, cnt =3D 0;
>=20
> c needs to be an int.
>=20
> > +	int ret;
> > +	struct device *dev =3D &ctx->client->dev;
> > +
> > +	/* write address only */
> > +	ret =3D anx7625_reg_write(ctx, ctx->i2c.rx_p0_client,
> > +				AP_AUX_ADDR_7_0, 0x30);
> > +	ret |=3D anx7625_reg_write(ctx, ctx->i2c.rx_p0_client,
> > +				 AP_AUX_COMMAND, 0x04);
> > +	ret |=3D anx7625_reg_write(ctx, ctx->i2c.rx_p0_client,
> > +				 AP_AUX_CTRL_STATUS,
> > +				 AP_AUX_CTRL_ADDRONLY | AP_AUX_CTRL_OP_EN);
> > +
> > +	ret |=3D wait_aux_op_finish(ctx);
> > +	/* write segment address */
> > +	ret |=3D sp_tx_aux_wr(ctx, segment);
> > +	/* data read */
> > +	ret |=3D anx7625_reg_write(ctx, ctx->i2c.rx_p0_client,
> > +				 AP_AUX_ADDR_7_0, 0x50);
> > +	if (ret < 0) {
> > +		DRM_ERROR("IO error : aux initial failed.\n");
> > +		return ret;
> > +	}
> > +
> > +	for (cnt =3D 0; cnt < 3; cnt++) {
> > +		sp_tx_aux_wr(ctx, offset);
> > +		/* set I2C read com 0x01 mot =3D 0 and read 16 bytes */
> > +		c =3D sp_tx_aux_rd(ctx, 0xf1);
> > +
> > +		if (c =3D=3D 1) {
>=20
>=20
> Where does 1 come from?  We need to check for negative returns.
>=20
> > +			ret =3D sp_tx_rst_aux(ctx);
> > +			DRM_DEV_ERROR(dev, "segment read failed, reset!\n");
> > +			cnt++;
> > +		} else {
> > +			ret =3D anx7625_reg_block_read(ctx, ctx->i2c.rx_p0_client,
> > +						     AP_AUX_BUFF_START,
> > +						     MAX_DPCD_BUFFER_SIZE, buf);
> > +			return ret;
> > +		}
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +static int sp_tx_edid_read(struct anx7625_data *ctx,
> > +			   u8 *pedid_blocks_buf)
> > +{
> > +	u8 offset, edid_pos;
> > +	int count, blocks_num;
> > +	u8 pblock_buf[MAX_DPCD_BUFFER_SIZE];
> > +	u8 i, j;
> > +	u8 g_edid_break =3D 0;
> > +	int ret;
> > +	struct device *dev =3D &ctx->client->dev;
> > +
> > +	/* address initial */
> > +	ret =3D anx7625_reg_write(ctx, ctx->i2c.rx_p0_client,
> > +				AP_AUX_ADDR_7_0, 0x50);
> > +	ret |=3D anx7625_reg_write(ctx, ctx->i2c.rx_p0_client,
> > +				 AP_AUX_ADDR_15_8, 0);
> > +	ret |=3D anx7625_write_and(ctx, ctx->i2c.rx_p0_client,
> > +				 AP_AUX_ADDR_19_16, 0xf0);
> > +	if (ret < 0) {
> > +		DRM_ERROR("access aux channel IO error.\n");
> > +		return -EIO;
> > +	}
> > +
> > +	blocks_num =3D sp_tx_get_edid_block(ctx);
> > +	if (blocks_num < 0)
> > +		return blocks_num;
> > +
> > +	count =3D 0;
> > +
> > +	do {
> > +		switch (count) {
> > +		case 0:
> > +		case 1:
> > +			for (i =3D 0; i < 8; i++) {
> > +				offset =3D (i + count * 8) * MAX_DPCD_BUFFER_SIZE;
> > +				g_edid_break =3D edid_read(ctx, offset,
> > +							 pblock_buf);
> > +
> > +				if (g_edid_break =3D=3D 1)
> > +					break;
> > +
> > +				memcpy(&pedid_blocks_buf[offset],
> > +				       pblock_buf,
> > +				       MAX_DPCD_BUFFER_SIZE);
> > +			}
> > +
> > +			break;
> > +		case 2:
> > +			offset =3D 0x00;
> > +
> > +			for (j =3D 0; j < 8; j++) {
> > +				edid_pos =3D (j + count * 8) *
> > +					MAX_DPCD_BUFFER_SIZE;
> > +
> > +				if (g_edid_break =3D=3D 1)
> > +					break;
> > +
> > +				segments_edid_read(ctx, count / 2,
> > +						   pblock_buf, offset);
> > +				memcpy(&pedid_blocks_buf[edid_pos],
> > +				       pblock_buf,
> > +				       MAX_DPCD_BUFFER_SIZE);
> > +				offset =3D offset + 0x10;
> > +			}
> > +
> > +			break;
> > +		case 3:
> > +			offset =3D 0x80;
> > +
> > +			for (j =3D 0; j < 8; j++) {
> > +				edid_pos =3D (j + count * 8) *
> > +					MAX_DPCD_BUFFER_SIZE;
> > +				if (g_edid_break =3D=3D 1)
> > +					break;
> > +
> > +				segments_edid_read(ctx, count / 2,
> > +						   pblock_buf, offset);
> > +				memcpy(&pedid_blocks_buf[edid_pos],
> > +				       pblock_buf,
> > +				       MAX_DPCD_BUFFER_SIZE);
> > +				offset =3D offset + 0x10;
> > +			}
> > +
> > +			break;
> > +		default:
> > +			break;
> > +		}
> > +
> > +		count++;
> > +
> > +	} while (blocks_num >=3D count);
> > +
> > +	/* check edid data */
> > +	if (drm_edid_is_valid((struct edid *)pedid_blocks_buf) =3D=3D false)
> > +		DRM_DEV_ERROR(dev, "WARNING! edid check failed!\n");
> > +
> > +	/* reset aux channel */
> > +	sp_tx_rst_aux(ctx);
> > +
> > +	return blocks_num;
> > +}
> > +
> > +static void anx7625_power_on(struct anx7625_data *ctx)
> > +{
> > +	struct device *dev =3D &ctx->client->dev;
> > +
> > +	if (ctx->pdata.low_power_mode) {
>=20
> Flip this around.
>=20
> 	if (!ctx->pdata.low_power_mode) {
> 		DRM_DEV_DEBUG_DRIVER(dev, "Anx7625 not low power mode!\n");
> 		return;
> 	}
>=20
> > +		/* power on pin enable */
> > +		gpio_set_value(ctx->pdata.gpio_p_on, 1);
> > +		usleep_range(10000, 11000);
> > +		/* power reset pin enable */
> > +		gpio_set_value(ctx->pdata.gpio_reset, 1);
> > +		usleep_range(10000, 11000);
> > +
> > +		DRM_DEV_DEBUG_DRIVER(dev, "Anx7625 power on !\n");
> > +	} else {
> > +		DRM_DEV_DEBUG_DRIVER(dev, "Anx7625 not low power mode!\n");
> > +	}
> > +}
> > +
> > +static void anx7625_power_standby(struct anx7625_data *ctx)
> > +{
> > +	struct device *dev =3D &ctx->client->dev;
> > +
> > +	if (ctx->pdata.low_power_mode) {
>=20
> Flip.
>=20
> > +		gpio_set_value(ctx->pdata.gpio_reset, 0);
> > +		usleep_range(1000, 1100);
> > +		gpio_set_value(ctx->pdata.gpio_p_on, 0);
> > +		usleep_range(1000, 1100);
> > +		DRM_DEV_DEBUG_DRIVER(dev, "anx7625 power down\n");
> > +	} else {
> > +		DRM_DEV_DEBUG_DRIVER(dev, "anx7625 not low power mode!\n");
> > +	}
> > +}
> > +
> > +/* basic configurations of ANX7625 */
> > +static void anx7625_config(struct anx7625_data *ctx)
> > +{
> > +	anx7625_reg_write(ctx, ctx->i2c.rx_p0_client,
> > +			  XTAL_FRQ_SEL, XTAL_FRQ_27M);
> > +}
> > +
> > +static void anx7625_disable_pd_protocol(struct anx7625_data *ctx)
> > +{
> > +	struct device *dev =3D &ctx->client->dev;
> > +	int ret;
> > +
> > +	/* reset main ocm */
> > +	ret =3D anx7625_reg_write(ctx, ctx->i2c.rx_p0_client, 0x88, 0x40);
> > +	/* Disable PD */
> > +	ret |=3D anx7625_reg_write(ctx, ctx->i2c.rx_p0_client,
> > +				 AP_AV_STATUS, AP_DISABLE_PD);
> > +	/* release main ocm */
> > +	ret |=3D anx7625_reg_write(ctx, ctx->i2c.rx_p0_client, 0x88, 0x00);
> > +
> > +	if (ret < 0)
> > +		DRM_DEV_DEBUG_DRIVER(dev, "disable PD feature failed.\n");
> > +	else
> > +		DRM_DEV_DEBUG_DRIVER(dev, "disable PD feature succeeded.\n");
> > +}
> > +
> > +static void anx7625_power_on_init(struct anx7625_data *ctx)
> > +{
> > +	int retry_count, i;
> > +	int ret =3D 0;
>                ^^^^
> Delete initialization.
>=20
> > +	struct device *dev =3D &ctx->client->dev;
> > +
> > +	for (retry_count =3D 0; retry_count < 3; retry_count++) {
> > +		anx7625_power_on(ctx);
> > +		anx7625_config(ctx);
> > +
> > +		for (i =3D 0; i < OCM_LOADING_TIME; i++) {
> > +			/* check interface workable */
> > +			ret =3D anx7625_reg_read(ctx, ctx->i2c.rx_p0_client,
> > +					       FLASH_LOAD_STA);
> > +			if (ret < 0) {
> > +				DRM_ERROR("IO error : access flash load.\n");
> > +				return;
> > +			}
> > +			if ((ret & FLASH_LOAD_STA_CHK) =3D=3D FLASH_LOAD_STA_CHK) {
> > +				anx7625_disable_pd_protocol(ctx);
> > +				DRM_DEV_DEBUG_DRIVER(dev,
> > +						     "Firmware ver %02x%02x,",
> > +					anx7625_reg_read(ctx,
> > +							 ctx->i2c.rx_p0_client,
> > +							 OCM_FW_VERSION),
> > +					anx7625_reg_read(ctx,
> > +							 ctx->i2c.rx_p0_client,
> > +							 OCM_FW_REVERSION));
> > +				DRM_DEV_DEBUG_DRIVER(dev, "Driver version %s\n",
> > +						     ANX7625_DRV_VERSION);
> > +
> > +				return;
> > +			}
> > +			usleep_range(1000, 1100);
> > +		}
> > +		anx7625_power_standby(ctx);
> > +	}
> > +}
> > +
> > +static int anx7625_extcon_notifier(struct notifier_block *nb,
> > +				   unsigned long event, void *ptr)
> > +{
> > +	struct anx7625_data *ctx =3D
> > +		container_of(nb, struct anx7625_data, event_nb);
> > +
> > +	schedule_work(&ctx->extcon_wq);
> > +	return NOTIFY_DONE;
> > +}
> > +
> > +static void anx7625_chip_control(struct anx7625_data *ctx)
> > +{
> > +	int state =3D extcon_get_state(ctx->extcon, EXTCON_DISP_DP);
> > +
> > +	if (ctx->pdata.low_power_mode) {
> > +		if (state > 0) {
> > +			if (atomic_read(&ctx->power_status) =3D=3D 0) {
> > +				anx7625_power_on_init(ctx);
> > +				atomic_set(&ctx->power_status, 1);
> > +			}
> > +		} else {
> > +			if (atomic_read(&ctx->power_status) =3D=3D 1) {
> > +				anx7625_power_standby(ctx);
> > +				atomic_set(&ctx->power_status, 0);
> > +			}
> > +		}
> > +	}
> > +}
> > +
> > +static void anx7625_extcon_work(struct work_struct *work)
> > +{
> > +	struct anx7625_data *ctx =3D
> > +		container_of(work, struct anx7625_data, extcon_wq);
> > +
> > +	mutex_lock(&ctx->lock);
> > +	anx7625_chip_control(ctx);
> > +	mutex_unlock(&ctx->lock);
> > +}
> > +
> > +static int anx7625_extcon_notifier_init(struct anx7625_data *ctx)
> > +{
> > +	int ret;
> > +	struct device *dev =3D &ctx->client->dev;
> > +
> > +	ctx->event_nb.notifier_call =3D anx7625_extcon_notifier;
> > +	INIT_WORK(&ctx->extcon_wq, anx7625_extcon_work);
> > +	ret =3D devm_extcon_register_notifier(&ctx->client->dev, ctx->extcon,
> > +					    EXTCON_DISP_DP, &ctx->event_nb);
> > +	if (ret) {
> > +		DRM_DEV_ERROR(dev, "failed to register notifier for DP");
> > +		return ret;
> > +	}
> > +	return 0;
> > +}
> > +
> > +static void anx7625_free_gpio(struct anx7625_data *platform)
> > +{
> > +	if (platform->pdata.gpio_intr_hpd)
> > +		gpio_free(platform->pdata.gpio_intr_hpd);
> > +
> > +	if (platform->pdata.low_power_mode) {
> > +		gpio_free(platform->pdata.gpio_reset);
> > +		gpio_free(platform->pdata.gpio_p_on);
> > +	}
> > +}
> > +
> > +static int anx7625_init_gpio(struct anx7625_data *platform)
> > +{
> > +	int ret =3D 0;
> > +	struct device *dev =3D &platform->client->dev;
> > +
> > +	DRM_DEV_DEBUG_DRIVER(dev, "anx7625 init gpio\n");
> > +
> > +	if (platform->pdata.low_power_mode) {
> > +		/* gpio for chip power down */
> > +		ret =3D gpio_request(platform->pdata.gpio_p_on,
> > +				   "anx7625_p_on_ctl");
> > +		if (ret) {
> > +			DRM_DEV_ERROR(dev, "failed to request gpio %d\n",
> > +				      platform->pdata.gpio_p_on);
> > +			goto err0;
>=20
> Choose error labels that say what the error handling does.  Imagine if
> we didn't have names, we just and "int var1, var2, var3;  func1(var2);".
> It's the same thing for error labels, the name should be useful.
>=20
> In this case the error handling is wrong because the gpio_request()
> failed so there is no cleanup required.  We should always just clean
> up the most recent allocation.  In this case since we haven't allocated
> anything we can just return;
>=20
> 		if (ret) {
> 			DRM_DEV_ERROR(dev, "failed to request gpio %d\n",
> 				      platform->pdata.gpio_p_on);
> 			return ret;
> 		}
>=20
>=20
> > +		}
> > +		/* gpio for chip reset */
> > +		ret =3D gpio_request(platform->pdata.gpio_reset,
> > +				   "anx7625_reset_n");
> > +		if (ret) {
> > +			DRM_DEV_ERROR(dev, "failed to request gpio %d\n",
> > +				      platform->pdata.gpio_reset);
> > +			goto err1;
>=20
> The most recent allocation is so gpio_p_on "goto free_gpio_p_on;".
>=20
> > +		}
> > +	}
> > +
> > +	if (platform->pdata.gpio_intr_hpd) {
> > +		/* gpio for chip interface communaction */
> > +		ret =3D gpio_request(platform->pdata.gpio_intr_hpd,
> > +				   "anx7625_hpd");
> > +		if (ret) {
> > +			DRM_DEV_ERROR(dev, "failed to request gpio %d\n",
> > +				      platform->pdata.gpio_intr_hpd);
> > +			goto err2;
>=20
> goto free_gpio_reset;
>=20
> > +		}
> > +	}
> > +
> > +	goto out;
>=20
> Just "return 0;"  "return 0;" is immediately readable.  The little goto
> hops around are like chasing a rabbit.  Fun for a little while but
> tiring in the end.
>=20
> free_gpio_reset:
> 	if (platform->pdata.low_power_mode)
> 		gpio_free(platform->pdata.gpio_reset);
> free_gpio_p_on:
> 	if (platform->pdata.low_power_mode)
> 		gpio_free(platform->pdata.gpio_p_on);
>=20
> 	return ret;
>=20
>=20
> > +
> > +err2:
> > +	if (platform->pdata.gpio_intr_hpd)
> > +		gpio_free(platform->pdata.gpio_intr_hpd);
> > +err1:
> > +	if (platform->pdata.low_power_mode)
> > +		gpio_free(platform->pdata.gpio_reset);
> > +err0:
> > +	if (platform->pdata.low_power_mode)
> > +		gpio_free(platform->pdata.gpio_p_on);
> > +
> > +	return 1;
>=20
> returning 1 here is a bug because it get propogated outside the driver.
>=20
> > +out:
> > +
> > +	return 0;
> > +}
> > +
> > +static void anx7625_stop_dp_work(struct anx7625_data *ctx)
> > +{
> > +	ctx->hpd_status =3D 0;
> > +	ctx->hpd_high_cnt =3D 0;
> > +	ctx->display_timing_valid =3D 0;
> > +
> > +	kfree(ctx->slimport_edid_p);
> > +	ctx->slimport_edid_p =3D NULL;
> > +
> > +	if (ctx->pdata.low_power_mode =3D=3D 0)
> > +		anx7625_disable_pd_protocol(ctx);
> > +}
> > +
> > +static void anx7625_start_dp_work(struct anx7625_data *ctx)
> > +{
> > +	int ret;
> > +	u8 buf[MAX_DPCD_BUFFER_SIZE];
> > +	u8 hdcp_cap;
> > +	struct device *dev =3D &ctx->client->dev;
> > +
> > +	u8 sp_tx_bw; /* linktraining banwidth */
> > +	u8 sp_tx_lane_count; /* link training lane count */
> > +
> > +	if (ctx->hpd_high_cnt >=3D 2) {
> > +		DRM_DEV_DEBUG_DRIVER(dev, "anx7625 filter useless HPD\n");
> > +		return;
> > +	}
> > +
> > +	ctx->hpd_high_cnt++;
> > +
> > +	sp_tx_get_rx_bw(ctx, &sp_tx_bw);
> > +
> > +	sp_tx_aux_dpcdread_bytes(ctx, 0x00, 0x00, DPCD_MAX_LANE_COUNT,
> > +				 1, &sp_tx_lane_count);
> > +
> > +	sp_tx_lane_count =3D sp_tx_lane_count & 0x1f;
> > +	sp_tx_aux_dpcdread_bytes(ctx, 0x06, 0x80, 0x28, 1, buf);/* read Bcap =
*/
> > +
> > +	hdcp_cap =3D buf[0] & 0x01;
> > +
> > +	/* not support HDCP */
> > +	ret =3D anx7625_write_and(ctx, ctx->i2c.rx_p1_client, 0xee, 0x9f);
> > +
> > +	if (hdcp_cap =3D=3D 0x01)
> > +		DRM_DEV_DEBUG_DRIVER(dev, "HDCP1.4\n");
> > +
> > +	/* try auth flag */
> > +	ret |=3D anx7625_write_or(ctx, ctx->i2c.rx_p1_client, 0xec, 0x10);
> > +	/* interrupt for DRM */
> > +	ret |=3D anx7625_write_or(ctx, ctx->i2c.rx_p1_client, 0xff, 0x01);
> > +	if (ret < 0)
> > +		return;
> > +	DRM_DEV_DEBUG_DRIVER(dev, "MAX BW=3D%02x, MAX Lane cnt=3D%02x, HDCP=
=3D%02x\n",
> > +			     (u32)sp_tx_bw,
> > +			     (u32)sp_tx_lane_count,
> > +			     (u32)hdcp_cap);
> > +
> > +	ret =3D anx7625_reg_read(ctx, ctx->i2c.rx_p1_client, 0x86);
> > +	if (ret < 0)
> > +		return;
> > +
> > +	DRM_DEV_DEBUG_DRIVER(dev, "Secure OCM version=3D%02x\n", ret);
> > +}
> > +
> > +static void dp_hpd_change_handler(struct anx7625_data *ctx, bool on)
> > +{
> > +	struct device *dev =3D &ctx->client->dev;
> > +
> > +	/* hpd changed */
> > +	DRM_DEV_DEBUG_DRIVER(dev, "dp_hpd_change_default_func: %d\n",
> > +			     (u32)on);
> > +
> > +	if (on =3D=3D 0) {
> > +		DRM_DEV_DEBUG_DRIVER(dev, " HPD low\n");
> > +		anx7625_stop_dp_work(ctx);
> > +	} else {
> > +		DRM_DEV_DEBUG_DRIVER(dev, " HPD high\n");
> > +		anx7625_start_dp_work(ctx);
> > +	}
> > +
> > +	ctx->hpd_status =3D on;
> > +}
> > +
> > +static int anx7625_hpd_change_detect(struct anx7625_data *ctx)
> > +{
> > +	int intr_vector, status;
> > +	struct device *dev =3D &ctx->client->dev;
> > +
> > +	DRM_DEV_DEBUG_DRIVER(dev, "power_status=3D%d\n",
> > +			     (u32)atomic_read(&ctx->power_status));
> > +
> > +	status =3D anx7625_reg_write(ctx, ctx->i2c.tcpc_client,
> > +				   INTR_ALERT_1, 0xFF);
> > +	if (status < 0) {
> > +		DRM_ERROR("IO error : clear alert register.\n");
> > +		return status;
> > +	}
> > +
> > +	intr_vector =3D anx7625_reg_read(ctx, ctx->i2c.rx_p0_client,
> > +				       INTERFACE_CHANGE_INT);
> > +	if (intr_vector < 0) {
> > +		DRM_ERROR("IO error : access interrupt change register.\n");
> > +		return intr_vector;
> > +	}
> > +	DRM_DEV_DEBUG_DRIVER(dev, "0x7e:0x44=3D%x\n", intr_vector);
> > +	status =3D anx7625_reg_write(ctx, ctx->i2c.rx_p0_client,
> > +				   INTERFACE_CHANGE_INT,
> > +				   intr_vector & (~intr_vector));
> > +	if (status < 0) {
> > +		DRM_ERROR("IO error : clear interrupt change register.\n");
> > +		return status;
> > +	}
> > +
> > +	if (intr_vector & HPD_STATUS_CHANGE) {
> > +		status =3D anx7625_reg_read(ctx, ctx->i2c.rx_p0_client,
> > +					  SYSTEM_STSTUS);
> > +		if (status < 0) {
> > +			DRM_ERROR("IO error : clear interrupt status.\n");
> > +			return status;
> > +		}
> > +
> > +		DRM_DEV_DEBUG_DRIVER(dev, "0x7e:0x45=3D%x\n", status);
> > +		dp_hpd_change_handler(ctx, status & HPD_STATUS);
> > +		return 1;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static void anx7625_work_func(struct work_struct *work)
> > +{
> > +	int event;
> > +	struct anx7625_data *ctx =3D container_of(work,
> > +						struct anx7625_data, work);
> > +
> > +	mutex_lock(&ctx->lock);
> > +	event =3D anx7625_hpd_change_detect(ctx);
> > +	mutex_unlock(&ctx->lock);
> > +
> > +	if (event < 0)
> > +		return;
> > +
> > +	if (event && ctx->bridge_attached)
> > +		drm_helper_hpd_irq_event(ctx->connector.dev);
> > +}
> > +
> > +static irqreturn_t anx7625_intr_hpd_isr(int irq, void *data)
> > +{
> > +	struct anx7625_data *ctx =3D (struct anx7625_data *)data;
> > +
> > +	if (atomic_read(&ctx->power_status) !=3D 1)
> > +		return IRQ_NONE;
> > +
> > +	queue_work(ctx->workqueue, &ctx->work);
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +#ifdef CONFIG_OF
> > +static int anx7625_parse_dt(struct device *dev,
> > +			    struct anx7625_platform_data *pdata)
> > +{
> > +	int ret;
> > +	struct device_node *np =3D dev->of_node;
> > +
> > +	ret =3D of_property_read_u32(dev->of_node, "low-power-mode",
> > +				   &pdata->low_power_mode);
> > +	if (ret)
> > +		pdata->low_power_mode =3D 1; /* default low power mode */
> > +
> > +	ret =3D of_property_read_u32(dev->of_node, "dsi-supported",
> > +				   &pdata->dsi_supported);
> > +	if (ret)
> > +		pdata->dsi_supported =3D 1; /* default dsi mode */
> > +
> > +	ret =3D of_property_read_u32(dev->of_node, "extcon-supported",
> > +				   &pdata->extcon_supported);
> > +	if (ret)
> > +		pdata->extcon_supported =3D 0;
> > +
> > +	ret =3D of_property_read_u32(dev->of_node, "internal-pannel-supported=
",
> > +				   &pdata->internal_pannel);
> > +	if (ret)
> > +		pdata->internal_pannel =3D 0;
> > +
> > +	of_property_read_u32(dev->of_node, "dsi-channel-id",
> > +			     &pdata->dsi_channel);
> > +
> > +	of_property_read_u32(dev->of_node, "dsi-lanes-num", &pdata->dsi_lanes=
);
> > +
> > +	pdata->host_node =3D of_graph_get_remote_node(np, 0, 0);
> > +	if (pdata->host_node)
> > +		of_node_put(pdata->host_node);
> > +
> > +	DRM_DEV_DEBUG_DRIVER(dev, "low_power_mode : %d, dsi_supported : %d\n"=
,
> > +			     pdata->low_power_mode, pdata->dsi_supported);
> > +	DRM_DEV_DEBUG_DRIVER(dev, "dsi_channel : %d, dsi_lanes : %d, %s node\=
n",
> > +			     pdata->dsi_channel, pdata->dsi_lanes,
> > +			     (!pdata->host_node) ? "not" : "has");
> > +
> > +	if (pdata->low_power_mode) {
> > +		pdata->gpio_p_on =3D
> > +			of_get_named_gpio_flags(np, "pon-gpios",
> > +						0, NULL);
> > +
> > +		pdata->gpio_reset =3D
> > +			of_get_named_gpio_flags(np, "reset-gpios",
> > +						0, NULL);
> > +		DRM_DEV_DEBUG_DRIVER(dev, "gpio p_on : %d, reset : %d\n",
> > +				     pdata->gpio_p_on, pdata->gpio_reset);
> > +	}
> > +
> > +	pdata->gpio_intr_hpd =3D
> > +		of_get_named_gpio_flags(np, "hpd-gpios", 0, NULL);
> > +
> > +	DRM_DEV_DEBUG_DRIVER(dev, "gpio hpd : %d\n", pdata->gpio_intr_hpd);
> > +
> > +	return 0;
> > +}
> > +#else
> > +static int anx7625_parse_dt(struct device *dev,
> > +			    struct anx7625_platform_data *pdata)
> > +{
> > +	return -ENODEV;
> > +}
> > +#endif
> > +
> > +static inline struct anx7625_data *connector_to_anx7625(struct drm_con=
nector *c)
> > +{
> > +	return container_of(c, struct anx7625_data, connector);
> > +}
> > +
> > +static inline struct anx7625_data *bridge_to_anx7625(struct drm_bridge=
 *bridge)
> > +{
> > +	return container_of(bridge, struct anx7625_data, bridge);
> > +}
> > +
> > +static int anx7625_read_hpd_status_p0(struct anx7625_data *ctx)
> > +{
> > +	return anx7625_reg_read(ctx, ctx->i2c.rx_p0_client, SYSTEM_STSTUS);
> > +}
> > +
> > +static int anx7625_get_modes(struct drm_connector *connector)
> > +{
> > +	struct anx7625_data *ctx =3D connector_to_anx7625(connector);
> > +	int err, num_modes =3D 0;
> > +	int val, ret;
> > +	struct s_edid_data *p_edid =3D (struct s_edid_data *)ctx->slimport_ed=
id_p;
> > +	struct device *dev =3D &ctx->client->dev;
> > +
> > +	DRM_DEV_DEBUG_DRIVER(dev, "drm get modes\n");
> > +
> > +	if (ctx->pdata.internal_pannel &&
> > +	    ctx->pdata.low_power_mode &&
> > +	    (!atomic_read(&ctx->power_status))) {
> > +		anx7625_power_on_init(ctx);
> > +		atomic_set(&ctx->power_status, 1);
> > +
> > +		ret =3D readx_poll_timeout(anx7625_read_hpd_status_p0,
> > +					 ctx, val,
> > +					 ((val & HPD_STATUS) || (val < 0)),
> > +					 5000,
> > +					 5000 * 100);
> > +		if (ret) {
> > +			DRM_DEV_ERROR(dev, "HPD status polling timeout!\n");
> > +		} else {
> > +			DRM_DEV_DEBUG_DRIVER(dev, "HPD raise up.\n");
> > +			anx7625_reg_write(ctx, ctx->i2c.tcpc_client,
> > +					  INTR_ALERT_1, 0xFF);
> > +			anx7625_reg_write(ctx, ctx->i2c.rx_p0_client,
> > +					  INTERFACE_CHANGE_INT, 0);
> > +		}
> > +
> > +		anx7625_start_dp_work(ctx);
> > +	}
> > +
> > +	if (WARN_ON(!atomic_read(&ctx->power_status)))
> > +		return 0;
> > +
> > +	if (ctx->slimport_edid_p && ctx->slimport_edid_p->edid_block_num >=3D=
 0)
> > +		return drm_add_edid_modes(connector,
> > +					  (struct edid *)
> > +					  &p_edid->edid_raw_data);
> > +
> > +	mutex_lock(&ctx->lock);
> > +
> > +	if (!ctx->slimport_edid_p)
> > +		ctx->slimport_edid_p =3D kzalloc(sizeof(*ctx->slimport_edid_p),
> > +					       GFP_KERNEL);
>=20
> Add a check for NULL.
>=20
> > +	p_edid =3D ctx->slimport_edid_p;
> > +	p_edid->edid_block_num =3D sp_tx_edid_read(ctx, p_edid->edid_raw_data=
);
> > +	if (p_edid->edid_block_num < 0) {
> > +		DRM_ERROR("Failed to read EDID.\n");
> > +		goto unlock;
> > +	}
> > +
> > +	err =3D drm_connector_update_edid_property(connector,
> > +						 (struct edid *)
> > +						 &p_edid->edid_raw_data);
> > +
> > +	if (err) {
> > +		DRM_ERROR("Failed to update EDID property: %d\n", err);
> > +		goto unlock;
> > +	}
> > +
> > +	num_modes =3D drm_add_edid_modes(connector,
> > +				       (struct edid *)&p_edid->edid_raw_data);
> > +
> > +unlock:
> > +	mutex_unlock(&ctx->lock);
> > +
> > +	return num_modes;
> > +}
> > +
> > +static enum drm_mode_status
> > +anx7625_connector_mode_valid(struct drm_connector *connector,
> > +			     struct drm_display_mode *mode)
> > +{
> > +	struct anx7625_data *ctx =3D connector_to_anx7625(connector);
> > +	struct device *dev =3D &ctx->client->dev;
> > +
> > +	DRM_DEV_DEBUG_DRIVER(dev, "drm modes valid verify\n");
> > +
> > +	if (mode->clock > 300000)
> > +		return MODE_CLOCK_HIGH;
> > +
> > +	return MODE_OK;
> > +}
> > +
> > +static struct drm_connector_helper_funcs anx7625_connector_helper_func=
s =3D {
> > +	.get_modes =3D anx7625_get_modes,
> > +	.mode_valid =3D anx7625_connector_mode_valid,
> > +};
> > +
> > +static enum drm_connector_status anx7625_detect(struct drm_connector *=
connector,
> > +						bool force)
> > +{
> > +	struct anx7625_data *ctx =3D connector_to_anx7625(connector);
> > +	struct device *dev =3D &ctx->client->dev;
> > +
> > +	if (!(ctx->hpd_status))
>=20
> Remove extra parens.
>=20
> > +		return connector_status_disconnected;
> > +
> > +	DRM_DEV_DEBUG_DRIVER(dev, "drm detect\n");
> > +
> > +	return connector_status_connected;
> > +}
> > +
> > +static const struct drm_connector_funcs anx7625_connector_funcs =3D {
> > +	.fill_modes =3D drm_helper_probe_single_connector_modes,
> > +	.detect =3D anx7625_detect,
> > +	.destroy =3D drm_connector_cleanup,
> > +	.reset =3D drm_atomic_helper_connector_reset,
> > +	.atomic_duplicate_state =3D drm_atomic_helper_connector_duplicate_sta=
te,
> > +	.atomic_destroy_state =3D drm_atomic_helper_connector_destroy_state,
> > +};
> > +
> > +static void anx7625_attach_dsi(struct anx7625_data *ctx)
> > +{
> > +	struct mipi_dsi_host *host;
> > +	struct mipi_dsi_device *dsi;
> > +	struct device *dev =3D &ctx->client->dev;
> > +	const struct mipi_dsi_device_info info =3D {
> > +		.type =3D "anx7625",
> > +		.channel =3D ctx->pdata.dsi_channel,
> > +		.node =3D NULL,
> > +	};
> > +
> > +	DRM_DEV_DEBUG_DRIVER(dev, "attach dsi\n");
> > +
> > +	host =3D of_find_mipi_dsi_host_by_node(ctx->pdata.host_node);
> > +	if (!host) {
> > +		DRM_ERROR("failed to find dsi host.\n");
> > +		return;
>=20
> I feel like this should really return negative error codes.
>=20
> > +	}
> > +
> > +	dsi =3D mipi_dsi_device_register_full(host, &info);
> > +	if (IS_ERR(dsi)) {
> > +		DRM_ERROR("failed to create dsi device.\n");
> > +		return;
> > +	}
> > +
> > +	dsi->lanes =3D ctx->pdata.dsi_lanes;
> > +	dsi->format =3D MIPI_DSI_FMT_RGB888;
> > +	dsi->mode_flags =3D MIPI_DSI_MODE_VIDEO	|
> > +		MIPI_DSI_MODE_VIDEO_SYNC_PULSE	|
> > +		MIPI_DSI_MODE_EOT_PACKET	|
> > +		MIPI_DSI_MODE_VIDEO_HSE;
> > +
> > +	if (mipi_dsi_attach(dsi) < 0) {
> > +		DRM_ERROR("failed to attach dsi to host.\n");
> > +		mipi_dsi_device_unregister(dsi);
> > +		return;
> > +	}
> > +
> > +	ctx->dsi =3D dsi;
> > +
> > +	DRM_DEV_DEBUG_DRIVER(dev, "attach dsi succeeded.\n");
> > +}
> > +
> > +static void anx7625_detach_dsi(struct anx7625_data *ctx)
> > +{
> > +	if (ctx->dsi) {
> > +		mipi_dsi_detach(ctx->dsi);
> > +		mipi_dsi_device_unregister(ctx->dsi);
> > +	}
> > +}
> > +
> > +static int anx7625_bridge_attach(struct drm_bridge *bridge)
> > +{
> > +	struct anx7625_data *ctx =3D bridge_to_anx7625(bridge);
> > +	int err;
> > +	struct device *dev =3D &ctx->client->dev;
> > +
> > +	DRM_DEV_DEBUG_DRIVER(dev, "drm attach\n");
> > +	if (!bridge->encoder) {
> > +		DRM_ERROR("Parent encoder object not found");
> > +		return -ENODEV;
> > +	}
> > +
> > +	err =3D drm_connector_init(bridge->dev, &ctx->connector,
> > +				 &anx7625_connector_funcs,
> > +				 DRM_MODE_CONNECTOR_DisplayPort);
> > +	if (err) {
> > +		DRM_ERROR("Failed to initialize connector: %d\n", err);
> > +		return err;
> > +	}
> > +
> > +	drm_connector_helper_add(&ctx->connector,
> > +				 &anx7625_connector_helper_funcs);
> > +
> > +	err =3D drm_connector_register(&ctx->connector);
> > +	if (err) {
> > +		DRM_ERROR("Failed to register connector: %d\n", err);
> > +		return err;
> > +	}
> > +
> > +	ctx->connector.polled =3D DRM_CONNECTOR_POLL_HPD;
> > +
> > +	err =3D drm_connector_attach_encoder(&ctx->connector, bridge->encoder=
);
> > +	if (err) {
> > +		DRM_ERROR("Failed to link up connector to encoder: %d\n", err);
> > +		drm_connector_unregister(&ctx->connector);
> > +		return err;
> > +	}
> > +
> > +	anx7625_attach_dsi(ctx);
> > +
> > +	ctx->bridge_attached =3D 1;
> > +
> > +	return 0;
> > +}
> > +
> > +static enum drm_mode_status
> > +anx7625_bridge_mode_valid(struct drm_bridge *bridge,
> > +			  const struct drm_display_mode *mode)
> > +{
> > +	struct anx7625_data *ctx =3D bridge_to_anx7625(bridge);
> > +	struct device *dev =3D &ctx->client->dev;
> > +
> > +	DRM_DEV_DEBUG_DRIVER(dev, "drm mode checking\n");
> > +
> > +	/* Max 1200p at 5.4 Ghz, one lane, pixel clock 300M */
> > +	if (mode->clock > 300000) {
> > +		DRM_DEV_DEBUG_DRIVER(dev,
> > +				     "drm mode invalid, pixelclock too high.\n");
> > +		return MODE_CLOCK_HIGH;
> > +	}
> > +
> > +	DRM_DEV_DEBUG_DRIVER(dev, "drm mode valid.\n");
> > +	return MODE_OK;
> > +}
> > +
> > +static void anx7625_bridge_mode_set(struct drm_bridge *bridge,
> > +				    const struct drm_display_mode *old_mode,
> > +				    const struct drm_display_mode *mode)
> > +{
> > +	struct anx7625_data *ctx =3D bridge_to_anx7625(bridge);
> > +	struct device *dev =3D &ctx->client->dev;
> > +
> > +	DRM_DEV_DEBUG_DRIVER(dev, "drm mode set\n");
>=20
> You can get better information with ftrace.
>=20
> > +
> > +	if (WARN_ON(!atomic_read(&ctx->power_status)))
> > +		return;
> > +
> > +	mutex_lock(&ctx->lock);
> > +
> > +	ctx->dt.pixelclock.min =3D mode->clock;
> > +	ctx->dt.hactive.min =3D mode->hdisplay;
> > +	ctx->dt.hsync_len.min =3D mode->hsync_end - mode->hsync_start;
> > +	ctx->dt.hfront_porch.min =3D mode->hsync_start - mode->hdisplay;
> > +	ctx->dt.hback_porch.min =3D mode->htotal - mode->hsync_end;
> > +	ctx->dt.vactive.min =3D mode->vdisplay;
> > +	ctx->dt.vsync_len.min =3D mode->vsync_end - mode->vsync_start;
> > +	ctx->dt.vfront_porch.min =3D mode->vsync_start - mode->vdisplay;
> > +	ctx->dt.vback_porch.min =3D mode->vtotal - mode->vsync_end;
> > +
> > +	ctx->display_timing_valid =3D 1;
> > +
> > +	DRM_DEV_DEBUG_DRIVER(dev, "pixelclock(%d).\n", ctx->dt.pixelclock.min=
);
> > +	DRM_DEV_DEBUG_DRIVER(dev, "hactive(%d), hsync(%d), hfp(%d), hbp(%d)\n=
",
> > +			     ctx->dt.hactive.min,
> > +			     ctx->dt.hsync_len.min,
> > +			     ctx->dt.hfront_porch.min,
> > +			     ctx->dt.hback_porch.min);
> > +	DRM_DEV_DEBUG_DRIVER(dev, "vactive(%d), vsync(%d), vfp(%d), vbp(%d)\n=
",
> > +			     ctx->dt.vactive.min,
> > +			     ctx->dt.vsync_len.min,
> > +			     ctx->dt.vfront_porch.min,
> > +			     ctx->dt.vback_porch.min);
> > +	DRM_DEV_DEBUG_DRIVER(dev, "hdisplay(%d),hsync_start(%d).\n",
> > +			     mode->hdisplay,
> > +			     mode->hsync_start);
> > +	DRM_DEV_DEBUG_DRIVER(dev, "hsync_end(%d),htotal(%d).\n",
> > +			     mode->hsync_end,
> > +			     mode->htotal);
> > +	DRM_DEV_DEBUG_DRIVER(dev, "vdisplay(%d),vsync_start(%d).\n",
> > +			     mode->vdisplay,
> > +			     mode->vsync_start);
> > +	DRM_DEV_DEBUG_DRIVER(dev, "vsync_end(%d),vtotal(%d).\n",
> > +			     mode->vsync_end,
> > +			     mode->vtotal);
> > +
> > +	mutex_unlock(&ctx->lock);
> > +}
> > +
> > +static void anx7625_bridge_enable(struct drm_bridge *bridge)
> > +{
> > +	struct anx7625_data *ctx =3D bridge_to_anx7625(bridge);
> > +	struct device *dev =3D &ctx->client->dev;
> > +
> > +	DRM_DEV_DEBUG_DRIVER(dev, "drm enable\n");
>=20
> ftrace.
>=20
> > +
> > +	if (WARN_ON(!atomic_read(&ctx->power_status)))
> > +		return;
> > +
> > +	mutex_lock(&ctx->lock);
> > +
> > +	anx7625_dp_start(ctx);
> > +
> > +	mutex_unlock(&ctx->lock);
> > +}
> > +
> > +static void anx7625_bridge_disable(struct drm_bridge *bridge)
> > +{
> > +	struct anx7625_data *ctx =3D bridge_to_anx7625(bridge);
> > +	struct device *dev =3D &ctx->client->dev;
> > +
> > +	if (WARN_ON(!atomic_read(&ctx->power_status)))
> > +		return;
> > +
> > +	DRM_DEV_DEBUG_DRIVER(dev, "drm disable\n");
>=20
> ftrace.
>=20
> > +	mutex_lock(&ctx->lock);
> > +
> > +	anx7625_dp_stop(ctx);
> > +
> > +	if (ctx->pdata.internal_pannel &&
> > +	    ctx->pdata.low_power_mode &&
> > +	    (atomic_read(&ctx->power_status))) {
> > +		anx7625_stop_dp_work(ctx);
> > +		anx7625_power_standby(ctx);
> > +		atomic_set(&ctx->power_status, 0);
> > +	}
> > +
> > +	mutex_unlock(&ctx->lock);
> > +}
> > +
> > +static const struct drm_bridge_funcs anx7625_bridge_funcs =3D {
> > +	.attach =3D anx7625_bridge_attach,
> > +	.disable =3D anx7625_bridge_disable,
> > +	.mode_valid =3D anx7625_bridge_mode_valid,
> > +	.mode_set =3D anx7625_bridge_mode_set,
> > +	.enable =3D anx7625_bridge_enable,
> > +};
> > +
> > +static int anx7625_register_i2c_dummy_clients(struct anx7625_data *ctx=
,
> > +					      struct i2c_client *client)
> > +{
> > +	ctx->i2c.tx_p0_client =3D i2c_new_dummy(client->adapter,
> > +					     TX_P0_ADDR >> 1);
> > +	ctx->i2c.tx_p1_client =3D i2c_new_dummy(client->adapter,
> > +					      TX_P1_ADDR >> 1);
> > +	ctx->i2c.tx_p2_client =3D i2c_new_dummy(client->adapter,
> > +					      TX_P2_ADDR >> 1);
> > +
> > +	ctx->i2c.rx_p0_client =3D i2c_new_dummy(client->adapter,
> > +					      RX_P0_ADDR >> 1);
> > +	ctx->i2c.rx_p1_client =3D i2c_new_dummy(client->adapter,
> > +					      RX_P1_ADDR >> 1);
> > +	ctx->i2c.rx_p2_client =3D i2c_new_dummy(client->adapter,
> > +					      RX_P2_ADDR >> 1);
> > +
> > +	ctx->i2c.tcpc_client =3D i2c_new_dummy(client->adapter,
> > +					     TCPC_INTERFACE_ADDR >> 1);
> > +
> > +	if ((!ctx->i2c.tx_p0_client |
> > +	     !ctx->i2c.tx_p1_client |
> > +	     !ctx->i2c.tx_p2_client |
> > +	     !ctx->i2c.rx_p0_client |
> > +	     !ctx->i2c.rx_p1_client |
> > +	     !ctx->i2c.rx_p2_client |
> > +	     !ctx->i2c.tcpc_client) !=3D 0)
>=20
> This is too complicated.  Don't return 1 on failure.  Every function
> should clean up it's own partial allocations.
>=20
> 	if (!ctx->i2c.tx_p0_client ||
> 	    !ctx->i2c.tx_p1_client ||
> 		...
> 	    !ctx->i2c.tcpc_client) {
> 		anx7625_unregister_i2c_dummy_clients(ctx);
> 		return -ENOMEM;
> 	}
>=20
> > +		return 1;
> > +
> > +	return 0;
> > +}
> > +
> > +static void anx7625_unregister_i2c_dummy_clients(struct anx7625_data *=
ctx)
> > +{
> > +	i2c_unregister_device(ctx->i2c.tx_p0_client);
> > +	i2c_unregister_device(ctx->i2c.tx_p1_client);
> > +	i2c_unregister_device(ctx->i2c.tx_p2_client);
> > +	i2c_unregister_device(ctx->i2c.rx_p1_client);
> > +	i2c_unregister_device(ctx->i2c.rx_p2_client);
> > +	i2c_unregister_device(ctx->i2c.rx_p3_client);
> > +	i2c_unregister_device(ctx->i2c.tcpc_client);
> > +}
> > +
> > +static int anx7625_i2c_probe(struct i2c_client *client,
> > +			     const struct i2c_device_id *id)
> > +{
> > +	struct anx7625_data *platform;
> > +	struct anx7625_platform_data *pdata;
> > +	int ret =3D 0;
> > +	struct device *dev =3D &client->dev;
> > +
> > +	if (!i2c_check_functionality(client->adapter,
> > +				     I2C_FUNC_SMBUS_I2C_BLOCK)) {
> > +		DRM_DEV_ERROR(dev, "anx7625's i2c bus doesn't support\n");
> > +		ret =3D -ENODEV;
> > +		goto exit;
>=20
> return -ENODEV;
>=20
> > +	}
> > +
> > +	platform =3D kzalloc(sizeof(*platform), GFP_KERNEL);
> > +	if (!platform) {
> > +		DRM_DEV_ERROR(dev, "failed to allocate driver data\n");
> > +		ret =3D -ENOMEM;
> > +		goto exit;
>=20
> Use devm_kzalloc()?  return -ENOMEM;
>=20
> > +	}
> > +
> > +	pdata =3D &platform->pdata;
> > +
> > +	/* device tree parsing function call */
> > +	ret =3D anx7625_parse_dt(&client->dev, pdata);
> > +	if (ret !=3D 0)	/* if occurs error */
>=20
> Only use =3D=3D 0 when you are talking about numbers as in if (size =3D=
=3D 0) or
> if (cnt =3D=3D 0) or for strcmp() =3D=3D 0.  Here zero is the absence of =
errors
> so it should be "if (ret) ".
>=20
> > +		goto err0;
>=20
> goto free_platfrom;
>=20
> > +
> > +	/* to access global platform data */
> > +	platform->client =3D client;
> > +	i2c_set_clientdata(client, platform);
> > +
> > +	if (platform->pdata.extcon_supported) {
> > +		/* get extcon device from DTS */
> > +		platform->extcon =3D extcon_get_edev_by_phandle(&client->dev, 0);
> > +		if (PTR_ERR(platform->extcon) =3D=3D -EPROBE_DEFER)
> > +			goto err0;
> > +		if (IS_ERR(platform->extcon)) {
> > +			DRM_DEV_ERROR(&client->dev,
> > +				      "can not get extcon device!");
> > +			goto err0;
> > +		}
> > +
> > +		ret =3D anx7625_extcon_notifier_init(platform);
> > +		if (ret < 0)
> > +			goto err0;
> > +	}
> > +
> > +	atomic_set(&platform->power_status, 0);
> > +
> > +	mutex_init(&platform->lock);
> > +
> > +	ret =3D anx7625_init_gpio(platform);
> > +	if (ret) {
> > +		DRM_DEV_ERROR(dev, "failed to initialize gpio\n");
> > +		goto err0;
> > +	}
> > +
> > +	INIT_WORK(&platform->work, anx7625_work_func);
> > +
> > +	platform->workqueue =3D create_workqueue("anx7625_work");
> > +	if (!platform->workqueue) {
> > +		DRM_DEV_ERROR(dev, "failed to create work queue\n");
> > +		ret =3D -ENOMEM;
> > +		goto err1;
>=20
> goto err_free_gpio;
>=20
> > +	}
> > +
> > +	if (platform->pdata.gpio_intr_hpd) {
> > +		platform->pdata.hpd_irq =3D
> > +			gpio_to_irq(platform->pdata.gpio_intr_hpd);
> > +		if (platform->pdata.hpd_irq < 0) {
> > +			DRM_DEV_ERROR(dev, "failed to get gpio irq\n");
> > +			goto err1;
>=20
> Leak.  goto err_destroy_wq;
>=20
> > +		}
> > +
> > +		ret =3D request_threaded_irq(platform->pdata.hpd_irq,
> > +					   NULL, anx7625_intr_hpd_isr,
> > +					   IRQF_TRIGGER_FALLING |
> > +					   IRQF_TRIGGER_RISING |
> > +					   IRQF_ONESHOT,
> > +					   "anx7625-hpd", platform);
> > +		if (ret < 0) {
> > +			DRM_DEV_ERROR(dev, "failed to request irq\n");
> > +			goto err2;
>=20
>=20
> goto free_workqueue;
>=20
> > +		}
> > +
> > +		ret =3D irq_set_irq_wake(platform->pdata.hpd_irq, 1);
> > +		if (ret < 0) {
> > +			DRM_DEV_ERROR(dev, "Request irq for hpd");
> > +			DRM_DEV_ERROR(dev, "interrupt wake set fail\n");
> > +			goto err2;
>=20
> Leak?  goto err_free_irq?
>=20
>=20
> > +		}
> > +
> > +		ret =3D enable_irq_wake(platform->pdata.hpd_irq);
> > +		if (ret < 0) {
> > +			DRM_DEV_ERROR(dev, "Enable irq for HPD");
> > +			DRM_DEV_ERROR(dev, "interrupt wake enable fail\n");
> > +			goto err2;
>=20
> Leak?
>=20
> > +		}
> > +	}
> > +
> > +	if (anx7625_register_i2c_dummy_clients(platform, client) !=3D 0) {
>=20
> Now that anx7625_register_i2c_dummy_clients() returns a valid error
> code we should preserve it.  No need to release the partially allocated
> dummy clients because it either allocates everything or it doesn't
> allocate anything.
>=20
> 	ret =3D anx7625_register_i2c_dummy_clients();
> 	if (ret)
> 		goto err_free_irq;
>=20
> > +		ret =3D -ENOMEM;
> > +		DRM_ERROR("Failed to reserve I2C bus.\n");
> > +		goto err3;
> > +	}
> > +
> > +	if (platform->pdata.low_power_mode =3D=3D 0) {
> > +		anx7625_disable_pd_protocol(platform);
> > +		atomic_set(&platform->power_status, 1);
> > +	}
> > +
> > +	/* add work function */
> > +	queue_work(platform->workqueue, &platform->work);
> > +
> > +	platform->bridge.funcs =3D &anx7625_bridge_funcs;
> > +#if IS_ENABLED(CONFIG_OF)
> > +	platform->bridge.of_node =3D client->dev.of_node;
> > +#endif
>=20
> We can get rid of the ifdef.
>=20
> 	if (IS_ENABLED(CONFIG_OF))
> 		platform->bridge.of_node =3D client->dev.of_node;
>=20
>=20
> > +	drm_bridge_add(&platform->bridge);
> > +
> > +	DRM_DEV_DEBUG_DRIVER(dev, "probe done\n");
> > +	goto exit;
>=20
> return 0;
>=20
> > +
> > +err3:
> > +	anx7625_unregister_i2c_dummy_clients(platform);
> > +err2:
> > +	if (platform->pdata.gpio_intr_hpd)
> > +		free_irq(platform->pdata.hpd_irq, platform);
> > +err1:
> > +	anx7625_free_gpio(platform);
> > +	destroy_workqueue(platform->workqueue);
> > +err0:
> > +	kfree(platform);
> > +exit:
> > +	return ret;
>=20
> err_free_irq:
> 	if (platform->pdata.gpio_intr_hpd)
> 		free_irq(platform->pdata.hpd_irq, platform);
> err_destroy_wq:
> 	destroy_workqueue(platform->workqueue);
> err_free_gpio:
> 	anx7625_free_gpio(platform);
> err_free_platform:
> 	kfree(platform);
>=20
> 	return ret;
>=20
>=20
> > +}
> > +
> > +static int anx7625_i2c_remove(struct i2c_client *client)
> > +{
> > +	struct anx7625_data *platform =3D i2c_get_clientdata(client);
> > +
> > +	drm_bridge_remove(&platform->bridge);
> > +
> > +	if (platform->pdata.gpio_intr_hpd)
> > +		free_irq(platform->pdata.hpd_irq, platform);
> > +
> > +	destroy_workqueue(platform->workqueue);
> > +
> > +	if (platform->pdata.extcon_supported) {
> > +		devm_extcon_unregister_notifier(&platform->client->dev,
> > +						platform->extcon,
> > +						EXTCON_DISP_DP,
> > +						&platform->event_nb);
> > +		flush_work(&platform->extcon_wq);
> > +	}
> > +
> > +	anx7625_detach_dsi(platform);
> > +
> > +	if (platform->bridge_attached)
> > +		drm_connector_unregister(&platform->connector);
> > +
>=20
> We don't call anx7625_attach_dis() or drm_connector_register() during
> probe so it's weird that we are doing it in remove.
>=20
> > +	anx7625_unregister_i2c_dummy_clients(platform);
>=20
> This should done between drm_bridge_remove() and free_irq() so that
> we unwind in the opposite/mirror order of how we probe().
>=20
> > +
> > +	anx7625_free_gpio(platform);
> > +
> > +	kfree(platform);
> > +	return 0;
> > +}
>=20
> regards,
> dan carpenter
