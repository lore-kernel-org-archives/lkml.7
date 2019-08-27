Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E4B4C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 13:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 686BA206BF
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 13:18:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="oO6mimng"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729898AbfH0NSa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 09:18:30 -0400
Received: from mail-eopbgr50112.outbound.protection.outlook.com ([40.107.5.112]:14974
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729690AbfH0NS2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 09:18:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OhPy/3N7F/3xcN6an2QLPsOztlGd6WtP89FKGU1lRjcjMcVW/berm4eDj67MV421fgiY0pLCk3S2s1bFFQTzFTxi720ZkTbcwEb6Ko9S7v2i8NfnGJqqJRZAouSznoNmg8EseAs6M7pSlfQjlWfael7NAc8vuE/6/Qd6/+3JF9/CdDv+uxBvsHYi/fFZhx+WtqNUvaQAVJ/RLlcvBRQmhIQFG282FAuPy5zRnvgsxohILHAXbx6kEWtDCx06AzsZn1NT7QkFSC1l6e4PD0a1MPF4VXXx4MXqDo6J+ckbf3+IcvDccviZmF4OsXVwZcHKc84E0m4Aas3mHIXqu0x3aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pRMxO89KF1/3XvRfAddg3LgCkcdK2Cvvum96iBBzTLE=;
 b=QHGFSctw84yPr99ij5jqyJC/M3RTqFxNM08aBGeoHachA1lQkCvgyS5MhyAM1UofIwbPyQQL9qR4sHYG/l5cu+DSXRGBBnBs2RsNmn4qh1FHmpewJ/NyWvC2K+7/tLIdPKrP/5hHIeSvP/WmUv6Ed7pUVAPVNij8eUW9s+oFEqNhz7ChWKUIiz9JkwROjgmarJuxzqV0IijL8tGCty/QawfD2jQtgMrxJm+9/68FxpsIpFf2lL6r4ZqkMWokv315/Nd3lTGYNItYR9WlcUkmO2UWG76KZDLSsMKCHqX9HycZw9yampPT3/YaaNIEDicTp3vKySJZC6SCWDjW+dKSMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pRMxO89KF1/3XvRfAddg3LgCkcdK2Cvvum96iBBzTLE=;
 b=oO6mimnguOI2KUuJupUzsE/tPUBwCXO5HpjmHr7+fdrmpAcdmLUMJ2ahyZSKgR7MSJYYcgYLwQnt9k1rlVvUayd9FwDnpls4T5r1zUv1bGDE9t/BgnWsfcrzm0Xyrz28m0Cab1+1e7d0Rin9aMLTpbbOtQJCZUCYywY+Z8pS9Po=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.17.157) by
 VI1PR0502MB3872.eurprd05.prod.outlook.com (52.134.5.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Tue, 27 Aug 2019 13:18:23 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::f59f:a307:9c53:63b9]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::f59f:a307:9c53:63b9%6]) with mapi id 15.20.2199.021; Tue, 27 Aug 2019
 13:18:23 +0000
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
Subject: [PATCH v5 03/13] ARM: dts: imx7-colibri: Add touch controllers
Thread-Topic: [PATCH v5 03/13] ARM: dts: imx7-colibri: Add touch controllers
Thread-Index: AQHVXNnmqbGVgA1FBU28GfECv2yH5g==
Date:   Tue, 27 Aug 2019 13:18:22 +0000
Message-ID: <20190827131806.6816-4-philippe.schenker@toradex.com>
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
x-ms-office365-filtering-correlation-id: f59f7887-d798-4a64-e276-08d72af10942
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR0502MB3872;
x-ms-traffictypediagnostic: VI1PR0502MB3872:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0502MB3872FAD3784F42E9F5B125A5F4A00@VI1PR0502MB3872.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:313;
x-forefront-prvs: 0142F22657
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(376002)(366004)(136003)(346002)(39850400004)(189003)(199004)(8936002)(66946007)(2906002)(11346002)(5660300002)(50226002)(54906003)(110136005)(316002)(14454004)(1076003)(14444005)(256004)(64756008)(6506007)(386003)(7736002)(478600001)(36756003)(53936002)(66556008)(6116002)(66066001)(66446008)(3846002)(6436002)(76176011)(476003)(2616005)(446003)(486006)(6512007)(26005)(305945005)(102836004)(6486002)(71200400001)(186003)(8676002)(86362001)(81166006)(4326008)(71190400001)(81156014)(66476007)(25786009)(99286004)(7416002)(52116002)(44832011);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB3872;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: H89fV9fL79pUHJILB9Uf/IW1BhCOD+ukdG8LZpUvrBSi7DywZrHZTL2b7RhPs41vP/aXb6++qbEkl1npaWENMPOwiszz96Px98VP72MroUftyW8PLE3kfujDIkHY+/X2BQxQ15LcbSjskCBotquRP1BrCThWEZMKj5+gnI6dCQw7IHuGRyGmNXtCFGzMBij/DczArVxjotISrQsu5AGmcd6q11+ocf8HPhSWsoWEpT5xRuoGpAxyptcMOhUoTZtGHggp+jDcLBzfOSNKMkz5AaQ3Fz9mra3EiKrcSuXUWY+dsgmeIGLkrTIQtnRprQ3CLm0U/R+ogUNxaMxm89iFZMxQfjBBr4U9V33EV7pf/B4znsHakun3Wc/pJRZzKKKmUKQvmhC/LhVGVbRh54MxV6DDBWwMF87ruW0B5JSutZI=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f59f7887-d798-4a64-e276-08d72af10942
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2019 13:18:23.0565
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9/36BiM1piBwE/126lRe5TmLanQbhtJUVlES+Omy4Zy0inDMLciGOp+94eb5fSlZL+kl9vLBJv36aBcMtdrQL2opY9Bq+sIz+dKGN1l8hHE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB3872
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add touch controller that is connected over an I2C bus.
It is disabled by default because the pins are also used for PWM,
which is the standard use for colibri boards.

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
Acked-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Reviewed-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>

---

Changes in v5:
- Add note in commit message about disabled status
- Added Olek's reviewed-by

Changes in v4:
- Add Marcel Ziswiler's Ack

Changes in v3:
- Fix commit message

Changes in v2:
- Deleted touchrevolution downstream stuff
- Use generic node name
- Better comment

 arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi | 24 +++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi b/arch/arm/boot/dt=
s/imx7-colibri-eval-v3.dtsi
index 45c4e721115a..6aa123cbdadb 100644
--- a/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
+++ b/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
@@ -145,6 +145,21 @@
 &i2c4 {
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
+		interrupt-parent =3D <&gpio1>;
+		interrupts =3D <9 IRQ_TYPE_EDGE_FALLING>;		/* SODIMM 28 */
+		reset-gpios =3D <&gpio1 10 GPIO_ACTIVE_HIGH>;	/* SODIMM 30 */
+		status =3D "disabled";
+	};
+
 	/* M41T0M6 real time clock on carrier board */
 	rtc: m41t0m6@68 {
 		compatible =3D "st,m41t0";
@@ -200,3 +215,12 @@
 	vmmc-supply =3D <&reg_3v3>;
 	status =3D "okay";
 };
+
+&iomuxc {
+	pinctrl_gpiotouch: touchgpios {
+		fsl,pins =3D <
+			MX7D_PAD_GPIO1_IO09__GPIO1_IO9		0x74
+			MX7D_PAD_GPIO1_IO10__GPIO1_IO10		0x14
+		>;
+	};
+};
--=20
2.23.0

