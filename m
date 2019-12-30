Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F219C2D0CE
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 08:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E709F2071E
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 08:58:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="njbzwYsE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbfL3I6M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 03:58:12 -0500
Received: from mail-eopbgr10076.outbound.protection.outlook.com ([40.107.1.76]:1446
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727275AbfL3I6M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 03:58:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L9KX9d85NqnV2/N5OoxMepXnOS4jJe0eVhOPGFjIj3BhWdwyjoIcud1zZjwDfdggufdS7WaKxoFOblHAiW5mQPI3FsSSwCSNSyl68BRiv4aVf3vf3BdQkCRsmhAQSOIAjkZcfYsH4Aw2KrssxkZtWPElAzPhBfjRJ6EsZVc6/KmLv1BzeFZFWaN60Udef35ZSvGxzNlIH78Y4CCbuYEkIrhCwrVxgyvI+8+gfVW4hN4zJrV2IJ369PrnmeSVWU8uLd8FU7K8EpUYGF/QbBCxmDj4+0jLBAxVzMCuREqBEANBIERHZiVzVSTjCOBTeu7c+lYKJLgy0jCPozhK1Pr5QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mmTu3+i7Yqq72kIOuk2jLjaiNASzhYBQ1y1Z4zZteow=;
 b=Po2KBHEwlP02YAr7/EiIM1uTdp1yB57hIcc0nPAjn9R2YT7xsamhZZx3Thtc97zv2ykaMmSCLxeg0auFX7SE2sp7zN3dPRxOEOC6RTYKF+Sl13Cuulu2npXpPWJkvvAUCIqCekZQiw6sm8w+VWiBXqiejv1hquazgy8hiiwHFNGpaieys7lCjD2qWOnRiNzQE0KVIqM3a33a14NwS0N56+CiZhm5uyyfIzwQ3z0Wmt8fA5o4nfrVtBKG7K/xXDg5dsj0+m3g1F7gfMwv9oKErJMHwUYsVLArGvteCv9ntRe/4RA6uprhCCylxvRKLZQNXp/IdsHfm5anEyOjmeoIrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mmTu3+i7Yqq72kIOuk2jLjaiNASzhYBQ1y1Z4zZteow=;
 b=njbzwYsEIDDB3MgSXNncW6xpLvU01yj13aspbnwFPI/DPvcqpN4U8LUTrC6zOF1CMkJoaow4xwi1aZY+ZOtlwEmn5tZW1D1euPY4abANbcAx0bvWpXEa5h96uxELwPibsxFBMmqqVNjQgikC4q/wCiY1KHAOKDhnZhwKbnRZPtc=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4961.eurprd04.prod.outlook.com (20.177.42.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2581.12; Mon, 30 Dec 2019 08:58:06 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::c58c:e631:a110:ba58]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::c58c:e631:a110:ba58%6]) with mapi id 15.20.2581.007; Mon, 30 Dec 2019
 08:58:06 +0000
Received: from localhost.localdomain (119.31.174.67) by HK2PR03CA0051.apcprd03.prod.outlook.com (2603:1096:202:17::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2602.6 via Frontend Transport; Mon, 30 Dec 2019 08:58:02 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alice Guo <alice.guo@nxp.com>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] ARM: dts: imx: drop "fsl,aips-bus"
Thread-Topic: [PATCH] ARM: dts: imx: drop "fsl,aips-bus"
Thread-Index: AQHVvu9AXeMfpR61Rke6CNGr+daIZA==
Date:   Mon, 30 Dec 2019 08:58:05 +0000
Message-ID: <1577696078-21720-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR03CA0051.apcprd03.prod.outlook.com
 (2603:1096:202:17::21) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5b87a5b8-f2bc-4ae2-fba6-08d78d066279
