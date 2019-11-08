Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A43FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 09:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 183A821D7B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 09:29:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="CJdpC44W";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="RoZ6N96F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731270AbfKHJ3C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 04:29:02 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:37610 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726987AbfKHJ3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 04:29:00 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E5FCF60DF5; Fri,  8 Nov 2019 09:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573205339;
        bh=lrADz3jGlSpRKHX9P9Ziz5MfvYECn4vWfslrXo4IOeA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CJdpC44WFl/lTU/WUanVCX/Dm4y6ScqiuUIGrcU9VVMdGxFoPnGrfb6pHI960fi50
         ro992R8st5rWnHHx9cuiMFqOu2nG/tVugI24AUhilpjRrmZu2B/rbxJHwKWZAE94nO
         Oj5kCRcKwq7sBo5i/orDVj7hufbqtG3U18HGo1QE=
Received: from blr-ubuntu-173.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A585A60DA5;
        Fri,  8 Nov 2019 09:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573205338;
        bh=lrADz3jGlSpRKHX9P9Ziz5MfvYECn4vWfslrXo4IOeA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RoZ6N96FwaeHY+yTacDE3SbKn8Z8OF9AaE++w2gwXyL7Hc7NnMpkN2vDXhGxpTPcp
         j60NMgjSz8odDw9x2bFD3eTAcDAaZfPOfAFLiGe0mRJDi8LhIvb0kC62McqjR4Y5vn
         1UHBB84FDxwHjDOSYrUP/3VgckGf1d4F74+3V3yE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A585A60DA5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
From:   Rajendra Nayak <rnayak@codeaurora.org>
To:     agross@kernel.org, robh+dt@kernel.org, bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mka@chromium.org,
        swboyd@chromium.org, Maulik Shah <mkshah@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH v5 04/13] arm64: dts: qcom: sc7180: Add cmd_db reserved area
Date:   Fri,  8 Nov 2019 14:58:15 +0530
Message-Id: <20191108092824.9773-5-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20191108092824.9773-1-rnayak@codeaurora.org>
References: <20191108092824.9773-1-rnayak@codeaurora.org>
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
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---
 arch/arm64/boot/dts/qcom/sc7180.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index 383593142f07..af9626da4edb 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -30,6 +30,18 @@
 		};
 	};
 
+	reserved_memory: reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		aop_cmd_db_mem: memory@80820000 {
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

