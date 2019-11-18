Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E6D9C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 21:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51A8A206DA
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 21:43:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="YSKwb2h1";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="Prm8oKfb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbfKRVn5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 16:43:57 -0500
Received: from a27-21.smtp-out.us-west-2.amazonses.com ([54.240.27.21]:56606
        "EHLO a27-21.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726739AbfKRVnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 16:43:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1574113434;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
        bh=gflz1Tnf86dtd+vmicl3ujXO2oWhimFrWupL9W+PNOs=;
        b=YSKwb2h1wZxWquq600JlwuHbEn8Pdk4it4ps8vWzGQvWXC/6qso5rHSQTzxCsnhc
        bOmcyIToNxYsRpfR3UFtpqlwdTUklxLjUCVTEIPXYbCa8IUohLw9BgWdPntGlKl42ZC
        a3sQwsLLGRRzBqV7eoMTpAMeYMrmlUgwqIUXcz10=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1574113434;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
        bh=gflz1Tnf86dtd+vmicl3ujXO2oWhimFrWupL9W+PNOs=;
        b=Prm8oKfbIoR3LQyfBbqfu2Wq0qle1N+6y5e3I8s5VzbdtLHiiv2C0Vh0HS5FJBAh
        m4I5ZcrEre3EsfzhxYbm0emTUW5o720kZeezl3R4Fn9avJMP1ReZEbcZzIsCkmrm9K2
        jZLVHg7Q65T8fgALBa5BgLIX5JZLfcqyV7Dwm/Fc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 155A7C00A22
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     bjorn.andersson@linaro.org, jhugo@codeaurora.org,
        robh+dt@kernel.org, jonathan@marek.ca
Cc:     ohad@wizery.com, mark.rutland@arm.com, p.zabel@pengutronix.de,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        agross@kernel.org, Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH 10/16] dt-bindings: remoteproc: qcom: SM8150 Add ADSP, CDSP, MPSS and SLPI support
Date:   Mon, 18 Nov 2019 21:43:54 +0000
Message-ID: <0101016e8078dad4-458c8501-93fd-4daa-8938-d01027f248cb-000000@us-west-2.amazonses.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20191118214250.14002-1-sibis@codeaurora.org>
References: <20191118214250.14002-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SES-Outgoing: 2019.11.18-54.240.27.21
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ADSP, CDSP, MPSS and SLPI compatibles for SM8150 SoC.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 .../devicetree/bindings/remoteproc/qcom,adsp.txt   | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.txt b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.txt
index 34dc1d94a78c7..9938918b2fea3 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.txt
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.txt
@@ -17,6 +17,10 @@ on the Qualcomm ADSP Hexagon core.
 		    "qcom,qcs404-wcss-pas"
 		    "qcom,sdm845-adsp-pas"
 		    "qcom,sdm845-cdsp-pas"
+		    "qcom,sm8150-adsp-pas"
+		    "qcom,sm8150-cdsp-pas"
+		    "qcom,sm8150-mpss-pas"
+		    "qcom,sm8150-slpi-pas"
 
 - interrupts-extended:
 	Usage: required
@@ -37,8 +41,12 @@ on the Qualcomm ADSP Hexagon core.
 	qcom,qcs404-cdsp-pas:
 	qcom,sdm845-adsp-pas:
 	qcom,sdm845-cdsp-pas:
+	qcom,sm8150-adsp-pas:
+	qcom,sm8150-cdsp-pas:
+	qcom,sm8150-slpi-pas:
 		    must be "wdog", "fatal", "ready", "handover", "stop-ack"
 	qcom,qcs404-wcss-pas:
+	qcom,sm8150-mpss-pas:
 		    must be "wdog", "fatal", "ready", "handover", "stop-ack",
 		    "shutdown-ack"
 
@@ -95,7 +103,13 @@ on the Qualcomm ADSP Hexagon core.
 		    must be "mx"
 	qcom,sdm845-adsp-pas:
 	qcom,sdm845-cdsp-pas:
+	qcom,sm8150-adsp-pas:
+	qcom,sm8150-cdsp-pas:
 		    must be "cx", "load_state"
+	qcom,sm8150-mpss-pas:
+		    must be "cx", "load_state", "mss"
+	qcom,sm8150-slpi-pas:
+		    must be "lcx", "lmx", "load_state"
 
 - memory-region:
 	Usage: required
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

