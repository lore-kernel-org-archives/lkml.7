Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C98BAC10F03
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 09:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3071520835
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 09:21:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="OVJyOak3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbfCGJVV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 04:21:21 -0500
Received: from mail-eopbgr00059.outbound.protection.outlook.com ([40.107.0.59]:34788
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725747AbfCGJVU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 04:21:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=55oBowp/yd8Cq40cGA1S25Yny7Uwz3XY5OIwHrC4dd4=;
 b=OVJyOak3kj30b5d3LSHfzwGXC7KrjSPqJYGLa8dTPrY08GvccO64dCouAwVmohgbbL+rIdQ6DbLqAZdKM0hTELnakIMqlOUlkPghejP37Tus0eST0cu1TsRdvQEpDCJ0yTYRWRbJtXm7ux8t8cCFjRIJ15M6Qwc1ccJSJjFYaY8=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB6436.eurprd04.prod.outlook.com (20.179.252.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.16; Thu, 7 Mar 2019 09:20:37 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::9579:32ab:898e:6769]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::9579:32ab:898e:6769%2]) with mapi id 15.20.1665.021; Thu, 7 Mar 2019
 09:20:37 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
CC:     Fabio Estevam <fabio.estevam@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: [RFC] clk: imx: Allow re-parenting by default on set rate
Thread-Topic: [RFC] clk: imx: Allow re-parenting by default on set rate
Thread-Index: AQHU1McGI7U/PNQmd0+BEjFYJ+Rc/w==
Date:   Thu, 7 Mar 2019 09:20:37 +0000
Message-ID: <1551950425-7346-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR01CA0065.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:e0::42) To AM0PR04MB5779.eurprd04.prod.outlook.com
 (2603:10a6:208:131::23)
x-originating-ip: [95.76.156.53]
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 42e8ba8f-9293-460c-c25c-08d6a2de28cf
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB6436;
x-ms-traffictypediagnostic: AM0PR04MB6436:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;AM0PR04MB6436;23:y80h7hCxbtcFGT09Yg1ZiK3KXM/Ka0Dloj06TDM?=
 =?iso-8859-1?Q?n/JYdW0xAidslGFhrAQ/urZ8bV7cIhMjZA/j0AIWqckTVYi73vXi9L8qzF?=
 =?iso-8859-1?Q?zJ8rp5qVacUGAp4Imkmw5E7tB51sE8V7qfCx3S/A8SY51OfB1u6P4F2bgw?=
 =?iso-8859-1?Q?lOaygIHAKqGYLrpvn0fh5AAUMZD/nDczFEUndcgXMusgEvk9OCb7pYQ9W3?=
 =?iso-8859-1?Q?0g3v4Cg69l//ddK4cv0BrK+KYVGBLym6hK9gSU3AT7mqoCjgThMqn6YV5N?=
 =?iso-8859-1?Q?cvBfc3V8ObwiytvZvNg8e+u/Zk+4bBrwJ95zffetYT62AhIaIRhytgnmf6?=
 =?iso-8859-1?Q?+2wXEU2qzuLl9VqoEGyA9ghoVel77h7rIT8NBAVgi593ze2hRdUim7qGKQ?=
 =?iso-8859-1?Q?abkARLPLI60vyDedd7FGTLHhchmYwI6q6VcS/PrSHUSkRPwPJBxf1JbTKF?=
 =?iso-8859-1?Q?g6iLurorBS+8wNkhvTMdWCihcK1ZZ2Ipt7dhiVeLJm3Af8rTruh2ZBIola?=
 =?iso-8859-1?Q?uZMf76I4nvc65wN8IlPIBaNEImvG7NDKnxSgl3U8qnwAHt87JShGgVMT6i?=
 =?iso-8859-1?Q?ANipJvTTNqPxR5ppySIBuEwVO4NA9CnC3ihg2pIcUbGccmbgTpX+8OlxvA?=
 =?iso-8859-1?Q?3Rq+vRuPRLq4XRR7nubP08BCh6hTYsiRXp9hkYSlNbnXOmPcg8C49vf2KX?=
 =?iso-8859-1?Q?Dr/tIVORArZTD5DIaVJcFO8JVvJsEqlxaW96ntnnFf1ouqFAYqiaAZGXyo?=
 =?iso-8859-1?Q?pToWhdslRa0Iq9lNa0Lu9k58cY6WPymfPT4jsKNKiDMdG27D4UHBe0dREz?=
 =?iso-8859-1?Q?9S0N9G3lTKmka2Z3B1+l6zUPK3Wg3uyqXSwPsIPOJd+arjG389GZ5V8iiN?=
 =?iso-8859-1?Q?BNudBORI9yLd8c8bBkLh8BJnk1D4r4BbV/NqrTsZfyXz5Z2pnXQRK2Tj68?=
 =?iso-8859-1?Q?bXxCD9J/OKGlDdYt3IAG6FVm8esIKILsoKzCWdvrY8ReVF0QAyLqvAFOrK?=
 =?iso-8859-1?Q?TplLFqHJNlaQ4xYgJICOaaWK/BDOdmYlIN/Nt4TAKbIe3g9j1KijvnP0L9?=
 =?iso-8859-1?Q?YIAJ6fCsM7PTsvaw3mL0XH53cq4kOzr0GflgV/vWXrhg6+a1INqRg5gM3l?=
 =?iso-8859-1?Q?W1U87Wn+kt2eU7Zm7/IuxuSbnSBcju0oJp/wrz9LTR06ItSltiptA3yf5S?=
 =?iso-8859-1?Q?5vA8MnjYmRCSZh0TB0M+fXZ7Njz6sniWg=3D=3D?=
