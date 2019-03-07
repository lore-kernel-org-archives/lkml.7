Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5C51C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 03:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ACD020661
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 03:41:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NC8hFIiq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbfCGDlI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 22:41:08 -0500
Received: from mail-eopbgr60083.outbound.protection.outlook.com ([40.107.6.83]:47856
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725793AbfCGDlH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 22:41:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C6A/rq0wXwBIqE9w5aOcqFEhwuF7G5yJllMKrYiW+GM=;
 b=NC8hFIiqHK+E9GnOUHlaO0KK2FMQUu65CgApILVKezNH4Df/BfxtixoXwPdEiQoXBxm/r/LtcwGFLoh8ncOIsc9iDooOwyPPaObUZg14rK61EJSs3sPnQzobfxDk6xAJWdfKvXxbhBj3D3et/fFN/2CxkuaH95eKCDBvuvSygUY=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3707.eurprd04.prod.outlook.com (52.134.65.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.18; Thu, 7 Mar 2019 03:41:03 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7%2]) with mapi id 15.20.1686.018; Thu, 7 Mar 2019
 03:41:03 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH 2/3] clk: imx8mq: add hdmi_phy_27m clock as pll's reference
 clock
Thread-Topic: [PATCH 2/3] clk: imx8mq: add hdmi_phy_27m clock as pll's
 reference clock
Thread-Index: AQHU1JeWR8aGkQFpX0a5WAuTNkYI2Q==
Date:   Thu, 7 Mar 2019 03:41:03 +0000
Message-ID: <1551929772-22633-2-git-send-email-Anson.Huang@nxp.com>
References: <1551929772-22633-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1551929772-22633-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0P153CA0046.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:17::34) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6687d2ba-6983-49d9-bea9-08d6a2aeb8ee
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3707;
x-ms-traffictypediagnostic: DB3PR0402MB3707:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DB3PR0402MB3707;23:qTRfwgEezuj2UKnZTYRTKmGdujBuXMsiiQNWB?=
 =?iso-8859-1?Q?3HeB9iAG9LAfg+IHDeDTFFNKwf+/WXvHwSoS6I033D1zp7N/OROvSMdPML?=
 =?iso-8859-1?Q?rL0y6Dq3lcOJAu/7pbbzqjD530tAidIiTBbF2f7GAf/HpD+bvtakixGPgg?=
 =?iso-8859-1?Q?DOhuR6vE3AXCRDmvdaBWvtq+z4/2qjAdx7X65MGc79f2MdZLal7VkozI0O?=
 =?iso-8859-1?Q?MI8jbXcVZeCJjss8azIg0zDU1D5b6PmiLrjOmq3a39QUe5/vkxEj0he1cw?=
 =?iso-8859-1?Q?OaEukJIhHfvWZDv4u7Hy5v6QIJOMLjxhH2P9HEDyJ6pW+WDiz0D4GD9O3W?=
 =?iso-8859-1?Q?FWm3JcLOpx4gjIHNxhyeH1eKQ1zQ0TboGEJGCa/0/RyA+pddQFRMSYWGz9?=
 =?iso-8859-1?Q?OAyyc9pPYoXoacnoY2fIKGTr3+aflKSgFA6L05UgDL4YmMy71kB/f/dfos?=
 =?iso-8859-1?Q?yYupqjhWpfDT89muj+NT8uibC0HNo76rZNq6iEwa/K8vs/WuCx9kuTUZ/J?=
 =?iso-8859-1?Q?dzIcfEwjVNSjjdEe61yqgGxubk/YL+aqN71oa4i6E2msnCdJMPyQi+ZTvi?=
 =?iso-8859-1?Q?4hpAgF7XnBHbDO60SXFT1/r/r67AmzftvWdL6ez2bvurV9kaAZn9X6GyfX?=
 =?iso-8859-1?Q?kTMz+6Eaxf5TIc25Frwd5rj5rD6S5dLY4qGuEL4cYL3JxP6+V2PK9GSZTs?=
 =?iso-8859-1?Q?vqlldM8zZ9sXXzNz4B4injTa0hkWi22cdTq0NA9w1T4bxuSBjHkm8V2lD5?=
 =?iso-8859-1?Q?yWfAPWxB9U9jWUsb+TaluZsPUVgr05EHmNm8XCtdJcAHi4JiixhvZOE2N/?=
 =?iso-8859-1?Q?qcyme7Ua9JuIMi/mvHxonG8IadCAfsN4j/srth6Au7HjSRhT4ExbsojJJ6?=
 =?iso-8859-1?Q?f2YLknDed1zeoOMStdwnbssu/lVVe9MUXRWY2aEXIat3ba8xXdBjfadcVk?=
 =?iso-8859-1?Q?i4DtkBkqEsv55ejQyQxkoP1zSpBmw3I56QxjwnTih2fmqlEGaqh57acCuy?=
 =?iso-8859-1?Q?OC5uMmE3sFbHfVLeIJPxLi74x40T53AjNqLNRAz3j8/7Sfvo6m0RKG9CIf?=
 =?iso-8859-1?Q?u/ny9hjHNmU4AeEj/dxeT6hWauCpdv95uEOA+1TJqJgpLifvpNG8feZEBJ?=
 =?iso-8859-1?Q?z1H/xC1yi9tODga+5B7pZ4eA6B18Pc/mefUt5g173bDF7UfqIR+8xbSVZM?=
 =?iso-8859-1?Q?xXuH8nGCUN+FIwdErRdHpE3gpjBLtlta9GNF0Z6qc/QHIJFCTU7kacRha8?=
 =?iso-8859-1?Q?rAs64QY3lIuPN8zXHtbZrJVffDCckCEOn2k+K94+D5/0h7Ulaz0qhoYWq1?=
 =?iso-8859-1?Q?aMWkcLQiXHNG5ZfLG3iBKk1Oc8lOO+eMPYtUf6i09qtd1mw=3D=3D?=
