Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 404F4C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 10:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEE7B206DD
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 10:08:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="OJEWGUn4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbfCEKIR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 05:08:17 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:23360 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbfCEKIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 05:08:15 -0500
X-IronPort-AV: E=Sophos;i="5.58,443,1544511600"; 
   d="scan'208";a="28727168"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 05 Mar 2019 03:08:15 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.105) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 5 Mar 2019 03:08:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W+HE41CyiCB05c1+dpayBAnxqXSg/ka725qhPH7sep8=;
 b=OJEWGUn4sN6MBIYyYCIEcvBwAOL1bwD96NFmCfT9HUZlEpCZj/hY5gvcGIi9pZNvNMD8iXwC3qu/h4ZArCS6DwE45u8NIePlvlvjKpY3iZYYOigtQD6IC08nyXlwiS2c6oQ3S3uhx8bO6QliFPx8ne3kOJ33sJlPgV5072k4ph4=
Received: from MWHPR11MB1549.namprd11.prod.outlook.com (10.172.54.17) by
 MWHPR11MB1647.namprd11.prod.outlook.com (10.172.55.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.21; Tue, 5 Mar 2019 10:08:11 +0000
Received: from MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::54fe:95ed:b0cf:55a6]) by MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::54fe:95ed:b0cf:55a6%9]) with mapi id 15.20.1665.020; Tue, 5 Mar 2019
 10:08:11 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <lee.jones@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>,
        <bbrezillon@kernel.org>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <thierry.reding@gmail.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linux-pwm@vger.kernel.org>, <Sandeep.Sheriker@microchip.com>,
        <Claudiu.Beznea@microchip.com>
