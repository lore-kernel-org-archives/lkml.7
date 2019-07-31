Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 314DEC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2108208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:38:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="RREgbCHd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387765AbfGaMiW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 08:38:22 -0400
Received: from mail-eopbgr140114.outbound.protection.outlook.com ([40.107.14.114]:6722
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387701AbfGaMiP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 08:38:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=StOne0Troqf7ptJ1RSFQ37pVojFL+x1sp8RdXcEQW3aocDYX1gfCY5gtg5lUDWMLwNHYTXtfQ8AHBsD0JJmaLUH7vhKGlILnawX8Ys+Lgqtn6cYKL4PAgIbVqelRsp0sKfvNE+Bn39VcgAZdOxGnyJQPMZjD1bGDNGIuscsLlsDMXo9sfSq3gr6tA7hmTTe47vniypk6yKJHVtYhckldTMx1fRI7zGchAxSC2efzOjUrSvBvd+bEncXEX8ozCiYTDYIa+w1/p3bNnjD+Ay0FCzeuaIDfrAGkvRLQ88Vz+YQ2LLXhDfFv9k5o6tUxuuggW2dR+gaTzkkp9wQTN+Q3dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jc+GOQ8svZSBDI3UfNEVHJFWroPXZvMYoa1bnNblTas=;
 b=EiulDgMA7wGH/VHbjDQwxzIr7aeGJQjTJgX2MWyglqz5tSGihAPyDyOGfmsxGTBk9mSR2tYmJ8/Cg87PQYSPrT2XHkvIS9RxXM9868HoF27Ckovs7p911ynlqrC5aDbd+oLCH6KlMw6UyBBeUKiIztFYWIU7etpOHXNcrvN5jvDPM6SRtkNdVW2gHirNDOw0uV2ahgU25EhjRF1DyT8y4/P4+Zzam5PxH/Sg17iPE6k6LpoHdpQwruzYm3yBjpfIxv+Gsh6YIhOxVOs79Oo91LYMGyYXdLFpXWfY4+Shs4jfN1R7xKaaQegYPoQ8ue2KX87DcSBwIV8d2bBKJij0eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=toradex.com;dmarc=pass action=none
 header.from=toradex.com;dkim=pass header.d=toradex.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jc+GOQ8svZSBDI3UfNEVHJFWroPXZvMYoa1bnNblTas=;
 b=RREgbCHdwe7kvrKflNHYYnpjoDhHCvdlJtufBLsm00iPqiWcCUeFi0AotNzn+5VSKuID9hHEenWbxR9L8+9zqW17BQcfCrUqV2/sRY6JA84F8MdLeLwHAvabQ3mwc8NB3YaK9nPiJJSti5EVuBnwPgSoAZPf6y1c27d5ahpYuzk=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.17.157) by
 VI1PR0502MB3648.eurprd05.prod.outlook.com (52.134.7.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.14; Wed, 31 Jul 2019 12:38:10 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2%6]) with mapi id 15.20.2115.005; Wed, 31 Jul 2019
 12:38:10 +0000
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
Subject: [PATCH v2 06/20] ARM: dts: imx7-colibri: add GPIO wakeup key
Thread-Topic: [PATCH v2 06/20] ARM: dts: imx7-colibri: add GPIO wakeup key
Thread-Index: AQHVR5zPf0p183kqbUCnkaQfNt4nyA==
Date:   Wed, 31 Jul 2019 12:38:10 +0000
Message-ID: <20190731123750.25670-7-philippe.schenker@toradex.com>
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
x-ms-office365-filtering-correlation-id: 52d9d257-526a-4860-a0e2-08d715b3f22d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR0502MB3648;
x-ms-traffictypediagnostic: VI1PR0502MB3648:
x-microsoft-antispam-prvs: <VI1PR0502MB3648FA544D553AC9D9E65D86F4DF0@VI1PR0502MB3648.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 011579F31F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(366004)(136003)(346002)(396003)(39850400004)(189003)(199004)(64756008)(66446008)(66476007)(66946007)(6512007)(476003)(66556008)(8676002)(86362001)(36756003)(44832011)(478600001)(5660300002)(71190400001)(71200400001)(1076003)(53936002)(6486002)(486006)(6436002)(2201001)(446003)(52116002)(50226002)(11346002)(316002)(99286004)(66066001)(2616005)(305945005)(256004)(26005)(14444005)(14454004)(102836004)(7736002)(3846002)(25786009)(6116002)(76176011)(2906002)(81156014)(81166006)(68736007)(386003)(6506007)(2501003)(4326008)(8936002)(110136005)(54906003)(186003)(7416002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB3648;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Rl2oeyrhwPGlAsREVrTxCo14bLGFCyvqYBJXM6UpBl3Zt8/c7F6wUrL+we0xZXHlqwor8XbOsO/rdx5+uXyELMXQ5VbyAeWRLvVvuMuX8cKMy1fAavyHCA0H/Xn67pNUrs2MXhdkU1oH5N0Ie6bQaYr25FJx/tKJ0NBxyHoeWfyOB7Tnpgf4y2JGrFb4rCK6XY0AHaFNE+aVvL4V8Pyv88BateBuc5IMoEHlCdccmY0vA5aFqgdvLSUEZYgVkkmZSBwYfw/KcZjny/30/SAxeKxfGXuQHEwxhrLrHpK5vn3MtKQSEkJwCb+/viEkFm7OHA3O1RxN2UM/wxw72q5Ojt4qsHXP548GZa8BADsFU5+IEAoRNqc5SpavELY93fgBVAgWyoAerb+nLIKC17CseBy9usWvzwVCI6vXtBGLjgw=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52d9d257-526a-4860-a0e2-08d715b3f22d
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2019 12:38:10.4729
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: philippe.schenker@toradex.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB3648
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

