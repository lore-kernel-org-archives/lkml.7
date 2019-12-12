Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76042C2D0C6
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 03:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B0FE2173E
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 03:19:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rwcZY6UM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbfLLDTd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 22:19:33 -0500
Received: from mail-eopbgr30064.outbound.protection.outlook.com ([40.107.3.64]:60992
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726638AbfLLDTd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 22:19:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SA74HZ/T7X6oNtscmaQD0dbXsn9XinPI+APt8yJi5IXh7qiu+aqd1tRGB1vN39cC30WWNsYcZ4rIw80vF4uipaP5PKS3/0TzCwu44z0BoYZJlQtB8oMDNBRaCvLAvJn5NSJt09HyFR9WwjJVZusqOQH0hLJCviAvrmZL28wTIwD6q6AIom+x2j2ncLwD+YuoWSDi9oUku0TCEqDSREjLnnWmewYmHVX0EKarbBmhscDrzztOwW6JLud2r7F7d4VACxrpJGhkasNXaO5OPy3QAVUGL0SCT9YkBqQNhbi8qsT7tVFeiPuOVqjvEYddXtJQHoFTIR1tW41wxFWKO84pfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DAwjKxvnVC+zMuAx21ydKprAKexJLCOi4NMZvk1QE0w=;
 b=EXF4s05e7C2B4vh228Jc8Pxwx9R+jLlMMlqfqIolJh01B/TXuZJ6dKoiC6VJD+fsL0bv5ddGDbq8RqrevRvoEns6Bhbq3t7xd1NHgJCnDv035P1nkZzNzD1F3tBIMvmj1r1xdECsvjRCYN/1xjKus497K2vigFh2IdYVWFPdgm6QoaqDd5uBdvuAMI2DvgmPIlI9xqQAPbA0vgjPjLT1wweyVwejCJBaAug0AKLuTVXwgMZ3PN82rjPi30eUn05RZ0h3pEMSuIO4JXOjpLlUjyNoAnnlo8L6m/UUKdzkNncMSaggolz1LlWOt9IH11qsU2dHFF0qV6ugFs+HnYKd9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DAwjKxvnVC+zMuAx21ydKprAKexJLCOi4NMZvk1QE0w=;
 b=rwcZY6UM9Ugjg5phXiNJ3jTQeNFaFKyCXM2qIj4YDyIb/eSkl1TBzcyU5fAmLjdpHBT2yt8Y3q2A2CZui10aQw8tD5i/GU5K5n1pLA+J2qVW1+PXoFMqE3QjrqJtZ0X4l8pywhXKByNymFg5vlTD+o23y51oxx13yvMy2zpvHHg=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6756.eurprd04.prod.outlook.com (10.255.182.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.16; Thu, 12 Dec 2019 03:19:25 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::505:87e7:6b49:3d29]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::505:87e7:6b49:3d29%7]) with mapi id 15.20.2538.017; Thu, 12 Dec 2019
 03:19:25 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Jun Li <jun.li@nxp.com>, Abel Vesa <abel.vesa@nxp.com>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "angus@akkea.ca" <angus@akkea.ca>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] arm64: dts: imx8m: drop "fsl,aips-bus" and
 "fsl,imx8mq-aips-bus"
Thread-Topic: [PATCH] arm64: dts: imx8m: drop "fsl,aips-bus" and
 "fsl,imx8mq-aips-bus"
Thread-Index: AQHVsJr0430+yrGMXkiqegeAayzdJw==
Date:   Thu, 12 Dec 2019 03:19:25 +0000
Message-ID: <1576120601-28698-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR04CA0076.apcprd04.prod.outlook.com
 (2603:1096:202:15::20) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 26512b2c-2412-4f7d-3186-08d77eb216f7
x-ms-traffictypediagnostic: AM0PR04MB6756:|AM0PR04MB6756:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB675619A221046213CCDCE4B688550@AM0PR04MB6756.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-forefront-prvs: 0249EFCB0B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(366004)(396003)(376002)(39860400002)(189003)(199004)(8936002)(81156014)(81166006)(71200400001)(6512007)(7416002)(2616005)(54906003)(186003)(6486002)(26005)(8676002)(4326008)(52116002)(86362001)(6506007)(110136005)(316002)(66476007)(66446008)(66946007)(64756008)(66556008)(2906002)(478600001)(36756003)(44832011)(5660300002)(32563001)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6756;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XN+8r7HR3a7tynccVF5m3CzcxwCKXIvper7rRhhSMPvhzXsRneLWRdQqk5BPfq+ikOnbq8jRlaFQwCUL511B8bWGyHcnf33GuuYUp2YlQhAyMumybYrrtuxGKUe/mIXya1H6AtpKkUPqfPl4GQ1+R4f8lkEzNXirTyqXc3yRO63Suw96YuueMp6lMM8Iqcnwq/g8A7fmhXlcVvD42oW+cgxDO+fV6AQLQva6UfUUtws59bwwQDbllqTtSaO0X90Z02MWGf8+m0o470mmlP0+sT/SgZ255SEF9PK+iw3x42rlF4PQgQJJtxAnYm6AVmIA15nW1iJlDHjBra5TzuZMNHZXV9xRJePsimyAjSZCUeX+SupRofBZTNGygHyU6jmDiI1+dvlU0hY+qLirDoXKjbxMQUmRP9oq5PwIbeTH2U+S+UEGfUR13c1OXFO8NF3EUMlD1k846PsBCxdo6VXmIJATZt5F6KizunA8B7Pebh+PoyuJlcStNuC2vi1lQK8+1k7eEEZslc8qKa3b4JM4xQ==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26512b2c-2412-4f7d-3186-08d77eb216f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2019 03:19:25.2740
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g4HauRcp+eat25InHGbb7kEsJRCdwBeQBpNFaZVj9xN5hE598Aast0MflFUMjoF9kZTih12veOJN9tG7x8oZ3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6756
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

