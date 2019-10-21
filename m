Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DF60CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 09:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 345CA20684
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 09:21:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XkAHb7od"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbfJUJVr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 05:21:47 -0400
Received: from mail-eopbgr80044.outbound.protection.outlook.com ([40.107.8.44]:27207
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727562AbfJUJVp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 05:21:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bVy6ZlDC9A31pJInfs8PJKCf6WB0Bf5bNupxREqy3pVi2zJZDlrjp8J4NETHtkFl7gRynd81ggfJiqXcw0EUnfR+zPBcbc76Jd44u18ixZwWPwSaPZP2DKE1iwBQ8KVQMWJUaxwo7QBnNfOJFvYim98/WHuMV3hW/NDRz9xKA49BdwEB5U7qsm+cWvApK2Zu0UIjrbPAn9zaLzMzLw8q4swtCRtYXx3zsFVeGqGtifphK2OjCLCoPYyjJRTP1EGG55sMduBLpvH644PhLu6IcBDmo0OqJpeuhPdf3/il/XaO7FL95nrW5qs2E+20PsXuiTLrfuLjXj9Hd3+lo+etgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v5gctPXLz4GnxUVPmpDENuLArDIqPJHZgd0UrbV63Fo=;
 b=eqea+V58xXEnQKMlSu8RzPOa1eKBmOC+Y+mEriA5ndYRxXGqGFouiMd6f3pInO1O1egd9jyunbNMqfnJixw/Yy4IDALO7SVNBmOodBEEJAvID32we7sMB6I+8W8qLritbUrom+PDm2WedpNz2va+PoImN77fwJZIMgR43eVedNkxqeQxqUBkcGhQtRHQ/xXs48yy+0nQ5cvLQje0s/RKHwcHxh0dTqi2KO4Idsod3QBUkImfAlCJwKY7no+sJ86iDACXwrmg7stIx+ScpSfkS7NSVddXa/KQLXgcCUGP+b65jiNOwhIqhSHyUv0T9hk/debApzqBa/hcUYfq9sOryQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v5gctPXLz4GnxUVPmpDENuLArDIqPJHZgd0UrbV63Fo=;
 b=XkAHb7od1KS0zl1pKw+OfFycUt2NgCqctWpnccLegmOtNmxfxya19B17/CQJ7ZDazmGRJvdisP3sSwv+fDZgA3YBxDl6nD4nhmJoQDmpM3SJq4t487YCnTASNnQOLPjDr14HlqoZUlPkWsEYf3W0N/GQAOpCP9WXbTMdH4rzrUQ=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6788.eurprd04.prod.outlook.com (10.255.225.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.17; Mon, 21 Oct 2019 09:21:41 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::843c:e722:27cb:74e1]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::843c:e722:27cb:74e1%5]) with mapi id 15.20.2347.028; Mon, 21 Oct 2019
 09:21:41 +0000
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
Subject: [PATCH 2/2] arm64: dts: imx8mn-ddr4-evk: add phy-reset-gpios for fec1
Thread-Topic: [PATCH 2/2] arm64: dts: imx8mn-ddr4-evk: add phy-reset-gpios for
 fec1
Thread-Index: AQHVh/DynXIOTbJASESwus6Kg3G3tw==
Date:   Mon, 21 Oct 2019 09:21:41 +0000
Message-ID: <1571649512-24041-2-git-send-email-peng.fan@nxp.com>
References: <1571649512-24041-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1571649512-24041-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0025.apcprd03.prod.outlook.com
 (2603:1096:203:2f::13) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 773e001c-bb5a-4d9e-3308-08d75608153e
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: AM0PR04MB6788:|AM0PR04MB6788:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB6788E49C9D02E85002F5515D88690@AM0PR04MB6788.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:175;
x-forefront-prvs: 0197AFBD92
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(136003)(376002)(39860400002)(366004)(189003)(199004)(6512007)(4326008)(25786009)(81156014)(81166006)(8936002)(50226002)(5660300002)(2501003)(478600001)(2906002)(6116002)(3846002)(7736002)(4744005)(8676002)(305945005)(54906003)(316002)(110136005)(14454004)(44832011)(446003)(26005)(186003)(6506007)(386003)(36756003)(71200400001)(66556008)(66476007)(64756008)(66446008)(71190400001)(11346002)(102836004)(86362001)(66066001)(66946007)(2201001)(2616005)(256004)(52116002)(6486002)(6436002)(476003)(486006)(76176011)(99286004)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6788;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6TA1fNCAz6Ej4kIPxwISOpzUo8s5+J31wGzUWqV1P+PNcOZM9WBPwlA3ok5gDYicJ8qjdYbPYCWyvvVoadhXpaIfDRcpyC1dFm6Mj3ndSIMD6FGzVVWRyU2jFEt1f2jR0xvi0I6Jix5ouXBlv3RyJIJpjSu86RF0lHInPk0ZrTKpAAwF12+EjlqKsZP8scVGdfp3ZTYkSHqNr6XnDdmEaaYW2TS+NN4QQOQy/KqRjsTCkEF4AGkGBhpbCpO8P7/jGailMNJfyzGZ7Cd/cz8h2O2JgvqZFbV0LgNSghVGmoq1NT7pV0hDXgfAAT0txCrgBskzsOYk7qT8Fwn/2akx1C/8gDctLOy+YlpA4wtJMgjJEkwX/sVnw16/NdKFpZiQ9pvlJE6n3MUfla96kkoWH9rXnWE/zNFCs5dpeYuXfEyCog+jBV7nB9HgChJ6P6Sh
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 773e001c-bb5a-4d9e-3308-08d75608153e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2019 09:21:41.6377
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FGCGqsOhOomJ76MkDlmEXsiS3oYv0tIEG4BrulRgX85y527kEh6aySbaUp+Z40q2+12HyDQPavOT1Ibv98u8kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6788
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

We should not rely on U-Boot to configure the phy reset.
So introduce phy-reset-gpios property to let Linux handle phy reset
itself.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
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

