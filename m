Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A925CCA9ECF
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 05:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73B79222CD
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 05:46:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="oTFgvoAT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbfKDFqL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 00:46:11 -0500
Received: from mail-eopbgr40046.outbound.protection.outlook.com ([40.107.4.46]:60011
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727771AbfKDFqK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 00:46:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=befiu6mDXcU8Xx15Pm3tVdPtyBRZS1tinJKNx374UZk5qR3B4m2Qd/QMbSPnGr98O4v2iBwlUqdT6TXfL+fTfdTi5+y4C/RIy5M+LY75y/U9iQTqVWhMjzNR0MesBr8/fq3iHOX/xpG2YCYyLiZdiOCwGvjeLPQLM2stIZ3jBduOUnvDHVoZfrH+clmFg7g03qfdTlJM92+kpbxYrgKw2AJZ4YPFQ2dUL4RTe4CrdbtAUro157I75aiGTXNegWrckatSaS/BpTMMcC0EeZqemB/C7XcG98+iV8GWe8SFJ0iTnr7S8VPz+T+lsSQNUtejfxKd6hfmx+7/NpMdTOhE8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=127ZqZr3yibLEGADIDwdS92koh1Pj0RZ3R7B7s2PvMA=;
 b=mjMGKtM8CSdQtZ3gPz7NXzVRjzKSJwvbatAup4nqNYQvr1DiOcMqMVWNmIAvsemL0BO8BnniOXU72fiHaPg2acC6eZAvCVnCFVF2gV6htqi93aZGIUJL0Bwj36KvBrrxxSbcCVJ50sDSRDmlO6KlIH6kzgGaIyogFIAlMyyTCQyAm8bqojmaBr5ZuZ1CYOqDM2YPRmcG2PUx+ett+cyqfm4vm5vugPUyFRYFn5y3tgzGzbUtR0YdESUgMTCX66tv+WnOMd0rIwqA3HDPdnoBff41FXx/FFju8RtwANJO0e9WxVPK/HrwVklmHu9WqlwL+TctTx7v6LOYntvwpxpSXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=127ZqZr3yibLEGADIDwdS92koh1Pj0RZ3R7B7s2PvMA=;
 b=oTFgvoATujPgmTfT4ug+XkRGiinqIo5SWKr5+tM2fLk60TimoZYAIIHHeFCT7LhvBV4lFsRK683hfd3BE0V+aAwQZAYyPQgZBIo+FvquelyAi2VPZdaYIftup3bVcXXxdox1SIsc8hAIf9nKw/7I1XFM3tj20NLpY4xMawu0cbA=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6451.eurprd04.prod.outlook.com (20.179.252.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Mon, 4 Nov 2019 05:46:07 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::f16d:a26a:840:f97c]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::f16d:a26a:840:f97c%4]) with mapi id 15.20.2408.024; Mon, 4 Nov 2019
 05:46:07 +0000
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
Subject: [PATCH V2 1/4] clk: imx: Remove __init for imx_obtain_fixed_clk_hw()
 API
Thread-Topic: [PATCH V2 1/4] clk: imx: Remove __init for
 imx_obtain_fixed_clk_hw() API
Thread-Index: AQHVktMnGVylTOmyPky7I+IXKHDRpA==
Date:   Mon, 4 Nov 2019 05:46:07 +0000
Message-ID: <1572846270-24375-2-git-send-email-peng.fan@nxp.com>
References: <1572846270-24375-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1572846270-24375-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0110.apcprd03.prod.outlook.com
 (2603:1096:203:b0::26) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ea94b1b7-3fa9-4ec3-badd-08d760ea4995
x-ms-traffictypediagnostic: AM0PR04MB6451:|AM0PR04MB6451:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB64518D738AC45CA3E9C1DF72887F0@AM0PR04MB6451.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:597;
x-forefront-prvs: 0211965D06
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(366004)(136003)(396003)(376002)(189003)(199004)(386003)(4744005)(6486002)(36756003)(66446008)(476003)(6512007)(2501003)(8676002)(2616005)(256004)(26005)(50226002)(316002)(2201001)(6116002)(6636002)(3846002)(14454004)(6436002)(64756008)(11346002)(66946007)(71190400001)(71200400001)(66556008)(66476007)(478600001)(4326008)(2906002)(102836004)(86362001)(76176011)(186003)(305945005)(7736002)(8936002)(25786009)(54906003)(66066001)(99286004)(486006)(44832011)(5660300002)(446003)(81156014)(81166006)(52116002)(110136005)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6451;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CPMbxo6lfKuJCePra66PlIrmYBLyDgJF2A7ISopXfufeUS5fnhtuoSEGBVbG9zvWCfOgoYhDWQ0xpIAOS9mvmUHlZ1X97z6K6emRvq19X7vQQza41b7T/4zwsP2meWWvwqmbb8JWlN+R08ncqkLyejOgmKSBgyy3Qgd0O0HO590JB5Ke9xd1ed03Ak3CF+lyv3FbR1MzDvqIOU0XqJXrD0H79ZloxbLFU4aXXyuGTyb7qV0Wh2/ndx1tqNRQndtqLGEil+fzGTuJCwki+DQQO9n7opbM+fXbDkNaaFpUdR1hiLCZYJ/EPnAHCznhPeh8a3sm+rGU3mdnUmsTZRbKO6XesGIAy68LbbPqBUfIMz2+wZrR+qaXy6Sde+Bw9/2VN7osz2j9rjSx+0eOuXWY7qXo4+LgvHD3lGRVjfeAXtlHGQMhdSPvuUWsdCejcNlZ
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea94b1b7-3fa9-4ec3-badd-08d760ea4995
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2019 05:46:07.3515
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O4ZBFDsEzsm96uUOxzzAmTfqf61o9/0xVaFTU+ZbjvJEp6jQvY2md/4CNzGrge85eDI6UbNavifbk5HIiCuDmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6451
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

