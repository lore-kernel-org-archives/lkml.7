Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A309CC3A5A4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 13:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71B4C2186A
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 13:18:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="KvUlnM2F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730183AbfH0NSr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 09:18:47 -0400
Received: from mail-eopbgr50112.outbound.protection.outlook.com ([40.107.5.112]:14974
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730065AbfH0NSn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 09:18:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MItVBUat7okZNtPavdoYoo2s2REEBTAm+Mq+g1+acivH5RQvNXAkQqr3hxAEMRugcYs7ZRKfAoZkx65C53vztBfK1iYbuc8KjuMBM9ZhXwsRnRN1BBZ/Xw/MqEsZdXB8+v+ngpxjrVXZx3fsyr0h8ns6bbe+0mlieFRHipSMxGkq1IjUuUg94+dgVxI3+cBK3egkox4VPDTttu1ww769y3ExemLc8329berQsZWu6VnEGHjF+yAX6WTQU/PLvXOKZG1rYYmHt72MHfeEOjFZck8O835udhbb/1wwnKdimAcdPOuIf+O9MVPzPjN3Kqccs2dgpHu60zKETrOiJ0soAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XemcFVYV5bRq/jjtYhlqGjLL4YszM2Q30lZLXK2SajE=;
 b=UvkBZigz3d6ZoWCUINhKK/OgFiIQIu8w8E1Rl8ttwc1HiG3eNGSqHepTCE3hChNzeMVk6h/8iubXXjx1GQSwlBseTWZy6fCQ0tcu3wW8cfBYkbyVkDoJRRCu1wahKdFCllqut7lID6YuqW53Ss0AZOGoNb/8LgMHVBqdG8zIxUrZHAheUcPDBjjyYnn0wHlsFnOeMFMKV+Z6TBLj1fFe66l84hX1CQ2IKt1cfNLrza+R692L95p08hwbj950tOLKSbaNOQxgBZRnpTl4JfmFj/VUo210i+VKqAHJX16p1A8U6JWKM8l2DTTsS777ZRMfQArd/nSx44vTVNMqgymfLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XemcFVYV5bRq/jjtYhlqGjLL4YszM2Q30lZLXK2SajE=;
 b=KvUlnM2FfNpd/nA4tbkiq93Wo/VWuajmUu9h88rjw9WPlFiNUgvMzYmiCKFxFXybn1yj5C95hquZ0ycFC7qNkEfSLMwO7/GOccMA4JLr2VEoY9MWxOeUxcF70QPSUQXdLxQ0jBAbd8BHZEtHfe16SuX/rICGu3Xi8X+G2jVeZeo=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.17.157) by
 VI1PR0502MB3872.eurprd05.prod.outlook.com (52.134.5.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Tue, 27 Aug 2019 13:18:32 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::f59f:a307:9c53:63b9]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::f59f:a307:9c53:63b9%6]) with mapi id 15.20.2199.021; Tue, 27 Aug 2019
 13:18:32 +0000
From:   Philippe Schenker <philippe.schenker@toradex.com>
To:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        "stefan @ agner . ch" <stefan@agner.ch>,
        "devicetree @ vger . kernel . org" <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?iso-8859-2?Q?Michal_Vok=E1=E8?= <michal.vokac@ysoft.com>,
        Fabio Estevam <festevam@gmail.com>
CC:     Philippe Schenker <philippe.schenker@toradex.com>,
        Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH v5 08/13] ARM: dts: imx6ull-colibri: Add sleep mode to fec
Thread-Topic: [PATCH v5 08/13] ARM: dts: imx6ull-colibri: Add sleep mode to
 fec
Thread-Index: AQHVXNnsQ+HoqCbh/0yS1FQhsuRmrw==
Date:   Tue, 27 Aug 2019 13:18:32 +0000
Message-ID: <20190827131806.6816-9-philippe.schenker@toradex.com>
References: <20190827131806.6816-1-philippe.schenker@toradex.com>
In-Reply-To: <20190827131806.6816-1-philippe.schenker@toradex.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR0102CA0031.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:14::44) To VI1PR0502MB3965.eurprd05.prod.outlook.com
 (2603:10a6:803:23::29)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=philippe.schenker@toradex.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.23.0
