Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AACB3C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 07:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72A592075C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 07:41:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DFbbfJX+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbfCRHla (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 03:41:30 -0400
Received: from mail-eopbgr00058.outbound.protection.outlook.com ([40.107.0.58]:28288
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727086AbfCRHla (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 03:41:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Flo/JzCU8aGrMQwiflXgdDVRwLZWMoWjW/R05fJBQoY=;
 b=DFbbfJX+xtHaZlSKITkspB4pCXexdxUrckRonk8HuYo2bpmP0isfVp3JR5vi6bm+Rem+vgBJfiug+yophf4GVAtoNESEwa5AL/CmO0/V+lON++yhGXXA1NF3VTmolGUpRxbajwM8Wv96yBtTmocMq1fuNALWaXLyTHeqxWtME+s=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3868.eurprd04.prod.outlook.com (52.134.71.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.14; Mon, 18 Mar 2019 07:41:26 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08%6]) with mapi id 15.20.1709.015; Mon, 18 Mar 2019
 07:41:26 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "otavio@ossystems.com.br" <otavio@ossystems.com.br>,
        "stefan@agner.ch" <stefan@agner.ch>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Robin Gong <yibin.gong@nxp.com>,
        "jan.tuerk@emtrion.com" <jan.tuerk@emtrion.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V5 0/5] Add i.MX7ULP EVK PWM backlight support
Thread-Topic: [PATCH V5 0/5] Add i.MX7ULP EVK PWM backlight support
Thread-Index: AQHU3V39X3ciu4hb4E6ZhKDi9rsd2Q==
Date:   Mon, 18 Mar 2019 07:41:26 +0000
Message-ID: <1552894581-3391-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR0401CA0011.apcprd04.prod.outlook.com
 (2603:1096:202:2::21) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dff16068-7ba4-47f7-5af8-08d6ab751ff9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3868;
x-ms-traffictypediagnostic: DB3PR0402MB3868:
x-microsoft-antispam-prvs: <DB3PR0402MB38680A05AB80E9BA62B4E674F5470@DB3PR0402MB3868.eurprd04.prod.outlook.com>
x-forefront-prvs: 098076C36C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(396003)(39860400002)(346002)(376002)(189003)(199004)(386003)(2501003)(5660300002)(2616005)(68736007)(476003)(14454004)(97736004)(7416002)(486006)(71200400001)(71190400001)(26005)(36756003)(25786009)(105586002)(478600001)(106356001)(4326008)(186003)(86362001)(50226002)(81156014)(6436002)(6512007)(8936002)(4744005)(2906002)(2201001)(66066001)(6486002)(3846002)(6116002)(305945005)(102836004)(7736002)(81166006)(53936002)(6506007)(52116002)(8676002)(256004)(316002)(110136005)(99286004)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3868;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: NkCHlzJtgRZBGr4LYa5souyBd8ggyLUFjmuJHIITkXEkR+zY0fpBJSCABFc7eNIgWeLQkZXpKACBvuO67JkS9OCqa1x2ZYYBiHgoPuLzjyAhMp4voB35xDAmnOagMJZo1gZamZv2Hi3VrgFeeuKoBVD1aX4FqOX6joVqOA9EA4jPi/ISfLPVbThs+IOb9Ygidv5TgHUM+K4vJOFTYs5OISdmHrc360ieVC0j831Ld+DbFAeogdR+cjkJn1G7BaLg9BIMYKXVxYsOY6SsZeHBNFOWFMEK/RGNMJAh9qzNxAxAkely2dqSCNgKbJ4WJURDYHyyuNRUgXzenijNJvMd0Qni72z49h3Q4QPSutI6j922yPIViYtOA7Pq7NyxvxUx9RmvtdobeoC5fF/Jg0ptotwjUOM0pw/mJltlpBAWPeI=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dff16068-7ba4-47f7-5af8-08d6ab751ff9
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2019 07:41:26.1226
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3868
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX7ULP EVK board has MIPI-DSI display, its backlight is supplied by
TPM PWM module, this patch set enables i.MX7ULP TPM PWM driver support
and also add backlight support for MIPI-DSI display.

Anson Huang (5):
  dt-bindings: pwm: Add i.MX TPM PWM binding
  pwm: Add i.MX TPM PWM driver support
  ARM: imx_v6_v7_defconfig: Add TPM PWM support by default
  ARM: dts: imx7ulp: Add pwm0 support
  ARM: dts: imx7ulp-evk: Add backlight support

 .../devicetree/bindings/pwm/imx-tpm-pwm.txt        |  19 +
 arch/arm/boot/dts/imx7ulp-evk.dts                  |  20 +
 arch/arm/boot/dts/imx7ulp.dtsi                     |  10 +
 arch/arm/configs/imx_v6_v7_defconfig               |   1 +
 drivers/pwm/Kconfig                                |  11 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-imx-tpm.c                          | 436 +++++++++++++++++=
++++
 7 files changed, 498 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/imx-tpm-pwm.txt
 create mode 100644 drivers/pwm/pwm-imx-tpm.c

--=20
2.7.4