x-microsoft-antispam-prvs: <AM0PR04MB643600489F7D01098246C691F64C0@AM0PR04MB6436.eurprd04.prod.outlook.com>
x-forefront-prvs: 096943F07A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(396003)(366004)(346002)(136003)(199004)(189003)(6436002)(53936002)(36756003)(305945005)(6486002)(6116002)(66066001)(478600001)(4326008)(86362001)(3846002)(7736002)(106356001)(14454004)(25786009)(5660300002)(81156014)(81166006)(8936002)(14444005)(256004)(8676002)(68736007)(99286004)(102836004)(386003)(6506007)(71190400001)(105586002)(71200400001)(52116002)(316002)(54906003)(110136005)(186003)(50226002)(486006)(44832011)(26005)(476003)(2616005)(2906002)(97736004)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6436;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: L72R9L2vvlsGD92rLsvNErDdzLmX+1vJxFt8hL3PdtSdmaUn5nmGOdg6EHejlaVv8Z+oPe/KomdqwVtS1URSN5MZK2h5c5j6PLY1xg8bNbDW/Mr1Xy+e59Lh4rg5sPj6p44AwpzWbEbdgok4a910aYshozVVxgd949XMFKEfeQlztigzbFFQ8kPoMztAKmpLZSmf0CCkm4mQ7h5bvjFfs+1nfXx6y2DSo4lLniAOShDhMdN31qdCdCivnhb2MOvUgnExkXLXfqvw3/oSPBLxfkponxnNvYuXlBXgWQl0qeRlic9s9UevrT32C/rWkrQAOfEBcOPbexN5XaP+Ek07orSNofkzZJfuMh3Iq8MC0d0A336k49XUDJXzd4D8uyxKxXcfJEpMyTRel4qomuQ3aPd3bNk5LUjlOlJUAxhAm1Q=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42e8ba8f-9293-460c-c25c-08d6a2de28cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2019 09:20:37.3769
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6436
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By default, the muxes should re-parent on set_rate.
This would allow the drivers to control only the leaf clock node,
leaving the rest to the clock driver, that way simplifying the
clock control.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/clk/imx/clk.h | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 5748ec8..055b602 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -148,7 +148,7 @@ static inline struct clk *imx_clk_mux_ldb(const char *n=
ame, void __iomem *reg,
 			int num_parents)
 {
 	return clk_register_mux(NULL, name, parents, num_parents,
-			CLK_SET_RATE_NO_REPARENT | CLK_SET_RATE_PARENT, reg,
+			CLK_SET_RATE_PARENT, reg,
 			shift, width, CLK_MUX_READ_ONLY, &imx_ccm_lock);
 }
=20
@@ -321,7 +321,7 @@ static inline struct clk *imx_clk_mux(const char *name,=
 void __iomem *reg,
 			int num_parents)
 {
 	return clk_register_mux(NULL, name, parents, num_parents,
-			CLK_SET_RATE_NO_REPARENT, reg, shift,
+			0, reg, shift,
 			width, 0, &imx_ccm_lock);
 }
=20
@@ -330,7 +330,7 @@ static inline struct clk *imx_clk_mux2(const char *name=
, void __iomem *reg,
 			int num_parents)
 {
 	return clk_register_mux(NULL, name, parents, num_parents,
-			CLK_SET_RATE_NO_REPARENT | CLK_OPS_PARENT_ENABLE,
+			CLK_OPS_PARENT_ENABLE,
 			reg, shift, width, 0, &imx_ccm_lock);
 }
=20
@@ -340,7 +340,6 @@ static inline struct clk_hw *imx_clk_hw_mux2(const char=
 *name, void __iomem *reg
 					     int num_parents)
 {
 	return clk_hw_register_mux(NULL, name, parents, num_parents,
-				   CLK_SET_RATE_NO_REPARENT |
 				   CLK_OPS_PARENT_ENABLE,
 				   reg, shift, width, 0, &imx_ccm_lock);
 }
@@ -351,7 +350,7 @@ static inline struct clk *imx_clk_mux_flags(const char =
*name,
 			unsigned long flags)
 {
 	return clk_register_mux(NULL, name, parents, num_parents,
-			flags | CLK_SET_RATE_NO_REPARENT, reg, shift, width, 0,
+			flags, reg, shift, width, 0,
 			&imx_ccm_lock);
 }
=20
@@ -361,7 +360,7 @@ static inline struct clk *imx_clk_mux2_flags(const char=
 *name,
 		int num_parents, unsigned long flags)
 {
 	return clk_register_mux(NULL, name, parents, num_parents,
-			flags | CLK_SET_RATE_NO_REPARENT | CLK_OPS_PARENT_ENABLE,
+			flags | CLK_OPS_PARENT_ENABLE,
 			reg, shift, width, 0, &imx_ccm_lock);
 }
=20
@@ -373,7 +372,7 @@ static inline struct clk_hw *imx_clk_hw_mux_flags(const=
 char *name,
 						  unsigned long flags)
 {
 	return clk_hw_register_mux(NULL, name, parents, num_parents,
-				   flags | CLK_SET_RATE_NO_REPARENT,
+				   flags,
 				   reg, shift, width, 0, &imx_ccm_lock);
 }
=20
@@ -389,7 +388,7 @@ struct clk *imx8m_clk_composite_flags(const char *name,
 #define __imx8m_clk_composite(name, parent_names, reg, flags) \
 	imx8m_clk_composite_flags(name, parent_names, \
 		ARRAY_SIZE(parent_names), reg, \
-		flags | CLK_SET_RATE_NO_REPARENT | CLK_OPS_PARENT_ENABLE)
+		flags | CLK_OPS_PARENT_ENABLE)
=20
 #define imx8m_clk_composite(name, parent_names, reg) \
 	__imx8m_clk_composite(name, parent_names, reg, 0)
--=20
2.7.4

