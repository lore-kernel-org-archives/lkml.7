Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C9AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:38:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4412218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:38:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="szphEHBa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbfCVPin (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 11:38:43 -0400
Received: from mail-eopbgr60072.outbound.protection.outlook.com ([40.107.6.72]:41091
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726022AbfCVPhL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 11:37:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MSx/Y6F0AgWZF84jic2oulMzN9dre7gLsY4aJ6LL4JI=;
 b=szphEHBaz2+i+Di/QMa/595Tw6h7OTQxCytSMLYuUIe3xf3GbaPVHOhSsdyUmMjsXkJ6+DWUGDdUi4PImQYEl13G18p3vVE1okRyE+dyc5DzsyX0ousN1xKwo5R+9i0fIzefckWPVz9wNgNWpi6kJtPeP98R68ChmS++6uNvf6s=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB5636.eurprd04.prod.outlook.com (20.178.202.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.15; Fri, 22 Mar 2019 15:37:03 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::9579:32ab:898e:6769]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::9579:32ab:898e:6769%2]) with mapi id 15.20.1709.017; Fri, 22 Mar 2019
 15:37:03 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>
CC:     "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: [RFC 03/19] clk: imx6sx: Do not reparent to unregistered
 IMX6SX_CLK_AXI
Thread-Topic: [RFC 03/19] clk: imx6sx: Do not reparent to unregistered
 IMX6SX_CLK_AXI
Thread-Index: AQHU4MUYtbPO5pw8/UqQLW6Tt6IGKQ==
Date:   Fri, 22 Mar 2019 15:37:03 +0000
Message-ID: <1553269010-15591-4-git-send-email-abel.vesa@nxp.com>
References: <1553269010-15591-1-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1553269010-15591-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR08CA0170.eurprd08.prod.outlook.com
 (2603:10a6:800:d1::24) To AM0PR04MB5779.eurprd04.prod.outlook.com
 (2603:10a6:208:131::23)
x-originating-ip: [212.146.100.6]
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eb5262e9-de93-4fcc-865b-08d6aedc3b2c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5636;
x-ms-traffictypediagnostic: AM0PR04MB5636:
x-microsoft-antispam-prvs: <AM0PR04MB5636AEA3C289435BC696B777F6430@AM0PR04MB5636.eurprd04.prod.outlook.com>
x-forefront-prvs: 09840A4839
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(39860400002)(376002)(396003)(136003)(199004)(189003)(106356001)(105586002)(54906003)(110136005)(316002)(52116002)(6512007)(81156014)(97736004)(53936002)(86362001)(81166006)(478600001)(8676002)(2906002)(14454004)(486006)(99286004)(36756003)(7736002)(71200400001)(44832011)(71190400001)(3846002)(5660300002)(4744005)(386003)(4326008)(6116002)(6486002)(50226002)(6506007)(66066001)(256004)(76176011)(446003)(186003)(25786009)(11346002)(68736007)(26005)(476003)(6436002)(2616005)(8936002)(102836004)(305945005)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5636;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4wK3uu33YOkFcYLo9OTV4ycEWHDOQ6QtIC0wKFv1/KT2scGxOCOsg6R0qo2uDWN0lm1SoNQpwlWQaEC7cxxRIeXC3TJAthuEi9mFL+OxGQW2Wv+rIGkZ0bVLqq0+pJDwFlJKgQNrUZ5KdBzuxCUU4AttM4kOVAxBBD8UyAySbxCIZU7XSEjVfoHgx7B7sm3oi1mfuxHPCxh1ufc9DLxuG5B8QPraV8/40a1XMan0geayTaQl3nVI7zW6zgGgRkySTI3y3TxM3JhIKI/4ErsI0an09VdyItLjtwVfILBo/tbgXCEa7/PGHeYV+yx2Ei/QP+eUlM+qCbYB+6O++2Xfd2R0ONzf/P8RWUOMDtPUL3zdq9uJ13JrYxiWm+3/f5h2qM6bpbZWVNtfT5dpmwmvE4S7bfLT1PcnwzbyKxyUmYU=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb5262e9-de93-4fcc-865b-08d6aedc3b2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2019 15:37:03.0357
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5636
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clock IMX6SX_CLK_AXI is not registered at all.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/clk/imx/clk-imx6sx.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/clk/imx/clk-imx6sx.c b/drivers/clk/imx/clk-imx6sx.c
index 91558b0..4ed180c 100644
--- a/drivers/clk/imx/clk-imx6sx.c
+++ b/drivers/clk/imx/clk-imx6sx.c
@@ -512,8 +512,6 @@ static void __init imx6sx_clocks_init(struct device_nod=
e *ccm_node)
 	/* Set the parent clks of PCIe lvds1 and pcie_axi to be pcie ref, axi */
 	if (clk_set_parent(clks[IMX6SX_CLK_LVDS1_SEL], clks[IMX6SX_CLK_PCIE_REF_1=
25M]))
 		pr_err("Failed to set pcie bus parent clk.\n");
-	if (clk_set_parent(clks[IMX6SX_CLK_PCIE_AXI_SEL], clks[IMX6SX_CLK_AXI]))
-		pr_err("Failed to set pcie parent clk.\n");
=20
 	/*
 	 * Init enet system AHB clock, set to 200MHz
--=20
2.7.4

