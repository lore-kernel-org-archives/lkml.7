Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4117CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ADCF21925
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:37:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZAozdHqq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbfCVPhT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 11:37:19 -0400
Received: from mail-eopbgr00067.outbound.protection.outlook.com ([40.107.0.67]:50409
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727587AbfCVPhQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 11:37:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0gt25DGys7wBvDYnJLFcHnOFReknIG0EAQSCJ87qNFc=;
 b=ZAozdHqqEc5PojNyp61Tp3qK9UmYI+T/uI1TQEtsOH0QQLxCIJ7sdoeOB3Cgmd1qULh9IojaBN59tvBlhI5W7yTagPoLlMdyHh9qiq1rlLzYv34x5jZwiQnoThvCCqWSPol3qemhXTggiP/nj5Edr6ivXU3QaNFwch8G5pksbTU=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB4802.eurprd04.prod.outlook.com (20.176.215.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.16; Fri, 22 Mar 2019 15:37:12 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::9579:32ab:898e:6769]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::9579:32ab:898e:6769%2]) with mapi id 15.20.1709.017; Fri, 22 Mar 2019
 15:37:12 +0000
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
Subject: [RFC 12/19] clk: imx: clk-fixup-mux: Switch to clk_hw based API
Thread-Topic: [RFC 12/19] clk: imx: clk-fixup-mux: Switch to clk_hw based API
Thread-Index: AQHU4MUeufVGGzhrCU2hP8THMQ1eQA==
Date:   Fri, 22 Mar 2019 15:37:12 +0000
Message-ID: <1553269010-15591-13-git-send-email-abel.vesa@nxp.com>
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
x-ms-office365-filtering-correlation-id: 5d85e81f-22b0-4788-58c4-08d6aedc4086
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4802;
x-ms-traffictypediagnostic: AM0PR04MB4802:
x-microsoft-antispam-prvs: <AM0PR04MB4802761D4054B153DE800626F6430@AM0PR04MB4802.eurprd04.prod.outlook.com>
x-forefront-prvs: 09840A4839
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(346002)(376002)(39860400002)(366004)(189003)(199004)(446003)(71190400001)(99286004)(25786009)(8676002)(478600001)(71200400001)(256004)(66066001)(305945005)(7736002)(4326008)(14454004)(68736007)(81166006)(5660300002)(8936002)(97736004)(53936002)(81156014)(50226002)(6512007)(36756003)(26005)(186003)(105586002)(102836004)(6436002)(3846002)(76176011)(52116002)(106356001)(6486002)(6116002)(386003)(486006)(44832011)(86362001)(476003)(2616005)(11346002)(54906003)(2906002)(6506007)(110136005)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4802;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vN8WpXg3n7iINOQO5E+9YwLbwhkHIgvZjcGSk68ldgpTqj8pK3rAeKRKdPXedzfFKHe5k8pCyiy0cvkCorF1fw1Q8VZS5XvB+3uK9zQL34YPhfjrWB4mLqWn3w46TSXqRLxwM4BYNgFhsz2QqbzlPldRjBNXDlPLKX872pP10iPkBFpTkRrPPOZkbE5JdTMeXVM+3MDXGSg6xxfxxaExeqbPB6OMZHRrE99d2se/4a+rThFGeYz8HCvPhGzNeLTvsEnB+qP72Nsbo3VFSBp8Coor+ga953EnJGbg1DvC55iH1wKS4cmGkfp2lmqxoeUEb9JiUDCLKpYFsx7Sf/Et5KLEVwteSP3X9lg4Fvc8KIQu8TYICtjrnVS0bGyAIe9T0DgtQyIaOJqDBulyiPM5dfHu0ATVyySL2fZCpwIovvI=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d85e81f-22b0-4788-58c4-08d6aedc4086
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2019 15:37:12.0920
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4802
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch the imx_clk_fixup_mux function to clk_hw based API,
rename accordingly and add a macro for clk based legacy.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/clk/imx/clk-fixup-mux.c | 15 ++++++++++-----
 drivers/clk/imx/clk.h           |  3 +++
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/imx/clk-fixup-mux.c b/drivers/clk/imx/clk-fixup-mu=
x.c
index 44817c1..f3c4ec2 100644
--- a/drivers/clk/imx/clk-fixup-mux.c
+++ b/drivers/clk/imx/clk-fixup-mux.c
@@ -69,13 +69,14 @@ static const struct clk_ops clk_fixup_mux_ops =3D {
 	.set_parent =3D clk_fixup_mux_set_parent,
 };
=20
-struct clk *imx_clk_fixup_mux(const char *name, void __iomem *reg,
+struct clk_hw *imx_clk_hw_fixup_mux(const char *name, void __iomem *reg,
 			      u8 shift, u8 width, const char * const *parents,
 			      int num_parents, void (*fixup)(u32 *val))
 {
 	struct clk_fixup_mux *fixup_mux;
-	struct clk *clk;
+	struct clk_hw *hw;
 	struct clk_init_data init;
+	int ret;
=20
 	if (!fixup)
 		return ERR_PTR(-EINVAL);
@@ -98,9 +99,13 @@ struct clk *imx_clk_fixup_mux(const char *name, void __i=
omem *reg,
 	fixup_mux->ops =3D &clk_mux_ops;
 	fixup_mux->fixup =3D fixup;
=20
-	clk =3D clk_register(NULL, &fixup_mux->mux.hw);
-	if (IS_ERR(clk))
+	hw =3D &fixup_mux->mux.hw;
+
+	ret =3D clk_hw_register(NULL, hw);
+	if (ret) {
 		kfree(fixup_mux);
+		return ERR_PTR(ret);
+	}
=20
-	return clk;
+	return hw;
 }
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 3b1f687..a8da9dc 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -75,6 +75,9 @@ struct imx_pll14xx_clk {
 #define imx_clk_fixup_divider(name, parent, reg, shift, width, fixup) \
 	imx_clk_hw_fixup_divider(name, parent, reg, shift, width, fixup)->clk
=20
+#define imx_clk_fixup_mux(name, reg, shift, width, parents, num_parents, f=
ixup) \
+	imx_clk_hw_fixup_mux(name, reg, shift, width, parents, num_parents, fixup=
)->clk
+
 struct clk *imx_clk_pll14xx(const char *name, const char *parent_name,
 		 void __iomem *base, const struct imx_pll14xx_clk *pll_clk);
=20
--=20
2.7.4

