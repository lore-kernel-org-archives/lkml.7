Return-Path: <SRS0=rArk=2Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5112C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 10:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80969206CB
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 10:21:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cw5E3jy6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbfLZKU7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Dec 2019 05:20:59 -0500
Received: from mail-eopbgr150042.outbound.protection.outlook.com ([40.107.15.42]:28545
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726060AbfLZKU7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 05:20:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fD6X816fK6OkJ2oYltZrNaJQSSXbapOvzwtkxqwhRzuv3RR30g7spyM3wwb3JwYU4vKQlPM395V5heyYYp/ASIKap1Ngq+2li3NpaXvHk/HID38lu/9dlslZzr8o4ggDUVarJADK6BQKhNHQidzLxJs9LSBAA4a3pY7AJMmw574GiOyhN0YHVieu4UBxw5b+5qjpygL59GZ8zTwtDE+rTpAXvRjRUbNxCT3jmI7MMp1+IWlbslVCwthi1xk6O/EOE5Vgxkr5yGRjtDnKzKvWKU0fstJ6BM21iPBwYSVve2XV70LKoTK4jbedFAZNdpED9lJ5LBDOh74vjvoXr6Nm4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O+cYKgkrpJdEsZekjmSkDokTj/PTrNyoDlS9Bp1qLnE=;
 b=QznldWhN0a+bkhbP5+oPQE35Q58rBuxPkJ+CpAVy7txsOM4BjyANbVTZgGbFWo3LI2TtpaXd0rWAQgCc0YtCK9fB2mt8OvA0tKq/55bInI9lmyU7ozfTb541n4CJJkx/jNlx/ldNwdUPTqoc2Z+kEjk8ZJQhX5A5u7SqSjENRapGTPjfJCqq0BsENCIkZeS+xRLHQNMfWljx7pJ1kmr+evDGToCX8p3RmgXxC5qFi1BjBGDPOYFOfrUlNwI0f+MfyJ9t9rT5roH3Zbu3Uax5vn4O2AL7m9sLovGOmlPC2C1Gxjf8Y28qS34yejoeG822BYWOjVZuNh1WIE+qA/8/uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O+cYKgkrpJdEsZekjmSkDokTj/PTrNyoDlS9Bp1qLnE=;
 b=cw5E3jy6W4VhoxgxDnXmAhUYQuKB82KUDJvjOuTC0UfXt31PIyb15ivbj+FV0HiavQD2W7vlCzUifWXGCHZgiiRekJ2z424m3051CDEl1Hf4imED2pH3oTz0Lpa7JhrWuzCo0y2qYQd7Unw1DBkYUQYdpwaReuZ3MQC5rDN3OvA=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4001.eurprd04.prod.outlook.com (52.134.93.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2581.12; Thu, 26 Dec 2019 10:20:50 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::c58c:e631:a110:ba58]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::c58c:e631:a110:ba58%6]) with mapi id 15.20.2581.007; Thu, 26 Dec 2019
 10:20:50 +0000
Received: from localhost.localdomain (119.31.174.67) by HK2PR0401CA0018.apcprd04.prod.outlook.com (2603:1096:202:2::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2581.11 via Frontend Transport; Thu, 26 Dec 2019 10:20:45 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] nvmem: imx: ocotp: introduce ocotp_ctrl_reg
Thread-Topic: [PATCH] nvmem: imx: ocotp: introduce ocotp_ctrl_reg
Thread-Index: AQHVu9YkWVS6MuwrQ0+tW7iZWrxuBQ==
Date:   Thu, 26 Dec 2019 10:20:49 +0000
Message-ID: <1577355442-2140-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR0401CA0018.apcprd04.prod.outlook.com
 (2603:1096:202:2::28) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0c9d0517-f1ca-42a4-c212-08d789ed471e
