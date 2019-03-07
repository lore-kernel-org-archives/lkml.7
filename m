Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A598C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 00:02:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DD22206DD
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 00:02:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ddf5u3tN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfCGACi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 19:02:38 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39324 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbfCGACf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 19:02:35 -0500
Received: by mail-pg1-f193.google.com with SMTP id h8so9722093pgp.6
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 16:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7D9fT9nrITboyJ+SOXix9/gHXfGWOiHJwaPk2qVUU3c=;
        b=ddf5u3tNvdNs2EOND3azErflgszR8yihqngDsUDQiHfChHcViUpb3bqlsw2RsTDmgs
         ALIvgX5JW+QO718cnmBYYXF3IFh60xdFg/ltYWTIJ4fkGua53pKdv+MWrVap52AQJO8L
         tS3+/i4f99b7kiRVEQhw9NO/A6g55EcbQS646hMgY5PHpjMYnbpILFlIUZCxP643BXe7
         3O4hTaTqPNW+9YCUoe85KOMjWJmcmH9eO1swzQkgH0+7NT06RwngsQ/0j+R5erbkPUaf
         HVQIZ/NDNRPo5v9xYmJPaWG/9GAkGMcck14zAFH49VRObiSJWIrzD3ar2eUqp3RD1+Cw
         dM3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7D9fT9nrITboyJ+SOXix9/gHXfGWOiHJwaPk2qVUU3c=;
        b=DO29u7+OCiQK1yq5bjGGSy5ylSFD9v4uja9sD1iODVfKxK9KjT7aBAfqd11agNEH0B
         H2B8iVPGtn+nxFl3DkddJWjn0BBm0CJOesh3tfU4cMwktdS1popJufBhQv5TO/MEk4Ic
         0poJFZ3rPem56oBPFmXw5JphcNMzv/JsiBRQYe/7w0Q2ojIZVl+M6XoACqzaxx3cvZ4O
         XUetMBUYFPqMZFtY/5JQqD2F41hAqSCJa+ZTXH7JIBtckGpzaHtHiGUu11shN8zSg1Ag
         LW1VFEImTbtzIF78tRKaUvycdsvtn2enpVUUHuC0jAg8tiWqWlyvie4+H/082sEczt5z
         TWgw==
X-Gm-Message-State: APjAAAV2qeXnb7Fyy/gajaXok7ZujhX1HOxLco1w8easA1dScb7L/Y+4
        rYn3NefCcPdqV1njL0XbmhpT7w==
X-Google-Smtp-Source: APXvYqxOpnh4m3QcGsAd9vOKds2uFkHqc2JOsXpnp8z9cY9EwouRpWm/QVkYkuY+IAyNrJCZETR2qA==
X-Received: by 2002:a63:3648:: with SMTP id d69mr8777394pga.314.1551916954331;
        Wed, 06 Mar 2019 16:02:34 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id n10sm4105589pfa.139.2019.03.06.16.02.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Mar 2019 16:02:33 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] remoteproc: qcom: qdsp6-adsp: Add support for QCS404 CDSP
Date:   Wed,  6 Mar 2019 16:03:18 -0800
Message-Id: <20190307000318.1750-3-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190307000318.1750-1-bjorn.andersson@linaro.org>
References: <20190307000318.1750-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the clock list to adsp_pil_data, make the pdc_reset optional and
make the driver directly enable the xo, sleep and core clocks.

The three clocks are previously toggled through the clock controller,
but that means the same hardware block needs to be mapped in both
drivers. Making the remoteproc driver enable the clocks is a nop when
using the clock controller, but allow us to remove the clocks from the
clock controller.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/remoteproc/qcom_q6v5_adsp.c | 73 ++++++++++++++++++++++-------
 1 file changed, 55 insertions(+), 18 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5_adsp.c b/drivers/remoteproc/qcom_q6v5_adsp.c
index 1f3ef9ee493c..e953886b2eb7 100644
--- a/drivers/remoteproc/qcom_q6v5_adsp.c
+++ b/drivers/remoteproc/qcom_q6v5_adsp.c
@@ -46,11 +46,9 @@
 #define LPASS_PWR_ON_REG		0x10
 #define LPASS_HALTREQ_REG		0x0
 
