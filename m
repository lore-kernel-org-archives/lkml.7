Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC9EC433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 07:10:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 319A8219BE
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 07:10:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PPymO7oT";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="SPRbSQpJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387412AbfHGHKt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 03:10:49 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48350 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727914AbfHGHKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 03:10:45 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A9EB061515; Wed,  7 Aug 2019 07:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1565161844;
        bh=lEXtBwDbznT4w9layBhb8XMkCCQd09VYslbVW/Av92g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PPymO7oTVCXDUzoFNuef7gDwt+cfudtz12DYjx8eEiW4XGXHeqUjfnrLoZhor4SbW
         ox2tBtDU1fTcUup8x0Oc4HylgC5jHXoR94KoacOYZ6y7gLz7L4WUXb1WrTw8Nj++xI
         bhw417iv/RiVEQD6Ed2ZQCS9air2ULUTlidsINQ8=
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E327D613A7;
        Wed,  7 Aug 2019 07:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1565161840;
        bh=lEXtBwDbznT4w9layBhb8XMkCCQd09VYslbVW/Av92g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SPRbSQpJWvnNW28NskYGm3aEEqfmBo+5ziXwNxuyJFr8MH7FM3rQrlNMcBfV9M1x6
         HdD+0v80AiV+rBY2y3vx7H02M81DoKWbbEXTsp8uxFSPbS9tBlKrpNZlndyUTelUeC
         27iD2+XsYIrTDsO83GukYTdHjyhHzg2BA0REcW/U=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E327D613A7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     bjorn.andersson@linaro.org, robh+dt@kernel.org, vkoul@kernel.org,
        aneela@codeaurora.org
Cc:     mark.rutland@arm.com, agross@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, jassisinghbrar@gmail.com,
        clew@codeaurora.org, Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH v2 6/7] dt-bindings: soc: qcom: aoss: Add SM8150 and SC7180 support
Date:   Wed,  7 Aug 2019 12:39:56 +0530
Message-Id: <20190807070957.30655-7-sibis@codeaurora.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190807070957.30655-1-sibis@codeaurora.org>
References: <20190807070957.30655-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SM8150 and SC7180 AOSS QMP to the list of possible bindings.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.txt
index 954ffee0a9c45..4fc571e78f018 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.txt
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.txt
@@ -15,7 +15,10 @@ power-domains.
 - compatible:
 	Usage: required
 	Value type: <string>
-	Definition: must be "qcom,sdm845-aoss-qmp"
+	Definition: must be one of:
+		    "qcom,sc7180-aoss-qmp"
+		    "qcom,sdm845-aoss-qmp"
+		    "qcom,sm8150-aoss-qmp"
 
 - reg:
 	Usage: required
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

