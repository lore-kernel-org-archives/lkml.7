Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF6A3C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 12:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B57A7206B8
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 12:07:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Zo6gMqj8";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="XmTFD9kz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728356AbfG2MHO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 08:07:14 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37694 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728297AbfG2MHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 08:07:10 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B999B60E73; Mon, 29 Jul 2019 12:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1564402029;
        bh=yESQEjxs/UF7jQlnePfCZrAc502Wc240TBy0w7/zWvM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zo6gMqj8GgfRq7bbt0D+/wP0VNMXwt96yUCn8XVI95GPKBu8z72ecCP/f8UrT+cec
         l+0MnTEotVc95VMKONY2yIAvYbl8RriqMnl1JzwadljnVuPOZOZfmZBEXeXdtUPZT6
         AoNM1VBduFBGFchlksCCZ0mfYjAcCGJxXr34negs=
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C0742601B4;
        Mon, 29 Jul 2019 12:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1564402028;
        bh=yESQEjxs/UF7jQlnePfCZrAc502Wc240TBy0w7/zWvM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XmTFD9kzbNNuOrY5vlf1SNHzGzUNb7kPogIxibjUnbdqt46SUw8pb68Dkqh3jqf+Y
         YnHT3u5P60yyFCES/7Hv9TRfAuYBnzUV+tBJWz7nsMc3idVdv50iDYDPQ0lr7arW3Q
         69PIsc6q6v7YuCPvZGhfY2etV3/jKbo+08Mgd4us=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C0742601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     bjorn.andersson@linaro.org, robh+dt@kernel.org, vkoul@kernel.org,
        aneela@codeaurora.org
Cc:     mark.rutland@arm.com, agross@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, jassisinghbrar@gmail.com,
        clew@codeaurora.org, Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH 6/6] soc: qcom: aoss: Add AOSS QMP support
Date:   Mon, 29 Jul 2019 17:36:33 +0530
Message-Id: <20190729120633.20451-7-sibis@codeaurora.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729120633.20451-1-sibis@codeaurora.org>
References: <20190729120633.20451-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add AOSS QMP support for SM8150 and SC7180 SoCs.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 drivers/soc/qcom/qcom_aoss.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/soc/qcom/qcom_aoss.c b/drivers/soc/qcom/qcom_aoss.c
index 5f885196f4d0f..e2f8c7c9a5a0a 100644
--- a/drivers/soc/qcom/qcom_aoss.c
+++ b/drivers/soc/qcom/qcom_aoss.c
@@ -462,6 +462,8 @@ static int qmp_remove(struct platform_device *pdev)
 
 static const struct of_device_id qmp_dt_match[] = {
 	{ .compatible = "qcom,sdm845-aoss-qmp", },
+	{ .compatible = "qcom,sm8150-aoss-qmp", },
+	{ .compatible = "qcom,sc7180-aoss-qmp", },
 	{}
 };
 MODULE_DEVICE_TABLE(of, qmp_dt_match);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

