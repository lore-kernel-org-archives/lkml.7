Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA1DCA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 10:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EDEF214AE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 10:19:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="AMKA9Ete"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbfJUKT1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 06:19:27 -0400
Received: from mail-eopbgr30045.outbound.protection.outlook.com ([40.107.3.45]:15395
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727990AbfJUKT0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 06:19:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UV2cgFS4qnbVVIlMMvNUDlX9dIyJkHPTw9uMydpo0ymJkXV7ejRSCjYC9B+wRvXJhfjLj6aBK/yeN10tbErtYfOnKyZKDIbaMpMYkXZsn1S348yMr07z4k6xFW1G90LJcX31is4wOToh0P3yp34HofNOOTC8nOfvUdMd/qd/ae1eBtmd+/0BggQHaid0m0w5W5yPl0253bnzfdY55LZm8TXhbWYCYRZ4YoeRox8BKjRsLsagtq/DH2GMmpno18vLQ2oHVVgHG4m8lYAnvGwwTIFToiCJiW8J9b2+T9t7pDCj9rJsi6oG8dBKMo4K68oiAQ/NYa28MxhEKzmjFRcN8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rb3kSKhCCgj/VnuMPW8//aDM48rvoRPK1bjoviziOaw=;
 b=oOwSzLFcuSWFOlm4wHVsE3/r3GB+W+GR5Sh+QHG60AvjKxrrtDV9eT1+P3ukv5QthlvPy5ZR2S4BJWmLrfVNGVfhG3rZBpnddL/AV+Ainx+RQS4zANr2xSkGkbWcuoII1AGvYOGoJUEXAVHW6AT+IiyIXM4iClKdXeMZPe0snTLTCmB6pYleYXR8zcazOAsFnuSVoQphRuOUIoevni51qIZ+okEqihOgV21vdxU/ydMjRtHF2fVWcUQgT3D/Bi5EoDNAjKGyI9XjzupPLY/pzLdxkhWxIX6g9Ib1MJK0LI1/KKt3SfEzriBESdXGUh6DpPQAWH6I/WBVydBQ5pw8Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rb3kSKhCCgj/VnuMPW8//aDM48rvoRPK1bjoviziOaw=;
 b=AMKA9Ete3ABkSaTrpbkciioPmLtJtOZQrBdIt6y5cEg08QbwwrPAMu7QR0ewm28KM9qAPoDT9IwHteMmzpF/zHyyEaHeZQm0rmwYuqxRu2OF6ecjtJQqFXEtRfy7JvRZTRf9qETgOm59VTYY5evMgkgoAzuNOqkIMxtvQbblph8=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6401.eurprd04.prod.outlook.com (20.179.254.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.20; Mon, 21 Oct 2019 10:19:23 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::843c:e722:27cb:74e1]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::843c:e722:27cb:74e1%5]) with mapi id 15.20.2347.028; Mon, 21 Oct 2019
 10:19:23 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, Jun Li <jun.li@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Duan <fugang.duan@nxp.com>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 2/2] arm64: dts: imx8mn-ddr4-evk: add phy-reset-gpios for
 fec1
Thread-Topic: [PATCH V2 2/2] arm64: dts: imx8mn-ddr4-evk: add phy-reset-gpios
 for fec1
Thread-Index: AQHVh/kCgreL1pe0zkuEohh3uUIwxA==
Date:   Mon, 21 Oct 2019 10:19:23 +0000
Message-ID: <1571652977-4754-2-git-send-email-peng.fan@nxp.com>
References: <1571652977-4754-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1571652977-4754-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0016.apcprd03.prod.outlook.com
 (2603:1096:203:2e::28) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f5a99556-7280-4800-2068-08d7561024a8
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: AM0PR04MB6401:|AM0PR04MB6401:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB64018F14339679942EA6F00C88690@AM0PR04MB6401.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:175;
x-forefront-prvs: 0197AFBD92
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(346002)(366004)(136003)(376002)(199004)(189003)(66066001)(3846002)(8676002)(8936002)(2906002)(50226002)(81156014)(11346002)(25786009)(2201001)(81166006)(486006)(476003)(86362001)(478600001)(44832011)(2501003)(76176011)(446003)(14454004)(66476007)(66556008)(64756008)(66446008)(66946007)(2616005)(52116002)(6116002)(305945005)(71200400001)(5660300002)(71190400001)(99286004)(186003)(316002)(7736002)(386003)(4744005)(102836004)(36756003)(6486002)(256004)(110136005)(4326008)(26005)(6512007)(54906003)(6436002)(6506007)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6401;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vm8Arn84pn1egn8BMDKNW8Bb6UYOOtLujqAeqQbwLFkwiI1PAbsSeT6UlmmePZ80W/k6Shusnr8B7U6MCx2GNtTRo97myWsyRMS8ktApeXCKPurTCsj5zKoTTwG22QktCEIJMzU+8lJOwICT9kzwa+BVgqE2VpO+NUbyF5M1NxoU1SpZBtd7pgXtkmdTSQBhMbPdzeOx73DnNaHVxtQ1fjQNNo/1nYapUu9JDFpINFjiHAjvKTEzHp95Uldpl8NU8YHzRqMap1uekBC+LxSOT5qP+Bjq+aciAtmasYdqUsomcOknGFuwv2WjDqLOKUH6gmnhyRqMMbt2iP50Z791R7/evwADVpJO/dQDzHnz1p1rVJabsBGomR0zgtp7AKPxNE+hJcQ9JogGfvRYi+OSr9NK/f7cLFQBqn1guTfjBYY+qmbZCzx3CkMdbqTI1CIP
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5a99556-7280-4800-2068-08d7561024a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2019 10:19:23.4895
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YDz3WcgIXoFhilIJTqiYO3Tye93c637s8djBgAaUMVZS8kaCa6KH4LIMVj4+4T80s41n90zkI8lQKqfsEb1gkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6401
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

We should not rely on bootloader to configure the phy reset.
So introduce phy-reset-gpios property to let Linux handle phy reset
itself.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V2:
 U-Boot->bootloader

 arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dts b/arch/arm64=
/boot/dts/freescale/imx8mn-ddr4-evk.dts
index 1b90faace1d3..761ba0b5d271 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dts
@@ -48,6 +48,7 @@
 	pinctrl-0 =3D <&pinctrl_fec1>;
 	phy-mode =3D "rgmii-id";
 	phy-handle =3D <&ethphy0>;
+	phy-reset-gpios =3D <&gpio4 22 GPIO_ACTIVE_LOW>;
 	fsl,magic-packet;
 	status =3D "okay";
=20
--=20
2.16.4