x-microsoft-antispam-prvs: <DB3PR0402MB3707B94BA2F6706EF8E503DFF54C0@DB3PR0402MB3707.eurprd04.prod.outlook.com>
x-forefront-prvs: 096943F07A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(39860400002)(346002)(376002)(366004)(189003)(199004)(99286004)(6116002)(446003)(76176011)(11346002)(26005)(186003)(6506007)(386003)(102836004)(52116002)(486006)(2616005)(476003)(3846002)(97736004)(50226002)(81156014)(8936002)(2501003)(81166006)(8676002)(68736007)(7736002)(305945005)(7416002)(256004)(478600001)(110136005)(14454004)(105586002)(71200400001)(66066001)(71190400001)(316002)(106356001)(2906002)(6436002)(14444005)(6486002)(5660300002)(36756003)(53936002)(6512007)(2201001)(86362001)(4326008)(25786009)(921003)(32563001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3707;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: R4dk7g1MuPZlPGgK4vBInyHB899wax8NXqxvAMz1tP4thLkpFdG18GGBKc1UGMfEjX0SIRAhgpQdPoXYS0oASxggqELQL5+lfT1fnWKPioMKGmJ8Pt1swBgviSQtaQ/ooMSUuU+sXjmGBj8RXG+aKvQISHlK5x/QDDFCFfMclG7StIhtAI0lAWEHasuuNyRrDtYrPgbNeaIXNUeS1nRPZXUH6KkPAK6k956yxLOh2XZMtaCuI1WwsjE25ImWgb4wpJipykcJOudxJvhdB9lVAAUrb7Zqn0XevyFiqShcvWM3tHL2aj/FoQ4hAPoH2LhMGzAe5Y1z3qoyJqI8jUfaCn/JhpqGb4495Wr84CJdNZWgpvYKo7gWdYWP+wQ6uVyjryIChtsA8Lw8BIRSv4vzMlbJw47oh006efRg7EVibtM=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6687d2ba-6983-49d9-bea9-08d6a2aeb8ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2019 03:41:03.2869
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3707
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is another 27MHz OSC inside i.MX8MQ's display block and
it can be one of reference clocks of all PLLs, add it into clock
tree and also add it as PLL's reference clock.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/clk/imx/clk-imx8mq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx8mq.c b/drivers/clk/imx/clk-imx8mq.c
index a9b3888..bb1bf9b 100644
--- a/drivers/clk/imx/clk-imx8mq.c
+++ b/drivers/clk/imx/clk-imx8mq.c
@@ -26,7 +26,7 @@ static u32 share_count_nand;
=20
 static struct clk *clks[IMX8MQ_CLK_END];
=20
-static const char * const pll_ref_sels[] =3D { "osc_25m", "osc_27m", "dumm=
y", "dummy", };
+static const char * const pll_ref_sels[] =3D { "osc_25m", "osc_27m", "osc_=
hdmi_phy_27m", "dummy", };
 static const char * const arm_pll_bypass_sels[] =3D {"arm_pll", "arm_pll_r=
ef_sel", };
 static const char * const gpu_pll_bypass_sels[] =3D {"gpu_pll", "gpu_pll_r=
ef_sel", };
 static const char * const vpu_pll_bypass_sels[] =3D {"vpu_pll", "vpu_pll_r=
ef_sel", };
@@ -281,6 +281,7 @@ static int imx8mq_clocks_probe(struct platform_device *=
pdev)
 	clks[IMX8MQ_CLK_32K] =3D of_clk_get_by_name(np, "ckil");
 	clks[IMX8MQ_CLK_25M] =3D of_clk_get_by_name(np, "osc_25m");
 	clks[IMX8MQ_CLK_27M] =3D of_clk_get_by_name(np, "osc_27m");
+	clks[IMX8MQ_CLK_HDMI_PHY_27M] =3D of_clk_get_by_name(np, "osc_hdmi_phy_27=
m");
 	clks[IMX8MQ_CLK_EXT1] =3D of_clk_get_by_name(np, "clk_ext1");
 	clks[IMX8MQ_CLK_EXT2] =3D of_clk_get_by_name(np, "clk_ext2");
 	clks[IMX8MQ_CLK_EXT3] =3D of_clk_get_by_name(np, "clk_ext3");
--=20
2.7.4

