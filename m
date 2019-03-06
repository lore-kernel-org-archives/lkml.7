Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 493FBC10F00
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 10:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA4E220675
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 10:32:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.se header.i=@prevas.se header.b="KxUzLetc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728865AbfCFKcN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 05:32:13 -0500
Received: from mail-eopbgr80125.outbound.protection.outlook.com ([40.107.8.125]:41333
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725783AbfCFKcN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 05:32:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KjefM4QhQzhkMPpsJXoysMqhFPKGUXJ058P+GTiHuQU=;
 b=KxUzLetc+Fu9YKsJwGrrWciCAn+/hxqrn74DEZh92TOb8HW+DBFnld+8vFKelEz0BQ4LHVs8AQefhxEWV8r17pI7tI8J82ScNazVV6JOGTjDeW535oQIeOyUEuUvAWKNBIMPRuWalgvGp8jGIPuD2nPtpyubZ7lVi4eVmKyHZUw=
Received: from VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM (20.178.126.212) by
 VI1PR10MB2367.EURPRD10.PROD.OUTLOOK.COM (20.177.62.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.19; Wed, 6 Mar 2019 10:32:06 +0000
Received: from VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::51c2:2f6a:3148:4a1f]) by VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::51c2:2f6a:3148:4a1f%3]) with mapi id 15.20.1686.018; Wed, 6 Mar 2019
 10:32:06 +0000
From:   Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     Esben Haabendal <esben@geanix.com>,
        Fabio Estevam <festevam@gmail.com>,
        Per Christensen <pnc@deif.com>,
        Rasmus Villemoes <Rasmus.Villemoes@prevas.se>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] spi: spi-fsl-spi: support use of the SPISEL_BOOT signal on
 MPC8309
Thread-Topic: [PATCH] spi: spi-fsl-spi: support use of the SPISEL_BOOT signal
 on MPC8309
Thread-Index: AQHU1AfYCEu+DVoJHESVruGnCokNwQ==
Date:   Wed, 6 Mar 2019 10:32:05 +0000
Message-ID: <20190306103156.19897-1-rasmus.villemoes@prevas.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0802CA0019.eurprd08.prod.outlook.com
 (2603:10a6:3:bd::29) To VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:e3::20)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Rasmus.Villemoes@prevas.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [81.216.59.226]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 89f4a557-2589-43ca-e563-08d6a21efa8d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:VI1PR10MB2367;
