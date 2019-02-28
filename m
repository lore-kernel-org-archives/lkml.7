Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88E18C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49EA62171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:07:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ibln4QfG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732120AbfB1OH5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 09:07:57 -0500
Received: from mail-eopbgr10064.outbound.protection.outlook.com ([40.107.1.64]:6114
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728038AbfB1OH5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 09:07:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bnFr/PcJfJNe9hPf4DjhznYw5DO77dGjgAgyGrL+7k0=;
 b=Ibln4QfGcQdkOin72niUD8AuQUO93bQXhkGKhm/PZzOQV8GvN4U1DfDOVbvCG/XzQR8Zv/Dx9DY99/S2Oy1+fEMDiu0tEmH1dhox148tYGonmJWiIFLQB/TeIMpiaEp+VSoZhubMMYDlyDIhauD6BjED0VqscH4Uds55gqa6JLk=
Received: from AM5PR0401MB2481.eurprd04.prod.outlook.com (10.169.244.137) by
 AM5PR0401MB2532.eurprd04.prod.outlook.com (10.169.245.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.15; Thu, 28 Feb 2019 14:07:39 +0000
Received: from AM5PR0401MB2481.eurprd04.prod.outlook.com
 ([fe80::c48f:bcc2:39d5:ad4]) by AM5PR0401MB2481.eurprd04.prod.outlook.com
 ([fe80::c48f:bcc2:39d5:ad4%11]) with mapi id 15.20.1665.015; Thu, 28 Feb 2019
 14:07:39 +0000
From:   Pankaj Bansal <pankaj.bansal@nxp.com>
To:     Leo Li <leoyang.li@nxp.com>, Peter Rosin <peda@axentia.se>
CC:     Pankaj Bansal <pankaj.bansal@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 2/2] drivers: mux: Add Generic regmap bitfield-based
 multiplexer in mmio-mux
Thread-Topic: [PATCH v6 2/2] drivers: mux: Add Generic regmap bitfield-based
 multiplexer in mmio-mux
Thread-Index: AQHUz272SCrygd7YhkGtMFabrgI/qg==
Date:   Thu, 28 Feb 2019 14:07:39 +0000
Message-ID: <20190228193206.30594-2-pankaj.bansal@nxp.com>
References: <20190228193206.30594-1-pankaj.bansal@nxp.com>
In-Reply-To: <20190228193206.30594-1-pankaj.bansal@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BMXPR01CA0033.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:c::19) To AM5PR0401MB2481.eurprd04.prod.outlook.com
 (2603:10a6:203:36::9)
