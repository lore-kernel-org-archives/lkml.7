Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A026FC282E1
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 12:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B8E520811
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 12:14:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="JunldfUc";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="KFr5rwOG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387581AbfDYMOG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 08:14:06 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56116 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbfDYMOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 08:14:04 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3793960907; Thu, 25 Apr 2019 12:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556194443;
        bh=jvy+dLZ/QRgMFWI/qQuty+r9SsQmVayLp00kJWm+xnQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JunldfUcHrA/dUaKr0WFvlX2wVjnvxwHreNweHgRyVrGfuHjIzmnmpkRqirXms1bN
         VoLrtOGVKYIM7yzzGVAe8TfzXPDuZkO0IuMVjtku0H12La4f9Lv+GlJ1ZvEWLosQ+G
         7Iwq8vlUMaatYljJOMiAIBfPj/ggo53BzOTWy1NU=
Received: from c-hbandi-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: c-hbandi@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 476E260791;
        Thu, 25 Apr 2019 12:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556194442;
        bh=jvy+dLZ/QRgMFWI/qQuty+r9SsQmVayLp00kJWm+xnQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KFr5rwOGvwvhwIQ4IPajbp2Q/nDfzsZmuDELcL+vwoIU/B+DeeTBJRRqUuS2IeHfP
         wuyMQahotgdbEW7Lzoc6iQoG92Q1P17kaaQV7/Z5AhjoP5nQQeN51Am/Bgn1poE8BK
         yEtR09+srktWU0IqDV8DPCO3OzxbZ3knfZswZ0gQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 476E260791
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
Subject: [PATCH v7 2/2] dt-bindings: net: bluetooth: Add device tree bindings for QTI chip WCN3998
Date:   Thu, 25 Apr 2019 17:43:36 +0530
Message-Id: <1556194416-30842-3-git-send-email-c-hbandi@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1556194416-30842-1-git-send-email-c-hbandi@codeaurora.org>
References: <1556194416-30842-1-git-send-email-c-hbandi@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible string for the Qualcomm WCN3998 Bluetooth controller

Signed-off-by: Harish Bandi <c-hbandi@codeaurora.org>
---
Changes in V6:
- Changed Commit text
---
 Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
index 824c0e2..7ef6118 100644
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
+Required properties for compatible string qcom,wcn399x-bt:
 
  - vddio-supply: VDD_IO supply regulator handle.
  - vddxo-supply: VDD_XO supply regulator handle.
  - vddrf-supply: VDD_RF supply regulator handle.
  - vddch0-supply: VDD_CH0 supply regulator handle.
 
-Optional properties for compatible string qcom,wcn3990-bt:
+Optional properties for compatible string qcom,wcn399x-bt:
 
  - max-speed: see Documentation/devicetree/bindings/serial/slave-device.txt
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

