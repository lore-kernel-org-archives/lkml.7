Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF28C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 04:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACF9A20836
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 04:30:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="lpRfpFaE";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="fbnpwzYW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbfLKEap (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 23:30:45 -0500
Received: from a27-56.smtp-out.us-west-2.amazonses.com ([54.240.27.56]:37066
        "EHLO a27-56.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726631AbfLKEam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 23:30:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1576038642;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
        bh=yUbcOQmZnB3OF8BOmjR64gfOmdhpbWHdIpUAKU7lamw=;
        b=lpRfpFaEVhls26tA4Qm0TxzI4q90Db7eSlvODNXtmtvrjrvJFTjwOg/KZBiDDXdk
        DIuK/6dLVI6+J0vwEOg5syVbrntJ97GeRoJao+zWJFH6OUzthVoshkONlIL1h4emupy
        S2tUm4giM6oSWSgfs35vw5EI2i+FS88IV7q/hd24=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1576038642;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
        bh=yUbcOQmZnB3OF8BOmjR64gfOmdhpbWHdIpUAKU7lamw=;
        b=fbnpwzYW3IX9qLFIcjZZzu5eofbvXqV03d6BsGhB+Pf246lgfd3NP4//FOO/L97N
        Bz1AgUU5JCCgHLKOajOTkQZvoJQYH31bx7NM9TT5HL37TioQZybjWyp2sDrCrDc9x1Y
        N7/pLSM92STkJsAaDHdGzJLtBndhXS240hy0W5EY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D9142C447A4
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: [PATCH 2/3] arm64: dts: qcom: sm8150: Add APSS watchdog node
Date:   Wed, 11 Dec 2019 04:30:41 +0000
Message-ID: <0101016ef3392fe5-e54f34cd-5571-4703-a07a-68af799c97b9-000000@us-west-2.amazonses.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1576037078.git.saiprakash.ranjan@codeaurora.org>
References: <cover.1576037078.git.saiprakash.ranjan@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SES-Outgoing: 2019.12.11-54.240.27.56
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add APSS (Application Processor Subsystem) watchdog
DT node for SM8150 SoC.

Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index 8f23fcadecb8..4224f6474a9d 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -387,6 +387,12 @@
 			#mbox-cells = <1>;
 		};
 
+		watchdog@17c10000 {
+			compatible = "qcom,apss-wdt-sm8150", "qcom,kpss-wdt";
+			reg = <0 0x17c10000 0 0x1000>;
+			clocks = <&sleep_clk>;
+		};
+
 		timer@17c20000 {
 			#address-cells = <2>;
 			#size-cells = <2>;
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

