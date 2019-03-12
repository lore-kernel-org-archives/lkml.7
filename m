Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F559C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F486213A2
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:14:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="H5wjMcJy";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="mHJxj16D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbfCLSO0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 14:14:26 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58650 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbfCLSOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 14:14:20 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E369E61CC5; Tue, 12 Mar 2019 18:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1552414459;
        bh=gvKE9Gn+LhYE/7yYVNegmkYny91RgmV05gJf1qgucNE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H5wjMcJy5L1y83PIgcewZsYueakIHdX59s4NT1wfcvfuTb/TciBlp3UbQIoafzW+e
         Dl92YBM7bFbfAsYxY8UIDry+HnNGW0gkMGIjz0BIpe1Tu7m0+IxKjYj0G3EKc7yN5h
         D+kIraIe68YSeBAipJem57SkQON7+RrcIArcbZ7c=
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7FD25619CF;
        Tue, 12 Mar 2019 18:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1552414454;
        bh=gvKE9Gn+LhYE/7yYVNegmkYny91RgmV05gJf1qgucNE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mHJxj16DmYG2hRI9zUupVB+e8ZIfVTNGAcc7Jl4MHlCEUvD4gl2mhfA0VaBXe056W
         7ou3JlkR0suuR4m9yS3IQXehhS+pDj5y8OUNgfdH3j+vtTZrL6qX8kKDECvXRCS4A5
         w8T44+KCih6Q/MfexT85ag88KhWIkJyFR/adS69M=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7FD25619CF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     freedreno@lists.freedesktop.org
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Gross <andy.gross@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v1 4/4] arm64: dts: sdm845: Add zap shader region for GPU
Date:   Tue, 12 Mar 2019 12:13:42 -0600
Message-Id: <1552414422-9568-5-git-send-email-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1552414422-9568-1-git-send-email-jcrouse@codeaurora.org>
References: <1552414422-9568-1-git-send-email-jcrouse@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some Adreno GPU targets require a special zap shader to bring the GPU
out of secure mode. Define a region to allocate and store the zap
shader.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---

 arch/arm64/boot/dts/qcom/sdm845.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index fed7a29..526456d 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -100,6 +100,11 @@
 			no-map;
 		};
 
+		zap_shader_region: memory@8c415000 {
+			reg = <0 0x8c415000 0 0x2000>;
+			no-map;
+		};
+
 		mpss_region: memory@8e000000 {
 			reg = <0 0x8e000000 0 0x7800000>;
 			no-map;
@@ -109,6 +114,8 @@
 			reg = <0 0x96500000 0 0x200000>;
 			no-map;
 		};
+
+
 	};
 
 	cpus {
@@ -1514,6 +1521,10 @@
 
 			qcom,gmu = <&gmu>;
 
+			zap-shader {
+				memory-region = <&zap_shader_region>;
+			};
+
 			gpu_opp_table: opp-table {
 				compatible = "operating-points-v2";
 
-- 
2.7.4

