Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C2AFC3A59F
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 03:02:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E7272070B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 03:02:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="QWHet+vB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728887AbfH0DCy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 23:02:54 -0400
Received: from mail-eopbgr740054.outbound.protection.outlook.com ([40.107.74.54]:55024
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727227AbfH0DCv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 23:02:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XZpDWFd4pOGrYnXy9MasLHS2NH1E3QC2mJmiUBQIpQpaWsXTnxmOVVoQtO5/71RpQQs9nbg9pCog7BeeFZH0sDvbj09qY9qKkqpElP/R6OJt33zNuAQWUdyKr5LDvADmTeEjdEKgtDnd0Qdx2me2qAxVYpiWsxAdmHWJeAcFOnFpmHivS6+XdKXAI5LiA7tNgc0HZBPOPQnHPpW21kSg7bWp0goST6HhfPFo0+ZIFbQbH/N5XsnbagnHL3Xi810mp3sA53TBlZJFvDktW2DLnt2FMP2pnFKmOR37YjTfI7CMTAj79fhDiwRAMiYJFWZbJL/Hn9B9SeBBDdLXgabwLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Gy9o108jtFL1ZkEsVjfAV6WBBpOWvQAmlkoNfXT7Jk=;
 b=nIvGbZglFULo/6RicI7id9H8c7ibOaSIL1U4054EneJ7hPBs7bf9CP87l1ySFp7W4bq4UMmxG6kXRAA8hgzxL10gak7tc4Z7T0ZwWPFhbrmskcD5FhPtZArka8ejNwkq08dS6i43brG90PnBTBtVJXOPOoaB7EcZ/NUrP4rHpJ0lfyP/2Nw0Z9f5Du/PyktGRU73WicD63ZaEpbALV+GnYDhtytG9bzy6Rl1Am1DL2XjSAxE1z32xU4y4cuNDUs4RwCfxB9NhFRdmj/UD/nMNXd9A9OPAmpRRJM2vKah7hGV1y9uRn9dO1YMZ57N8SMjTTHPnYzHjOCTa3woDUcQ9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Gy9o108jtFL1ZkEsVjfAV6WBBpOWvQAmlkoNfXT7Jk=;
 b=QWHet+vBv8o+ITGItoanLmLWoUeOhmH5O+C5f0vZF5huFoiJDNOPJje7ZSJjosbr8iASbNZS8+LW7kwuACpSz8BuESnPf+2URTxqgu69turUhbmiVVifW4TJD4yoIfBK6PJLNxwUV8rUC/if/EKM4ceYHpeT+0JscpIgpWmj0Rk=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.92.152) by
 BYAPR03MB4134.namprd03.prod.outlook.com (20.177.184.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.20; Tue, 27 Aug 2019 03:02:40 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::b050:60f8:d275:e9f4]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::b050:60f8:d275:e9f4%7]) with mapi id 15.20.2199.021; Tue, 27 Aug 2019
 03:02:40 +0000
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] hwmon: Add Synaptics AS370 PVT sensor driver
Thread-Topic: [PATCH 1/2] hwmon: Add Synaptics AS370 PVT sensor driver
Thread-Index: AQHVW/U+3KXhEGf4F0mE/YeHwSUiPKcNcN8AgADbxgA=
Date:   Tue, 27 Aug 2019 03:02:40 +0000
Message-ID: <20190827105110.0be8d669@xhacker.debian>
References: <20190826174942.2b28ff05@xhacker.debian>
        <20190826175029.433632f6@xhacker.debian>
        <35b05950-4a72-9e00-50ab-ecd0a7e759a4@roeck-us.net>
