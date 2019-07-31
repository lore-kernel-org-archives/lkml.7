Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2CE9C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4827206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:39:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="uDEwUugu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387796AbfGaMif (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 08:38:35 -0400
Received: from mail-eopbgr00137.outbound.protection.outlook.com ([40.107.0.137]:9952
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728082AbfGaMic (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 08:38:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ra+51s60x9+gTvh78wk8ZCrRm+HAOHQDOo8FA2UhBTMazi+OTeevJxyXSqHAhW1DFPmQuI0ijAHALT3Nppq9N3IfgTPt1+SMkCp7LkWggUYuqd1auIPg1BAHude9yn2Bxm+WvMU2e+E/fo6AwvCgqApUd2NlVZ6CMv/HfJUWxsAXsJYptwM+iZMC50EBjShnNqtvAJ86r4rMIMXzEdaU5qJQamQDQZfxwBC8zai8CWB6z7xJimxf3Yf7J6f1ymL4TDcL02B2DdAYjApdbp3B6ChNx4agQy6vX5d7DcZV04cpl+IN1tkRh89nncBIo12bdVqWyu709EYCde94RHsOEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+bwSD+wY4a265VWU//ee3Zp4L/nCN6MCP5iXPU2twpA=;
 b=g64u9JPWRiueNBlJ5UEJjz/41eNBo8S/jO+azGMR3EU/g5TmgZd9H/0pBhKovMW9sj5bUwjBO5R1lAjbEszLvQEkYDweRop8CBZPCeWXTtWntbfxwKJDqZ1P2+wH4OCYpyEwefESyORR8OxlyMtuywcodrscsl85BgjYcc/OIV20Q4SYAKRKXdO4ncY85h3KKdTtjOOaUrU1sQ5KEQ2Ll7ZbFJWtwlzHtNlBC9M/90jpwUuuTtOVmsN17chEjgHKLsf3Ltj2Z3CC22LCbdqm83I4pEQtU8Sxiibf/oxSS8QFWB/i+fMdziQ0l5yeBPvz/BzmL/TLp70JVgJ0R+8Acg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=toradex.com;dmarc=pass action=none
 header.from=toradex.com;dkim=pass header.d=toradex.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+bwSD+wY4a265VWU//ee3Zp4L/nCN6MCP5iXPU2twpA=;
 b=uDEwUuguKBapAZflhycIy8SqRKS7jZnu6NUReHfjS4KWKOdw8j3pSKSPqnT3W/iSF64Lp7QcHydB4LRZkurIveV/LSUOkaYAq1xulj+NWoUbNVEr7SKjCv5s/seHfMC2pOCLRBuZdbA/DHuUG1C7hq3DPMhiz3HJ9y8LCVvzBek=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.17.157) by
 VI1PR0502MB3615.eurprd05.prod.outlook.com (52.134.7.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.15; Wed, 31 Jul 2019 12:38:21 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2%6]) with mapi id 15.20.2115.005; Wed, 31 Jul 2019
 12:38:21 +0000
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
Subject: [PATCH v2 12/20] ARM: dts: imx6: Add touchscreens used on Toradex
 eval boards
Thread-Topic: [PATCH v2 12/20] ARM: dts: imx6: Add touchscreens used on
 Toradex eval boards
Thread-Index: AQHVR5zWHQexF8AVwkue7T0eNPpvww==
Date:   Wed, 31 Jul 2019 12:38:21 +0000
Message-ID: <20190731123750.25670-13-philippe.schenker@toradex.com>
References: <20190731123750.25670-1-philippe.schenker@toradex.com>
In-Reply-To: <20190731123750.25670-1-philippe.schenker@toradex.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR02CA0012.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::25) To VI1PR0502MB3965.eurprd05.prod.outlook.com
 (2603:10a6:803:23::29)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=philippe.schenker@toradex.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.22.0
x-originating-ip: [46.140.72.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6cedddbd-49e1-454c-9dcd-08d715b3f8ed
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR0502MB3615;
x-ms-traffictypediagnostic: VI1PR0502MB3615:
x-microsoft-antispam-prvs: <VI1PR0502MB3615205D4E7069C4D29599C4F4DF0@VI1PR0502MB3615.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:469;
x-forefront-prvs: 011579F31F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39850400004)(376002)(136003)(396003)(366004)(346002)(199004)(189003)(66946007)(52116002)(66446008)(64756008)(66556008)(66476007)(76176011)(99286004)(53936002)(6512007)(6436002)(5660300002)(4326008)(7416002)(66066001)(6486002)(25786009)(478600001)(14454004)(7736002)(305945005)(71190400001)(71200400001)(3846002)(6116002)(36756003)(2501003)(68736007)(2906002)(2201001)(44832011)(486006)(476003)(86362001)(446003)(2616005)(14444005)(11346002)(256004)(186003)(81166006)(81156014)(26005)(102836004)(50226002)(8936002)(8676002)(6506007)(386003)(316002)(54906003)(110136005)(1076003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB3615;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: JLFe872mINd4VQbVag6DY92kNOdzMYtIYJpOpkNM7CwbIcL8z2TZb/QXxiifDpz24LAXL5Kh0C837N0UBicK5tWLATI7DsnlZo6XrPb2T+n+TePab/rIUZKflSA9FnHDEiHIXTjcDSp8tGI1D0fkX4lBRTL+LBVVUhgLEEzKXZfCi98knWpRZD4g6ZB6sIvWdLwsLyvTu3tZrWaGWXQpxJqpKBpBFvv97NoyurYlLpdKmjynYFjKU2AZaLkW1VBGQPZhVTc8/13E8vyYX9ofktAWp3Ep3U09K+a5kXey882dl1czgvOZB09jUJzYAgHR179T2rwfiTjWTIS80LBXdVy1JODVhPvJymzy561wx290npLZKzZwcI8W0uexGMDnVSBNFSImDLMSEg2sJO+fy/hrTpD2XrOkuQdeF52vA3o=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cedddbd-49e1-454c-9dcd-08d715b3f8ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2019 12:38:21.7824
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: philippe.schenker@toradex.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB3615
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds the touchscreens from Toradex so one can enable it.

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>

---

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
index 9a5d6c94cca4..763fb5e90bd3 100644
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
+	pinctrl_pcap_1: pcap-1 {
+		fsl,pins =3D <
+			MX6QDL_PAD_GPIO_9__GPIO1_IO09	0x1b0b0 /* SODIMM 28 */
+			MX6QDL_PAD_SD4_DAT2__GPIO2_IO10	0x1b0b0 /* SODIMM 30 */
+		>;
+	};
+
+	pinctrl_mxt_ts: mxt-ts {
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
2.22.0

