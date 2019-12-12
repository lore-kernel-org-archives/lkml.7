Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FFF1C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 02:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 460E422B48
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 02:59:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="BV6D86l2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbfLLC73 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 21:59:29 -0500
Received: from mail-eopbgr60065.outbound.protection.outlook.com ([40.107.6.65]:2682
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727472AbfLLC71 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 21:59:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RgcT4A5lYV+GktEV50/ICpqpSXKbqCgEi0XyFlKpPdeSf0inTbFwYM3Dq0djPv9ZSeC0f+/qNWu923cKof4D3uPfyf4FBuURv8SAEZNDQpC1b4egOR8TGWggttN6DzteB1QhNgyz/uNxrVWbnyayL870dEERwwI0ueVsIvoi5QDSFOTaNp04reXTwFbI8gAEhId7RK7K15mXDxwpHhz34e83WMY+GMeDyDbb4ErvNE2yz9XhxXnE15YIwvZ9oBJIYGs6cDgB5MMl+IPupaEQwZw6dPXB2/93gTJiMzLmPrjPrV/6p81tyWI3QYB1COYyZbP2rqDytGgJQOyW5SFAIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TmP/J8+lSTJ72L+YfDiWnqLgv47r9EsYxC8ONhrzGwA=;
 b=FucParvwNTGWCxJfCJO3bnjQa5cc6v/gpBEyVwETJbQaj3K+jTBuBwgHa5WJLWwBpBh24QmngJkGy2UxWucn09d0eCxgrcMvC8CawTmV4IvCIlz9+iv6dDhxDXD/smg1s+8NQ5JTigraI4ikoP+y+GZw808jFD5+vpEyhIzyx3C7S5NSkfMOgDzcL9SVMlQjmkyMH9pzm3OzJVd7nFfwo/MxG/wL0t+q9xWJEPR0++HSxgWlRP+nAp7Ci2MWVhP8JKtNm9hfEpFnVA94RDwkYZgP1O4HzyyduLiztVT4gilwH8MJgzwNnNablaKOwAIe8+ODZVzTZPotyMNJAtKyWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TmP/J8+lSTJ72L+YfDiWnqLgv47r9EsYxC8ONhrzGwA=;
 b=BV6D86l2AqnW4WqmgetYshddjR2WUs/b7c7N7MT5gZHXXcgc+sanrhHASSebZ8W07GPGZig8EdAZylxsxH0qkhQBqyxLguTmLBN9hZYFhMO955zg7+ueJtofqTX8IO6xV+fkFmTl1qMcvQj/veFHPXBSbntcZlkCQvXDaZIuAPM=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6196.eurprd04.prod.outlook.com (20.179.34.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Thu, 12 Dec 2019 02:58:54 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::505:87e7:6b49:3d29]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::505:87e7:6b49:3d29%7]) with mapi id 15.20.2538.017; Thu, 12 Dec 2019
 02:58:54 +0000
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
Subject: [PATCH V2 3/9] clk: imx: add imx_unregister_hw_clocks
Thread-Topic: [PATCH V2 3/9] clk: imx: add imx_unregister_hw_clocks
Thread-Index: AQHVsJgXLLTiXm5fZEqiDZK/JwhSLg==
Date:   Thu, 12 Dec 2019 02:58:54 +0000
Message-ID: <1576119353-26679-4-git-send-email-peng.fan@nxp.com>
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
x-ms-office365-filtering-correlation-id: 5d2d6a4d-0d5c-48a6-733e-08d77eaf397c
x-ms-traffictypediagnostic: AM0PR04MB6196:|AM0PR04MB6196:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB6196DE65C90E3BF0D2FF429688550@AM0PR04MB6196.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1002;
x-forefront-prvs: 0249EFCB0B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(346002)(366004)(39860400002)(376002)(199004)(189003)(81156014)(8936002)(316002)(81166006)(8676002)(36756003)(52116002)(478600001)(6512007)(6486002)(71200400001)(110136005)(54906003)(86362001)(186003)(66476007)(4326008)(5660300002)(2906002)(66446008)(64756008)(44832011)(26005)(6636002)(66946007)(6506007)(2616005)(66556008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6196;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XMMeZTycAAG91Ibsc9JSCJm+vL2uac6UaQ7SsxlQz1TXpXzvOo0jm/zkxV0hz81KnCMs/uFhTbZfBddHEt+W1ReoPNCtz47uL4rm2wKvqs3Ldo70byb1zXXKqHi+XP9Br3p4wkQEEdkJC3BzZ1+YoyhzesrKDkmePQKmc93DT8cKTgJhoVlCtDtWDEx0TQNDaSgY1vkC+cZf/c5N31AdjslXD2LWYXC+j0seAnREFVcSAG+w3eBJzhG6djzyb/WYq24WH9kABuwNmXgsOiktNR7Addisa7ZBJY3qI0P+SafgHpvEOSXDSuSOTRFdlrB5RLdqhED3pHr6rdH9tv+TcoW9g5309+oefXkze7O1kEQR5wk6XwHTcKZMNo8zY3J7CcBpU35ailmoZwnQH+5lHgl4U6GyJPEPfLzNkBtGjIIlZgavHsqXUkEb6DTv0ehV
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d2d6a4d-0d5c-48a6-733e-08d77eaf397c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2019 02:58:54.7736
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Saxg+sKOYzEzq+KY2u9s54lPhKGP6/zXEzq9vtlbgSu+FZpMPtdY7NbXjGErBZ34u4qvuknODgavQpWRU2/91Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6196
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

There is a non hw API based imx_unregister_clocks to unregister clocks
when of_clk_add_provider failed. Add a hw API based
imx_unregister_hw_clocks when of_clk_add_hw_provider failed.

Reviewed-by: Abel Vesa <abel.vesa@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk.c | 8 ++++++++
 drivers/clk/imx/clk.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/drivers/clk/imx/clk.c b/drivers/clk/imx/clk.c
index cfc05e43c343..d0ce29f2c417 100644
--- a/drivers/clk/imx/clk.c
+++ b/drivers/clk/imx/clk.c
@@ -22,6 +22,14 @@ void imx_unregister_clocks(struct clk *clks[], unsigned =
int count)
 		clk_unregister(clks[i]);
 }
=20
+void imx_unregister_hw_clocks(struct clk_hw *hws[], unsigned int count)
+{
+	unsigned int i;
+
+	for (i =3D 0; i < count; i++)
+		clk_hw_unregister(hws[i]);
+}
+
 void __init imx_mmdc_mask_handshake(void __iomem *ccm_base,
 				    unsigned int chn)
 {
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 46cbac4d89a5..20dc9a1fcd6c 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -12,6 +12,7 @@ void imx_check_clk_hws(struct clk_hw *clks[], unsigned in=
t count);
 void imx_register_uart_clocks(struct clk ** const clks[]);
 void imx_mmdc_mask_handshake(void __iomem *ccm_base, unsigned int chn);
 void imx_unregister_clocks(struct clk *clks[], unsigned int count);
+void imx_unregister_hw_clocks(struct clk_hw *hws[], unsigned int count);
=20
 extern void imx_cscmr1_fixup(u32 *val);
=20
--=20
2.16.4

