Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8322ECE587
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 07:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86D5C205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 07:06:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="H5DL+7CK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbfJOHF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 03:05:59 -0400
Received: from mail-eopbgr20044.outbound.protection.outlook.com ([40.107.2.44]:10834
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726236AbfJOHF6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 03:05:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lX9oZzMXjFu7JdXJZAFnrVsb9OvitHt+gnpPnqwj/OU8LSVv2hDoRo9gpE9lBwZhABYbaRL06k3okKc8VZHQZdSh+smWIzr7f+XtYtXzPqxg6d0Yq4XZR5DoI9tkmVkIkaxbCaoirJgETrTC4gADLr8c6j5KDpeK24STHa1CtFxLZV9l/owgLLpEUoNmYcpzgSCg7EMLQHBxkxYkhZCcgXdEdYMW9nGkGKJSPr/sh5JgzpuiRTYfkruuISwFeF0hRI493DRy2Lw2VWbLvQ2/Nn4SOBN+3V7DBijkOCog2Dno+sq1XBs83aPvzzq9Hk8XEQFnNnb9I1VhL/NNn8rRmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DCbBUNqU2Xi+G69tYMOFUCw6uVPSzHYICKtvvfwAFGg=;
 b=QDmf/BF0nklnRNrNoC8fby2gNWhhH7Ctjoge+BJOcSN2QfZBAe6URifi3X6eIl4jCU46uXEgGhIQ52bYT4Sb4tNt95540zzz59IZlxquqQhRaHQ9gmVZQixaOnSRhT8bDQoWi/eL3QE68bbfXnhE+ZsKyaXrqEguCXSci0Maq22Qa5lssqgCv2zjDY1gKJxX54J/j3e+K/iQmU6AzarLCfNwfBvtS0cHY+yhWYKARZor5roreB18UCeb/rk4u+9Z5Bigm8U7WU5gGXff3Ml7gDeoXTfzzBDJHv1uQs2en2Sfpi1c2qbZw0Vfub04qkc4XT8bpjHEjHneZBghGx1h7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DCbBUNqU2Xi+G69tYMOFUCw6uVPSzHYICKtvvfwAFGg=;
 b=H5DL+7CKXAz2/qAb8SJVMPUiuMy7ecSAXNSN91tNug45pB4drX3QAvYbDD2f/iRTFw57yHNj/eIF81I9OahLdAbRR/WFTO3Ci5eL8HbjioYsO5hWw+Wsm3gk4AGqDcbaHvSodHwYzjH6dV9oL1b1rW/0g78UB3EszA3Q921ELXg=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6721.eurprd04.prod.outlook.com (20.179.254.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Tue, 15 Oct 2019 07:05:53 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::843c:e722:27cb:74e1]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::843c:e722:27cb:74e1%5]) with mapi id 15.20.2347.021; Tue, 15 Oct 2019
 07:05:53 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, Abel Vesa <abel.vesa@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] clk: imx: imx8mn: drop unused pll enum
Thread-Topic: [PATCH] clk: imx: imx8mn: drop unused pll enum
Thread-Index: AQHVgyb7rQc7WB2ptUeNJcHfwDTOYA==
Date:   Tue, 15 Oct 2019 07:05:53 +0000
Message-ID: <1571122989-29361-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR02CA0190.apcprd02.prod.outlook.com
 (2603:1096:201:21::26) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 06e83f04-0a7f-4d80-fe22-08d7513e1ddc
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: AM0PR04MB6721:|AM0PR04MB6721:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB6721369DFE571E81DBB2B8D388930@AM0PR04MB6721.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:628;
x-forefront-prvs: 01917B1794
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(39860400002)(376002)(396003)(366004)(199004)(189003)(50226002)(71200400001)(71190400001)(66946007)(81166006)(81156014)(52116002)(256004)(25786009)(4744005)(316002)(2201001)(5660300002)(14454004)(66446008)(64756008)(66556008)(66476007)(305945005)(99286004)(44832011)(2906002)(7736002)(36756003)(6436002)(3846002)(6506007)(478600001)(86362001)(486006)(2501003)(2616005)(476003)(6116002)(26005)(102836004)(386003)(66066001)(8676002)(6512007)(4326008)(186003)(110136005)(6486002)(54906003)(8936002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6721;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LU9bcTCVdIyVLT45Y8G2ke8kM9cdX4io2JYo+jZ3jzuWBsOqPnpZ20vCX0yM0J/gwhgOUM6c6GOif2NO6XU+a9eJBPIXFrgSCz5uHPAnl0g/2e69p9fR01oG48Wckc3wS4I3P/9V+pStp4mMky8A3zgJZ0lpUoKNPGqsOCmD/eIyfYQOWjuWRayMefx4ZqmhS5CKryUwQBeFF6cRnkprGXTUFb7omjNJoAfT5U2NHEGNDqecd9bHUvAhwFBGUK7dP1Lppb3H4SqsnRby1MRu28+CGDE31rL7+Sqflil+9LgNLl73zNEKMHOyJpUnQ/Uy9GrbM2+GvpAsLtbacB7c++RE5TkM7bhoFje4fTjzMjq9lpR7RjmMeYB8jObMG3hdxBMNddL2kHJlNzbcRi9/Ez8JQFT/PnTOsySq3YW7TrE=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06e83f04-0a7f-4d80-fe22-08d7513e1ddc
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2019 07:05:53.0926
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p3KHzXThsDYvFMOcBH+qhnmQ89rLcK+C032FiSjiVizYvtLZNk8gzkaaZsrEW9DrWcP6q3sYZbJYHiF4aseZ7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6721
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

The PLL enum definition is not used, so drop it.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx8mn.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx8mn.c
index 28467db10c69..6ab6e9228962 100644
--- a/drivers/clk/imx/clk-imx8mn.c
+++ b/drivers/clk/imx/clk-imx8mn.c
@@ -25,20 +25,6 @@ static u32 share_count_disp;
 static u32 share_count_pdm;
 static u32 share_count_nand;
=20
-enum {
-	ARM_PLL,
-	GPU_PLL,
-	VPU_PLL,
-	SYS_PLL1,
-	SYS_PLL2,
-	SYS_PLL3,
-	DRAM_PLL,
-	AUDIO_PLL1,
-	AUDIO_PLL2,
-	VIDEO_PLL2,
-	NR_PLLS,
-};
-
 static const char * const pll_ref_sels[] =3D { "osc_24m", "dummy", "dummy"=
, "dummy", };
 static const char * const audio_pll1_bypass_sels[] =3D {"audio_pll1", "aud=
io_pll1_ref_sel", };
 static const char * const audio_pll2_bypass_sels[] =3D {"audio_pll2", "aud=
io_pll2_ref_sel", };
--=20
2.16.4