In-Reply-To: <35b05950-4a72-9e00-50ab-ecd0a7e759a4@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [124.74.246.114]
x-clientproxiedby: HK0PR04CA0009.apcprd04.prod.outlook.com
 (2603:1096:203:36::21) To BYAPR03MB4773.namprd03.prod.outlook.com
 (2603:10b6:a03:134::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d666e6f3-1460-4285-b090-08d72a9b058b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR03MB4134;
x-ms-traffictypediagnostic: BYAPR03MB4134:
x-microsoft-antispam-prvs: <BYAPR03MB4134F21C444DF45BAF1C1715EDA00@BYAPR03MB4134.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0142F22657
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(346002)(376002)(39860400002)(396003)(199004)(189003)(486006)(476003)(11346002)(186003)(478600001)(6116002)(3846002)(50226002)(446003)(6916009)(53546011)(6506007)(386003)(102836004)(99286004)(52116002)(6486002)(76176011)(4326008)(71200400001)(316002)(26005)(71190400001)(54906003)(6246003)(25786009)(5660300002)(2906002)(256004)(53936002)(6512007)(9686003)(66556008)(66066001)(66946007)(64756008)(66476007)(66446008)(229853002)(86362001)(6436002)(8936002)(81166006)(81156014)(7736002)(8676002)(305945005)(14454004)(1076003)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB4134;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: DG7IjrYrD1MEARhHe/QeLunt6almhtrusXppxtamSzcVEJ8ZO3EQH+2IjDGrO1uM5eRwlFPKXTRQypeztsREI5LbSoqEpWckrJY6A5fNp9Xz/2CaJ8ZafT2Pw0uYTMmjDhRZM8cN34KlkZtzAWdvvLaan0ozeIT4o+/1WIFMTpaNC7QgL+ZsUto+r0cBlZ24X5NCoJiOguQkJLsYaecMJRUP8HSlTIlfn+oteyGofy7k58FAAyh2OBDJSI6YUMqK84HhffC/Hw8AqYcm8d8s5hbKWubsMDX8dBgfobP+6wtXPQI4pu2jiWtHyTpnN3u/Gvlkn18Df1RTS2HaSVaeXLz/kxn95Z/0ekAhcA+uF0U/oYGNjoWgNjfoEre3oS8ljoyh+Wj2iCL0Os9cDFTXqW1ImPJf+ByCQpUEhyC5oGg=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <00884E76A2EEC34784622FEA13882DD8@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d666e6f3-1460-4285-b090-08d72a9b058b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2019 03:02:40.4169
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2aisWtvwzYh6VfzVAZWkceA3J8pM0t+C/2Jk2Z5wIvoK6ZhJvA86A9/sIhfOZu30wJmLRrhns8riKuT2QwRJ0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4134
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

On Mon, 26 Aug 2019 06:44:34 -0700 Guenter Roeck wrote:

>=20
>=20
> On 8/26/19 3:01 AM, Jisheng Zhang wrote:
> > Add a new driver for Synaptics AS370 PVT sensors. Currently, only
> > temperature is supported.
> >
> > Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> > ---
> >   drivers/hwmon/Kconfig       |  10 +++
> >   drivers/hwmon/Makefile      |   1 +
> >   drivers/hwmon/as370-hwmon.c | 158 +++++++++++++++++++++++++++++++++++=
+
> >   3 files changed, 169 insertions(+)
> >   create mode 100644 drivers/hwmon/as370-hwmon.c
> >
> > diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> > index 650dd71f9724..d31610933faa 100644
> > --- a/drivers/hwmon/Kconfig
> > +++ b/drivers/hwmon/Kconfig
> > @@ -246,6 +246,16 @@ config SENSORS_ADT7475
> >         This driver can also be built as a module. If so, the module
> >         will be called adt7475.
> >
> > +config SENSORS_AS370
> > +     tristate "Synaptics AS370 SoC hardware monitoring driver" =20
>=20
> I think this needs "depends on HAS_IOMEM".

HWMON depends on HAS_IOMEM, so the dependency has been required
by the common HWMON, we don't need it here.

>=20
> > +     help
> > +       If you say yes here you get support for the PVT sensors of
> > +       the Synaptics AS370 SoC
> > +
> > +       This driver can also be built as a module. If so, the module
> > +       will be called as370-hwmon.
> > +
> > +
> >   config SENSORS_ASC7621
> >       tristate "Andigilog aSC7621"
> >       depends on I2C
> > diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> > index 8db472ea04f0..252e8a4c9781 100644
> > --- a/drivers/hwmon/Makefile
> > +++ b/drivers/hwmon/Makefile
> > @@ -48,6 +48,7 @@ obj-$(CONFIG_SENSORS_ADT7475)       +=3D adt7475.o
> >   obj-$(CONFIG_SENSORS_APPLESMC)      +=3D applesmc.o
> >   obj-$(CONFIG_SENSORS_ARM_SCMI)      +=3D scmi-hwmon.o
> >   obj-$(CONFIG_SENSORS_ARM_SCPI)      +=3D scpi-hwmon.o
> > +obj-$(CONFIG_SENSORS_AS370)  +=3D as370-hwmon.o
> >   obj-$(CONFIG_SENSORS_ASC7621)       +=3D asc7621.o
> >   obj-$(CONFIG_SENSORS_ASPEED)        +=3D aspeed-pwm-tacho.o
> >   obj-$(CONFIG_SENSORS_ATXP1) +=3D atxp1.o
> > diff --git a/drivers/hwmon/as370-hwmon.c b/drivers/hwmon/as370-hwmon.c
> > new file mode 100644
> > index 000000000000..98dfba45e1b0
> > --- /dev/null
> > +++ b/drivers/hwmon/as370-hwmon.c
> > @@ -0,0 +1,158 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Synaptics AS370 SoC Hardware Monitoring Driver
> > + *
> > + * Copyright (C) 2018 Synaptics Incorporated
> > + * Author: Jisheng Zhang <jszhang@kernel.org>
> > + */
> > +
> > +#include <linux/bitops.h>
> > +#include <linux/delay.h> =20
>=20
> Unnecessary include file.

will remove it in newer version.

>=20
> > +#include <linux/hwmon.h>
> > +#include <linux/init.h>
> > +#include <linux/io.h>
> > +#include <linux/module.h>
> > +#include <linux/of_device.h>
> > +
> > +#define CTRL         0x0
> > +#define  PD          BIT(0)
> > +#define  EN          BIT(1)
> > +#define  T_SEL               BIT(2)
> > +#define  V_SEL               BIT(3)
> > +#define  NMOS_SEL    BIT(8)
> > +#define  PMOS_SEL    BIT(9)
> > +#define STS          0x4
> > +#define  BN_MASK     (0xfff << 0) =20
>=20
> How about using GENMASK() ?

Good idea.

>=20
> > +#define  EOC         BIT(12)
> > +
> > +struct as370_hwmon {
> > +     void __iomem *base;
> > +};
> > +
> > +static void init_pvt(struct as370_hwmon *hwmon)
> > +{
> > +     u32 val;
> > +     void __iomem *addr =3D hwmon->base + CTRL;
> > +
> > +     val =3D PD;
> > +     writel_relaxed(val, addr);
> > +     val |=3D T_SEL;
> > +     val &=3D ~V_SEL;
> > +     val &=3D ~NMOS_SEL;
> > +     val &=3D ~PMOS_SEL; =20
>=20
> What is the point of this ? We know that val =3D=3D PD here.

yes, could be removed

>=20
> > +     writel_relaxed(val, addr);
> > +     val |=3D EN;
> > +     writel_relaxed(val, addr);
> > +     val &=3D ~PD;
> > +     writel_relaxed(val, addr);
> > +}
> > +
> > +static int read_pvt(struct as370_hwmon *hwmon)
> > +{
> > +     return readl_relaxed(hwmon->base + STS) & BN_MASK;
> > +} =20
>=20
> Please fold into the calling code.
>=20
> > +
> > +static int as370_hwmon_read(struct device *dev, enum hwmon_sensor_type=
s type,
> > +                         u32 attr, int channel, long *temp)
> > +{
> > +     int val;
> > +     struct as370_hwmon *hwmon =3D dev_get_drvdata(dev);
> > +
> > +     switch (attr) {
> > +     case hwmon_temp_input:
> > +             val =3D read_pvt(hwmon);
> > +             if (val < 0)
> > +                     return val; =20
>=20
> read_pvt() doesn't return a negative error code. This check is unnecessar=
y.
>=20
> > +             *temp =3D val * 251802 / 4096 - 85525; =20
>=20
> This results in rounding down the reported temperature. It is ok if it is
> what you want; otherwise, I would suggest to use DIV_ROUND_CLOSEST().

Good idea.

Thanks for your review,
Jisheng

>=20
> > +             break;
> > +     default:
> > +             return -EOPNOTSUPP;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static umode_t
> > +as370_hwmon_is_visible(const void *data, enum hwmon_sensor_types type,
> > +                    u32 attr, int channel)
> > +{
> > +     if (type !=3D hwmon_temp)
> > +             return 0;
> > +
> > +     switch (attr) {
> > +     case hwmon_temp_input:
> > +             return 0444;
> > +     default:
> > +             return 0;
> > +     }
> > +}
> > +
> > +static const u32 as370_hwmon_temp_config[] =3D {
> > +     HWMON_T_INPUT,
> > +     0
> > +};
> > +
> > +static const struct hwmon_channel_info as370_hwmon_temp =3D {
> > +     .type =3D hwmon_temp,
> > +     .config =3D as370_hwmon_temp_config,
> > +};
> > +
> > +static const struct hwmon_channel_info *as370_hwmon_info[] =3D {
> > +     &as370_hwmon_temp,
> > +     NULL
> > +};
> > +
> > +static const struct hwmon_ops as370_hwmon_ops =3D {
> > +     .is_visible =3D as370_hwmon_is_visible,
> > +     .read =3D as370_hwmon_read,
> > +};
> > +
> > +static const struct hwmon_chip_info as370_chip_info =3D {
> > +     .ops =3D &as370_hwmon_ops,
> > +     .info =3D as370_hwmon_info,
> > +};
> > +
> > +static int as370_hwmon_probe(struct platform_device *pdev)
> > +{
> > +     struct resource *res;
> > +     struct device *hwmon_dev;
> > +     struct as370_hwmon *hwmon;
> > +     struct device *dev =3D &pdev->dev;
> > +
> > +     hwmon =3D devm_kzalloc(dev, sizeof(*hwmon), GFP_KERNEL);
> > +     if (!hwmon)
> > +             return -ENOMEM;
> > +
> > +     res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +     hwmon->base =3D devm_ioremap_resource(&pdev->dev, res);
> > +     if (IS_ERR(hwmon->base))
> > +             return PTR_ERR(hwmon->base);
> > +
> > +     init_pvt(hwmon);
> > +
> > +     hwmon_dev =3D devm_hwmon_device_register_with_info(dev,
> > +                                                      "as370_hwmon", =
=20
>=20
> The "_hwmon" seems unnecessary. It will show up in "sensors" as part
> of the sensor name. Is this really what you want ?
>=20
> > +                                                      hwmon,
> > +                                                      &as370_chip_info=
,
> > +                                                      NULL);
> > +     return PTR_ERR_OR_ZERO(hwmon_dev);
> > +}
> > +
> > +static const struct of_device_id as370_hwmon_match[] =3D {
> > +     { .compatible =3D "syna,as370-hwmon" },
> > +     {},
> > +};
> > +MODULE_DEVICE_TABLE(of, as370_hwmon_match);
> > +
> > +static struct platform_driver as370_hwmon_driver =3D {
> > +     .probe =3D as370_hwmon_probe,
> > +     .driver =3D {
> > +             .name =3D "as370-hwmon",
> > +             .of_match_table =3D as370_hwmon_match,
> > +     },
> > +};
> > +module_platform_driver(as370_hwmon_driver);
> > +
> > +MODULE_AUTHOR("Jisheng Zhang<jszhang@kernel.org>");
> > +MODULE_DESCRIPTION("Synaptics AS370 SoC hardware monitor");
> > +MODULE_LICENSE("GPL v2");
> > =20
>=20

