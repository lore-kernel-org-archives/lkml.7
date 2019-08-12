Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB864C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 14:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76F6820665
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 14:22:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="cXuOVtHn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728958AbfHLOWP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 10:22:15 -0400
Received: from mail-eopbgr150103.outbound.protection.outlook.com ([40.107.15.103]:19221
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728123AbfHLOWM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 10:22:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DlK+arUDOV/84Lxy1+spe/iP1diRVUiaGVrOr73QGmwtsr2psUaNltE6hebQ1u3T3X44DHBM3ZSVZy9UuH/9fJNIq24xQ2eZNKi8uWLvxctl3iN6FCqxWGzcTyXjRot/4oVWDJfNfbBLee1mkgTc2kHMLlKvTjn3T+bOxGSeSxyUA+uO48iAS7IPbd6+5OuIfCI8ckEZdKOVqWz2wxnM8KDx1yXfq9qPk4RczUV4UkkC9YlNLR/KTMc2AxZoiq8V17ZKdu+OUAxfAx3G03gqYOfqebXwJO5zX+WOaq+xNI1PtQYVjcRg5Ex5jMjoDudoMJf28Uk4PMybVp5bm7Xztw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B0BdRznFxAUhNxrspkTK7rwiM+GJQy59F2gJy2dJvFk=;
 b=k5OkZZHR8CiUxrU1WbQYTFYiqNmD7iaj5nP6ja0MCaj1H8WpgQLcKVoVmmn1i3KVWWTSQulZQGa0OOHLYf9doXWcIBLJw7CEsjJrAY5mRHbXcW93bcW9r35YnaWFbo4xcmlvbx4wgVhMTZgjQQ00nfqiOeqhVsTk40e2YpE5moEpw9NKn29WE5RGTKbIENalxDyV0po3wvn40n/gmSigssv97H0Lew7/xPiIDEaX8LUF4U0L/GsZCrGrLxBNz4r2qzPXHxGF0ucFlFDz9/5vL0BDxYl0FVTSOk2Tkr22ivin7KP6QU9H16TdEhDjWQTXVlsfNZbynYD14dyiEnXTfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B0BdRznFxAUhNxrspkTK7rwiM+GJQy59F2gJy2dJvFk=;
 b=cXuOVtHnO0I8TIb90QA77ueAJ4ehRUuhP34PNWDlTDLQKdgJoC5TEkeo9PxKnfl7sdeUaqq3+UE198tCUUV/ERrznKA0ZiON9P1JZ0wwKeYK5BJeiYJP/ikxYChDpI4IF2+bwgjlKx/ZmRlxbYXOkJBwestxHlu0qLlmfRDOWvk=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.17.157) by
 VI1PR0502MB2942.eurprd05.prod.outlook.com (10.175.26.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.21; Mon, 12 Aug 2019 14:21:23 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2%6]) with mapi id 15.20.2157.022; Mon, 12 Aug 2019
 14:21:23 +0000
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
Subject: [PATCH v4 06/21] ARM: dts: imx7-colibri: add GPIO wakeup key
Thread-Topic: [PATCH v4 06/21] ARM: dts: imx7-colibri: add GPIO wakeup key
Thread-Index: AQHVURk3eaP9B74GN0+d3QWKMOWx0g==
Date:   Mon, 12 Aug 2019 14:21:23 +0000
Message-ID: <20190812142105.1995-7-philippe.schenker@toradex.com>
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
x-ms-office365-filtering-correlation-id: 2405a16f-9c0a-41dc-1770-08d71f305a40
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR0502MB2942;
x-ms-traffictypediagnostic: VI1PR0502MB2942:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0502MB2942F6671D13FD34E8E938AFF4D30@VI1PR0502MB2942.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 012792EC17
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(136003)(39840400004)(346002)(366004)(396003)(199004)(189003)(5660300002)(54906003)(110136005)(316002)(478600001)(6486002)(86362001)(2201001)(66066001)(53936002)(6116002)(1076003)(3846002)(2906002)(4326008)(25786009)(66446008)(64756008)(66556008)(66946007)(66476007)(6436002)(8676002)(11346002)(476003)(2616005)(446003)(256004)(81166006)(81156014)(2501003)(44832011)(6512007)(14444005)(486006)(50226002)(71200400001)(71190400001)(7416002)(8936002)(36756003)(52116002)(7736002)(305945005)(99286004)(102836004)(386003)(14454004)(76176011)(186003)(6506007)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB2942;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: HEDVro1QxJZ41i8TOh3Jt+7VUKAUTar499Zd/0VBi0V4CRI1nPTU7Tsw6WqAt6Fh+v2bHG+FIMRWh+JCdU9TprmR+uV6U3VlzpvybPnvDFU9uN5+uOEZa5+A7J24d6lbXJNET3OUsGlHn3o0IW9B3Bx5bXQ0VgbeINWQzqK4lhvtPrPu0QmLDAgOwa9jxDz/UQOLhGe7ymZp2UiONnNagWOg50CO4BiQerP2AgY14qRaTAQomjC3T7dqSc3RHt6tnL3XvzRo0Snmj8ID/wHlnICHUomE3+TFahVScoOwRCe/iz10NBrLPPsEkJBWYuGCpDI/K0i9WblndvQcXvZYbu+bR9F7hJNDgiP1UP3JuhhYI+bRfYtTc2Im2bk/+994pMdPWyM9fQyawgzkA73M8kPhqXjKZiVdeQRDqdUotfo=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2405a16f-9c0a-41dc-1770-08d71f305a40
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2019 14:21:23.1504
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CPJxbupaE/jfbhCv/YZYMvQmYAK1peuORlY/sgA5oQYL++0V+nkl+1YRKn67kGrRyG82t7U4aj4+gcZEpIvofxVYEolygMLX/HEmk00ejLc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB2942
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Agner <stefan.agner@toradex.com>

Add wakeup GPIO key which is able to wake the system from sleep
modes (e.g. Suspend-to-Memory).

Signed-off-by: Stefan Agner <stefan.agner@toradex.com>
Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
Acked-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v4:
- Add Marcel Ziswiler's Ack

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
index cab40d22d24e..5347ed38acb2 100644
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