x-originating-ip: [46.140.72.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c13bb7cb-8770-472d-a1bc-08d72af10f18
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR0502MB3872;
x-ms-traffictypediagnostic: VI1PR0502MB3872:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0502MB38728C5E12ADEE9C06F1D2E3F4A00@VI1PR0502MB3872.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 0142F22657
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(376002)(366004)(136003)(346002)(39850400004)(189003)(199004)(8936002)(66946007)(2906002)(11346002)(5660300002)(50226002)(54906003)(110136005)(316002)(14454004)(1076003)(14444005)(256004)(64756008)(6506007)(386003)(7736002)(478600001)(36756003)(53936002)(66556008)(6116002)(66066001)(66446008)(3846002)(6436002)(76176011)(476003)(2616005)(446003)(486006)(6512007)(26005)(305945005)(102836004)(6486002)(71200400001)(186003)(8676002)(86362001)(81166006)(4326008)(71190400001)(81156014)(66476007)(25786009)(99286004)(7416002)(52116002)(44832011)(32563001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB3872;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Hd0eRJ+18MoULs8By7unWGkpi8gX5LH+n2HuI90EtATsq4eMLvK8L9AeH4gDFhuBWG+LhtiaCG6qDiJUVJoXBak05Zs4DMRpNP3FusbyeUDCIgnxiXeH8mrjThgVJi2H7Idn3ylClYsf0sHbc+Z6iIvKgt6uBd88dCUJqmxZirO+3HXYgArTUyPfUPf9Yp22AWbtP+lwV0SUpx8rf8n0U/KoVRk6J+unM3SWy0hMnlq07Xo2cZcenoc1G2LdLSj6y8HEL/cplQ/1jHMl4M73PanESN2lo53Bdy6au8hiQqReo9Z4RP5BhIHy20uhL3oS92y/XjRaqoFb9gXnGMthuEMy4JrFVPlJOqUIOs4Xy5VNKg4uRUvLQKB/RYFGbF1stpeRzTMB/deohdGSxjhQvPuw+nDLMmlaq1Vt2hWOtyw=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c13bb7cb-8770-472d-a1bc-08d72af10f18
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2019 13:18:32.7060
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kxVh420Kz9EApC3PS1mTYo8SAs9elB3fgt2yq2BMEf7uPt3jeHNhy7ijPF/1q8JvqBa/hOMovft8MujcWEaPbyV76GZSMKMINDvbqt+/KP8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB3872
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not change the clock as the power for this phy is switched
with that clock.

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
Acked-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Reviewed-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>

---

Changes in v5:
- Added Olek's Reviewed-by

Changes in v4:
- Add Marcel Ziswiler's Ack

Changes in v3: None
Changes in v2: None

 arch/arm/boot/dts/imx6ull-colibri.dtsi | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6ull-colibri.dtsi b/arch/arm/boot/dts/imx=
6ull-colibri.dtsi
index d56728f03c35..1019ce69a242 100644
--- a/arch/arm/boot/dts/imx6ull-colibri.dtsi
+++ b/arch/arm/boot/dts/imx6ull-colibri.dtsi
@@ -62,8 +62,9 @@
 };
=20
 &fec2 {
-	pinctrl-names =3D "default";
+	pinctrl-names =3D "default", "sleep";
 	pinctrl-0 =3D <&pinctrl_enet2>;
+	pinctrl-1 =3D <&pinctrl_enet2_sleep>;
 	phy-mode =3D "rmii";
 	phy-handle =3D <&ethphy1>;
 	status =3D "okay";
@@ -220,6 +221,21 @@
 		>;
 	};
=20
+	pinctrl_enet2_sleep: enet2sleepgrp {
+		fsl,pins =3D <
+			MX6UL_PAD_GPIO1_IO06__GPIO1_IO06	0x0
+			MX6UL_PAD_GPIO1_IO07__GPIO1_IO07	0x0
+			MX6UL_PAD_ENET2_RX_DATA0__GPIO2_IO08	0x0
+			MX6UL_PAD_ENET2_RX_DATA1__GPIO2_IO09	0x0
+			MX6UL_PAD_ENET2_RX_EN__GPIO2_IO10	0x0
+			MX6UL_PAD_ENET2_RX_ER__GPIO2_IO15	0x0
+			MX6UL_PAD_ENET2_TX_CLK__ENET2_REF_CLK2	0x4001b031
+			MX6UL_PAD_ENET2_TX_DATA0__GPIO2_IO11	0x0
+			MX6UL_PAD_ENET2_TX_DATA1__GPIO2_IO12	0x0
+			MX6UL_PAD_ENET2_TX_EN__GPIO2_IO13	0x0
+		>;
+	};
+
 	pinctrl_ecspi1_cs: ecspi1-cs-grp {
 		fsl,pins =3D <
 			MX6UL_PAD_LCD_DATA21__GPIO3_IO26	0x000a0
--=20
2.23.0

