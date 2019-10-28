Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9135CC47E49
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 03:08:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65EDF21848
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 03:08:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="I02UjrYF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729983AbfJ1DIi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 23:08:38 -0400
Received: from mail-eopbgr00077.outbound.protection.outlook.com ([40.107.0.77]:64422
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727330AbfJ1DIi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 23:08:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eCBQSdkpDKEitmPb4sOqVYM1x6JnVNHPJbnXztBqSdCrTaIHUhLzFeugInTF91/wYkHMhUvN0Zoyeh6ngDuupSJYpU/Zj9zd1ttmoup66M0rc0Vbnkj877eRqWfVaYQkdhlsTcxcz3JOeLSiqFUqgFxbdROBPu8VDqXNxtVyHuz2xLb7sJhzG6lyJVqo7Gf/zy3W2S7TzT+ZiTYxvxMkOw5shsWXmPaWn0n1FgSM+S9jloQyvGxBeuITejg0qkboNWJLo39fZaH98zIA7MJHaIL6M/8xGw36pnDE0+ZjLbP26/j0BnB9JQtVGwgvTvIB+RH58mxkQexJrYHbeZA2Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZLwty+gNlF9aQuCrrGlwaOCKhwe8h9kIiNLELyz3zS8=;
 b=d51KntHgxmxGbxiWeh8zDkebywr5ejcAzAFM514mAuJgkQH265zk27SQH9Os0D0VYGMxPespD+I3v2XEklx6FCr0lbAWvU+fN6HwiaSGhplD+3lNboDwn38KjjDSNF0xC91JYFriyHyLaBiqAupKjpdtlbUtJ0Diot5XhrTzc2DoqotbnkVfDUaEpFu7vjGsqiS+1/5idBaJkQu9AP5e66RCXhkT18ZaJoZVAFKRI/zJNH3UibbjLXROIWKNHfXHv4pvR/BeBDUekgDElgwe59W/Ods9UIalxpQ9joBUlcbbo1Sil5h8/85nr2uaeVBhoMqP7FKGPtnJyQ0TGqGlyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZLwty+gNlF9aQuCrrGlwaOCKhwe8h9kIiNLELyz3zS8=;
 b=I02UjrYFuwKUNoy2JsTjP3Fj7Hwzha/5/ItMNTKQIH9FYNv2WjRpLZg0MGEDMnhDHZH745Fs9PXIa00nm4MyxWWtZQ5wr/8h8pk8wFjj3BNsFfNrrFxbIZxL6teotkPGgI3tejdb4RoZxQlIXjOgGF6gybTwGHLRNpB77P2apBg=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5667.eurprd04.prod.outlook.com (20.178.119.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.22; Mon, 28 Oct 2019 03:08:34 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::843c:e722:27cb:74e1]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::843c:e722:27cb:74e1%5]) with mapi id 15.20.2387.023; Mon, 28 Oct 2019
 03:08:34 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
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
Subject: [PATCH V2] clk: imx: imx8mq: fix sys3_pll_out_sels
Thread-Topic: [PATCH V2] clk: imx: imx8mq: fix sys3_pll_out_sels
Thread-Index: AQHVjTz7lchDB1BYpky6rmS85b14tA==
Date:   Mon, 28 Oct 2019 03:08:34 +0000
Message-ID: <1572231902-30230-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0064.apcprd03.prod.outlook.com
 (2603:1096:203:52::28) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b19f7ace-f013-416f-5e97-08d75b541e39
