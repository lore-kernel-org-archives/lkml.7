Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD4A8C19759
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 08:26:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B7A7229F5
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 08:26:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="r8cQBit2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729267AbfHGI0c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 04:26:32 -0400
Received: from mail-eopbgr00098.outbound.protection.outlook.com ([40.107.0.98]:5766
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728110AbfHGI0a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 04:26:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AQQE+uXoX7iu7ck8bRK3+t6EC1imNU4cljHagITDQCs8aEsOyjTdN1XwSUGdO1S06STaHCysE5uktj+YXHI+UGlZsWVda3bly/nYDLnmF0aC0OnEBed/lQZQGYX+GnlgvNYXvnV1I80UAs8saKxDwPWErAyeE3Q/GXgV/VAO4O+KpKaqZdOHeMuAmfKaAvRULDMUvDt+W/KksBqNUjhqN6CtYuVGHIjPxWOWF6yXdOBzd1s2yXPGnOBguNszl4G5YA9GuT+jT51Q0akbVlZjryOeqiFjm8wzWlhahNZ4KHxLxZfHDekIa2zCj8lFU/NStmYU/FkYPwFoTth/vAWuww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KS2CADGPaYm7ArcbDFzXj/Te3GT91m8cjIUKRUowElU=;
 b=EqqceZDjFeyOXTMAu73EJ/lvO2ERmbxHyt5CJ1LNOYecwwoDYj6v6wj5CYnpFaOX6geVpnSQTRgyPcZguN/Dc90asuCebFpRubtTEyuQa3K6DEGBkUhivQjY1Jps8JtQKnFI9TOU8qw58f5mWCctCCLv2Gd9hiq8VvvzG61DgdxzMxorzgBwocMyryZR1midPWP8Xgs6yPcos66mkRIsbFCcCyy4HWBpjSAWCA6CUELf6gYUohPPWzx0vMTDURddImddruwvRBOswybGl/e7QDA6f0a1ve8IBbtVqq3BLwYseFaZ7ry/I4RrRxreXnYFiUYMogMLU2sp1TmAdcQwFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KS2CADGPaYm7ArcbDFzXj/Te3GT91m8cjIUKRUowElU=;
 b=r8cQBit2IwB0Q37La7MYmo10SO8UZgK38hH+amqFQREsTv0EffJ/yvx6F7x4KkVccqjrFt0qKEf5SkaP38sStmmPmSaFpZM9z+Yq0X+mQWME4KyDCAHJZDQyJfsPHOTTcS4het8Qcz05YqlF2TdFLlL4ehd5vYJRGWd1STWOeNI=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.17.157) by
 VI1PR0502MB2928.eurprd05.prod.outlook.com (10.175.25.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.15; Wed, 7 Aug 2019 08:26:25 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2%6]) with mapi id 15.20.2157.015; Wed, 7 Aug 2019
 08:26:25 +0000
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
Subject: [PATCH v3 10/21] ARM: dts: imx6qdl-colibri: Add missing pin
 declaration in iomuxc
Thread-Topic: [PATCH v3 10/21] ARM: dts: imx6qdl-colibri: Add missing pin
 declaration in iomuxc
Thread-Index: AQHVTPnNUloOartdxU6Cf5WMSyR4oQ==
Date:   Wed, 7 Aug 2019 08:26:25 +0000
Message-ID: <20190807082556.5013-11-philippe.schenker@toradex.com>
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
x-ms-office365-filtering-correlation-id: 74264afb-c81d-4d77-3012-08d71b10efec
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR0502MB2928;
x-ms-traffictypediagnostic: VI1PR0502MB2928:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0502MB292898AF572DE92FB75810DCF4D40@VI1PR0502MB2928.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-forefront-prvs: 01221E3973
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39850400004)(366004)(396003)(346002)(136003)(376002)(199004)(189003)(64756008)(66556008)(66476007)(66946007)(36756003)(11346002)(476003)(6436002)(76176011)(2906002)(316002)(305945005)(2616005)(66446008)(1076003)(54906003)(110136005)(68736007)(486006)(14454004)(5660300002)(446003)(256004)(4744005)(86362001)(44832011)(50226002)(4326008)(66066001)(53936002)(6486002)(186003)(8676002)(26005)(71200400001)(99286004)(6512007)(2501003)(2201001)(71190400001)(102836004)(386003)(8936002)(6506007)(478600001)(7736002)(7416002)(52116002)(3846002)(81156014)(81166006)(6116002)(25786009)(32563001)(473944003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB2928;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3BsqZtszGpDMtzLwgGzaycXCgEcjlsvKdqVi1UmKHPSH+M4WoegPiw0GSwaxTY/BKUadPJDsgtUiHQk6IZUP1gOIbSkPxrPdVQPzCY3abYZwOdPY6I7rMPL1mbnEtkpcTfyaUrbBsw+ELN+z5y9oAkIKsvPKXPzMLnfsDZ+vdtfQtTVSJwf3BCJ2eo9urwBzS/xYAURMyN4vGYi4veRxudEcEp0hr5Z1KTAPyhqZKov5SA1sHSRigOHEwPtGIE7CpmbgsJSFzbZNtxLbTuFHmOScwbaq9/JmDUYwawE7UuDWE+8VSJK/idaNbx65k23dysoKQxrMmJg4umNxUn6N5LHAj79wUY5ykx8dPAgXbgwHN9j5IWW0mMid23A4q6ZsDuwafKun3LfA2P2plmdTLpOCJ1PpqXPrRZp7UNr4cyE=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74264afb-c81d-4d77-3012-08d71b10efec
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2019 08:26:25.6853
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u513AruqVknxK0TiejFyYwQIHJhO9zZfJE+Qkl/mLVO/PIo8ALtYEeoBPNnIqbMqeylJWOzygUGBiQ6Q3fhyGdcq0d0x95FH+eAIGQs8ZS8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB2928
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the muxing for the optional pins usb-oc (overcurrent) and
usb-id.

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
---

Changes in v3: None
Changes in v2: None

 arch/arm/boot/dts/imx6qdl-colibri.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-colibri.dtsi b/arch/arm/boot/dts/imx=
6qdl-colibri.dtsi
index 019dda6b88ad..9a63debab0b5 100644
--- a/arch/arm/boot/dts/imx6qdl-colibri.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
@@ -615,6 +615,13 @@
 		>;
 	};
=20
+	pinctrl_usbh_oc_1: usbh_oc-1 {
+		fsl,pins =3D <
+			/* USBH_OC */
+			MX6QDL_PAD_EIM_D30__GPIO3_IO30		0x1b0b0
+		>;
+	};
+
 	pinctrl_spdif: spdifgrp {
 		fsl,pins =3D <
 			MX6QDL_PAD_GPIO_17__SPDIF_OUT 0x1b0b0
@@ -681,6 +688,13 @@
 		>;
 	};
=20
+	pinctrl_usbc_id_1: usbc_id-1 {
+		fsl,pins =3D <
+			/* USBC_ID */
+			MX6QDL_PAD_NANDF_D2__GPIO2_IO02		0x1b0b0
+		>;
+	};
+
 	pinctrl_usdhc1: usdhc1grp {
 		fsl,pins =3D <
 			MX6QDL_PAD_SD1_CMD__SD1_CMD	0x17071
--=20
2.22.0

