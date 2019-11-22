Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF76C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 23:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 223CC20714
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 23:32:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="disZq4cn";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="EneNzmGI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfKVXcJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 18:32:09 -0500
Received: from a27-10.smtp-out.us-west-2.amazonses.com ([54.240.27.10]:45290
        "EHLO a27-10.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726638AbfKVXcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 18:32:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1574465526;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        bh=IT10Q4XCr31Jq/WEe8X5Birx5D7BngHgTwImSyhbjdU=;
        b=disZq4cn/7LAiGPK9RHafcaoJEQUHNjSvZGKOI/Hf1SoIGWc5f4MTgDBuJt3WrvC
        oNceeCDRaeRlua7mNayCbVepGMBt9GfKiLwFGlVMVAurslUbbq3j92lxXqF8CqZ+2G3
        c2ugAezHz43folUXt7WRX79JNHnLbIGHA+gBtvms=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1574465526;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:Feedback-ID;
        bh=IT10Q4XCr31Jq/WEe8X5Birx5D7BngHgTwImSyhbjdU=;
        b=EneNzmGIftyTd8kPwyY/s09m3FbxTPJWjVuUb4FE1XNrg5VhmKzDypMXfv/+0QM/
        IEkzU01dQ6fzLnlMErpp/ScevCLJU7/+fE+5yRj4/5vdl73HVlJDupwLzLiXQGqMMVv
        34bDlNkfbYmkwrVO4TuMZM8usJ2eYLawSiyaJEI8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 365FCC48B0E
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     iommu@lists.linux-foundation.org
Cc:     robin.murphy@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 8/8] arm64: dts: qcom: sdm845:  Update Adreno GPU SMMU compatible string
Date:   Fri, 22 Nov 2019 23:32:06 +0000
Message-ID: <0101016e95755b09-51ea3058-7760-41f8-b0fa-bec58077c068-000000@us-west-2.amazonses.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574465484-7115-1-git-send-email-jcrouse@codeaurora.org>
References: <1574465484-7115-1-git-send-email-jcrouse@codeaurora.org>
X-SES-Outgoing: 2019.11.22-54.240.27.10
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add "qcom,adreno-smmu-v2" compatible string for the Adreno GPU SMMU node
to enable split pagetable support.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---

 arch/arm64/boot/dts/qcom/sdm845.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index ddb1f23..d90ba6eda 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -2869,7 +2869,7 @@
 		};
 
 		adreno_smmu: iommu@5040000 {
-			compatible = "qcom,sdm845-smmu-v2", "qcom,smmu-v2";
+			compatible = "qcom,adreno-smmu-v2", "qcom,smmu-v2";
 			reg = <0 0x5040000 0 0x10000>;
 			#iommu-cells = <1>;
 			#global-interrupts = <2>;
-- 
2.7.4

