Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB62C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 06:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 805432184C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 06:27:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="LlTB0Jy8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbfCNG1P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 02:27:15 -0400
Received: from mail-eopbgr130041.outbound.protection.outlook.com ([40.107.13.41]:6467
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726527AbfCNG1N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 02:27:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=11oFbbhShcbiewhjMrv5WpTncCm0AuyC1+FZeJYNfjM=;
 b=LlTB0Jy8+y+n/FrmpUAFF94DZT+TIvoW+LsxfNkTBRhnz4lVGz55JnX4ueBqAVB7RqtWPESXkNwIWE2CGBpE3HSHL/sWZdwFFMlfD1OMCiB5xeREPeolvOW6q6bAJ08yHW33iSo/I23fXpPH3mq72jWUnwCdICB3ogZSfDV/okU=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3707.eurprd04.prod.outlook.com (52.134.65.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.18; Thu, 14 Mar 2019 06:27:07 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08%6]) with mapi id 15.20.1709.011; Thu, 14 Mar 2019
 06:27:07 +0000
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
Subject: [PATCH V3 0/5] Add i.MX7ULP EVK PWM backlight support
Thread-Topic: [PATCH V3 0/5] Add i.MX7ULP EVK PWM backlight support
Thread-Index: AQHU2i7yTqNDcRWbxEmBziO54/4czQ==
Date:   Thu, 14 Mar 2019 06:27:07 +0000
Message-ID: <1552544534-5295-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0031.apcprd03.prod.outlook.com
 (2603:1096:203:2f::19) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 39627ea2-4b74-4313-7e1c-08d6a84614de
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3707;
x-ms-traffictypediagnostic: DB3PR0402MB3707:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DB3PR0402MB3707;23:dH16XG2UrSb5ceT2iyEcmSiDgT3KblycDwDUh?=
 =?iso-8859-1?Q?diOdlkEJqBnQmAuDYdeNH9XK5YyzE/yfYO8vdGC/za+qvsUHaPpz1dvzD0?=
 =?iso-8859-1?Q?4AHqiQp4MCw/on68/7hMFICyk0CUZfPM4iapUz9UCKLRYNb2pCzD1ew+Py?=
 =?iso-8859-1?Q?6yDwnuhminVL+TKJLg42CGcucPQIfBg9cxGC+8ppW5dhn9AEi0b0xZ1YZe?=
 =?iso-8859-1?Q?IxQGBP4sg3vY85V5n0URNX2KaszvTIl9soqnKWbpPVXe03in4q9Ayx7SXX?=
 =?iso-8859-1?Q?vMyq7PWfJBSTVz4hUJlWRapHc4hQEBPskQOs1m/seC6DyBH/Ptidqlikty?=
 =?iso-8859-1?Q?hRmHLk98213NNugELYWhcsijJR+aYsUytnkCwJBjNHdw49cCDXCkDr7mYi?=
 =?iso-8859-1?Q?QKvXltDw3akYdLLq6Gb2L0uBqHkLcW569t5/Pn/11O50dagA+GzP7AzP4v?=
 =?iso-8859-1?Q?xbSG4CBbBziDR41KR5jHSrPeJ3R4xSWZ0spJPpMqnPoNmIRmWYUi75q37I?=
 =?iso-8859-1?Q?EjIeSIunRlTmPAHxQd6bU8PXH/1U62wjEBKp6RJflTJ9OUhpWcoBvjLboS?=
 =?iso-8859-1?Q?BGjHTUUGYethmPHWI+ONin/y30BKfBnX30rQTat7YfJiQfGTaLesvHX1+1?=
 =?iso-8859-1?Q?OAXMM30O6ito3FdCSMInbwvg3+NyBfGL7F9Cf3Y/8OnJvGs+Xw4kVj01n9?=
 =?iso-8859-1?Q?kUQf4GFpqJ4xpDaIwFBz/baJ6xhMuWvmyyncySbIQpdWj2YbkYyMG+HQI+?=
 =?iso-8859-1?Q?Ru6RjYeZoJQ8WPBvAQtZ0g08QuxoRuglC+eo/YwcWaz2cl1Gx70wYOlU9d?=
 =?iso-8859-1?Q?/9erlfM2dIK1AuA1eBc/ZrAiCdpMwa++1vOmfjRHFlYKhtolPr2tOCLhdJ?=
 =?iso-8859-1?Q?ItaXn1mvLaHU4kTyrmx78ZR4y0uqIENT70/AaXvO7g7lCFkp/noxyfsAeV?=
 =?iso-8859-1?Q?ZJznuP3Srhj4bwFjXXicP6hyb/xY9qlAwPThxfqEmNibVGY4Y3XmWQqp/T?=
 =?iso-8859-1?Q?kqixvsxIribFmF8OyYrD7E1rOSXwIF0RXO7Ti52fNRjnLqxMp2lCRTwf8g?=
 =?iso-8859-1?Q?WECuaNjjcxxsKYJaTdKsbJN2FtF7cu6ZbnccDgT6PDj4v/CkQivjqOZV02?=
 =?iso-8859-1?Q?64yq2NowBGchXZpdejU9Y7FRFJ4P1ROvPf4f8TMMToatFBcLFFLa6KQlpb?=
 =?iso-8859-1?Q?lxVn34+IHrQCXOv1xZ3UqVN5wFv/93OayxEv1W3KFNBdFYA9Mr86PfcCnu?=
 =?iso-8859-1?Q?3Y5jnHNN2mHhO6h8PuTcWCUBjS6HFQgNOdvZBGG9Q=3D=3D?=
