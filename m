Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03440C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 11:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE2F9208C2
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 11:01:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Qrsrtear";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="lZGbAX4a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408280AbfFLLBR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 07:01:17 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38292 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406773AbfFLLBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 07:01:15 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 843F060E41; Wed, 12 Jun 2019 11:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1560337275;
        bh=STT5Zacpmn1Tzxc7n0fxRUbKEiHnd7ZXgLIR/YseG54=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QrsrtearuLOmlb3jyo5FUJrFK8eAN/vPCe6NzN98C1kmmEfLonhU+1hRlWt4Fqrw0
         1g3Hg8p+gas8mE7sq8XVAoJtcvhystalgUCp96eMvEvgjcyD0lak3IwMLwjfqg5oc5
         pF3XpbthCnjU83Mhmdyrlgw5SawfH+pXVLHKGp/w=
Received: from blr-ubuntu-288.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: nishakumari@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BED4C60DAB;
        Wed, 12 Jun 2019 11:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1560337274;
        bh=STT5Zacpmn1Tzxc7n0fxRUbKEiHnd7ZXgLIR/YseG54=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lZGbAX4aiz3TPNdgeImwu3pilZhC1ORM74uKaQVzoJu2/XDQcsELjbr73kYots7NR
         kK/ss+C03DQNj84nTHTV3Wn5Rarvb0BEX+lwiE0GtnRE8Dq9YvIXqZsgY1oQskVWUU
         3zKWOPqB4ZZ7uajE6Urj/oeJqPe8/IK3Hypvuy84=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BED4C60DAB
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=nishakumari@codeaurora.org
From:   Nisha Kumari <nishakumari@codeaurora.org>
To:     bjorn.andersson@linaro.org, broonie@kernel.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        agross@kernel.org
Cc:     lgirdwood@gmail.com, mark.rutland@arm.com, david.brown@linaro.org,
        linux-kernel@vger.kernel.org, kgunda@codeaurora.org,
        rnayak@codeaurora.org, Nisha Kumari <nishakumari@codeaurora.org>
Subject: [PATCH 2/4] arm64: dts: qcom: pmi8998: Add nodes for LAB and IBB regulators
Date:   Wed, 12 Jun 2019 16:30:50 +0530
Message-Id: <1560337252-27193-3-git-send-email-nishakumari@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1560337252-27193-1-git-send-email-nishakumari@codeaurora.org>
References: <1560337252-27193-1-git-send-email-nishakumari@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds devicetree nodes for LAB and IBB regulators.

Signed-off-by: Nisha Kumari <nishakumari@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/pmi8998.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pmi8998.dtsi b/arch/arm64/boot/dts/qcom/pmi8998.dtsi
index da3285e..6c8539f 100644
--- a/arch/arm64/boot/dts/qcom/pmi8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmi8998.dtsi
@@ -36,5 +36,27 @@
 		reg = <0x3 SPMI_USID>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+
+		labibb: qcom-lab-ibb-regulator {
+			compatible = "qcom,lab-ibb-regulator";
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			ibb_regulator: qcom,ibb@dc00 {
+				reg = <0xdc00>;
+				regulator-name = "ibb_reg";
+
+				interrupts = <0x3 0xdc 0x2 IRQ_TYPE_EDGE_RISING>;
+				interrupt-names = "ibb-sc-err";
+			};
+
+			lab_regulator: qcom,lab@de00 {
+				reg = <0xde00>;
+				regulator-name = "lab_reg";
+
+				interrupts = <0x3 0xde 0x0 IRQ_TYPE_EDGE_RISING>;
+				interrupt-names = "lab-sc-err";
+			};
+		};
 	};
 };
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

