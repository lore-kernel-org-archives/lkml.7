Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A099CC19759
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 08:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A47D229F7
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 08:26:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="ahwHEf+x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729145AbfHGI00 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 04:26:26 -0400
Received: from mail-eopbgr40137.outbound.protection.outlook.com ([40.107.4.137]:35606
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728110AbfHGI0X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 04:26:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uce+Bt4g8nXOXa3TByp5YDY30hDTf3ZQuJaA+6Hk/NqgiMj9kCJ05ahKYhn5ZU6K3oSf/A+ExeIIVJDP82eWPxtk+WKfBZW0Q2G0eN1oYtOBPL842JM1T3Rmg5tbgjCh2jMYVRspU3C6V+zvZuIY9KPX4X1+xrmXzS7WcysMCC9OZbAryRtVtzawvhT3IhQZSpSa0CAzp96MHJfN/xaEtNmzmZzMIJrjpQkcUBruAoQmn+Y+J1lsv5N7s4qNun+6sa2PGKHH/9ds/uxwcjlnJg+DPQvC+/vFAY4mWovTjUnqTOzI13eJzXKsfEs/CU2M7Rvwl5o28e4iZuHk+kQdlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wBEimsd4rYHNaHIAN0dH8nO3V6dN593OmtSvPqLyr6I=;
 b=HJ8rUDPMANlZ2xybTt7UOVXTJjUAr4whPXTDty8Fs6hjFc0kPlL+1EQd/lAkwPdqZrRaIHiZSRlIRPzOToqvg0jXQYfajma/yLNxU8BKQi5fI/29bKZQvfKQ0V9L5N81aYwEuQEyuXps/FXNtFytHgGY4vPbFHzZmPe0+4EJ8t7D1G/UfXqg5/YrIUvqHx/eCFDBm3bP/Zip1EOEEBwx+CSKIvctKjRF2+SvnOnVazsNPr19gKb4Ro1Bln4imcNDvAe+aRsQr5MBf5TNomC+sYR99PCqQA24fnt12pwyn6rp3qcyzJopH0ashbWLj7CgvzGDQQiJvkrpsorprhgt9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=toradex.com;dmarc=pass action=none
 header.from=toradex.com;dkim=pass header.d=toradex.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wBEimsd4rYHNaHIAN0dH8nO3V6dN593OmtSvPqLyr6I=;
 b=ahwHEf+xKH7Hj4I34JOJMYeVJ+Z/7V6oiBXRbRkMgGImBr0UNrQhFfUCWkOs9CoPXtS/26p537x0Tc9IkGeEiBSiq8H1XUT/n7rh8paFQ87MLitpJhUBQMrQhuMzfwFk9Zs7bd5Wt5ASpRdWWexsfES8yRC3fsyjEja84TkU2ok=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.17.157) by
 VI1PR0502MB3614.eurprd05.prod.outlook.com (52.134.7.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.16; Wed, 7 Aug 2019 08:26:16 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2%6]) with mapi id 15.20.2157.015; Wed, 7 Aug 2019
 08:26:16 +0000
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
Subject: [PATCH v3 05/21] ARM: dts: add recovery for I2C for iMX7
Thread-Topic: [PATCH v3 05/21] ARM: dts: add recovery for I2C for iMX7
Thread-Index: AQHVTPnHBymxxsKMCkWQ+k28WDfDKQ==
Date:   Wed, 7 Aug 2019 08:26:15 +0000
Message-ID: <20190807082556.5013-6-philippe.schenker@toradex.com>
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
x-ms-office365-filtering-correlation-id: f33ba720-5ddd-48e5-b444-08d71b10ea13
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR0502MB3614;
x-ms-traffictypediagnostic: VI1PR0502MB3614:
x-microsoft-antispam-prvs: <VI1PR0502MB3614A90FE9136A6864B6D06DF4D40@VI1PR0502MB3614.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1284;
x-forefront-prvs: 01221E3973
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(376002)(396003)(39850400004)(136003)(366004)(199004)(189003)(305945005)(6116002)(26005)(81156014)(76176011)(36756003)(3846002)(6486002)(86362001)(6512007)(478600001)(25786009)(71190400001)(2906002)(7416002)(81166006)(256004)(316002)(71200400001)(2201001)(44832011)(53936002)(7736002)(110136005)(8936002)(54906003)(52116002)(66446008)(64756008)(14454004)(99286004)(476003)(102836004)(8676002)(6436002)(1076003)(66556008)(5660300002)(6506007)(2501003)(4326008)(66946007)(486006)(446003)(11346002)(66066001)(68736007)(50226002)(186003)(66476007)(2616005)(386003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB3614;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 9PeKL/X7JLiNHxlXr46C7NsgQ66UolXm3vlcbJXBFijH4Btu3jIBjQCruHTp/BlUMrGTUio3zDgaS39rET2+DBIKNBwkn40/1EbE2vHK3loITFLun2ly4anmAERLvHRndsxwYYFXGF5rGEq38LJnJrUbbNmeHl5LlMg4vz5EhTwAi2bbphQuT9C7cEuPZXDCr3GFGjf7t3q+XG0V34THbdGOAhy1Ygw+r6wAOsjhjVqn54SPGIIUP+cXWcQmzz1oBpxVJWvD8F1wV1+huskMGsvAUABOC+ZDy5wehnp7Qcw5mj73ASOaxNQaf5S8UVeDvb/WT7I0/UdG/s8XIDn/9fM0DBLIYsaQn6+hB7hZHfFaIqE0KVT16va0rLTTDUpqkuKMPem8KEjBUTmEvuSm0A4L3AIrqgtExxvmBl33V20=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f33ba720-5ddd-48e5-b444-08d71b10ea13
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2019 08:26:15.8989
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fKQ98ATQ30UB4VpqN7yXxFZY1bHwgJ3764ldNlDT8bjkRIzlm8VYTxHZ2dF8vQoI/J0IZOupYeFL8HbzMzI+MyVSQ6eJMsRKVFafGOXVx9o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB3614
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

Changes in v3: None
Changes in v2: None

 arch/arm/boot/dts/imx7-colibri.dtsi | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx7-colibri.dtsi b/arch/arm/boot/dts/imx7-c=
olibri.dtsi
index a8d992f3e897..2480623c92ff 100644
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
+	scl-gpios =3D <&gpio1 4 GPIO_ACTIVE_HIGH>;
+	sda-gpios =3D <&gpio1 5 GPIO_ACTIVE_HIGH>;
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
+	scl-gpios =3D <&gpio7 8 GPIO_ACTIVE_HIGH>;
+	sda-gpios =3D <&gpio7 9 GPIO_ACTIVE_HIGH>;
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