x-ms-traffictypediagnostic: AM0PR04MB4001:|AM0PR04MB4001:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB4001C33E6B00A851F05A45C1882B0@AM0PR04MB4001.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 02638D901B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(396003)(376002)(346002)(366004)(189003)(199004)(81156014)(81166006)(36756003)(8676002)(4326008)(8936002)(956004)(5660300002)(2616005)(6506007)(44832011)(52116002)(478600001)(186003)(16526019)(64756008)(66556008)(66476007)(66446008)(66946007)(26005)(316002)(69590400006)(2906002)(86362001)(110136005)(54906003)(71200400001)(6486002)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4001;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7HxbP+36MFR9mKXI54zxgIbQAiU++LjSyFVBn/gY2gphGYBwbGJ3a59qb4p7hWXsLCv2tVRPEuFqt2dhwJ6X6wEIAu3V18U7BSRFG3BOfMO9syAxF36k1cAH0q6vOqMaKjv2tGikShRuawpuIeaSqpbxNz0kEdUscx6A6OxWN4nRDi7LPql6oOzWUW6zfC+Zs/vZ0XHilqZWaDoEVnK7GU07CBi3QYGvDKUanriWtiedtdYoCLB6rxhlS4P1KfFnmMJlZ4lW65y9T5ISziyoN+B2dK1xihjpBjd3orjCBcmZpYL9nPeUKhd1dPU1qcbdTSwDoHacD+illMX8gDCXTmAdseg1BX+OwQ/puYsFAWNiISlga1sfTkkgNPqgEJfq4pL7g3kbMeulhFVcKnpZzJqIliUbLH1XZTcK4cblKYrqe6wFnfGuccq6dq1ToUTCZxz7ELxsmMRfICXxymwsd0G8YLtIezXhQZFUtQHuG8NPL4c4v/32rupvuNxKc8rQ
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c9d0517-f1ca-42a4-c212-08d789ed471e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Dec 2019 10:20:49.5453
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LOItwtozHuFZ7wBSnbUMsGyHlUasAkP0WI3C/OSSOvdbNkG60KLxGIMDOtapg854am2rxKoDxmpy3tWtW6/vOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Introduce ocotp_ctrl_reg to include the low 16bits mask of CTRL
register.

i.MX chips will have different layout of the low 16bits of CTRL
register, so use ocotp_ctrl_reg will make it clean to add new
chip support.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/nvmem/imx-ocotp.c | 79 ++++++++++++++++++++++++++++++++++---------=
----
 1 file changed, 57 insertions(+), 22 deletions(-)

diff --git a/drivers/nvmem/imx-ocotp.c b/drivers/nvmem/imx-ocotp.c
index fc40555ca4cd..4ba9cc8f76df 100644
--- a/drivers/nvmem/imx-ocotp.c
+++ b/drivers/nvmem/imx-ocotp.c
@@ -44,6 +44,14 @@
 #define IMX_OCOTP_BM_CTRL_ERROR		0x00000200
 #define IMX_OCOTP_BM_CTRL_REL_SHADOWS	0x00000400
=20
+#define IMX_OCOTP_BM_CTRL_DEFAULT				\
+	{							\
+		.bm_addr =3D IMX_OCOTP_BM_CTRL_ADDR,		\
+		.bm_busy =3D IMX_OCOTP_BM_CTRL_BUSY,		\
+		.bm_error =3D IMX_OCOTP_BM_CTRL_ERROR,		\
+		.bm_rel_shadows =3D IMX_OCOTP_BM_CTRL_REL_SHADOWS,\
+	}
+
 #define TIMING_STROBE_PROG_US		10	/* Min time to blow a fuse */
 #define TIMING_STROBE_READ_NS		37	/* Min time before read */
 #define TIMING_RELAX_NS			17
@@ -62,18 +70,31 @@ struct ocotp_priv {
 	struct nvmem_config *config;
 };
=20
+struct ocotp_ctrl_reg {
+	u32 bm_addr;
+	u32 bm_busy;
+	u32 bm_error;
+	u32 bm_rel_shadows;
+};
+
 struct ocotp_params {
 	unsigned int nregs;
 	unsigned int bank_address_words;
 	void (*set_timing)(struct ocotp_priv *priv);
+	struct ocotp_ctrl_reg ctrl;
 };
=20
-static int imx_ocotp_wait_for_busy(void __iomem *base, u32 flags)
+static int imx_ocotp_wait_for_busy(struct ocotp_priv *priv, u32 flags)
 {
 	int count;
 	u32 c, mask;
+	u32 bm_ctrl_busy, bm_ctrl_error;
+	void __iomem *base =3D priv->base;
=20
-	mask =3D IMX_OCOTP_BM_CTRL_BUSY | IMX_OCOTP_BM_CTRL_ERROR | flags;
+	bm_ctrl_busy =3D priv->params->ctrl.bm_busy;
+	bm_ctrl_error =3D priv->params->ctrl.bm_error;
+
+	mask =3D bm_ctrl_busy | bm_ctrl_error | flags;
=20
 	for (count =3D 10000; count >=3D 0; count--) {
 		c =3D readl(base + IMX_OCOTP_ADDR_CTRL);
@@ -97,7 +118,7 @@ static int imx_ocotp_wait_for_busy(void __iomem *base, u=
32 flags)
 		 * - A read is performed to from a fuse word which has been read
 		 *   locked.
 		 */
-		if (c & IMX_OCOTP_BM_CTRL_ERROR)
+		if (c & bm_ctrl_error)
 			return -EPERM;
 		return -ETIMEDOUT;
 	}
@@ -105,15 +126,18 @@ static int imx_ocotp_wait_for_busy(void __iomem *base=
, u32 flags)
 	return 0;
 }
