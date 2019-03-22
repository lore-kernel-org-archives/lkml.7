Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7647AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:38:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C56F218FE
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:38:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kYs22tAD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbfCVPil (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 11:38:41 -0400
Received: from mail-eopbgr00067.outbound.protection.outlook.com ([40.107.0.67]:50409
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727552AbfCVPhO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 11:37:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DQqn1hiZo+ZHCSefWFPCewJ251/VIBiq7ocj6Uim170=;
 b=kYs22tADVf7AERcL+FIUZ//g/1w3BdtXopfwBng1ECfeiXMETG/2lqVLrsQxHGmFfxDak1+lIV8dgtgmdCykXGr7K6Dt9+AjvAnJ2qlFJprMRShRsuR3sl+mGYir6BtBEPmpGjaDzyNjnaneahT4hkt3/k1NM99QhZq1FmdWM6g=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB4802.eurprd04.prod.outlook.com (20.176.215.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.16; Fri, 22 Mar 2019 15:37:11 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::9579:32ab:898e:6769]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::9579:32ab:898e:6769%2]) with mapi id 15.20.1709.017; Fri, 22 Mar 2019
 15:37:11 +0000
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
Subject: [RFC 11/19] clk: imx: clk-fixup-div: Switch to clk_hw based API
Thread-Topic: [RFC 11/19] clk: imx: clk-fixup-div: Switch to clk_hw based API
Thread-Index: AQHU4MUd06J+r9hZ9EmcnR9X41Z5Cw==
Date:   Fri, 22 Mar 2019 15:37:11 +0000
Message-ID: <1553269010-15591-12-git-send-email-abel.vesa@nxp.com>
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
x-ms-office365-filtering-correlation-id: d6433351-05d2-4c2a-c8b5-08d6aedc3ffa
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4802;
x-ms-traffictypediagnostic: AM0PR04MB4802:
x-microsoft-antispam-prvs: <AM0PR04MB4802C6024FCBD746FF1D901FF6430@AM0PR04MB4802.eurprd04.prod.outlook.com>
x-forefront-prvs: 09840A4839
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(346002)(376002)(39860400002)(366004)(189003)(199004)(446003)(71190400001)(99286004)(25786009)(8676002)(478600001)(71200400001)(256004)(66066001)(305945005)(7736002)(4326008)(14454004)(68736007)(81166006)(5660300002)(8936002)(97736004)(53936002)(81156014)(50226002)(6512007)(36756003)(26005)(186003)(105586002)(102836004)(6436002)(3846002)(76176011)(52116002)(106356001)(6486002)(6116002)(386003)(486006)(44832011)(86362001)(476003)(2616005)(11346002)(54906003)(2906002)(6506007)(110136005)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4802;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: YEOYFUHysxcSnHjCCt/xdG3wuZTLZljWoqq1S4LIt8G3Qov3OEgC4zXimRUw0CDMSThJJdbztOSbIhb7NMKjJkbODTArILQ952X3buTefb6ZEbr9t1ASzQwY8Q9EM7xy0tojiqPFrO6R0SXj/4yXtYbfjV/pVbNUDy7cjBkb5EEoTEXigvFhRhJZAyUJFREVurBTB9vfI8iwhUJ5QTDnUWjAnKkOwhPmopKdcMnXHVz0r+tO/sLdH9K4RhyZIGD8Ck2LAIQaZcMKklb8Pcpd5n8t8YkwVmkI+BygESsMRb3ivLZwNgTyx7AiPpgZ56GAESpDEwYXjoXHjdzbwXxRinq1XLBO7LKD8LNMkPbj9zgLSv29lg3O85u6DnuMwm7dfw3aarLcLI+jeRexWVciB+0E51u5iDNaQPU2g9ZFhQA=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6433351-05d2-4c2a-c8b5-08d6aedc3ffa
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2019 15:37:11.1113
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4802
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch the imx_clk_fixup_divider function to clk_hw based API,
rename accordingly and add a macro for clk based legacy.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/clk/imx/clk-fixup-div.c | 15 ++++++++++-----
 drivers/clk/imx/clk.h           |  7 +++++--
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/imx/clk-fixup-div.c b/drivers/clk/imx/clk-fixup-di=
v.c
index ce572273..287539b 100644
--- a/drivers/clk/imx/clk-fixup-div.c
+++ b/drivers/clk/imx/clk-fixup-div.c
@@ -91,13 +91,14 @@ static const struct clk_ops clk_fixup_div_ops =3D {
 	.set_rate =3D clk_fixup_div_set_rate,
 };
=20
-struct clk *imx_clk_fixup_divider(const char *name, const char *parent,
+struct clk_hw *imx_clk_hw_fixup_divider(const char *name, const char *pare=
nt,
 				  void __iomem *reg, u8 shift, u8 width,
 				  void (*fixup)(u32 *val))
 {
 	struct clk_fixup_div *fixup_div;
-	struct clk *clk;
+	struct clk_hw *hw;
 	struct clk_init_data init;
+	int ret;
=20
 	if (!fixup)
 		return ERR_PTR(-EINVAL);
@@ -120,9 +121,13 @@ struct clk *imx_clk_fixup_divider(const char *name, co=
nst char *parent,
 	fixup_div->ops =3D &clk_divider_ops;
 	fixup_div->fixup =3D fixup;
=20
-	clk =3D clk_register(NULL, &fixup_div->divider.hw);
-	if (IS_ERR(clk))
+	hw =3D &fixup_div->divider.hw;
+
+	ret =3D clk_hw_register(NULL, hw);
+	if (ret) {
 		kfree(fixup_div);
+		return ERR_PTR(ret);
+	}
=20
-	return clk;
+	return hw;
 }
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 1abbb0f..3b1f687 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -72,6 +72,9 @@ struct imx_pll14xx_clk {
 #define imx_clk_gate_exclusive(name, parent, reg, shift, exclusive_mask) \
 	imx_clk_hw_gate_exclusive(name, parent, reg, shift, exclusive_mask)->clk
=20
+#define imx_clk_fixup_divider(name, parent, reg, shift, width, fixup) \
+	imx_clk_hw_fixup_divider(name, parent, reg, shift, width, fixup)->clk
+
 struct clk *imx_clk_pll14xx(const char *name, const char *parent_name,
 		 void __iomem *base, const struct imx_pll14xx_clk *pll_clk);
=20
@@ -147,11 +150,11 @@ struct clk_hw *imx7ulp_clk_composite(const char *name=
,
 				     bool rate_present, bool gate_present,
 				     void __iomem *reg);
=20
-struct clk *imx_clk_fixup_divider(const char *name, const char *parent,
+struct clk_hw *imx_clk_hw_fixup_divider(const char *name, const char *pare=
nt,
 				  void __iomem *reg, u8 shift, u8 width,
 				  void (*fixup)(u32 *val));
=20
-struct clk *imx_clk_fixup_mux(const char *name, void __iomem *reg,
+struct clk_hw *imx_clk_hw_fixup_mux(const char *name, void __iomem *reg,
 			      u8 shift, u8 width, const char * const *parents,
 			      int num_parents, void (*fixup)(u32 *val));
=20
--=20
2.7.4

