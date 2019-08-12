Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 266CAC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 14:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E243E214C6
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 14:21:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="INoMzjSo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbfHLOVf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 10:21:35 -0400
Received: from mail-eopbgr150109.outbound.protection.outlook.com ([40.107.15.109]:32224
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728026AbfHLOVa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 10:21:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n6l1qihiyKSNmdpR/0jeN6IkCsHbx1FKkOtgX+JE4zNJix/yhlyfMNNpErXqeJG1aeTxBc2dvqc0QurvDwRreT+QEAYPRl3HLCRH/PKLd9i4RkixHDzg/7KXdzJUHfEhgFWImakCJD9vFiX3uwqihNR+eOdi45EHzri3Q11e3/2JveF1OKHIveUDPAgfMHLLETH7JQf2TIP8a6em2xaOxuF4+Csw440xfhPi2aDRhr7wO22SAp/YDznSClv/TPiuXzEpTbnJQDV7WOLYsoOb1kcGJbeDMjmhrdU+eS2UvS6M6fB8i31U1IQYxlT+AetEgVLKvWy33C4k/xPdhhiK/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0vbSgR25oYej+vyC/BecXfhmGZndDAqL0BVgREiPctw=;
 b=arK30CI09fInUIyXM68fX8mVBljZ3y+uYRfVhyO0xsp6fzPRjq5gJDwJqz9cypEn5n8foxH1rKBJWQOFBujXOLHvtjx2CSkMuAHm/rOprXixdcs8OrKAG1wPGL3NizLrI49KZWy16ULNQsNp/BdWmQ/VjSuB2f2sv7yuYbcd6VdjtvcNodukibm4RKQluiosYM3/3ppjwZj/QgkfyxU772CYpjFVcfxCGqTx2DhxmPXqrelZWRLUbM6u6lzpWkEa7CsXc9wsMJgcBwU9hdpVbdPB7VYyjXWQvBoXYaHIX911CU2DI1MRZXpKxS4NTSUiyt3q4RkRMQYWFzNcK/SSfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0vbSgR25oYej+vyC/BecXfhmGZndDAqL0BVgREiPctw=;
 b=INoMzjSolVAqV8dfJeD8GEEahjtbagRgy38zKTGYxGsS7EnBU96JrgXPMNqMqqQrpiySnQ7myJ/GBK6iBxuIgttW+Ry0rUU8akjTeGsk6AeFOwvMRb8FPNoVwTURhYZBERWF8pR3Xk+DbU8sb9JHLDYK3Ohy4WS0h99L6jvpjLg=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.17.157) by
 VI1PR0502MB2942.eurprd05.prod.outlook.com (10.175.26.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.21; Mon, 12 Aug 2019 14:21:21 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2%6]) with mapi id 15.20.2157.022; Mon, 12 Aug 2019
 14:21:21 +0000
From:   Philippe Schenker <philippe.schenker@toradex.com>
To:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?iso-8859-2?Q?Michal_Vok=E1=E8?= <michal.vokac@ysoft.com>,
        Fabio Estevam <festevam@gmail.com>
CC:     Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH v4 05/21] ARM: dts: imx7-colibri: add recovery for I2C for
 iMX7
Thread-Topic: [PATCH v4 05/21] ARM: dts: imx7-colibri: add recovery for I2C
 for iMX7
Thread-Index: AQHVURk2Uw5ESt/Pfk61M9kvOJGjAA==
Date:   Mon, 12 Aug 2019 14:21:21 +0000
Message-ID: <20190812142105.1995-6-philippe.schenker@toradex.com>
References: <20190812142105.1995-1-philippe.schenker@toradex.com>
In-Reply-To: <20190812142105.1995-1-philippe.schenker@toradex.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P194CA0055.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:803:3c::44) To VI1PR0502MB3965.eurprd05.prod.outlook.com
 (2603:10a6:803:23::29)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=philippe.schenker@toradex.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.22.0
