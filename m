Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E77CA9EB7
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 06:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B946205ED
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 06:56:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="FJV78QP7";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="RIa8dVRY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727432AbfJUG4W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 02:56:22 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:35190 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbfJUG4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 02:56:21 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 700FE60930; Mon, 21 Oct 2019 06:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571640980;
        bh=B8Tun+ms/ItaMfnpNX+5AmyDT3CYb/tuPINRTyt3ews=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FJV78QP7IR7jnxP+R6wj0uNzEEg6QXaA0opXt49CzkPe4ynoIYh0DbBrFolUU+ysT
         g8I2qLThaMUhLwNnLtnx4rlKuHWnINECTvM4T51HVE5CHlXYDKxU9vslRpVaLD+fpc
         mbenS28HzurgNmmgu+2PfH/OSgpUvIFXxPeWUhm0=
Received: from blr-ubuntu-173.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 46B9D602F0;
        Mon, 21 Oct 2019 06:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571640979;
        bh=B8Tun+ms/ItaMfnpNX+5AmyDT3CYb/tuPINRTyt3ews=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RIa8dVRYhMrInc5INF1tWOYGIxBJvCR0BLYH3YZ786/w1/bGr1kJ2tes6+gPzeaPx
         36EC3kLsa6nbQr5/a8QzPbgqKI723/yDA5urImGzdk/jsTWXhSz89iDxWdGY+KmVav
         DclmkXerR+S6KJEFWDV5cJt2TsoB0J9MhRhgRHNY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 46B9D602F0
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
From:   Rajendra Nayak <rnayak@codeaurora.org>
To:     agross@kernel.org, robh+dt@kernel.org, bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Maulik Shah <mkshah@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH v2 05/13] arm64: dts: qcom: sc7180: Add cmd_db reserved area
Date:   Mon, 21 Oct 2019 12:25:14 +0530
Message-Id: <20191021065522.24511-6-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20191021065522.24511-1-rnayak@codeaurora.org>
References: <20191021065522.24511-1-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maulik Shah <mkshah@codeaurora.org>

Command_db provides mapping for resource key and address managed
by remote processor. Add cmd_db reserved memory area.

Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
---
v2: No change

 arch/arm64/boot/dts/qcom/sc7180.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index c67d32242ca2..012ee5028bf6 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -32,6 +32,18 @@
 		};
 	};
 
+	reserved_memory: reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		cmd_db: reserved-memory@80820000 {
+			reg = <0x0 0x80820000 0x0 0x20000>;
+			compatible = "qcom,cmd-db";
+			no-map;
+		};
+	};
+
 	cpus {
 		#address-cells = <2>;
 		#size-cells = <0>;
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

