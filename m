Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37DEDC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 19:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12D112339D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 19:06:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="JmGGSHOG";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Qg0TuwlY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730701AbfHTTGq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 15:06:46 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45150 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730657AbfHTTGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 15:06:43 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id DF4DE60F3C; Tue, 20 Aug 2019 19:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566328002;
        bh=zzjtL5wslsQS8yWsr2CKph8GttmF/LKM4t/Yy33PQbM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JmGGSHOGPovm0LqZtDwvxCWxW+kXqIdyBZeTz8qZK9g7OlcX1ZUWJAhzeOIweqfkO
         XlV2UzEXl5V6DDYEix+Z3dKV9mzm5uj3gkCfedr2nbksxAa/A7uCElMOPWiXDW0ExQ
         SD7/BFxrRmppyV76P9SUo1xRdmVNyjYguVR4/qVw=
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C9FEB60E40;
        Tue, 20 Aug 2019 19:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566328001;
        bh=zzjtL5wslsQS8yWsr2CKph8GttmF/LKM4t/Yy33PQbM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qg0TuwlYiNw6G05Dy5nOOSnh4PuCp/NgTjhzAREkbQU0ac+BrGd9PGFZygmo85kQe
         C5rXdpyWGH4ojSU1ynbdTZOJweG81C5ZS5HeLIPtAFFh9Xb5U7dEGDwMv5646bE3CJ
         bwi9cwYDHojU/JleqC8XYl2s89+adAx2Fa7YPbTA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C9FEB60E40
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     freedreno@lists.freedesktop.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 2/7] dt-bindings: arm-smmu: Add Adreno GPU variant
Date:   Tue, 20 Aug 2019 13:06:27 -0600
Message-Id: <1566327992-362-3-git-send-email-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1566327992-362-1-git-send-email-jcrouse@codeaurora.org>
References: <1566327992-362-1-git-send-email-jcrouse@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a compatible string to identify SMMUs that are attached
to Adreno GPU devices that wish to support split pagetables.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---

 Documentation/devicetree/bindings/iommu/arm,smmu.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
index 3133f3b..3b07896 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
@@ -18,6 +18,7 @@ conditions.
                         "arm,mmu-500"
                         "cavium,smmu-v2"
                         "qcom,smmu-v2"
+			"qcom,adreno-smmu-v2"
 
                   depending on the particular implementation and/or the
                   version of the architecture implemented.
@@ -31,6 +32,12 @@ conditions.
                   as below, SoC-specific compatibles:
                   "qcom,sdm845-smmu-500", "arm,mmu-500"
 
+		  "qcom,adreno-smmu-v2" is a special implementation for
+		  SMMU devices attached to the Adreno GPU on Qcom devices.
+		  If selected, this will enable split pagetable (TTBR1)
+		  support. Only use this if the GPU target is capable of
+		  supporting 64 bit addresses.
+
 - reg           : Base address and size of the SMMU.
 
 - #global-interrupts : The number of global interrupts exposed by the
-- 
2.7.4

