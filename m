Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AAA3ECE58C
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 03:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B718217F9
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 03:17:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qJ2Q9gg8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbfJODR2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 23:17:28 -0400
Received: from mail-eopbgr60055.outbound.protection.outlook.com ([40.107.6.55]:48140
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727057AbfJODR1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 23:17:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NG2mh9M0R6N98gPGK4/Rix/wadrspB64aF+RGrUoO8D93MYip4FfQHAZmRm7KqYUj/cMZOiXPkk+H7lLkyU0+gN9tAKqf4pqPz83OF0jAdGzrxwqEnKK6sy8Vjon08mZedbsexzzhWsJADK4Ye0zp4BouLft9j1iH7CtkTkPL2gLt9rpY3OvJllXQhwtemv4T6frvKWpj2+DSaAk8a8vFUCLpRpURtS1E9tLrpGrzQkMdRt9kZMrXGgs/tb+IE1kasCuMImzXFV6qBrwwOG4odPE7tA+XcvMou7fT52Ufaw04WIFpuYU2tQMF4ts2s3Hi10ZfmVO7xaaZGGMr3cq0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3u+P9CUuutKWCr8RCJl3AMLDlv+eO47P9CwMwk8VnNw=;
 b=Mu61mQ3eushC+l0GeMQBYeDx5Q1ypvBNg8FVBXsXqZuT9iTzvvgqLx+Qcb30rcSyfnJYvAFi73wSIHiNGdkz/l3g0BjFK6zEuOTesIfP0DRyVhEOdbnF3ay8akdlxvnrUad7NX3aMWQwUdS8QeYlactNN4RAsVPRZbepUI07FOvNe2wLmeA4VFLEWQRdkwwcbaTsq2Z7i176oSX4yGisiyb+4Y/fuKtTkYQYt73V+eYlZ2QYs+WXFFMciERR9Uzdg8ko/2d7p94Q31xMrpkX0KSrlx3Tv1zfdcjKvW2M/TKaFPGB1hYJEC06Ws4yED++VanmPfK0aAaQhbKcSl4YcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3u+P9CUuutKWCr8RCJl3AMLDlv+eO47P9CwMwk8VnNw=;
 b=qJ2Q9gg8tS5Q1RCcDQozGsxJVv63MH8AAzT+SsCWLIEZyD+l6f12JTyY8wuiwR0m07HrH/kavv/10AnWCTWBbCWLhNI4Jzl3b05SioVAflyt5KZZ4y2RixdozelpmaN54gnqEm9Nvftthg26UMih8+48Ov8j+qEMY9PYArk+QDU=
Received: from AM6PR04MB4936.eurprd04.prod.outlook.com (20.177.34.20) by
 AM6PR04MB5414.eurprd04.prod.outlook.com (20.178.95.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Tue, 15 Oct 2019 03:17:23 +0000
Received: from AM6PR04MB4936.eurprd04.prod.outlook.com
 ([fe80::79b4:252:8bba:c88c]) by AM6PR04MB4936.eurprd04.prod.outlook.com
 ([fe80::79b4:252:8bba:c88c%6]) with mapi id 15.20.2347.023; Tue, 15 Oct 2019
 03:17:23 +0000
From:   Fancy Fang <chen.fang@nxp.com>
To:     "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH v3] clk: imx7ulp: do not export out IMX7ULP_CLK_MIPI_PLL clock
Thread-Topic: [PATCH v3] clk: imx7ulp: do not export out IMX7ULP_CLK_MIPI_PLL
 clock
Thread-Index: AQHVgwcPc0jqN29IB0OYPLGVX+dhGA==
Date:   Tue, 15 Oct 2019 03:17:23 +0000
Message-ID: <20191015031501.2703-1-chen.fang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-clientproxiedby: HK2PR03CA0060.apcprd03.prod.outlook.com
 (2603:1096:202:17::30) To AM6PR04MB4936.eurprd04.prod.outlook.com
 (2603:10a6:20b:8::20)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=chen.fang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b50d3614-cc04-4487-6512-08d7511e3263
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: AM6PR04MB5414:|AM6PR04MB5414:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB54149713D8037006822C07AFF3930@AM6PR04MB5414.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 01917B1794
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(366004)(396003)(39860400002)(346002)(189003)(199004)(54534003)(99286004)(54906003)(26005)(7736002)(186003)(8936002)(52116002)(25786009)(6486002)(6512007)(386003)(6506007)(2906002)(2501003)(81166006)(50226002)(6436002)(1076003)(102836004)(256004)(8676002)(71190400001)(71200400001)(478600001)(81156014)(86362001)(4326008)(36756003)(305945005)(110136005)(2616005)(66556008)(64756008)(66446008)(66066001)(316002)(66946007)(66476007)(476003)(14454004)(5660300002)(486006)(6116002)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5414;H:AM6PR04MB4936.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3ftyLwbBo/4E9niyrfVEN44Zq4Ek32Nc7uXy1rf4JBeiOZLscDJmGoKSYHUdenAc2ZIoiS29x7wSwRIR1Gzj0bND5s93gWrbu5xWGozw2v0pIexkcM/AYtv2UkH7eegZ5X44urPmHz3OVzd/Ltue2YYY4nTUMb5bB0nVAmjhq70udvHFoEx3/8wZ0XERec1EE3mZ8PqR+TM1LfTyHed/w2Rdj9ZVMrMKWvIPO+jzcoA4Wq05MPh4KsCMrQL33FYoMTzc5pQpT62zbql0fOm+yduaPPsW1VaWbACK+qacU7KYSQDZ9T0ji9PB57l6bW8VjFmixsPWMVORm8dEpl+v1mQ1cE7kCBXh8kbPqd6UCzJ3gW2r1xXpjlRq2pPJ16igE72PjHlmykhnZ+s2iQlJkj6xTtCdAX6QrYOLKgd0yg4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b50d3614-cc04-4487-6512-08d7511e3263
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2019 03:17:23.5456
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WF9dOQn2o+cZRmkXv2gmNKcyFiAZL4L7kltw577Lv8V2DKECrOuxku1hKbCXO7ec2qoEe6UYRbVTH7Q4+AdPWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5414
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mipi pll clock comes from the MIPI PHY PLL output, so
it should not be a fixed clock.

MIPI PHY PLL is in the MIPI DSI space, and it is used as
the bit clock for transferring the pixel data out and its
output clock is configured according to the display mode.

So it should be used only for MIPI DSI and not be exported
out for other usages.

Signed-off-by: Fancy Fang <chen.fang@nxp.com>
---
ChangeLog v2->v3:
 * Keep 'IMX7ULP_CLK_MIPI_PLL' macro definition.

ChangeLog v1->v2:
 * Keep other clock indexes unchanged as Shawn suggested.

 Documentation/devicetree/bindings/clock/imx7ulp-clock.txt | 1 -
 drivers/clk/imx/clk-imx7ulp.c                             | 3 +--
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/imx7ulp-clock.txt b/Do=
cumentation/devicetree/bindings/clock/imx7ulp-clock.txt
index a4f8cd478f92..93d89adb7afe 100644
--- a/Documentation/devicetree/bindings/clock/imx7ulp-clock.txt
+++ b/Documentation/devicetree/bindings/clock/imx7ulp-clock.txt
@@ -82,7 +82,6 @@ pcc2: pcc2@403f0000 {
 		 <&scg1 IMX7ULP_CLK_APLL_PFD0>,
 		 <&scg1 IMX7ULP_CLK_UPLL>,
 		 <&scg1 IMX7ULP_CLK_SOSC_BUS_CLK>,
-		 <&scg1 IMX7ULP_CLK_MIPI_PLL>,
 		 <&scg1 IMX7ULP_CLK_FIRC_BUS_CLK>,
 		 <&scg1 IMX7ULP_CLK_ROSC>,
 		 <&scg1 IMX7ULP_CLK_SPLL_BUS_CLK>;
diff --git a/drivers/clk/imx/clk-imx7ulp.c b/drivers/clk/imx/clk-imx7ulp.c
index 2022d9bead91..459b120b71d5 100644
--- a/drivers/clk/imx/clk-imx7ulp.c
+++ b/drivers/clk/imx/clk-imx7ulp.c
@@ -28,7 +28,7 @@ static const char * const scs_sels[]		=3D { "dummy", "sos=
c", "sirc", "firc", "dumm
 static const char * const ddr_sels[]		=3D { "apll_pfd_sel", "upll", };
 static const char * const nic_sels[]		=3D { "firc", "ddr_clk", };
 static const char * const periph_plat_sels[]	=3D { "dummy", "nic1_bus_clk"=
, "nic1_clk", "ddr_clk", "apll_pfd2", "apll_pfd1", "apll_pfd0", "upll", };
-static const char * const periph_bus_sels[]	=3D { "dummy", "sosc_bus_clk",=
 "mpll", "firc_bus_clk", "rosc", "nic1_bus_clk", "nic1_clk", "spll_bus_clk"=
, };
+static const char * const periph_bus_sels[]	=3D { "dummy", "sosc_bus_clk",=
 "dummy", "firc_bus_clk", "rosc", "nic1_bus_clk", "nic1_clk", "spll_bus_clk=
", };
 static const char * const arm_sels[]		=3D { "divcore", "dummy", "dummy", "=
hsrun_divcore", };
=20
 /* used by sosc/sirc/firc/ddr/spll/apll dividers */
@@ -75,7 +75,6 @@ static void __init imx7ulp_clk_scg1_init(struct device_no=
de *np)
 	clks[IMX7ULP_CLK_SOSC]		=3D imx_obtain_fixed_clk_hw(np, "sosc");
 	clks[IMX7ULP_CLK_SIRC]		=3D imx_obtain_fixed_clk_hw(np, "sirc");
 	clks[IMX7ULP_CLK_FIRC]		=3D imx_obtain_fixed_clk_hw(np, "firc");
-	clks[IMX7ULP_CLK_MIPI_PLL]	=3D imx_obtain_fixed_clk_hw(np, "mpll");
 	clks[IMX7ULP_CLK_UPLL]		=3D imx_obtain_fixed_clk_hw(np, "upll");
=20
 	/* SCG1 */
--=20
2.17.1

