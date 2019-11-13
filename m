Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AD75C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 07:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB8562084F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 07:25:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jLoBtTX2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbfKMHY7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 02:24:59 -0500
Received: from mail-eopbgr00077.outbound.protection.outlook.com ([40.107.0.77]:37003
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725908AbfKMHY5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 02:24:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lFE/enU+Om4QHMVAdc6NMp9izpPNEOQgV0NrQeljy3lEebxYlC6MFbfsif0B/U7hfe4LSOGtujul5TPAKW/R/cFgMw6q6x3DrauDqUi01Gjf+CvoJg5p5ypkOKyGoofqazrC+770U08MhL3TaaUVEwuT+R5SbP7ugbek+7Hpm2TlCPkfSptIkZMgojYYO0hyzqxnU07b2rOGHBsTYjrndNliSrMArUlcYF5XdlcBSiQywVwmsRe8ka9/FHxUpDun2A2ftUyjmk5ZuQSdR8EJB37Qqz5awC7fDUmDb4PbQ8thtGq4PHJPlj122MxBHoILVJKrqTJPrWJOnrHBQhd+Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RV77L6pAwy8VG3PxPqjjLYulQaVEqevS2utmf1FEiyg=;
 b=PQNCVA40AvdH9gTMO9uzeIDdiSFn3HQqbAwX+3X6AeWsU94iElUqxJsj0mWdGoHkPHfDuooYjVW66ciq/GzFSNjfIw/6DamYqJnxhojNDogrQjP+4F390R1LpXtPQySacUBYwkBOMAyXYv5bvGAVfV9NmmQTsT6SKsF2uSLrZHA0gK6BtiIfZaGUGMDu1RALkyIH+6wmGpxdFZs8TftyAt78jUrQQxQEuYa1TzNhVWNCbvrbpJuz/wF8uh3otVRFx40GPiUSGx1o/VrF16nkwEBiMaDo84gUeozQSexedEbQPInR21fnurR/25UKfQ0Vtt/RfKiGaO+4wMBKOo2AaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RV77L6pAwy8VG3PxPqjjLYulQaVEqevS2utmf1FEiyg=;
 b=jLoBtTX2bX4+3FexxUN7724JYNrDOQ9vCDbPrTa2PV64R/J6RsUUK5xLc3qyXcSUVaGDG2mG/o3G4gMhixiQBf1nEWiUim4asKHSB6U/nOaM9X+721mecXegD5abjwxjGWMswNBK5eibiK7sCN+wNh49fvGjquZyFXtdnWIbwnA=
Received: from DB7PR04MB4490.eurprd04.prod.outlook.com (52.135.138.150) by
 DB7PR04MB4651.eurprd04.prod.outlook.com (52.135.138.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.22; Wed, 13 Nov 2019 07:24:54 +0000
Received: from DB7PR04MB4490.eurprd04.prod.outlook.com
 ([fe80::115f:1e4f:9ceb:2a2c]) by DB7PR04MB4490.eurprd04.prod.outlook.com
 ([fe80::115f:1e4f:9ceb:2a2c%7]) with mapi id 15.20.2430.028; Wed, 13 Nov 2019
 07:24:54 +0000
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
        Alice Guo <alice.guo@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        Will Deacon <will@kernel.org>
Subject: [PATCH 2/2] clk: imx: pll14xx: use readl to force write completed
Thread-Topic: [PATCH 2/2] clk: imx: pll14xx: use readl to force write
 completed
Thread-Index: AQHVmfNxsbVsC4dvu0eM4eyT9DyAhQ==
Date:   Wed, 13 Nov 2019 07:24:54 +0000
Message-ID: <1573629763-18389-3-git-send-email-peng.fan@nxp.com>
References: <1573629763-18389-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1573629763-18389-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR02CA0169.apcprd02.prod.outlook.com
 (2603:1096:201:1f::29) To DB7PR04MB4490.eurprd04.prod.outlook.com
 (2603:10a6:5:36::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f3d0c28f-59f8-4c68-17ad-08d7680a93e8
x-ms-traffictypediagnostic: DB7PR04MB4651:|DB7PR04MB4651:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR04MB46514EC43A119C21775E60CA88760@DB7PR04MB4651.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1079;
x-forefront-prvs: 0220D4B98D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(366004)(136003)(396003)(39860400002)(346002)(199004)(189003)(54906003)(81156014)(81166006)(44832011)(8676002)(76176011)(50226002)(256004)(186003)(52116002)(6636002)(6486002)(66066001)(486006)(110136005)(2906002)(8936002)(36756003)(6436002)(316002)(478600001)(6512007)(7736002)(305945005)(71200400001)(2616005)(386003)(11346002)(102836004)(71190400001)(446003)(2501003)(6506007)(26005)(14454004)(476003)(4744005)(5660300002)(66476007)(66556008)(64756008)(66446008)(86362001)(25786009)(6116002)(66946007)(3846002)(99286004)(2201001)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4651;H:DB7PR04MB4490.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cENT66VEuYXcB5okVNepGYwuhwLwOR12246uSLSMQZ/ZwL0x8X5LPttKomvp6aUvMPhX49IpPy5u6t7kYn7Z0CefOyvRvPzSYQiFdIHHZHG5RNhc4kpNtR6YxXxjBtjFZ9O27580mZtbIRy3ADD3gcj/dIKdRwbSAQ+ooQvG8jlvz4ELGnrmA/+SYMl/gx1XwToMDcs0QQbKAtMp438ZujUPxUUvy3WY9HV+gHQznondRXvbS6N+LYYoQM04WKqdFwgW7gnb+09tBSwDNnS8I0+/8+SIy30rX/Q6a3SJ/ffHRvRM2aKkv4eeNcccyio6fAVwpiiiexxoc5YSdYtVLXuS3NN/TC1/9ouZ7R9AVRBzi1Gk9IYo0jyD596fSFl/kXNksFvqJgxZzBiD4krXcFkqo/DcjWh1UMVt9SJinTVMhY5iTYVvt3DJi9gjFR3u
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3d0c28f-59f8-4c68-17ad-08d7680a93e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2019 07:24:54.0964
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sotzV3pm5nz9JNdgM0xbDJi8DVDzW2alqm/ntVICdd6WS/fR8oNixSFyhPAdIycD5pJgwgPWaey1LIeKEtXQ6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4651
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

To ensure writes to clock registers have properly completed,
add a readl after writel_relaxed. Then we could make sure
when udelay, write has been completed.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Cc: Will Deacon <will@kernel.org>
---
 drivers/clk/imx/clk-pll14xx.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/clk/imx/clk-pll14xx.c b/drivers/clk/imx/clk-pll14xx.c
index e34813904023..2bbcfbf8081a 100644
--- a/drivers/clk/imx/clk-pll14xx.c
+++ b/drivers/clk/imx/clk-pll14xx.c
@@ -205,6 +205,12 @@ static int clk_pll1416x_set_rate(struct clk_hw *hw, un=
signed long drate,
 		(rate->sdiv << SDIV_SHIFT);
 	writel_relaxed(div_val, pll->base + 0x4);
=20
+	/*
+	 * readl will force write completed. There is a udelay below,
+	 * we need make sure before udelay, write has been completed
+	 */
+	readl(pll->base + 0x4);
+
 	/*
 	 * According to SPEC, t3 - t2 need to be greater than
 	 * 1us and 1/FREF, respectively.
--=20
2.16.4

