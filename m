Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D2B6CA9EC3
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 13:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC8F8217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 13:41:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="OtFXJgsI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388930AbfJ2NlZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 09:41:25 -0400
Received: from mail-eopbgr130083.outbound.protection.outlook.com ([40.107.13.83]:20179
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388274AbfJ2NlZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 09:41:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TnuJX/0zBLxUQiDI+7BjVn/I1hEBmbSXnnmnMYSCaMRBf0z4/Tv/uBsCRTIimqI0Q9eJJ6UKYHIydzmqVpP1UcEICqYaGBTR3m+DAUovYS/a9Zut0e662wWpIbBrJaSzqe/cnm8tM4xp5TA2vz3IRqVuiGnvnuwAEKidgnxR7YUepQTwKwI8kDcqZ7RRpLep5sj1xmdTtPtjK84nEafQ9LbgXgp5K11Mp9sCHfEt6UN7ZozqdO9MunDM2AZGjSF08FK4UO/AIIAA0TOvGMn48DTHOah5Q0NtW6KN85hMq8d6b3s9gx9y07FU+gDZJ9mYuGQDbG6iYU9gb9fJ+YmovA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+N35YA2hGtlaq18HtoQiKoZdlQsPSmE4wBDIDrjkUkA=;
 b=UPeDVyo0FlSe2iq+U52KfFeWMWo/lt4z6KuisTTYGmoekt9bSLonoDItDLOzhAJOkxwdPlsYYJuifVayaNP8cyqXY+g5tnOkvIK23xmq3CA5V+2bNzcw+dcbka9c2wtWIP43PJhd2hMgLX13nNF8WxheubRvUZE5VChMGIjFFSMxCNnTwk3spHdPG3bj+4/PeTW4aJJLjDxzjvVmAAgLrh+2n2BeFPwdLKSC6tuK1O4fSWCiuO8e1jWbSVs/57Xll4TDg4xH+wwHRmKsmeJQJezdRfP3uKM6rzl8YpJBXdMpXkVdqjky7teWVi0oQ1ksug7bXs5YKeW3uew4SMx+9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+N35YA2hGtlaq18HtoQiKoZdlQsPSmE4wBDIDrjkUkA=;
 b=OtFXJgsIhIE3UKBUDMdra3MatkeOdl8LnkYMFbOnoUWXEX2cWD9YhZmlqUuYxtONdYA8jTEgPLa4aOfhxQbqvjRQCxJhyEnJP8Tf5SaGpLKVPJkrQYqz6nJTk+IjJX/cXvJM5C81a8vRRaZyxRTtn+E5tUq6ACJhMkvd+dLPZFQ=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5139.eurprd04.prod.outlook.com (20.176.215.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Tue, 29 Oct 2019 13:41:16 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::843c:e722:27cb:74e1]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::843c:e722:27cb:74e1%5]) with mapi id 15.20.2387.023; Tue, 29 Oct 2019
 13:41:16 +0000
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
Subject: [PATCH 5/7] clk: imx: frac-pll: Switch to clk_hw based API
Thread-Topic: [PATCH 5/7] clk: imx: frac-pll: Switch to clk_hw based API
Thread-Index: AQHVjl6JCjRvyPL6y024UL55o1NcNA==
Date:   Tue, 29 Oct 2019 13:41:16 +0000
Message-ID: <1572356175-24950-6-git-send-email-peng.fan@nxp.com>
References: <1572356175-24950-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1572356175-24950-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0P153CA0030.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:17::18) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7579d4e4-868f-4e97-9ed0-08d75c75ac0e
x-ms-traffictypediagnostic: AM0PR04MB5139:|AM0PR04MB5139:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB5139A21B13ACBADF1C6A99DF88610@AM0PR04MB5139.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-forefront-prvs: 0205EDCD76
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(366004)(39860400002)(396003)(136003)(199004)(189003)(6436002)(102836004)(66946007)(52116002)(66556008)(66066001)(5660300002)(66476007)(2501003)(81166006)(8676002)(486006)(81156014)(6506007)(386003)(66446008)(6486002)(64756008)(256004)(478600001)(26005)(2906002)(3846002)(76176011)(186003)(25786009)(99286004)(71190400001)(71200400001)(6116002)(6512007)(6636002)(54906003)(14454004)(7736002)(36756003)(446003)(11346002)(476003)(2616005)(305945005)(4326008)(44832011)(50226002)(316002)(110136005)(86362001)(2201001)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5139;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UIJziiZF6hof3oDCUUV/qLKiI/0qN3+8ZU93u2XVvoS+Cn7jIJ3LrLy++ERAhDweZgzmtzwLj6TMP2Wn41dhdCKLLXY3NzC7IkCpfRstZYM+cNxh2U/rWsGeQZFKFBXmTI9NPhh/x/+qNmR5J0g9q/BtFjzwMveMHvls06YOCcim21rp7OcPUD1We7ZjZc+jWj8Q44mL4arRY2euiAftLpWOVX9SAMFFKfcGPwpxlzTa2KDKBW51kIq4d1KZIcEzdbh1Gh2lhVg8Ph+ID7IWKL5QyVr6bkGvvD8LQqfUYrIma0DoxdKqEupgPzkHdh3Yd/N5ksYqUbLR9HDAaQKdaUnaTuboeyBPdzlvbkfz9UcX4RduUXwVermvl2DU5GWuA/OrjWcCrCX+Bj4SF3Irywpc7xXjv5VUsHf+oCyP1vw8yC8EpFxshPPy8/G2a738
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7579d4e4-868f-4e97-9ed0-08d75c75ac0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2019 13:41:16.5771
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P3xd4SlU46KrbuAWkyB2jzXYdwXCIgE/uMWm4x+a7fp8agIxITWPowYMlUSeEAwrJ3Fc4u4pd8Y6IwS7OmTexQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5139
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Switch the imx_clk_frac_pll function to clk_hw based API, rename
accordingly and add a macro for clk based legacy. This allows us to
move closer to a clear split between consumer and provider clk APIs.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-frac-pll.c | 4 ++--
 drivers/clk/imx/clk.h          | 6 ++++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/imx/clk-frac-pll.c b/drivers/clk/imx/clk-frac-pll.=
