Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C0EEC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42F1D2068E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:11:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Wt/aytNG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729184AbfKVGLt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 01:11:49 -0500
Received: from mail-eopbgr40088.outbound.protection.outlook.com ([40.107.4.88]:36225
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728706AbfKVGLr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 01:11:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=npZzroqu3fkYZS/TtW202OrhdR63KqgHdhH6qSaebkibP55jCzDq85casZztG2tSAz8FMuV+R+039iwxyzsCphi5mSsDVoghaJT6RYp9bB3NWndAQlEfsEf0QMlldXiDibh+JIJNsyn1ElGvESX27eQWFCk9sMn3SBSOVFNDBjPYfnbrVgZXexmceMPnJYMXx+EnMYHr6N+aDbx+IdMXG+TB1qOCDwazPpubthxXW/beoD42yJ7jqIfMJjA+/HhM1yKfDBful8KXMrQyt7S7m2FReFahFgcZlHx1kwOM+EoYQDKc6arJegfFfz/wf5/VpMX491R433LfY+COwLAj8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2W6Ixk6pIl6FrbjBwtxE0Y3Z5gzLc+BCXlLgoMKIhNk=;
 b=PKAHjwZAmHFVNgcndln66cLtNK7go9rkMf9/A+OIQN4rf2f2ETk/UOQSW9d0BF2D8BbSLBzCRup4J8vGsMQPNIY6IG/t1r4Kg26lHLLBVtO3hJ7PqS8+Fg/lwSY3e3CSpIfpHjNSHfVxtp2wNOGSRaAqcD25WmYaQqkmbdZ2zY6p9uBQpf3Ou2joa/OtH46caTA84AEixkmhUWmCi9vHguHsiOQZOQGfw8k9xlbq54GyPf9eLZkVEdo0HmCUMm4zu58V4GnXoIJNriCHAqPWiVs0RYKfN/YT31rkUhr4ugkPId5ANYfO5ccWXFGDUWuy75Ab5aoPZouOEubyE4xwrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2W6Ixk6pIl6FrbjBwtxE0Y3Z5gzLc+BCXlLgoMKIhNk=;
 b=Wt/aytNGFTQvLMCUhMThBRqZyEQ86qoj5u5GA8kb6W9egW7SocR5/LeXkcqjO7vwR9ye/dZxSVdWJhSQiDo6BoTRPhFs3Jd4/QH/iF55lWMsyFp2tvC52hHMRjSPlu8xeHWFeuKTMqXSU834h/5eiN68GhpZu6yFHRs0v0PwaUE=
Received: from DB7PR04MB4490.eurprd04.prod.outlook.com (52.135.138.150) by
 DB7PR04MB4027.eurprd04.prod.outlook.com (52.135.128.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.19; Fri, 22 Nov 2019 06:11:43 +0000
Received: from DB7PR04MB4490.eurprd04.prod.outlook.com
 ([fe80::4182:4692:ffbd:43a0]) by DB7PR04MB4490.eurprd04.prod.outlook.com
 ([fe80::4182:4692:ffbd:43a0%6]) with mapi id 15.20.2474.021; Fri, 22 Nov 2019
 06:11:43 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Abel Vesa <abel.vesa@nxp.com>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Alice Guo <alice.guo@nxp.com>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] clk: imx: clk-imx7ulp: Add missing sentinel of ulp_div_table
Thread-Topic: [PATCH] clk: imx: clk-imx7ulp: Add missing sentinel of
 ulp_div_table
Thread-Index: AQHVoPu2X6fv8TWPzU2zaNGhXWqkhA==
Date:   Fri, 22 Nov 2019 06:11:42 +0000
Message-ID: <1574402986-11117-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR01CA0067.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::31) To DB7PR04MB4490.eurprd04.prod.outlook.com
 (2603:10a6:5:36::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8b4031c6-3cc2-470d-8b33-08d76f12d854
x-ms-traffictypediagnostic: DB7PR04MB4027:|DB7PR04MB4027:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR04MB4027D528D5CC70D1D597486688490@DB7PR04MB4027.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:873;
x-forefront-prvs: 02296943FF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(366004)(39860400002)(376002)(396003)(136003)(199004)(189003)(44832011)(2616005)(99286004)(14454004)(2501003)(508600001)(386003)(6506007)(102836004)(4326008)(26005)(186003)(2906002)(6116002)(3846002)(50226002)(5660300002)(8936002)(4744005)(316002)(52116002)(81156014)(81166006)(8676002)(54906003)(110136005)(256004)(14444005)(6436002)(66066001)(6636002)(36756003)(2201001)(6486002)(305945005)(86362001)(6512007)(66946007)(66476007)(66556008)(64756008)(66446008)(71200400001)(7736002)(71190400001)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4027;H:DB7PR04MB4490.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UM5s49S3wsGfZ+jzxZ50FQrxJsCmA8rUl4RFXbW6NAPhQpnJmbILM15wr7T6BJEVfyTShOr/gh/f6/9/HyGK1QZURRy5lrnPgCHFb4CYzD4CoErvSwYy6Qdk/ekdYFItQkD4WtHKA73Us5enNhEt5m6NTCuthjd/Cpbtyu5+kv7OMRcoM0i8eRR8/Gvz6W6EChdAQeDISzaxthq6D7W5xH5xhB/S2VecwnKW7UoghuvI3P6yfgHexihdav7nBy2GiEudJcqa9TUy1AnBXjLG8r3o2JtolzY5gWUK02E5B2dKbFGCUbDLCgbwKBwWgXOH60WpO46o4iEbMWO4M5kxikAqcR4J4EAmHLxupQg+52lo8TP4ie7oIGHj7wmwP9YPjrk0awq9t9MSQxUbJT1E0+uRdsKCKeM0RISLM0KdC3ilSbe/2LFge9XE7fMV2ovI
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b4031c6-3cc2-470d-8b33-08d76f12d854
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2019 06:11:43.0595
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gMdDCiDmJFmOASj8Q9Qq9OnXPvAOCfb0xNJJVRuuRu29rNZkTjT3GO+QFhecQDe90sV+M3gd/mg4bSHSbp8WXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4027
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

There should be a sentinel of ulp_div_table, otherwise _get_table_div
may access data out of the array.

Fixes: b1260067ac3d ("clk: imx: add imx7ulp clk driver")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx7ulp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/imx/clk-imx7ulp.c b/drivers/clk/imx/clk-imx7ulp.c
index 3fdf3d494f0a..281191b55b3a 100644
--- a/drivers/clk/imx/clk-imx7ulp.c
+++ b/drivers/clk/imx/clk-imx7ulp.c
@@ -40,6 +40,7 @@ static const struct clk_div_table ulp_div_table[] =3D {
 	{ .val =3D 5, .div =3D 16, },
 	{ .val =3D 6, .div =3D 32, },
 	{ .val =3D 7, .div =3D 64, },
+	{ /* sentinel */ },
 };
=20
 static const int pcc2_uart_clk_ids[] __initconst =3D {
--=20
2.16.4

