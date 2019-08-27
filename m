Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48DDFC41514
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FCD0206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:17:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rGN9XdhV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729986AbfH0IRy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 04:17:54 -0400
Received: from mail-eopbgr60053.outbound.protection.outlook.com ([40.107.6.53]:14917
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727788AbfH0IRx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 04:17:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mC6SGfUGcj5qfowVWSJ996L5OzXYwktpH8iMQC2pLbM1ADZOtA4ZTllXCzGeYxZ/q49PldKvlaKqln3FVYJAa+fzFzYF9kPN88P3Hx8YIQxLGS0VZ3IJ7Nd4HKdczSBuEjqW//KTCy9iUz7UmRcCEEllnwR/Sv0pbw033bWRUPSvanRzuX+PJ5dUZTFAKM3eEQ7z5Ur73VdXQsuaD2nnTvpDZT4msP1e5mmzUS4BloKxEYd2y4Up/KHk0XQl/sGjq7gt9avOkpKSrWOWh8odLGNUzmeXnVgZyju3dfeGWiO/4kBHvDxPvgzG6X2qGVVwXW/Ch837WE/eCPoRjYFetQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6tLgUOAdcUK2g4ZMA3HdTrrSdjZWSUZVsh5luoh4dMA=;
 b=EWit/mVuTId+PLQDdfPdFEklX278AjaUp4K/eCE/D0p2/6zO9e+xIsNgdyC/Wp/guukcq1BtZ4OK4jPh/gVED1YAZY4hS8KAyfThYtv2i4WvTkP1rs1pY0s1Hfza1ppPezXbpAiJ1IlEkBxLXlWDjr09fIM/TliuY8qtlaaTU86f9WKEzJn38xI0F9uZWgDWuKAhbI+9DW8D9WoCOk54+3ejzLl/ch9m7MB2wYMsLXTg/f+IcivJkFbW/lQXA2PCVof87Ejs5U01uJjbU0F/vIdDpws31h+ANS9sgEWo+rWhkjQSkC0DalI7U35pmkLsg4GFOT/3DfR4ELPJptanKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6tLgUOAdcUK2g4ZMA3HdTrrSdjZWSUZVsh5luoh4dMA=;
 b=rGN9XdhVXSK6FQKzLQd1oOON8o4jwQSZnErHFROQIbdG8UX5bkPRlWT9shQ1o1At85ti97MaJef3s+3g5LJ9VZr4OwpR+WYo0zM7sWGoVN3uvS2nwWTYuYzt139bOhga1adUZsIPeCSznaVi2tmIk0nRDTs10fCZpgVNIHG3VxQ=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6961.eurprd04.prod.outlook.com (52.132.214.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Tue, 27 Aug 2019 08:17:50 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::5d98:e1f4:aa72:16b4]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::5d98:e1f4:aa72:16b4%4]) with mapi id 15.20.2178.022; Tue, 27 Aug 2019
 08:17:50 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Aisheng Dong <aisheng.dong@nxp.com>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, Abel Vesa <abel.vesa@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] clk: imx: lpcg: write twice when writing lpcg regs
Thread-Topic: [PATCH] clk: imx: lpcg: write twice when writing lpcg regs
Thread-Index: AQHVXK/qRNohGClvt0yC94cqOwkPUA==
Date:   Tue, 27 Aug 2019 08:17:50 +0000
Message-ID: <1566936978-28519-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR02CA0143.apcprd02.prod.outlook.com
 (2603:1096:202:16::27) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 31915c1d-db0b-4f77-1171-08d72ac70cc4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB6961;
x-ms-traffictypediagnostic: AM0PR04MB6961:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB696121F771311C6327AA6D9C88A00@AM0PR04MB6961.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0142F22657
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(136003)(39860400002)(366004)(346002)(199004)(189003)(71200400001)(54906003)(2501003)(8936002)(66066001)(478600001)(36756003)(64756008)(66556008)(6436002)(6486002)(66446008)(386003)(6506007)(66476007)(71190400001)(7736002)(110136005)(305945005)(2201001)(86362001)(316002)(14454004)(6636002)(81156014)(81166006)(2906002)(486006)(2616005)(476003)(26005)(4326008)(44832011)(66946007)(53936002)(186003)(14444005)(52116002)(102836004)(99286004)(25786009)(6512007)(256004)(50226002)(3846002)(6116002)(5660300002)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6961;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: JaamQxk4G4A+hccSgbT3aTuuAafYjkuY65ZzYnFOIQblxCbZe1qlbpJcI5cPT0nu3ofMKsAYLR9zkghodqNlY23CJx3AHW59knHEHFz2B3Zw4Gba0nCKZLuDntMoBH07iPXlWphzMbUXCga0Xn7Vtf1H3Sci2YqmQm1vNTFUT98tOATjaeWjxHR6KWd9VvaKpGpNelXetfe1pt0WXwQv3dk6dwhCC8U3/O0d52V4z9/N8cT4MMbiL882ZZ9ItppJUVIwCfmvrH3zgQcT8VUJDTHOUk9qL+fFySlcfFVJUK/J7vyg0CLJlNssDKvM9QfHNaSTnnKjCIjGRGZL6jO1zlgk+LoE1qBvBN52HN2/sYTxOHAGC5Ii/biDwf6zX/fU07nZNrOTwG7o/Rxex0hyYEGNYIabOTEEr/tZkHzG32k=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31915c1d-db0b-4f77-1171-08d72ac70cc4
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2019 08:17:50.1446
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QAq71gkrnoh1/AcRotgSzzX5jZ0h43vi6PEuR8IzdXScqTdTeCB2PVd4YC3FLnefUqRmVumMF2pzHqetUypeaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6961
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

There is hardware issue that:
The output clock the LPCG cell will not turn back on as expected,
even though a read of the IPG registers in the LPCG indicates that
the clock should be enabled.

The software workaround is to write twice to enable the LPCG clock
output.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-lpcg-scu.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/clk/imx/clk-lpcg-scu.c b/drivers/clk/imx/clk-lpcg-scu.=
c
index a73a799fb777..7391d0668ec4 100644
--- a/drivers/clk/imx/clk-lpcg-scu.c
+++ b/drivers/clk/imx/clk-lpcg-scu.c
@@ -54,6 +54,11 @@ static int clk_lpcg_scu_enable(struct clk_hw *hw)
=20
 	reg |=3D val << clk->bit_idx;
 	writel(reg, clk->reg);
+	/*
+	 * There is hardware bug. When enabling the LPCG clock
+	 * output, SW can write the enabling value twice
+	 */
+	writel(reg, clk->reg);
=20
 	spin_unlock_irqrestore(&imx_lpcg_scu_lock, flags);
=20
@@ -71,6 +76,11 @@ static void clk_lpcg_scu_disable(struct clk_hw *hw)
 	reg =3D readl_relaxed(clk->reg);
 	reg &=3D ~(CLK_GATE_SCU_LPCG_MASK << clk->bit_idx);
 	writel(reg, clk->reg);
+	/*
+	 * There is hardware bug. When enabling the LPCG clock
+	 * output, SW can write the enabling value twice
+	 */
+	writel(reg, clk->reg);
=20
 	spin_unlock_irqrestore(&imx_lpcg_scu_lock, flags);
 }
--=20
2.16.4

