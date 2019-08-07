Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 096C7C32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 07:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6CE52199C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 07:10:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="DusIS/Qz";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="SJTad0XX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbfHGHKg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 03:10:36 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48002 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727914AbfHGHKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 03:10:35 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 458BC6134E; Wed,  7 Aug 2019 07:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1565161834;
        bh=2Mbb4/+kQYvc9UDwk6UFWOCd7q1Q1KuwGpou5Xw45Dg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DusIS/Qz/arT7gNAGvUNuTiRa4kps/nuGutfqmhehvkEWdo6VAnVx2noOXkAGBNyu
         bl5QCG3U7yALPcZLnsTcWyUEKjPRADYJaFm1zooJodY1p+QpKcfNLEGp2URapo5f3x
         6FCAVNMyUuowxvbDen0LlT1yt/DRWZyhfVsR1Tjc=
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 95102611FD;
        Wed,  7 Aug 2019 07:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1565161832;
        bh=2Mbb4/+kQYvc9UDwk6UFWOCd7q1Q1KuwGpou5Xw45Dg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SJTad0XXXNEisKkrT6Drl0OWh7CsFDfapLOfptj/XoKFX7ZaksZqmu95wqUaOkGzy
         sKrgzEL16Xh3MMuvImgV15ruUoXTPgWvt4WCuRiZVzANyN4wC3QY+w+46JwWBFCMCV
         /EnPVqIWIQ3f9EWX01eMJXF9vh016BFA46ofg5Eo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 95102611FD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     bjorn.andersson@linaro.org, robh+dt@kernel.org, vkoul@kernel.org,
        aneela@codeaurora.org
Cc:     mark.rutland@arm.com, agross@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, jassisinghbrar@gmail.com,
        clew@codeaurora.org, Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH v2 4/7] dt-bindings: mailbox: Add APSS shared for SM8150 and SC7180 SoCs
Date:   Wed,  7 Aug 2019 12:39:54 +0530
Message-Id: <20190807070957.30655-5-sibis@codeaurora.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190807070957.30655-1-sibis@codeaurora.org>
References: <20190807070957.30655-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SM8150 and SC7180 APSS shared to the list of possible bindings.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 .../devicetree/bindings/mailbox/qcom,apcs-kpss-global.txt       | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.txt b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.txt
index 1232fc9fc709c..e5a541a693e1b 100644
--- a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.txt
+++ b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.txt
@@ -12,7 +12,9 @@ platforms.
 		    "qcom,msm8996-apcs-hmss-global"
 		    "qcom,msm8998-apcs-hmss-global"
 		    "qcom,qcs404-apcs-apps-global"
+		    "qcom,sc7180-apss-shared"
 		    "qcom,sdm845-apss-shared"
+		    "qcom,sm8150-apss-shared"
 
 - reg:
 	Usage: required
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

