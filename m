Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B48C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 13:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BCA0206BF
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 13:18:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="a0+uG7Dy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730063AbfH0NSi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 09:18:38 -0400
Received: from mail-eopbgr50112.outbound.protection.outlook.com ([40.107.5.112]:14974
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729810AbfH0NSg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 09:18:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YPuZiKrvBN0Ng80onA4BthYySpZp388Rehi1KtJmNwE4JM3LYIwFBN6aPCu6VAMAbJ08kpmDV9BoUmANpTJx0vwJDjdOg2hu4tx9DlxVhg4O+Gte8Fk1V7omADSSAJcpkJ8yB0VhGasbUAcYP97lxtROpxN3SB7qhTWO5r4GIFFiZSVwI3QExlOcyJaExOxCvaZwiar7RhsCVSPa/n7RBcNY99WPkiqAPMz+O/DmGpcNFt0IgzahM9PAxGl0g6k17Qu9D2rPO1bkme0XhSg8VuhTWkGdz/KcC2g2c8nAhuh9WsGD766A7N2G7daE5ilc8MMR5RHTLLmNgsXHdSOl3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sc9bSbRVYJhwGRj+jgvBqVyuUazerMV1rm+BJ1hcr9Y=;
 b=dBxmPrD/30uw8nmkBNtis5h0TljGsMseaDM328jU9n+Egx2Br4XM6xdxVTomg/kxX+mJNxZDAcJ+IE7EJlz3E5YFFacDRYCyV6TNS/SxxyUrltPqlOYX1WwufrQGPLxbIuItYVgB0Px4V+FSpmc/pU2KW7aD/ghjRb+ynxii/VKtXokWbUEBUxfkFk495mLHEn2lz4ohqk6/4PRMZTBIHCwLJx24H53YdJ8NJjegeHWjDt0rPJmuTqEtDF4OO7ce1fDMNUdXO0Q4LKB2/Yj+4G84VvctDq0YDeBZRmAcLwc8GIf6U9lXOeTmZXPhivmhPLqJCwb4OqrVE0jyk/iUqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sc9bSbRVYJhwGRj+jgvBqVyuUazerMV1rm+BJ1hcr9Y=;
 b=a0+uG7DyDpLUT2xFG63YXhQ8Ll2lQA88Ucl0mZhxiuqQ5yRS3Q7anBMMuCFmL4MdTFiPzNZaQDZWEeonLjJFg1Fu7BvqEV0w4ZAw/xKurHsK/uXMaQXafiJXwnPIzZIF0D1nGOgLiEdlGw4ibuEHzb2MwZDflweFfYOU1nRBxno=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.17.157) by
 VI1PR0502MB3872.eurprd05.prod.outlook.com (52.134.5.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Tue, 27 Aug 2019 13:18:29 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::f59f:a307:9c53:63b9]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::f59f:a307:9c53:63b9%6]) with mapi id 15.20.2199.021; Tue, 27 Aug 2019
 13:18:29 +0000
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
Subject: [PATCH v5 06/13] ARM: dts: imx6-apalis: Add touchscreens used on
 Toradex eval boards
Thread-Topic: [PATCH v5 06/13] ARM: dts: imx6-apalis: Add touchscreens used on
 Toradex eval boards
