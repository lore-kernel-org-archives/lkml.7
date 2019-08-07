Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB7DDC433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 08:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 766C9217F4
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 08:26:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="GXrWcLzU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387774AbfHGI04 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 04:26:56 -0400
Received: from mail-eopbgr130117.outbound.protection.outlook.com ([40.107.13.117]:6210
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387737AbfHGI0v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 04:26:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ia7d2hRX3uDgJChaBMnT83iXQPHSVgo25N7FX8HS57Pw8StKNuo8OJBUO8G5LBNA3MUxfKwKy3srIFXWnQlfW7UlrIzDj1Xwg7jLxTxKDmYEGh9Fs3q0ZYHLYyvI88zAnJyPBTlXFrdG4wmyNWMNMaooOkmdltmXEtuQ4d2BaokUQNBJzzLFT41Kr2STTXG/dVHplpBVRDTTnBNIX4zW7VUvS01qCjOcu4yXUSvS4R6Ja98o/AUOR1EVfSnZdG5il5aora8mr5qLkTNG/hYp6CqVToP210WxNTeg2rYH48QvJi5GZsys68mfru8Y787Xqy9GnAyKhFphrSOUc6NLlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L2+wI3VLlhtkbpyTM8u8OmWHtF9m0yE4P+D3JprtO8s=;
 b=b+NSQgNUyGHJ8As2buYrRI2z+4tuKm50i+KNtnf4Fy4f4hMT8lKUR0WMO4R4AwrXMJJ4dQl4aHZrZKiLeuEZG0PQAu0mE2d9zn96ANKWctI2Hqy5M1Zlyg03eSOjt06Ya+dNJG2FIxhoD9gUiKAGduCILrC5ToBPBspCVa/rL/QpzyLGqduK8BQ2i6SuwFu9HBM5uNVbcIPpKhCruCdT3zTiRi5+FMznBoZY5Hjn/wbQ1a3fFyVAc3bunwJpaXfLRiBJmzW3NyEqLrbF361HisschMDD+roAxa5Jt5xGkWyrGJCoVldCfyqPrzu1e4SPXDLynyH9SPqc+FN17a1PMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=toradex.com;dmarc=pass action=none
 header.from=toradex.com;dkim=pass header.d=toradex.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L2+wI3VLlhtkbpyTM8u8OmWHtF9m0yE4P+D3JprtO8s=;
 b=GXrWcLzUtjMWSthHOQXtgILV2BG0TI14bZSeekLDTJUbQBB7SLmwI5la3UHUlfAJ1oUyIsoC7gEZIfPBjQigtbBFyny/cG/ejB78+uqJEYjlzTEk7uKpMe66YuPwYzYzFvdMeL8njU3wuupPrLXJWg+X/EAYEyP064TnvO03rnw=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.17.157) by
 VI1PR0502MB3614.eurprd05.prod.outlook.com (52.134.7.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.16; Wed, 7 Aug 2019 08:26:47 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2%6]) with mapi id 15.20.2157.015; Wed, 7 Aug 2019
 08:26:47 +0000
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
CC:     Philippe Schenker <philippe.schenker@toradex.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH v3 20/21] ARM: dts: imx6ull-colibri: Add touchscreen used with
 Eval Board
Thread-Topic: [PATCH v3 20/21] ARM: dts: imx6ull-colibri: Add touchscreen used
 with Eval Board