x-ms-traffictypediagnostic: AM0PR04MB5667:|AM0PR04MB5667:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB5667665DBA307BA05129515888660@AM0PR04MB5667.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1060;
x-forefront-prvs: 0204F0BDE2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(376002)(366004)(39860400002)(136003)(199004)(189003)(99286004)(110136005)(6636002)(25786009)(186003)(102836004)(4326008)(36756003)(2616005)(14454004)(486006)(2501003)(44832011)(2906002)(66066001)(52116002)(6116002)(3846002)(476003)(6506007)(386003)(26005)(6486002)(6512007)(81156014)(6436002)(5660300002)(81166006)(316002)(8676002)(7736002)(71190400001)(71200400001)(305945005)(86362001)(66946007)(64756008)(66476007)(66556008)(50226002)(478600001)(256004)(14444005)(8936002)(2201001)(54906003)(66446008)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5667;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J0Uz83wK47vqyBBJddU8iMB72nu+fWyErPm6YjFqNXs6c4ZnGbDeodGp5HD5+MCKWXC2tLHgVDQNTg1tkdv554zx9z7uruc9bws1/FzAZkim782xgUmIU+Xyf7VryRJmqw9gOATbz28x1dBNY7wq27/yXqSehESGuJtvQQs6z5BMB6qYPrez1uHJKn1AfHOFoBEbpD7eh0cUmoaD6brlpFoLzD2pebJuDpKmVMXOEPpvp0nIsja1zfgtL+0L2AKh47YJK4Nr/5bJlPY2Xh+KvytRmCvxtRpnMhZGYuHIQ30rUdC7t4g036Tk6JmW7b5Rlurvoid+DyzBiQnDWmarJhkMROYZfLM0xM9hScmvdvBbvzNYwk1yxZGfhTcXAlFaQEeOfYkb19tOBaCOmtWsV6CVl6QAldWNBf0Tbq6HFuDs0JueVHgnO3m+KpJtHhjL
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b19f7ace-f013-416f-5e97-08d75b541e39
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2019 03:08:34.0350
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pKHHI1b8+d5j+8eEnI8oFH+rWBL4R+mx7C9Jf31n0q/Tw+jlw44stTT+8zVUdsEKPXHw97OHv/M/A9IvANTUVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5667
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

It is not correct that sys3_pll_out use sys2_pll1_ref_sel as parent.

According to the current imx_clk_sccg_pll design, it uses both
bypass1/2, however set bypass2 as 1 is not correct, because it will
make sys[x]_pll_out use wrong parent and might access wrong registers.

So correct bypass2 to 0 and fix sys3_pll_out_sels.

Fixes: e9dda4af685f ("clk: imx: Refactor entire sccg pll clk")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V2:
 Rebased on Shawn's clk/imx tree to avoid conflicts

 drivers/clk/imx/clk-imx8mq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8mq.c b/drivers/clk/imx/clk-imx8mq.c
index 4a5dbc4366a5..5f10a606d836 100644
--- a/drivers/clk/imx/clk-imx8mq.c
+++ b/drivers/clk/imx/clk-imx8mq.c
@@ -34,7 +34,7 @@ static const char * const audio_pll1_bypass_sels[] =3D {"=
audio_pll1", "audio_pll1_
 static const char * const audio_pll2_bypass_sels[] =3D {"audio_pll2", "aud=
io_pll2_ref_sel", };
 static const char * const video_pll1_bypass_sels[] =3D {"video_pll1", "vid=
eo_pll1_ref_sel", };
=20
-static const char * const sys3_pll_out_sels[] =3D {"sys3_pll1_ref_sel", "s=
ys2_pll1_ref_sel", };
+static const char * const sys3_pll_out_sels[] =3D {"sys3_pll1_ref_sel", };
 static const char * const dram_pll_out_sels[] =3D {"dram_pll1_ref_sel", };
 static const char * const video2_pll_out_sels[] =3D {"video2_pll1_ref_sel"=
, };
=20
@@ -342,7 +342,7 @@ static int imx8mq_clocks_probe(struct platform_device *=
pdev)
=20
 	clks[IMX8MQ_SYS1_PLL_OUT] =3D imx_clk_fixed("sys1_pll_out", 800000000);
 	clks[IMX8MQ_SYS2_PLL_OUT] =3D imx_clk_fixed("sys2_pll_out", 1000000000);
-	clks[IMX8MQ_SYS3_PLL_OUT] =3D imx_clk_sccg_pll("sys3_pll_out", sys3_pll_o=
ut_sels, ARRAY_SIZE(sys3_pll_out_sels), 0, 0, 1, base + 0x48, CLK_IS_CRITIC=
AL);
+	clks[IMX8MQ_SYS3_PLL_OUT] =3D imx_clk_sccg_pll("sys3_pll_out", sys3_pll_o=
ut_sels, ARRAY_SIZE(sys3_pll_out_sels), 0, 0, 0, base + 0x48, CLK_IS_CRITIC=
AL);
 	clks[IMX8MQ_DRAM_PLL_OUT] =3D imx_clk_sccg_pll("dram_pll_out", dram_pll_o=
ut_sels, ARRAY_SIZE(dram_pll_out_sels), 0, 0, 0, base + 0x60, CLK_IS_CRITIC=
AL);
 	clks[IMX8MQ_VIDEO2_PLL_OUT] =3D imx_clk_sccg_pll("video2_pll_out", video2=
_pll_out_sels, ARRAY_SIZE(video2_pll_out_sels), 0, 0, 0, base + 0x54, 0);
=20
--=20
2.16.4

