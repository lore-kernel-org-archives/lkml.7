Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B2EC19759
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 08:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F484229F7
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 08:26:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="CbMIUhHI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387601AbfHGI0g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 04:26:36 -0400
Received: from mail-eopbgr00098.outbound.protection.outlook.com ([40.107.0.98]:5766
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729088AbfHGI0d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 04:26:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iwHOV5vJaL9s+lXZ/4TqhoPWBcFm60ib1cQxAijVX+cmEGgLjg/yQvOFW2eXVr5pqk+LNaZZI801X/XAN14QGqmPAXYOoj2+qZAyxHZZuG8eLjB2cWws2T88navM0ES3X3owFExQOtg6CXfbu/wS5nlntDYPkOjrjrTx1/My4iRdZPBtuYb3m19nz4F8JSJ8FWqUAuvqWCYcAW5qet8xGDOwXH0gXsjUyduPiu0Y7+bIx17pLif98pMbIttWDc+mRmlXN0eLcwEV2l/3Fwm9dM4PnZLKduq9MWQ9MJpc0IbPpcI774Ll5AkBADML25vL0VyKVIWaVV1G3IIjhzBxWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XS1eMki17z51actuZ4PXRZQTgGAjAiYyaK4QToU7D5g=;
 b=f2Gc2RStF2YS7BFDBR7+v/nAkdgesKL3OkJb+NzW/S0gDM6qQ+NlnTiF+Hdxugu0vmSg+4Tv2gaXNDOfdbKabvoAeotCCRUqFYrycYYzBAee5a2bsTQxOL2fUgDcsouvIMvKuMz5dNsUUfQppP7XYhwWRLhj+0ZEImqB13LYTbaVUPIp2RLrJT+IVgnP/rqy0/R631zVYfOkbgNkeZ6Ci607NPAYec2+KOrNfEsvf6i+Z0ivkCd7goV9Vu/M2cunzsHyo0oUssR0FaTL0XRxGn/HfbiYgGaA2KCHphXRXLDZ+yhU/z7v0B5NAegmmW2MN/KaPfVmAZEVpjoT2e0aAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XS1eMki17z51actuZ4PXRZQTgGAjAiYyaK4QToU7D5g=;
 b=CbMIUhHIxCnQqI/S9JxTJHSf9oAVOU9PO5YSHOIXuBNRySq2B7uo3+OYBGB8J05FpFajk86EBuhewY4dryHiU+YVoqBswglcW1p4NzUyxGbH9QFPA5UxFMKY7v3skoE0nbbNfBuRko9XhT54Lx4tdEqz/9N1wxTTIpZ6D2l0fJk=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.17.157) by
 VI1PR0502MB2928.eurprd05.prod.outlook.com (10.175.25.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.15; Wed, 7 Aug 2019 08:26:28 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2%6]) with mapi id 15.20.2157.015; Wed, 7 Aug 2019
 08:26:27 +0000
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
Subject: [PATCH v3 11/21] ARM: dts: imx6qdl-apalis: Add sleep state to can
 interfaces
Thread-Topic: [PATCH v3 11/21] ARM: dts: imx6qdl-apalis: Add sleep state to
 can interfaces
