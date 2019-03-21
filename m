Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EAEBC10F05
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 02:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D05A1218D8
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 02:26:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qPcWSjP6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbfCUC0g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 22:26:36 -0400
Received: from mail-eopbgr20064.outbound.protection.outlook.com ([40.107.2.64]:32454
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726983AbfCUC0g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 22:26:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+lBWMEKAwwR7FliQAmvHDF4QnEd4P/HnbDpBKHz2Whc=;
 b=qPcWSjP6GLwE9PaEMz8yws2hCYoxXyU6YZUKKuGo2t31WAWCSOa9VVvRtWBDWuqvw8olZwKuNyYNkb6eTdbz4CMW6P9qRlo+I3zBIRaboeWzXTeVe4XIcD5fdAmUgWqa1cmudJFRNcgR8rbnWkvbyZ9sQrMBiJhvx+naiL/oeqY=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3785.eurprd04.prod.outlook.com (52.134.71.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.16; Thu, 21 Mar 2019 02:26:30 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08%7]) with mapi id 15.20.1730.013; Thu, 21 Mar 2019
 02:26:29 +0000
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
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        Andy Gross <andy.gross@linaro.org>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "ezequiel@collabora.com" <ezequiel@collabora.com>,
        "stefan.wahren@i2se.com" <stefan.wahren@i2se.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "olof@lixom.net" <olof@lixom.net>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V9 0/4] Add i.MX8QXP system controller watchdog
Thread-Topic: [PATCH V9 0/4] Add i.MX8QXP system controller watchdog
Thread-Index: AQHU3419SZ6L5v/Fc0y0OruBFf0TYQ==
Date:   Thu, 21 Mar 2019 02:26:29 +0000
Message-ID: <1553134884-1720-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR04CA0017.apcprd04.prod.outlook.com
 (2603:1096:203:36::29) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b6739b71-426c-4b3a-ef24-08d6ada4a024
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3785;
x-ms-traffictypediagnostic: DB3PR0402MB3785:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <DB3PR0402MB3785B6B402D26C2ADAA55902F5420@DB3PR0402MB3785.eurprd04.prod.outlook.com>
x-forefront-prvs: 0983EAD6B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(376002)(136003)(396003)(366004)(199004)(189003)(316002)(478600001)(486006)(2616005)(7736002)(476003)(305945005)(66066001)(8676002)(81156014)(14454004)(386003)(110136005)(6506007)(36756003)(68736007)(6486002)(14444005)(6436002)(256004)(102836004)(52116002)(105586002)(99286004)(81166006)(106356001)(26005)(186003)(97736004)(4326008)(50226002)(2501003)(8936002)(25786009)(3846002)(6116002)(6512007)(5660300002)(53936002)(2906002)(86362001)(2201001)(7416002)(71200400001)(71190400001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3785;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Yv0VgRvQ+wdAb8n+Rbvk1dZ9sGMkCLgfBhH/cJ5/NhcM2T9/13TZPd6qxvHVk3OB69jSAKOz6SbZ1tKM5YN4C69WdpfsPv0EBiM3VXPL4mRH9GnPylc1hwsenkcdDdBFWUhtnv6/MU59CKQ2fPgIzaP3BiGY7Xk1OE2a0noM0uLPaew8ESEeqADc7Wbw+pwN1oCZlrcJmP6Ev9HdObaDGKmYXHisSzUd8b6DdCcDKlbbqvhZmIqdR4ecF2NEkZkHE4N+rZtUwTkjAFFf96dvOliz8bEYkhzNh8fcv5xesiMV2Y5I4taf421eQsR7uvoNo8/zoePbBy2r32dsOdnIiETC9Y6lVOxptldt3tHxkITXor/J+c6YQHQAdN6kuqs9oyIMDQNChTceyXI/7lpQA+9DsGra/mkm87/olun115c=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6739b71-426c-4b3a-ef24-08d6ada4a024
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2019 02:26:29.7934
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3785
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

Changes since V8:
	- change the timeout value to be from DT instead of from module parameter,
	  and also update the binding doc and dts to add timeout property.

Anson Huang (4):
  dt-bindings: watchdog: add i.MX system controller watchdog
  watchdog: imx_sc: Add i.MX system controller watchdog support
  arm64: defconfig: add support for i.MX system controller watchdog
  arm64: dts: imx8qxp: add system controller watchdog support

 .../bindings/watchdog/fsl-imx-sc-wdt.txt           |  24 +++
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi         |   5 +
 arch/arm64/configs/defconfig                       |   1 +
 drivers/watchdog/Kconfig                           |  16 ++
 drivers/watchdog/Makefile                          |   1 +
 drivers/watchdog/imx_sc_wdt.c                      | 177 +++++++++++++++++=
++++
 6 files changed, 224 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/fsl-imx-sc-w=
dt.txt
 create mode 100644 drivers/watchdog/imx_sc_wdt.c

--=20
2.7.4

