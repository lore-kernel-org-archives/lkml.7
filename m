Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ABFCC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 09:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 432E52133D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 09:28:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="bsEq08T0";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hoJwCEMs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729917AbfDJJ2e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 05:28:34 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33990 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728687AbfDJJ2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 05:28:33 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 03F736115B; Wed, 10 Apr 2019 09:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554888513;
        bh=kL+8NYYATT/dB12MVy270oH9WAUkxjzMIw7MZgWcJAI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bsEq08T0UbzzLzgV61LTD44WEn+t7FPUneiVXAacDbOKlT7LfswCv7WtLpRVTtTyi
         htsD76eWfB93yFNtetD60C6GtShUkX0LDV/snLg9WqU/T98Jj0Uh4F2CPDKKz9AeK8
         Nzxplsd2aib9efJnbL0XgXWXiRjGM9yxOxYFFRM4=
Received: from rocky-HP-EliteBook-8460p.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rjliao@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C4E7D61112;
        Wed, 10 Apr 2019 09:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554888508;
        bh=kL+8NYYATT/dB12MVy270oH9WAUkxjzMIw7MZgWcJAI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hoJwCEMsHZLNnkQW/zpdWwgy1faFOSmkeZxPhg+VcXlWjB9jxt8K2/g58PqkdVPB2
         Lb0XH6lm6lFBJ4269mVWiN8LSH2GRsWIwl/uRfPU/9nlMRUFcNyv1oVXDf+TGM/gqg
         jLm68unwsCfOD1Tflv707IGC7ZZoinRvhjkzwIBM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C4E7D61112
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rjliao@codeaurora.org
From:   Rocky Liao <rjliao@codeaurora.org>
To:     robh+dt@kernel.org, mark.rutland@arm.com, marcel@holtmann.org,
        johan.hedberg@gmail.com, thierry.escande@linaro.org
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, bgodavar@codeaurora.org,
        Rocky Liao <rjliao@codeaurora.org>
Subject: [PATCH v3 2/2] dt-bindings: net: bluetooth: Add device property firmware-name for QCA6174
Date:   Wed, 10 Apr 2019 17:27:56 +0800
Message-Id: <1554888476-17560-1-git-send-email-rjliao@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1554368908-22017-2-git-send-email-rjliao@codeaurora.org>
References: <1554368908-22017-2-git-send-email-rjliao@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds an optional device property "firmware-name" to allow the
driver to load customized nvm firmware file based on this property.

Signed-off-by: Rocky Liao <rjliao@codeaurora.org>
---
Changes in v3:
  * added firmware-name instead of nvm-postfix to specify full firmware name
---
 Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
index 824c0e2..2bcea50 100644
--- a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
+++ b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
@@ -16,6 +16,7 @@ Optional properties for compatible string qcom,qca6174-bt:
 
  - enable-gpios: gpio specifier used to enable chip
  - clocks: clock provided to the controller (SUSCLK_32KHZ)
+ - firmware-name: specify the name of nvm firmware to load
 
 Required properties for compatible string qcom,wcn3990-bt:
 
@@ -39,6 +40,7 @@ serial@7570000 {
 
 		enable-gpios = <&pm8994_gpios 19 GPIO_ACTIVE_HIGH>;
 		clocks = <&divclk4>;
+		firmware-name = "nvm_00440302.bin";
 	};
 };
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project

