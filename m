Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1313C32771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 09:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A5142075D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 09:52:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="VFQedWlx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729926AbgAIJwM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 04:52:12 -0500
Received: from mail-eopbgr140042.outbound.protection.outlook.com ([40.107.14.42]:14702
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729911AbgAIJwK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 04:52:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RwxgrM7xXCWp5cp+MvBPBaVlNYO9rJr0zlZCij5D1UHOxpbEoUeiaeyZzSBv6Rzd3MHzVbrbB7GahDKUi6rMJkXURzfaacXoYUuq3Zxt8h+UX9WFtuezbVQGmO/faXSNWqwo/dgBCPftl8tQc39FETxO60zb5UpqwYyxJlVqGZYHM33xbBHbuATAd2v8dhkyCvpeetMv8CnOpdHNfBUhxpLJ3boPp9B+fYoeXbvr2JDNW6eAe3WbJKkU/IpbUrAFc9KwLT+xaVf0pgR0dpMOrsv4W1LYbgFTPPXFzETJ8WG/2OdVMSBs8m00z4m+hzD0vtdHfrAPHBhp4h6KrY0q/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MIKUhZgICijkrX28JixLRv5pQtUlSzyXjt7NpcozBpE=;
 b=GXVH7OfEFWgt9lLiG/oIGgzYVvRVU9X+3hd/lqSHNYfwXJOwHgHe/u8LCyPJroV+zDKKe0IMFNGrJNWm8MrJkBLu51yV9exW9ru1lKGrtVsTiwb3F4rxLDxq2lC/VEWdREaMp4dFse8qYTNtq8TD3LQZGy1rICupqKRqs+qwZmFg4MBEJrqJpHWKPPhIIblVrCAd1i5NaJjqzjXTHijsCAdoMp8053Ii8o+NUXeELJc6os19k3fxDUt3smpFpBUuVELvOT6PekBWUhvEFRfHpV3bOoXhRfiNtpFfnmXl5UeneZQ7S0xwyrY6UL6t2s1ScThkaVuK+YCiL/BQ+yBrqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MIKUhZgICijkrX28JixLRv5pQtUlSzyXjt7NpcozBpE=;
 b=VFQedWlxaaH1EmkLSpzw3ToNcV9oY9UOJMpCh3tSei2MpSNxSi5UtAwEKGqCaWwSeTTiixSOl+jAwCutkJezpklAjy4pLAQ76efPUwKgVphrdHBz/o6pxGRJbkMk0mgJj3471FErcusFspfjoLjOyRN6MGzYYI1dL7mAnxJoH3I=
Received: from VI1PR04MB4496.eurprd04.prod.outlook.com (20.177.54.92) by
 VI1PR04MB6878.eurprd04.prod.outlook.com (52.133.244.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.10; Thu, 9 Jan 2020 09:52:07 +0000
Received: from VI1PR04MB4496.eurprd04.prod.outlook.com
 ([fe80::25c7:9207:684a:5e2b]) by VI1PR04MB4496.eurprd04.prod.outlook.com
 ([fe80::25c7:9207:684a:5e2b%6]) with mapi id 15.20.2623.010; Thu, 9 Jan 2020
 09:52:07 +0000
Received: from localhost.localdomain (119.31.174.67) by HK2PR02CA0172.apcprd02.prod.outlook.com (2603:1096:201:1f::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2602.12 via Frontend Transport; Thu, 9 Jan 2020 09:52:03 +0000
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
Subject: [PATCH 3/4] clk: imx: imx8mm: use imx8m_clk_hw_core_composite
Thread-Topic: [PATCH 3/4] clk: imx: imx8mm: use imx8m_clk_hw_core_composite
Thread-Index: AQHVxtJ07Eg4kmVY8kOhffTV5CAwEg==
Date:   Thu, 9 Jan 2020 09:52:07 +0000
Message-ID: <1578563269-32710-4-git-send-email-peng.fan@nxp.com>
References: <1578563269-32710-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1578563269-32710-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR02CA0172.apcprd02.prod.outlook.com
 (2603:1096:201:1f::32) To VI1PR04MB4496.eurprd04.prod.outlook.com
 (2603:10a6:803:69::28)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 33e380a7-d40c-43db-6d35-08d794e99692
x-ms-traffictypediagnostic: VI1PR04MB6878:|VI1PR04MB6878:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB6878242DC214AFD8F9FADB0D88390@VI1PR04MB6878.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:361;
x-forefront-prvs: 02778BF158
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(376002)(366004)(346002)(39860400002)(189003)(199004)(6486002)(26005)(4326008)(54906003)(69590400006)(36756003)(6636002)(71200400001)(6506007)(110136005)(52116002)(478600001)(8936002)(6512007)(316002)(16526019)(186003)(86362001)(2616005)(956004)(44832011)(66946007)(66556008)(5660300002)(66446008)(64756008)(2906002)(8676002)(81166006)(66476007)(81156014)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB6878;H:VI1PR04MB4496.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: viODdROdMcIU3l1o2Tdi4pvo9OnBS5BgzmYGuO221RE0WOcZdZmxZ973wrjtvJpl788bgokTVTHUfdGVPC2lPVmvNrJwm60cuQldtBiIVSnCrfa7RS55nzvMIvEhw47Y99CkCF3+J/mBCgsiBCP0xvBwXos/i5LEb2zw4LTWJvi/3eahUs9WmdZA4tw0Y/EMDx4j5Vg/d21Ht5yXkebpe8CnAQydaqirzSmuYNevAk+s8LJy820FulrLpAfj01m5r2yALobaXJSecfNVdppR5v4GCHml9cz5dmy0K+fpsODMCB9RLo9cfsW51DuA923MPkiHVZwDbiWpWTNocijywPT5aTdtSIKf9oHTqlt09TZDHYWl94qDA0toMAp7ZkSZDcpkLLrHx9DP3l4t2vxOWTnY4ipFl+C9GAJ35lwolYpi9jvis0tQKpaFxqTOPL1q4uvusDKV25FD5IGB7HE3TBToTEyuUCsXvPvBF0EgcydYvLvOzgoJiET1YWPgT6l7JCaK1uo9GIoBzMLKLyriVw==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33e380a7-d40c-43db-6d35-08d794e99692
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2020 09:52:07.2542
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cqLRgJ1yCL9zObZZrZb+OEbgLWxFulpifFKjr4ntAjhoBVWEbMKfC/dhWLU5Wk4Pmq3S510CrEGmrYPhDiIvtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6878
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Use imx8m_clk_hw_core_composite to simplify code.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx8mm.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8mm.c b/drivers/clk/imx/clk-imx8mm.c
index 55862652b19f..19883611a5ab 100644
--- a/drivers/clk/imx/clk-imx8mm.c
+++ b/drivers/clk/imx/clk-imx8mm.c
@@ -414,20 +414,13 @@ static int imx8mm_clocks_probe(struct platform_device=
 *pdev)
=20
 	/* Core Slice */
 	hws[IMX8MM_CLK_A53_SRC] =3D imx_clk_hw_mux2("arm_a53_src", base + 0x8000,=
 24, 3, imx8mm_a53_sels, ARRAY_SIZE(imx8mm_a53_sels));
-	hws[IMX8MM_CLK_M4_SRC] =3D imx_clk_hw_mux2("arm_m4_src", base + 0x8080, 2=
4, 3, imx8mm_m4_sels, ARRAY_SIZE(imx8mm_m4_sels));
-	hws[IMX8MM_CLK_VPU_SRC] =3D imx_clk_hw_mux2("vpu_src", base + 0x8100, 24,=
 3, imx8mm_vpu_sels, ARRAY_SIZE(imx8mm_vpu_sels));
-	hws[IMX8MM_CLK_GPU3D_SRC] =3D imx_clk_hw_mux2("gpu3d_src", base + 0x8180,=
 24, 3,  imx8mm_gpu3d_sels, ARRAY_SIZE(imx8mm_gpu3d_sels));
-	hws[IMX8MM_CLK_GPU2D_SRC] =3D imx_clk_hw_mux2("gpu2d_src", base + 0x8200,=
 24, 3, imx8mm_gpu2d_sels,  ARRAY_SIZE(imx8mm_gpu2d_sels));
 	hws[IMX8MM_CLK_A53_CG] =3D imx_clk_hw_gate3("arm_a53_cg", "arm_a53_src", =
base + 0x8000, 28);
-	hws[IMX8MM_CLK_M4_CG] =3D imx_clk_hw_gate3("arm_m4_cg", "arm_m4_src", bas=
e + 0x8080, 28);
-	hws[IMX8MM_CLK_VPU_CG] =3D imx_clk_hw_gate3("vpu_cg", "vpu_src", base + 0=
x8100, 28);
-	hws[IMX8MM_CLK_GPU3D_CG] =3D imx_clk_hw_gate3("gpu3d_cg", "gpu3d_src", ba=
se + 0x8180, 28);
-	hws[IMX8MM_CLK_GPU2D_CG] =3D imx_clk_hw_gate3("gpu2d_cg", "gpu2d_src", ba=
se + 0x8200, 28);
 	hws[IMX8MM_CLK_A53_DIV] =3D imx_clk_hw_divider2("arm_a53_div", "arm_a53_c=
g", base + 0x8000, 0, 3);
-	hws[IMX8MM_CLK_M4_DIV] =3D imx_clk_hw_divider2("arm_m4_div", "arm_m4_cg",=
 base + 0x8080, 0, 3);
-	hws[IMX8MM_CLK_VPU_DIV] =3D imx_clk_hw_divider2("vpu_div", "vpu_cg", base=
 + 0x8100, 0, 3);
-	hws[IMX8MM_CLK_GPU3D_DIV] =3D imx_clk_hw_divider2("gpu3d_div", "gpu3d_cg"=
, base + 0x8180, 0, 3);
-	hws[IMX8MM_CLK_GPU2D_DIV] =3D imx_clk_hw_divider2("gpu2d_div", "gpu2d_cg"=
, base + 0x8200, 0, 3);
+
+	hws[IMX8MM_CLK_M4_DIV] =3D imx8m_clk_hw_core_composite("arm_m4_div", imx8=
mm_m4_sels, base + 0x8080);
+	hws[IMX8MM_CLK_VPU_DIV] =3D imx8m_clk_hw_core_composite("vpu_div", imx8mm=
_vpu_sels, base + 0x8100);
+	hws[IMX8MM_CLK_GPU3D_DIV] =3D imx8m_clk_hw_core_composite("gpu3d_div", im=
x8mm_gpu3d_sels, base + 0x8180);
+	hws[IMX8MM_CLK_GPU2D_DIV] =3D imx8m_clk_hw_core_composite("gpu2d_div", im=
x8mm_gpu2d_sels, base + 0x8200);
=20
 	/* BUS */
 	hws[IMX8MM_CLK_MAIN_AXI] =3D imx8m_clk_hw_composite_critical("main_axi", =
 imx8mm_main_axi_sels, base + 0x8800);
--=20
2.16.4

