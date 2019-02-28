Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7BE5C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D13F20830
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:30:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="QVuPrsm/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730751AbfB1Nac (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 08:30:32 -0500
Received: from mail-eopbgr30042.outbound.protection.outlook.com ([40.107.3.42]:1114
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726806AbfB1Nab (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 08:30:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lZKBOx8ALklUsjL4FAabjUHKw9VKDo/E7zy4wKFuyqY=;
 b=QVuPrsm/eBKcP2dqPu9X38S2cxBATUTs3SSE8E/n2Vw+/R4rvG4nmGnL4eoU9xk24b6S4oIEczlKeCuxBztG+ZMm6TZxXFO+MbntGmCEpj/1LjI8iXMdqiXMH6mgYbCO7qvAccVCRGgpoKOoF6XQiT9RqUsxUxI8dlJEEjMmGHA=
Received: from AM5PR0401MB2481.eurprd04.prod.outlook.com (10.169.244.137) by
 AM5PR0401MB2450.eurprd04.prod.outlook.com (10.169.244.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.18; Thu, 28 Feb 2019 13:30:26 +0000
Received: from AM5PR0401MB2481.eurprd04.prod.outlook.com
 ([fe80::c48f:bcc2:39d5:ad4]) by AM5PR0401MB2481.eurprd04.prod.outlook.com
 ([fe80::c48f:bcc2:39d5:ad4%11]) with mapi id 15.20.1665.015; Thu, 28 Feb 2019
 13:30:26 +0000
From:   Pankaj Bansal <pankaj.bansal@nxp.com>
To:     Leo Li <leoyang.li@nxp.com>, Peter Rosin <peda@axentia.se>
CC:     Pankaj Bansal <pankaj.bansal@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 2/2] drivers: mux: Add Generic regmap bitfield-based
 multiplexer in mmio-mux
Thread-Topic: [PATCH v5 2/2] drivers: mux: Add Generic regmap bitfield-based
 multiplexer in mmio-mux
Thread-Index: AQHUz2nDUhg9fUpc0kq/AOr8b8dqgw==
Date:   Thu, 28 Feb 2019 13:30:26 +0000
Message-ID: <20190228185452.22981-2-pankaj.bansal@nxp.com>
References: <20190228185452.22981-1-pankaj.bansal@nxp.com>
In-Reply-To: <20190228185452.22981-1-pankaj.bansal@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BM1PR0101CA0039.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1a::25) To AM5PR0401MB2481.eurprd04.prod.outlook.com
 (2603:10a6:203:36::9)
x-mailer: git-send-email 2.17.1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pankaj.bansal@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.120.1.69]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 297dc013-85ce-424b-e1de-08d69d80e5bd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM5PR0401MB2450;
x-ms-traffictypediagnostic: AM5PR0401MB2450:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;AM5PR0401MB2450;23:yM0jo67NDdE/9cKQqt+ZMBhG1ZyS5FsbB6O4S?=
 =?iso-8859-1?Q?aHC/ZbVHDJlPfIOIr3aHxPSfwb9RSV3wa5EKB3ZeEb/e5rh5mCB0FegTn7?=
 =?iso-8859-1?Q?r+KP8rgYBBaDwcKTuH4c2jFrNGEnOltq4/TgmP2Xjd28zSPcYuQi825BGp?=
 =?iso-8859-1?Q?gwWEqHHwIucXkTjoyK7pDGcl77zxLq6u/gjEdv6WpogbP36Ksf/BmO/0mQ?=
 =?iso-8859-1?Q?rfLBfh3hPfTvFkrpX9irYBCn3iNicfiSKtD3Fb0spcs7AM4bhKJWjR5t9G?=
 =?iso-8859-1?Q?scqmxctzl6KIkmukd9J81FLrSX2jjotHU6SmIrXbjKXwgLITO093J/oDL0?=
 =?iso-8859-1?Q?2TPqlYb/No3w83UWeocBhmVryRtzhAn1g+nLVDBAYE0ShfE2DRrUoxdLPz?=
 =?iso-8859-1?Q?lXVpSx6NfDvQ3dT4Tc/nzkKVTagoETkzUJsW8VybPrLpMoVk1ZoInUswrz?=
 =?iso-8859-1?Q?F8AxXkJdmWchKgbRT4CUt+8A+LYADBdPAZO6iLvxfLAjsiV3sWPbQ+9Lt1?=
 =?iso-8859-1?Q?bdS6gshKvpIBoHtKVxEYYxYdxy1z13ffKzyZzR4Fzo3+pGk1l3c6dwqEoV?=
 =?iso-8859-1?Q?7WQop53peyAPXLBnVPG4qj7/tI02zHSKwsPCtXuQXJn5+xnjGuv5ECc1cm?=
 =?iso-8859-1?Q?tTbWfhQlRaxcfyHf3Bmqr10EnZpAl3/dKREftrVkrz9C42OJShNQrT3lmG?=
 =?iso-8859-1?Q?uWbT2JH+R4ulwgNDafdrcCKwmiWOOMyA8QCiuJxwsWQrAaQIh+nr2hpsx9?=
 =?iso-8859-1?Q?FzOAookx2t9RmtWDfKzPvhethtEC2arrqpSfDOE/WzG3KLYDMdxS94+/1S?=
 =?iso-8859-1?Q?xamIKICKFN8lOxndGVuQ1wKBA/M0rY082KoqyTz/eDwm+gzz/hWrayUbox?=
 =?iso-8859-1?Q?dMjcBkVZyeLVke8JKDaAO3y2JGQzUXzZYxc9kGU5cPceDDC6PfoGq4PSqJ?=
 =?iso-8859-1?Q?03bXOTC4Bv3HT9XLQa97Fz1c5SNx1bhq8H6y85Isi0ICbrzslZlJ1IzUmF?=
 =?iso-8859-1?Q?AQwn0URdN2haRcgZtlSwe8OVUUH2LMBNdOmS/ODwlOUx6NzWxBIi10+4WX?=
 =?iso-8859-1?Q?/h1XXXJBWQkBr9YJM+a8Ur8KFl3vkWJ2uLFmf/n2Vg7NUGWbWLQ2bAx5iN?=
 =?iso-8859-1?Q?HuzAXIUBVNCuV1XLyLugKc1ezpEujRDyx/m0LzfGhjKDC3NdSDNO8L9pjD?=
 =?iso-8859-1?Q?bRhXUZ+KTT3PBSp5i4MuT4WVAIyt4R1OXF5K/TDeu0PTrZhLKz+thL+BL4?=
 =?iso-8859-1?Q?ujHFm6RE4OoM7YdnYmxVj4xZMRB3ZmRWCL3IN5FR3LE9WdWOUCZz7pShBI?=
 =?iso-8859-1?Q?bHI4=3D?=
