Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F104C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 14:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08B1820665
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 14:22:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="K+c236w3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729015AbfHLOWf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 10:22:35 -0400
Received: from mail-eopbgr150112.outbound.protection.outlook.com ([40.107.15.112]:51614
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728874AbfHLOWP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 10:22:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S8mVhm3DPyA1jGH9keWZS39xiXy0redvFRSZ7XGGyUC24NUOEqGA+XyQSPdsgOaGA+h+AqDupjj81MsuGChvO1M8MlV/YFkOtC33y3jwhFMfFHnolaQuTzigDeZG1knEaV8NZcH/3bxqcWmUNpFJE5X0rn9haUS21mhET8w+SbzGKKjAIxYZ042vFWmsQAl0ibnvNNtMGFypYEamfzKTHb/I+Mbp1pqYjZWoBuHHPHDj4wtw6eebysbQNJzbpb7M0/4+ZPHN1dIr+2/vCS0SiznUuKki+gfoS8+5EtiWQdcHUHVmHQG0L1EcKL+VwD5XvMtRo9FDIKgdXzdNiMn4rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JjuROcQfVqzdJnbplx8Ufqu88hzjt8BvXyOZNmLKV90=;
 b=PAMRFe4tVcUN35AEJ/X1bYQmMyHO8ndHukcA4XGRjmFjpzgyDcOfshgFldthmePlCfcqyYH1Na/PI4Qy26eFQy2uiUrrq4LjA5ooTodbycjthssyXWqJtmMiCPm9YX4LrIR0W2uvq6CMAUQQA7yokCh0tVupM2CcY0yGeS45sVZXwhNH5e2cZVN9usn9O1AyEMG2jI2G9ux+BfAqc725vvrQBfwxlU3bN0X5Tw82KmU6GyewCesSJTVwzUmBraoHLsfqQvfn3sujzgG6noFLdn6puA11tB4sId5fWSJwxtsdrv+xkdjCPjGevOIcP7JVz3qoQ/Mwvy2LxmHSE42xUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JjuROcQfVqzdJnbplx8Ufqu88hzjt8BvXyOZNmLKV90=;
 b=K+c236w3Ym9QWNeENI1DDSM/Huu23eiCUHb9XeDHdfhdf+Mlt8EjFKPGl9ZoiFT4QvpV5Jx74RRforLYCVMbeh4MY5lJSIbAlunoUMyMiUhZa2tF2HyoS1j051YBjz/sQ/ODmtVonl0E9BZl+479pB/JOcS1S6K78N2i7E8GQEQ=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.17.157) by
 VI1PR0502MB2942.eurprd05.prod.outlook.com (10.175.26.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.21; Mon, 12 Aug 2019 14:21:44 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2%6]) with mapi id 15.20.2157.022; Mon, 12 Aug 2019
 14:21:44 +0000
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
Subject: [PATCH v4 19/21] ARM: dts: imx6ull-colibri: Add touchscreen used with
 Eval Board
Thread-Topic: [PATCH v4 19/21] ARM: dts: imx6ull-colibri: Add touchscreen used
 with Eval Board
Thread-Index: AQHVURlEhvp4muOxlkOgL6J5rgvomA==
Date:   Mon, 12 Aug 2019 14:21:44 +0000
Message-ID: <20190812142105.1995-20-philippe.schenker@toradex.com>
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
x-ms-office365-filtering-correlation-id: f128eda9-3452-4651-15d6-08d71f3066fe
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR0502MB2942;
x-ms-traffictypediagnostic: VI1PR0502MB2942:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0502MB2942D95BB63A0F6BADC5D2A5F4D30@VI1PR0502MB2942.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 012792EC17
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(1496009)(376002)(136003)(39850400004)(346002)(366004)(396003)(199004)(189003)(5660300002)(54906003)(110136005)(316002)(478600001)(6486002)(86362001)(2201001)(66066001)(53936002)(6116002)(1076003)(3846002)(2906002)(4326008)(25786009)(66446008)(64756008)(66556008)(66946007)(66476007)(6436002)(8676002)(11346002)(476003)(2616005)(446003)(256004)(81166006)(81156014)(2501003)(44832011)(6512007)(14444005)(486006)(50226002)(71200400001)(71190400001)(7416002)(8936002)(36756003)(52116002)(7736002)(305945005)(99286004)(102836004)(386003)(14454004)(76176011)(186003)(6506007)(26005)(32563001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB2942;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: VRKvQNExDcxURudWtGPEN5WGA7sNgsBrwVEpAH7x6hAZz0cJmCHCgt1sRQX23OGXDTauA4BoF3ubCKqCLnCjHMWIA2IqqXNEO9F+yJFXstFXJOvKjpLW7qHJ9j2Dc1WYG3vyJ7oBBENm/OkSkxLzJE2/VYrmCmGTy2L6DDcwM/z8uJEwwsWC4k+3ErN2cn6d9XW15OJbGK5YQnDUx6HZIu5/BGMb8DDniHASAtCJTy9YcRoIDtNfboQ/Fk8u1Zqhkjz6vO4lqzjUJi3WSt4twDtSSF6LDHangAljA1tqYn8tPAUpaF429pXVOIjhZFd2hHvkq9A4W85Zd+knkZZfQLP5GDwAk6vrGpkvyINTeHN8+HhaFVojZwA1UAmXud40koqg+VDM/KVOJ4AAx9yCfvyea6ooPu8RLbcomKRtUFk=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f128eda9-3452-4651-15d6-08d71f3066fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2019 14:21:44.4802
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z1OB4eilPfaHVCdxID2PVjcP1SEXD/07RWIOGUicG/ZnU6uN/ruti5IIVMPx8QjYCuBRe4fVTlvIk6N13yHgwKHyM+ShzXWb1zqOOBohMec=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB2942
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the common touchscreen that is used with Toradex's
Eval Boards.

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>

---

Changes in v4: None
Changes in v3: None
Changes in v2:
- Removed f0710a, that is downstream only
- Changed to generic node name
- Better comment

 .../arm/boot/dts/imx6ull-colibri-eval-v3.dtsi | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtsi b/arch/arm/boot=
/dts/imx6ull-colibri-eval-v3.dtsi
index a78849fd2afa..458a4084e53c 100644
--- a/arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtsi
+++ b/arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtsi
@@ -100,6 +100,21 @@
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
@@ -176,3 +191,12 @@
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

