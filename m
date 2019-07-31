Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E276FC32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB5CE208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:38:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="qVz1VI69"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387836AbfGaMii (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 08:38:38 -0400
Received: from mail-eopbgr140114.outbound.protection.outlook.com ([40.107.14.114]:6722
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387729AbfGaMid (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 08:38:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JQ8Ptn9+/80iv6GhJWsZ8PrvCU95UTa/0OMk02NmJ+z1YuUKHJM9lyKCTsZXIaJmImRIgQEOxEIYK0v0Gncs5/3E9XGxap3NtexdJU1lBvITgz14/QWuUl8yrPG4qa8XOhISDKJO6P85j8AwWtTbe31ubYekLIPznAdS0z67paUxyIK/AR8VfbZq/WhYw2KVRDAZpoZqwtnKWB3SU7zmG1+TTwlkLBCv+0Ep9pkXkxvwiO8hlur9IKpjUuFAX5sneSYMQego92RnrzxtZAi5AxR4e1sWmkjgXEZMAb8rNvFhMwu5SeY+A5y0meSdYXzyzrQVQY3aem0r9LnfX+aAew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QrpoQyN+/UzCR5JErHOHajjddYJ6uZ5edlzG727cu50=;
 b=ATFTbXaU6ZKCGXkLY4bIpepnxp7e/whnrzQ1oobfAVEQorBTiS0DTJq2slE96P0wjcHKMuxCzh4NaFurnrchhoSsetSXXX1QtTPmKUW0/N1OFI2mskZR+aeRLRQAwGwCMORuyWsS+BMgrpW+ICtDXYLyfxyyrPJdaWLIMbqIjoqQG0qMXsBLUt/Zspu7KY7pbzjp78FaBFuyQD+b4WgukFrDfT6zo0rqJ7q1hXaDjaVXEm4/7y/7ZblF7b7FndTMRklLAM77nkYmNfZ5bfWVlVVxnbz0DUpZUDZJW6uaT2mtiG0FbK7ilDvw5PexB2UvRg9zumAyInxjSEa3JH38Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=toradex.com;dmarc=pass action=none
 header.from=toradex.com;dkim=pass header.d=toradex.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QrpoQyN+/UzCR5JErHOHajjddYJ6uZ5edlzG727cu50=;
 b=qVz1VI6951TtDxsfPpoIHlH8bElVSfsksQpROIz36GTrbwz/7VwFXcQr8R1Ug918xqtDUFMdjr0bpfX+VQd9VBujfNDYuNwOZUnxhJlZ0tKo5ap5nzDmFk49BZLmhytp3Qn/wtI0/QM3MG7gS6+sMIulqe/HHSQKXBhE8XMgII8=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.17.157) by
 VI1PR0502MB3648.eurprd05.prod.outlook.com (52.134.7.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.14; Wed, 31 Jul 2019 12:38:14 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2%6]) with mapi id 15.20.2115.005; Wed, 31 Jul 2019
 12:38:14 +0000
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
Subject: [PATCH v2 08/20] ARM: dts: imx7-colibri: Add touch controllers
Thread-Topic: [PATCH v2 08/20] ARM: dts: imx7-colibri: Add touch controllers
Thread-Index: AQHVR5zSfqDLO7YI3kGn89/J0dQlQg==
Date:   Wed, 31 Jul 2019 12:38:14 +0000
Message-ID: <20190731123750.25670-9-philippe.schenker@toradex.com>
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
x-ms-office365-filtering-correlation-id: 923b3748-5c42-4f11-5ac2-08d715b3f469
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR0502MB3648;
x-ms-traffictypediagnostic: VI1PR0502MB3648:
x-microsoft-antispam-prvs: <VI1PR0502MB3648E34F7C190AF360FB94D7F4DF0@VI1PR0502MB3648.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:901;
x-forefront-prvs: 011579F31F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(366004)(136003)(346002)(396003)(39850400004)(189003)(199004)(64756008)(66446008)(66476007)(66946007)(6512007)(476003)(66556008)(8676002)(86362001)(36756003)(44832011)(478600001)(5660300002)(71190400001)(71200400001)(1076003)(53936002)(6486002)(486006)(6436002)(2201001)(446003)(52116002)(50226002)(11346002)(316002)(99286004)(66066001)(2616005)(305945005)(256004)(26005)(14444005)(14454004)(102836004)(7736002)(3846002)(25786009)(6116002)(76176011)(2906002)(81156014)(81166006)(68736007)(386003)(6506007)(2501003)(4326008)(8936002)(110136005)(54906003)(186003)(7416002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB3648;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: myYUaVJd7vhbw14NkCC30cX9Y/FHmq2hHObdlnS8bOUTRfWJkdy+ORuUXwLmfSiBFAjvg00KSlpYQi3kJrxVr1dTdxnJhxl/BY4nwiS4eQPsJNknpuoUuydGZMbqlbu0pRlvyaW2zZgIhXZZD6WzRVh4CLUB4VNUcGa8ic0ZlHWoAQtZ7MypqgE8D3MLDXuYPxdCR+kpB3ESkvV2dfEazpZHI9bhkNK0aNrPE3vusNKl+cQiix3+tB5xaStD1S3UuK4sByIENdMsRH/9zQW5J3vf3qVioSIQik0gLicFybgg8qGLPICZ+3tIqN5K4+Ex5JRC+aMKO2cqGUn0YqJO7ZYi5Lzat0zaMnG7kun5HLZbjr2TNc+9hZ1WFoSHy8fmf36Up6RYcG9P+cMbft/c47McZVP8EL+hgm6z9QhU3zA=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 923b3748-5c42-4f11-5ac2-08d715b3f469
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2019 12:38:14.2387
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

Add atmel mxt multitouch controller and TouchRevolution multitouch
controller which are connected over an I2C bus.

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>

---

Changes in v2:
- Deleted touchrevolution downstream stuff
- Use generic node name
- Better comment

 arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi | 24 +++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi b/arch/arm/boot/dt=
s/imx7-colibri-eval-v3.dtsi
index d4dbc4fc1adf..576dec9ff81c 100644
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
2.22.0

