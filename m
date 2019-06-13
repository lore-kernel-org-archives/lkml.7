Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE4ADC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C41CF2082C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:50:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kIpFm8Uc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725843AbfFMQuF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:50:05 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43534 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbfFMEHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 00:07:50 -0400
Received: by mail-pg1-f194.google.com with SMTP id f25so10121766pgv.10
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 21:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lfGAIiirWl0nq0xQZNMDSMKFfgaKJNsts8bTk+SJ4Kc=;
        b=kIpFm8Uc3gMN7cY/f4FOgPfIeA/9vYsgAIqeb8GD6KvPMC2lWIZKOD6s2OQbP4fw0U
         8AAVUUUiKsgfEoRwZRyQc7YeuxBcsWkB5ZmmTWNWMKl00ONQz6jkp53/jq0UtSOcWRCf
         S+EMJdIuhtotXqDbY2dYGqhPIP3hkQ6oE+dVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lfGAIiirWl0nq0xQZNMDSMKFfgaKJNsts8bTk+SJ4Kc=;
        b=khSiN41Nz08SNGrLLKn33GBokSDH6v1vwqFAwngjvhQ2r0ljNepV7ecVMeoLCqF1Ve
         SQmccLVy3FgPGkFBfb2AkUIW6fP4A26Nqiws6k2g4wBRnl9suE0nPMfpKitEXC38mV9W
         UmNnggQWXSW7R3qwNWXaTMLV4jUISiaf6A6TSaM09r8AlZeESpYDQmuoeFkolk0J4wSl
         8WHY8GCIbcjviZeGuUl42b7yrMXnBpJgiEisK6k9BVhpzXk93RRO3/PJ75fVBhm4Q6uy
         874NQhte5ojvQ6yL+F/RHeHRqwEVKWHirIMkxcJRPTHP1U89FAx692b1DX0vggyUonAI
         BCGg==
X-Gm-Message-State: APjAAAXPnefqgPNTtq5kfGOymsQRrD3rwkeywq2r3lRspJFsCvhLNvfZ
        6PseLwDXkw7YS8WUnc67rbczug==
X-Google-Smtp-Source: APXvYqzA8cwBTsrR0gt9uDW70cCt1Y7F0MO9epqJK78JcRhYLfxAGcVRCaUHubB2xwG8abq4iqMeZQ==
X-Received: by 2002:a17:90a:a601:: with SMTP id c1mr2704985pjq.24.1560398869389;
        Wed, 12 Jun 2019 21:07:49 -0700 (PDT)
Received: from pihsun-z840.tpe.corp.google.com ([2401:fa00:1:10:7889:7a43:f899:134c])
        by smtp.googlemail.com with ESMTPSA id a13sm956849pgh.6.2019.06.12.21.07.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 21:07:48 -0700 (PDT)
From:   Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Pi-Hsun Shih <pihsun@chromium.org>,
        Eddie Huang <eddie.huang@mediatek.com>,
        Erin Lo <erin.lo@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support),
        linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v11 5/5] arm64: dts: mt8183: add scp node
Date:   Thu, 13 Jun 2019 12:06:52 +0800
Message-Id: <20190613040708.97488-6-pihsun@chromium.org>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
In-Reply-To: <20190613040708.97488-1-pihsun@chromium.org>
References: <20190613040708.97488-1-pihsun@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eddie Huang <eddie.huang@mediatek.com>

Add scp node to mt8183 and mt8183-evb

Signed-off-by: Erin Lo <erin.lo@mediatek.com>
Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>
---
Changes from v10:
 - No change.

Changes from v9:
 - Remove extra reserve-memory-vpu_share node.

Changes from v8:
 - New patch.
---
 arch/arm64/boot/dts/mediatek/mt8183-evb.dts | 11 +++++++++++
 arch/arm64/boot/dts/mediatek/mt8183.dtsi    | 12 ++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-evb.dts b/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
index d8e555cbb5d3..e46e34ce3159 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
@@ -24,6 +24,17 @@
 	chosen {
 		stdout-path = "serial0:921600n8";
 	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+		scp_mem_reserved: scp_mem_region {
+			compatible = "shared-dma-pool";
+			reg = <0 0x50000000 0 0x2900000>;
+			no-map;
+		};
+	};
 };
 
 &auxadc {
diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index c2749c4631bc..133146b52904 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -254,6 +254,18 @@
 			clock-names = "spi", "wrap";
 		};
 
+		scp: scp@10500000 {
+			compatible = "mediatek,mt8183-scp";
+			reg = <0 0x10500000 0 0x80000>,
+			      <0 0x105c0000 0 0x5000>;
+			reg-names = "sram", "cfg";
+			interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&infracfg CLK_INFRA_SCPSYS>;
+			clock-names = "main";
+			memory-region = <&scp_mem_reserved>;
+			status = "disabled";
+		};
+
 		auxadc: auxadc@11001000 {
 			compatible = "mediatek,mt8183-auxadc",
 				     "mediatek,mt8173-auxadc";
-- 
2.22.0.rc2.383.gf4fbbf30c2-goog