Thread-Index: AQHVTPnauiw8XawvRE+YnPE86awA4w==
Date:   Wed, 7 Aug 2019 08:26:46 +0000
Message-ID: <20190807082556.5013-21-philippe.schenker@toradex.com>
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
x-ms-office365-filtering-correlation-id: 7db6327a-0899-4e26-fbc7-08d71b10fc9b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR0502MB3614;
x-ms-traffictypediagnostic: VI1PR0502MB3614:
x-microsoft-antispam-prvs: <VI1PR0502MB3614D47537DBAACF62B898ABF4D40@VI1PR0502MB3614.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 01221E3973
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(376002)(396003)(39850400004)(136003)(366004)(199004)(189003)(305945005)(14444005)(6116002)(26005)(81156014)(76176011)(36756003)(3846002)(6486002)(86362001)(6512007)(478600001)(25786009)(71190400001)(2906002)(7416002)(81166006)(256004)(316002)(71200400001)(2201001)(44832011)(53936002)(7736002)(110136005)(8936002)(54906003)(52116002)(66446008)(64756008)(14454004)(99286004)(476003)(102836004)(8676002)(6436002)(1076003)(66556008)(5660300002)(6506007)(2501003)(4326008)(66946007)(486006)(446003)(11346002)(66066001)(68736007)(50226002)(186003)(66476007)(2616005)(386003)(32563001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB3614;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: khSREIvXv2M1d1IO+T/NjdjTq9rOV50KCV0OUu33fR7mMZxUzsXSyRYdq7/v3zFIUABX1iKKI0r7rtY6MEU5gJrcJW5lq4b4Z3Wtpa/bHjuCeUA8nf8kmVOQCNYV8I4OcsGLgNLqdJpoYzmNF3D/SQcd4LOq9D395UXt4eso8pK5txC7q4xoLUhjnaa6Lbwhwp26QLghGzwH0lAsLW4SsrJWEKoYt7jRhbMVO56qP9RNL91vJXBKU3wc/Ek8zvanKaY7sRLJSSWVr8HfkC1E3UIESoZADIzQh7EBZo92gDwTjwmA6R2SVYf5Q0xFomNoMKisaOXt9NkpNQXwjzCzZbqO6ByWE3TEAvtG2+f6+scJ2knEz/Cccg7td9KOkU3SmeBj2gkaUWkH2lGwtXuFfQeBmilUNHXejqI0SHXGFNM=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7db6327a-0899-4e26-fbc7-08d71b10fc9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2019 08:26:46.9960
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PA85rWSTzHu/v1mcGzKNFYMst0R70QE2BWUyXIp2cwAryHkWyNirCQ7jX5pkr7VMFzgLncao153DQoXfDNYcdsXauxQRGc5jSraey/bdT7I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB3614
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the common touchscreen that is used with Toradex's
Eval Boards.

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>

---

Changes in v3: None
Changes in v2:
- Removed f0710a, that is downstream only
- Changed to generic node name
- Better comment

 .../arm/boot/dts/imx6ull-colibri-eval-v3.dtsi | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtsi b/arch/arm/boot=
/dts/imx6ull-colibri-eval-v3.dtsi
index d3c4809f140e..78e74bfeca1b 100644
--- a/arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtsi
+++ b/arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtsi
@@ -112,6 +112,21 @@
 &i2c1 {
 	status =3D "okay";
=20
+	/*
+	 * Touchscreen is using SODIMM 28/30, also used for PWM<B>, PWM<C>,
+	 * aka pwm2, pwm3. so if you enable touchscreen, disable the pwms
+	 */
+	touchscreen@4a {
+		compatible =3D "atmel,maxtouch";
+		pinctrl-names =3D "default";
+		pinctrl-0 =3D <&pinctrl_gpiotouch>;
+		reg =3D <0x4a>;
+		interrupt-parent =3D <&gpio4>;
+		interrupts =3D <16 IRQ_TYPE_EDGE_FALLING>;	/* SODIMM 28 */
+		reset-gpios =3D <&gpio2 5 GPIO_ACTIVE_HIGH>;	/* SODIMM 30 */
+		status =3D "disabled";
+	};
+
 	/* M41T0M6 real time clock on carrier board */
 	m41t0m6: rtc@68 {
 		compatible =3D "st,m41t0";
@@ -188,3 +203,12 @@
 	sd-uhs-sdr104;
 	status =3D "okay";
 };
+
+&iomuxc {
+	pinctrl_gpiotouch: touchgpios {
+		fsl,pins =3D <
+			MX6UL_PAD_NAND_DQS__GPIO4_IO16		0x74
+			MX6UL_PAD_ENET1_TX_EN__GPIO2_IO05	0x14
+		>;
+	};
+};
--=20
2.22.0

