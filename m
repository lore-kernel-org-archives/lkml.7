Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8393C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 12:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 898CD20843
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 12:28:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="AqPqrT5H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbfEOM2S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 08:28:18 -0400
Received: from mail-eopbgr150077.outbound.protection.outlook.com ([40.107.15.77]:45343
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726441AbfEOM2S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 08:28:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jZ10VM0E0QGH+rFqn+KCRa0x5MdVNWbZ2uV9Wh376JI=;
 b=AqPqrT5HrrjsZ/E1b/BtEOa7Q9Oe7xML1e0jZ8xILy1nFWb5sPxqBkcZPiYjMY45w1CQ1o9C2xdVM0/Z71+Z6B2swAlmMt2fh/w4tnghDiWy+ngfVmTUINr9WhMVlUbzN2XIYMeAxKibO8f93j9oqV5X0or0EJH56xkRCnyt4/4=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3946.eurprd04.prod.outlook.com (52.134.72.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.16; Wed, 15 May 2019 12:28:13 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d035:3bd0:a56a:189d]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d035:3bd0:a56a:189d%2]) with mapi id 15.20.1900.010; Wed, 15 May 2019
 12:28:13 +0000
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
        "robh@kernel.org" <robh@kernel.org>,
        "hofrat@osadl.org" <hofrat@osadl.org>,
        Jacky Bai <ping.bai@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "michael@amarulasolutions.com" <michael@amarulasolutions.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V2 1/2] clk: imx: Add common API for masking MMDC handshake
Thread-Topic: [PATCH V2 1/2] clk: imx: Add common API for masking MMDC
 handshake
Thread-Index: AQHVCxmq80TspEKNo0uWdJG5ctX+bA==
Date:   Wed, 15 May 2019 12:28:13 +0000
Message-ID: <1557922984-20811-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0P153CA0031.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:17::19) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dcad10e4-0a7e-423a-ebf7-08d6d930cc51
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3946;
x-ms-traffictypediagnostic: DB3PR0402MB3946:
x-microsoft-antispam-prvs: <DB3PR0402MB39463515D1C6FBCA84E30F49F5090@DB3PR0402MB3946.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2089;
x-forefront-prvs: 0038DE95A2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(136003)(396003)(366004)(199004)(189003)(5660300002)(68736007)(99286004)(8676002)(36756003)(2501003)(50226002)(66066001)(256004)(14444005)(110136005)(14454004)(478600001)(81166006)(81156014)(8936002)(52116002)(66556008)(3846002)(73956011)(6116002)(6486002)(64756008)(66446008)(7416002)(2906002)(2201001)(66946007)(6506007)(102836004)(6436002)(7736002)(305945005)(6512007)(386003)(316002)(26005)(86362001)(486006)(71200400001)(71190400001)(4326008)(25786009)(476003)(2616005)(186003)(66476007)(53936002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3946;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: k0N4P84mGLD6Scdfuxo96GiZVd3ggiZeJeFvP9RZdmVKGed4/dCQMOXra7w6kWDYPVXLg9fCrtlJIb1WjD6rI1fI8vrrKbWMdL15Ne9FQ6vSkIRdeo257OsCEYupqGde61CC7ap40/MlG1Ls6Ao3zREs8apw2DVZzQTiZ9+c0ggv+cdNZg4nAaO5REv4Z3lcIRzydGXvvA9zkhGN6spZwlJVQp+S603Rvz9Q7EtyIxkmN8wBqDtikepgQhumpmTegRUG2REphdW7aZ1FRsfSdB6AQNI6aneIj7V/fjZVQJcCgFT40NkeiJwsJlw4zi+tX7ljzEB0jPzcJ6wfjI1F5eBO223tNgHx1i7FxdcCa6VctRBkEel2waJl4eOy/NlkBokMsJj5fzs2q1MYsHeQxHkGiKe4viT4Vypl/olWWVA=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <02B300F23F96AE42A8237D96181AD782@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcad10e4-0a7e-423a-ebf7-08d6d930cc51
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2019 12:28:13.3645
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3946
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
Changes since V1:
	- add necessary "io.h" head file to avoid build error based on latest linu=
x-next.
---
 drivers/clk/imx/clk.c | 15 +++++++++++++++
 drivers/clk/imx/clk.h |  1 +
 2 files changed, 16 insertions(+)

diff --git a/drivers/clk/imx/clk.c b/drivers/clk/imx/clk.c
index 1efed86..9cd7097 100644
--- a/drivers/clk/imx/clk.c
+++ b/drivers/clk/imx/clk.c
@@ -1,13 +1,28 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/clk.h>
 #include <linux/err.h>
+#include <linux/io.h>
 #include <linux/of.h>
 #include <linux/slab.h>
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

