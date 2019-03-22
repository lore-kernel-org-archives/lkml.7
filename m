Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EAEAC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DC3421925
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:37:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="akkoGU6i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbfCVPhL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 11:37:11 -0400
Received: from mail-eopbgr60072.outbound.protection.outlook.com ([40.107.6.72]:41091
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725981AbfCVPhJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 11:37:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fUr5VU1Dyg57KtD3QC7h42AMUCrQoW+fxf7vwC5LzQ0=;
 b=akkoGU6iOECD8+uv1Lr8Nc2mBdFLlh/nZ/sSPnWv0EFX4iel9AXSgLmtnzrLWWvGbqZQV25xBoFzmUT+fsPrB6FSyv97i7Ivteor6d12lY9TSoqH4vk1CbGa+RV0JtiEjBEeNvw7ycOeKvKig1XC7jryoCPxDZIv66vr6M5RVtU=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB5636.eurprd04.prod.outlook.com (20.178.202.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.15; Fri, 22 Mar 2019 15:37:02 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::9579:32ab:898e:6769]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::9579:32ab:898e:6769%2]) with mapi id 15.20.1709.017; Fri, 22 Mar 2019
 15:37:02 +0000
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
Subject: [RFC 02/19] clk: imx: Add imx_obtain_fixed_clock clk_hw based variant
Thread-Topic: [RFC 02/19] clk: imx: Add imx_obtain_fixed_clock clk_hw based
 variant
Thread-Index: AQHU4MUYo/Wnp4tMMEGlyRyj4Rfm7g==
Date:   Fri, 22 Mar 2019 15:37:02 +0000
Message-ID: <1553269010-15591-3-git-send-email-abel.vesa@nxp.com>
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
x-ms-office365-filtering-correlation-id: 486c47b6-b02a-4586-59f0-08d6aedc3aa0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5636;
x-ms-traffictypediagnostic: AM0PR04MB5636:
x-microsoft-antispam-prvs: <AM0PR04MB5636D44678F97AFF9AE33251F6430@AM0PR04MB5636.eurprd04.prod.outlook.com>
x-forefront-prvs: 09840A4839
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(39860400002)(376002)(396003)(136003)(199004)(189003)(106356001)(105586002)(54906003)(110136005)(316002)(52116002)(6512007)(81156014)(97736004)(53936002)(86362001)(81166006)(478600001)(8676002)(2906002)(14454004)(486006)(99286004)(36756003)(7736002)(71200400001)(44832011)(71190400001)(3846002)(5660300002)(386003)(4326008)(6116002)(6486002)(50226002)(6506007)(66066001)(256004)(76176011)(446003)(186003)(25786009)(11346002)(68736007)(26005)(476003)(6436002)(2616005)(8936002)(102836004)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5636;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /iny20IPh8QGgpRFFJgFAAR6J8+qqHB4vqvjTaQK7wRqvnV3noxR2MoTSTaerPeWhHazDY8p2QGMc6Ss3BqDgrZaNis/L5VdNHcmzJdtTzVcV0hRTB1puUGSKCWZEOwMxzGNpwSNvipXYczwPEqc209Ve4ITy1vI4F+uL4n37x/3FpXqoCdO5p2ORcNwZumeHb+uc3BrT08Kshupc6A9xRZJFGxZh+dt3uMriqw18O3gJYhK9MWmbBa3/8K0jAq4C/+XqLAbDcaxNxogCwKvClXKCzz2KRiiL6fPn5EHvkxm0SOaaWsCkf34OMyYNzG4yb5WCLIIaf9kT1jBHBFWBYg//oiKQQINOoCjrxOUGxPpQB4xOu4QeSvT6VEVWyU3EWYoVho1nbWCElqek9lHQ5hBqD/tQ44k6OYX7/fwOWg=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 486c47b6-b02a-4586-59f0-08d6aedc3aa0
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2019 15:37:02.1340
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5636
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/clk/imx/clk.c | 11 +++++++++++
 drivers/clk/imx/clk.h |  3 +++
 2 files changed, 14 insertions(+)

diff --git a/drivers/clk/imx/clk.c b/drivers/clk/imx/clk.c
index 1efed86..d9ce911 100644
--- a/drivers/clk/imx/clk.c
+++ b/drivers/clk/imx/clk.c
@@ -59,6 +59,17 @@ struct clk * __init imx_obtain_fixed_clock(
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
index edc12d6..e78519c 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -94,6 +94,9 @@ struct clk *clk_register_gate2(struct device *dev, const =
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

