Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7342CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 06:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42AD1218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 06:17:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="CBSNpIzA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728408AbfCOGRk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 02:17:40 -0400
Received: from mail-eopbgr80073.outbound.protection.outlook.com ([40.107.8.73]:34531
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728050AbfCOGRi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 02:17:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7sGnsRBR11as5w8QjMfK7m6wH02zar6x4YDWvQV1bm8=;
 b=CBSNpIzAEQayp7uFLxHft4sPLH4Mn3g55ro+FUZpcb6GQ7h4Gbzo57OALg5sb99XjxyuUQVh1KdxItxsZfxzHrAYkMB44V+0CxmJJw0pHJoXnbhn2AwmgQol4mXWbvcg4tsr3nzhlPbj/nIisZPFrG9dah7zX4gYcHdNcWByqxs=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Fri, 15 Mar 2019 06:17:34 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08%6]) with mapi id 15.20.1709.011; Fri, 15 Mar 2019
 06:17:34 +0000
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
Subject: [PATCH V8 3/4] arm64: defconfig: add support for i.MX system
 controller watchdog
Thread-Topic: [PATCH V8 3/4] arm64: defconfig: add support for i.MX system
 controller watchdog
Thread-Index: AQHU2vbHXeLS+eO0A0u5mLf/F8PrIw==
Date:   Fri, 15 Mar 2019 06:17:34 +0000
Message-ID: <1552630331-32068-4-git-send-email-Anson.Huang@nxp.com>
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
x-ms-office365-filtering-correlation-id: 98074593-5e6c-42b3-404a-08d6a90de981
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3916;
x-ms-traffictypediagnostic: DB3PR0402MB3916:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <DB3PR0402MB3916ECBCE58B7301FAF974E8F5440@DB3PR0402MB3916.eurprd04.prod.outlook.com>
x-forefront-prvs: 09778E995A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(376002)(346002)(39860400002)(366004)(199004)(189003)(8936002)(2501003)(102836004)(2906002)(6436002)(68736007)(5660300002)(7416002)(6116002)(66066001)(36756003)(446003)(71190400001)(486006)(4744005)(71200400001)(76176011)(6346003)(2616005)(476003)(186003)(386003)(11346002)(3846002)(26005)(52116002)(6506007)(6486002)(305945005)(6512007)(256004)(478600001)(2201001)(86362001)(4326008)(25786009)(106356001)(105586002)(7736002)(316002)(110136005)(50226002)(14454004)(99286004)(8676002)(97736004)(81156014)(81166006)(53936002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3916;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: wFI2tJt/COVApaSW1zuQpjzC5YodNsAXFH9F7SIsyc6lZT/9yjpjhu+/sGfcBV5T7y8lQkJixwCjdnCMvO5ovSXUbN55X0RUUIqy/ACXYVot7IvmCt/nIzJraM6sLFTl0iw7YLe6M2qjbguR2xaaD2hx77VX7NY0Mh4Yu8LapSNs330c+iRljY2fBA/XHOROfjsgfjm/zk+LOJ26MIqRlboDWxZZKhTm3mC9MHN/KyaU+8Z1VBkSnwPbFHJ/FZp4XMopsO/weOkIJ+nkTfB3LyfShMgFpRdfQ4UJHEXp2/jUqLXwWljwpsWLu350Zhux5wUA+f/X83LaqQQW2UlwwVK91cmMTOXTJBaQ+MxcucT95I4jY0EUu34iEszcFZ9rXKHKp1R2YhfCs6PkPyQaEeR6WqUv2PS72gxdfaeReBM=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98074593-5e6c-42b3-404a-08d6a90de981
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2019 06:17:34.1097
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3916
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable CONFIG_IMX_SC_WDT as module to support i.MX system
controller watchdog.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
No changes.
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 2d9c390..690f4ba 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -427,6 +427,7 @@ CONFIG_WATCHDOG=3Dy
 CONFIG_ARM_SP805_WATCHDOG=3Dy
 CONFIG_S3C2410_WATCHDOG=3Dy
 CONFIG_IMX2_WDT=3Dy
+CONFIG_IMX_SC_WDT=3Dm
 CONFIG_MESON_GXBB_WATCHDOG=3Dm
 CONFIG_MESON_WATCHDOG=3Dm
 CONFIG_RENESAS_WDT=3Dy
--=20
2.7.4

