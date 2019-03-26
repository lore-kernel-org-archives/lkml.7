Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB39C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 17:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C7562070D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 17:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HVSO81oH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731579AbfCZRF1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 13:05:27 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36272 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729693AbfCZRF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 13:05:27 -0400
Received: by mail-pg1-f195.google.com with SMTP id r124so8548126pgr.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 10:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LsLe1HrF/ojJF1oDyTC8JucVDbgZ9e7bF+XA2994fJU=;
        b=HVSO81oHItsZPvcbJ67VR6yV45MRAsWA+J1tUiXOtE3h691f6HhWfZHExLmfLhwfYr
         ZjxhhXvXEGfn5We+2Ujif+pJU0WU35MFNxM371BD/6NXVKRdaQMDCCyEeBgB6Q+ccbL0
         hqC4FnpcWX/ifac5uzbjfqc4vTjXytQRr/RvY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LsLe1HrF/ojJF1oDyTC8JucVDbgZ9e7bF+XA2994fJU=;
        b=ZdXlp5jXSGVck7KvmMcweArynDp60OoL2zxPrJ8vjCQ0iwRu11mr6EBiZIT8Gq5Mcn
         jdUsK90KhGulAsxQ7EWfKHNDROEyuDyCRuemvBnjwuWKSl/W+jKuPOHWMVpAbx6sMTgw
         lUo4pknA8i0ahJiNsQxxJ5CJcQ6cSqn/a74KScrCqYRq0LpCADjmh+F51MXKGj1cZ2tR
         cAyp7tIYhwF4Vwdl9rbuVI7LryycCMLLE2yV81Il+R9zYZkTTG/a2zI5TvzBAQ36OeJb
         HFsS2YNL2NDEXEZ09Pf98MB+Yv8T1zI+NpwSix5tel8r1k/spZZeSgNNizL7vltxdjHR
         zJCw==
X-Gm-Message-State: APjAAAWy6xYpON7mC1bmnJvOeR/cd44GysCLLwERXRbVlpq5fS/Sz8aL
        BndXIQjG/WjoT7rI2Wy34Koijg==
X-Google-Smtp-Source: APXvYqwJ+aiJxRaHVGgXu51qkRdwnCCXFqPebaF1OBVulvgkjcwWYcEvaUacnP2JuOdtAOsBUmTRoA==
X-Received: by 2002:a63:4346:: with SMTP id q67mr29516890pga.92.1553619926353;
        Tue, 26 Mar 2019 10:05:26 -0700 (PDT)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id u11sm22768433pfh.23.2019.03.26.10.05.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 26 Mar 2019 10:05:25 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Andy Gross <andy.gross@linaro.org>
Cc:     Evan Green <evgreen@chromium.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH] arm64: dts: msm8998: Add UFS phy reset
Date:   Tue, 26 Mar 2019 10:05:18 -0700
Message-Id: <20190326170518.157317-1-evgreen@chromium.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the new refactoring at [1], the UFS phy now controls its own
destiny in toggling the phy reset bit within the UFS host controller.
Add the DT pieces needed to 1) expose the reset controller from the
HC, and 2) use it from the PHY. This series is based atop linux-next
plus Marc's series at [2].

Signed-off-by: Evan Green <evgreen@chromium.org>

[1] https://lore.kernel.org/lkml/20190321171800.104681-1-evgreen@chromium.org/
[2] https://lore.kernel.org/lkml/43768d77-80b7-9cdc-b6e0-08ec4a026c21@free.fr/

---
I haven't tested this. Marc, I'm hoping you'll test this out and hijack this
patch if it needs any fixups.

 arch/arm64/boot/dts/qcom/msm8998.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index 3d0aeb3211de..d59a2c5fe83a 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -990,6 +990,7 @@
 			interrupts = <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>;
 			phys = <&ufsphy_lanes>;
 			phy-names = "ufsphy";
+			#reset-cells = <1>;
 			lanes-per-direction = <2>;
 			power-domains = <&gcc UFS_GDSC>;
 
@@ -1039,6 +1040,7 @@
 				<&gcc GCC_UFS_CLKREF_CLK>,
 				<&gcc GCC_UFS_PHY_AUX_CLK>;
 
+			resets = <&ufshc 0>;
 			ufsphy_lanes: lanes@1da7400 {
 				reg = <0x01da7400 0x128>,
 				      <0x01da7600 0x1fc>,
-- 
2.20.1

