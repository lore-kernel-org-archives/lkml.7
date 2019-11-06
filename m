Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC1CC5DF64
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 06:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D5AC217D7
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 06:51:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="YOJHg07/";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="cjc1fz3F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731170AbfKFGvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 01:51:04 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:45094 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbfKFGvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 01:51:03 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 981096121B; Wed,  6 Nov 2019 06:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573023062;
        bh=V4WmtBm/quYvY+EKwMP2zlhtoRoFHftEBTZz5MhvZgY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YOJHg07/HNe4hLGSabykHCfX+TMfqdplbC94XlldRODft7oax4MIOW46aFJ6s9Eth
         8LgwwFFVARX5jL4L4Q4DkXubXfXlWuduKEG9jS2rmGkv7ixafZT/JwBfKrhUPoQzfL
         Pd47b78+mx5mW2zF+smLPMzORtHjwY8Fd6wW86ik=
Received: from blr-ubuntu-173.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1DC6C6121B;
        Wed,  6 Nov 2019 06:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573023061;
        bh=V4WmtBm/quYvY+EKwMP2zlhtoRoFHftEBTZz5MhvZgY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cjc1fz3FJEu2cnIr3s7nH50g6X3QL9O4dPU6tpsAzvsqCgWdzhjoshHlGlDpstncZ
         MCC9weyv5Bh2EpQeIxUB1F4oVI+K3kGZ7idHjUu7qy3+XZVbNO7Bb0d7iUH4mOM5sm
         jE513FP9Or37Ow76qov+kw6oobyXRVfOOxADZLi0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1DC6C6121B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
From:   Rajendra Nayak <rnayak@codeaurora.org>
To:     agross@kernel.org, robh+dt@kernel.org, bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mka@chromium.org,
        swboyd@chromium.org, Rajendra Nayak <rnayak@codeaurora.org>,
        Joerg Roedel <joro@8bytes.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v4 03/14] dt-bindings: arm-smmu: update binding for qcom sc7180 SoC
Date:   Wed,  6 Nov 2019 12:20:06 +0530
Message-Id: <20191106065017.22144-4-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20191106065017.22144-1-rnayak@codeaurora.org>
References: <20191106065017.22144-1-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the soc specific compatible for sc7180 smmu-500

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Mark Rutland <mark.rutland@arm.com>
---
v4: Updated yaml, sorted.

 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index 3b31b4802a54..6515dbe47508 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -34,6 +34,7 @@ properties:
       - description: Qcom SoCs implementing "arm,mmu-500"
         items:
           - enum:
+              - qcom,sc7180-smmu-500
               - qcom,sdm845-smmu-500
           - const: arm,mmu-500
       - items:
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

