Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BCD8FC6194
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 09:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EF9021D7B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 09:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="CjK8CiRO";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="iE+eNN1b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731320AbfKHJ3F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 04:29:05 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:37720 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726987AbfKHJ3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 04:29:04 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 77FAB60D5C; Fri,  8 Nov 2019 09:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573205343;
        bh=f/hj5yj7jjrgeNt8nXpWqBkIay6KPZZ6EOVtiJbZoMc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CjK8CiROVUViGV3YAt4v6SNdVGC2mnfefBg2rjXfMGr5dAPFhHUrrMUy6W4whTy4y
         LGvaNiD4IdToAxI2iJzphUjcA9Jt7cK1UBKd1n5FQSfc7SYa1GRlUNNRkdZfl7T/Ek
         Sly21YsQuWn2BzXvQUsxZA6FpbO5ZdA5oHnqrm88=
Received: from blr-ubuntu-173.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 753E760DD4;
        Fri,  8 Nov 2019 09:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573205342;
        bh=f/hj5yj7jjrgeNt8nXpWqBkIay6KPZZ6EOVtiJbZoMc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iE+eNN1b+DWdFtPLpRPQHyL8QLjrRBhuD0O8mz7yvuizygTbfHgRZXVNNKewDxKB5
         p1ctWXsjWyeJ41zuy0NWAgDb0vWkg28sG2aIAiUQs3XLcDh6qorfdL25IncsLz1RvV
         KeH+G3ypOE2b/mrIQWWy6/T/Wtsclfb3LdjYeh8U=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 753E760DD4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
From:   Rajendra Nayak <rnayak@codeaurora.org>
To:     agross@kernel.org, robh+dt@kernel.org, bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mka@chromium.org,
        swboyd@chromium.org, Maulik Shah <mkshah@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH v5 05/13] arm64: dts: qcom: sc7180: Add rpmh-rsc node
Date:   Fri,  8 Nov 2019 14:58:16 +0530
Message-Id: <20191108092824.9773-6-rnayak@codeaurora.org>
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

Add device bindings for the application processor's rsc. The rsc
contains the TCS that are used for communicating with the hardened
resource accelerators on Qualcomm Technologies, Inc. (QTI) SoCs.

Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---
 arch/arm64/boot/dts/qcom/sc7180.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index af9626da4edb..22bcff89918f 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -7,6 +7,7 @@
 
 #include <dt-bindings/clock/qcom,gcc-sc7180.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/soc/qcom,rpmh-rsc.h>
 
 / {
 	interrupt-parent = <&intc>;
@@ -386,6 +387,23 @@
 				status = "disabled";
 			};
 		};
+
+		apps_rsc: rsc@18200000 {
+			compatible = "qcom,rpmh-rsc";
+			reg = <0 0x18200000 0 0x10000>,
+			      <0 0x18210000 0 0x10000>,
+			      <0 0x18220000 0 0x10000>;
+			reg-names = "drv-0", "drv-1", "drv-2";
+			interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
+			qcom,tcs-offset = <0xd00>;
+			qcom,drv-id = <2>;
+			qcom,tcs-config = <ACTIVE_TCS  2>,
+					  <SLEEP_TCS   3>,
+					  <WAKE_TCS    3>,
+					  <CONTROL_TCS 1>;
+		};
 	};
 
 	timer {
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