Thread-Index: AQHVTPnO2dmXEu4+HUek6D7d0b8AYA==
Date:   Wed, 7 Aug 2019 08:26:27 +0000
Message-ID: <20190807082556.5013-12-philippe.schenker@toradex.com>
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
x-ms-office365-filtering-correlation-id: 183f6288-914f-43aa-e5df-08d71b10f123
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR0502MB2928;
x-ms-traffictypediagnostic: VI1PR0502MB2928:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0502MB292893DC354B2E39A3C56C93F4D40@VI1PR0502MB2928.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:758;
x-forefront-prvs: 01221E3973
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39850400004)(366004)(396003)(346002)(136003)(376002)(199004)(189003)(64756008)(66556008)(66476007)(66946007)(36756003)(11346002)(476003)(6436002)(76176011)(2906002)(316002)(305945005)(2616005)(66446008)(1076003)(54906003)(110136005)(68736007)(486006)(14454004)(14444005)(5660300002)(446003)(256004)(86362001)(44832011)(50226002)(4326008)(66066001)(53936002)(6486002)(186003)(8676002)(26005)(71200400001)(99286004)(6512007)(2501003)(2201001)(71190400001)(102836004)(386003)(8936002)(6506007)(478600001)(7736002)(7416002)(52116002)(3846002)(81156014)(81166006)(6116002)(25786009)(32563001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB2928;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 19siTMFJMY9Dps/wyiMgwlh7Fn7K6XgBJ64tiIi1EOWoOK32nKoQsVSNdtK/GzmcO9hvWAi6aXEsmbi/AJtSkWkLKfzuptdYypYWJyAhLFz/3quQ6B44mrV/56cpEFHu6hG3Cax5sPzPVs/NAv/w9sQPVcgWXFLNsglcU0bQjbe7Nch69nZHd2XZlJ7qqsqeZtRlD43gyAzEaM2DCYjtMwUcfbqlydGMW02954oKAWXPv1d7tX1aXEHP8WGReLbrXpiyey10RRwwgvh2uL1sPRwSDy8z5U4OxeBXiakPdlglITu4W6/6lP0l6QZY6ot8wdLQBmMGq4/Mx3cBotcS/uMRBar6kKs2WmMD0FNcsdEiScm6bhXugxudE38CRvZHZ7z5icBLAsIvkgPMF1Hy+7T64Xc/0ertpdVUF5fK7R0=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 183f6288-914f-43aa-e5df-08d71b10f123
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2019 08:26:27.7671
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6EiC3QmQ2QkBSWq6n2I6p/+2KKayhqVZ3QJnEiAapLuzWmCJLa4arvZnt4jP1+ZYaLmpcWZnKIwvv2mVcoy6/ZKOj0umEm31RAsyFr23EOs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB2928
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch prepares the devicetree for the new Ixora V1.2 where we are
able to turn off the supply of the can transceiver. This implies to use
a sleep state on transmission pins in order to prevent backfeeding.

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>

---

Changes in v3: None
Changes in v2:
- Changed commit title to '...imx6qdl-apalis:...'

 arch/arm/boot/dts/imx6qdl-apalis.dtsi | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-apalis.dtsi b/arch/arm/boot/dts/imx6=
qdl-apalis.dtsi
index 7c4ad541c3f5..59ed2e4a1fd1 100644
--- a/arch/arm/boot/dts/imx6qdl-apalis.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
@@ -148,14 +148,16 @@
 };
=20
 &can1 {
-	pinctrl-names =3D "default";
-	pinctrl-0 =3D <&pinctrl_flexcan1>;
+	pinctrl-names =3D "default", "sleep";
+	pinctrl-0 =3D <&pinctrl_flexcan1_default>;
+	pinctrl-1 =3D <&pinctrl_flexcan1_sleep>;
 	status =3D "disabled";
 };
=20
 &can2 {
-	pinctrl-names =3D "default";
-	pinctrl-0 =3D <&pinctrl_flexcan2>;
+	pinctrl-names =3D "default", "sleep";
+	pinctrl-0 =3D <&pinctrl_flexcan2_default>;
+	pinctrl-1 =3D <&pinctrl_flexcan2_sleep>;
 	status =3D "disabled";
 };
=20
@@ -599,19 +601,32 @@
 		>;
 	};
=20
-	pinctrl_flexcan1: flexcan1grp {
+	pinctrl_flexcan1_default: flexcan1defgrp {
 		fsl,pins =3D <
 			MX6QDL_PAD_GPIO_7__FLEXCAN1_TX 0x1b0b0
 			MX6QDL_PAD_GPIO_8__FLEXCAN1_RX 0x1b0b0
 		>;
 	};
=20
-	pinctrl_flexcan2: flexcan2grp {
+	pinctrl_flexcan1_sleep: flexcan1slpgrp {
+		fsl,pins =3D <
+			MX6QDL_PAD_GPIO_7__GPIO1_IO07 0x0
+			MX6QDL_PAD_GPIO_8__GPIO1_IO08 0x0
+		>;
+	};
+
+	pinctrl_flexcan2_default: flexcan2defgrp {
 		fsl,pins =3D <
 			MX6QDL_PAD_KEY_COL4__FLEXCAN2_TX 0x1b0b0
 			MX6QDL_PAD_KEY_ROW4__FLEXCAN2_RX 0x1b0b0
 		>;
 	};
+	pinctrl_flexcan2_sleep: flexcan2slpgrp {
+		fsl,pins =3D <
+			MX6QDL_PAD_KEY_COL4__GPIO4_IO14 0x0
+			MX6QDL_PAD_KEY_ROW4__GPIO4_IO15 0x0
+		>;
+	};
=20
 	pinctrl_gpio_bl_on: gpioblon {
 		fsl,pins =3D <
--=20
2.22.0