x-microsoft-antispam-prvs: <AM5PR0401MB2450AF64531D60B0344F0E2AF1750@AM5PR0401MB2450.eurprd04.prod.outlook.com>
x-forefront-prvs: 0962D394D2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(346002)(396003)(376002)(39860400002)(189003)(199004)(110136005)(99286004)(66066001)(316002)(6486002)(54906003)(97736004)(105586002)(5660300002)(44832011)(71200400001)(476003)(11346002)(486006)(446003)(86362001)(106356001)(3846002)(6116002)(2616005)(71190400001)(1076003)(6512007)(102836004)(76176011)(53936002)(186003)(6436002)(256004)(4326008)(52116002)(26005)(6506007)(25786009)(386003)(36756003)(7736002)(305945005)(8676002)(81156014)(50226002)(14454004)(81166006)(478600001)(2906002)(8936002)(68736007)(41533002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0401MB2450;H:AM5PR0401MB2481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: i2pt7vVxH6jvXYnODok0jhYdxYJoCeXe4GRa+m7I5xGSV7ZfpSepMOkx1eJ8L30H9LD8E0iI1g5Fkpo75XLD4S0f0iTOLf+S+Ryo1ObTGcp/Sn7UaF5mfvOGJq3dmp+QjaXcn1Xxr/LJpHWyimtVCKPvacm3eFCooBFUn9LQDxEbojfZSU9EDpQAHtxh1uDVFYwFtn08V3dAbrN0baJbe5jLYncqLZPAv1uJ8oMt2OcIXKL36ii/RZNnkjXXFIXgtpxp3SKoN4RxyEZPzCURunV9bO06HWv28mZ9gDfrB/tLgU8fp11htD2DNQacVqvSjKbImh2wxLtVmagDO1PYZvTPXTbl7Ny1DWw2cJYstR3x/okngop5GVi4Sj4yCsQvhI0/FUIF50jE5GAW7o9LUjwC79oDU8mqEoq8D8rfgcU=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 297dc013-85ce-424b-e1de-08d69d80e5bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2019 13:30:26.0389
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0401MB2450
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Generic register bitfield-based multiplexer that controls the multiplexer
producer defined under a parent node.
The driver corresponding to parent node provides register read/write
capabilities.

Signed-off-by: Pankaj Bansal <pankaj.bansal@nxp.com>
---

Notes:
    V5:
    - No Change
    V4:
    - As per Peter's suggestion fixup the NULL from dev_get_regmap as early=
 as
      possible using ternary operator.
    V3:
    - Added the patch in series with device tree binding patch
    - Added the NULL return handling for regmap
    V2:
    - removed seperate driver regmap.c and added the regmap function in mmi=
o.c
      based on compatible field, the syscon or regmap function would be cal=
led
    - Modified the KConfig as per Peter's comments

 drivers/mux/Kconfig | 12 ++++++------
 drivers/mux/mmio.c  |  6 +++++-
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/mux/Kconfig b/drivers/mux/Kconfig
index 7659d6c5f718..e5c571fd232c 100644
--- a/drivers/mux/Kconfig
+++ b/drivers/mux/Kconfig
@@ -46,14 +46,14 @@ config MUX_GPIO
 	  be called mux-gpio.
=20
 config MUX_MMIO
-	tristate "MMIO register bitfield-controlled Multiplexer"
-	depends on (OF && MFD_SYSCON) || COMPILE_TEST
+	tristate "MMIO/Regmap register bitfield-controlled Multiplexer"
+	depends on OF || COMPILE_TEST
 	help
-	  MMIO register bitfield-controlled Multiplexer controller.
+	  MMIO/Regmap register bitfield-controlled Multiplexer controller.
=20
-	  The driver builds multiplexer controllers for bitfields in a syscon
-	  register. For N bit wide bitfields, there will be 2^N possible
-	  multiplexer states.
+	  The driver builds multiplexer controllers for bitfields in either
+	  a syscon register or a driver regmap register. For N bit wide
+	  bitfields, there will be 2^N possible multiplexer states.
=20
 	  To compile the driver as a module, choose M here: the module will
 	  be called mux-mmio.
diff --git a/drivers/mux/mmio.c b/drivers/mux/mmio.c
index 935ac44aa209..44a7a0e885b8 100644
--- a/drivers/mux/mmio.c
+++ b/drivers/mux/mmio.c
@@ -28,6 +28,7 @@ static const struct mux_control_ops mux_mmio_ops =3D {
=20
 static const struct of_device_id mux_mmio_dt_ids[] =3D {
 	{ .compatible =3D "mmio-mux", },
+	{ .compatible =3D "reg-mux", },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, mux_mmio_dt_ids);
@@ -43,7 +44,10 @@ static int mux_mmio_probe(struct platform_device *pdev)
 	int ret;
 	int i;
=20
-	regmap =3D syscon_node_to_regmap(np->parent);
+	if (of_device_is_compatible(np, "mmio-mux"))
+		regmap =3D syscon_node_to_regmap(np->parent);
+	else
+		regmap =3D dev_get_regmap(dev->parent, NULL) ?: ERR_PTR(-ENODEV);
 	if (IS_ERR(regmap)) {
 		ret =3D PTR_ERR(regmap);
 		dev_err(dev, "failed to get regmap: %d\n", ret);
--=20
2.17.1