Subject: [PATCH v2 7/7] drm: atmel-hlcdc: add sam9x60 LCD controller
Thread-Topic: [PATCH v2 7/7] drm: atmel-hlcdc: add sam9x60 LCD controller
Thread-Index: AQHU0ztWsecK/da2U0+4KoK8RYPaoA==
Date:   Tue, 5 Mar 2019 10:08:11 +0000
Message-ID: <1551780434-4580-8-git-send-email-claudiu.beznea@microchip.com>
References: <1551780434-4580-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1551780434-4580-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0502CA0011.eurprd05.prod.outlook.com
 (2603:10a6:803:1::24) To MWHPR11MB1549.namprd11.prod.outlook.com
 (2603:10b6:301:c::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 86ec419d-02b2-4943-fa98-08d6a1527909
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB1647;
x-ms-traffictypediagnostic: MWHPR11MB1647:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;MWHPR11MB1647;23:KuDGC6htkbBka4uCi+d6Otr6Tjz3fZljgwc8dOT?=
 =?iso-8859-1?Q?LZBSVnhK+IQVqN2lSECLluTLuFr6HVUmYKV28UmuVz8dOoZf0NP6bXN3KC?=
 =?iso-8859-1?Q?nM9C/5EMbGAW9P2oEBwu9JCzkCAVpsb+ClWLRT8dD9+Ljg3AzEnNwN3n7N?=
 =?iso-8859-1?Q?HL3X0ByRYqqNs7aP7OD173/zlKYGtwzTpMX1Yz8OCgHX8t7Mz2mOanu6x9?=
 =?iso-8859-1?Q?jfTguvKfVIun8+yzqpkNAtmKcPUXdn40QHutpc+92LBrQ+ztpISoymAzVA?=
 =?iso-8859-1?Q?Wg8OjMXSEBIizJonJ1LR9SaAJPFO8+GCf1kNW1y+YiYnbLPpRGqWVmThnW?=
 =?iso-8859-1?Q?PtuEzw/0JEN8e3EzYNIY/R6tboMSqRBV8k8rhZNr43uv9lBBbBCpi6qJqi?=
 =?iso-8859-1?Q?dGoCK7+IvXsoN3+vA+n4GWFRKIc94k4/lYZD7F2bLbcas4B4md0A8qge3i?=
 =?iso-8859-1?Q?LtNopRVZOIo2XlpUGTqnxcr69w0PrlsCizpUDY8sZbKDWVFjDGZ7UY13R1?=
 =?iso-8859-1?Q?EVfbgFxbmFn0WEA4ep4Ki17CWOFeaPkKClpvTMnhCbegvF51kXX6du1x0+?=
 =?iso-8859-1?Q?ExIMO0LOSge58O4glZn+CSbFa+hV1voymxAbCUBwT8XU1DMM6iWbCmW3eW?=
 =?iso-8859-1?Q?YAi1uWrtRf9otrHwRPmpx++StE6Hon7nqkpJmrIYWzZdR/vFsOIIkXFgLY?=
 =?iso-8859-1?Q?M5qjKSw8OxiKLKUrO8mAnCETNgeHeYdaG2JpqD8VTY4sFl+QOpfZIwPn22?=
 =?iso-8859-1?Q?I4M+0CQUlUmoJqaTYXzfxEDKh9m2FH5H07G8E/cqUg6L9+rGyAc5QGf2dF?=
 =?iso-8859-1?Q?FfB7nfhsMMXfMkVBO/EkK+AJiaMKsyvv7jBY2BYJsRansFJIR27VLzWX3m?=
 =?iso-8859-1?Q?3lwtujGm0lvasNsBbnfjEC4nF2qEmEhvMCM1uz9zHPD/fMwjEKsIpuEmKS?=
 =?iso-8859-1?Q?69/NYEYqyg/F62yXn0gpMUW+ZcxoA3TVc6c6ezHL3BL3xBwFurouyEPTCi?=
 =?iso-8859-1?Q?V81y2OVXRmhU+M47lWYKT7szAPBC02ifrb9sL/ctJlWekdSFDU2AcAdb6f?=
 =?iso-8859-1?Q?13bbspUXDFCv2odVd2SPqxM6nLncVsRahS+/9oYqsyPS++VATCb3dhuu9c?=
 =?iso-8859-1?Q?lE2l+CtYhRqSyf/lj6wcllIxI+cuWz+8zO+hPYC3Vz+s4VukrssgjTDqvI?=
 =?iso-8859-1?Q?3CK0XK4SaBbVjiGbwCybBq3li8C+nLlx00nqnLuC0lEfooORa6oXUxlg4n?=
 =?iso-8859-1?Q?kjkWHQivWcK7Di10epSvShlMlDYVXo40g3kTIkv72GrOcXsHAfy08ckVE6?=
 =?iso-8859-1?Q?l+BXkcR5CEMUhLWjmsBqCr/up74+X0V7ZveAppxdjfLx/OVuPvoZsXAb1B?=
 =?iso-8859-1?Q?19SaOEyI=3D?=
x-microsoft-antispam-prvs: <MWHPR11MB164737FE33372EB9992A472187720@MWHPR11MB1647.namprd11.prod.outlook.com>
x-forefront-prvs: 0967749BC1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(39860400002)(346002)(136003)(366004)(199004)(189003)(106356001)(72206003)(3846002)(99286004)(81156014)(52116002)(36756003)(76176011)(14454004)(81166006)(66066001)(8676002)(110136005)(6116002)(105586002)(6486002)(7736002)(5660300002)(8936002)(305945005)(25786009)(102836004)(54906003)(97736004)(316002)(2906002)(7416002)(2501003)(2616005)(186003)(71190400001)(6506007)(386003)(256004)(476003)(68736007)(11346002)(71200400001)(6512007)(2201001)(107886003)(53936002)(446003)(50226002)(486006)(4326008)(86362001)(6436002)(478600001)(26005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1647;H:MWHPR11MB1549.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: YEb/z9VzKiG+ejqHmETDzVmNWyQLPp/IIn0vRYDqamnNot7Q15zh/mz524ahq33Vg2B2KI+mVj3jMpvDJQXZGepJs47lU2ZpHJvNBYag6zmrUKziOlNzdEhhysoUM6WZvMYPOGSCB4ziH821UtbZ+wd1KTvb/ffypC03s0uyL952ikcs3zjP7Xfpmio5kdFIK5d6OyydLXS9foyLzmGGTiylKGLqyFt+bYzTRnBazcGV+5Gqjx9CTO633WTYrD6VXQV/fIlQAmkD2j0HjuEqSECP3Q49swe8i1/7rD48/I7DowJUZHH3eZ/jjGTFBBH081k4djMnC6eiy2OvUvTbaSjIAHNGimGAaEh8O0SEjTPxe4teN96JsnImIIf2xGg673zy8E7TMwgrMe+MEBz8eGulVEbSQxgGquLSKmbe0Ww=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 86ec419d-02b2-4943-fa98-08d6a1527909
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2019 10:08:11.3024
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1647
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sandeep Sheriker Mallikarjun <sandeepsheriker.mallikarjun@microchip.c=
om>

Add the LCD controller for SAM9X60.

Signed-off-by: Sandeep Sheriker Mallikarjun <sandeepsheriker.mallikarjun@mi=
crochip.com>
[claudiu.beznea@microchip.com: add fixed_clksrc option to
 atmel_hlcdc_dc_sam9x60]
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c | 101 +++++++++++++++++++++++=
++++
 1 file changed, 101 insertions(+)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c b/drivers/gpu/drm=
/atmel-hlcdc/atmel_hlcdc_dc.c
index 8bf51f853721..fb2e7646daeb 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
@@ -364,6 +364,103 @@ static const struct atmel_hlcdc_dc_desc atmel_hlcdc_d=
c_sama5d4 =3D {
 	.nlayers =3D ARRAY_SIZE(atmel_hlcdc_sama5d4_layers),
 	.layers =3D atmel_hlcdc_sama5d4_layers,
 };
+
+static const struct atmel_hlcdc_layer_desc atmel_hlcdc_sam9x60_layers[] =
=3D {
+	{
+		.name =3D "base",
+		.formats =3D &atmel_hlcdc_plane_rgb_formats,
+		.regs_offset =3D 0x60,
+		.id =3D 0,
+		.type =3D ATMEL_HLCDC_BASE_LAYER,
+		.cfgs_offset =3D 0x2c,
+		.layout =3D {
+			.xstride =3D { 2 },
+			.default_color =3D 3,
+			.general_config =3D 4,
+			.disc_pos =3D 5,
+			.disc_size =3D 6,
+		},
+		.clut_offset =3D 0x600,
+	},
+	{
+		.name =3D "overlay1",
+		.formats =3D &atmel_hlcdc_plane_rgb_formats,
+		.regs_offset =3D 0x160,
+		.id =3D 1,
+		.type =3D ATMEL_HLCDC_OVERLAY_LAYER,
+		.cfgs_offset =3D 0x2c,
+		.layout =3D {
+			.pos =3D 2,
+			.size =3D 3,
+			.xstride =3D { 4 },
+			.pstride =3D { 5 },
+			.default_color =3D 6,
+			.chroma_key =3D 7,
+			.chroma_key_mask =3D 8,
+			.general_config =3D 9,
+		},
+		.clut_offset =3D 0xa00,
+	},
+	{
+		.name =3D "overlay2",
+		.formats =3D &atmel_hlcdc_plane_rgb_formats,
+		.regs_offset =3D 0x260,
+		.id =3D 2,
+		.type =3D ATMEL_HLCDC_OVERLAY_LAYER,
+		.cfgs_offset =3D 0x2c,
+		.layout =3D {
+			.pos =3D 2,
+			.size =3D 3,
+			.xstride =3D { 4 },
+			.pstride =3D { 5 },
+			.default_color =3D 6,
+			.chroma_key =3D 7,
+			.chroma_key_mask =3D 8,
+			.general_config =3D 9,
+		},
+		.clut_offset =3D 0xe00,
+	},
+	{
+		.name =3D "high-end-overlay",
+		.formats =3D &atmel_hlcdc_plane_rgb_and_yuv_formats,
+		.regs_offset =3D 0x360,
+		.id =3D 3,
+		.type =3D ATMEL_HLCDC_OVERLAY_LAYER,
+		.cfgs_offset =3D 0x4c,
+		.layout =3D {
+			.pos =3D 2,
+			.size =3D 3,
+			.memsize =3D 4,
+			.xstride =3D { 5, 7 },
+			.pstride =3D { 6, 8 },
+			.default_color =3D 9,
+			.chroma_key =3D 10,
+			.chroma_key_mask =3D 11,
+			.general_config =3D 12,
+			.scaler_config =3D 13,
+			.phicoeffs =3D {
+				.x =3D 17,
+				.y =3D 33,
+			},
+			.csc =3D 14,
+		},
+		.clut_offset =3D 0x1200,
+	},
+};
+
+static const struct atmel_hlcdc_dc_desc atmel_hlcdc_dc_sam9x60 =3D {
+	.min_width =3D 0,
+	.min_height =3D 0,
+	.max_width =3D 2048,
+	.max_height =3D 2048,
+	.max_spw =3D 0xff,
+	.max_vpw =3D 0xff,
+	.max_hpw =3D 0x3ff,
+	.fixed_clksrc =3D true,
+	.nlayers =3D ARRAY_SIZE(atmel_hlcdc_sam9x60_layers),
+	.layers =3D atmel_hlcdc_sam9x60_layers,
+};
+
 static const struct of_device_id atmel_hlcdc_of_match[] =3D {
 	{
 		.compatible =3D "atmel,at91sam9n12-hlcdc",
@@ -385,6 +482,10 @@ static const struct of_device_id atmel_hlcdc_of_match[=
] =3D {
 		.compatible =3D "atmel,sama5d4-hlcdc",
 		.data =3D &atmel_hlcdc_dc_sama5d4,
 	},
+	{
+		.compatible =3D "microchip,sam9x60-hlcdc",
+		.data =3D &atmel_hlcdc_dc_sam9x60,
+	},
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, atmel_hlcdc_of_match);
--=20
2.7.4