x-ms-traffictypediagnostic: AM0PR04MB4961:|AM0PR04MB4961:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB4961199CCCACB9F5548CABAE88270@AM0PR04MB4961.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:157;
x-forefront-prvs: 0267E514F9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(366004)(376002)(39860400002)(136003)(189003)(199004)(66476007)(66556008)(956004)(86362001)(44832011)(16526019)(64756008)(66446008)(66946007)(26005)(6486002)(316002)(71200400001)(186003)(6506007)(81166006)(81156014)(8936002)(69590400006)(8676002)(2616005)(52116002)(36756003)(4326008)(54906003)(6512007)(110136005)(5660300002)(2906002)(478600001)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4961;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u1EyF1+DDnnprMteIpsxurLK3dqgClpdJfWoMieyZnxgHxc3BcXIeaNK0Jk1xxgkwLlDpRKkClsfuKiW3ocV1e/Kd2Ery4D9H8P1vLu6mcl9sN2v4kLOc3Z8V9nda/YPXJhIq3OCno/DCEaVpBkjlxA1eQaA++WkuW5l5lmQPMoBTNiaZpLH7A6nRNT/ze9+ka7cJhnWtspI3QUbgiTPKe/qY2FO3MvmV0RRWrn5eqH0K/jj/ZDspxxep7J/2X8daB+kOoYPlXtJbNCZgq6vLfgOJsuECoMVoO8Dy5nIX+rMq08BN0b5dnUR1gkIf0tikAdFLgH9/ZYTQLcwqOEZOqid5KoM/+nw4erURlOKXuQGr/IGjF4hGRNa+zD5fxUYKfLHPyqTHxdqkXCCBDm4OMcLyMd41rW94U6s/1j0P6wtcEgy1SSr41pw7mj6xcPN8gj0W1geiUchxiMLmkLTMmyU4j3vkIKCvWZifVa6q2i/P60dzz2teZDv2ME8PpzfRzSh/UmIM7tqQXgEMJwbdw==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b87a5b8-f2bc-4ae2-fba6-08d78d066279
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Dec 2019 08:58:05.9954
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rHw664M+X1d9MggLhLtpKvwOFTkDbGB0YQBocBVLLIYldfgZfYJWCv3t7ZCs2kEfly9NZQ4zpfazoqHkNaDP6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4961
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

There is no binding doc for "fsl,aips-bus", "simple-bus" is enough
for aips usage, so drop it.

Scirpt:
sed -i 's/compatible =3D "fsl,aips-bus", "simple-bus";/compatible =3D "simp=
le-bus";/'
arch/arm/boot/dts/imx*

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/boot/dts/imx25.dtsi   | 4 ++--
 arch/arm/boot/dts/imx31.dtsi   | 4 ++--
 arch/arm/boot/dts/imx50.dtsi   | 4 ++--
 arch/arm/boot/dts/imx51.dtsi   | 4 ++--
 arch/arm/boot/dts/imx53.dtsi   | 4 ++--
 arch/arm/boot/dts/imx6qdl.dtsi | 4 ++--
 arch/arm/boot/dts/imx6sl.dtsi  | 4 ++--
 arch/arm/boot/dts/imx6sll.dtsi | 4 ++--
 arch/arm/boot/dts/imx6sx.dtsi  | 6 +++---
 arch/arm/boot/dts/imx6ul.dtsi  | 4 ++--
 arch/arm/boot/dts/imx6ull.dtsi | 2 +-
 arch/arm/boot/dts/imx7s.dtsi   | 6 +++---
 12 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
index 40b95a290bd6..3b7a0b249d80 100644
--- a/arch/arm/boot/dts/imx25.dtsi
+++ b/arch/arm/boot/dts/imx25.dtsi
@@ -76,7 +76,7 @@
 		ranges;
=20
 		aips@43f00000 { /* AIPS1 */
-			compatible =3D "fsl,aips-bus", "simple-bus";
+			compatible =3D "simple-bus";
 			#address-cells =3D <1>;
 			#size-cells =3D <1>;
 			reg =3D <0x43f00000 0x100000>;
@@ -333,7 +333,7 @@
 		};
=20
 		aips@53f00000 { /* AIPS2 */
-			compatible =3D "fsl,aips-bus", "simple-bus";
+			compatible =3D "simple-bus";
 			#address-cells =3D <1>;
 			#size-cells =3D <1>;
 			reg =3D <0x53f00000 0x100000>;
diff --git a/arch/arm/boot/dts/imx31.dtsi b/arch/arm/boot/dts/imx31.dtsi
index 6b62f0745b82..b0e7e3bf8a1a 100644
--- a/arch/arm/boot/dts/imx31.dtsi
+++ b/arch/arm/boot/dts/imx31.dtsi
@@ -64,7 +64,7 @@
 		};
=20
 		aips@43f00000 { /* AIPS1 */
-			compatible =3D "fsl,aips-bus", "simple-bus";
+			compatible =3D "simple-bus";
 			#address-cells =3D <1>;
 			#size-cells =3D <1>;
 			reg =3D <0x43f00000 0x100000>;
@@ -226,7 +226,7 @@
 		};
