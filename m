Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E45C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 09:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 509B621D7E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 09:29:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="kYQ3zQ/f";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="KIzSqih5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731438AbfKHJ3S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 04:29:18 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:38078 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731373AbfKHJ3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 04:29:16 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2576260EE9; Fri,  8 Nov 2019 09:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573205356;
        bh=tBG2LqS2ZJFq34jELsNChhqYFzR78SApq0NhYYLWTGM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kYQ3zQ/fWR9xKvMrSazK1WdsO6jP7AwP9uEiHRM0MJARVGhts4N0sEI3fXOjFmjZ0
         Oyiaf+1mzKCGPrSQmV8DPcwHqdyE8ic7MHwiHhoOQqoUPKBGpkfP8L+4T+04O9+aPk
         zXI9/a4xquRCRAfVENA9NfPvawpq8m99zP+vQtxM=
Received: from blr-ubuntu-173.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C9A5760EE3;
        Fri,  8 Nov 2019 09:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573205355;
        bh=tBG2LqS2ZJFq34jELsNChhqYFzR78SApq0NhYYLWTGM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KIzSqih5XWLE6KqRv4WmUOspyxakIGHhJ6U5P+ud7+cKoSXtuW+h/0gwISxy5cSOj
         8RpAR+tqeayiZ+EvhSb3H0yxYtZDBYRRr+FdzqPc355/CoZlc9/dQCdklhKZLS+rcI
         2KHFQTQ7dTVoG5TEAMvIjwJZAB2XicgY8WOynfME=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C9A5760EE3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
From:   Rajendra Nayak <rnayak@codeaurora.org>
To:     agross@kernel.org, robh+dt@kernel.org, bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mka@chromium.org,
        swboyd@chromium.org, Maulik Shah <mkshah@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH v5 08/13] arm64: dts: qcom: sc7180: Add pdc interrupt controller
Date:   Fri,  8 Nov 2019 14:58:19 +0530
Message-Id: <20191108092824.9773-9-rnayak@codeaurora.org>
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

Add pdc interrupt controller for sc7180

Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---
 arch/arm64/boot/dts/qcom/sc7180.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index 22bcff89918f..6b7dd71e3315 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -201,6 +201,16 @@
 			};
 		};
 
+		pdc: interrupt-controller@b220000 {
+			compatible = "qcom,sc7180-pdc", "qcom,pdc";
+			reg = <0 0xb220000 0 0x30000>;
+			qcom,pdc-ranges = <0 480 15>, <17 497 98>,
+					  <119 634 4>, <124 639 1>;
+			#interrupt-cells = <2>;
+			interrupt-parent = <&intc>;
+			interrupt-controller;
+		};
+
 		tlmm: pinctrl@3500000 {
 			compatible = "qcom,sc7180-pinctrl";
 			reg = <0 0x03500000 0 0x300000>,
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

