Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A48C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 12:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16628216FD
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 12:26:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Qd1HhNiO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbfE2M0q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 08:26:46 -0400
Received: from mail-eopbgr70079.outbound.protection.outlook.com ([40.107.7.79]:5830
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726612AbfE2M0o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 08:26:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T8jY5Sb2i129F8pv7zm/YImKjhCCH8B2F1bW+Zgae6A=;
 b=Qd1HhNiOpMGh130+AYUu8PmECK2GXXtGjR079mc3X9g4IaHQdrFsTaxYLTsftgvVGjTm2nNwIUrUAwqGIKKoystwnKX2qKJguGnQCyLmktTk7Vz5kG9mjgDiXepWi7+pWO3FXlMsTj0yDSXnYW3i5KqflfaNjUBZEzYqIbhrwKQ=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB6049.eurprd04.prod.outlook.com (20.179.32.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.17; Wed, 29 May 2019 12:26:39 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::c19b:5964:bfcb:96a8]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::c19b:5964:bfcb:96a8%7]) with mapi id 15.20.1922.021; Wed, 29 May 2019
 12:26:39 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>
CC:     Fabio Estevam <fabio.estevam@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        Jacky Bai <ping.bai@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: [RESEND 01/18] clk: imx: Add imx_obtain_fixed_clock clk_hw based
 variant
Thread-Topic: [RESEND 01/18] clk: imx: Add imx_obtain_fixed_clock clk_hw based
 variant
Thread-Index: AQHVFhnDfgMCmm0LTEe53AHMkXNRPA==
Date:   Wed, 29 May 2019 12:26:39 +0000
Message-ID: <1559132773-12884-2-git-send-email-abel.vesa@nxp.com>
References: <1559132773-12884-1-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1559132773-12884-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cfe1c59d-b650-4ec9-c88b-08d6e430e678
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB6049;
x-ms-traffictypediagnostic: AM0PR04MB6049:
x-microsoft-antispam-prvs: <AM0PR04MB60498080EFED960EE2E5E4A7F61F0@AM0PR04MB6049.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1468;
x-forefront-prvs: 0052308DC6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(39860400002)(366004)(346002)(376002)(199004)(189003)(6436002)(476003)(73956011)(53936002)(486006)(11346002)(446003)(76116006)(186003)(5660300002)(102836004)(66446008)(66476007)(66946007)(26005)(44832011)(64756008)(36756003)(91956017)(66556008)(8936002)(316002)(2616005)(66066001)(99286004)(256004)(6116002)(6512007)(3846002)(76176011)(68736007)(305945005)(14444005)(81156014)(81166006)(6486002)(6506007)(54906003)(110136005)(478600001)(2906002)(7736002)(8676002)(14454004)(86362001)(71190400001)(71200400001)(25786009)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6049;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: K5natfntCGCsdTb4svUj6bBYmFaOnbSCz0g8RQ3rnMHeahPvUJzM0j96QQviGHlVOPUROYaZC41B0GGlnTeOSCv6m4e+tU65hIh9pCYFzOEwNK9Ary1vMMr7amaCK4lN/GwjrDvPQTdXEbgxsfpnqw3BBmAMJB7496hHOgZkXVupumxzKr02oj5PESnhgegVrcwhmkg4HqeUT6hs/dx0fXjWj6qJXkOZTlUiIT4xP+lXCFmXog6J5j9FFxgkj4c26h57TKFaxZf2sWubX7Qu9Qwnxc4MJK83EimdZ8wP8164e8J01pCYXS7LJo140Xt7CIPzBWkVZ7c0P1iW2ZrxHk2Qur1G1LNFQ14pQF+OvmO8kc/HFuym/T6EMWzjeyD0w2ryj0T+1APSGiNJksgGD9r6Mkvg4qwBzKMExd9xcys=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <D32FA522AA9F294E91492CEEC14CA09F@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfe1c59d-b650-4ec9-c88b-08d6e430e678
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2019 12:26:39.3453
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: abel.vesa@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6049
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to move to clk_hw based API, imx_obtain_fixed_clock_hw
is added. The end goal here is to have all the clk providers use
the clk_hw based API.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/clk/imx/clk.c | 11 +++++++++++
 drivers/clk/imx/clk.h |  3 +++
 2 files changed, 14 insertions(+)

diff --git a/drivers/clk/imx/clk.c b/drivers/clk/imx/clk.c
index 9cd7097..0ecb67a 100644
--- a/drivers/clk/imx/clk.c
+++ b/drivers/clk/imx/clk.c
@@ -74,6 +74,17 @@ struct clk * __init imx_obtain_fixed_clock(
 	return clk;
 }
=20
+struct clk_hw * __init imx_obtain_fixed_clock_hw(
+			const char *name, unsigned long rate)
+{
+	struct clk *clk;
+
+	clk =3D imx_obtain_fixed_clock_from_dt(name);
+	if (IS_ERR(clk))
+		clk =3D imx_clk_fixed(name, rate);
+	return __clk_get_hw(clk);
+}
+
 struct clk_hw * __init imx_obtain_fixed_clk_hw(struct device_node *np,
 					       const char *name)
 {
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 6dcdc91..77c2ce8 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -96,6 +96,9 @@ struct clk *clk_register_gate2(struct device *dev, const =
char *name,
 struct clk * imx_obtain_fixed_clock(
 			const char *name, unsigned long rate);
=20
+struct clk_hw *imx_obtain_fixed_clock_hw(
+			const char *name, unsigned long rate);
+
 struct clk_hw *imx_obtain_fixed_clk_hw(struct device_node *np,
 				       const char *name);
=20
--=20
2.7.4
