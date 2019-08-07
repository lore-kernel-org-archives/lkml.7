Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4273FC19759
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 07:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18FF0219BE
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 07:10:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="VJRiFr8d";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="VvgeK5Ju"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728529AbfHGHKn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 03:10:43 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48196 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727914AbfHGHKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 03:10:41 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6763561424; Wed,  7 Aug 2019 07:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1565161840;
        bh=heNe+iqrOyeQV3Ms255wL/v9OpwrJ6sfppxJL1Inl5o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VJRiFr8d4HebJtAgnBPoOtqzgfrzERikNusurS7ud1s/wsVNhDUMdEQFDTw7QvysT
         fZVvRwQ63oTrvW9J91+G2qqzOkTEhrHn1/j4lcpJIV/1pK7DK4jdVVKj2QCojU+ycH
         VHXY+Q9rCUpFAI5eSEU7p3xJbWSpBjw6Muv91BWg=
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D89256133A;
        Wed,  7 Aug 2019 07:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1565161836;
        bh=heNe+iqrOyeQV3Ms255wL/v9OpwrJ6sfppxJL1Inl5o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VvgeK5JuygQAXq5VgIRFikHihV2rZ1xO1ptQXkrni8SQZlf5WiZBQuAVJiGyFkMJS
         NbN872uCLg0o1JmevUou8RpMe3qFt6vg8JpiHY4Op0rjoyLmZe9Lqwzf1Ij4pSBJAR
         OBrCxH1PLdvCSenUW6fyeR7aPB15l5GADiSRpHw4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D89256133A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     bjorn.andersson@linaro.org, robh+dt@kernel.org, vkoul@kernel.org,
        aneela@codeaurora.org
Cc:     mark.rutland@arm.com, agross@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, jassisinghbrar@gmail.com,
        clew@codeaurora.org, Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH v2 5/7] mailbox: qcom: Add support for Qualcomm SM8150 and SC7180 SoCs
Date:   Wed,  7 Aug 2019 12:39:55 +0530
Message-Id: <20190807070957.30655-6-sibis@codeaurora.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190807070957.30655-1-sibis@codeaurora.org>
References: <20190807070957.30655-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the corresponding APSS shared offset for SM8150 and SC7180 SoCs.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 drivers/mailbox/qcom-apcs-ipc-mailbox.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mailbox/qcom-apcs-ipc-mailbox.c b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
index 705e17a5479cc..2dfd288fe720d 100644
--- a/drivers/mailbox/qcom-apcs-ipc-mailbox.c
+++ b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
@@ -118,7 +118,9 @@ static const struct of_device_id qcom_apcs_ipc_of_match[] = {
 	{ .compatible = "qcom,msm8996-apcs-hmss-global", .data = (void *)16 },
 	{ .compatible = "qcom,msm8998-apcs-hmss-global", .data = (void *)8 },
 	{ .compatible = "qcom,qcs404-apcs-apps-global", .data = (void *)8 },
+	{ .compatible = "qcom,sc7180-apss-shared", .data = (void *)12 },
 	{ .compatible = "qcom,sdm845-apss-shared", .data = (void *)12 },
+	{ .compatible = "qcom,sm8150-apss-shared", .data = (void *)12 },
 	{}
 };
 MODULE_DEVICE_TABLE(of, qcom_apcs_ipc_of_match);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

