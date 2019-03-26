Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C35C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 11:46:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20FC42075D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 11:46:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="kuOXiCOb";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="kuOXiCOb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731457AbfCZLqV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 07:46:21 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:35816 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731416AbfCZLqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 07:46:20 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7F2B360E73; Tue, 26 Mar 2019 11:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553600778;
        bh=Vb7PSR5nGSjXM6I8nuFYiMBtzKHugK6KZocABqQ2LuI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kuOXiCObZ1TqkcEhg5IQuRQgEbY2FAJiVbUeHrNoiXvj6S15O/Bv9ifsl0rFObC6Z
         k1/XDrJkmsd7nFYGxaTjz+S/NlZVCB8Ofye03dYWpVv602Vv9r/peBx/GNp9Jb5qJj
         RfacPBe13yixAxmEr2x+7VVZatEO4ZcwIRlHOBYM=
Received: from c-hbandi-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: c-hbandi@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 38F7560312;
        Tue, 26 Mar 2019 11:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553600778;
        bh=Vb7PSR5nGSjXM6I8nuFYiMBtzKHugK6KZocABqQ2LuI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kuOXiCObZ1TqkcEhg5IQuRQgEbY2FAJiVbUeHrNoiXvj6S15O/Bv9ifsl0rFObC6Z
         k1/XDrJkmsd7nFYGxaTjz+S/NlZVCB8Ofye03dYWpVv602Vv9r/peBx/GNp9Jb5qJj
         RfacPBe13yixAxmEr2x+7VVZatEO4ZcwIRlHOBYM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 38F7560312
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
Subject: [PATCH v5 2/2] dt-bindings: net: bluetooth: Add device tree bindings for QTI chip WCN3998
Date:   Tue, 26 Mar 2019 17:15:56 +0530
Message-Id: <1553600756-8264-3-git-send-email-c-hbandi@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1553600756-8264-1-git-send-email-c-hbandi@codeaurora.org>
References: <1553600756-8264-1-git-send-email-c-hbandi@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables regulators for the Qualcomm Bluetooth WCN3998
controller.

Signed-off-by: Harish Bandi <c-hbandi@codeaurora.org>
---
Changes in V5:
- modified the DT document for wcn399x to make inline 
- in function call with driver code
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

