Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB78EC04AB4
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 01:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B9192084A
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 01:30:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="KAriZnZS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbfEOBaC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 21:30:02 -0400
Received: from mail-eopbgr150080.outbound.protection.outlook.com ([40.107.15.80]:32414
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726174AbfEOBaA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 21:30:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cdLtjoqZTQeXXA2igAVtyX+/FRQaIPwtpaxd3t0Qw2E=;
 b=KAriZnZS0OF21piVUCKG/B7BFtnu9f27ZG4AuzXMYZkkGrj6fNIT5Pl12em40a1309uU/Lo0pvmuyV+lMl7MIT628dCKlMVGsXVWSabx1uiyqpyPdBJHEQ01uR86V/kMtrsB4ykzUQMVDYSD2h/7oomJTsRZ4zPCzlTo2108TQE=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3724.eurprd04.prod.outlook.com (52.134.66.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.16; Wed, 15 May 2019 01:29:58 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d035:3bd0:a56a:189d]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d035:3bd0:a56a:189d%2]) with mapi id 15.20.1900.010; Wed, 15 May 2019
 01:29:58 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH 2/3] clk: imx8mm: add SNVS clock to clock tree
Thread-Topic: [PATCH 2/3] clk: imx8mm: add SNVS clock to clock tree
Thread-Index: AQHVCr21OU/Swoqgv0qy7PbWkQQ4qw==
Date:   Wed, 15 May 2019 01:29:57 +0000
Message-ID: <1557883490-22360-2-git-send-email-Anson.Huang@nxp.com>
References: <1557883490-22360-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1557883490-22360-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR03CA0056.apcprd03.prod.outlook.com
 (2603:1096:202:17::26) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 354443fa-8bfe-46ce-77ec-08d6d8d4d741
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3724;
x-ms-traffictypediagnostic: DB3PR0402MB3724:
x-microsoft-antispam-prvs: <DB3PR0402MB37243C6CAC565089B9EF3D51F5090@DB3PR0402MB3724.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0038DE95A2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(136003)(346002)(396003)(376002)(199004)(189003)(316002)(256004)(50226002)(81166006)(4326008)(6512007)(8936002)(71190400001)(5660300002)(110136005)(71200400001)(52116002)(2906002)(86362001)(6506007)(386003)(68736007)(81156014)(25786009)(99286004)(102836004)(36756003)(186003)(6116002)(3846002)(476003)(486006)(26005)(2201001)(76176011)(11346002)(2616005)(446003)(53936002)(64756008)(73956011)(66446008)(66476007)(66556008)(66946007)(2501003)(478600001)(14454004)(6436002)(305945005)(66066001)(7736002)(6486002)(8676002)(7416002)(921003)(32563001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3724;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: cDj7Lct2Gg7MOaKMfpwvLOADqVmRlYSD792SJgsm6TF+eM8ptpkZrh8+GPCS7jd4R1frmY5D67pCMhOo85g3PZa6v0cqVDhsEIYNVHh3W/0RyRfNkW981AJYT+ovkB7zcjgSBiEhNjdfx4ZwlkUejb5DJ0ydK3iLtxhJDuslPAIthu1Wk/dS0jLvxVeHuHEWqcCwR+9Ulu5HdplJtx8MWWwdiQrginq5aOmKgS1uPW4OTU1yqFo2aHvItBwMF13VEHqb1KwC5+3o7K6/obXjxZXuHk/yO1y27sb/VC/7nmTaa0guKY9oz8oAmbpp8z7lvwumxgOQWUyTdFQXFv3pIJFDcDTb4fk1vez1OXv0xRthdVmo+BG3h3wU6VXHJR5QVDwPEG6Or+9PBYB8YcAP79df1NXzTDUIBS4/C6nhPa4=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <655E84F9BB8182418802F07E7FE89A7F@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 354443fa-8bfe-46ce-77ec-08d6d8d4d741
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2019 01:29:58.0005
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3724
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX8MM has clock gate for SNVS module, add it into clock tree
for SNVS RTC driver to manage.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/clk/imx/clk-imx8mm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/imx/clk-imx8mm.c b/drivers/clk/imx/clk-imx8mm.c
index 733ca20..7ffbd6e3 100644
--- a/drivers/clk/imx/clk-imx8mm.c
+++ b/drivers/clk/imx/clk-imx8mm.c
@@ -622,6 +622,7 @@ static int __init imx8mm_clocks_init(struct device_node=
 *ccm_node)
 	clks[IMX8MM_CLK_SAI5_IPG] =3D imx_clk_gate2_shared2("sai5_ipg_clk", "ipg_=
audio_root", base + 0x4370, 0, &share_count_sai5);
 	clks[IMX8MM_CLK_SAI6_ROOT] =3D imx_clk_gate2_shared2("sai6_root_clk", "sa=
i6", base + 0x4380, 0, &share_count_sai6);
 	clks[IMX8MM_CLK_SAI6_IPG] =3D imx_clk_gate2_shared2("sai6_ipg_clk", "ipg_=
audio_root", base + 0x4380, 0, &share_count_sai6);
+	clks[IMX8MM_CLK_SNVS_ROOT] =3D imx_clk_gate4("snvs_root_clk", "ipg_root",=
 base + 0x4470, 0);
 	clks[IMX8MM_CLK_UART1_ROOT] =3D imx_clk_gate4("uart1_root_clk", "uart1", =
base + 0x4490, 0);
 	clks[IMX8MM_CLK_UART2_ROOT] =3D imx_clk_gate4("uart2_root_clk", "uart2", =
base + 0x44a0, 0);
 	clks[IMX8MM_CLK_UART3_ROOT] =3D imx_clk_gate4("uart3_root_clk", "uart3", =
base + 0x44b0, 0);
--=20
2.7.4