Thread-Index: AQHVXNnqVpW8049fZU+4HTFIsdv8qw==
Date:   Tue, 27 Aug 2019 13:18:28 +0000
Message-ID: <20190827131806.6816-7-philippe.schenker@toradex.com>
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
x-ms-office365-filtering-correlation-id: 53a33dad-1dbb-4d5f-8cf5-08d72af10cd9
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR0502MB3872;
x-ms-traffictypediagnostic: VI1PR0502MB3872:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0502MB38725031B3C9F5A74B1E5B62F4A00@VI1PR0502MB3872.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:826;
x-forefront-prvs: 0142F22657
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(376002)(366004)(136003)(346002)(39850400004)(189003)(199004)(8936002)(66946007)(2906002)(11346002)(5660300002)(50226002)(54906003)(110136005)(316002)(14454004)(1076003)(14444005)(256004)(64756008)(6506007)(386003)(7736002)(478600001)(36756003)(53936002)(66556008)(6116002)(66066001)(66446008)(3846002)(6436002)(76176011)(476003)(2616005)(446003)(486006)(6512007)(26005)(305945005)(102836004)(6486002)(71200400001)(186003)(8676002)(86362001)(81166006)(4326008)(71190400001)(81156014)(66476007)(25786009)(99286004)(7416002)(52116002)(44832011)(21314003)(473944003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB3872;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: wvvXdn6q0TGgKHqxSP9xO0tOOOxuLRxBJTGuNMy6iFUMPO7Jb3VrSPbD/gIzjCmix+XtL2EA0fUqNoScIlRTWMjvBiSdwRYDP5cKVguQ+C4T/qG2A1FtYY9n8UsXrI0rduZykA2+u0G8gvSIjbtbgExYiWuiC5dk8EikZCI4WelfnZ0sx4yr7WfoOhyCik8FDYTawkYF/LJpYgkw0s8JsyAwl/aJqeU1ErlsAhQAMFi5SKfXxpeu4iG0wVgEsBvcWcIpEvH9l04CDFVRXzk5tgZCm6ZI1ukh7oQR23nXsIBOdqDfWVvuz5Ob4uVja17lM31QkJPQC7NpTBAeFPPWnSn89TrD9GuBuFGnn9HHU2BdsXUlBPP3iKxMpLyD673SW7FvThSu98cDfopXKNssdsFTl4hJD6j/gi+4Wnp+TTw=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53a33dad-1dbb-4d5f-8cf5-08d72af10cd9
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2019 13:18:28.9162
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2BD9mxdxuREh1fDKiyojk+UcGy/fXYiFsAD7YPbbAvJXqnZgdl9L8n/TiA/nLdhQfaGHXptyrYsnnv2jLzdx7SHzFk+ioVEJ2JHJ9MGy/To=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB3872
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds the touchscreen from Toradex so one can enable it.
It is disabled by default because the pins are also used for PWM<B>,
PWM<C>, aka pwm2, pwm3 which is the standard use for colibri boards.

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
Acked-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Reviewed-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>

---

Changes in v5:
- Adjusted commit message
- Switched to consistent naming: pinctrl_xxx: xxxgrp
- Added Olek's Reviewed-by

Changes in v4:
- Add Marcel Ziswiler's Ack

Changes in v3:
- Fix commit title to "...imx6-apalis:..."

Changes in v2:
- Deleted touchrevolution downstream stuff
- Use generic node name
- Put a better comment in there

 arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts  | 31 +++++++++++++++++++
 arch/arm/boot/dts/imx6q-apalis-eval.dts       | 13 ++++++++
 arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dts | 13 ++++++++
 arch/arm/boot/dts/imx6q-apalis-ixora.dts      | 13 ++++++++
 4 files changed, 70 insertions(+)

diff --git a/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts b/arch/arm/boot/d=
ts/imx6dl-colibri-eval-v3.dts
index 9a5d6c94cca4..5e9d844d78f2 100644
--- a/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts
+++ b/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts
@@ -168,6 +168,21 @@
 &i2c3 {
 	status =3D "okay";
=20
+	/*
+	 * Touchscreen is using SODIMM 28/30, also used for PWM<B>, PWM<C>,
+	 * aka pwm2, pwm3. so if you enable touchscreen, disable the pwms
+	 */
+	touchscreen@4a {
+		compatible =3D "atmel,maxtouch";
+		pinctrl-names =3D "default";
+		pinctrl-0 =3D <&pinctrl_pcap_1>;
+		reg =3D <0x4a>;
+		interrupt-parent =3D <&gpio1>;
+		interrupts =3D <9 IRQ_TYPE_EDGE_FALLING>;		/* SODIMM 28 */
+		reset-gpios =3D <&gpio2 10 GPIO_ACTIVE_HIGH>;	/* SODIMM 30 */
+		status =3D "disabled";
+	};
+
 	/* M41T0M6 real time clock on carrier board */
 	rtc_i2c: rtc@68 {
 		compatible =3D "st,m41t0";
@@ -175,6 +190,22 @@
 	};
 };
=20
+&iomuxc {
+	pinctrl_pcap_1: pcap1grp {
+		fsl,pins =3D <
+			MX6QDL_PAD_GPIO_9__GPIO1_IO09	0x1b0b0 /* SODIMM 28 */
+			MX6QDL_PAD_SD4_DAT2__GPIO2_IO10	0x1b0b0 /* SODIMM 30 */
+		>;
+	};
+
+	pinctrl_mxt_ts: mxttsgrp {
+		fsl,pins =3D <
+			MX6QDL_PAD_EIM_CS1__GPIO2_IO24	0x130b0 /* SODIMM 107 */
+			MX6QDL_PAD_SD2_DAT1__GPIO1_IO14	0x130b0 /* SODIMM 106 */
+		>;
+	};
+};
+
 &ipu1_di0_disp0 {
 	remote-endpoint =3D <&lcd_display_in>;
 };
diff --git a/arch/arm/boot/dts/imx6q-apalis-eval.dts b/arch/arm/boot/dts/im=
x6q-apalis-eval.dts
index 0edd3043d9c1..4665e15b196d 100644
--- a/arch/arm/boot/dts/imx6q-apalis-eval.dts
+++ b/arch/arm/boot/dts/imx6q-apalis-eval.dts
@@ -167,6 +167,19 @@
 &i2c1 {
 	status =3D "okay";
=20
+	/*
+	 * Touchscreen is using SODIMM 28/30, also used for PWM<B>, PWM<C>,
+	 * aka pwm2, pwm3. so if you enable touchscreen, disable the pwms
+	 */
+	touchscreen@4a {
+		compatible =3D "atmel,maxtouch";
+		reg =3D <0x4a>;
+		interrupt-parent =3D <&gpio6>;
+		interrupts =3D <10 IRQ_TYPE_EDGE_FALLING>;
+		reset-gpios =3D <&gpio6 9 GPIO_ACTIVE_HIGH>; /* SODIMM 13 */
+		status =3D "disabled";
+	};
+
 	pcie-switch@58 {
 		compatible =3D "plx,pex8605";
 		reg =3D <0x58>;
diff --git a/arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dts b/arch/arm/boot/=
dts/imx6q-apalis-ixora-v1.1.dts
index b94bb687be6b..a3fa04a97d81 100644
--- a/arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dts
+++ b/arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dts
@@ -172,6 +172,19 @@
 &i2c1 {
 	status =3D "okay";
=20
+	/*
+	 * Touchscreen is using SODIMM 28/30, also used for PWM<B>, PWM<C>,
+	 * aka pwm2, pwm3. so if you enable touchscreen, disable the pwms
+	 */
+	touchscreen@4a {
+		compatible =3D "atmel,maxtouch";
+		reg =3D <0x4a>;
+		interrupt-parent =3D <&gpio6>;
+		interrupts =3D <10 IRQ_TYPE_EDGE_FALLING>;
+		reset-gpios =3D <&gpio6 9 GPIO_ACTIVE_HIGH>; /* SODIMM 13 */
+		status =3D "disabled";
+	};
+
 	/* M41T0M6 real time clock on carrier board */
 	rtc_i2c: rtc@68 {
 		compatible =3D "st,m41t0";
diff --git a/arch/arm/boot/dts/imx6q-apalis-ixora.dts b/arch/arm/boot/dts/i=
mx6q-apalis-ixora.dts
index 302fd6adc8a7..5ba49d0f4880 100644
--- a/arch/arm/boot/dts/imx6q-apalis-ixora.dts
+++ b/arch/arm/boot/dts/imx6q-apalis-ixora.dts
@@ -171,6 +171,19 @@
 &i2c1 {
 	status =3D "okay";
=20
+	/*
+	 * Touchscreen is using SODIMM 28/30, also used for PWM<B>, PWM<C>,
+	 * aka pwm2, pwm3. so if you enable touchscreen, disable the pwms
+	 */
+	touchscreen@4a {
+		compatible =3D "atmel,maxtouch";
+		reg =3D <0x4a>;
+		interrupt-parent =3D <&gpio6>;
+		interrupts =3D <10 IRQ_TYPE_EDGE_FALLING>;
+		reset-gpios =3D <&gpio6 9 GPIO_ACTIVE_HIGH>; /* SODIMM 13 */
+		status =3D "disabled";
+	};
+
 	eeprom@50 {
 		compatible =3D "atmel,24c02";
 		reg =3D <0x50>;
--=20
2.23.0