-/* list of clocks required by ADSP PIL */
-static const char * const adsp_clk_id[] = {
-	"sway_cbcr", "lpass_ahbs_aon_cbcr", "lpass_ahbm_aon_cbcr",
-	"qdsp6ss_xo", "qdsp6ss_sleep", "qdsp6ss_core",
-};
+#define QDSP6SS_XO_CBCR		0x38
+#define QDSP6SS_CORE_CBCR	0x20
+#define QDSP6SS_SLEEP_CBCR	0x3c
 
 struct adsp_pil_data {
 	int crash_reason_smem;
@@ -59,6 +57,9 @@ struct adsp_pil_data {
 	const char *ssr_name;
 	const char *sysmon_name;
 	int ssctl_id;
+
+	const char **clk_ids;
+	int num_clks;
 };
 
 struct qcom_adsp {
@@ -75,7 +76,7 @@ struct qcom_adsp {
 	void __iomem *qdsp6ss_base;
 
 	struct reset_control *pdc_sync_reset;
-	struct reset_control *cc_lpass_restart;
+	struct reset_control *restart;
 
 	struct regmap *halt_map;
 	unsigned int halt_lpass;
@@ -143,7 +144,7 @@ static int qcom_adsp_shutdown(struct qcom_adsp *adsp)
 	/* Assert the LPASS PDC Reset */
 	reset_control_assert(adsp->pdc_sync_reset);
 	/* Place the LPASS processor into reset */
-	reset_control_assert(adsp->cc_lpass_restart);
+	reset_control_assert(adsp->restart);
 	/* wait after asserting subsystem restart from AOSS */
 	usleep_range(200, 300);
 
@@ -153,7 +154,7 @@ static int qcom_adsp_shutdown(struct qcom_adsp *adsp)
 	/* De-assert the LPASS PDC Reset */
 	reset_control_deassert(adsp->pdc_sync_reset);
 	/* Remove the LPASS reset */
-	reset_control_deassert(adsp->cc_lpass_restart);
+	reset_control_deassert(adsp->restart);
 	/* wait after de-asserting subsystem restart from AOSS */
 	usleep_range(200, 300);
 
@@ -192,6 +193,15 @@ static int adsp_start(struct rproc *rproc)
 		goto disable_power_domain;
 	}
 
+	/* Enable the XO clock */
+	writel(1, adsp->qdsp6ss_base + QDSP6SS_XO_CBCR);
+
+	/* Enable the QDSP6SS sleep clock */
+	writel(1, adsp->qdsp6ss_base + QDSP6SS_SLEEP_CBCR);
+
+	/* Enable the QDSP6 core clock */
+	writel(1, adsp->qdsp6ss_base + QDSP6SS_CORE_CBCR);
+
 	/* Program boot address */
 	writel(adsp->mem_phys >> 4, adsp->qdsp6ss_base + RST_EVB_REG);
 
@@ -280,8 +290,9 @@ static const struct rproc_ops adsp_ops = {
 	.load = adsp_load,
 };
 
-static int adsp_init_clock(struct qcom_adsp *adsp)
+static int adsp_init_clock(struct qcom_adsp *adsp, const char **clk_ids)
 {
+	int num_clks = 0;
 	int i, ret;
 
 	adsp->xo = devm_clk_get(adsp->dev, "xo");
@@ -292,32 +303,39 @@ static int adsp_init_clock(struct qcom_adsp *adsp)
 		return ret;
 	}
 
-	adsp->num_clks = ARRAY_SIZE(adsp_clk_id);
+	for (i = 0; clk_ids[i]; i++)
+		num_clks++;
+
+	adsp->num_clks = num_clks;
 	adsp->clks = devm_kcalloc(adsp->dev, adsp->num_clks,
 				sizeof(*adsp->clks), GFP_KERNEL);
 	if (!adsp->clks)
 		return -ENOMEM;
 
 	for (i = 0; i < adsp->num_clks; i++)
-		adsp->clks[i].id = adsp_clk_id[i];
+		adsp->clks[i].id = clk_ids[i];
 
 	return devm_clk_bulk_get(adsp->dev, adsp->num_clks, adsp->clks);
 }
 
 static int adsp_init_reset(struct qcom_adsp *adsp)
 {
-	adsp->pdc_sync_reset = devm_reset_control_get_exclusive(adsp->dev,
+	adsp->pdc_sync_reset = devm_reset_control_get_optional_exclusive(adsp->dev,
 			"pdc_sync");
 	if (IS_ERR(adsp->pdc_sync_reset)) {
 		dev_err(adsp->dev, "failed to acquire pdc_sync reset\n");
 		return PTR_ERR(adsp->pdc_sync_reset);
 	}
 
-	adsp->cc_lpass_restart = devm_reset_control_get_exclusive(adsp->dev,
-			"cc_lpass");
-	if (IS_ERR(adsp->cc_lpass_restart)) {
-		dev_err(adsp->dev, "failed to acquire cc_lpass restart\n");
-		return PTR_ERR(adsp->cc_lpass_restart);
+	adsp->restart = devm_reset_control_get_optional_exclusive(adsp->dev, "restart");
+
+	/* Fall back to the  old "cc_lpass" if "restart" is absent */
+	if (!adsp->restart)
+		adsp->restart = devm_reset_control_get_exclusive(adsp->dev, "cc_lpass");
+
+	if (IS_ERR(adsp->restart)) {
+		dev_err(adsp->dev, "failed to acquire restart\n");
+		return PTR_ERR(adsp->restart);
 	}
 
 	return 0;
@@ -415,7 +433,7 @@ static int adsp_probe(struct platform_device *pdev)
 	if (ret)
 		goto free_rproc;
 
-	ret = adsp_init_clock(adsp);
+	ret = adsp_init_clock(adsp, desc->clk_ids);
 	if (ret)
 		goto free_rproc;
 
@@ -479,9 +497,28 @@ static const struct adsp_pil_data adsp_resource_init = {
 	.ssr_name = "lpass",
 	.sysmon_name = "adsp",
 	.ssctl_id = 0x14,
+	.clk_ids = (const char*[]) {
+		"sway_cbcr", "lpass_ahbs_aon_cbcr", "lpass_ahbm_aon_cbcr",
+		"qdsp6ss_xo", "qdsp6ss_sleep", "qdsp6ss_core", NULL
+	},
+	.num_clks = 7,
+};
+
+static const struct adsp_pil_data cdsp_resource_init = {
+	.crash_reason_smem = 601,
+	.firmware_name = "cdsp.mdt",
+	.ssr_name = "cdsp",
+	.sysmon_name = "cdsp",
+	.ssctl_id = 0x17,
+	.clk_ids = (const char*[]) {
+		"sway", "tbu", "bimc", "ahb_aon", "q6ss_slave", "q6ss_master",
+		"q6_axim", NULL
+	},
+	.num_clks = 7,
 };
 
 static const struct of_device_id adsp_of_match[] = {
+	{ .compatible = "qcom,qcs404-cdsp-pil", .data = &cdsp_resource_init },
 	{ .compatible = "qcom,sdm845-adsp-pil", .data = &adsp_resource_init },
 	{ },
 };
-- 
2.18.0

