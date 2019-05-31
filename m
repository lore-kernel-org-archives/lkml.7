Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86ACAC28CC0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 03:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C38126274
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 03:01:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AThpnQT7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbfEaDBI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 23:01:08 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42236 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbfEaDBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 23:01:05 -0400
Received: by mail-pf1-f195.google.com with SMTP id r22so5210604pfh.9
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 20:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YgKfMwz7QEcU1FSD56lQNrLc7UNemus3Exm2ro4+YNU=;
        b=AThpnQT7lOL4lIzaJBXgzesfe4WbhqyJCN319kKrfRbfeLsSOOyQKJhbMknPnPxj67
         sOsmzOS+c7HrIkuboFE4o/7RdThXax4OFGeIur380ikyBnhSjsBAmiw7dxPB/aHgq2qa
         yn4vz0zRCyCNs0QnJtGdfoLHPkK6Xlsh+ZWxg4M9fb1QG4FBg2tUXyMw7lGCpstAtVVu
         KrDFcFnqm1GZj+8jKvxqdI0MPy37eq9ouIaffQSbCSx59mHTQucO6koj5lKGuk0YA7bF
         06xc/cjPKF44vrPQmKRhgMqjwez+3cJQa1fcoK3YWGpF2brpbnizQqhPmU4qyKhEh3+q
         FABw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YgKfMwz7QEcU1FSD56lQNrLc7UNemus3Exm2ro4+YNU=;
        b=DB8Bo7Gbu1WTmG71s5/FYdQBCV8mKTKw+WW2+8Rhzq4JLCirsFrqFMZwFKcvU6kTQH
         AcYCG57fcys0InMFpfbUlSrhWpATZuUiJyi8QJjUuZOfmqHm8Qyymnn0Km7hx8aNMGLr
         mbkjfxSPCTalxTRm6gPeQK4RTrx8qlSwq5n+0rLkDa1sttl5OsV4DazrpSKF5IHbcve8
         fBJxjFBMPnhoiV72EeKkS/kmTBtqGdTKlki+WTtwKFJs7sIeiCHJIVMG/bt8IlWKX1Bp
         7BiH/yAJGEDzs3SAMFLOrAr9rghxcexDek2vR0GTxs676G5k1kMbXszDZPVKgeg2HWdu
         wTsw==
X-Gm-Message-State: APjAAAXvV24Vk+Pky8Un2R/SBTvUlGkzZ6xxEE2SKyEn/k5WSlItXJ0D
        rJ/wqWhFqir8XtNs5nUVBw8OLQ==
X-Google-Smtp-Source: APXvYqzs8mX4E5LLFeZ/zhwCrc8qPNkYCajy/kL2bwCKS9Hm2J7SE0BT3uzcGR8/L1UlzAzBaz9J7w==
X-Received: by 2002:a65:5203:: with SMTP id o3mr6551231pgp.379.1559271665014;
        Thu, 30 May 2019 20:01:05 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id m8sm6991549pff.137.2019.05.30.20.01.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 20:01:04 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>
Cc:     David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Doug Anderson <dianders@chromium.org>,
        Arun Kumar Neelakantam <aneela@codeaurora.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 3/4] arm64: dts: qcom: Add AOSS QMP node
Date:   Thu, 30 May 2019 20:00:56 -0700
Message-Id: <20190531030057.18328-4-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190531030057.18328-1-bjorn.andersson@linaro.org>
References: <20190531030057.18328-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AOSS QMP provides a number of power domains, used for QDSS and
PIL, add the node for this.

Tested-by: Sibi Sankar <sibis@codeaurora.org>
Reviewed-by: Sibi Sankar <sibis@codeaurora.org>
Reviewed-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v7:
- None

 arch/arm64/boot/dts/qcom/sdm845.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index fcb93300ca62..b25c251b6503 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -2142,6 +2142,16 @@
 			#reset-cells = <1>;
 		};
 
+		aoss_qmp: qmp@c300000 {
+			compatible = "qcom,sdm845-aoss-qmp";
+			reg = <0 0x0c300000 0 0x100000>;
+			interrupts = <GIC_SPI 389 IRQ_TYPE_EDGE_RISING>;
+			mboxes = <&apss_shared 0>;
+
+			#clock-cells = <0>;
+			#power-domain-cells = <1>;
+		};
+
 		spmi_bus: spmi@c440000 {
 			compatible = "qcom,spmi-pmic-arb";
 			reg = <0 0x0c440000 0 0x1100>,
-- 
2.18.0

