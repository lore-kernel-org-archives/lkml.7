Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54446C2D0C5
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 02:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A72024679
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 02:59:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="BLCTg2v1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbfLLC7r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 21:59:47 -0500
Received: from mail-eopbgr70082.outbound.protection.outlook.com ([40.107.7.82]:54337
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727783AbfLLC7q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 21:59:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J4EZh6tcu61qW/oRepJ0pSvGhXHeQG+sXZOCwoU3VDDq1DhkTHmH8WoVb1Yn78qM1ivko1dzZiN6qdI7NksF+SEqXs1R8QWiGjIeuGGVYgM/3v7n/STqBCf588M6Fcr8fvfXCeJ31N1tGyjQYjYU3s5xR9VviL01n08dS1yjzN3orAinuuT5paQcu3QIcgT2F6wZZzUa3DpPbvxL9Y/LTaBsv9u0lcrM8dMchYlFI/ehClP5x2h9pvrw5nEFArLpOXINuBxtQqJD3eVaLXhoj8jdA9NaIiWl0CQdmVKCWgUJEr8YW6UwcWxmzV0a9OQixH+QbnkyTOfFa+RkE+b1Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=127ZqZr3yibLEGADIDwdS92koh1Pj0RZ3R7B7s2PvMA=;
 b=X32L03hLn2FBQOKm/2h4ihJhyZLVON5IzcTPOjSR7FpK/aeuCE8QH6k8OQ5thGsFhvmBglR5FL0GxG7V6apO8c7cDVTmGgVcMfX9M3EWpWatarPhx5wLyKy9rKrY5ClXoIFDoMah1ThdFDVwi4o2xRr0X5X+LVkAhw/trZ76HypFAg70bMjbzOfnHvhzwpSEp6TS0pXpEgVQsFXK6PILZKmbHmQqXFe+Y/IkwXjzy7n5+Ynp+pxwAq1WF3ka5q3xlxveQbuZbVM4H0ECAKvbwSDJaf4d5O0QAQGBOHXNU5PHMeHtEGByFIrs8+yS5moHLRx1tt67FuA+bAvYtR47FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=127ZqZr3yibLEGADIDwdS92koh1Pj0RZ3R7B7s2PvMA=;
 b=BLCTg2v1dOOJtMCV3M3NwmxFMcuw5XrXrPvIje2rz5l3atshSIbbTgnZQ2b1wZPaoI2H+4L3QqSeVIAiDAxaWf9DjVa2g3he+x8dRfSv7p8Ar30ScbatmIwFrlANPJWZX9dnZaQ/eSkd0/DTb+vB/USXPgXgY0Oj2J+WwmXZcTU=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6196.eurprd04.prod.outlook.com (20.179.34.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Thu, 12 Dec 2019 02:59:10 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::505:87e7:6b49:3d29]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::505:87e7:6b49:3d29%7]) with mapi id 15.20.2538.017; Thu, 12 Dec 2019
 02:59:10 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 6/9] clk: imx: Remove __init for imx_obtain_fixed_clk_hw()
 API
Thread-Topic: [PATCH V2 6/9] clk: imx: Remove __init for
 imx_obtain_fixed_clk_hw() API
Thread-Index: AQHVsJggB12mI9cJ2kSnN3lMk35vrg==
Date:   Thu, 12 Dec 2019 02:59:10 +0000
Message-ID: <1576119353-26679-7-git-send-email-peng.fan@nxp.com>
References: <1576119353-26679-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1576119353-26679-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR0401CA0022.apcprd04.prod.outlook.com
 (2603:1096:202:2::32) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 693baaa6-e0ba-4736-1466-08d77eaf42b4
x-ms-traffictypediagnostic: AM0PR04MB6196:|AM0PR04MB6196:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB619692945E4957D15EED5DAD88550@AM0PR04MB6196.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:597;
x-forefront-prvs: 0249EFCB0B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(346002)(366004)(39860400002)(376002)(199004)(189003)(81156014)(8936002)(316002)(81166006)(8676002)(36756003)(52116002)(478600001)(4744005)(6512007)(6486002)(71200400001)(110136005)(54906003)(86362001)(186003)(66476007)(4326008)(5660300002)(2906002)(66446008)(64756008)(44832011)(26005)(6636002)(66946007)(6506007)(2616005)(66556008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6196;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ahiViBqAzNCa50vorosuUMDVYmTRD9vQHKSRKe0z1y7N0cTPbd1FIB4C5gGOQN7fA4vJSCXQIAE5I/aE/ouLn6dWwWF8uJBKCReS3rCQDJGDfm9/ekdz0D/L6WfR6gLgC+PtZsb6+qLdXhGfWDpa66i2bvEgcWKSFRSNT78eW/4C8o4jxquVZm/N59iVWFjPoy2w3o8iW1dDYIoHGJ3jOp4+xXOVtImiYk03z9PlREC20Ld9/uyBAiRfYBUg73cYmwzLtOPBje5V35YgE5ZC9mZHsKrB2cgogSZ7/OiWBvdyowi+1j/3kPwi1v3TKxz0rcw/1puH/p/dzv6+nCk7W40/MlRSjfDWrPdXN0qtXNG0fTmmOqF4R0TNwdMPumhqAQu8bnyJZBApeJHBTzhezpEcegcVrsgcXECmCpbTbkwgFZiXD+/ca8z7V4ioQUmy
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 693baaa6-e0ba-4736-1466-08d77eaf42b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2019 02:59:10.3476
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FKWbq96K6KAjaLGi0QIudOD52YZOgnJS9zqrEDEl02SecEThIyGltPrJ2UivUxJ5azXlp5dFY+d9aszGHpMQwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6196
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Some of i.MX SoCs' clock driver will use platform driver model,
and they need to call imx_obtain_fixed_clk_hw() API, so
imx_obtain_fixed_clk_hw() API should NOT be in .init section.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/imx/clk.c b/drivers/clk/imx/clk.c
index d0ce29f2c417..87ab8db3d282 100644
--- a/drivers/clk/imx/clk.c
+++ b/drivers/clk/imx/clk.c
@@ -102,8 +102,8 @@ struct clk_hw * __init imx_obtain_fixed_clock_hw(
 	return __clk_get_hw(clk);
 }
=20
-struct clk_hw * __init imx_obtain_fixed_clk_hw(struct device_node *np,
-					       const char *name)
+struct clk_hw * imx_obtain_fixed_clk_hw(struct device_node *np,
+					const char *name)
 {
 	struct clk *clk;
=20
--=20
2.16.4

