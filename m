Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7975C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 11:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4A112085A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 11:37:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ZEqwZSxv";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="N5+N1qLT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730991AbfCYLhO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 07:37:14 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44538 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730972AbfCYLhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 07:37:12 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D824061AD9; Mon, 25 Mar 2019 11:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553513830;
        bh=Dz8FaXrVhpDCXbQzJbkKdLMFWrvC0wqlUNveWiT/xFQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZEqwZSxv8PR2XlPUFjNlcWyr/bMV3P6r2hN84sceUVwlG2W1sB7rXuQ9unDSFL83y
         C3QyFVOt0TKdJfKEpmhzGPtcLzFxrbg0aAaznSx1ED8qoRBjPwCVAv7eEpH6uVZQb0
         p11qXYgooguvKmH1NFNaZK+ItF//vCKW2gsiiSv4=
Received: from c-hbandi-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: c-hbandi@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 906EA619C9;
        Mon, 25 Mar 2019 11:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553513829;
        bh=Dz8FaXrVhpDCXbQzJbkKdLMFWrvC0wqlUNveWiT/xFQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N5+N1qLTGSXVnyre9OMZrftw6rJPZnKuIfKBDkkMMGSvTe125T0o3tfmWcDGvli44
         qdPjDqLsprxrOvUvld0MUqEOfBxeMHFYihKXdaQjnJ6D355AEqU5Arjfr9dicg7gBf
         qaw8IRUncQV9VTDm1TLLs+yeNcdvTTdNkof5cHzw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 906EA619C9
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=c-hbandi@codeaurora.org
From:   Harish Bandi <c-hbandi@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org, bgodavar@codeaurora.org,
        anubhavg@codeaurora.org, devicetree@vger.kernel.org,
        mark.rutland@arm.com, robh+dt@kernel.org,
        Harish Bandi <c-hbandi@codeaurora.org>
Subject: [PATCH v4 2/2] dt-bindings: net: bluetooth: Add device tree bindings for QTI chip WCN3998
Date:   Mon, 25 Mar 2019 17:06:40 +0530
Message-Id: <1553513800-27611-3-git-send-email-c-hbandi@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1553513800-27611-1-git-send-email-c-hbandi@codeaurora.org>
References: <1553513800-27611-1-git-send-email-c-hbandi@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables regulators for the Qualcomm Bluetooth WCN3998
controller.

Signed-off-by: Harish Bandi <c-hbandi@codeaurora.org>
---
Changes in V4:
- Removed new compatible WCN3998
- changed wcn3990 to wcn399* to represent wcn399* family
---
 Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
index 824c0e2..de9cefa 100644
--- a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
+++ b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
@@ -11,20 +11,21 @@ Required properties:
  - compatible: should contain one of the following:
    * "qcom,qca6174-bt"
    * "qcom,wcn3990-bt"
+   * "qcom,wcn3998-bt"
 
 Optional properties for compatible string qcom,qca6174-bt:
 
  - enable-gpios: gpio specifier used to enable chip
  - clocks: clock provided to the controller (SUSCLK_32KHZ)
 
-Required properties for compatible string qcom,wcn3990-bt:
+Required properties for compatible string qcom,wcn399*-bt:
 
  - vddio-supply: VDD_IO supply regulator handle.
  - vddxo-supply: VDD_XO supply regulator handle.
  - vddrf-supply: VDD_RF supply regulator handle.
  - vddch0-supply: VDD_CH0 supply regulator handle.
 
-Optional properties for compatible string qcom,wcn3990-bt:
+Optional properties for compatible string qcom,wcn399*-bt:
 
  - max-speed: see Documentation/devicetree/bindings/serial/slave-device.txt
 
@@ -44,7 +45,7 @@ serial@7570000 {
 
 serial@898000 {
 	bluetooth {
-		compatible = "qcom,wcn3990-bt";
+		compatible = "qcom,wcn399*-bt";
 
 		vddio-supply = <&vreg_s4a_1p8>;
 		vddxo-supply = <&vreg_l7a_1p8>;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

