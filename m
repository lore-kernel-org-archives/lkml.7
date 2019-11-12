Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 555C8C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 11:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E54A214E0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 11:04:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Q88zUNqM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbfKLLEl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 06:04:41 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38541 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbfKLLEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 06:04:39 -0500
Received: by mail-pg1-f193.google.com with SMTP id 15so11619689pgh.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 03:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gpsL+1OsfAr2EbSe7/d6AgWIawat7sBvrVvMWd1mlyI=;
        b=Q88zUNqMQUpbDmlFg31NtvbjEfiLkeIvDZ0qmbtAoJcLECe9708wdE4XVjMIpiIlJm
         uUxdBDo0ZlZ/1XDgsGTZGAVA/VckiGDwD7eTp5FGI09QmDiaYB10riXEcVUYxupTWFcY
         F2v/jEvdXbnBP/iXmrdqM/XMkkX7al8P20mC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gpsL+1OsfAr2EbSe7/d6AgWIawat7sBvrVvMWd1mlyI=;
        b=ug7qa+9MI9CSxOa9TQ1oNhpUxH6GMOp9U323wafEPpVoopAPz02LJicey7mDHzQzUy
         W5eeGcVpCJpg+SrADGHWPjC6smQSwJSmis10loGv0BRKhD30bSMS3MbXDHmtpNqzP8Nm
         tpinMY84i8Xni4xrgLkv3LW+cXQ3rVLZ7lRG5Vd7aXa9AOmtYxyIgxeM8+DQ0EQTRYcH
         0F73Ue1LDyrVKkdcBq/+T0Jo6nMoM64jJ+sCa5zqenAjYP2gQQYxX6sI1jPFYsLTQV2l
         ota3IHbNUdrI+68eaaXgVTTyZCh7Hma7iQJ1Tfh7AakkjsGACOv0TfyW3PHkBE05zehp
         LJaw==
X-Gm-Message-State: APjAAAVdx4E/dPCcIXtDzHzUPeIR5zktce35w3MSNK6kdHCKYvco56WD
        PN2ejLhId3YAhvkRyQse0OE72m59s9g=
X-Google-Smtp-Source: APXvYqxMiABHPJiamwCTFkQ4ycRR49FAHvMVRQSIWpI9Zma4/9WH24j4MvYSest6clRhSEMMoSwrAw==
X-Received: by 2002:a62:ac06:: with SMTP id v6mr35247435pfe.210.1573556677548;
        Tue, 12 Nov 2019 03:04:37 -0800 (PST)
Received: from pihsun-z840.tpe.corp.google.com ([2401:fa00:1:10:7889:7a43:f899:134c])
        by smtp.googlemail.com with ESMTPSA id 6sm21528389pfy.43.2019.11.12.03.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 03:04:36 -0800 (PST)
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
Subject: [PATCH v21 4/4] arm64: dts: mt8183: add scp node
Date:   Tue, 12 Nov 2019 19:03:27 +0800
Message-Id: <20191112110330.179649-5-pihsun@chromium.org>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
In-Reply-To: <20191112110330.179649-1-pihsun@chromium.org>
References: <20191112110330.179649-1-pihsun@chromium.org>
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
Changes from v20 ... v14:
 - No change.

Changes from v13:
 - Change the size of the cfg register region.

Changes from v12 ... v10:
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
index 1fb195c683c3..ddb7a7ac9655 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
@@ -24,6 +24,17 @@ memory@40000000 {
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
index 10b32471bc7b..e582f5e6691d 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -269,6 +269,18 @@ pwrap: pwrap@1000d000 {
 			clock-names = "spi", "wrap";
 		};
 
+		scp: scp@10500000 {
+			compatible = "mediatek,mt8183-scp";
+			reg = <0 0x10500000 0 0x80000>,
+			      <0 0x105c0000 0 0x19080>;
+			reg-names = "sram", "cfg";
+			interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&infracfg CLK_INFRA_SCPSYS>;
+			clock-names = "main";
+			memory-region = <&scp_mem_reserved>;
+			status = "disabled";
+		};
+
 		systimer: timer@10017000 {
 			compatible = "mediatek,mt8183-timer",
 				     "mediatek,mt6765-timer";
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

