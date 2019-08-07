Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 398E3C19759
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 08:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 057EA217F4
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 08:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="PVZHNled"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387832AbfHGI1R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 04:27:17 -0400
Received: from mail-eopbgr130110.outbound.protection.outlook.com ([40.107.13.110]:52856
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387657AbfHGI0l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 04:26:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jS8buJnx7pAsKIyG5ugA1pTOHAcSzjR4zKgsqZah2vqT2Y7Red5yuKY2GhBvkmVHSXsnU/ram9/qgw1AM0RCdcPeJ504lLgtQhmfHbLLbPatHisJru7473ScaAlz8C3DbxEhYCUz5fI4OFz8o14pBzKady/IzXsI1DDTK9BTGVUiie/o54jxSIo2ebBMIcH2Q12lBYwXyHX380OPwbsauq4DqdkqT5XRnCO18iJp+dRuxUVXSzD7ZR3lyPOxlj/Th2tQCLiljS1tvUzf90YJm2Co+lVI/mjyMP5sr7yMef76NlhTtbI3lTzGLs1YffcK1F+k+rtd1qqTQc5jnCwgXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0K3X17obhRSAD4LGyqnpINkkfREol4HHYtGFEnAdoHo=;
 b=HXt8rW1N7aYQ650w0AVLxGLu8PJ8Uwrm1MMPvnFtytt3iSZgVZG9uETtb88B+A5pghwp3/3LcgYNqdjWji2IPEIJbolJOh6EbTCOeAuqIe7O+rMTvL3+4BLTO5IHURzESuer4OWh3WAwbVSssDiA5G32eAemFgYG8h1kGNFocdBee10EMf+3TAwFlupdZtGPra09wVFnirofKOA+05ZS0JlNPklBj4V2Ms39yufOOQ5P31h9scbApzhdwamKxMO9NZhIj79twJOCdgRmPG+szaDRlp6xhVoujnzO4LJbcAAZYGYYDcp36yk71PoH062pm1AvXiPSw4hWZXPs342UDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=toradex.com;dmarc=pass action=none
 header.from=toradex.com;dkim=pass header.d=toradex.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0K3X17obhRSAD4LGyqnpINkkfREol4HHYtGFEnAdoHo=;
 b=PVZHNled7N4AQmsjPSt5oAMIfB1UwcsUmcwUJFzBtMyX/UxSRwkweNI1Ad+G/Gu65KkZ1IQQF8yMYqDkJNRxKdkKsoZZ9R9qhVLcW9fRnRj0PWilr7fhPAnZAvHlZ9qzMFjO6NRVmE+TF5fO8K29QhonukAsUiouwzPbPC5zaO8=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.17.157) by
 VI1PR0502MB3614.eurprd05.prod.outlook.com (52.134.7.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.16; Wed, 7 Aug 2019 08:26:38 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2%6]) with mapi id 15.20.2157.015; Wed, 7 Aug 2019
 08:26:38 +0000
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
Subject: [PATCH v3 16/21] ARM: dts: imx6ull-colibri: Add watchdog
Thread-Topic: [PATCH v3 16/21] ARM: dts: imx6ull-colibri: Add watchdog
Thread-Index: AQHVTPnVE8xtMjRGZ0aIz8jrggbNSQ==
Date:   Wed, 7 Aug 2019 08:26:38 +0000
Message-ID: <20190807082556.5013-17-philippe.schenker@toradex.com>
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
x-ms-office365-filtering-correlation-id: 5ed0d4fe-eec2-49d2-63bb-08d71b10f75b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR0502MB3614;
x-ms-traffictypediagnostic: VI1PR0502MB3614:
x-microsoft-antispam-prvs: <VI1PR0502MB3614B10B4CD7051DFF4AF62DF4D40@VI1PR0502MB3614.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 01221E3973
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(376002)(396003)(39850400004)(136003)(366004)(199004)(189003)(305945005)(6116002)(26005)(81156014)(76176011)(36756003)(3846002)(6486002)(86362001)(6512007)(478600001)(25786009)(71190400001)(2906002)(7416002)(81166006)(256004)(316002)(71200400001)(2201001)(44832011)(53936002)(7736002)(110136005)(8936002)(54906003)(52116002)(66446008)(64756008)(14454004)(99286004)(476003)(102836004)(8676002)(6436002)(1076003)(66556008)(5660300002)(6506007)(2501003)(4326008)(66946007)(486006)(4744005)(446003)(11346002)(66066001)(68736007)(50226002)(186003)(66476007)(2616005)(386003)(32563001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB3614;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: P2kJw4ODRXqrOwiLM5qxlzp/+GHPy/GBRsAv8wdiaA8IgjV/6vcaCBN/fPeQd2X1T/i0RZAuJOef+6ivg4fvjON9yEkmgtq5gm2k6RSs5tWExA5K6fpw3VO81GAX+e2CwYF5C5xH3r4P0DNkwvAS3QOvRLmFnbDu5414pgIL4mv/GHxPdywxvfULA/mAj/Njr5YF9dI7hbH8jHd2caXC3GV0J/FPLM8w83zPS5S96ZZeJ+bLgvzA1PA5JGIKaDsQE/PJtVIUit7AdxZKbEESq/NwkkUJeus48H75sjWbS2Xzk1FL4ZeOk+QqWh18qhjstIHcjsPUnwkR/NDJOIX/5nJGENWAihpKRV2CE0mZjykShXYz2LKipEMM2WWNEfEqnV+YVDDAA86s9ToktPIHMnWkvRu7oFI/ZME5ORfDnDA=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ed0d4fe-eec2-49d2-63bb-08d71b10f75b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2019 08:26:38.1621
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U4h6zTsAclBBJz7+08piGxotKnkIcum/9SzoaopnMTAAwUQJPyS3Otuxb+TFKi4rjVojSnKxjjLb2kdaSvsmNdrqR8nFPErYM5i2vtTp2zs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB3614
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the watchdog to the imx6ull-colibri devicetree

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
---

Changes in v3: None
Changes in v2: None

 arch/arm/boot/dts/imx6ull-colibri.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ull-colibri.dtsi b/arch/arm/boot/dts/imx=
6ull-colibri.dtsi
index 1f112ec55e5c..e3220298dd6f 100644
--- a/arch/arm/boot/dts/imx6ull-colibri.dtsi
+++ b/arch/arm/boot/dts/imx6ull-colibri.dtsi
@@ -199,6 +199,12 @@
 	assigned-clock-rates =3D <0>, <198000000>;
 };
=20
+&wdog1 {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&pinctrl_wdog>;
+	fsl,ext-reset-output;
+};
+
 &iomuxc {
 	pinctrl_can_int: canint-grp {
 		fsl,pins =3D <
@@ -506,6 +512,12 @@
 			MX6UL_PAD_GPIO1_IO03__OSC32K_32K_OUT	0x14
 		>;
 	};
+
+	pinctrl_wdog: wdog-grp {
+		fsl,pins =3D <
+			MX6UL_PAD_LCD_RESET__WDOG1_WDOG_ANY    0x30b0
+		>;
+	};
 };
=20
 &iomuxc_snvs {
--=20
2.22.0