x-originating-ip: [46.140.72.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2d14e5e4-58d1-4734-2f5b-08d71f305927
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR0502MB2942;
x-ms-traffictypediagnostic: VI1PR0502MB2942:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0502MB29426CB2B7BD7095FCEF337DF4D30@VI1PR0502MB2942.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:188;
x-forefront-prvs: 012792EC17
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(136003)(39840400004)(346002)(366004)(396003)(199004)(189003)(5660300002)(54906003)(110136005)(316002)(478600001)(6486002)(86362001)(2201001)(66066001)(53936002)(6116002)(1076003)(3846002)(2906002)(4326008)(25786009)(66446008)(64756008)(66556008)(66946007)(66476007)(6436002)(8676002)(11346002)(476003)(2616005)(446003)(256004)(81166006)(81156014)(2501003)(44832011)(6512007)(486006)(50226002)(71200400001)(71190400001)(7416002)(8936002)(36756003)(52116002)(7736002)(305945005)(99286004)(102836004)(386003)(14454004)(76176011)(186003)(6506007)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB2942;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Nu/vkf1dbL5shZEEuvd48NVNc7c0bzlV8gWeiihxZI8HSsrVtCzQ6Hdk+lS72TV8gufmZs9mwChTE/olnDdSkXGWPMpx0hf8JGQ/75zcIrjuOrW0sSHYCoDy5zpbA6LYkX4Hlw3psH1ogFsI+89QX8wzk/lDx11H2E7YfroqeBvugszfqGglHVmWz+e7I8dNqeZYd5GcPhPeZE5iC9tlaqtF4KcrTCG02LI2Kp0OicJNX+/+v10gbj3d8wh3KmJUwZmIQiXNOIZSLUNiGVSeTWRevCYwpQDmyNYW+hA3Axi8lRp3mwmUJPScLCEku+siYOEUNCb6AEgkdKleNaaUhxKO42adKeV3K8NJ+8h6S6dI1aj3O7wFO8Gdl7EQ6tLsrSVS3NaQ8iUzVx8kSAprqlrJlPyjTch6no5svAEXspk=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d14e5e4-58d1-4734-2f5b-08d71f305927
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2019 14:21:21.4703
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p9u94HAvqzKKIZsfFP15tDaSGJeHE7njq4y9Y3XVd5XY0amHtQHAtI1AkfsTc46erMCo0AzkctJUs8wH3o7IulsfE8Zt1WrUqBP3CmYjPyo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB2942
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>

- add recovery mode for applicable i2c buses for
  Colibri iMX7 module.

Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>

---

Changes in v4:
- Make scl-gpios and sda-gpios (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)
- Change commit title to Michal's suggestion

Changes in v3: None
Changes in v2: None

 arch/arm/boot/dts/imx7-colibri.dtsi | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx7-colibri.dtsi b/arch/arm/boot/dts/imx7-c=
olibri.dtsi
index a8d992f3e897..cab40d22d24e 100644
--- a/arch/arm/boot/dts/imx7-colibri.dtsi
+++ b/arch/arm/boot/dts/imx7-colibri.dtsi
@@ -140,8 +140,12 @@
=20
 &i2c1 {
 	clock-frequency =3D <100000>;
-	pinctrl-names =3D "default";
+	pinctrl-names =3D "default", "gpio";
 	pinctrl-0 =3D <&pinctrl_i2c1 &pinctrl_i2c1_int>;
+	pinctrl-1 =3D <&pinctrl_i2c1_recovery &pinctrl_i2c1_int>;
+	scl-gpios =3D <&gpio1 4 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios =3D <&gpio1 5 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+
 	status =3D "okay";
=20
 	codec: sgtl5000@a {
@@ -242,8 +246,11 @@
=20
 &i2c4 {
 	clock-frequency =3D <100000>;
-	pinctrl-names =3D "default";
+	pinctrl-names =3D "default", "gpio";
 	pinctrl-0 =3D <&pinctrl_i2c4>;
+	pinctrl-1 =3D <&pinctrl_i2c4_recovery>;
+	scl-gpios =3D <&gpio7 8 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios =3D <&gpio7 9 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 };
=20
 &lcdif {
@@ -540,6 +547,13 @@
 		>;
 	};
=20
+	pinctrl_i2c4_recovery: i2c4-recoverygrp {
+		fsl,pins =3D <
+			MX7D_PAD_ENET1_RGMII_TD2__GPIO7_IO8	0x4000007f
+			MX7D_PAD_ENET1_RGMII_TD3__GPIO7_IO9	0x4000007f
+		>;
+	};
+
 	pinctrl_lcdif_dat: lcdif-dat-grp {
 		fsl,pins =3D <
 			MX7D_PAD_LCD_DATA00__LCD_DATA0		0x79
@@ -740,6 +754,13 @@
 		>;
 	};
=20
+	pinctrl_i2c1_recovery: i2c1-recoverygrp {
+		fsl,pins =3D <
+			MX7D_PAD_LPSR_GPIO1_IO04__GPIO1_IO4	0x4000007f
+			MX7D_PAD_LPSR_GPIO1_IO05__GPIO1_IO5	0x4000007f
+		>;
+	};
+
 	pinctrl_cd_usdhc1: usdhc1-cd-grp {
 		fsl,pins =3D <
 			MX7D_PAD_LPSR_GPIO1_IO00__GPIO1_IO0	0x59 /* CD */
--=20
2.22.0

