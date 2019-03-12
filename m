Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E883CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 12:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8D8D214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 12:23:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="aSmhBkP0";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="moz+ipj0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbfCLMXl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 08:23:41 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54276 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726733AbfCLMXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 08:23:40 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 640A960E40; Tue, 12 Mar 2019 12:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1552393419;
        bh=2/fq+sA34++wkQig1JAiEDuSvwjnAyOWoqHEb9iMlFI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aSmhBkP0ega2mgfekK3h7P9FX61qQTDS/E0YKSaSd2o2iX4URlpWAhFH32uvJeTJI
         aObawLIxNQzixHD7rGrD4VVlF53mu6h4Juu7tdyrYe01T7uClNfsFN0eAnt0bMdxaA
         flDXzNDWw6hz8mVigtaEkf8Y8VUCYu/MSWDJVEy4=
Received: from c-hbandi-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: c-hbandi@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 403AA60DB3;
        Tue, 12 Mar 2019 12:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1552393418;
        bh=2/fq+sA34++wkQig1JAiEDuSvwjnAyOWoqHEb9iMlFI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=moz+ipj0T3NxCCAt7yO0itA31YcveLRYbfcaR4eiUV5V4y3UjuhbEBME1w7UGnkLc
         AxGdZo216GMnoUwtnJiKWf25iBwWSX3y09Tan54vmQde0gm5LUP30ihmakKFc9UnN2
         st4SLP7PeP/vdlhDHUVXWYcapHFFtUlI9NRVI0MM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 403AA60DB3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=c-hbandi@codeaurora.org
From:   Harish Bandi <c-hbandi@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org, bgodavar@codeaurora.org,
        anubhavg@codeaurora.org, Harish Bandi <c-hbandi@codeaurora.org>
Subject: [PATCH v3 2/2] dt-bindings: net: bluetooth: Add device tree bindings for QTI chip wcn3998
Date:   Tue, 12 Mar 2019 17:52:59 +0530
Message-Id: <1552393379-26330-3-git-send-email-c-hbandi@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552393379-26330-1-git-send-email-c-hbandi@codeaurora.org>
References: <1552393379-26330-1-git-send-email-c-hbandi@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables regulators for the Qualcomm Bluetooth wcn3998
controller.

Signed-off-by: Harish Bandi <c-hbandi@codeaurora.org>
---
changes in v3:
- updated to latest code base.
---
 .../devicetree/bindings/net/qualcomm-bluetooth.txt        | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
index 824c0e2..1221535 100644
--- a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
+++ b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
@@ -53,3 +53,18 @@ serial@898000 {
 		max-speed = <3200000>;
 	};
 };
+
+&blsp1_uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&blsp1_uart3_default>;
+	status = "okay";
+
+	bluetooth: wcn3998-bt {
+		compatible = "qcom,wcn3998-bt";
+		vddio-supply = <&vreg_l6_1p8>;
+		vddxo-supply = <&vreg_l5_1p8>;
+		vddrf-supply = <&vreg_s5_1p35>;
+		vddch0-supply = <&vdd_ch0_3p3>;
+		max-speed = <3200000>;
+	};
+};
\ No newline at end of file
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