x-microsoft-antispam-prvs: <DB3PR0402MB3707CC1F98EED1BBCEFBF96CF54B0@DB3PR0402MB3707.eurprd04.prod.outlook.com>
x-forefront-prvs: 09760A0505
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(136003)(366004)(376002)(39860400002)(199004)(189003)(478600001)(6436002)(26005)(97736004)(6506007)(476003)(7416002)(68736007)(4744005)(8676002)(102836004)(386003)(81166006)(81156014)(305945005)(486006)(14454004)(186003)(110136005)(2906002)(2616005)(106356001)(105586002)(7736002)(71190400001)(71200400001)(52116002)(316002)(2501003)(6116002)(3846002)(66066001)(50226002)(4326008)(5660300002)(256004)(36756003)(99286004)(86362001)(8936002)(6486002)(2201001)(25786009)(6512007)(53936002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3707;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: QycvI12x26F9/f3iDfedO9kkQvbi2J64O+dhyF4suTd21gK+Z+nHFhtjX+Ro+JtjWEndtrwZlsyt7AIvFiT5rYXFRBmlDySYYfUx9Zks6QgZlEVQYoxVVukeshw0o6GquSUbgOzCpdeYpYt8hi2ivEp7Z5k/FNP98WCJvmSk/H6Ov/5oMM2VA0e28MVbKg+YflmdOmWbQho5hEzLpSQrublXHwe80c4Ky9rMDomh22zat0T7cHSYdIMFft6Zwx98lHbbO7oydc0cUECXWe52jLbeMy+sAqOrKvcMrw+ieey0COb4cdNo8BorFyEcHFYTvA0QfPZb1d6xixxAU3Qx8mIeeEiwEFAaaGGUnQ56ozPFOp5Om0FBGNsp19mgLmQx5BbgL+sZD7kVOsEauBPQro5IcVGk6+JH7JPKeFKQtbs=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39627ea2-4b74-4313-7e1c-08d6a84614de
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2019 06:27:07.6010
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3707
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX7ULP EVK board has MIPI-DSI display, its backlight is supplied
by TPM PWM module, this patch set enables i.MX7ULP TPM PWM driver
support and also add backlight support for MIPI-DSI display.

Anson Huang (5):
  dt-bindings: pwm: Add i.MX TPM PWM binding
  pwm: Add i.MX TPM PWM driver support
  ARM: imx_v6_v7_defconfig: Add TPM PWM support by default
  ARM: dts: imx7ulp: Add pwm0 support
  ARM: dts: imx7ulp-evk: Add backlight support

 .../devicetree/bindings/pwm/imx-tpm-pwm.txt        |  23 ++
 arch/arm/boot/dts/imx7ulp-evk.dts                  |  20 ++
 arch/arm/boot/dts/imx7ulp.dtsi                     |  11 +
 arch/arm/configs/imx_v6_v7_defconfig               |   1 +
 drivers/pwm/Kconfig                                |   9 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-imx-tpm.c                          | 277 +++++++++++++++++=
++++
 7 files changed, 342 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/imx-tpm-pwm.txt
 create mode 100644 drivers/pwm/pwm-imx-tpm.c

--=20
2.7.4

