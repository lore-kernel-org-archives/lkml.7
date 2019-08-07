Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48334C19759
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 08:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14014229F5
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 08:26:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="H5nySGIQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729215AbfHGI0a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 04:26:30 -0400
Received: from mail-eopbgr40137.outbound.protection.outlook.com ([40.107.4.137]:35606
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729088AbfHGI02 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 04:26:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ktpFhSHxwlBRkNI06VK5nAlO/3ZeREopdxmASqz2tSkFeMtSACJJEZ+cxvCTIyJ2EQaFl/aFOR2wvhkFTg5BGMmJPgs8nZ3dphGo1EPT2O9culEik1UU83NorhXpWpsyMhrVQwDWKictT0HE9ks6r/PsOtxV5mlVfEz6TX88mEx7cHlFXglQMyRbk+g+LAWQFaIM/uq11MZnpInURRAtjJdB3Uz6CF7NAn2zgC1J9129Ul53jsyEL12KqHYMEK+HVpegJRFqC2d7TWORe/aF4KgWmIeXfvIBgOG0l1GaxW5JSVSfnKQdydMum1BodX/49rm8jZo1ppJYfUn4Ww9Fyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tybhqeOF4fZssoHdu14wtOn6a6G8MyqgshtOhrxnAMI=;
 b=Due3JJAtSv3Xsd+ebT79FqHi58XpnlYx0rpQUuU5ZRxvH+EojE7kcqjO5nihgyeOA/wBfKhFRgz4bZqV4li4H/LYXUmJP8uVPEdrkdWoW9KW0eQ2ykJkPKonKfZLXx4eHHkCppsZxAYeSih79l8tVOLZXMk/N5NdvbsXDGOGV04JNVH/12Rc0QM6/dQl0J+PugOS3GirqGDY1zY/bUCoB2jZOX5DbW43VNdm6CUKLaFhd/PtudVSUCnVk8hfo7iXblJLsWL8R8zO62ZK0mhp8LGLeKlOhh0ANdFHoQZyyrHkZ3W8BTu5ArnhKIAipYAuJUdCRMPtfaCD/QwNYXcfmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=toradex.com;dmarc=pass action=none
 header.from=toradex.com;dkim=pass header.d=toradex.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tybhqeOF4fZssoHdu14wtOn6a6G8MyqgshtOhrxnAMI=;
 b=H5nySGIQ2MuhJ6k8x9MVhEs/3BKNL5dPbiCZIBTsjKnyiIWX084DfuZBDcgK3/i3rJiu2D3M22yvoFtUEdOEvhVs8t1xX9DN6JHNQj5FUbmObAnELKSgMt586crrTU3/9+/OyrVFSp79SZ4KnRYYU6p6e5h8QRvX+iRfFEc8yyc=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.17.157) by
 VI1PR0502MB3614.eurprd05.prod.outlook.com (52.134.7.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.16; Wed, 7 Aug 2019 08:26:17 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2%6]) with mapi id 15.20.2157.015; Wed, 7 Aug 2019
 08:26:17 +0000
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
CC:     Stefan Agner <stefan.agner@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH v3 06/21] ARM: dts: imx7-colibri: add GPIO wakeup key
Thread-Topic: [PATCH v3 06/21] ARM: dts: imx7-colibri: add GPIO wakeup key
Thread-Index: AQHVTPnIH+pC0dkadkScKPC1LLl3mQ==
Date:   Wed, 7 Aug 2019 08:26:17 +0000
Message-ID: <20190807082556.5013-7-philippe.schenker@toradex.com>
References: <20190807082556.5013-1-philippe.schenker@toradex.com>
In-Reply-To: <20190807082556.5013-1-philippe.schenker@toradex.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM4PR0101CA0044.eurprd01.prod.exchangelabs.com
 (2603:10a6:200:41::12) To VI1PR0502MB3965.eurprd05.prod.outlook.com
 (2603:10a6:803:23::29)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=philippe.schenker@toradex.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.22.0
