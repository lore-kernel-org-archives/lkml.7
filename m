Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9ED0C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 06:17:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F73921872
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 06:17:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XL/MSWFx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728370AbfCOGRV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 02:17:21 -0400
Received: from mail-eopbgr150048.outbound.protection.outlook.com ([40.107.15.48]:25934
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728050AbfCOGRU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 02:17:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kZJ03AUc56KlwHjDsLQPC//d83M0VrrzDMVWsdUQUps=;
 b=XL/MSWFxtoxOncCIe42BSrtwgyiGRL0bCGLlX//Fb7XGObjXjInfDR2gg8c2kmXCIFsN9bOmmuTP1enpo11jmMETb18hwzr4L1MhODFo9Y17hVtakihVNbRnNH8Q4RsZh7yAsUjY5rJbsigv30uMdzNPtz4LngZmc1h4TpPC7u0=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Fri, 15 Mar 2019 06:17:17 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08%6]) with mapi id 15.20.1709.011; Fri, 15 Mar 2019
 06:17:17 +0000
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
Subject: [PATCH V8 1/4] dt-bindings: watchdog: add i.MX system controller
 watchdog
Thread-Topic: [PATCH V8 1/4] dt-bindings: watchdog: add i.MX system controller
 watchdog
Thread-Index: AQHU2va9F7SpvWeprUqeDHfDWW4udg==
Date:   Fri, 15 Mar 2019 06:17:16 +0000
Message-ID: <1552630331-32068-2-git-send-email-Anson.Huang@nxp.com>
References: <1552630331-32068-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1552630331-32068-1-git-send-email-Anson.Huang@nxp.com>
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
x-ms-office365-filtering-correlation-id: 940ccd8f-7550-4c2a-5322-08d6a90ddf60
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3916;
x-ms-traffictypediagnostic: DB3PR0402MB3916:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <DB3PR0402MB391618A29BBD2D0F2A48F453F5440@DB3PR0402MB3916.eurprd04.prod.outlook.com>
x-forefront-prvs: 09778E995A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(376002)(346002)(39860400002)(366004)(199004)(189003)(8936002)(2501003)(102836004)(2906002)(6436002)(68736007)(5660300002)(7416002)(6116002)(66066001)(36756003)(446003)(71190400001)(486006)(71200400001)(76176011)(6346003)(2616005)(476003)(186003)(386003)(11346002)(3846002)(26005)(52116002)(6506007)(6486002)(305945005)(6512007)(256004)(478600001)(2201001)(86362001)(4326008)(25786009)(106356001)(105586002)(7736002)(316002)(14444005)(110136005)(50226002)(14454004)(99286004)(8676002)(97736004)(81156014)(81166006)(53936002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3916;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tFNl8nKgS/UO/3gBEKheIQfDVGqn5C8I4+IqDAfX+Jn1uiMx54lQ9zXpKJDnd9sZXMRkX9QChfK+fFfVrWvSGJo6Lu+FpPo8pJn8wa266womN678z+U3u5o2x1WHlrgyuX0+cZI7Z44F0U8pB6NPuMQg3bB7D55uPIsDJiez3rdPoR5PVNbSKf8VIUkYPKuCviMgB24GgPt4K/z0px6vFx+hPOyk+J9Vmi6oqQ2GEcYkXHUs0ZzjOm82HrpkrGJj0U2ICAkPRNtsAKJHCCQIrR0dtl2HijWGQ+dAICl9hqiBEhJuOTs61T+ppWEM5q/Dv72FUrvz5OBEg/UQ2U4RT8UJgE8XOhY/L+XR3PN989aqGpFpHX35P1OZGpKOLZPCGeWIhEq6eNgVyJ+nnkK1p71H0/wtB4PfWkhNddOIM0Y=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 940ccd8f-7550-4c2a-5322-08d6a90ddf60
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2019 06:17:16.9376
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3916
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add i.MX system controller watchdog binding doc.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
New patch, as watchdog node is moved out of SCU, so we need to add binding =
doc for it.
---
 .../devicetree/bindings/watchdog/fsl-imx-sc-wdt.txt  | 20 ++++++++++++++++=
++++
 1 file changed, 20 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/fsl-imx-sc-w=
dt.txt

diff --git a/Documentation/devicetree/bindings/watchdog/fsl-imx-sc-wdt.txt =
b/Documentation/devicetree/bindings/watchdog/fsl-imx-sc-wdt.txt
new file mode 100644
index 0000000..e461c85
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/fsl-imx-sc-wdt.txt
@@ -0,0 +1,20 @@
+* Freescale i.MX System Controller Watchdog
+
+i.MX system controller watchdog is for i.MX SoCs with system controller in=
side,
+the watchdog is managed by system controller, users can ONLY communicate w=
ith
+system controller from secure mode for watchdog operations, so Linux i.MX =
system
+controller watchdog driver will call ARM SMC API and trap into ARM-Trusted=
-Firmware
+for watchdog operations, ARM-Trusted-Firmware is running at secure EL3 mod=
e and
+it will request system controller to execute the watchdog operation passed=
 from
+Linux kernel.
+
+Required properties:
+- compatible:	Should be :
+		"fsl,imx8qxp-sc-wdt"
+		followed by "fsl,imx-sc-wdt";
+
+Examples:
+
+watchdog {
+	compatible =3D "fsl,imx8qxp-sc-wdt", "fsl,imx-sc-wdt";
+};
--=20
2.7.4

