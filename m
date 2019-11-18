Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ECECC432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 17:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 737DA2186D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 17:40:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Ox29XsKd";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="FpAXiswL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbfKRRkN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 12:40:13 -0500
Received: from a27-185.smtp-out.us-west-2.amazonses.com ([54.240.27.185]:54312
        "EHLO a27-185.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726647AbfKRRkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 12:40:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1574098811;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
        bh=t7jtbgukqgNt7y/CYHVzbPdeYQ3vCuZGVCItRg7k/vw=;
        b=Ox29XsKdQAjymKCXAasO9+ZE4AQ2V2tVx8QJ2V/nin+AljbnQ7Uwj+OFUs8pDWDV
        118kzrsMgYh+6MNG148mG6P4mGlUC/MCwH8xadunbJELylMV/guxoKn9SDtoGokK2WH
        xZ1TQRTul2KFfxJAGNmUwbCPNP/SgwaLDHXvg994=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1574098811;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
        bh=t7jtbgukqgNt7y/CYHVzbPdeYQ3vCuZGVCItRg7k/vw=;
        b=FpAXiswL6kU6rKEpbtaeuUYAQodRfCMopkR2KONcBLoqpRfygpWMwXESbmLkAovI
        Tk3sllz6EK10T4pWZS0J+u/N6IBV6xWFYTex52lJbe3NoR11AdApfcMjR3pXa4Lt/7Q
        MD0AL8gTqr0ARhgEC9A9kZXetvWGRUxaO4qedy8E=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E02A2C44BE6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     bjorn.andersson@linaro.org, robh+dt@kernel.org,
        ulf.hansson@linaro.org, rnayak@codeaurora.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        mark.rutland@arm.com, swboyd@chromium.org, dianders@chromium.org,
        Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH 3/6] soc: qcom: rpmhpd: Add SM8150 RPMH power-domains
Date:   Mon, 18 Nov 2019 17:40:11 +0000
Message-ID: <0101016e7f99b99a-e1a501f1-823e-4ede-86ad-f517323c5014-000000@us-west-2.amazonses.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20191118173944.27043-1-sibis@codeaurora.org>
References: <20191118173944.27043-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SES-Outgoing: 2019.11.18-54.240.27.185
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for cx/mx/gfx/mss/ebi/mmcx power-domains found on
SM8150 SoCs.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 drivers/soc/qcom/rpmhpd.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/soc/qcom/rpmhpd.c b/drivers/soc/qcom/rpmhpd.c
index 51850cc68b701..3b109ee67a4d2 100644
--- a/drivers/soc/qcom/rpmhpd.c
+++ b/drivers/soc/qcom/rpmhpd.c
@@ -131,8 +131,44 @@ static const struct rpmhpd_desc sdm845_desc = {
 	.num_pds = ARRAY_SIZE(sdm845_rpmhpds),
 };
 
+/* SM8150 RPMH powerdomains */
+
+static struct rpmhpd sm8150_mmcx_ao;
+static struct rpmhpd sm8150_mmcx = {
+	.pd = { .name = "mmcx", },
+	.peer = &sm8150_mmcx_ao,
+	.res_name = "mmcx.lvl",
+};
+
+static struct rpmhpd sm8150_mmcx_ao = {
+	.pd = { .name = "mmcx_ao", },
+	.active_only = true,
+	.peer = &sm8150_mmcx,
+	.res_name = "mmcx.lvl",
+};
+
+static struct rpmhpd *sm8150_rpmhpds[] = {
+	[SM8150_MSS] = &sdm845_mss,
+	[SM8150_EBI] = &sdm845_ebi,
+	[SM8150_LMX] = &sdm845_lmx,
+	[SM8150_LCX] = &sdm845_lcx,
+	[SM8150_GFX] = &sdm845_gfx,
+	[SM8150_MX] = &sdm845_mx,
+	[SM8150_MX_AO] = &sdm845_mx_ao,
+	[SM8150_CX] = &sdm845_cx,
+	[SM8150_CX_AO] = &sdm845_cx_ao,
+	[SM8150_MMCX] = &sm8150_mmcx,
+	[SM8150_MMCX_AO] = &sm8150_mmcx_ao,
+};
+
+static const struct rpmhpd_desc sm8150_desc = {
+	.rpmhpds = sm8150_rpmhpds,
+	.num_pds = ARRAY_SIZE(sm8150_rpmhpds),
+};
+
 static const struct of_device_id rpmhpd_match_table[] = {
 	{ .compatible = "qcom,sdm845-rpmhpd", .data = &sdm845_desc },
+	{ .compatible = "qcom,sm8150-rpmhpd", .data = &sm8150_desc },
 	{ }
 };
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