=20
-static void imx_ocotp_clr_err_if_set(void __iomem *base)
+static void imx_ocotp_clr_err_if_set(struct ocotp_priv *priv)
 {
-	u32 c;
+	u32 c, bm_ctrl_error;
+	void __iomem *base =3D priv->base;
+
+	bm_ctrl_error =3D priv->params->ctrl.bm_error;
=20
 	c =3D readl(base + IMX_OCOTP_ADDR_CTRL);
-	if (!(c & IMX_OCOTP_BM_CTRL_ERROR))
+	if (!(c & bm_ctrl_error))
 		return;
=20
-	writel(IMX_OCOTP_BM_CTRL_ERROR, base + IMX_OCOTP_ADDR_CTRL_CLR);
+	writel(bm_ctrl_error, base + IMX_OCOTP_ADDR_CTRL_CLR);
 }
=20
 static int imx_ocotp_read(void *context, unsigned int offset,
@@ -140,7 +164,7 @@ static int imx_ocotp_read(void *context, unsigned int o=
ffset,
 		return ret;
 	}
=20
-	ret =3D imx_ocotp_wait_for_busy(priv->base, 0);
+	ret =3D imx_ocotp_wait_for_busy(priv, 0);
 	if (ret < 0) {
 		dev_err(priv->dev, "timeout during read setup\n");
 		goto read_end;
@@ -157,7 +181,7 @@ static int imx_ocotp_read(void *context, unsigned int o=
ffset,
 		 * issued
 		 */
 		if (*(buf - 1) =3D=3D IMX_OCOTP_READ_LOCKED_VAL)
-			imx_ocotp_clr_err_if_set(priv->base);
+			imx_ocotp_clr_err_if_set(priv);
 	}
 	ret =3D 0;
=20
@@ -274,7 +298,7 @@ static int imx_ocotp_write(void *context, unsigned int =
offset, void *val,
 	 * write or reload must be completed before a write access can be
 	 * requested.
 	 */
-	ret =3D imx_ocotp_wait_for_busy(priv->base, 0);
+	ret =3D imx_ocotp_wait_for_busy(priv, 0);
 	if (ret < 0) {
 		dev_err(priv->dev, "timeout during timing setup\n");
 		goto write_end;
@@ -306,8 +330,8 @@ static int imx_ocotp_write(void *context, unsigned int =
offset, void *val,
 	}
=20
 	ctrl =3D readl(priv->base + IMX_OCOTP_ADDR_CTRL);
-	ctrl &=3D ~IMX_OCOTP_BM_CTRL_ADDR;
-	ctrl |=3D waddr & IMX_OCOTP_BM_CTRL_ADDR;
+	ctrl &=3D ~priv->params->ctrl.bm_addr;
+	ctrl |=3D waddr & priv->params->ctrl.bm_addr;
 	ctrl |=3D IMX_OCOTP_WR_UNLOCK;
=20
 	writel(ctrl, priv->base + IMX_OCOTP_ADDR_CTRL);
@@ -374,11 +398,11 @@ static int imx_ocotp_write(void *context, unsigned in=
t offset, void *val,
 	 * be set. It must be cleared by software before any new write access
 	 * can be issued.
 	 */
-	ret =3D imx_ocotp_wait_for_busy(priv->base, 0);
+	ret =3D imx_ocotp_wait_for_busy(priv, 0);
 	if (ret < 0) {
 		if (ret =3D=3D -EPERM) {
 			dev_err(priv->dev, "failed write to locked region");
-			imx_ocotp_clr_err_if_set(priv->base);
+			imx_ocotp_clr_err_if_set(priv);
 		} else {
 			dev_err(priv->dev, "timeout during data write\n");
 		}
@@ -394,10 +418,10 @@ static int imx_ocotp_write(void *context, unsigned in=
t offset, void *val,
 	udelay(2);
=20
 	/* reload all shadow registers */
-	writel(IMX_OCOTP_BM_CTRL_REL_SHADOWS,
+	writel(priv->params->ctrl.bm_rel_shadows,
 	       priv->base + IMX_OCOTP_ADDR_CTRL_SET);
-	ret =3D imx_ocotp_wait_for_busy(priv->base,
-				      IMX_OCOTP_BM_CTRL_REL_SHADOWS);
+	ret =3D imx_ocotp_wait_for_busy(priv,
+				      priv->params->ctrl.bm_rel_shadows);
 	if (ret < 0) {
 		dev_err(priv->dev, "timeout during shadow register reload\n");
 		goto write_end;
@@ -424,65 +448,76 @@ static const struct ocotp_params imx6q_params =3D {
 	.nregs =3D 128,
 	.bank_address_words =3D 0,
 	.set_timing =3D imx_ocotp_set_imx6_timing,
+	.ctrl =3D IMX_OCOTP_BM_CTRL_DEFAULT,
 };
=20
 static const struct ocotp_params imx6sl_params =3D {
 	.nregs =3D 64,
 	.bank_address_words =3D 0,
 	.set_timing =3D imx_ocotp_set_imx6_timing,
+	.ctrl =3D IMX_OCOTP_BM_CTRL_DEFAULT,
 };
=20
 static const struct ocotp_params imx6sll_params =3D {
 	.nregs =3D 128,
 	.bank_address_words =3D 0,
 	.set_timing =3D imx_ocotp_set_imx6_timing,
+	.ctrl =3D IMX_OCOTP_BM_CTRL_DEFAULT,
 };
=20
 static const struct ocotp_params imx6sx_params =3D {
 	.nregs =3D 128,
 	.bank_address_words =3D 0,
 	.set_timing =3D imx_ocotp_set_imx6_timing,
+	.ctrl =3D IMX_OCOTP_BM_CTRL_DEFAULT,
 };
=20
 static const struct ocotp_params imx6ul_params =3D {
 	.nregs =3D 128,
 	.bank_address_words =3D 0,
 	.set_timing =3D imx_ocotp_set_imx6_timing,
+	.ctrl =3D IMX_OCOTP_BM_CTRL_DEFAULT,
 };
=20
 static const struct ocotp_params imx6ull_params =3D {
 	.nregs =3D 64,
 	.bank_address_words =3D 0,
 	.set_timing =3D imx_ocotp_set_imx6_timing,
+	.ctrl =3D IMX_OCOTP_BM_CTRL_DEFAULT,
 };
=20
 static const struct ocotp_params imx7d_params =3D {
 	.nregs =3D 64,
 	.bank_address_words =3D 4,
 	.set_timing =3D imx_ocotp_set_imx7_timing,
+	.ctrl =3D IMX_OCOTP_BM_CTRL_DEFAULT,
 };
=20
 static const struct ocotp_params imx7ulp_params =3D {
 	.nregs =3D 256,
 	.bank_address_words =3D 0,
+	.ctrl =3D IMX_OCOTP_BM_CTRL_DEFAULT,
 };
=20
 static const struct ocotp_params imx8mq_params =3D {
 	.nregs =3D 256,
 	.bank_address_words =3D 0,
 	.set_timing =3D imx_ocotp_set_imx6_timing,
+	.ctrl =3D IMX_OCOTP_BM_CTRL_DEFAULT,
 };
=20
 static const struct ocotp_params imx8mm_params =3D {
 	.nregs =3D 256,
 	.bank_address_words =3D 0,
 	.set_timing =3D imx_ocotp_set_imx6_timing,
+	.ctrl =3D IMX_OCOTP_BM_CTRL_DEFAULT,
 };
=20
 static const struct ocotp_params imx8mn_params =3D {
 	.nregs =3D 256,
 	.bank_address_words =3D 0,
 	.set_timing =3D imx_ocotp_set_imx6_timing,
+	.ctrl =3D IMX_OCOTP_BM_CTRL_DEFAULT,
 };
=20
 static const struct of_device_id imx_ocotp_dt_ids[] =3D {
@@ -521,17 +556,17 @@ static int imx_ocotp_probe(struct platform_device *pd=
ev)
 	if (IS_ERR(priv->clk))
 		return PTR_ERR(priv->clk);
=20
-	clk_prepare_enable(priv->clk);
-	imx_ocotp_clr_err_if_set(priv->base);
-	clk_disable_unprepare(priv->clk);
-
 	priv->params =3D of_device_get_match_data(&pdev->dev);
 	imx_ocotp_nvmem_config.size =3D 4 * priv->params->nregs;
 	imx_ocotp_nvmem_config.dev =3D dev;
 	imx_ocotp_nvmem_config.priv =3D priv;
 	priv->config =3D &imx_ocotp_nvmem_config;
-	nvmem =3D devm_nvmem_register(dev, &imx_ocotp_nvmem_config);
=20
+	clk_prepare_enable(priv->clk);
+	imx_ocotp_clr_err_if_set(priv);
+	clk_disable_unprepare(priv->clk);
+
+	nvmem =3D devm_nvmem_register(dev, &imx_ocotp_nvmem_config);
=20
 	return PTR_ERR_OR_ZERO(nvmem);
 }
--=20
2.16.4

