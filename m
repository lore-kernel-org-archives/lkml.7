Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A953C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 00:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D597218C3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 00:47:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="warZYzT1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727575AbfCUArw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 20:47:52 -0400
Received: from mail-eopbgr10049.outbound.protection.outlook.com ([40.107.1.49]:28825
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726169AbfCUArv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 20:47:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RSBtxswWHYuJrF+v0hb8s6usTlqYf9kL+Mi/f7AdG9s=;
 b=warZYzT1HTUb2NmM1KQRNosKHr6WUgIaQRm6pPWAL1TIwxKN/bH850u/Udlvy1Dxh0PcZpLkU1ZPbAQJrEg84hUiGxNn1a45IGblA5d9knj6vX5bpBr+VVtZ1zIaTvnJ3FvEk9jxE2sM31q8G3qospPB/W6dx5xOA1ehSRnxCfU=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3738.eurprd04.prod.outlook.com (52.134.70.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.14; Thu, 21 Mar 2019 00:47:44 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08%7]) with mapi id 15.20.1730.013; Thu, 21 Mar 2019
 00:47:44 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "otavio@ossystems.com.br" <otavio@ossystems.com.br>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "schnitzeltony@gmail.com" <schnitzeltony@gmail.com>,
        "jan.tuerk@emtrion.com" <jan.tuerk@emtrion.com>,
        Robin Gong <yibin.gong@nxp.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V8 0/5] Add i.MX7ULP EVK PWM backlight support
Thread-Topic: [PATCH V8 0/5] Add i.MX7ULP EVK PWM backlight support
Thread-Index: AQHU33+yczxouQcxw0e7w8f7WTm6uQ==
Date:   Thu, 21 Mar 2019 00:47:44 +0000
Message-ID: <1553128960-17923-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0087.apcprd03.prod.outlook.com
 (2603:1096:203:72::27) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3d1ea2be-3bef-4794-b458-08d6ad96d456
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3738;
x-ms-traffictypediagnostic: DB3PR0402MB3738:
x-microsoft-antispam-prvs: <DB3PR0402MB3738F9544B8770DF32DD5550F5420@DB3PR0402MB3738.eurprd04.prod.outlook.com>
x-forefront-prvs: 0983EAD6B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(366004)(376002)(136003)(396003)(199004)(189003)(53936002)(2616005)(71200400001)(486006)(3846002)(478600001)(476003)(6486002)(8936002)(6116002)(36756003)(66066001)(25786009)(102836004)(14454004)(26005)(7736002)(110136005)(186003)(99286004)(6436002)(7416002)(81156014)(4326008)(81166006)(305945005)(6512007)(97736004)(2201001)(4744005)(105586002)(386003)(256004)(50226002)(2501003)(68736007)(6506007)(8676002)(86362001)(316002)(5660300002)(52116002)(106356001)(71190400001)(2906002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3738;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: D5qWZFSRFaZKGzJofJco+i3YVpLa5nMmk6DOeGbcNTATX5yGIi1l+CvhlrXC+ifhd2py2dF2LFXLWrElPJUI7loKP3IUhISvWhR0ioMW57pyxIwaVLxbbBew+/cUQRl4ruy1iPn/4JsZkPUVz425rxTTubPQ6RL9gy5P291CrfMQj9yM1gBii+nlXLoJHd2EcoM5be8M4elU/eIFhsXEjxyFKz6jgprWVcBRCMH9xVHdCd2e3OZi7WDSepYfiXgZTAGlddrNFMo2d/TiGbp5w+m6yJiWbD9ZDZSaaBdCkerpY3nvQnE1vAFDc1lGWnUrFOGrZ+yQn1YptkdIAeijj8nGUOGplrDol8wXBhX4U/yGlVCxbEwDi/8oN5EZdsoANWG9ovDryIm+hI3XQaJfHfj087vuVsUWo8KQ6urw0vc=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d1ea2be-3bef-4794-b458-08d6ad96d456
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2019 00:47:44.5920
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3738
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX7ULP EVK board has MIPI-DSI display, its backlight is supplied by
TPM PWM module, this patch set enables i.MX7ULP TPM PWM driver support
and also add backlight support for MIPI-DSI display.

Changes since V7:
	- ONLY change the pwm driver patch.

Anson Huang (5):
  dt-bindings: pwm: Add i.MX TPM PWM binding
  pwm: Add i.MX TPM PWM driver support
  ARM: imx_v6_v7_defconfig: Add TPM PWM support by default
  ARM: dts: imx7ulp: Add pwm0 support
  ARM: dts: imx7ulp-evk: Add backlight support

 .../devicetree/bindings/pwm/imx-tpm-pwm.txt        |  22 ++
 arch/arm/boot/dts/imx7ulp-evk.dts                  |  21 +
 arch/arm/boot/dts/imx7ulp.dtsi                     |  10 +
 arch/arm/configs/imx_v6_v7_defconfig               |   1 +
 drivers/pwm/Kconfig                                |  11 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-imx-tpm.c                          | 435 +++++++++++++++++=
++++
 7 files changed, 501 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/imx-tpm-pwm.txt
 create mode 100644 drivers/pwm/pwm-imx-tpm.c

--=20
2.7.4

