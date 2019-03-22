Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5532C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69349218FE
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:37:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="G02nlldp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbfCVPhi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 11:37:38 -0400
Received: from mail-eopbgr50074.outbound.protection.outlook.com ([40.107.5.74]:56385
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727673AbfCVPhS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 11:37:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+S+KkOU7H01y9+3dafC3otnsuPw51zaWwKv+HXHsmjU=;
 b=G02nlldpv2/ouMyR2/VZnMIXfz+ula9dCMEvbzXNWX009gPkRruI2O53gXE21o3kMkU6lydNQupfxOg+YklSZz727LJFXQTHOhuHHV0KSmxdIX02VPrYVQkej2ESOeezuvDgNc0s+tUFv+LPxvEQO9qNwMdQG1zR03Xwp4jmpoQ=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB5636.eurprd04.prod.outlook.com (20.178.202.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.15; Fri, 22 Mar 2019 15:37:09 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::9579:32ab:898e:6769]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::9579:32ab:898e:6769%2]) with mapi id 15.20.1709.017; Fri, 22 Mar 2019
 15:37:09 +0000
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
Subject: [RFC 09/19] clk: imx: clk-pfd: Switch to clk_hw based API
Thread-Topic: [RFC 09/19] clk: imx: clk-pfd: Switch to clk_hw based API
Thread-Index: AQHU4MUcTsXUlHc8K0q5E41wNrRU+g==
Date:   Fri, 22 Mar 2019 15:37:09 +0000
Message-ID: <1553269010-15591-10-git-send-email-abel.vesa@nxp.com>
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
x-ms-office365-filtering-correlation-id: 282fc0ba-bd18-4873-e8f9-08d6aedc3ee0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5636;
x-ms-traffictypediagnostic: AM0PR04MB5636:
x-microsoft-antispam-prvs: <AM0PR04MB5636FF557BDE8E73D54CCC96F6430@AM0PR04MB5636.eurprd04.prod.outlook.com>
x-forefront-prvs: 09840A4839
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(39860400002)(376002)(396003)(136003)(199004)(189003)(106356001)(105586002)(54906003)(110136005)(316002)(52116002)(6512007)(81156014)(97736004)(53936002)(86362001)(81166006)(478600001)(8676002)(2906002)(14454004)(486006)(99286004)(36756003)(7736002)(71200400001)(44832011)(71190400001)(3846002)(5660300002)(386003)(4326008)(6116002)(6486002)(50226002)(6506007)(66066001)(256004)(76176011)(446003)(186003)(25786009)(11346002)(68736007)(26005)(476003)(6436002)(2616005)(8936002)(102836004)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5636;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 262y5nLEF/a+ht0f3NQgYZjzuYa9t8d23X/OQkvpTwco3FJ3g/fV2s+rs++gj2+0bpsvq+rWk56msiKRQmNx7swWDV1TWXpk6V3QDMgCiMTZi7ANpyKXzmxW0u9pFgkrEjC4LkrkqRM04KxSUvHe5o83be4g6uOn3vqeFA/VYt/Qn57iBXASDgaERQLthWbovhepL9cI95MpZjsaK2t8YNjEmhUh7ledfChgCsKP3D0Gpw8HixaeojSOHczdpVN+ar5kzlU3Plyvc8vR5GclH1mBMn3WuQkjdIv/NlxQzb4rnzfs1QNFBFwYnQnL/RYO+Pin3mY43/fwiUubAC+TDWjxZJW/TG9ggqZCWQ6hOrbYEhMLRJ7OwyMTP4RnTqP1pYj09tqlKnYv2HUFNmmDY579MV0ojmJ7Iws+5xKyZLw=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 282fc0ba-bd18-4873-e8f9-08d6aedc3ee0
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2019 15:37:09.2580
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5636
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch the imx_clk_pfd function to clk_hw based API,
rename accordingly and add a macro for clk based legacy.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/clk/imx/clk-pfd.c | 14 +++++++++-----
 drivers/clk/imx/clk.h     |  5 ++++-
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/imx/clk-pfd.c b/drivers/clk/imx/clk-pfd.c
index 04a3e78..3b43d29 100644
--- a/drivers/clk/imx/clk-pfd.c
+++ b/drivers/clk/imx/clk-pfd.c
@@ -127,12 +127,13 @@ static const struct clk_ops clk_pfd_ops =3D {
 	.is_enabled     =3D clk_pfd_is_enabled,
 };
=20
-struct clk *imx_clk_pfd(const char *name, const char *parent_name,
+struct clk_hw *imx_clk_hw_pfd(const char *name, const char *parent_name,
 			void __iomem *reg, u8 idx)
 {
 	struct clk_pfd *pfd;
-	struct clk *clk;
+	struct clk_hw *hw;
 	struct clk_init_data init;
+	int ret;
=20
 	pfd =3D kzalloc(sizeof(*pfd), GFP_KERNEL);
 	if (!pfd)
@@ -148,10 +149,13 @@ struct clk *imx_clk_pfd(const char *name, const char =
*parent_name,
 	init.num_parents =3D 1;
=20
 	pfd->hw.init =3D &init;
+	hw =3D &pfd->hw;
=20
-	clk =3D clk_register(NULL, &pfd->hw);
-	if (IS_ERR(clk))
+	ret =3D clk_hw_register(NULL, hw);
+	if (ret) {
 		kfree(pfd);
+		return ERR_PTR(ret);
+	}
=20
-	return clk;
+	return hw;
 }
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 89f1276..14c410e 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -66,6 +66,9 @@ struct imx_pll14xx_clk {
 #define imx_clk_pllv3(type, name, parent_name, base, div_mask) \
 	imx_clk_hw_pllv3(type, name, parent_name, base, div_mask)->clk
=20
+#define imx_clk_pfd(name, parent_name, reg, idx) \
+	imx_clk_hw_pfd(name, parent_name, reg, idx)->clk
+
 struct clk *imx_clk_pll14xx(const char *name, const char *parent_name,
 		 void __iomem *base, const struct imx_pll14xx_clk *pll_clk);
=20
@@ -121,7 +124,7 @@ struct clk_hw *imx_obtain_fixed_clk_hw(struct device_no=
de *np,
 struct clk *imx_clk_gate_exclusive(const char *name, const char *parent,
 	 void __iomem *reg, u8 shift, u32 exclusive_mask);
=20
-struct clk *imx_clk_pfd(const char *name, const char *parent_name,
+struct clk_hw *imx_clk_hw_pfd(const char *name, const char *parent_name,
 		void __iomem *reg, u8 idx);
=20
 struct clk_hw *imx_clk_pfdv2(const char *name, const char *parent_name,
--=20
2.7.4

