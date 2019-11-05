Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A087CA9ED0
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 05:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 006CC2084D
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 05:22:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ZNN/Tpbx";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Ey5sY7lq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729783AbfKEFWP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 00:22:15 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:54540 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbfKEFWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 00:22:14 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 55AA660D77; Tue,  5 Nov 2019 05:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572931333;
        bh=xs9i0VSa9ACa4k7cSLN2iUfBEn4jA8IiiZGN2Q/YeqY=;
        h=From:To:Cc:Subject:Date:From;
        b=ZNN/TpbxXnKoosJEcPLI1tFIEjO3VAPQLx/yZAxQY2Tf0aEoFTIfKm3mL72jH3hS8
         ogkxVrk8xltvaaJ7tDodEWvyHWJ7hhQSCjmLVCT7YtbTBgqW2wvGGScU8rUb1f1GTN
         dzdUrZwght/8ooJB+qTq/98lMQsN/FCosJnho6QE=
Received: from kgunda-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kgunda@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 071FE6087F;
        Tue,  5 Nov 2019 05:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572931332;
        bh=xs9i0VSa9ACa4k7cSLN2iUfBEn4jA8IiiZGN2Q/YeqY=;
        h=From:To:Cc:Subject:Date:From;
        b=Ey5sY7lqKS/ZaPohQV7TVM/ptT2MqFjTHA6yIvd3kleRk/jtj4aLIm7x0jHWdmKfb
         lBRneEm3cIFEFH5Q8Nf7P3bsFJ9MbxOEH5cL+btCiL7LwW7fTr5wjQYZ64dVS6JoX5
         8puBMuPSo5xXlj5JSqXpFvtmTSEOWdklT48DWdU0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 071FE6087F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kgunda@codeaurora.org
From:   Kiran Gunda <kgunda@codeaurora.org>
To:     swboyd@chromium.org, bjorn.andersson@linaro.org,
        lee.jones@linaro.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org
Cc:     rnayak@codeaurora.org, Kiran Gunda <kgunda@codeaurora.org>
Subject: [PATCH V2] mfd: qcom-spmi-pmic: Add support for pm6150 and pm6150l
Date:   Tue,  5 Nov 2019 10:51:49 +0530
Message-Id: <1572931309-16250-1-git-send-email-kgunda@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the compatibles and PMIC ids for pm6150 and pm6150l PMICs
found on SC7180 based platforms.

Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>
---
 - Changes from V1:
   Sorted the macros and compatibles.

 Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.txt | 2 ++
 drivers/mfd/qcom-spmi-pmic.c                             | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.txt b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.txt
index 1437062..b5fc64e 100644
--- a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.txt
+++ b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.txt
@@ -32,6 +32,8 @@ Required properties:
                    "qcom,pm8998",
                    "qcom,pmi8998",
                    "qcom,pm8005",
+		   "qcom,pm6150",
+		   "qcom,pm6150l",
                    or generalized "qcom,spmi-pmic".
 - reg:             Specifies the SPMI USID slave address for this device.
                    For more information see:
diff --git a/drivers/mfd/qcom-spmi-pmic.c b/drivers/mfd/qcom-spmi-pmic.c
index e8fe705..74b7980 100644
--- a/drivers/mfd/qcom-spmi-pmic.c
+++ b/drivers/mfd/qcom-spmi-pmic.c
@@ -34,6 +34,8 @@
 #define PM8998_SUBTYPE		0x14
 #define PMI8998_SUBTYPE		0x15
 #define PM8005_SUBTYPE		0x18
+#define PM6150_SUBTYPE		0x28
+#define PM6150L_SUBTYPE		0x27
 
 static const struct of_device_id pmic_spmi_id_table[] = {
 	{ .compatible = "qcom,spmi-pmic", .data = (void *)COMMON_SUBTYPE },
@@ -53,6 +55,8 @@
 	{ .compatible = "qcom,pm8998",    .data = (void *)PM8998_SUBTYPE },
 	{ .compatible = "qcom,pmi8998",   .data = (void *)PMI8998_SUBTYPE },
 	{ .compatible = "qcom,pm8005",    .data = (void *)PM8005_SUBTYPE },
+	{ .compatible = "qcom,pm6150",    .data = (void *)PM6150_SUBTYPE },
+	{ .compatible = "qcom,pm6150l",   .data = (void *)PM6150L_SUBTYPE },
 	{ }
 };
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
 a Linux Foundation Collaborative Project

