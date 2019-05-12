Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6A19C04AB1
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 03:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7584A21019
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 03:19:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="MrhPPpm5";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="aGWySsKU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbfELDTw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 May 2019 23:19:52 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34434 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbfELDTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 May 2019 23:19:52 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 52A816076C; Sun, 12 May 2019 03:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1557631191;
        bh=TeR6kCs8VrGftf636+9F8hCLPirBITpiLkVcR7XxvXM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MrhPPpm5YA0G8IKXR06G3lxYMj90NMKADX9CIF+2xqSkTW4gBd7+xxlG1lJlkv5rJ
         vtqBT4EyGKAIARnDM3v9ItGPjpP5+EYxgxFsMTOGoVGnkQElK25DiTMuurGxs/SwjS
         KCSP4ygI3Me9+Vy+LWFukcN+5maIPlaz60Ufh0ho=
Received: from rocky-HP-EliteBook-8460p.wlan.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rjliao@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6106360769;
        Sun, 12 May 2019 03:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1557631190;
        bh=TeR6kCs8VrGftf636+9F8hCLPirBITpiLkVcR7XxvXM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aGWySsKUOAIsFaN/ZgDX9Smvd5cO8OBBRkh+VXAmFTjN5ifasUnFMQR0USvIkuP3i
         Q25IvOXOjrUejjIryPzo1cRm8SRcli4dcr7bfL04FvJ9xzFF0o9tGoVSlvaWNgxN6Z
         c1jVuwPin8SHN7laXOlba3eEoD+7LCQqQ/jz8IyA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6106360769
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rjliao@codeaurora.org
From:   Rocky Liao <rjliao@codeaurora.org>
To:     robh+dt@kernel.org, mark.rutland@arm.com, marcel@holtmann.org,
        johan.hedberg@gmail.com, thierry.escande@linaro.org
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, bgodavar@codeaurora.org,
        Rocky Liao <rjliao@codeaurora.org>
Subject: [PATCH v4 2/2] dt-bindings: net: bluetooth: Add device property firmware-name for QCA6174
Date:   Sun, 12 May 2019 11:19:45 +0800
Message-Id: <1557631185-5167-1-git-send-email-rjliao@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1554888476-17560-1-git-send-email-rjliao@codeaurora.org>
References: <1554888476-17560-1-git-send-email-rjliao@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds an optional device property "firmware-name" to allow the
driver to load customized nvm firmware file based on this property.

Signed-off-by: Rocky Liao <rjliao@codeaurora.org>
---
Changes in v4:
  * rebased the code base and merge with latest code
---
 Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
index 7ef6118..7a3eda7 100644
--- a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
+++ b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
@@ -17,6 +17,7 @@ Optional properties for compatible string qcom,qca6174-bt:
 
  - enable-gpios: gpio specifier used to enable chip
  - clocks: clock provided to the controller (SUSCLK_32KHZ)
+ - firmware-name: specify the name of nvm firmware to load
 
 Required properties for compatible string qcom,wcn399x-bt:
 
@@ -40,6 +41,7 @@ serial@7570000 {
 
 		enable-gpios = <&pm8994_gpios 19 GPIO_ACTIVE_HIGH>;
 		clocks = <&divclk4>;
+		firmware-name = "nvm_00440302.bin";
 	};
 };
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project

