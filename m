Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E893C2D0CD
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 12:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09B672072B
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 12:03:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Pz6zak2k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfLRMDc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 07:03:32 -0500
Received: from mail-eopbgr10067.outbound.protection.outlook.com ([40.107.1.67]:64995
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726710AbfLRMDc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 07:03:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IneQ+aeGNYyx/SDRxdf6NVUrj4afFCGBOlhu8AN1HXSWq3zx+MsE8aIocieN/7WvQBRk5pMoq72ooNK79xNad5x8l7/pRLY0SthM1A4IjL+hNOn57gbXN0ydJapW7+QpyyTBjIvkE3S6SBAAI9+srdKI9Frw3BMLgrdf5p1KhYBFM11Tl5qv6cdPDYA7cR/KSD2KG6msV966qOpJpwjoiTi15C2G/lCGCMjIX+mV5515cKvSVuiKXIyLfe8RJGUDFTbjQZdwW8EaQC2oRUC/RvlftoOYM9V2UNTOdOz07n3jcxM2bG5nb2dqkexgJYXVcS0Fe9HLdMu200NMWSst9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PPejmARIY3bXlVxJaiO/1bWA33kWUWy9eLsu/vlv0oE=;
 b=FED9F13C9ksRMtjinOAFBTNrtvRHSahglhozvC8COlaASx70dwSoIs8p49rZ9dYsYjZrzCpdTl4Pe65jQ4ang/4oJv4Chvhxnx6E+rIUZNRUzVTE1ZwfqCx4kT+P3tiPwWVoEQDfUoiCVxGoXltupcE7jP3afO5DGp+pKQ+ZOwINGQroH+dItojyw3keJD3/s4tFRIRLuEb9iFMWCX+WHqV58yV42YVT2SJ7wlpSGOkvq8gwwgMFa5YPpvNv+dNjn4i0gzddCKqv73U7K+ilUN3NXen9FAoYmZ1dEgVDZ6rXw7biTa1vfR/PGtKIxCkRZ3WN6MKDYE/DvQ412mQI4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PPejmARIY3bXlVxJaiO/1bWA33kWUWy9eLsu/vlv0oE=;
 b=Pz6zak2kAX5hJUxCcKj0adTn2o4Gl4utw5Oe31Dks9PlZ5CpqINBqgvXYzbE0TsNDbXNubddB5+aurPOBvPQGOWYe/mW5tAqb05HM43YmnKAkVWETluV5NBwboxdVT7pqKBIQbGyQyfYMX7q0DBYIwkKS9Epgem0RhnpbotJhJw=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6148.eurprd04.prod.outlook.com (20.179.33.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Wed, 18 Dec 2019 12:03:25 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::505:87e7:6b49:3d29]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::505:87e7:6b49:3d29%7]) with mapi id 15.20.2559.012; Wed, 18 Dec 2019
 12:03:25 +0000
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
Subject: [PATCH] arm: dts: imx7ulp: fix reg of cpu node
Thread-Topic: [PATCH] arm: dts: imx7ulp: fix reg of cpu node
Thread-Index: AQHVtZsmfGvwTi+ciE+LrR2fcO2bIg==
Date:   Wed, 18 Dec 2019 12:03:25 +0000
Message-ID: <1576670430-14226-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR03CA0055.apcprd03.prod.outlook.com
 (2603:1096:202:17::25) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d7d7c33a-99b6-48a9-d40c-08d783b2492c
x-ms-traffictypediagnostic: AM0PR04MB6148:|AM0PR04MB6148:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB6148675D241CAD0A655EA44988530@AM0PR04MB6148.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0255DF69B9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(396003)(346002)(376002)(366004)(199004)(189003)(6512007)(4744005)(316002)(71200400001)(6486002)(26005)(110136005)(5660300002)(2906002)(54906003)(6506007)(81166006)(186003)(4326008)(64756008)(66946007)(86362001)(66476007)(66556008)(44832011)(36756003)(8676002)(81156014)(52116002)(478600001)(2616005)(8936002)(66446008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6148;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:3;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hWZhBeIhaQ3eTmXljcb2R6SX6G7kxxWQqegYs6SBg/SGKv+Ec5CYxEHzGPqSgSnjBMcB4dGVdTDlE+2poQHIhkiAJNkUsUNI3Ox42am5Up9Rla4symPL1Pj03Su5stsMUVR0DOcMH0BpYyIg4pqtyzyJfTIez32/JttXEPfpcrjA8ap9oaixD5gc477sncPcnHQCFe7HzXjPY9bDOYLDE0TFJKYehIdc0v8RP0i4Q3dbQ3927TtbGMF4XnR570tBezE09ByInIVgagQsmUO4CVeMi0o7x2qHwAsBQ8rRbGwCPdSIAmIdm+wj8yI/sajqmMZbv+FvZHEiFZJ0ftc0mtVcbDzXnUZibmRCv5bfHOBNP4JHAdJDUxAf0x9Y+pdwbg9Kyit47bMnyro4iDPIOv2SLZITRUv83vjywJGofkHpFQ5kTWnjI6pM0+drdO+k
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7d7c33a-99b6-48a9-d40c-08d783b2492c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2019 12:03:25.4794
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sLqCyxjb/6KwjXB4hCQmJEfgm4K0VuPP1bGSH81UhaZGUl+M7Lcfvt9umsrSqoiF/+sUzm2EMXUdu09NsSZYKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6148
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
 arch/arm/boot/dts/imx7ulp.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx7ulp.dtsi b/arch/arm/boot/dts/imx7ulp.dts=
i
index d37a1927c88e..aa9e50178d6b 100644
--- a/arch/arm/boot/dts/imx7ulp.dtsi
+++ b/arch/arm/boot/dts/imx7ulp.dtsi
@@ -40,7 +40,7 @@
 		cpu0: cpu@0 {
 			compatible =3D "arm,cortex-a7";
 			device_type =3D "cpu";
-			reg =3D <0>;
+			reg =3D <0xf00>;
 		};
 	};
=20
--=20
2.16.4