x-ms-traffictypediagnostic: VI1PR10MB2367:
x-microsoft-antispam-prvs: <VI1PR10MB236754B3E0C0A031086522158A730@VI1PR10MB2367.EURPRD10.PROD.OUTLOOK.COM>
x-forefront-prvs: 0968D37274
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(136003)(376002)(346002)(39850400004)(189003)(199004)(66066001)(102836004)(110136005)(42882007)(476003)(486006)(8976002)(53936002)(71200400001)(2616005)(256004)(8936002)(1076003)(6506007)(386003)(26005)(105586002)(106356001)(6486002)(6436002)(71190400001)(5660300002)(186003)(81166006)(52116002)(6512007)(14454004)(50226002)(99286004)(97736004)(4326008)(25786009)(2906002)(305945005)(72206003)(36756003)(74482002)(478600001)(68736007)(44832011)(3846002)(6116002)(54906003)(8676002)(81156014)(316002)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR10MB2367;H:VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: prevas.se does not designate
 permitted sender hosts)
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;VI1PR10MB2367;23:DlASuMGxdB6rpvrOYrFxxR5vDhMjIYf7XR/R/OO?=
 =?iso-8859-1?Q?djxj140vN+UjpQosnLkmCmMdx3cFmWCWGjc3byag3ORXda471n5pfD83Jf?=
 =?iso-8859-1?Q?9kbG7RTThMaCVqI3EPw1eRAFSJ3Gxk0HiFsV/ApF2E3bTVmfYiUaBsco23?=
 =?iso-8859-1?Q?qZfR+3CYz+Moi6z8nRwmmC0irryrmXCBc6/i+iYf6Uq5qgS1mO1Pg1bmiq?=
 =?iso-8859-1?Q?asLt6HBgHprxXiY3mshW62Nbgza1kuscSeaIvvUdpS0L+wJZK7p7I2IACa?=
 =?iso-8859-1?Q?eYE4wtmMn9OwD1102kByaivmroJoBLtKOJMrEx1/LnQxtM5w1WEOISwQor?=
 =?iso-8859-1?Q?lmcqW4tJiCtgIGpd0ZPIPnFBIMXbBeM0EuBZ4QS/geMjZzPJbGtokmnssI?=
 =?iso-8859-1?Q?cebKP01/3NToa5TovWh5ve0CklotgKx9PZi2zOB4oIXpqQxxfX5ul3ladf?=
 =?iso-8859-1?Q?U/9llqwNzfIc0562hvBOI5SkUVprTJIWa6W9vDlXYfDKF2w+ItxvtYUrIA?=
 =?iso-8859-1?Q?7+iFLuF/0D/gRPNBlIuT36u3C/binqB0VaE4fX9Y8BHn506ftBnAh/ni43?=
 =?iso-8859-1?Q?L90BqImAPJTJ/8LkWHGvfcHnTWwmuPo6iDnwM1LWGuxkjYirXI0KVA+kgy?=
 =?iso-8859-1?Q?9iLTRHUQXFDe0gRgWMm0+cGlvjD0rcahveqr8J55tAClMhtbIuRzX5i1Kn?=
 =?iso-8859-1?Q?g23JHFDSwJ7fhaU5cQ8SXOyo4cSG2ghh8D6PqWbx1O2V3o0WOgiHeu9Zky?=
 =?iso-8859-1?Q?ltTLpiMw13+/Lr7VPxBmMxd7jWKOGnwCHmXgoJJi8HJa9TwVXDuvwCs0cY?=
 =?iso-8859-1?Q?9GLQ8qT7bYlPcORXlpIRZqZqb6uajWEL+jQcE360iED8DWdRzwtPoSjfXu?=
 =?iso-8859-1?Q?4Ns3/+0L18jsAIZiGgKtGB7YiLFDs0wpkd5z/e8JOlwnzvJqQewR/Ulu1o?=
 =?iso-8859-1?Q?GpiYeUgAqp5LA0N55DJILlXprYyW7JRmTI/vwKhF+l4CPMXwlD8+xvq7GF?=
 =?iso-8859-1?Q?5nWj46yxdlMaWq4ia+mLSHa4J0/iuBm3+XneNz+5hg3g1+qJ7FBS8VV6Zx?=
 =?iso-8859-1?Q?ZLsdwP1mUB3eJ2sP94ylqlLGcVbR6OUi/l32KsnbJRWsQ4uScSKfNHCfxB?=
 =?iso-8859-1?Q?InxdlhSv9xCoLBbBt0Nk+LTWVb7/XgnfKTPlDwi0jdXZKSA267Zlka2fe7?=
 =?iso-8859-1?Q?2/Px4N9TMXpZgq4yu4rhiyyTzHCMQ0Nn+9+WyAFEm3w8u6oRAvnDcSgpg+?=
 =?iso-8859-1?Q?quiZgnsz8uorCiMVeiPL3GNfLxeNp9GyKjrysRg=3D=3D?=
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: aT+UzObiNeyHh2mGtgZ+MmRaTb7ICrf/dSgh6QEI5ykaR1c+zA7njDYWJ20PKcgTuZYUCEuoc68m+30/tG3XPLfGWgKHUMOTurm3ymNdzSs4lVKZcEdzyhMi6Ojv+TFSQqxilbocz81Lj9p94APrPZXXg2K0YRS4dMnYEvfY90BMIpauImq8/+lgb0QsMSCnCRT/D3zzZQQX7Wg3bQmqKiqDLEvSE2yYz9t7esW7mB0HqTpUXfDPbHIM92wnhFi7UZZ/9BrOUISN6P/xh8H5AuNMl6VeQproRcM+YEW0Sy304MZVOO7g80JeEinCJ9id5TLYz9Q/tROmd8uyK4w8MsWyLYMJK9iWW6oBlV9sE7sbDlyVPAEP6ZpL8tqqdy6UFRvcIswhOmNtehkpQ7gZiFxG6tQneL+DQxi+AvjFCjA=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 89f4a557-2589-43ca-e563-08d6a21efa8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2019 10:32:05.8807
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB2367
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MPC8309 has a dedicated signal, SPISEL_BOOT, usually used as chip
select for the flash device from which the bootloader is loaded. It is
not an ordinary gpio, but is simply controlled via the SPI_CS register
in the system configuration.

To allow accessing such a spi slave, we need to teach
fsl_spi_cs_control() how to control the SPISEL_BOOT signal. To
distinguish the gpio-controlled slaves, continue to have those use
chip_select values of 0..ngpios-1, and use chip_select =3D=3D ngpios for
the boot flash.

I'm not too happy with all the ifdeffery, but it seems to be necessary
for guarding the sysdev/fsl_soc.h and use of
get_immrbase() (spi-fsl-lib.c already contains similar ifdeffery).

Googling suggests that the MPC8306 is similar, with the SPI_CS
register at the same offset.

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 .../devicetree/bindings/spi/fsl-spi.txt       |  4 ++
 drivers/spi/spi-fsl-lib.h                     |  2 +
 drivers/spi/spi-fsl-spi.c                     | 40 ++++++++++++++++---
 3 files changed, 41 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/fsl-spi.txt b/Documentat=
ion/devicetree/bindings/spi/fsl-spi.txt
index 8854004a1d3a..411375eac54d 100644
--- a/Documentation/devicetree/bindings/spi/fsl-spi.txt
+++ b/Documentation/devicetree/bindings/spi/fsl-spi.txt
@@ -18,6 +18,10 @@ Optional properties:
 - gpios : specifies the gpio pins to be used for chipselects.
   The gpios will be referred to as reg =3D <index> in the SPI child nodes.
   If unspecified, a single SPI device without a chip select can be used.
