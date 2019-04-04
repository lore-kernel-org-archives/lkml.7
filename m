Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E00BC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1BFC2177E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:08:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="oD4KNDhl";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="RNidpODG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732741AbfDDJI5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:08:57 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48006 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732512AbfDDJIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:08:52 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B18A7619C9; Thu,  4 Apr 2019 09:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554368932;
        bh=Z81iXYjkOYj5XvxYYmB9iw/+ZWNQ1R56Utmi3+lDtn4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oD4KNDhlchSSZlTnsaosCpYh3QTKjptT3wkkpm01PhffnAIDTa8bHvEt4abffK5cU
         eyLhAiUmYtUHXrF0gHBxsqg/Nm9MSQHs6DeSAe3r23ogZkZJaV23s2Y7HN/zbL3a9V
         d2rw4FIW+J9HvX3BYFGBMGYG92LHDplb6UezK10Q=
Received: from rocky-HP-EliteBook-8460p.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rjliao@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 32ECF619B4;
        Thu,  4 Apr 2019 09:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554368929;
        bh=Z81iXYjkOYj5XvxYYmB9iw/+ZWNQ1R56Utmi3+lDtn4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RNidpODGenRS6E2hVTh/Jr6E+oYmR9yNIRGJMO8Hb6KEEp50ESlmsGXliaIWuaMec
         +eOjrI6HPSxAEvvdotuW29+Y4cJIFd74mcZ51QX60J8qIFtccjFWYsPV9UCPewDKcr
         CrnB0J8mDzSLaYeYUW4CJjdWuswn1MwLXqJpcEW0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 32ECF619B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rjliao@codeaurora.org
From:   Rocky Liao <rjliao@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bgodavar@codeaurora.org, Rocky Liao <rjliao@codeaurora.org>
Subject: [PATCH v2 2/2] dt-bindings: net: bluetooth: Add device property nvm-postfix for QCA6174
Date:   Thu,  4 Apr 2019 17:08:28 +0800
Message-Id: <1554368908-22017-2-git-send-email-rjliao@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1554368908-22017-1-git-send-email-rjliao@codeaurora.org>
References: <1554359858-21049-1-git-send-email-rjliao@codeaurora.org>
 <1554368908-22017-1-git-send-email-rjliao@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchs patch adds an optional device property nvm-postfix to allow the
driver to load customized nvm file based on this property

Signed-off-by: Rocky Liao <rjliao@codeaurora.org>
---
Changes in v2:
  * added the property to the document file
    Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
  * fixed coding style warnings
  * moved the nvm-postfix to the last entry of the qca_serdev
---
 Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
index 824c0e2..70cda4b 100644
--- a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
+++ b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
@@ -16,6 +16,7 @@ Optional properties for compatible string qcom,qca6174-bt:
 
  - enable-gpios: gpio specifier used to enable chip
  - clocks: clock provided to the controller (SUSCLK_32KHZ)
+ - nvm-postfix: nvm file postfix to load customized nvm file
 
 Required properties for compatible string qcom,wcn3990-bt:
 
@@ -39,6 +40,7 @@ serial@7570000 {
 
 		enable-gpios = <&pm8994_gpios 19 GPIO_ACTIVE_HIGH>;
 		clocks = <&divclk4>;
+		nvm-postfix = "i2s";
 	};
 };
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project

