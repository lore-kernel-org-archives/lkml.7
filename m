Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60453C19759
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 07:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35E4E2199C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 07:10:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="JNUsvIWx";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="JX8zkTYo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbfHGHK1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 03:10:27 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:47728 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727663AbfHGHKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 03:10:25 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E594060EA5; Wed,  7 Aug 2019 07:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1565161825;
        bh=MeooteiSYjF5ytduhc9Md6ikwA1W1L4AaBNOLJElbaA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JNUsvIWxQVclS8vBKAgWWptXKlSa9PVm0ACjNCem1MR5sOj/0zZSaAxQkUpJiZH3T
         TXGACcMonlAnpaF0RkHKJRaBS2FYm/IU99amjBTIiT/p9Wt7HnkWI2KCq+XHyg1QTz
         lB2KatS9GyxjzFKVREPTUSp4JNoUEXA20327CTyg=
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id ADB7F61195;
        Wed,  7 Aug 2019 07:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1565161824;
        bh=MeooteiSYjF5ytduhc9Md6ikwA1W1L4AaBNOLJElbaA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JX8zkTYo/RsJ2BzMipwCLPwAtl0iuIjul7/VGGig504RnbAJerPUhmLsSAi1ixUTz
         xeXDRbROETtrGYgQsbp40bveF2ys1V3h4Hof43+6Q+UCZ9cQlUXANVtJJO6MBhvEPK
         CNmu1039lQbaoNQzNypgK+3mSdjTd22FBCHZsg0o=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org ADB7F61195
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     bjorn.andersson@linaro.org, robh+dt@kernel.org, vkoul@kernel.org,
        aneela@codeaurora.org
Cc:     mark.rutland@arm.com, agross@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, jassisinghbrar@gmail.com,
        clew@codeaurora.org, Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH v2 2/7] dt-bindings: firmware: scm: re-order compatible list
Date:   Wed,  7 Aug 2019 12:39:52 +0530
Message-Id: <20190807070957.30655-3-sibis@codeaurora.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190807070957.30655-1-sibis@codeaurora.org>
References: <20190807070957.30655-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

re-order compatible list to maintain sort order.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 Documentation/devicetree/bindings/firmware/qcom,scm.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.txt b/Documentation/devicetree/bindings/firmware/qcom,scm.txt
index 41f133a4e2fa7..d19be836df533 100644
--- a/Documentation/devicetree/bindings/firmware/qcom,scm.txt
+++ b/Documentation/devicetree/bindings/firmware/qcom,scm.txt
@@ -9,13 +9,13 @@ Required properties:
 - compatible: must contain one of the following:
  * "qcom,scm-apq8064"
  * "qcom,scm-apq8084"
+ * "qcom,scm-ipq4019"
  * "qcom,scm-msm8660"
  * "qcom,scm-msm8916"
  * "qcom,scm-msm8960"
  * "qcom,scm-msm8974"
  * "qcom,scm-msm8996"
  * "qcom,scm-msm8998"
- * "qcom,scm-ipq4019"
  * "qcom,scm-sdm845"
  and:
  * "qcom,scm"
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