x-mailer: git-send-email 2.17.1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pankaj.bansal@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.120.1.69]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c4741b23-48be-4886-2b6a-08d69d861941
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM5PR0401MB2532;
x-ms-traffictypediagnostic: AM5PR0401MB2532:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;AM5PR0401MB2532;23:3ReGYx0EcQ3E8tUid7/x5dWkHUSFQJESQJ/47?=
 =?iso-8859-1?Q?+9Zvo/LPVB/lFJrYLfVZezXJywbL6ydWuSVR4hNz6Fs3d9GQRSIqSWNFKB?=
 =?iso-8859-1?Q?hSx7ytfd72rSbPmKMRk7yuuzZImOpJLPo5LHi9oF+gUfbvWdpv+BW6yHDg?=
 =?iso-8859-1?Q?Qg82Ju24b8NvgX60Q0LEMrVhni08+8BT/qV1ALGG0nZqw7ijVDy3upfnz/?=
 =?iso-8859-1?Q?zeshAvTifK0m9Am42bUvdBEaLfEpLT9xkfx43Yl5tyHcnCgTcUB/XMA5EO?=
 =?iso-8859-1?Q?nQmH9+kLLx+OMmlFnhcTSWCMVaTPCB0eysq3ULOqdI/9+RxsoC8AZpeiIE?=
 =?iso-8859-1?Q?KqdBnj/sOVe+jMqU5AqbY9wBNcAaZmEoPsfAVUVxZ4kn2JH1TKnoLFXFnS?=
 =?iso-8859-1?Q?wzXCTCrHINSzITycBQAPYgNVDNJwTLmYybwHNyWV5GiJe6U4Bl7QjOtxi2?=
 =?iso-8859-1?Q?1Pr1NC5zjbavBLLdXKBqhYEx1aRFfUT7LH2z9rC4MsHpKaUPM4KLM3vjpS?=
 =?iso-8859-1?Q?DafL4uU2jyNCkP/eUAqDJN7OPrLJSRkAtsinrfKADjPaRUhE9cFqX0/QFn?=
 =?iso-8859-1?Q?Z+n37tqwqSpwQfzzOabIshTyjXGqvspg1H+RyKhBjmKKxGxKwhrm/OGFZf?=
 =?iso-8859-1?Q?s4QVoLQNU8eN7EMdXiAaE6g+rRaIcNAdmxm7TC8cof7Q5XAkxPbuRhOMiW?=
 =?iso-8859-1?Q?WkbAlRSfE7J16giJWAGD4uXzZnkOOhTn4kDKpMZuLk7Opg9pwza33oPy1o?=
 =?iso-8859-1?Q?02s9qBA1rEoq3KZ6u8WJ4obX8spNaaLGMpWgqqEDN4SKMuQUYHminW6fsd?=
 =?iso-8859-1?Q?fAZr3ZCMq/mY8nDDdMIVXBZfGv8iyZXEaPxXeKoHGUGRSMc0Kap2WU7/Mu?=
 =?iso-8859-1?Q?eLZLWbTeHOQPC85G+2+xP1dmu8nhB166V97yZ1GS5iRiFN9v/2Lzovf7OJ?=
 =?iso-8859-1?Q?rXHhH8RkyWNR+/pz9dmsS7Umw4r+KqvlniYZi/LhzCA8QNOMngP0vWMEyc?=
 =?iso-8859-1?Q?etUPpgQOMn9SnQkaX2Iki+VvefuQhOpA8JEEnLdqQwVE7UHfyGEdI8r96h?=
 =?iso-8859-1?Q?n7OKcZop12xj7S68wqmyjuIrLgL2FgTyhSEgC5neXoz6LUldU2vbGDXOkn?=
 =?iso-8859-1?Q?pRZ22LAb9MnsOCzWMuxyARtAPqeq8DWc0F46JjzTKljJpBlrY12cYz01fZ?=
 =?iso-8859-1?Q?euG9wUR6tdbNXvTZrBEtR3pDc+GOirEa9/Ihi7JFIsHX1PEdZs75CoejCs?=
 =?iso-8859-1?Q?u7WflV0BzU1nBhIGuBFFw/TPpMhfq8fp4tu+fwlQO675KMlcuoizQkQsgn?=
 =?iso-8859-1?Q?91tc=3D?=
x-microsoft-antispam-prvs: <AM5PR0401MB253208D72F43818D0364125FF1750@AM5PR0401MB2532.eurprd04.prod.outlook.com>
x-forefront-prvs: 0962D394D2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(396003)(346002)(39860400002)(376002)(189003)(199004)(86362001)(8936002)(81166006)(81156014)(76176011)(52116002)(4326008)(305945005)(99286004)(3846002)(6116002)(2906002)(8676002)(36756003)(316002)(7736002)(25786009)(54906003)(110136005)(386003)(71190400001)(71200400001)(486006)(5660300002)(14454004)(66066001)(1076003)(44832011)(186003)(97736004)(6486002)(476003)(50226002)(26005)(53936002)(6512007)(106356001)(478600001)(68736007)(6506007)(105586002)(102836004)(2616005)(256004)(11346002)(6436002)(446003)(41533002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0401MB2532;H:AM5PR0401MB2481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: C8A293EgqHQQcgSk54MYv6QMGNj1CFntx/8Cg8Kj/qafp9X3vSg9oYS4SHQW7xNpwB2lF0RWJCQGSPpBlb+aJ8FnfTbWpp7zNvCLOn4J2T7OqhxGc1R2znuSJ4VoUFr+mWM4X0eslGYLM41W4khD/eOxVo7Bn/oN3BQD4us0DLBRkDuGXnlb4cqQi2jSknaJNzdYR8NjG/KCysU/TB3m5wBsFE9fet4zLOlmCf6jbT1i2zzf9C0zBySes1GCGu2AxiroxW3+0J3IenMVZXON+1XqfARiRvBbsZkfnoiEf3Rk3DNKco5i40Nk9wRFjs2vjd6Ku/aeIn72rkBq2MJwX9W+utop2jrT5htiFQEpKkt5BFGCNAIb6tBNkgovDqtahCD4TJiHZ5JiVmXCO6D7rdDns1NmzFe9Y0hAStjilYI=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4741b23-48be-4886-2b6a-08d69d861941
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2019 14:07:39.7796
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0401MB2532
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
    V6:
    - No Change
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

