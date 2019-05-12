Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75864C04AB4
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 10:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CC282133D
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 10:24:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="L9/q0iKw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbfELKYT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 06:24:19 -0400
Received: from mail-eopbgr80084.outbound.protection.outlook.com ([40.107.8.84]:11907
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726274AbfELKYS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 06:24:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JsHyy5VJgiWsLf0tWEzdrvTf3kLNw/sCXTHWc+VAdJQ=;
 b=L9/q0iKw6TSt9pIcYkhjdj2Xyr2by3Ap3h4vI9td82vKWlaQoXns3O+mLQdTWi5Or7i1XS6bf/pYUfGABqQ2N6Vdm48HmMJO7U8XNTCTHmankdq4hyB6rtHvvNr9+hp8K9ZbeEfxv75TcvTJ4DGi2gKU9P/7GClHDaQmD33Qe8w=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3675.eurprd04.prod.outlook.com (52.134.69.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.22; Sun, 12 May 2019 10:24:12 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d035:3bd0:a56a:189d]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d035:3bd0:a56a:189d%2]) with mapi id 15.20.1878.022; Sun, 12 May 2019
 10:24:12 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "tiny.windzz@gmail.com" <tiny.windzz@gmail.com>,
        "pp@emlix.com" <pp@emlix.com>,
        "colin.didier@devialet.com" <colin.didier@devialet.com>,
        "robh@kernel.org" <robh@kernel.org>, Jacky Bai <ping.bai@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "hofrat@osadl.org" <hofrat@osadl.org>,
        "michael@amarulasolutions.com" <michael@amarulasolutions.com>,
        "stefan@agner.ch" <stefan@agner.ch>, Abel Vesa <abel.vesa@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH RESEND 1/2] clk: imx: Add common API for masking MMDC
 handshake
Thread-Topic: [PATCH RESEND 1/2] clk: imx: Add common API for masking MMDC
 handshake
Thread-Index: AQHVCKzXj5CeLLFh1kCpP4B8xSmy8A==
Date:   Sun, 12 May 2019 10:24:12 +0000
Message-ID: <1557656348-13040-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0P153CA0036.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:17::24) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 97fdc2b7-a1a7-4a0d-6bf5-08d6d6c3fa17
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3675;
x-ms-traffictypediagnostic: DB3PR0402MB3675:
x-microsoft-antispam-prvs: <DB3PR0402MB3675370625D6371605417799F50E0@DB3PR0402MB3675.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-forefront-prvs: 0035B15214
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(39860400002)(396003)(346002)(366004)(199004)(189003)(14444005)(3846002)(6116002)(256004)(7416002)(2201001)(26005)(2906002)(66476007)(66556008)(64756008)(66446008)(5660300002)(8936002)(102836004)(73956011)(66946007)(6512007)(6506007)(71200400001)(386003)(99286004)(71190400001)(476003)(86362001)(2616005)(486006)(186003)(52116002)(110136005)(25786009)(14454004)(4326008)(305945005)(478600001)(2501003)(6436002)(7736002)(6486002)(53936002)(36756003)(68736007)(316002)(50226002)(66066001)(81166006)(81156014)(8676002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3675;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: nHeNxPNSywblom9gjuTzn6EGrSM2HhQMYOlLl8OUyA/Jdv6GtBRjYuta3N/t5W/YV1vel0gmnGHC5tyvduaeaGntotk3rfcGfFmGASMm6HZVRS3/l7pDCOWoOwDV6OFIhb5wBucBjCahuEEbofk9grReKd6/jfHVpSQdayDbD0GvzP6UT6Ndz6f1o7yz1d+ILjJ0MyeDIX8pqOqmbJro9MYhjT8ByEbAiryEME+Sus5iZ4fM8K8Q4gXYAM7IXcHLb0v3WH1lDjnyygea8vQCROvvih3QsIcevKGbBpqYsHYPR/jZgYcf7yatH/Qjdthz/O3fT1G08QDnPUpcCdKawYOWU89mL5Mq7Rpk46Y4qDJAmAUK0sZYBZsFcutyh2UBHY3LbvB4FISpktVmg/HHJwEIOYv45evhu+n+sV4Wjq4=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <A76FF3D684F8BF428F56D299B6EE8572@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97fdc2b7-a1a7-4a0d-6bf5-08d6d6c3fa17
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2019 10:24:12.8153
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3675
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All i.MX6 SoCs need to mask unused MMDC channel's handshake
for low power modes, this patch provides common API for masking
the MMDC channel passed from caller.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
---
No change, just resend patch with correct encoding.
---
 drivers/clk/imx/clk.c | 14 ++++++++++++++
 drivers/clk/imx/clk.h |  1 +
 2 files changed, 15 insertions(+)

diff --git a/drivers/clk/imx/clk.c b/drivers/clk/imx/clk.c
index 1efed86..6f9bcee 100644
--- a/drivers/clk/imx/clk.c
+++ b/drivers/clk/imx/clk.c
@@ -6,8 +6,22 @@
 #include <linux/spinlock.h>
 #include "clk.h"
=20
+#define CCM_CCDR			0x4
+#define CCDR_MMDC_CH0_MASK		BIT(17)
+#define CCDR_MMDC_CH1_MASK		BIT(16)
+
 DEFINE_SPINLOCK(imx_ccm_lock);
=20
+void __init imx_mmdc_mask_handshake(void __iomem *ccm_base,
+				    unsigned int chn)
+{
+	unsigned int reg;
+
+	reg =3D readl_relaxed(ccm_base + CCM_CCDR);
+	reg |=3D chn =3D=3D 0 ? CCDR_MMDC_CH0_MASK : CCDR_MMDC_CH1_MASK;
+	writel_relaxed(reg, ccm_base + CCM_CCDR);
+}
+
 void __init imx_check_clocks(struct clk *clks[], unsigned int count)
 {
 	unsigned i;
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 8639a8f..6dcdc91 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -10,6 +10,7 @@ extern spinlock_t imx_ccm_lock;
 void imx_check_clocks(struct clk *clks[], unsigned int count);
 void imx_check_clk_hws(struct clk_hw *clks[], unsigned int count);
 void imx_register_uart_clocks(struct clk ** const clks[]);
+void imx_mmdc_mask_handshake(void __iomem *ccm_base, unsigned int chn);
=20
 extern void imx_cscmr1_fixup(u32 *val);
=20
--=20
2.7.4

