Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5FFEC43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 12:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9508B222D0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 12:25:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="YTTW3dpy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbfKMMZT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 07:25:19 -0500
Received: from mail-eopbgr80071.outbound.protection.outlook.com ([40.107.8.71]:47362
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727427AbfKMMZS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 07:25:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qb9v0lnSuX7ly/JHz4Y/VCCHujtKD99qysKHOOk7x0WYiwL8ZVSsDkFFZ4oUpFkS6cCpMZI5UVpQ9EyURzenysQJcrk9i/n2ktPzA8Q4ljd/p7OYWiiAfEmGRul+ISEa2BWE9Mkpi4tbb+5e6zzh10p0Uc6HTcyfXoXhGi9LRvriPck+BsqXVYcCgvmMdTqghDSPgTKZqHdPnHHEh+JsEGppsV50x9y2K/86ceJSWT2rEwBY96w2XE4vkk1rHqoY3qJ8jV9NB0Sw/eMnfU7Yj2vWhPj6kXK22fWHGDG5DE4OUY9M7pxuf0JThtx1Lcp9OVZ+WL7199vM0qqtkByODA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gaKre0UKGUV6c1mHSzYN5TRobPztOjwZKpwPk93Jj1A=;
 b=MU1XjwrpFirFWuckXdYTCpJlnc69xNn1NulFuqGgJYSWmtz0+87IMrwmgVCX8jE2S4PiiuDEmxaauM7b+5IfsZ6JjhqD9lgNjz8LE1HhGd8ENO5jjTTf2CDN4ml6CgBVLE6yGgqBuokcbmZJXKtSXdL4/Xshlm2UTYYZEWb/kbkamaEX7wUeX6hPjN242IOMfxvxXtvtUZVnGRC6HekN9Fuy1cgjZu2AJVELD2MfNhOke3qjxvaQeuMCbkW1JSfYdEVgv6x4Fw6Rb6TFGHrqOKZ/bqdq13TjGQCsOKR3W2H9AASSi58DvpyGrD8YJHfmL3whAtZKraJx1LHJmyahbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gaKre0UKGUV6c1mHSzYN5TRobPztOjwZKpwPk93Jj1A=;
 b=YTTW3dpyZ6zpo9lud/so2+uLXeAFYb2oXhXQ0HdmJ5o8l2IuXvIiBUmkzakBF24U35amW/eH1US4rCtdLk37k5tymZKQtNykJ9Hs1XxOG8NQWL4Mc3j8uVqh0RyDkNTH7RIRRrn8DnwcmZtLiTV16uh+Jft2vo3wERkVGK1MchA=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB4499.eurprd04.prod.outlook.com (52.135.151.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.23; Wed, 13 Nov 2019 12:25:13 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::fd44:1b14:587c:9fde]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::fd44:1b14:587c:9fde%7]) with mapi id 15.20.2430.027; Wed, 13 Nov 2019
 12:25:13 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Aisheng Dong <aisheng.dong@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Jacky Bai <ping.bai@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: [PATCH 1/3] dt-bindings: imx8-clock: Add ADMA clock ids
Thread-Topic: [PATCH 1/3] dt-bindings: imx8-clock: Add ADMA clock ids
Thread-Index: AQHVmh1lUtcvIOh5CU6AJDEM/1tcYw==
Date:   Wed, 13 Nov 2019 12:25:13 +0000
Message-ID: <1573647909-31081-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR0402CA0014.eurprd04.prod.outlook.com
 (2603:10a6:208:15::27) To AM0PR04MB5779.eurprd04.prod.outlook.com
 (2603:10a6:208:131::23)
