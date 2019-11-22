Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 946C9C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 23:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AF7320706
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 23:31:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="UOEMVFHJ";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="DgnsHuP/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbfKVXbx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 18:31:53 -0500
Received: from a27-11.smtp-out.us-west-2.amazonses.com ([54.240.27.11]:38832
        "EHLO a27-11.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726735AbfKVXbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 18:31:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1574465511;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        bh=o+LH9HwYJtl6AvafAe/yG6jV7U6wpVWP6EbR+x6D88w=;
        b=UOEMVFHJbV7I0utUYthKxwbSiwvpzrLepaT/It9Tt6R6rmXEgdFtphjEspp0jt+Q
        VZ/c4f94yWD+3ZLW+UNvye74Q9/jOFWjR9ZZc6Ij4tQ0gH4aUHA13ENUIgJUnhwibF+
        dkdZLouWjTHjkVl8Sj3e1irs571Pc+IK7X/krvC0=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1574465511;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:Feedback-ID;
        bh=o+LH9HwYJtl6AvafAe/yG6jV7U6wpVWP6EbR+x6D88w=;
        b=DgnsHuP/a2qwdF/oNLe8ARH+4tgl62xxjhYPZPB2c21Sfh8sNUeXZYwQ/WXgq1f4
        rhug3GSgB6tFkkoVOWYSzPOAAcXinvVeSMTRb2admJxkb+DRe+fFMQqcdPpLYAWNHqg
        4H2H+vBNnoImA1RzJBsNDW4tooYjmaPkcwpaoAIE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A9946C433A2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     iommu@lists.linux-foundation.org
Cc:     robin.murphy@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v2 1/8] dt-bindings: arm-smmu: Add Adreno GPU variant
Date:   Fri, 22 Nov 2019 23:31:51 +0000
Message-ID: <0101016e95751ea5-da4da251-ddba-4017-9258-b2cfd4e06f7f-000000@us-west-2.amazonses.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574465484-7115-1-git-send-email-jcrouse@codeaurora.org>
References: <1574465484-7115-1-git-send-email-jcrouse@codeaurora.org>
X-SES-Outgoing: 2019.11.22-54.240.27.11
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a compatible string to identify SMMUs that are attached
to Adreno GPU devices that wish to support split pagetables.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---

 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index 6515dbe..db9f826 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -31,6 +31,12 @@ properties:
               - qcom,sdm845-smmu-v2
           - const: qcom,smmu-v2
 
+      - description: Qcom Adreno GPU SMMU iplementing split pagetables
+        items:
+          - enum:
+              - qcom,adreno-smmu-v2
+          - const: qcom,smmu-v2
+
       - description: Qcom SoCs implementing "arm,mmu-500"
         items:
           - enum:
-- 
2.7.4

