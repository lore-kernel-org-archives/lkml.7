Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AD0FC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 13:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C27A2206A3
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 13:56:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="bazxwUXf";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Vcrlu8NI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbfDZN43 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 09:56:29 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48338 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbfDZN41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 09:56:27 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5EDB460770; Fri, 26 Apr 2019 13:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556286986;
        bh=4FBBQRmUGuacHR6BqyvmerXZQsx6ZmHXRFdrwfWhthU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bazxwUXfHNF/bY6VOTy9kj4c9XDacMo/bK0bNM2iXhGV2mpVN/4FJrTNadjmjgQ3d
         oYV8Pc7zrWA0zRoCt2Sj7FR//6C67wUx4rUP8h4fqEtO5nqxI8e6KJLQWLUokTcF7F
         teLGQRM9S/DDXGETBYM+ucery+41unt8GNi0XwjA=
Received: from c-hbandi-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: c-hbandi@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B667860770;
        Fri, 26 Apr 2019 13:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556286985;
        bh=4FBBQRmUGuacHR6BqyvmerXZQsx6ZmHXRFdrwfWhthU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vcrlu8NIMIeeTlUo60Zxlg4pt1ObH6lJu/vQiD7dCSf42zXi0LYxVfwpHMLCV2D80
         DQQYUmxzNMBWf0a8kEZ5X61KDGRrFfCYEvuvaon6f8AXtGJTdKxuGTi0cucaZDVGaE
         LIYXlnvQj7QFPxHSep6cnKhUMeu9QZM5zgBJm0XQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B667860770
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
Subject: [PATCH v8 2/2] dt-bindings: net: bluetooth: Add device tree bindings for QTI chip WCN3998
Date:   Fri, 26 Apr 2019 19:26:02 +0530
Message-Id: <1556286962-3132-3-git-send-email-c-hbandi@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1556286962-3132-1-git-send-email-c-hbandi@codeaurora.org>
References: <1556286962-3132-1-git-send-email-c-hbandi@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible string for the Qualcomm WCN3998 Bluetooth controller

Signed-off-by: Harish Bandi <c-hbandi@codeaurora.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes in V7:
- Added robh reviewed by tag in commit text
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

