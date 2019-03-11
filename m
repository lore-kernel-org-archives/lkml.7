Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72A4CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 07:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33838206DF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 07:16:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="eKblsbRy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbfCKHQJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 03:16:09 -0400
Received: from mail-eopbgr60057.outbound.protection.outlook.com ([40.107.6.57]:36096
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725808AbfCKHQI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 03:16:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=11oFbbhShcbiewhjMrv5WpTncCm0AuyC1+FZeJYNfjM=;
 b=eKblsbRy3Ci4X4ZvDlDAUEQly2+MgZpukoS5ftVE+KyfrgcjnIZPKWLePVq4D1gHu0sgbS9mGSxooDDWDiOX0fPU4wsXgCVcP6T4oayDOUiSFq5FvwqSLrm7fj6pylXW0oVvo9lgAEanwrhAILlWSHhNU3bKChMuMR22dClq+wY=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3897.eurprd04.prod.outlook.com (52.134.73.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.19; Mon, 11 Mar 2019 07:16:02 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7%2]) with mapi id 15.20.1686.021; Mon, 11 Mar 2019
 07:16:02 +0000
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH 0/5] Add i.MX7ULP EVK PWM backlight support
Thread-Topic: [PATCH 0/5] Add i.MX7ULP EVK PWM backlight support
Thread-Index: AQHU19pI1z6Lb+cSJEKPyQKNhgk6+g==
Date:   Mon, 11 Mar 2019 07:16:02 +0000
Message-ID: <1552288273-31028-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0090.apcprd03.prod.outlook.com
 (2603:1096:203:72::30) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7b214ead-9902-4b7c-82ab-08d6a5f16b09
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3897;
x-ms-traffictypediagnostic: DB3PR0402MB3897:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DB3PR0402MB3897;23:KREGn59eXcMIKI7ow7teAB/CJNkl1XpAMsR38?=
 =?iso-8859-1?Q?gAKLKp3NAeSOgJZA/BFHVm0DgFbo0eSAWpCwh2TO8BC+1lT3+d/6a9TPrk?=
 =?iso-8859-1?Q?Hk0ywoNOiYe3s8fN9rthsrxiami1v23kph1amNr609kNx4Q7CtdIDstSmJ?=
 =?iso-8859-1?Q?DPq5MyRBSl5Ics7+PQIYwULWwYCPzSYMtX8nIu9IjGq2t4GhkrnDCbMnZy?=
 =?iso-8859-1?Q?rLA/xkanFIasI09mrFI4mJ7HDjxH5qVi9+Eilyvu+6dgt/d94gn0tgXA8g?=
 =?iso-8859-1?Q?ciOxLP1Ky+VYev1MuII0oBA99+jBAeD4aTfsCU/CzfI1Yc2AMtZGx9ukP4?=
 =?iso-8859-1?Q?+AK9AerwFZ3YDWTU5RH7Eh6HLP28VhX2bAYJUl4GeItTTxu1snvKVee81O?=
 =?iso-8859-1?Q?G7AMvzE98/NxgGlC8YJtFWBBTGsZGaHhCe8yh3f1n3qkOqz/J3ZcL7xlYu?=
 =?iso-8859-1?Q?Ymg31XNmK8H/vSOxXY9EQNr52zs8sTR7afxH7TZRsWpVih6ZWfLokK1YZw?=
 =?iso-8859-1?Q?wHUXr+zF+aitDpRtvuf8SThbxffVMbbS9ILohvdvtcv8JzVju6EOrlFkNn?=
 =?iso-8859-1?Q?tLxIR4sqlBkF+cb9GynBnZ9VYcHnKaVQ6OYwyFrHVVuaWzJ6R735wVulX4?=
 =?iso-8859-1?Q?sNl2oOcW76gGJNqxz+ufS2EgABtWCmJAmwysgreeGSH+VmK08JGXyHDpAi?=
 =?iso-8859-1?Q?iTh3mn/m2NhjixQ1h6Oc8zj246R0LqbHGt/bqg3q0MelDu1uINue44xQic?=
 =?iso-8859-1?Q?M04Wdo6vz1i1u8DzjkfNR5PYLxV2/OlOjigQQ+OiokjhQB/zc3aWuckCR8?=
 =?iso-8859-1?Q?8W9DObeEZp/Um85zgZLbT5L8suO04u/QjWrTNXMC568mwTGQw4zF7hhMk1?=
 =?iso-8859-1?Q?St6xUEoBhr8E9eIPmaVO+3IUm8jxi96w7nT+g2MgszMvm1yyi+tzXsjJPW?=
 =?iso-8859-1?Q?l5UBwicmUEZq6o3lmXfF6uqROgFblCSF05M/1HidSb7df2Huuv7o1/JUef?=
 =?iso-8859-1?Q?tzgK5H6d9tjuEfeD272QxrMnXIiN/QDuCpKYePEexJ1C4p2y1GuWK2SQuw?=
 =?iso-8859-1?Q?f3E6tcklY2u83B2Fi889AVDF7X88KgHrBqsmyUB+CQhbRq2baqbS/S1QaP?=
 =?iso-8859-1?Q?wm8dGURxcFCgPS6cPy/ND+l8zkfGpspoZUS14scZgpMUDpVWScVwRANepO?=
 =?iso-8859-1?Q?flRh50OWa+VX+d1Uw8Rayr7z/kHo13cDcm8O2ZMzoM+bWXqANIGrb0N+Vv?=
 =?iso-8859-1?Q?DMmwel7wIyf9sgkn2YjnH3glqomwH2RVK3r/+g4kg=3D=3D?=
x-microsoft-antispam-prvs: <DB3PR0402MB389799DFB08D6E0F505A9D48F5480@DB3PR0402MB3897.eurprd04.prod.outlook.com>
x-forefront-prvs: 09730BD177
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(366004)(396003)(346002)(39860400002)(199004)(189003)(478600001)(86362001)(53936002)(6512007)(71190400001)(71200400001)(102836004)(386003)(6506007)(36756003)(68736007)(316002)(256004)(14454004)(2201001)(50226002)(305945005)(66066001)(6116002)(8936002)(105586002)(2501003)(5660300002)(6436002)(7416002)(3846002)(6486002)(26005)(4744005)(7736002)(186003)(110136005)(52116002)(25786009)(99286004)(2616005)(476003)(4326008)(81166006)(81156014)(8676002)(486006)(106356001)(2906002)(97736004)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3897;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: wOhiD24o1moBj2X4aYJTvyHwf+EWKQPHh0Wf9b42XQrm+oRJBaArA19s/VoO2hn4du2I0XriyXoGmJIE27Nr2X1kyBYgC2MkqluUxgNz4G4W+fX7VCRU4mf/s7uTc+g4z8F2OEH2kfSeNGrcp2KqUR3IdJ31/1s1f/k1pRO+BNlwPWujqBDlO+mQ1dHDgCv5qtQPa1wZOpsba1h52NUkLGo0yzUwpHzedvYd8QsjdPJZk0WL+qDPNE2BCNRhBUMVTeXYlNy4eIyy0hsCS+vzeXNhSNRSCATlsPaBo5k0SPTsaNcAP5Rmh1dOy9Z9uibvxpT4W/eKE9O8hy2zcE6ITzRi/W///oJnnmLqxI4Z/mS5QRpv92Z9PPXPGagxrH7Odpyk2HouAlG9BTHwMdN5tg3m5h7gurEWFI2ETL9XaqI=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b214ead-9902-4b7c-82ab-08d6a5f16b09
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2019 07:16:02.8105
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3897
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