+- fsl,spisel_boot : for the MPC8306 and MPC8309, specifies that the
+  SPISEL_BOOT signal is used as chip select for a slave device. Use
+  reg =3D <number of gpios> in the corresponding child node, i.e. 0 if
+  the gpios property is not present.
=20
 Example:
 	spi@4c0 {
diff --git a/drivers/spi/spi-fsl-lib.h b/drivers/spi/spi-fsl-lib.h
index f303f306b38e..483734bc1b1e 100644
--- a/drivers/spi/spi-fsl-lib.h
+++ b/drivers/spi/spi-fsl-lib.h
@@ -95,8 +95,10 @@ static inline u32 mpc8xxx_spi_read_reg(__be32 __iomem *r=
eg)
=20
 struct mpc8xxx_spi_probe_info {
 	struct fsl_spi_platform_data pdata;
+	int ngpios;
 	int *gpios;
 	bool *alow_flags;
+	__be32 __iomem *immr_spi_cs;
 };
=20
 extern u32 mpc8xxx_spi_tx_buf_u8(struct mpc8xxx_spi *mpc8xxx_spi);
diff --git a/drivers/spi/spi-fsl-spi.c b/drivers/spi/spi-fsl-spi.c
index 8f2e97857e8b..3d7b50c65f36 100644
--- a/drivers/spi/spi-fsl-spi.c
+++ b/drivers/spi/spi-fsl-spi.c
@@ -39,6 +39,14 @@
 #include <linux/spi/spi_bitbang.h>
 #include <linux/types.h>
=20
+#ifdef CONFIG_FSL_SOC
+#include <sysdev/fsl_soc.h>
+#endif
+
+/* Specific to the MPC8306/MPC8309 */
+#define IMMR_SPI_CS_OFFSET 0x14c
+#define SPI_BOOT_SEL_BIT   0x80000000
+
 #include "spi-fsl-lib.h"
 #include "spi-fsl-cpm.h"
 #include "spi-fsl-spi.h"
@@ -701,10 +709,17 @@ static void fsl_spi_cs_control(struct spi_device *spi=
, bool on)
 	struct fsl_spi_platform_data *pdata =3D dev_get_platdata(dev);
 	struct mpc8xxx_spi_probe_info *pinfo =3D to_of_pinfo(pdata);
 	u16 cs =3D spi->chip_select;
-	int gpio =3D pinfo->gpios[cs];
-	bool alow =3D pinfo->alow_flags[cs];
=20
-	gpio_set_value(gpio, on ^ alow);
+	if (cs < pinfo->ngpios) {
+		int gpio =3D pinfo->gpios[cs];
+		bool alow =3D pinfo->alow_flags[cs];
+
+		gpio_set_value(gpio, on ^ alow);
+	} else {
+		if (WARN_ON_ONCE(cs > pinfo->ngpios || !pinfo->immr_spi_cs))
+			return;
+		iowrite32be(on ? SPI_BOOT_SEL_BIT : 0, pinfo->immr_spi_cs);
+	}
 }
=20
 static int of_fsl_spi_get_chipselects(struct device *dev)
@@ -712,12 +727,15 @@ static int of_fsl_spi_get_chipselects(struct device *=
dev)
 	struct device_node *np =3D dev->of_node;
 	struct fsl_spi_platform_data *pdata =3D dev_get_platdata(dev);
 	struct mpc8xxx_spi_probe_info *pinfo =3D to_of_pinfo(pdata);
+	bool spisel_boot =3D IS_ENABLED(CONFIG_FSL_SOC) &&
+		of_property_read_bool(np, "fsl,spisel_boot");
 	int ngpios;
 	int i =3D 0;
 	int ret;
=20
 	ngpios =3D of_gpio_count(np);
-	if (ngpios <=3D 0) {
+	ngpios =3D max(ngpios, 0);
+	if (ngpios =3D=3D 0 && !spisel_boot) {
 		/*
 		 * SPI w/o chip-select line. One SPI device is still permitted
 		 * though.
@@ -726,6 +744,7 @@ static int of_fsl_spi_get_chipselects(struct device *de=
v)
 		return 0;
 	}
=20
+	pinfo->ngpios =3D ngpios;
 	pinfo->gpios =3D kmalloc_array(ngpios, sizeof(*pinfo->gpios),
 				     GFP_KERNEL);
 	if (!pinfo->gpios)
@@ -769,7 +788,18 @@ static int of_fsl_spi_get_chipselects(struct device *d=
ev)
 		}
 	}
=20
-	pdata->max_chipselect =3D ngpios;
+#if IS_ENABLED(CONFIG_FSL_SOC)
+	if (spisel_boot) {
+		pinfo->immr_spi_cs =3D ioremap(get_immrbase() + IMMR_SPI_CS_OFFSET, 4);
+		if (!pinfo->immr_spi_cs) {
+			ret =3D -ENOMEM;
+			i =3D ngpios - 1;
+			goto err_loop;
+		}
+	}
+#endif
+
+	pdata->max_chipselect =3D ngpios + spisel_boot;
 	pdata->cs_control =3D fsl_spi_cs_control;
=20
 	return 0;
--=20
2.20.1