x-originating-ip: [89.37.124.34]
x-mailer: git-send-email 2.7.4
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 799d458e-3196-4a59-decb-08d7683487fc
x-ms-traffictypediagnostic: AM0PR04MB4499:|AM0PR04MB4499:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB44990E7D41C70FB5ACE391E7F6760@AM0PR04MB4499.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1443;
x-forefront-prvs: 0220D4B98D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(396003)(366004)(136003)(376002)(199004)(189003)(486006)(44832011)(2616005)(71200400001)(66446008)(66476007)(102836004)(86362001)(6506007)(386003)(71190400001)(64756008)(256004)(6512007)(476003)(66066001)(5660300002)(36756003)(66946007)(4326008)(66556008)(6636002)(6436002)(26005)(186003)(2906002)(7736002)(110136005)(8676002)(52116002)(99286004)(8936002)(316002)(478600001)(54906003)(14454004)(6116002)(3846002)(50226002)(25786009)(6486002)(305945005)(81156014)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4499;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6ekcCsHY+lw3rzCwdNIlBjypUBjlt0c/bIJgO5TScimdKcciHTpvqItTHN1q9TIkwcUn36DnXzW/MK7n+hLmZg07DHMTHwNM1dewtqhmgJ2O2LDNAKXGUyqdA/Q6o1IndonJ5oCCbcYmWQgxU7uagRtGCBbZYmqFKbflRJ6npy+7pssBv2xwyqF/crTtkzJDFNq5zn/DCJhPUjuhVilcP1V1UgqzvReFY4ZIrw4EO7kNKsreme7FMe04kaEJ2gZw287VR5o26LEoz7foNxeUrEHGHdkr2mBjIASZe6jKL8s5ltkoV6hSRTyeRYBWBG9IlPQmkSeBbWkJtMxwGyzNW4foqtju2v6eYyPWjw1m31Vh7mRDL3rHz9vFxFCB9jzvstJwD9p7veIrsml/eIx9tu+iTuKZFJPTKA6ouEuPM5QCmrU8obxAyYufh0pKjWqU
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 799d458e-3196-4a59-decb-08d7683487fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2019 12:25:13.1385
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dWGyW3tM323gjhyci5Xu1iBTfiaPeVhwMc9jm+EdwOStPFVcZkhcZOkhiDmKQe7arWUAv/++p1GCFnLaeqXhVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4499
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the RM, the Audio and DMA (ADMA) subsystem is a collection
of audio peripherals and some system modules.
Add the ADMA specific clock ids to the dt-bindings clock file.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 include/dt-bindings/clock/imx8-clock.h | 96 ++++++++++++++++++++++++++++++=
+++-
 1 file changed, 94 insertions(+), 2 deletions(-)

diff --git a/include/dt-bindings/clock/imx8-clock.h b/include/dt-bindings/c=
lock/imx8-clock.h
index 673a8c6..6e0c752 100644
--- a/include/dt-bindings/clock/imx8-clock.h
+++ b/include/dt-bindings/clock/imx8-clock.h
@@ -131,7 +131,60 @@
 #define IMX_ADMA_PWM_CLK				188
 #define IMX_ADMA_LCD_CLK				189
=20
-#define IMX_SCU_CLK_END					190
+#define IMX_ADMA_AUD_PLL0				190
+#define IMX_ADMA_AUD_PLL1				191
+
+#define IMX_ADMA_AUD_PLL_DIV_CLK0_CLK			192
+#define IMX_ADMA_AUD_PLL_DIV_CLK1_CLK			193
+#define IMX_ADMA_AUD_REC_CLK0_CLK			194
+#define IMX_ADMA_AUD_REC_CLK1_CLK			195
+
+/* CM40 SS */
+#define IMX_CM40_IPG_CLK				196
+#define IMX_CM40_I2C_DIV				197
+
+#define IMX_SCU_CLK_END					198
+
+#define IMX_ADMA_ACM_AUD_CLK0_SEL			0
+#define IMX_ADMA_ACM_AUD_CLK0_CLK			1
+#define IMX_ADMA_ACM_AUD_CLK1_SEL			2
+#define IMX_ADMA_ACM_AUD_CLK1_CLK			3
+#define IMX_ADMA_ACM_MCLKOUT0_SEL			4
+#define IMX_ADMA_ACM_MCLKOUT1_SEL			5
+#define IMX_ADMA_ACM_ESAI0_MCLK_SEL			6
+#define IMX_ADMA_ACM_GPT0_MUX_CLK_SEL			7
+#define IMX_ADMA_ACM_GPT1_MUX_CLK_SEL			8
+#define IMX_ADMA_ACM_GPT2_MUX_CLK_SEL			9
+#define IMX_ADMA_ACM_GPT3_MUX_CLK_SEL			10
+#define IMX_ADMA_ACM_GPT4_MUX_CLK_SEL			11
+#define IMX_ADMA_ACM_GPT5_MUX_CLK_SEL			12
+#define IMX_ADMA_ACM_SAI0_MCLK_SEL			13
+#define IMX_ADMA_ACM_SAI1_MCLK_SEL			14
+#define IMX_ADMA_ACM_SAI2_MCLK_SEL			15
+#define IMX_ADMA_ACM_SAI3_MCLK_SEL			16
+#define IMX_ADMA_ACM_SAI4_MCLK_SEL			17
+#define IMX_ADMA_ACM_SAI5_MCLK_SEL			18
+#define IMX_ADMA_ACM_SPDIF0_TX_CLK_SEL			19
+#define IMX_ADMA_ACM_MQS_TX_CLK_SEL			20
+#define IMX_ADMA_ACM_ASRC0_MUX_CLK_SEL			21
+#define IMX_ADMA_ACM_ASRC1_MUX_CLK_SEL			22
+
+#define IMX_ADMA_EXT_AUD_MCLK0				23
+#define IMX_ADMA_EXT_AUD_MCLK1				24
+#define IMX_ADMA_ESAI0_RX_CLK				25
+#define IMX_ADMA_ESAI0_RX_HF_CLK			26
+#define IMX_ADMA_ESAI0_TX_CLK				27
+#define IMX_ADMA_ESAI0_TX_HF_CLK			28
+#define IMX_ADMA_SPDIF0_RX				29
+#define IMX_ADMA_SAI0_RX_BCLK				30
+#define IMX_ADMA_SAI0_TX_BCLK				31
+#define IMX_ADMA_SAI1_RX_BCLK				32
+#define IMX_ADMA_SAI1_TX_BCLK				33
+#define IMX_ADMA_SAI2_RX_BCLK				34
+#define IMX_ADMA_SAI3_RX_BCLK				35
+#define IMX_ADMA_SAI4_RX_BCLK				36
+
+#define IMX_ADMA_ACM_CLK_END				37
=20
 /* LPCG clocks */