c
index fece503e3610..818ddb35329f 100644
--- a/drivers/clk/imx/clk-frac-pll.c
+++ b/drivers/clk/imx/clk-frac-pll.c
@@ -201,7 +201,7 @@ static const struct clk_ops clk_frac_pll_ops =3D {
 	.set_rate	=3D clk_pll_set_rate,
 };
=20
-struct clk *imx_clk_frac_pll(const char *name, const char *parent_name,
+struct clk_hw *imx_clk_hw_frac_pll(const char *name, const char *parent_na=
me,
 			     void __iomem *base)
 {
 	struct clk_init_data init;
@@ -230,5 +230,5 @@ struct clk *imx_clk_frac_pll(const char *name, const ch=
ar *parent_name,
 		return ERR_PTR(ret);
 	}
=20
-	return hw->clk;
+	return hw;
 }
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 49cbf6e20ad8..a260b8dd3256 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -111,8 +111,10 @@ struct clk *imx_clk_pllv1(enum imx_pllv1_type type, co=
nst char *name,
 struct clk *imx_clk_pllv2(const char *name, const char *parent,
 		void __iomem *base);
=20
-struct clk *imx_clk_frac_pll(const char *name, const char *parent_name,
-			     void __iomem *base);
+struct clk_hw *imx_clk_hw_frac_pll(const char *name, const char *parent_na=
me,
+				   void __iomem *base);
+#define imx_clk_frac_pll(name, parent_name, base) \
+	imx_clk_hw_frac_pll(name, parent_name, base)->clk
=20
 struct clk *imx_clk_sccg_pll(const char *name,
 				const char * const *parent_names,
--=20
2.16.4

