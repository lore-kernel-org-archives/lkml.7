Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D1CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 09:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2C3E20863
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 09:31:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="sFNJL44v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730345AbfCYJbE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 05:31:04 -0400
Received: from mail-eopbgr20071.outbound.protection.outlook.com ([40.107.2.71]:8686
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730137AbfCYJbD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 05:31:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZMGjj8DEBrM1TwZWr9oOYH3d/mVjI1y5t+lANt0POas=;
 b=sFNJL44vtnLeXmH8Z6eNmELk/rte5hD43INkV55TUwE5K/vKc7hTgxZUK8z/p3Frsl2EqWsTjqX6+RLC0kXtPMF5AK9WA3vLtLiPaYkQ9jpUG8d3/e7TFiemjFfP6fbwxR+EtetZDzOlZPOsYJwKGfZ8oSStgDYaz7oTJ5kPd+A=
Received: from DB7PR04MB5163.eurprd04.prod.outlook.com (20.176.235.75) by
 DB7PR04MB5308.eurprd04.prod.outlook.com (20.176.236.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.16; Mon, 25 Mar 2019 09:30:58 +0000
Received: from DB7PR04MB5163.eurprd04.prod.outlook.com
 ([fe80::6869:c937:7d2:d60b]) by DB7PR04MB5163.eurprd04.prod.outlook.com
 ([fe80::6869:c937:7d2:d60b%5]) with mapi id 15.20.1730.019; Mon, 25 Mar 2019
 09:30:58 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        Claudiu Manoil <claudiu.manoil@nxp.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: [PATCH] ARM: dts: ls1021: Fix SGMII PCS link remaining down after PHY
 disconnect
Thread-Topic: [PATCH] ARM: dts: ls1021: Fix SGMII PCS link remaining down
 after PHY disconnect
Thread-Index: AQHU4u10/As1+FdGfk+r8tl5GBIdhQ==
Date:   Mon, 25 Mar 2019 09:30:58 +0000
Message-ID: <1553506240-2584-1-git-send-email-vladimir.oltean@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: VI1PR03CA0071.eurprd03.prod.outlook.com
 (2603:10a6:803:50::42) To DB7PR04MB5163.eurprd04.prod.outlook.com
 (2603:10a6:10:1d::11)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vladimir.oltean@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [212.146.100.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fefcc352-356e-420b-f935-08d6b10496ab
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB5308;
x-ms-traffictypediagnostic: DB7PR04MB5308:
x-microsoft-antispam-prvs: <DB7PR04MB5308E4D566FFA27D2D3DBF58E05E0@DB7PR04MB5308.eurprd04.prod.outlook.com>
x-forefront-prvs: 0987ACA2E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(396003)(346002)(376002)(366004)(199004)(189003)(71200400001)(71190400001)(4326008)(102836004)(476003)(2616005)(486006)(97736004)(86362001)(44832011)(6506007)(14454004)(386003)(6512007)(6116002)(53936002)(26005)(68736007)(186003)(3846002)(256004)(14444005)(5660300002)(7736002)(305945005)(99286004)(6636002)(25786009)(316002)(478600001)(110136005)(54906003)(2906002)(106356001)(8936002)(2501003)(105586002)(66066001)(52116002)(6486002)(36756003)(50226002)(6436002)(81156014)(8676002)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB5308;H:DB7PR04MB5163.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: l17En+ejIEF9Rele+N292iRCSRocbPow5b7oL1LtuwFBzq4yxaSeYNK0ExPCTmrIfQ3SyCOax0O5ZamybXJKMmtPFKjPeAUZ8Lot3btzHDBwN9/bk7/dGNoP06JYM8BCvFm2WVUBxhL1vVXODaJgYsmGc5JYuNoWcDjOkHGPi3pQ1pRN4pL71pIzD4AajCu/JjKZD+tTsN+YiCQKT6ABx5ACJYPniYY4B2PanpiTFHSHe/j5Uiw97HezYfODgtFEkHoTLkqtcp7yx/HgelS4+uNYtri/avIQiBAz7/389IJr5Vd2mKl2H/IBjUmMJoD1jYFkJNOnHHLBJXehTjN1fV/ynP4/fXzAkD/DM9GshlD8EzbcO+3AlJDAivV0xHCtAaIWdpMITTMItPV9oIEUK/b/ABbuKt3kfZa5LGJlLGU=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fefcc352-356e-420b-f935-08d6b10496ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2019 09:30:58.8924
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5308
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each eTSEC MAC has its own TBI (SGMII) PCS and private MDIO bus.
But due to a DTS oversight, both SGMII-compatible MACs of the LS1021 SoC
are pointing towards the same internal PCS. Therefore nobody is
controlling the internal PCS of eTSEC0.

Upon initial ndo_open, the SGMII link is ok by virtue of U-boot
initialization. But upon an ifdown/ifup sequence, the code path from
ndo_open -> init_phy -> gfar_configure_serdes does not get executed for
the PCS of eTSEC0 (and is executed twice for MAC eTSEC1). So the SGMII
link remains down for eTSEC0. On the LS1021A-TWR board, to signal this
failure condition, the PHY driver keeps printing
'803x_aneg_done: SGMII link is not ok'.

Fixes: 055223d4d22d ("ARM: dts: ls1021a: Enable the eTSEC ports on QDS and =
TWR")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 arch/arm/boot/dts/ls1021a-twr.dts | 9 ++++++++-
 arch/arm/boot/dts/ls1021a.dtsi    | 9 +++++++++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/ls1021a-twr.dts b/arch/arm/boot/dts/ls1021a-=
twr.dts
index 97e1fb7..9b1fe99 100644
--- a/arch/arm/boot/dts/ls1021a-twr.dts
+++ b/arch/arm/boot/dts/ls1021a-twr.dts
@@ -145,7 +145,7 @@
 };
=20
 &enet0 {
-	tbi-handle =3D <&tbi1>;
+	tbi-handle =3D <&tbi0>;
 	phy-handle =3D <&sgmii_phy2>;
 	phy-connection-type =3D "sgmii";
 	status =3D "okay";
@@ -225,6 +225,13 @@
 	sgmii_phy2: ethernet-phy@2 {
 		reg =3D <0x2>;
 	};
+	tbi0: tbi-phy@1f {
+		reg =3D <0x1f>;
+		device_type =3D "tbi-phy";
+	};
+};
+
+&mdio1 {
 	tbi1: tbi-phy@1f {
 		reg =3D <0x1f>;
 		device_type =3D "tbi-phy";
diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dts=
i
index b4f2723..3a3d264 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -709,6 +709,15 @@
 			      <0x0 0x2d10030 0x0 0x4>;
 		};
=20
+		mdio1: mdio@2d64000 {
+			compatible =3D "gianfar";
+			device_type =3D "mdio";
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			reg =3D <0x0 0x2d64000 0x0 0x4000>,
+			      <0x0 0x2d50030 0x0 0x4>;
+		};
+
 		ptp_clock@2d10e00 {
 			compatible =3D "fsl,etsec-ptp";
 			reg =3D <0x0 0x2d10e00 0x0 0xb0>;
--=20
2.7.4