x-originating-ip: [46.140.72.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: db49f099-a24c-45de-fbfc-08d71b10eb24
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR0502MB3614;
x-ms-traffictypediagnostic: VI1PR0502MB3614:
x-microsoft-antispam-prvs: <VI1PR0502MB361475F8363A864D55DF3402F4D40@VI1PR0502MB3614.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 01221E3973
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(376002)(396003)(39850400004)(136003)(366004)(199004)(189003)(305945005)(14444005)(6116002)(26005)(81156014)(76176011)(36756003)(3846002)(6486002)(86362001)(6512007)(478600001)(25786009)(71190400001)(2906002)(7416002)(81166006)(256004)(316002)(71200400001)(2201001)(44832011)(53936002)(7736002)(110136005)(8936002)(54906003)(52116002)(66446008)(64756008)(14454004)(99286004)(476003)(102836004)(8676002)(6436002)(1076003)(66556008)(5660300002)(6506007)(2501003)(4326008)(66946007)(486006)(446003)(11346002)(66066001)(68736007)(50226002)(186003)(66476007)(2616005)(386003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB3614;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: DuKUqfaxjdKFlCtGnE/yCgTQHNm+BIyxhvBAmqp8zIsHnn6/m0vivmu8ETmAk6H3cgveIz76kwktxxuYQonhPCI2NDo2YdLB0n4tT/KXwAgO3Q+npk10CoM9GA7niIQLKSFsTPlMP5+Q8Oo8AFQ6vhUqcX/2VcwagB1//Sm4DcnDYBcw+kHK8FJgiavq0hBB3vHiP3PbktBvbhuJTu5YB7PwiJKrN7YT/nBLDGzVuJlJCGdU7WcQrEiFgA75ZKW9bn5gOsCAsMz0e5+IiDfRwIryC/PHe4zYvYm21zYFyjJGqM6S0Pbb5JiIj/EbS/BAwjcV3+zzH/OnndKticWL3wMroRuusYU0rn0qxnal3N1cKEof5zED+ZOgWMJ1xp/CPJN663yOHmlP+S/rnWczBZkxjGA6q0JFrBB123Au8vk=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db49f099-a24c-45de-fbfc-08d71b10eb24
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2019 08:26:17.7119
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W3vD0bXlGXmWlORWNi93G/EONSAHaDNefT2WX3Xz44VLSMInhz8PB5r2/gqa4FEoATgJsOm3J3uzpfVN5npFqkfRGkP5s6JpYo3i/caztdM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB3614
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Agner <stefan.agner@toradex.com>

Add wakeup GPIO key which is able to wake the system from sleep
modes (e.g. Suspend-to-Memory).

Signed-off-by: Stefan Agner <stefan.agner@toradex.com>
Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
---

Changes in v3: None
Changes in v2: None

 arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi | 14 ++++++++++++++
 arch/arm/boot/dts/imx7-colibri.dtsi         |  7 ++++++-
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi b/arch/arm/boot/dt=
s/imx7-colibri-eval-v3.dtsi
index 3f2746169181..d4dbc4fc1adf 100644
--- a/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
+++ b/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
@@ -52,6 +52,20 @@
 		clock-frequency =3D <16000000>;
 	};
=20
+	gpio-keys {
+		compatible =3D "gpio-keys";
+		pinctrl-names =3D "default";
+		pinctrl-0 =3D <&pinctrl_gpiokeys>;
+
+		power {
+			label =3D "Wake-Up";
+			gpios =3D <&gpio1 1 GPIO_ACTIVE_HIGH>;
+			linux,code =3D <KEY_WAKEUP>;
+			debounce-interval =3D <10>;
+			gpio-key,wakeup;
+		};
+	};
+
 	panel: panel {
 		compatible =3D "edt,et057090dhu";
 		backlight =3D <&bl>;
diff --git a/arch/arm/boot/dts/imx7-colibri.dtsi b/arch/arm/boot/dts/imx7-c=
olibri.dtsi
index 2480623c92ff..16d1a1ed1aff 100644
--- a/arch/arm/boot/dts/imx7-colibri.dtsi
+++ b/arch/arm/boot/dts/imx7-colibri.dtsi
@@ -741,12 +741,17 @@
=20
 	pinctrl_gpio_lpsr: gpio1-grp {
 		fsl,pins =3D <
-			MX7D_PAD_LPSR_GPIO1_IO01__GPIO1_IO1	0x59
 			MX7D_PAD_LPSR_GPIO1_IO02__GPIO1_IO2	0x59
 			MX7D_PAD_LPSR_GPIO1_IO03__GPIO1_IO3	0x59
 		>;
 	};
=20
+	pinctrl_gpiokeys: gpiokeysgrp {
+		fsl,pins =3D <
+			MX7D_PAD_LPSR_GPIO1_IO01__GPIO1_IO1	0x19
+		>;
+	};
+
 	pinctrl_i2c1: i2c1-grp {
 		fsl,pins =3D <
 			MX7D_PAD_LPSR_GPIO1_IO05__I2C1_SDA	0x4000007f
--=20
2.22.0

