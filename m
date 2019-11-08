Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C840AFA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 09:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F0B921D7E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 09:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="e3juVe/4";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="GQ9D3CVH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731407AbfKHJ3P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 04:29:15 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:38014 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731373AbfKHJ3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 04:29:14 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0658960EE4; Fri,  8 Nov 2019 09:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573205354;
        bh=eex0N1Krj2urz6Wd2DuWeNvoZpsbxJpVTJ/iMcYDd58=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e3juVe/40oMvKPAY9ZHiiTLvtxCgJT8TeID8ElPsMTzUxbMNynJhsI1XcRnw+mgnn
         2WwEx1H3ao4Afkn7Ucmn+YHWtcoL7bHtSrVIKsLuqpftKuuIgEVxxw88lYE09YjXeU
         XZHzAHUafQJCv7zcXZNc6nROFzVK5v2FWd5EWjVM=
Received: from blr-ubuntu-173.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 600FD60A63;
        Fri,  8 Nov 2019 09:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573205351;
        bh=eex0N1Krj2urz6Wd2DuWeNvoZpsbxJpVTJ/iMcYDd58=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GQ9D3CVHsUlkVEp1zVNFA42nkU9VmlfHNVzdgp+pEgmRyuaqW2ohSPJ/VxpwQ6mcF
         +YHk0vtmvFf5LeS0PmTqGMnSO9B2+lQW1MyKIpv+5C0k5IfCz6mFvSMgstoOuOQLBU
         ambOu04hkKtU/vbpoY7bNDlSyfj4s0njiy8tlYv0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 600FD60A63
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
From:   Rajendra Nayak <rnayak@codeaurora.org>
To:     agross@kernel.org, robh+dt@kernel.org, bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mka@chromium.org,
        swboyd@chromium.org, Rajendra Nayak <rnayak@codeaurora.org>,
        Rob Herring <robh@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>, Marc Zyngier <maz@kernel.org>
Subject: [PATCH v5 07/13] dt-bindings: qcom,pdc: Add compatible for sc7180
Date:   Fri,  8 Nov 2019 14:58:18 +0530
Message-Id: <20191108092824.9773-8-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20191108092824.9773-1-rnayak@codeaurora.org>
References: <20191108092824.9773-1-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the compatible string for sc7180 SoC from Qualcomm.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Cc: Lina Iyer <ilina@codeaurora.org>
Cc: Marc Zyngier <maz@kernel.org>
---
 .../devicetree/bindings/interrupt-controller/qcom,pdc.txt      | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.txt b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.txt
index 8e0797cb1487..1df293953327 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.txt
@@ -17,7 +17,8 @@ Properties:
 - compatible:
 	Usage: required
 	Value type: <string>
-	Definition: Should contain "qcom,<soc>-pdc"
+	Definition: Should contain "qcom,<soc>-pdc" and "qcom,pdc"
+		    - "qcom,sc7180-pdc": For SC7180
 		    - "qcom,sdm845-pdc": For SDM845
 
 - reg:
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

