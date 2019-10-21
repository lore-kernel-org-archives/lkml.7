Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A41CA9EB9
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 09:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCB0620684
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 09:21:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qWot4CjS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbfJUJVk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 05:21:40 -0400
Received: from mail-eopbgr80044.outbound.protection.outlook.com ([40.107.8.44]:46975
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726847AbfJUJVk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 05:21:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YyI6BbdgYL4vLnsgsWeNyUx8UsDZGo5BqZdDMTr/p5mkN5N9QiU1J5xoal3AlzXL63IXDaXMnbReHzP2KsejJMLgEHZAS0Gm5VjQHtUcRnJSE8aV0yB0nOzggWW/WHKvz8EL0YN3UOUIEkl8VjlatUqd/m7oyaRo/7KsH4hoKbhQ9r3OpixsWaKkHHo/npu99/UlCkArTps+IQkVpkCuPR66OcrgLx74nNMbP/KlwVxMaq26QwnvPbpzEGAQ5hbauV7qjTB4xbiuWHvAjVyvDCajWLdnXXbNx1CVLLUFPiayWFi5Tm5jnyRPJIlxJjqy7NCO4j4LBanQsMnGTH6Obw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YHcjdV4wIYTcXg/0ZOrMFUWTxFoQVOmEtaF+3r4Basc=;
 b=M4Yo2X2f0zhGn0sTzEAmjYcjL4jaBl1+vBr6TiLSBmWusgD6e2guw3HoagdT8C6giLi79dzBD12E+KPhb45+SQqImuioW3wfwBb2T1+bKQjy0/KgDXL2cA6pB5RR1off12+0n8yTxoPEHK4r6UyGBVSzUMJEQIu8jz6Mjck6Puf5NW5AgAMpQUjZ4juAZWFdklrYOP1Fh1BazbTeZvTjZyuxBjnSA283/GCZIKUrgKpK62xv6OcBbjBw2ZuCwALFMTLveJLKTv2fY9NS3XYrNfqd9Mlqc7hc2DM3AneXJEJP3ULKqcFMxSmfDrSS0OtHmWk9ajVlYm6mk6KGjE8TcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YHcjdV4wIYTcXg/0ZOrMFUWTxFoQVOmEtaF+3r4Basc=;
 b=qWot4CjSz7Q87dA6IyZiPwloSzJEN2orpGx26p/x7TEBiQ29NJJpll9vIExQDzIsUpzv7OhXDlNabM/VGpwHxb9v/OBquyHiJqMG/9osKAWZmJO6WqY/8XbmX33//MxCNVWOyh7JKbhFvmgEulpuyoydQITk4shBsqwP0cHZdXw=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5619.eurprd04.prod.outlook.com (20.178.119.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.21; Mon, 21 Oct 2019 09:21:36 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::843c:e722:27cb:74e1]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::843c:e722:27cb:74e1%5]) with mapi id 15.20.2347.028; Mon, 21 Oct 2019
 09:21:36 +0000
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
Subject: [PATCH 1/2] arm64: dts: imx8mm-evk: add phy-reset-gpios for fec1
Thread-Topic: [PATCH 1/2] arm64: dts: imx8mm-evk: add phy-reset-gpios for fec1
Thread-Index: AQHVh/DvpHNuw1YCQUS80eeiIyy4HA==
Date:   Mon, 21 Oct 2019 09:21:35 +0000
Message-ID: <1571649512-24041-1-git-send-email-peng.fan@nxp.com>
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
x-ms-office365-filtering-correlation-id: f1e0c301-9834-408c-1bc1-08d7560811d0
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: AM0PR04MB5619:|AM0PR04MB5619:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB56197C598B5D6F74F20430C788690@AM0PR04MB5619.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:175;
x-forefront-prvs: 0197AFBD92
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(136003)(39860400002)(346002)(376002)(396003)(189003)(199004)(110136005)(6512007)(478600001)(81156014)(14454004)(316002)(7736002)(54906003)(305945005)(8676002)(81166006)(50226002)(2501003)(25786009)(8936002)(4326008)(66066001)(36756003)(2201001)(86362001)(6436002)(6486002)(476003)(66556008)(66476007)(99286004)(44832011)(64756008)(66446008)(2616005)(186003)(5660300002)(2906002)(71190400001)(4744005)(102836004)(3846002)(6116002)(386003)(6506007)(256004)(52116002)(71200400001)(66946007)(486006)(26005)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5619;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rg/AFaCLrOHgbQTNJhrzvoxpxp5qusIVHRF7x/EnSg6+PkU7IA/3gliw/RarSn5pINenBoE6kpepbwa6mJZYKqIds/gLQAj7H8HcJ6LNap6dm1Zb1CpiHJI63mSmKwYoBZ/w7u8SezrYYkVjcXoLG4o3i34pbd00psCbZwurNrW6adLt2TQGzQbpmVUpA8pmf5D2VYT6bQP7ND8LnUDAFyRXxl5uKocWcdRCBgy9VHHCoHqiqV9ZOAkHR/6l7NMHc31l0a5BjtS3GzjKfZBv/qDCfZxw+mZ/fCBjVLSALQTqr+nZaNGyFXXi2h4oJ+SsBfxA7acKozm34SDb+7mDaTEyd+Wh+nLa+ea0mZuNv9yhtoC3UgD4AMV/vVXcmOsmebnAXTamT5thePqu+JL3NPFaQIc0C40rSA8OEJeMWCOX/9wuX/VKbD6xmVCpLYjx
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1e0c301-9834-408c-1bc1-08d7560811d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2019 09:21:35.8880
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HRRwd91wBszI8Cecs/Raflt6ahl3d6Pl6nQjKrsYKld/aowv4UOKKrh00ksoqdubFbsg8QTkBjAZHpwG8Qpo0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5619
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
 arch/arm64/boot/dts/freescale/imx8mm-evk.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk.dts b/arch/arm64/boot=
/dts/freescale/imx8mm-evk.dts
index faefb7182af1..e4d66f7db09d 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
@@ -80,6 +80,7 @@
 	pinctrl-0 =3D <&pinctrl_fec1>;
 	phy-mode =3D "rgmii-id";
 	phy-handle =3D <&ethphy0>;
+	phy-reset-gpios =3D <&gpio4 22 GPIO_ACTIVE_LOW>;
 	fsl,magic-packet;
 	status =3D "okay";
=20
--=20
2.16.4

