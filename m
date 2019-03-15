Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62BABC4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 06:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32623218AC
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 06:17:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ipyrml44"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbfCOGRP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 02:17:15 -0400
Received: from mail-eopbgr80072.outbound.protection.outlook.com ([40.107.8.72]:44150
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728050AbfCOGRO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 02:17:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o36Uu/1FRdQbNWNWRLY+dsW3Ctv/3OYS1yzLF/dJIKw=;
 b=ipyrml44ChwXi+yzr3n5n/jI+Ss0H3Ornv3BJMCM+7BgTbLDjHkF6rrYicRXmCnpu/NkfMIL+IAHSYyIHCa43VF/lbdQp/HMR5zqLiI6jJ4HcG5pozhzNKbV8SEKawPMGTjXo4SlIYE9XpCzGiZHtoliUvkjWb3jWCALuZswfTY=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Fri, 15 Mar 2019 06:17:08 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08%6]) with mapi id 15.20.1709.011; Fri, 15 Mar 2019
 06:17:08 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        Andy Gross <andy.gross@linaro.org>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "olof@lixom.net" <olof@lixom.net>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "ezequiel@collabora.com" <ezequiel@collabora.com>,
        "stefan.wahren@i2se.com" <stefan.wahren@i2se.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V8 0/4] Add i.MX8QXP system controller watchdog
Thread-Topic: [PATCH V8 0/4] Add i.MX8QXP system controller watchdog
Thread-Index: AQHU2va3esFEmGQoN0iKH6tI/mfb5w==
Date:   Fri, 15 Mar 2019 06:17:08 +0000
Message-ID: <1552630331-32068-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR01CA0002.apcprd01.prod.exchangelabs.com
 (2603:1096:203:92::14) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dc99712a-2b72-42bf-aa3f-08d6a90dda2c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3916;
x-ms-traffictypediagnostic: DB3PR0402MB3916:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <DB3PR0402MB39169977DDE11A0BD861ACAAF5440@DB3PR0402MB3916.eurprd04.prod.outlook.com>
x-forefront-prvs: 09778E995A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(376002)(346002)(39860400002)(366004)(199004)(189003)(8936002)(2501003)(102836004)(2906002)(6436002)(68736007)(5660300002)(7416002)(6116002)(66066001)(36756003)(71190400001)(486006)(71200400001)(6346003)(2616005)(476003)(186003)(386003)(3846002)(26005)(52116002)(6506007)(6486002)(305945005)(6512007)(256004)(478600001)(2201001)(86362001)(4326008)(25786009)(106356001)(105586002)(7736002)(316002)(14444005)(110136005)(50226002)(14454004)(99286004)(8676002)(97736004)(81156014)(81166006)(53936002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3916;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zV33oYRG5A/HC2GgF1QvxzLFEv834OIyg95Cp5aRf/tk+6s2u1BbeSJi/e/LcOITftfoZBUCHWDqtVxGdc5mnWhBRjc0TJHawtU/9eltq6xMhp49bCP3/bB1TnpLpT68usDDnGCLHY/QlGQYAD7W9dyAbHSYcs82P0nzWKsv+KczDC141PEdFXg67gMnHy7bSggIE2rsqORYHZ3nsPmUpCbCq8hqsXa4Z1rIDKcEyK4A0Eqs1nR+0YJdKfrvNABYDRp8unTsxaAqQynnesrNraPsXTEVczG1vzoirebCzjIzF3+Ppu7TxHhZ+jj04dnhPSBpzSEq1R9HKScJPydeXf5IvIvP62xW9shxHmXoOMDB266YYN0k41fIGvfxuVA11S9Szy/DrvnErc/UbsbkguoVDOuWqdGCEcwWr6e/P+4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc99712a-2b72-42bf-aa3f-08d6a90dda2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2019 06:17:08.4276
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3916
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX8QXP is an ARMv8 Cortex-A35 SoC with a Cortex-M4 system controller
inside, the system controller manages overall power, clock, secure RTC
and watchdog etc., so Linux kernel running on A35 needs to communicate
with system controller for watchdog operation, this system controller
watchdog will call SMC to trap to EL3 secure world ARM-Trusted-Firmware
and then it will request system controller to do the watchdog operation
via IPC.

Anson Huang (4):
  dt-bindings: watchdog: add i.MX system controller watchdog
  watchdog: imx_sc: Add i.MX system controller watchdog support
  arm64: defconfig: add support for i.MX system controller watchdog
  arm64: dts: imx8qxp: add system controller watchdog support

 .../bindings/watchdog/fsl-imx-sc-wdt.txt           |  20 +++
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi         |   4 +
 arch/arm64/configs/defconfig                       |   1 +
 drivers/watchdog/Kconfig                           |  16 ++
 drivers/watchdog/Makefile                          |   1 +
 drivers/watchdog/imx_sc_wdt.c                      | 182 +++++++++++++++++=
++++
 6 files changed, 224 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/fsl-imx-sc-w=
dt.txt
 create mode 100644 drivers/watchdog/imx_sc_wdt.c

--=20
2.7.4

