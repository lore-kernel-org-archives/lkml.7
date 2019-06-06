Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94BE8C28D1A
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 09:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CFD820868
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 09:41:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="NlL4zF4B";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="oHSU84he"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbfFFJlP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 05:41:15 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54986 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727359AbfFFJlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 05:41:14 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id BF06660E5A; Thu,  6 Jun 2019 09:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1559814073;
        bh=ujnBF24UenfJ+PWbiBelZs5e+gKhOb5EbsqMOD7BPc8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NlL4zF4BvbsVer3NhFkytTs/YCwl4nvlkZOiTZV5KAn3Vbls5Rp9MNce/jP/myFBT
         NQbEO3f4eoLQe91bhxjOi07VyUJ6EH1HM+0xHgObACVmpi+hF3rcIHAtO3LxBKqD2/
         GgQyOwrMfzNYG6wRr6jbHAESbgTSSD7dbmAuB0nk=
Received: from rocky-HP-EliteBook-8460p.wlan.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rjliao@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3102A605FE;
        Thu,  6 Jun 2019 09:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1559814063;
        bh=ujnBF24UenfJ+PWbiBelZs5e+gKhOb5EbsqMOD7BPc8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oHSU84heqWgZ1UIZCEwGMXfTQLsimGyod2fjE1Q0xWBwL6soLbyNDQhdK4YdhG6xR
         hyHCuy0mx3ZfmZELs41ntJ2785hfiU5JUTdAh4UpSdsGcr+h838Vz2BBxUskseeUGi
         V1hV2ZE2eB3PrRVUGhQOsslqUdr+CXvtLfJpZsbE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3102A605FE
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rjliao@codeaurora.org
From:   Rocky Liao <rjliao@codeaurora.org>
To:     robh+dt@kernel.org, mark.rutland@arm.com, marcel@holtmann.org,
        johan.hedberg@gmail.com, thierry.escande@linaro.org
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, bgodavar@codeaurora.org,
        c-hbandi@codeaurora.org, Rocky Liao <rjliao@codeaurora.org>
Subject: [PATCH v6 2/2] dt-bindings: net: bluetooth: Add device property firmware-name for QCA6174
Date:   Thu,  6 Jun 2019 17:40:55 +0800
Message-Id: <1559814055-13872-1-git-send-email-rjliao@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1557919203-11055-1-git-send-email-rjliao@codeaurora.org>
References: <1557919203-11055-1-git-send-email-rjliao@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds an optional device property "firmware-name" to allow the
driver to load customized nvm firmware file based on this property.

Signed-off-by: Rocky Liao <rjliao@codeaurora.org>
---
Changes in v6:
  * Added read firmware-name property for both QCA6174 and WCN399X
---
 Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
index 7ef6118..68b67d9 100644
--- a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
+++ b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
@@ -17,6 +17,7 @@ Optional properties for compatible string qcom,qca6174-bt:
 
  - enable-gpios: gpio specifier used to enable chip
  - clocks: clock provided to the controller (SUSCLK_32KHZ)
+ - firmware-name: specify the name of nvm firmware to load
 
 Required properties for compatible string qcom,wcn399x-bt:
 
@@ -28,6 +29,7 @@ Required properties for compatible string qcom,wcn399x-bt:
 Optional properties for compatible string qcom,wcn399x-bt:
 
  - max-speed: see Documentation/devicetree/bindings/serial/slave-device.txt
+ - firmware-name: specify the name of nvm firmware to load
 
 Examples:
 
@@ -40,6 +42,7 @@ serial@7570000 {
 
 		enable-gpios = <&pm8994_gpios 19 GPIO_ACTIVE_HIGH>;
 		clocks = <&divclk4>;
+		firmware-name = "nvm_00440302.bin";
 	};
 };
 
@@ -52,5 +55,6 @@ serial@898000 {
 		vddrf-supply = <&vreg_l17a_1p3>;
 		vddch0-supply = <&vreg_l25a_3p3>;
 		max-speed = <3200000>;
+		firmware-name = "crnv21.bin";
 	};
 };
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project

