Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68311C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 02:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3012822B48
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 02:59:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ar3zGG8Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbfLLC7f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 21:59:35 -0500
Received: from mail-eopbgr60065.outbound.protection.outlook.com ([40.107.6.65]:2682
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727472AbfLLC7c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 21:59:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bZZ7AB2cKiat6cMzw4+pKb6dPJbK2BXOswd/0I6iWxVPtBMuwuSd6BhgMMQeNDBIie5hvWHHTd43rzknqLf3PJ9Gw1W8FioCHRyy2QMh+LMaIsFdI6611W9YRKO+OW59LUH0ENCyI9BbhBmeXDtnd9dTIpQYPshpQE9bHTuL7QCMJ35LAol+pCgP8Ksfcu9kdWHQ+dUHvQZHU88uOyWafiqJzlZ+83Bu8Ub1EjqAnbhBJpUNKVbIrKJPU/I/ZpxGYxW7Hz6NhaayNBeP61xq3xFzWuZXc3cTkhqVYvByXcbBEroLm4Q3pLkFSkWaVmVdCkpZwkHblUkGa2okWczLDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NdMtZnMiQ6ShimXBpJCJMex9hCe7iXPibZaNgDSF/X0=;
 b=g4JTG8GSposTxHv4RFEWKKeBId0nRxSQDEgm4V6nzSMmjN/+SwCUZq2pv7c6ju7OKb52X80L0kjTUK/gK9hzMuHiPZPAYo1p/YutcNx+6Pu77NknLKlWuCtAYiN79De4tfBZv2Bg+15rRnOp/N4YKXMsVlbttVNtV32j3k6tmPfYJWmmlmIUMAOMUtQGJ/GUvddGDPPK5RN/yJkuevwsG6DGhSI3iHuG4i7pFyL4TLaGAYmudDREiVg7Dt+j/qMQnz3N4CNuMyoYDtWsg2XyNFwppQ5c3tJJ5wS2kXt8CRGJ0W83HlltBTY9qYAygMQg+PLdr7la/MOuncDUibUxvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NdMtZnMiQ6ShimXBpJCJMex9hCe7iXPibZaNgDSF/X0=;
 b=ar3zGG8YHoB3M6Cz+TUOXM9m0IdyFVVgeMIatL2mtfo2R11aGGGH8Oan+ES/M2YXfB1u0iGQxvkva79P5VCadyXJflFU7wxciNUXLHoePDFDtxDswcEFityLfzm3U7HlpDb4TsX7InsD3WZjAMVGzUE3OJcCZkLPYO9w1JfE+8w=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6196.eurprd04.prod.outlook.com (20.179.34.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Thu, 12 Dec 2019 02:59:04 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::505:87e7:6b49:3d29]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::505:87e7:6b49:3d29%7]) with mapi id 15.20.2538.017; Thu, 12 Dec 2019
 02:59:04 +0000
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
Subject: [PATCH V2 5/9] clk: imx: gate3: Switch to clk_hw based API
Thread-Topic: [PATCH V2 5/9] clk: imx: gate3: Switch to clk_hw based API
Thread-Index: AQHVsJgd+KHoh+Od+k6savbze6AFKQ==
Date:   Thu, 12 Dec 2019 02:59:04 +0000
Message-ID: <1576119353-26679-6-git-send-email-peng.fan@nxp.com>
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
x-ms-office365-filtering-correlation-id: fa648a4d-31ea-4d6d-f884-08d77eaf3f7b
x-ms-traffictypediagnostic: AM0PR04MB6196:|AM0PR04MB6196:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB6196A34677B82062B6E40D2588550@AM0PR04MB6196.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-forefront-prvs: 0249EFCB0B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(346002)(366004)(39860400002)(376002)(199004)(189003)(81156014)(8936002)(316002)(81166006)(8676002)(36756003)(52116002)(478600001)(6512007)(6486002)(71200400001)(110136005)(54906003)(86362001)(186003)(66476007)(4326008)(5660300002)(2906002)(66446008)(64756008)(44832011)(26005)(6636002)(66946007)(6506007)(2616005)(66556008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6196;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Yp+Isp9n32VloZosSsSv3OVksf61Aw6pK6fDIKpTPbJGxbomeGwZBLDiwWNCgZTE6C+WralWjMa8XTvI3iOrJdqO74WHmoZG3O/IbibfvDF2NJ1f7WyC2xprS26BXnewkDaHhH/G/Y9Mnjp5F0LiwbiD63p3qdpJ+aPeC6PHsVXYKCjLIH+hyQMnKfamIiJi5Lf3wsxJxSI5N9K7nukoSkozvDfdt9p+N4uNOf8/Q4IogVB/gj5dfRaj2y9smV7lunaZbQhP4dX8Gw6xktAECfx2mcwvRMm3lQ0Isn8Srfdvi6CNLvGMcurSg6AA2HB15kf9U58PXkbiSasfh7iM8a//l8cwVluh00Wj+QLkzYVP5mcwZEGiMc7Kz4Mc1NnWK2n3jkBBWOpa9zoa4behy4fx4IsgeC0QlznXIGICWAjuMWRhgzcwA97T+wClOMWg
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa648a4d-31ea-4d6d-f884-08d77eaf3f7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2019 02:59:04.7779
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VPQfLypCRQ+M2hEWUDfAfBUqUANYocm/+qBbQFzcZyNxoGJwBGw32lXMIUMlAT8liIPyS2m9+XgO2fdIN48jwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6196
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Switch the imx_clk_hw_gate3_flags function to clk_hw based API, rename
accordingly and add a macro for clk based legacy. This allows us to
move closer to a clear split between consumer and provider clk APIs.

Reviewed-by: Abel Vesa <abel.vesa@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index e28166a63894..65d80c675aa9 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -370,15 +370,18 @@ static inline struct clk_hw *imx_clk_hw_gate3(const c=
har *name, const char *pare
 			reg, shift, 0, &imx_ccm_lock);
 }
=20
-static inline struct clk *imx_clk_gate3_flags(const char *name,
+static inline struct clk_hw *imx_clk_hw_gate3_flags(const char *name,
 		const char *parent, void __iomem *reg, u8 shift,
 		unsigned long flags)
 {
-	return clk_register_gate(NULL, name, parent,
+	return clk_hw_register_gate(NULL, name, parent,
 			flags | CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
 			reg, shift, 0, &imx_ccm_lock);
 }
=20
+#define imx_clk_gate3_flags(name, parent, reg, shift, flags) \
+	to_clk(imx_clk_hw_gate3_flags(name, parent, reg, shift, flags))
+
 static inline struct clk_hw *imx_clk_hw_gate4(const char *name, const char=
 *parent,
 		void __iomem *reg, u8 shift)
 {
--=20
2.16.4