There is no binding doc for these compatible string
"fsl,imx8mq-aips-bus" and "fsl,aips-bus", "simple-bus" is enough
for aips usage, so drop the upper two.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mm.dtsi | 8 ++++----
 arch/arm64/boot/dts/freescale/imx8mn.dtsi | 8 ++++----
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 8 ++++----
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dt=
s/freescale/imx8mm.dtsi
index 20756440a420..a0dbf47ab320 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -232,7 +232,7 @@
 		ranges =3D <0x0 0x0 0x0 0x3e000000>;
=20
 		aips1: bus@30000000 {
-			compatible =3D "fsl,aips-bus", "simple-bus";
+			compatible =3D "simple-bus";
 			#address-cells =3D <1>;
 			#size-cells =3D <1>;
 			ranges =3D <0x30000000 0x30000000 0x400000>;
@@ -501,7 +501,7 @@
 		};
=20
 		aips2: bus@30400000 {
-			compatible =3D "fsl,aips-bus", "simple-bus";
+			compatible =3D "simple-bus";
 			#address-cells =3D <1>;
 			#size-cells =3D <1>;
 			ranges =3D <0x30400000 0x30400000 0x400000>;
@@ -560,7 +560,7 @@
 		};
=20
 		aips3: bus@30800000 {
-			compatible =3D "fsl,aips-bus", "simple-bus";
+			compatible =3D "simple-bus";
 			#address-cells =3D <1>;
 			#size-cells =3D <1>;
 			ranges =3D <0x30800000 0x30800000 0x400000>;
@@ -775,7 +775,7 @@
 		};
=20
 		aips4: bus@32c00000 {
-			compatible =3D "fsl,aips-bus", "simple-bus";
+			compatible =3D "simple-bus";
 			#address-cells =3D <1>;
 			#size-cells =3D <1>;
 			ranges =3D <0x32c00000 0x32c00000 0x400000>;
diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dt=
s/freescale/imx8mn.dtsi
index 5c47443ceb3d..cce65b9a861f 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
@@ -208,7 +208,7 @@
 		ranges =3D <0x0 0x0 0x0 0x3e000000>;
=20
 		aips1: bus@30000000 {
-			compatible =3D "fsl,aips-bus", "simple-bus";
+			compatible =3D "simple-bus";
 			reg =3D <0x30000000 0x400000>;
 			#address-cells =3D <1>;
 			#size-cells =3D <1>;
@@ -395,7 +395,7 @@
 		};
=20
 		aips2: bus@30400000 {
-			compatible =3D "fsl,aips-bus", "simple-bus";
+			compatible =3D "simple-bus";
 			reg =3D <0x30400000 0x400000>;
 			#address-cells =3D <1>;
 			#size-cells =3D <1>;
@@ -455,7 +455,7 @@
 		};
=20
 		aips3: bus@30800000 {
-			compatible =3D "fsl,aips-bus", "simple-bus";
+			compatible =3D "simple-bus";
 			reg =3D <0x30800000 0x400000>;
 			#address-cells =3D <1>;
 			#size-cells =3D <1>;
@@ -671,7 +671,7 @@
 		};
=20
 		aips4: bus@32c00000 {
-			compatible =3D "fsl,aips-bus", "simple-bus";
+			compatible =3D "simple-bus";
 			reg =3D <0x32c00000 0x400000>;
 			#address-cells =3D <1>;
 			#size-cells =3D <1>;
diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dt=
s/freescale/imx8mq.dtsi
index a9fe065e3cde..6a1e83922c71 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -290,7 +290,7 @@
 		dma-ranges =3D <0x40000000 0x0 0x40000000 0xc0000000>;
=20
 		bus@30000000 { /* AIPS1 */
-			compatible =3D "fsl,imx8mq-aips-bus", "simple-bus";
+			compatible =3D "simple-bus";
 			#address-cells =3D <1>;
 			#size-cells =3D <1>;
 			ranges =3D <0x30000000 0x30000000 0x400000>;
@@ -692,7 +692,7 @@
 		};
=20
 		bus@30400000 { /* AIPS2 */
-			compatible =3D "fsl,imx8mq-aips-bus", "simple-bus";
+			compatible =3D "simple-bus";
 			#address-cells =3D <1>;
 			#size-cells =3D <1>;
 			ranges =3D <0x30400000 0x30400000 0x400000>;
@@ -751,7 +751,7 @@
 		};
=20
 		bus@30800000 { /* AIPS3 */
-			compatible =3D "fsl,imx8mq-aips-bus", "simple-bus";
+			compatible =3D "simple-bus";
 			#address-cells =3D <1>;
 			#size-cells =3D <1>;
 			ranges =3D <0x30800000 0x30800000 0x400000>,
@@ -1023,7 +1023,7 @@
 		};
=20
 		bus@32c00000 { /* AIPS4 */
-			compatible =3D "fsl,imx8mq-aips-bus", "simple-bus";
+			compatible =3D "simple-bus";
 			#address-cells =3D <1>;
 			#size-cells =3D <1>;
 			ranges =3D <0x32c00000 0x32c00000 0x400000>;
--=20
2.16.4

