Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F4D2C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AF2920721
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:17:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="F1/5SwTU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729940AbfKVKs1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:48:27 -0500
Received: from mail-eopbgr70054.outbound.protection.outlook.com ([40.107.7.54]:28323
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729436AbfKVKsY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:48:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DSbugRl50dRzBL8elSIneMNzLxS8WmVjYKn4cwmg9TffFZXj/BFks/EhF6+jmmR7v0zAVIQcCDRuJag6tyVFZjTtzJKSMW7dP47cgCNkTM6RVd9GMqgTgOO97wZ7x8xV+hoYhZWvJIarYjT6xH8evgiDx3o7VUPyhmeeGTJoc7eBYGvqnqt+wDBkXWdfocO1z99lIXYY5vP8dQHJPCYmdwjTZtq0dKHPn8Wj6FKRuu+XbcfOT0sc7ME+DAn+NvkAkL6YiYLb5muQCLUKavPgjkGvuarnDYY/tvChMSCvsQJMgN0lVQRgEDeDTVrTWCMhpT+vKADLO6qCI5fsue+mFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=co9cb+A0AGS5c92Syz8c52yrV+P87z5U37kAMuET7MY=;
 b=TdD4cr2gOb37Dw+mcCdSQwXEWb79zKuWV8acrfw05ppnWiCk+GnBdIiC4P42pk/0PWOXEwYPUia9de+AT9FSUnmxbkNjqcGd511IdYq47FRSaQXbsSW4j7jiOauIpw0dInIk2W6z3gdu4lG+kn4lQve5vhJxStZ8QQLgd8RwRE2tN+TGsQgmDUTeC2P29PDsVyuDgr1+eTTGGGGwE7K5Bu4amIUtwvA4YlHnzwHXNBreJuuotcW+jPwF7LWTiCsaZgN69qRD87joGhkc8A/iwYoGd5xeAwE0VSQ8WK0AreL/nvL2ZEnyza8xOePxjlTx9dXKQ/+KzfrpkmUR32cwfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=co9cb+A0AGS5c92Syz8c52yrV+P87z5U37kAMuET7MY=;
 b=F1/5SwTU+8zFFz5oza746JooiNHxe5PhcTMWjzNTDa7lIsfRvUeKpgUQa1uNGaGc/mRRDYEfd3TLd9aC+jVAheG4MEy0GP6yYy6RSjyVEBZkFNIU2wje/f6oMw8PdcE+O57WcbkR53CDThvmbi1M7bOM+9xURZdEDK/wzH7sxoY=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB5074.eurprd04.prod.outlook.com (20.177.42.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.19; Fri, 22 Nov 2019 10:48:12 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::fd44:1b14:587c:9fde]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::fd44:1b14:587c:9fde%7]) with mapi id 15.20.2474.019; Fri, 22 Nov 2019
 10:48:12 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Aisheng Dong <aisheng.dong@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Jacky Bai <ping.bai@nxp.com>
CC:     Peng Fan <peng.fan@nxp.com>, dl-linux-imx <linux-imx@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH v2 02/11] clk: imx: Rename the SCCG to SSCG
Thread-Topic: [PATCH v2 02/11] clk: imx: Rename the SCCG to SSCG
Thread-Index: AQHVoSJVos81iAs140qQzPKlu2RTzQ==
Date:   Fri, 22 Nov 2019 10:48:12 +0000
Message-ID: <1574419679-3813-3-git-send-email-abel.vesa@nxp.com>
References: <1574419679-3813-1-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1574419679-3813-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR0402CA0020.eurprd04.prod.outlook.com
 (2603:10a6:208:15::33) To AM0PR04MB5779.eurprd04.prod.outlook.com
 (2603:10a6:208:131::23)
x-originating-ip: [89.37.124.34]
x-mailer: git-send-email 2.7.4
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 32aec2a1-8b4b-4844-23a2-08d76f397836
x-ms-traffictypediagnostic: AM0PR04MB5074:|AM0PR04MB5074:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB5074B55F5C7DC52ABE2460AFF6490@AM0PR04MB5074.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 02296943FF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(366004)(346002)(376002)(396003)(136003)(189003)(199004)(478600001)(14444005)(256004)(6506007)(54906003)(30864003)(7736002)(305945005)(316002)(71200400001)(5660300002)(110136005)(102836004)(186003)(86362001)(66066001)(71190400001)(2906002)(4326008)(76176011)(966005)(99286004)(36756003)(26005)(52116002)(386003)(8936002)(3846002)(2616005)(446003)(44832011)(11346002)(66556008)(66476007)(66446008)(64756008)(6486002)(66946007)(6436002)(81166006)(8676002)(81156014)(6636002)(6306002)(6512007)(25786009)(14454004)(50226002)(6116002)(559001)(579004)(569006);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5074;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 97Z1JjGEZaRD6EXCwUJyNT9c7RIPFc4X/p2UpaH+MbwRW2dlawxiP/VPITcQrnTZN2bK+GOuGNdw/DFDRUVaLBBCf77BYvVUutJiMu1P4nlX2Awdl5B0BD/piDe0cHZn5JcECBLoZxknDPOkOwoi1ERdT223b6fWbgkx6a9vk0D8y0xVnEGvxz3cpQ98c5didl0nJkuBt26Y6DWI8YgmX5a2aVM/aYMl7ZeZPjUiXyxx+jOrrL5yWR/aQH3CapQWCXfygBB/hcompSs9pqr8ZbB84nvdK4gm5kkP089InpVNDsah4PniPycr7tSVsHelY1cQQ/AJyiRJyR0k5Wd4BY5RX1s8KzoqsnQKITUu05ApPOW5/KmlDG/PGvJV+vGb5kOxo3JADjd2Dm2aYLcWvML+zJcNgv9GSEBn3uEET9NgWdtP/VmnV0wjniYBv7LmLkIsFPpfiqM0P24wc6MLH/Ccy0OSvNbkkd7E/jlkkb0=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32aec2a1-8b4b-4844-23a2-08d76f397836
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2019 10:48:12.0865
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xAJDDFY2k/RtlIw+nM5VvZaI+78GqUPS5AZ8mDAt4VwzzjKOrAGT01ssqhdG1YGyeUtyFwCkzjLuNYIGyhW1sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5074
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the manual the acronym stands for
Spread Sprectum Clock Generator.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/clk/imx/Makefile       |   2 +-
 drivers/clk/imx/clk-imx8mq.c   |   6 +-
 drivers/clk/imx/clk-sccg-pll.c | 549 -------------------------------------=
----
 drivers/clk/imx/clk-sscg-pll.c | 549 +++++++++++++++++++++++++++++++++++++=
++++
 drivers/clk/imx/clk.h          |   4 +-
 5 files changed, 555 insertions(+), 555 deletions(-)
 delete mode 100644 drivers/clk/imx/clk-sccg-pll.c
 create mode 100644 drivers/clk/imx/clk-sscg-pll.c

diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
index 77a3d71..3724ba7 100644
--- a/drivers/clk/imx/Makefile
+++ b/drivers/clk/imx/Makefile
@@ -18,7 +18,7 @@ obj-$(CONFIG_MXC_CLK) +=3D \
 	clk-pllv2.o \
 	clk-pllv3.o \
 	clk-pllv4.o \
-	clk-sccg-pll.o \
+	clk-sscg-pll.o \
 	clk-pll14xx.o
=20
 obj-$(CONFIG_MXC_CLK_SCU) +=3D \
diff --git a/drivers/clk/imx/clk-imx8mq.c b/drivers/clk/imx/clk-imx8mq.c
index 5f10a60..f2a35b1 100644
--- a/drivers/clk/imx/clk-imx8mq.c
+++ b/drivers/clk/imx/clk-imx8mq.c
@@ -342,9 +342,9 @@ static int imx8mq_clocks_probe(struct platform_device *=
pdev)
=20
 	clks[IMX8MQ_SYS1_PLL_OUT] =3D imx_clk_fixed("sys1_pll_out", 800000000);
 	clks[IMX8MQ_SYS2_PLL_OUT] =3D imx_clk_fixed("sys2_pll_out", 1000000000);
-	clks[IMX8MQ_SYS3_PLL_OUT] =3D imx_clk_sccg_pll("sys3_pll_out", sys3_pll_o=
ut_sels, ARRAY_SIZE(sys3_pll_out_sels), 0, 0, 0, base + 0x48, CLK_IS_CRITIC=
AL);
-	clks[IMX8MQ_DRAM_PLL_OUT] =3D imx_clk_sccg_pll("dram_pll_out", dram_pll_o=
ut_sels, ARRAY_SIZE(dram_pll_out_sels), 0, 0, 0, base + 0x60, CLK_IS_CRITIC=
AL);
-	clks[IMX8MQ_VIDEO2_PLL_OUT] =3D imx_clk_sccg_pll("video2_pll_out", video2=
_pll_out_sels, ARRAY_SIZE(video2_pll_out_sels), 0, 0, 0, base + 0x54, 0);
+	clks[IMX8MQ_SYS3_PLL_OUT] =3D imx_clk_sscg_pll("sys3_pll_out", sys3_pll_o=
ut_sels, ARRAY_SIZE(sys3_pll_out_sels), 0, 0, 0, base + 0x48, CLK_IS_CRITIC=
AL);
+	clks[IMX8MQ_DRAM_PLL_OUT] =3D imx_clk_sscg_pll("dram_pll_out", dram_pll_o=
ut_sels, ARRAY_SIZE(dram_pll_out_sels), 0, 0, 0, base + 0x60, CLK_IS_CRITIC=
AL);
+	clks[IMX8MQ_VIDEO2_PLL_OUT] =3D imx_clk_sscg_pll("video2_pll_out", video2=
_pll_out_sels, ARRAY_SIZE(video2_pll_out_sels), 0, 0, 0, base + 0x54, 0);
=20
 	/* SYS PLL1 fixed output */
 	clks[IMX8MQ_SYS1_PLL_40M_CG] =3D imx_clk_gate("sys1_pll_40m_cg", "sys1_pl=
l_out", base + 0x30, 9);
diff --git a/drivers/clk/imx/clk-sccg-pll.c b/drivers/clk/imx/clk-sccg-pll.=
c
deleted file mode 100644
index 5d65f65..00000000
--- a/drivers/clk/imx/clk-sccg-pll.c
+++ /dev/null
@@ -1,549 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0 OR MIT)
-/*
- * Copyright 2018 NXP.
- *
- * This driver supports the SCCG plls found in the imx8m SOCs
- *
- * Documentation for this SCCG pll can be found at:
- *   https://www.nxp.com/docs/en/reference-manual/IMX8MDQLQRM.pdf#page=3D8=
34
- */
-
-#include <linux/clk-provider.h>
-#include <linux/err.h>
-#include <linux/io.h>
-#include <linux/iopoll.h>
-#include <linux/slab.h>
-#include <linux/bitfield.h>
-
-#include "clk.h"
-
-/* PLL CFGs */
-#define PLL_CFG0		0x0
-#define PLL_CFG1		0x4
-#define PLL_CFG2		0x8
-
-#define PLL_DIVF1_MASK		GENMASK(18, 13)
-#define PLL_DIVF2_MASK		GENMASK(12, 7)
-#define PLL_DIVR1_MASK		GENMASK(27, 25)
-#define PLL_DIVR2_MASK		GENMASK(24, 19)
-#define PLL_DIVQ_MASK           GENMASK(6, 1)
-#define PLL_REF_MASK		GENMASK(2, 0)
-
-#define PLL_LOCK_MASK		BIT(31)
-#define PLL_PD_MASK		BIT(7)
-
-/* These are the specification limits for the SSCG PLL */
-#define PLL_REF_MIN_FREQ		25000000UL
-#define PLL_REF_MAX_FREQ		235000000UL
-
-#define PLL_STAGE1_MIN_FREQ		1600000000UL
-#define PLL_STAGE1_MAX_FREQ		2400000000UL
-
-#define PLL_STAGE1_REF_MIN_FREQ		25000000UL
-#define PLL_STAGE1_REF_MAX_FREQ		54000000UL
-
-#define PLL_STAGE2_MIN_FREQ		1200000000UL
-#define PLL_STAGE2_MAX_FREQ		2400000000UL
-
-#define PLL_STAGE2_REF_MIN_FREQ		54000000UL
-#define PLL_STAGE2_REF_MAX_FREQ		75000000UL
-
-#define PLL_OUT_MIN_FREQ		20000000UL
-#define PLL_OUT_MAX_FREQ		1200000000UL
-
-#define PLL_DIVR1_MAX			7
-#define PLL_DIVR2_MAX			63
-#define PLL_DIVF1_MAX			63
-#define PLL_DIVF2_MAX			63
-#define PLL_DIVQ_MAX			63
-
-#define PLL_BYPASS_NONE			0x0
-#define PLL_BYPASS1			0x2
-#define PLL_BYPASS2			0x1
-
-#define SSCG_PLL_BYPASS1_MASK           BIT(5)
-#define SSCG_PLL_BYPASS2_MASK           BIT(4)
-#define SSCG_PLL_BYPASS_MASK		GENMASK(5, 4)
-
-#define PLL_SCCG_LOCK_TIMEOUT		70
-
-struct clk_sccg_pll_setup {
-	int divr1, divf1;
-	int divr2, divf2;
-	int divq;
-	int bypass;
-
-	uint64_t vco1;
-	uint64_t vco2;
-	uint64_t fout;
-	uint64_t ref;
-	uint64_t ref_div1;
-	uint64_t ref_div2;
-	uint64_t fout_request;
-	int fout_error;
-};
-
-struct clk_sccg_pll {
-	struct clk_hw	hw;
-	const struct clk_ops  ops;
-
-	void __iomem *base;
-
-	struct clk_sccg_pll_setup setup;
-
-	u8 parent;
-	u8 bypass1;
-	u8 bypass2;
-};
-
-#define to_clk_sccg_pll(_hw) container_of(_hw, struct clk_sccg_pll, hw)
-
-static int clk_sccg_pll_wait_lock(struct clk_sccg_pll *pll)
-{
-	u32 val;
-
-	val =3D readl_relaxed(pll->base + PLL_CFG0);
-
-	/* don't wait for lock if all plls are bypassed */
-	if (!(val & SSCG_PLL_BYPASS2_MASK))
-		return readl_poll_timeout(pll->base, val, val & PLL_LOCK_MASK,
-						0, PLL_SCCG_LOCK_TIMEOUT);
-
-	return 0;
-}
-
-static int clk_sccg_pll2_check_match(struct clk_sccg_pll_setup *setup,
-					struct clk_sccg_pll_setup *temp_setup)
-{
-	int new_diff =3D temp_setup->fout - temp_setup->fout_request;
-	int diff =3D temp_setup->fout_error;
-
-	if (abs(diff) > abs(new_diff)) {
-		temp_setup->fout_error =3D new_diff;
-		memcpy(setup, temp_setup, sizeof(struct clk_sccg_pll_setup));
-
-		if (temp_setup->fout_request =3D=3D temp_setup->fout)
-			return 0;
-	}
-	return -1;
-}
-
-static int clk_sccg_divq_lookup(struct clk_sccg_pll_setup *setup,
-				struct clk_sccg_pll_setup *temp_setup)
-{
-	int ret =3D -EINVAL;
-
-	for (temp_setup->divq =3D 0; temp_setup->divq <=3D PLL_DIVQ_MAX;
-	     temp_setup->divq++) {
-		temp_setup->vco2 =3D temp_setup->vco1;
-		do_div(temp_setup->vco2, temp_setup->divr2 + 1);
-		temp_setup->vco2 *=3D 2;
-		temp_setup->vco2 *=3D temp_setup->divf2 + 1;
-		if (temp_setup->vco2 >=3D PLL_STAGE2_MIN_FREQ &&
-				temp_setup->vco2 <=3D PLL_STAGE2_MAX_FREQ) {
-			temp_setup->fout =3D temp_setup->vco2;
-			do_div(temp_setup->fout, 2 * (temp_setup->divq + 1));
-
-			ret =3D clk_sccg_pll2_check_match(setup, temp_setup);
-			if (!ret) {
-				temp_setup->bypass =3D PLL_BYPASS1;
-				return ret;
-			}
-		}
-	}
-
-	return ret;
-}
-
-static int clk_sccg_divf2_lookup(struct clk_sccg_pll_setup *setup,
-					struct clk_sccg_pll_setup *temp_setup)
-{
-	int ret =3D -EINVAL;
-
-	for (temp_setup->divf2 =3D 0; temp_setup->divf2 <=3D PLL_DIVF2_MAX;
-	     temp_setup->divf2++) {
-		ret =3D clk_sccg_divq_lookup(setup, temp_setup);
-		if (!ret)
-			return ret;
-	}
-
-	return ret;
-}
-
-static int clk_sccg_divr2_lookup(struct clk_sccg_pll_setup *setup,
-				struct clk_sccg_pll_setup *temp_setup)
-{
-	int ret =3D -EINVAL;
-
-	for (temp_setup->divr2 =3D 0; temp_setup->divr2 <=3D PLL_DIVR2_MAX;
-	     temp_setup->divr2++) {
-		temp_setup->ref_div2 =3D temp_setup->vco1;
-		do_div(temp_setup->ref_div2, temp_setup->divr2 + 1);
-		if (temp_setup->ref_div2 >=3D PLL_STAGE2_REF_MIN_FREQ &&
-		    temp_setup->ref_div2 <=3D PLL_STAGE2_REF_MAX_FREQ) {
-			ret =3D clk_sccg_divf2_lookup(setup, temp_setup);
-			if (!ret)
-				return ret;
-		}
-	}
-
-	return ret;
-}
-
-static int clk_sccg_pll2_find_setup(struct clk_sccg_pll_setup *setup,
-					struct clk_sccg_pll_setup *temp_setup,
-					uint64_t ref)
-{
-
-	int ret =3D -EINVAL;
-
-	if (ref < PLL_STAGE1_MIN_FREQ || ref > PLL_STAGE1_MAX_FREQ)
-		return ret;
-
-	temp_setup->vco1 =3D ref;
-
-	ret =3D clk_sccg_divr2_lookup(setup, temp_setup);
-	return ret;
-}
-
-static int clk_sccg_divf1_lookup(struct clk_sccg_pll_setup *setup,
-				struct clk_sccg_pll_setup *temp_setup)
-{
-	int ret =3D -EINVAL;
-
-	for (temp_setup->divf1 =3D 0; temp_setup->divf1 <=3D PLL_DIVF1_MAX;
-	     temp_setup->divf1++) {
-		uint64_t vco1 =3D temp_setup->ref;
-
-		do_div(vco1, temp_setup->divr1 + 1);
-		vco1 *=3D 2;
-		vco1 *=3D temp_setup->divf1 + 1;
-
-		ret =3D clk_sccg_pll2_find_setup(setup, temp_setup, vco1);
-		if (!ret) {
-			temp_setup->bypass =3D PLL_BYPASS_NONE;
-			return ret;
-		}
-	}
-
-	return ret;
-}
-
-static int clk_sccg_divr1_lookup(struct clk_sccg_pll_setup *setup,
-				struct clk_sccg_pll_setup *temp_setup)
-{
-	int ret =3D -EINVAL;
-
-	for (temp_setup->divr1 =3D 0; temp_setup->divr1 <=3D PLL_DIVR1_MAX;
-	     temp_setup->divr1++) {
-		temp_setup->ref_div1 =3D temp_setup->ref;
-		do_div(temp_setup->ref_div1, temp_setup->divr1 + 1);
-		if (temp_setup->ref_div1 >=3D PLL_STAGE1_REF_MIN_FREQ &&
-		    temp_setup->ref_div1 <=3D PLL_STAGE1_REF_MAX_FREQ) {
-			ret =3D clk_sccg_divf1_lookup(setup, temp_setup);
-			if (!ret)
-				return ret;
-		}
-	}
-
-	return ret;
-}
-
-static int clk_sccg_pll1_find_setup(struct clk_sccg_pll_setup *setup,
-					struct clk_sccg_pll_setup *temp_setup,
-					uint64_t ref)
-{
-
-	int ret =3D -EINVAL;
-
-	if (ref < PLL_REF_MIN_FREQ || ref > PLL_REF_MAX_FREQ)
-		return ret;
-
-	temp_setup->ref =3D ref;
-
-	ret =3D clk_sccg_divr1_lookup(setup, temp_setup);
-
-	return ret;
-}
-
-static int clk_sccg_pll_find_setup(struct clk_sccg_pll_setup *setup,
-					uint64_t prate,
-					uint64_t rate, int try_bypass)
-{
-	struct clk_sccg_pll_setup temp_setup;
-	int ret =3D -EINVAL;
-
-	memset(&temp_setup, 0, sizeof(struct clk_sccg_pll_setup));
-	memset(setup, 0, sizeof(struct clk_sccg_pll_setup));
-
-	temp_setup.fout_error =3D PLL_OUT_MAX_FREQ;
-	temp_setup.fout_request =3D rate;
-
-	switch (try_bypass) {
-
-	case PLL_BYPASS2:
-		if (prate =3D=3D rate) {
-			setup->bypass =3D PLL_BYPASS2;
-			setup->fout =3D rate;
-			ret =3D 0;
-		}
-		break;
-
-	case PLL_BYPASS1:
-		ret =3D clk_sccg_pll2_find_setup(setup, &temp_setup, prate);
-		break;
-
-	case PLL_BYPASS_NONE:
-		ret =3D clk_sccg_pll1_find_setup(setup, &temp_setup, prate);
-		break;
-	}
-
-	return ret;
-}
-
-
-static int clk_sccg_pll_is_prepared(struct clk_hw *hw)
-{
-	struct clk_sccg_pll *pll =3D to_clk_sccg_pll(hw);
-
-	u32 val =3D readl_relaxed(pll->base + PLL_CFG0);
-
-	return (val & PLL_PD_MASK) ? 0 : 1;
-}
-
-static int clk_sccg_pll_prepare(struct clk_hw *hw)
-{
-	struct clk_sccg_pll *pll =3D to_clk_sccg_pll(hw);
-	u32 val;
-
-	val =3D readl_relaxed(pll->base + PLL_CFG0);
-	val &=3D ~PLL_PD_MASK;
-	writel_relaxed(val, pll->base + PLL_CFG0);
-
-	return clk_sccg_pll_wait_lock(pll);
-}
-
-static void clk_sccg_pll_unprepare(struct clk_hw *hw)
-{
-	struct clk_sccg_pll *pll =3D to_clk_sccg_pll(hw);
-	u32 val;
-
-	val =3D readl_relaxed(pll->base + PLL_CFG0);
-	val |=3D PLL_PD_MASK;
-	writel_relaxed(val, pll->base + PLL_CFG0);
-}
-
-static unsigned long clk_sccg_pll_recalc_rate(struct clk_hw *hw,
-					 unsigned long parent_rate)
-{
-	struct clk_sccg_pll *pll =3D to_clk_sccg_pll(hw);
-	u32 val, divr1, divf1, divr2, divf2, divq;
-	u64 temp64;
-
-	val =3D readl_relaxed(pll->base + PLL_CFG2);
-	divr1 =3D FIELD_GET(PLL_DIVR1_MASK, val);
-	divr2 =3D FIELD_GET(PLL_DIVR2_MASK, val);
-	divf1 =3D FIELD_GET(PLL_DIVF1_MASK, val);
-	divf2 =3D FIELD_GET(PLL_DIVF2_MASK, val);
-	divq =3D FIELD_GET(PLL_DIVQ_MASK, val);
-
-	temp64 =3D parent_rate;
-
-	val =3D readl(pll->base + PLL_CFG0);
-	if (val & SSCG_PLL_BYPASS2_MASK) {
-		temp64 =3D parent_rate;
-	} else if (val & SSCG_PLL_BYPASS1_MASK) {
-		temp64 *=3D divf2;
-		do_div(temp64, (divr2 + 1) * (divq + 1));
-	} else {
-		temp64 *=3D 2;
-		temp64 *=3D (divf1 + 1) * (divf2 + 1);
-		do_div(temp64, (divr1 + 1) * (divr2 + 1) * (divq + 1));
-	}
-
-	return temp64;
-}
-
-static int clk_sccg_pll_set_rate(struct clk_hw *hw, unsigned long rate,
-			    unsigned long parent_rate)
-{
-	struct clk_sccg_pll *pll =3D to_clk_sccg_pll(hw);
-	struct clk_sccg_pll_setup *setup =3D &pll->setup;
-	u32 val;
-
-	/* set bypass here too since the parent might be the same */
-	val =3D readl(pll->base + PLL_CFG0);
-	val &=3D ~SSCG_PLL_BYPASS_MASK;
-	val |=3D FIELD_PREP(SSCG_PLL_BYPASS_MASK, setup->bypass);
-	writel(val, pll->base + PLL_CFG0);
-
-	val =3D readl_relaxed(pll->base + PLL_CFG2);
-	val &=3D ~(PLL_DIVF1_MASK | PLL_DIVF2_MASK);
-	val &=3D ~(PLL_DIVR1_MASK | PLL_DIVR2_MASK | PLL_DIVQ_MASK);
-	val |=3D FIELD_PREP(PLL_DIVF1_MASK, setup->divf1);
-	val |=3D FIELD_PREP(PLL_DIVF2_MASK, setup->divf2);
-	val |=3D FIELD_PREP(PLL_DIVR1_MASK, setup->divr1);
-	val |=3D FIELD_PREP(PLL_DIVR2_MASK, setup->divr2);
-	val |=3D FIELD_PREP(PLL_DIVQ_MASK, setup->divq);
-	writel_relaxed(val, pll->base + PLL_CFG2);
-
-	return clk_sccg_pll_wait_lock(pll);
-}
-
-static u8 clk_sccg_pll_get_parent(struct clk_hw *hw)
-{
-	struct clk_sccg_pll *pll =3D to_clk_sccg_pll(hw);
-	u32 val;
-	u8 ret =3D pll->parent;
-
-	val =3D readl(pll->base + PLL_CFG0);
-	if (val & SSCG_PLL_BYPASS2_MASK)
-		ret =3D pll->bypass2;
-	else if (val & SSCG_PLL_BYPASS1_MASK)
-		ret =3D pll->bypass1;
-	return ret;
-}
-
-static int clk_sccg_pll_set_parent(struct clk_hw *hw, u8 index)
-{
-	struct clk_sccg_pll *pll =3D to_clk_sccg_pll(hw);
-	u32 val;
-
-	val =3D readl(pll->base + PLL_CFG0);
-	val &=3D ~SSCG_PLL_BYPASS_MASK;
-	val |=3D FIELD_PREP(SSCG_PLL_BYPASS_MASK, pll->setup.bypass);
-	writel(val, pll->base + PLL_CFG0);
-
-	return clk_sccg_pll_wait_lock(pll);
-}
-
-static int __clk_sccg_pll_determine_rate(struct clk_hw *hw,
-					struct clk_rate_request *req,
-					uint64_t min,
-					uint64_t max,
-					uint64_t rate,
-					int bypass)
-{
-	struct clk_sccg_pll *pll =3D to_clk_sccg_pll(hw);
-	struct clk_sccg_pll_setup *setup =3D &pll->setup;
-	struct clk_hw *parent_hw =3D NULL;
-	int bypass_parent_index;
-	int ret =3D -EINVAL;
-
-	req->max_rate =3D max;
-	req->min_rate =3D min;
-
-	switch (bypass) {
-	case PLL_BYPASS2:
-		bypass_parent_index =3D pll->bypass2;
-		break;
-	case PLL_BYPASS1:
-		bypass_parent_index =3D pll->bypass1;
-		break;
-	default:
-		bypass_parent_index =3D pll->parent;
-		break;
-	}
-
-	parent_hw =3D clk_hw_get_parent_by_index(hw, bypass_parent_index);
-	ret =3D __clk_determine_rate(parent_hw, req);
-	if (!ret) {
-		ret =3D clk_sccg_pll_find_setup(setup, req->rate,
-						rate, bypass);
-	}
-
-	req->best_parent_hw =3D parent_hw;
-	req->best_parent_rate =3D req->rate;
-	req->rate =3D setup->fout;
-
-	return ret;
-}
-
-static int clk_sccg_pll_determine_rate(struct clk_hw *hw,
-				       struct clk_rate_request *req)
-{
-	struct clk_sccg_pll *pll =3D to_clk_sccg_pll(hw);
-	struct clk_sccg_pll_setup *setup =3D &pll->setup;
-	uint64_t rate =3D req->rate;
-	uint64_t min =3D req->min_rate;
-	uint64_t max =3D req->max_rate;
-	int ret =3D -EINVAL;
-
-	if (rate < PLL_OUT_MIN_FREQ || rate > PLL_OUT_MAX_FREQ)
-		return ret;
-
-	ret =3D __clk_sccg_pll_determine_rate(hw, req, req->rate, req->rate,
-						rate, PLL_BYPASS2);
-	if (!ret)
-		return ret;
-
-	ret =3D __clk_sccg_pll_determine_rate(hw, req, PLL_STAGE1_REF_MIN_FREQ,
-						PLL_STAGE1_REF_MAX_FREQ, rate,
-						PLL_BYPASS1);
-	if (!ret)
-		return ret;
-
-	ret =3D __clk_sccg_pll_determine_rate(hw, req, PLL_REF_MIN_FREQ,
-						PLL_REF_MAX_FREQ, rate,
-						PLL_BYPASS_NONE);
-	if (!ret)
-		return ret;
-
-	if (setup->fout >=3D min && setup->fout <=3D max)
-		ret =3D 0;
-
-	return ret;
-}
-
-static const struct clk_ops clk_sccg_pll_ops =3D {
-	.prepare	=3D clk_sccg_pll_prepare,
-	.unprepare	=3D clk_sccg_pll_unprepare,
-	.is_prepared	=3D clk_sccg_pll_is_prepared,
-	.recalc_rate	=3D clk_sccg_pll_recalc_rate,
-	.set_rate	=3D clk_sccg_pll_set_rate,
-	.set_parent	=3D clk_sccg_pll_set_parent,
-	.get_parent	=3D clk_sccg_pll_get_parent,
-	.determine_rate	=3D clk_sccg_pll_determine_rate,
-};
-
-struct clk *imx_clk_sccg_pll(const char *name,
-				const char * const *parent_names,
-				u8 num_parents,
-				u8 parent, u8 bypass1, u8 bypass2,
-				void __iomem *base,
-				unsigned long flags)
-{
-	struct clk_sccg_pll *pll;
-	struct clk_init_data init;
-	struct clk_hw *hw;
-	int ret;
-
-	pll =3D kzalloc(sizeof(*pll), GFP_KERNEL);
-	if (!pll)
-		return ERR_PTR(-ENOMEM);
-
-	pll->parent =3D parent;
-	pll->bypass1 =3D bypass1;
-	pll->bypass2 =3D bypass2;
-
-	pll->base =3D base;
-	init.name =3D name;
-	init.ops =3D &clk_sccg_pll_ops;
-
-	init.flags =3D flags;
-	init.parent_names =3D parent_names;
-	init.num_parents =3D num_parents;
-
-	pll->base =3D base;
-	pll->hw.init =3D &init;
-
-	hw =3D &pll->hw;
-
-	ret =3D clk_hw_register(NULL, hw);
-	if (ret) {
-		kfree(pll);
-		return ERR_PTR(ret);
-	}
-
-	return hw->clk;
-}
diff --git a/drivers/clk/imx/clk-sscg-pll.c b/drivers/clk/imx/clk-sscg-pll.=
c
new file mode 100644
index 00000000..0669e17
--- /dev/null
+++ b/drivers/clk/imx/clk-sscg-pll.c
@@ -0,0 +1,549 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright 2018 NXP.
+ *
+ * This driver supports the SCCG plls found in the imx8m SOCs
+ *
+ * Documentation for this SCCG pll can be found at:
+ *   https://www.nxp.com/docs/en/reference-manual/IMX8MDQLQRM.pdf#page=3D8=
34
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/slab.h>
+#include <linux/bitfield.h>
+
+#include "clk.h"
+
+/* PLL CFGs */
+#define PLL_CFG0		0x0
+#define PLL_CFG1		0x4
+#define PLL_CFG2		0x8
+
+#define PLL_DIVF1_MASK		GENMASK(18, 13)
+#define PLL_DIVF2_MASK		GENMASK(12, 7)
+#define PLL_DIVR1_MASK		GENMASK(27, 25)
+#define PLL_DIVR2_MASK		GENMASK(24, 19)
+#define PLL_DIVQ_MASK           GENMASK(6, 1)
+#define PLL_REF_MASK		GENMASK(2, 0)
+
+#define PLL_LOCK_MASK		BIT(31)
+#define PLL_PD_MASK		BIT(7)
+
+/* These are the specification limits for the SSCG PLL */
+#define PLL_REF_MIN_FREQ		25000000UL
+#define PLL_REF_MAX_FREQ		235000000UL
+
+#define PLL_STAGE1_MIN_FREQ		1600000000UL
+#define PLL_STAGE1_MAX_FREQ		2400000000UL
+
+#define PLL_STAGE1_REF_MIN_FREQ		25000000UL
+#define PLL_STAGE1_REF_MAX_FREQ		54000000UL
+
+#define PLL_STAGE2_MIN_FREQ		1200000000UL
+#define PLL_STAGE2_MAX_FREQ		2400000000UL
+
+#define PLL_STAGE2_REF_MIN_FREQ		54000000UL
+#define PLL_STAGE2_REF_MAX_FREQ		75000000UL
+
+#define PLL_OUT_MIN_FREQ		20000000UL
+#define PLL_OUT_MAX_FREQ		1200000000UL
+
+#define PLL_DIVR1_MAX			7
+#define PLL_DIVR2_MAX			63
+#define PLL_DIVF1_MAX			63
+#define PLL_DIVF2_MAX			63
+#define PLL_DIVQ_MAX			63
+
+#define PLL_BYPASS_NONE			0x0
+#define PLL_BYPASS1			0x2
+#define PLL_BYPASS2			0x1
+
+#define SSCG_PLL_BYPASS1_MASK           BIT(5)
+#define SSCG_PLL_BYPASS2_MASK           BIT(4)
+#define SSCG_PLL_BYPASS_MASK		GENMASK(5, 4)
+
+#define PLL_SCCG_LOCK_TIMEOUT		70
+
+struct clk_sscg_pll_setup {
+	int divr1, divf1;
+	int divr2, divf2;
+	int divq;
+	int bypass;
+
+	uint64_t vco1;
+	uint64_t vco2;
+	uint64_t fout;
+	uint64_t ref;
+	uint64_t ref_div1;
+	uint64_t ref_div2;
+	uint64_t fout_request;
+	int fout_error;
+};
+
+struct clk_sscg_pll {
+	struct clk_hw	hw;
+	const struct clk_ops  ops;
+
+	void __iomem *base;
+
+	struct clk_sscg_pll_setup setup;
+
+	u8 parent;
+	u8 bypass1;
+	u8 bypass2;
+};
+
+#define to_clk_sscg_pll(_hw) container_of(_hw, struct clk_sscg_pll, hw)
+
+static int clk_sscg_pll_wait_lock(struct clk_sscg_pll *pll)
+{
+	u32 val;
+
+	val =3D readl_relaxed(pll->base + PLL_CFG0);
+
+	/* don't wait for lock if all plls are bypassed */
+	if (!(val & SSCG_PLL_BYPASS2_MASK))
+		return readl_poll_timeout(pll->base, val, val & PLL_LOCK_MASK,
+						0, PLL_SCCG_LOCK_TIMEOUT);
+
+	return 0;
+}
+
+static int clk_sscg_pll2_check_match(struct clk_sscg_pll_setup *setup,
+					struct clk_sscg_pll_setup *temp_setup)
+{
+	int new_diff =3D temp_setup->fout - temp_setup->fout_request;
+	int diff =3D temp_setup->fout_error;
+
+	if (abs(diff) > abs(new_diff)) {
+		temp_setup->fout_error =3D new_diff;
+		memcpy(setup, temp_setup, sizeof(struct clk_sscg_pll_setup));
+
+		if (temp_setup->fout_request =3D=3D temp_setup->fout)
+			return 0;
+	}
+	return -1;
+}
+
+static int clk_sscg_divq_lookup(struct clk_sscg_pll_setup *setup,
+				struct clk_sscg_pll_setup *temp_setup)
+{
+	int ret =3D -EINVAL;
+
+	for (temp_setup->divq =3D 0; temp_setup->divq <=3D PLL_DIVQ_MAX;
+	     temp_setup->divq++) {
+		temp_setup->vco2 =3D temp_setup->vco1;
+		do_div(temp_setup->vco2, temp_setup->divr2 + 1);
+		temp_setup->vco2 *=3D 2;
+		temp_setup->vco2 *=3D temp_setup->divf2 + 1;
+		if (temp_setup->vco2 >=3D PLL_STAGE2_MIN_FREQ &&
+				temp_setup->vco2 <=3D PLL_STAGE2_MAX_FREQ) {
+			temp_setup->fout =3D temp_setup->vco2;
+			do_div(temp_setup->fout, 2 * (temp_setup->divq + 1));
+
+			ret =3D clk_sscg_pll2_check_match(setup, temp_setup);
+			if (!ret) {
+				temp_setup->bypass =3D PLL_BYPASS1;
+				return ret;
+			}
+		}
+	}
+
+	return ret;
+}
+
+static int clk_sscg_divf2_lookup(struct clk_sscg_pll_setup *setup,
+					struct clk_sscg_pll_setup *temp_setup)
+{
+	int ret =3D -EINVAL;
+
+	for (temp_setup->divf2 =3D 0; temp_setup->divf2 <=3D PLL_DIVF2_MAX;
+	     temp_setup->divf2++) {
+		ret =3D clk_sscg_divq_lookup(setup, temp_setup);
+		if (!ret)
+			return ret;
+	}
+
+	return ret;
+}
+
+static int clk_sscg_divr2_lookup(struct clk_sscg_pll_setup *setup,
+				struct clk_sscg_pll_setup *temp_setup)
+{
+	int ret =3D -EINVAL;
+
+	for (temp_setup->divr2 =3D 0; temp_setup->divr2 <=3D PLL_DIVR2_MAX;
+	     temp_setup->divr2++) {
+		temp_setup->ref_div2 =3D temp_setup->vco1;
+		do_div(temp_setup->ref_div2, temp_setup->divr2 + 1);
+		if (temp_setup->ref_div2 >=3D PLL_STAGE2_REF_MIN_FREQ &&
+		    temp_setup->ref_div2 <=3D PLL_STAGE2_REF_MAX_FREQ) {
+			ret =3D clk_sscg_divf2_lookup(setup, temp_setup);
+			if (!ret)
+				return ret;
+		}
+	}
+
+	return ret;
+}
+
+static int clk_sscg_pll2_find_setup(struct clk_sscg_pll_setup *setup,
+					struct clk_sscg_pll_setup *temp_setup,
+					uint64_t ref)
+{
+
+	int ret =3D -EINVAL;
+
+	if (ref < PLL_STAGE1_MIN_FREQ || ref > PLL_STAGE1_MAX_FREQ)
+		return ret;
+
+	temp_setup->vco1 =3D ref;
+
+	ret =3D clk_sscg_divr2_lookup(setup, temp_setup);
+	return ret;
+}
+
+static int clk_sscg_divf1_lookup(struct clk_sscg_pll_setup *setup,
+				struct clk_sscg_pll_setup *temp_setup)
+{
+	int ret =3D -EINVAL;
+
+	for (temp_setup->divf1 =3D 0; temp_setup->divf1 <=3D PLL_DIVF1_MAX;
+	     temp_setup->divf1++) {
+		uint64_t vco1 =3D temp_setup->ref;
+
+		do_div(vco1, temp_setup->divr1 + 1);
+		vco1 *=3D 2;
+		vco1 *=3D temp_setup->divf1 + 1;
+
+		ret =3D clk_sscg_pll2_find_setup(setup, temp_setup, vco1);
+		if (!ret) {
+			temp_setup->bypass =3D PLL_BYPASS_NONE;
+			return ret;
+		}
+	}
+
+	return ret;
+}
+
+static int clk_sscg_divr1_lookup(struct clk_sscg_pll_setup *setup,
+				struct clk_sscg_pll_setup *temp_setup)
+{
+	int ret =3D -EINVAL;
+
+	for (temp_setup->divr1 =3D 0; temp_setup->divr1 <=3D PLL_DIVR1_MAX;
+	     temp_setup->divr1++) {
+		temp_setup->ref_div1 =3D temp_setup->ref;
+		do_div(temp_setup->ref_div1, temp_setup->divr1 + 1);
+		if (temp_setup->ref_div1 >=3D PLL_STAGE1_REF_MIN_FREQ &&
+		    temp_setup->ref_div1 <=3D PLL_STAGE1_REF_MAX_FREQ) {
+			ret =3D clk_sscg_divf1_lookup(setup, temp_setup);
+			if (!ret)
+				return ret;
+		}
+	}
+
+	return ret;
+}
+
+static int clk_sscg_pll1_find_setup(struct clk_sscg_pll_setup *setup,
+					struct clk_sscg_pll_setup *temp_setup,
+					uint64_t ref)
+{
+
+	int ret =3D -EINVAL;
+
+	if (ref < PLL_REF_MIN_FREQ || ref > PLL_REF_MAX_FREQ)
+		return ret;
+
+	temp_setup->ref =3D ref;
+
+	ret =3D clk_sscg_divr1_lookup(setup, temp_setup);
+
+	return ret;
+}
+
+static int clk_sscg_pll_find_setup(struct clk_sscg_pll_setup *setup,
+					uint64_t prate,
+					uint64_t rate, int try_bypass)
+{
+	struct clk_sscg_pll_setup temp_setup;
+	int ret =3D -EINVAL;
+
+	memset(&temp_setup, 0, sizeof(struct clk_sscg_pll_setup));
+	memset(setup, 0, sizeof(struct clk_sscg_pll_setup));
+
+	temp_setup.fout_error =3D PLL_OUT_MAX_FREQ;
+	temp_setup.fout_request =3D rate;
+
+	switch (try_bypass) {
+
+	case PLL_BYPASS2:
+		if (prate =3D=3D rate) {
+			setup->bypass =3D PLL_BYPASS2;
+			setup->fout =3D rate;
+			ret =3D 0;
+		}
+		break;
+
+	case PLL_BYPASS1:
+		ret =3D clk_sscg_pll2_find_setup(setup, &temp_setup, prate);
+		break;
+
+	case PLL_BYPASS_NONE:
+		ret =3D clk_sscg_pll1_find_setup(setup, &temp_setup, prate);
+		break;
+	}
+
+	return ret;
+}
+
+
+static int clk_sscg_pll_is_prepared(struct clk_hw *hw)
+{
+	struct clk_sscg_pll *pll =3D to_clk_sscg_pll(hw);
+
+	u32 val =3D readl_relaxed(pll->base + PLL_CFG0);
+
+	return (val & PLL_PD_MASK) ? 0 : 1;
+}
+
+static int clk_sscg_pll_prepare(struct clk_hw *hw)
+{
+	struct clk_sscg_pll *pll =3D to_clk_sscg_pll(hw);
+	u32 val;
+
+	val =3D readl_relaxed(pll->base + PLL_CFG0);
+	val &=3D ~PLL_PD_MASK;
+	writel_relaxed(val, pll->base + PLL_CFG0);
+
+	return clk_sscg_pll_wait_lock(pll);
+}
+
+static void clk_sscg_pll_unprepare(struct clk_hw *hw)
+{
+	struct clk_sscg_pll *pll =3D to_clk_sscg_pll(hw);
+	u32 val;
+
+	val =3D readl_relaxed(pll->base + PLL_CFG0);
+	val |=3D PLL_PD_MASK;
+	writel_relaxed(val, pll->base + PLL_CFG0);
+}
+
+static unsigned long clk_sscg_pll_recalc_rate(struct clk_hw *hw,
+					 unsigned long parent_rate)
+{
+	struct clk_sscg_pll *pll =3D to_clk_sscg_pll(hw);
+	u32 val, divr1, divf1, divr2, divf2, divq;
+	u64 temp64;
+
+	val =3D readl_relaxed(pll->base + PLL_CFG2);
+	divr1 =3D FIELD_GET(PLL_DIVR1_MASK, val);
+	divr2 =3D FIELD_GET(PLL_DIVR2_MASK, val);
+	divf1 =3D FIELD_GET(PLL_DIVF1_MASK, val);
+	divf2 =3D FIELD_GET(PLL_DIVF2_MASK, val);
+	divq =3D FIELD_GET(PLL_DIVQ_MASK, val);
+
+	temp64 =3D parent_rate;
+
+	val =3D readl(pll->base + PLL_CFG0);
+	if (val & SSCG_PLL_BYPASS2_MASK) {
+		temp64 =3D parent_rate;
+	} else if (val & SSCG_PLL_BYPASS1_MASK) {
+		temp64 *=3D divf2;
+		do_div(temp64, (divr2 + 1) * (divq + 1));
+	} else {
+		temp64 *=3D 2;
+		temp64 *=3D (divf1 + 1) * (divf2 + 1);
+		do_div(temp64, (divr1 + 1) * (divr2 + 1) * (divq + 1));
+	}
+
+	return temp64;
+}
+
+static int clk_sscg_pll_set_rate(struct clk_hw *hw, unsigned long rate,
+			    unsigned long parent_rate)
+{
+	struct clk_sscg_pll *pll =3D to_clk_sscg_pll(hw);
+	struct clk_sscg_pll_setup *setup =3D &pll->setup;
+	u32 val;
+
+	/* set bypass here too since the parent might be the same */
+	val =3D readl(pll->base + PLL_CFG0);
+	val &=3D ~SSCG_PLL_BYPASS_MASK;
+	val |=3D FIELD_PREP(SSCG_PLL_BYPASS_MASK, setup->bypass);
+	writel(val, pll->base + PLL_CFG0);
+
+	val =3D readl_relaxed(pll->base + PLL_CFG2);
+	val &=3D ~(PLL_DIVF1_MASK | PLL_DIVF2_MASK);
+	val &=3D ~(PLL_DIVR1_MASK | PLL_DIVR2_MASK | PLL_DIVQ_MASK);
+	val |=3D FIELD_PREP(PLL_DIVF1_MASK, setup->divf1);
+	val |=3D FIELD_PREP(PLL_DIVF2_MASK, setup->divf2);
+	val |=3D FIELD_PREP(PLL_DIVR1_MASK, setup->divr1);
+	val |=3D FIELD_PREP(PLL_DIVR2_MASK, setup->divr2);
+	val |=3D FIELD_PREP(PLL_DIVQ_MASK, setup->divq);
+	writel_relaxed(val, pll->base + PLL_CFG2);
+
+	return clk_sscg_pll_wait_lock(pll);
+}
+
+static u8 clk_sscg_pll_get_parent(struct clk_hw *hw)
+{
+	struct clk_sscg_pll *pll =3D to_clk_sscg_pll(hw);
+	u32 val;
+	u8 ret =3D pll->parent;
+
+	val =3D readl(pll->base + PLL_CFG0);
+	if (val & SSCG_PLL_BYPASS2_MASK)
+		ret =3D pll->bypass2;
+	else if (val & SSCG_PLL_BYPASS1_MASK)
+		ret =3D pll->bypass1;
+	return ret;
+}
+
+static int clk_sscg_pll_set_parent(struct clk_hw *hw, u8 index)
+{
+	struct clk_sscg_pll *pll =3D to_clk_sscg_pll(hw);
+	u32 val;
+
+	val =3D readl(pll->base + PLL_CFG0);
+	val &=3D ~SSCG_PLL_BYPASS_MASK;
+	val |=3D FIELD_PREP(SSCG_PLL_BYPASS_MASK, pll->setup.bypass);
+	writel(val, pll->base + PLL_CFG0);
+
+	return clk_sscg_pll_wait_lock(pll);
+}
+
+static int __clk_sscg_pll_determine_rate(struct clk_hw *hw,
+					struct clk_rate_request *req,
+					uint64_t min,
+					uint64_t max,
+					uint64_t rate,
+					int bypass)
+{
+	struct clk_sscg_pll *pll =3D to_clk_sscg_pll(hw);
+	struct clk_sscg_pll_setup *setup =3D &pll->setup;
+	struct clk_hw *parent_hw =3D NULL;
+	int bypass_parent_index;
+	int ret =3D -EINVAL;
+
+	req->max_rate =3D max;
+	req->min_rate =3D min;
+
+	switch (bypass) {
+	case PLL_BYPASS2:
+		bypass_parent_index =3D pll->bypass2;
+		break;
+	case PLL_BYPASS1:
+		bypass_parent_index =3D pll->bypass1;
+		break;
+	default:
+		bypass_parent_index =3D pll->parent;
+		break;
+	}
+
+	parent_hw =3D clk_hw_get_parent_by_index(hw, bypass_parent_index);
+	ret =3D __clk_determine_rate(parent_hw, req);
+	if (!ret) {
+		ret =3D clk_sscg_pll_find_setup(setup, req->rate,
+						rate, bypass);
+	}
+
+	req->best_parent_hw =3D parent_hw;
+	req->best_parent_rate =3D req->rate;
+	req->rate =3D setup->fout;
+
+	return ret;
+}
+
+static int clk_sscg_pll_determine_rate(struct clk_hw *hw,
+				       struct clk_rate_request *req)
+{
+	struct clk_sscg_pll *pll =3D to_clk_sscg_pll(hw);
+	struct clk_sscg_pll_setup *setup =3D &pll->setup;
+	uint64_t rate =3D req->rate;
+	uint64_t min =3D req->min_rate;
+	uint64_t max =3D req->max_rate;
+	int ret =3D -EINVAL;
+
+	if (rate < PLL_OUT_MIN_FREQ || rate > PLL_OUT_MAX_FREQ)
+		return ret;
+
+	ret =3D __clk_sscg_pll_determine_rate(hw, req, req->rate, req->rate,
+						rate, PLL_BYPASS2);
+	if (!ret)
+		return ret;
+
+	ret =3D __clk_sscg_pll_determine_rate(hw, req, PLL_STAGE1_REF_MIN_FREQ,
+						PLL_STAGE1_REF_MAX_FREQ, rate,
+						PLL_BYPASS1);
+	if (!ret)
+		return ret;
+
+	ret =3D __clk_sscg_pll_determine_rate(hw, req, PLL_REF_MIN_FREQ,
+						PLL_REF_MAX_FREQ, rate,
+						PLL_BYPASS_NONE);
+	if (!ret)
+		return ret;
+
+	if (setup->fout >=3D min && setup->fout <=3D max)
+		ret =3D 0;
+
+	return ret;
+}
+
+static const struct clk_ops clk_sscg_pll_ops =3D {
+	.prepare	=3D clk_sscg_pll_prepare,
+	.unprepare	=3D clk_sscg_pll_unprepare,
+	.is_prepared	=3D clk_sscg_pll_is_prepared,
+	.recalc_rate	=3D clk_sscg_pll_recalc_rate,
+	.set_rate	=3D clk_sscg_pll_set_rate,
+	.set_parent	=3D clk_sscg_pll_set_parent,
+	.get_parent	=3D clk_sscg_pll_get_parent,
+	.determine_rate	=3D clk_sscg_pll_determine_rate,
+};
+
+struct clk *imx_clk_sscg_pll(const char *name,
+				const char * const *parent_names,
+				u8 num_parents,
+				u8 parent, u8 bypass1, u8 bypass2,
+				void __iomem *base,
+				unsigned long flags)
+{
+	struct clk_sscg_pll *pll;
+	struct clk_init_data init;
+	struct clk_hw *hw;
+	int ret;
+
+	pll =3D kzalloc(sizeof(*pll), GFP_KERNEL);
+	if (!pll)
+		return ERR_PTR(-ENOMEM);
+
+	pll->parent =3D parent;
+	pll->bypass1 =3D bypass1;
+	pll->bypass2 =3D bypass2;
+
+	pll->base =3D base;
+	init.name =3D name;
+	init.ops =3D &clk_sscg_pll_ops;
+
+	init.flags =3D flags;
+	init.parent_names =3D parent_names;
+	init.num_parents =3D num_parents;
+
+	pll->base =3D base;
+	pll->hw.init =3D &init;
+
+	hw =3D &pll->hw;
+
+	ret =3D clk_hw_register(NULL, hw);
+	if (ret) {
+		kfree(pll);
+		return ERR_PTR(ret);
+	}
+
+	return hw->clk;
+}
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 30ddbc1..9330632 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -24,7 +24,7 @@ enum imx_pllv1_type {
 	IMX_PLLV1_IMX35,
 };
=20
-enum imx_sccg_pll_type {
+enum imx_sscg_pll_type {
 	SCCG_PLL1,
 	SCCG_PLL2,
 };
@@ -109,7 +109,7 @@ struct clk *imx_clk_pllv2(const char *name, const char =
*parent,
 struct clk *imx_clk_frac_pll(const char *name, const char *parent_name,
 			     void __iomem *base);
=20
-struct clk *imx_clk_sccg_pll(const char *name,
+struct clk *imx_clk_sscg_pll(const char *name,
 				const char * const *parent_names,
 				u8 num_parents,
 				u8 parent, u8 bypass1, u8 bypass2,
--=20
2.7.4

