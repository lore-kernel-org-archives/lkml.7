Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC611C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 07:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFE6F26515
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 07:39:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Q5wCjFWX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbfEaHje (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 03:39:34 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38627 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbfEaHj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 03:39:27 -0400
Received: by mail-pl1-f193.google.com with SMTP id f97so3667494plb.5
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 00:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ejdHdx9aJPFDTdLKuLfQa4XoPCSxip4iB0fegeYSrZY=;
        b=Q5wCjFWX0X+zb5g9028sfTh6/jgJd2eQo05xjMOOBPDXrV6g/iI4f2uvL46tPj900R
         C/0u9XYpKeRmSOSCSHy8wo0CGZJ6Y2Hpd6lG+x2lHYFvTPkVLSFCqV+8Mc1RvgE9F7dR
         1e9trXJpBMPtQB+kwjB0LE9lqF8M5eXitaXac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ejdHdx9aJPFDTdLKuLfQa4XoPCSxip4iB0fegeYSrZY=;
        b=TfAJltOJgXdS9VmF91/JRqyh9irWa4+RYKVP8IX9QG8rSxltYqwA9HWkszKG1MJIjn
         aJwkJyotRDpuDzFyu9zvNgGqkWEqFm/K0QCY66URZnslKB2AjdKLDZ11BI7mRgs87FqF
         OEPMvdRhNnURjqXO+FC3QgqQJ8Mz7ujeqORJcTfa9ipuTEE/euZXVHp10U32MC45FYMc
         HFlha96oSuVyfKOIl4CGIET+EpGWT5IW2Ehsdr7FG8TRdxOerjFBM7JvvvzBVeSFT38J
         zZDw7WvcqCZB9NXMujHxPjbLQh7j/zFKFkQLoL0bOSHHw/C6mogxIl/GA8tdO7OI+NFJ
         3z6Q==
X-Gm-Message-State: APjAAAUBoFQ0NUXeSuKhQE0Ti9iRhcKU1tjEPTDPfR9kgWzLI8VL2G13
        xhNpZnSPKMME4wQ/pFOd7r/suQ==
X-Google-Smtp-Source: APXvYqwoNtsvmCcTcLY1kQ0tL5LV8FXN4fOgbtLi9YsFY5vxCjPTuvcDxqSO9x0O0gI1118bfseHVQ==
X-Received: by 2002:a17:902:704a:: with SMTP id h10mr7466917plt.294.1559288367311;
        Fri, 31 May 2019 00:39:27 -0700 (PDT)
Received: from pihsun-z840.tpe.corp.google.com ([2401:fa00:1:10:7889:7a43:f899:134c])
        by smtp.googlemail.com with ESMTPSA id r71sm17051741pjb.2.2019.05.31.00.39.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 May 2019 00:39:26 -0700 (PDT)
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
Subject: [PATCH v9 7/7] arm64: dts: mt8183: add scp node
Date:   Fri, 31 May 2019 15:38:48 +0800
Message-Id: <20190531073848.155444-8-pihsun@chromium.org>
X-Mailer: git-send-email 2.22.0.rc1.257.g3120a18244-goog
In-Reply-To: <20190531073848.155444-1-pihsun@chromium.org>
References: <20190531073848.155444-1-pihsun@chromium.org>
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
---
Changes from v8:
 - New patch.
---
 arch/arm64/boot/dts/mediatek/mt8183-evb.dts | 18 ++++++++++++++++++
 arch/arm64/boot/dts/mediatek/mt8183.dtsi    | 12 ++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-evb.dts b/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
index d8e555cbb5d3..8dd74d7aefdb 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
@@ -24,6 +24,24 @@
 	chosen {
 		stdout-path = "serial0:921600n8";
 	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+		reserve-memory-vpu_share {
+			compatible = "mediatek,reserve-memory-vpu_share";
+			no-map;
+			size = <0 0x01400000>; /* 20 MB share mem size */
+			alignment = <0 0x1000000>;
+			alloc-ranges = <0 0x50000000 0 0x10000000>;
+		};
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
2.22.0.rc1.257.g3120a18244-goog