=20
 		aips@53f00000 { /* AIPS2 */
-			compatible =3D "fsl,aips-bus", "simple-bus";
+			compatible =3D "simple-bus";
 			#address-cells =3D <1>;
 			#size-cells =3D <1>;
 			reg =3D <0x53f00000 0x100000>;
diff --git a/arch/arm/boot/dts/imx50.dtsi b/arch/arm/boot/dts/imx50.dtsi
index 0bfe7c91d0eb..961de09b571d 100644
--- a/arch/arm/boot/dts/imx50.dtsi
+++ b/arch/arm/boot/dts/imx50.dtsi
@@ -102,7 +102,7 @@
 		ranges;
=20
 		aips@50000000 { /* AIPS1 */
-			compatible =3D "fsl,aips-bus", "simple-bus";
+			compatible =3D "simple-bus";
 			#address-cells =3D <1>;
 			#size-cells =3D <1>;
 			reg =3D <0x50000000 0x10000000>;
@@ -390,7 +390,7 @@
 		};
=20
 		aips@60000000 {	/* AIPS2 */
-			compatible =3D "fsl,aips-bus", "simple-bus";
+			compatible =3D "simple-bus";
 			#address-cells =3D <1>;
 			#size-cells =3D <1>;
 			reg =3D <0x60000000 0x10000000>;
diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
index dea86b98e9c3..86708688371b 100644
--- a/arch/arm/boot/dts/imx51.dtsi
+++ b/arch/arm/boot/dts/imx51.dtsi
@@ -159,7 +159,7 @@
 		};
=20
 		aips@70000000 { /* AIPS1 */
-			compatible =3D "fsl,aips-bus", "simple-bus";
+			compatible =3D "simple-bus";
 			#address-cells =3D <1>;
 			#size-cells =3D <1>;
 			reg =3D <0x70000000 0x10000000>;
@@ -441,7 +441,7 @@
 		};
=20
 		aips@80000000 {	/* AIPS2 */
-			compatible =3D "fsl,aips-bus", "simple-bus";
+			compatible =3D "simple-bus";
 			#address-cells =3D <1>;
 			#size-cells =3D <1>;
 			reg =3D <0x80000000 0x10000000>;
diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index ed341cfd9d09..f46a83c7d2c4 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -223,7 +223,7 @@
 		};
=20
 		aips@50000000 { /* AIPS1 */
-			compatible =3D "fsl,aips-bus", "simple-bus";
+			compatible =3D "simple-bus";
 			#address-cells =3D <1>;
 			#size-cells =3D <1>;
 			reg =3D <0x50000000 0x10000000>;
@@ -655,7 +655,7 @@
 		};
=20
 		aips@60000000 {	/* AIPS2 */
-			compatible =3D "fsl,aips-bus", "simple-bus";
+			compatible =3D "simple-bus";
 			#address-cells =3D <1>;
 			#size-cells =3D <1>;
 			reg =3D <0x60000000 0x10000000>;
diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dts=
i
index e6b4b8525f98..9b7635e9cf3c 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -295,7 +295,7 @@
 		};
=20
 		aips-bus@2000000 { /* AIPS1 */
-			compatible =3D "fsl,aips-bus", "simple-bus";
+			compatible =3D "simple-bus";
 			#address-cells =3D <1>;
 			#size-cells =3D <1>;
 			reg =3D <0x02000000 0x100000>;
@@ -936,7 +936,7 @@
 		};
=20
 		aips-bus@2100000 { /* AIPS2 */
-			compatible =3D "fsl,aips-bus", "simple-bus";
+			compatible =3D "simple-bus";
 			#address-cells =3D <1>;
 			#size-cells =3D <1>;
 			reg =3D <0x02100000 0x100000>;
diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index 59c54e6ad09a..4b4f22217dfe 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -144,7 +144,7 @@
 		};
=20
 		aips1: aips-bus@2000000 {
-			compatible =3D "fsl,aips-bus", "simple-bus";
+			compatible =3D "simple-bus";
 			#address-cells =3D <1>;
 			#size-cells =3D <1>;
 			reg =3D <0x02000000 0x100000>;
@@ -787,7 +787,7 @@
 		};
=20
 		aips2: aips-bus@2100000 {
-			compatible =3D "fsl,aips-bus", "simple-bus";
+			compatible =3D "simple-bus";
 			#address-cells =3D <1>;
 			#size-cells =3D <1>;
 			reg =3D <0x02100000 0x100000>;
diff --git a/arch/arm/boot/dts/imx6sll.dtsi b/arch/arm/boot/dts/imx6sll.dts=
i
index a1bc5bb31756..fac8f22255aa 100644
--- a/arch/arm/boot/dts/imx6sll.dtsi
+++ b/arch/arm/boot/dts/imx6sll.dtsi
@@ -145,7 +145,7 @@
 		};
=20
 		aips1: aips-bus@2000000 {
-			compatible =3D "fsl,aips-bus", "simple-bus";
+			compatible =3D "simple-bus";
 			#address-cells =3D <1>;
 			#size-cells =3D <1>;
 			reg =3D <0x02000000 0x100000>;
@@ -664,7 +664,7 @@
 		};
=20
 		aips2: aips-bus@2100000 {
-			compatible =3D "fsl,aips-bus", "simple-bus";
+			compatible =3D "simple-bus";
 			#address-cells =3D <1>;
 			#size-cells =3D <1>;
 			reg =3D <0x02100000 0x100000>;
diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index 59bad60a47dc..4499be62c8bb 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -236,7 +236,7 @@
 		};
=20
 		aips1: aips-bus@2000000 {
-			compatible =3D "fsl,aips-bus", "simple-bus";
+			compatible =3D "simple-bus";
 			#address-cells =3D <1>;
 			#size-cells =3D <1>;
 			reg =3D <0x02000000 0x100000>;
@@ -831,7 +831,7 @@
 		};
=20
 		aips2: aips-bus@2100000 {
-			compatible =3D "fsl,aips-bus", "simple-bus";
+			compatible =3D "simple-bus";
 			#address-cells =3D <1>;
 			#size-cells =3D <1>;
 			reg =3D <0x02100000 0x100000>;
@@ -1189,7 +1189,7 @@
 		};
=20
 		aips3: aips-bus@2200000 {
-			compatible =3D "fsl,aips-bus", "simple-bus";
+			compatible =3D "simple-bus";
 			#address-cells =3D <1>;
 			#size-cells =3D <1>;
 			reg =3D <0x02200000 0x100000>;
diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index d9fdca12819b..63d276fc2477 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -205,7 +205,7 @@
 		};
=20
 		aips1: aips-bus@2000000 {
-			compatible =3D "fsl,aips-bus", "simple-bus";
+			compatible =3D "simple-bus";
 			#address-cells =3D <1>;
 			#size-cells =3D <1>;
 			reg =3D <0x02000000 0x100000>;
@@ -772,7 +772,7 @@
 		};
=20
 		aips2: aips-bus@2100000 {
-			compatible =3D "fsl,aips-bus", "simple-bus";
+			compatible =3D "simple-bus";
 			#address-cells =3D <1>;
 			#size-cells =3D <1>;
 			reg =3D <0x02100000 0x100000>;
diff --git a/arch/arm/boot/dts/imx6ull.dtsi b/arch/arm/boot/dts/imx6ull.dts=
i
index b7e67d121322..633fa08bc972 100644
--- a/arch/arm/boot/dts/imx6ull.dtsi
+++ b/arch/arm/boot/dts/imx6ull.dtsi
@@ -52,7 +52,7 @@
 / {
 	soc {
 		aips3: aips-bus@2200000 {
-			compatible =3D "fsl,aips-bus", "simple-bus";
+			compatible =3D "simple-bus";
 			#address-cells =3D <1>;
 			#size-cells =3D <1>;
 			reg =3D <0x02200000 0x100000>;
diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index 139ab9b98472..552b14be14a1 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -317,7 +317,7 @@
 		};
=20
 		aips1: aips-bus@30000000 {
-			compatible =3D "fsl,aips-bus", "simple-bus";
+			compatible =3D "simple-bus";
 			#address-cells =3D <1>;
 			#size-cells =3D <1>;
 			reg =3D <0x30000000 0x400000>;
@@ -669,7 +669,7 @@
 		};
=20
 		aips2: aips-bus@30400000 {
-			compatible =3D "fsl,aips-bus", "simple-bus";
+			compatible =3D "simple-bus";
 			#address-cells =3D <1>;
 			#size-cells =3D <1>;
 			reg =3D <0x30400000 0x400000>;
@@ -809,7 +809,7 @@
 		};
=20
 		aips3: aips-bus@30800000 {
-			compatible =3D "fsl,aips-bus", "simple-bus";
+			compatible =3D "simple-bus";
 			#address-cells =3D <1>;
 			#size-cells =3D <1>;
 			reg =3D <0x30800000 0x400000>;
--=20
2.16.4

