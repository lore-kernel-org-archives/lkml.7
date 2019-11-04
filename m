Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26910CA9ED2
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 08:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB8DE222CD
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 08:19:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="KdoI2/vv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbfKDITk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 03:19:40 -0500
Received: from mail-eopbgr10065.outbound.protection.outlook.com ([40.107.1.65]:21895
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726441AbfKDITk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 03:19:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WBIFOptkWEk2amk+Ss5fJG34/X5+bgfY5zIA+KV4/Ep4ZStUvusbENrtmPrp/XYUQC2ZmF7+nJkb6ctx3LFlESRTAXEH8UcEiJjQ87Uep1TWUnU1ymLJpoB1ELKCzgUPyScROsFJGZRJDKMW3ndVFlgRhxt60VoUwo4eSozQRRFQW5BteNSQ8RTwA5MF/rqle9NF7c8LnOlnxrkwsysAyJjnb53zW5rekbdYP5ZIERQUMOkgj4dNbnmFDhSSf3Q3bsPD1EdcU5Cfhg74TUrxvb4P9D/ziai2bP7gYm933yDG60cdOIbTlPXKEx15R+ySvrssOnGf8QmtavN5qFmlAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=woOEwPZT9X/FUZEnx3QG6yv093CcOEuSuT8J51eubZA=;
 b=YEtOjZwcEANp021oH4biBdjOtFYUMUd9u5bvrPFjp20sg1qqS8oIn2ryv474TJ7kaA6SakzRBO8VI117zh9E8k3jv0q0X+8CxLVzfpEuRJ6RlJM84ogVUf5PqedVU1aZkmYylMAEipZgEtxeBCFx3+GTH6+9sGRbPbIjoK6UdAefJ6IWOGjvMdsHO8LngzqYpqO4vgRJ5qCp4AxH4WpueXcmZv4WQ8RNDkyOx1NV7hCaSTjUNhFc5SZxmynSZcMOVyFF98awySBGCQiE8+6nhZnR7mm9cj8hnGU7wP/Pioew4T4+Q0EHTEeUNHkNnoQjK2tea9Q3kuAHipK+vts1Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=woOEwPZT9X/FUZEnx3QG6yv093CcOEuSuT8J51eubZA=;
 b=KdoI2/vv4EBiY/JSWxsybNicRHnIrto1znyhyp9dSPyDYUY404K7CEeq/ZJq3+cpQnMuLAYKHXR0l8fEiJOseDuX+WEXw32vfOtLJCandXBEQbkdUdaIX179/TZG+/R8xzOOumojh61c9j04u/38xjX+AobxxBoPCHhNQUNHc9k=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6212.eurprd04.prod.outlook.com (20.179.36.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Mon, 4 Nov 2019 08:19:33 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::f16d:a26a:840:f97c]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::f16d:a26a:840:f97c%4]) with mapi id 15.20.2408.024; Mon, 4 Nov 2019
 08:19:33 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Abel Vesa <abel.vesa@nxp.com>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] clk: imx: imx8mn: add IMX8MN_CLK_SAI7_IPG clk
Thread-Topic: [PATCH] clk: imx: imx8mn: add IMX8MN_CLK_SAI7_IPG clk
Thread-Index: AQHVkuiWYOV+kg2wl0yC3cmY9ucIdQ==
Date:   Mon, 4 Nov 2019 08:19:33 +0000
Message-ID: <1572855483-10624-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR01CA0036.apcprd01.prod.exchangelabs.com
 (2603:1096:203:3e::24) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cc3181e7-fcc3-478e-3d9d-08d760ffb8ff
x-ms-traffictypediagnostic: AM0PR04MB6212:|AM0PR04MB6212:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB62120C95DE6C68860D63ED83887F0@AM0PR04MB6212.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-forefront-prvs: 0211965D06
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(346002)(366004)(136003)(376002)(199004)(189003)(2906002)(305945005)(7736002)(66066001)(256004)(25786009)(3846002)(6116002)(81166006)(2616005)(186003)(476003)(26005)(2201001)(52116002)(6486002)(316002)(81156014)(86362001)(54906003)(44832011)(50226002)(99286004)(8936002)(110136005)(66556008)(66476007)(6636002)(5660300002)(102836004)(4326008)(8676002)(486006)(6512007)(6436002)(14454004)(36756003)(478600001)(71200400001)(6506007)(71190400001)(386003)(64756008)(66446008)(2501003)(66946007)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6212;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SoUjoZNrZYSM42Oh0Xgca1xIFLRn1+dfQGHYpCaGXtN2EYMuILbAPgvMlLDUQlBr6i/ars2fkgXJSGzqSTp2ZbcT7f13vb/KP7j/74EERpdLo4sSOrEXOUeUq+H4t821mYOA/8/HRhzi5WQJyLil6fOdmDlLQOg27gAJMxFk/MBkACYY3QMjW7A95hahXOwAk+E2U7/u1DTX+1EUefORF82fyJ32UqwER1F+BhRiG2GzKpcqVEUPrxd/L9Vbv95xo3JR/2B1KKnDh6wBh7sBIegAxwHbU4ZCWY4xVNJIL+dBroN/7Zal9TT2bv6oRkJ1augMrb3/4/ZMkpdfsqP6sfdDOFC0fTU8BuZo31PqvFaPDyzdd0xSlKxxX0dyX7yRJMbYORssjB+gE7t9Ki3YlxDTNsBHjjGvPFaJ2j5fgwMU+5yQoCMjarBWgTf2OkeD
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc3181e7-fcc3-478e-3d9d-08d760ffb8ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2019 08:19:33.6954
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zokdg3ow+NFgmQrVm2x/+1tu95CPVUI6pme2n9ADzPyJdRLa6PUZftLoCDJ5GOCV49xtL9jPulqbC+jVujx0sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6212
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

It does not make sense to use shared count for IMX8MN_CLK_SAI7_ROOT
without ipg clk. Actually there are ipg clks for other sai clks,
let's add IMX8MN_CLK_SAI7_IPG clk.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx8mn.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx8mn.c
index 838f6e2347f1..5e801892c631 100644
--- a/drivers/clk/imx/clk-imx8mn.c
+++ b/drivers/clk/imx/clk-imx8mn.c
@@ -556,6 +556,7 @@ static int imx8mn_clocks_probe(struct platform_device *=
pdev)
 	clks[IMX8MN_CLK_SDMA2_ROOT] =3D imx_clk_hw_gate4("sdma2_clk", "ipg_audio_=
root", base + 0x43b0, 0);
 	clks[IMX8MN_CLK_SDMA3_ROOT] =3D imx_clk_hw_gate4("sdma3_clk", "ipg_audio_=
root", base + 0x45f0, 0);
 	clks[IMX8MN_CLK_SAI7_ROOT] =3D imx_clk_hw_gate2_shared2("sai7_root_clk", =
"sai7", base + 0x4650, 0, &share_count_sai7);
+	clks[IMX8MN_CLK_SAI7_IPG] =3D imx_clk_hw_gate2_shared2("sai7_ipg_clk", "i=
pg_audio_root", base + 0x4650, 0, &share_count_sai7);
=20
 	clks[IMX8MN_CLK_DRAM_ALT_ROOT] =3D imx_clk_hw_fixed_factor("dram_alt_root=
", "dram_alt", 1, 4);
=20
--=20
2.16.4

