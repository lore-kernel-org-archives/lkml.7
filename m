Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63791C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 07:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38E9C2199C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 07:10:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ivHjCd5I";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PK7eIx5L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbfHGHKc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 03:10:32 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:47894 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728007AbfHGHKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 03:10:31 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6D60F61215; Wed,  7 Aug 2019 07:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1565161830;
        bh=SEXiFrMhY1BWCJ7yr62bgJ4XhTfOIOpQBrITjy2mpp0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ivHjCd5IFs8v3a/ZGfamWW+v+HSzRreTOFfpzVXyO2IpxH7YZKmYjdcCMAnn6SMc8
         tkLO+lxObCyy3cdIcSjlt54YiUqR5n9JcHjMszJPQ0xU+SoGVkB5WfL6stMEVGWrv3
         nnIv4kCA30pzeKDNGMycs/z84SQZrPb/aHjscKtE=
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B45A7611BF;
        Wed,  7 Aug 2019 07:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1565161828;
        bh=SEXiFrMhY1BWCJ7yr62bgJ4XhTfOIOpQBrITjy2mpp0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PK7eIx5L7ZXKsunsrWVQtnB8kR5VHQVkvLTuhlDnEma0mFBLtVlToQl/ZgEO/xDH1
         q291d1xeDvtEsafou8wIKGRocIFvw1grfsZT2mzRuUCYkxi0/wAFyKYblf1PLeMN3w
         DSuK8aAetSb8DSckoOAPnTzG8AIeeeSNftXYYWzA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B45A7611BF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     bjorn.andersson@linaro.org, robh+dt@kernel.org, vkoul@kernel.org,
        aneela@codeaurora.org
Cc:     mark.rutland@arm.com, agross@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, jassisinghbrar@gmail.com,
        clew@codeaurora.org, Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH v2 3/7] dt-bindings: firmware: scm: Add SM8150 and SC7180 support
Date:   Wed,  7 Aug 2019 12:39:53 +0530
Message-Id: <20190807070957.30655-4-sibis@codeaurora.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190807070957.30655-1-sibis@codeaurora.org>
References: <20190807070957.30655-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible for SM8150 and SC7180 SoCs.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 Documentation/devicetree/bindings/firmware/qcom,scm.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.txt b/Documentation/devicetree/bindings/firmware/qcom,scm.txt
index d19be836df533..3f29ea04b5fe9 100644
--- a/Documentation/devicetree/bindings/firmware/qcom,scm.txt
+++ b/Documentation/devicetree/bindings/firmware/qcom,scm.txt
@@ -16,7 +16,9 @@ Required properties:
  * "qcom,scm-msm8974"
  * "qcom,scm-msm8996"
  * "qcom,scm-msm8998"
+ * "qcom,scm-sc7180"
  * "qcom,scm-sdm845"
+ * "qcom,scm-sm8150"
  and:
  * "qcom,scm"
 - clocks: Specifies clocks needed by the SCM interface, if any:
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

