Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBAB5C2D0CD
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 12:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2C2A21582
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 12:22:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZNenrH4d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfLRMWh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 07:22:37 -0500
Received: from mail-eopbgr20050.outbound.protection.outlook.com ([40.107.2.50]:15790
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726029AbfLRMWg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 07:22:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nMZTKDuJtSzPi0YXMVIBZt9VLe2lm8+gJ35mRKPjU7VNtwHa5LyCOPAonwrmBbIPhEKnMAIdfZZM1eYCilT4XBZ1nsFcwVxw8lJwFivu6UlQ60ALayWeJGUJHLfzgFZZaFiBXBr1etYW7fLFrcDm7TFI0Yi3U9FqI3u+PURSl42Yd/rgYijLh4qkdW4uSf9YeQ94ljnMOQyr2KPH4I5HnTl/kr/ybbYiaTUEjswYOmbbNP+LIwP4wF001wspz4jnu9QNksEqk5MkGN/Neggcl3rLZXCTqnJUfLOrpe+5iav/ElVyVCRgj+m73Yy5QtVd9u6U1V0pvzLtno4pBRJbPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tTuEKf/EFCkW1Qb+E8gvrSXlS3d4O/B7qA3Y/w4rAg4=;
 b=AIQRS95Tf6B4iRbxEwWbkqWIGA+s5ngNDgDOe3Op6vzr+c/gFqFOMWG1ORJffnoWqR9IKVPZAmchCRUeu/lOFVUJhs0v2Qfb+BmR5BlF1G1+OP00ci5Ez7Ftj/RpO/+EHU3IHM8pUA0A7BEjPZP1stywz0lB6lu6zd3k6XqAjiY+poKtGX1ap6CDgbHcel6tHzgECM7f7EPxNoOkoLpDuXqxOlG0+EdzsPSeqq1t4BOIkMz+wThKJFiMDPpW5jSMRpjauUUqjWVZtu4i6hT2qbPwP2VLAo+6+eq9aDBq/NSL5jUwOIuB63BdcyDKZrlqps51TUJ6cXF2/CCmOm+fjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tTuEKf/EFCkW1Qb+E8gvrSXlS3d4O/B7qA3Y/w4rAg4=;
 b=ZNenrH4d82KJjv2QBc/J3t1CE0Mw/zr7oUCjIpy48HS/rzDQc2tMqT/jgM9sQYwmdcGvG2kgqJ3/yV0rdXNsgYOshWweWvVv+XkC5brmykdH7wgJ/hBEueBXuxwhPYjI6S64hj/4B1Y88oiYwwIQz6yOqR5DE+CIQ7DyhiCnuhg=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4339.eurprd04.prod.outlook.com (52.134.126.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.18; Wed, 18 Dec 2019 12:22:32 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::505:87e7:6b49:3d29]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::505:87e7:6b49:3d29%7]) with mapi id 15.20.2559.012; Wed, 18 Dec 2019
 12:22:32 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "baruch@tkos.co.il" <baruch@tkos.co.il>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alice Guo <alice.guo@nxp.com>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2] arm: dts: imx7ulp: fix reg of cpu node
Thread-Topic: [PATCH V2] arm: dts: imx7ulp: fix reg of cpu node
Thread-Index: AQHVtZ3S73Uc6dGN4kqEDXQASKgQOQ==
Date:   Wed, 18 Dec 2019 12:22:32 +0000
Message-ID: <1576671574-14319-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR0302CA0015.apcprd03.prod.outlook.com
 (2603:1096:202::25) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ae239e32-a8e9-4754-33ee-08d783b4f494
x-ms-traffictypediagnostic: AM0PR04MB4339:|AM0PR04MB4339:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB4339CB32E29DA7F51A3763A688530@AM0PR04MB4339.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0255DF69B9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(366004)(136003)(346002)(39860400002)(376002)(189003)(199004)(52116002)(5660300002)(6506007)(54906003)(186003)(316002)(110136005)(2906002)(4326008)(86362001)(64756008)(26005)(81166006)(81156014)(8676002)(8936002)(6486002)(66476007)(66556008)(2616005)(36756003)(71200400001)(6512007)(44832011)(478600001)(66946007)(66446008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4339;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zeIt0R+qomnIKd8y0uT4leZgWbu7kvbMZjW4IuQSSN6J+V3L4rI48JaJCvL7le1/hV6vvNRVZxp3NPN+InrLVCWcrHUWRIVCrdfGxRbFS/CRM/LNqV4ieVgPZktlHcJxSZgoX21ybNBEhIdj8KgxiFTXQqht7/cPNkqORHOSAO9Ee4A5e5b46q9cVuP6TiQAXc6b3aMX2CT0b6bCQL4jT9hRWThNP7gGqgFKItvjFRFTHGHWiLqbcShvZEgKUFaYV3oeAD+WlwnfyZ4In+vqSje4F5xqI6ZXNDRyiEhNSYCe+ubZbFKetYJiPQUYD2sEhoxFTAcA4myXg0yb8onYpmgnCosa56F/m4BiCIC0VJmDa/bJL+wBYjAdL10k9epS6rxySc5Or7gTPFgNAWJow+UMFOCM7F3h6hpvIzOYXl6kIo4FauerZINs8PODh/wD
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae239e32-a8e9-4754-33ee-08d783b4f494
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2019 12:22:32.0187
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T2qj9/4AsgMtwiHIAv23FEAbeDvsbEdJXW/Xyfnagkmn87uZUwjJfOh+IEQVkf/0m0sTd7sFh4EIuEZ2KqjFfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4339
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

According to arm cpus binding doc,
"
      On 32-bit ARM v7 or later systems this property is
        required and matches the CPU MPIDR[23:0] register
        bits.

        Bits [23:0] in the reg cell must be set to
        bits [23:0] in MPIDR.

        All other bits in the reg cell must be set to 0.
"

In i.MX7ULP, the MPIDR[23:0] is 0xf00, not 0, so fix it.
Otherwise there will be warning:
"DT missing boot CPU MPIDR[23:0], fall back to default cpu_logical_map"

Fixes: 20434dc92c05 ("ARM: dts: imx: add common imx7ulp dtsi support")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V2:
 Fix suffix, from 0 -> f00

 arch/arm/boot/dts/imx7ulp.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx7ulp.dtsi b/arch/arm/boot/dts/imx7ulp.dts=
i
index d37a1927c88e..ab91c98f2124 100644
--- a/arch/arm/boot/dts/imx7ulp.dtsi
+++ b/arch/arm/boot/dts/imx7ulp.dtsi
@@ -37,10 +37,10 @@
 		#address-cells =3D <1>;
 		#size-cells =3D <0>;
=20
-		cpu0: cpu@0 {
+		cpu0: cpu@f00 {
 			compatible =3D "arm,cortex-a7";
 			device_type =3D "cpu";
-			reg =3D <0>;
+			reg =3D <0xf00>;
 		};
 	};
=20
--=20
2.16.4