=20
@@ -287,7 +340,46 @@
 #define IMX_ADMA_LPCG_DSP_IPG_CLK			42
 #define IMX_ADMA_LPCG_DSP_CORE_CLK			43
 #define IMX_ADMA_LPCG_OCRAM_IPG_CLK			44
+#define IMX_ADMA_LPCG_AMIX_IPG_CLK			45
+#define IMX_ADMA_LPCG_ESAI_0_IPG_CLK			46
+#define IMX_ADMA_LPCG_ESAI_0_EXTAL_CLK			47
+#define IMX_ADMA_LPCG_SAI_0_IPG_CLK			48
+#define IMX_ADMA_LPCG_SAI_0_MCLK			49
+#define IMX_ADMA_LPCG_SAI_1_IPG_CLK			50
+#define IMX_ADMA_LPCG_SAI_1_MCLK			51
+#define IMX_ADMA_LPCG_SAI_2_IPG_CLK			52
+#define IMX_ADMA_LPCG_SAI_2_MCLK			53
+#define IMX_ADMA_LPCG_SAI_3_IPG_CLK			54
+#define IMX_ADMA_LPCG_SAI_3_MCLK			55
+#define IMX_ADMA_LPCG_SAI_4_IPG_CLK			56
+#define IMX_ADMA_LPCG_SAI_4_MCLK			57
+#define IMX_ADMA_LPCG_SAI_5_IPG_CLK			58
+#define IMX_ADMA_LPCG_SAI_5_MCLK			59
+#define IMX_ADMA_LPCG_MQS_IPG_CLK			60
+#define IMX_ADMA_LPCG_MQS_MCLK				61
+#define IMX_ADMA_LPCG_GPT5_IPG_CLK			62
+#define IMX_ADMA_LPCG_GPT5_CLKIN			63
+#define IMX_ADMA_LPCG_GPT6_IPG_CLK			64
+#define IMX_ADMA_LPCG_GPT6_CLKIN			65
+#define IMX_ADMA_LPCG_GPT7_IPG_CLK			66
+#define IMX_ADMA_LPCG_GPT7_CLKIN			67
+#define IMX_ADMA_LPCG_GPT8_IPG_CLK			68
+#define IMX_ADMA_LPCG_GPT8_CLKIN			69
+#define IMX_ADMA_LPCG_GPT9_IPG_CLK			70
+#define IMX_ADMA_LPCG_GPT9_CLKIN			71
+#define IMX_ADMA_LPCG_GPT10_IPG_CLK			72
+#define IMX_ADMA_LPCG_GPT10_CLKIN			73
+#define IMX_ADMA_LPCG_MCLKOUT0				74
+#define IMX_ADMA_LPCG_MCLKOUT1				75
+#define IMX_ADMA_LPCG_SPDIF_0_TX_CLK			76
+#define IMX_ADMA_LPCG_SPDIF_0_GCLKW			77
+#define IMX_ADMA_LPCG_ASRC_0_IPG_CLK			79
+#define IMX_ADMA_LPCG_ASRC_1_IPG_CLK			80
+#define IMX_ADMA_LPCG_AUD_PLL_DIV_CLK0_CLK		81
+#define IMX_ADMA_LPCG_AUD_PLL_DIV_CLK1_CLK		82
+#define IMX_ADMA_LPCG_AUD_REC_CLK0_CLK			83
+#define IMX_ADMA_LPCG_AUD_REC_CLK1_CLK			84
=20
-#define IMX_ADMA_LPCG_CLK_END				45
+#define IMX_ADMA_LPCG_CLK_END				85
=20
 #endif /* __DT_BINDINGS_CLOCK_IMX_H */
--=20
2.7.4

