Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72DEBC3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 06:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4505621743
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 06:20:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OB+Cr4Op"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731528AbfIEGUO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 02:20:14 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39254 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731490AbfIEGUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 02:20:08 -0400
Received: by mail-pl1-f196.google.com with SMTP id bd8so771861plb.6
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 23:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MAallv2ag0tJ/oPkN3Vv/AEajyCr4vKtB43rEz1b1g4=;
        b=OB+Cr4OpKagHtKG17BS58qZ+fafPWnk7TLbFByv2znvovyIxmnrGGUCeRqKRvXvNnU
         e3HHsK/ysbpiRw+t1ftQ4ongvlnN3A69/5FUP1Non+Rmn1tlbvuL0wYhL1j1Pjzyf074
         LxXCvPx6154cyqjIdJYi+6qtxJoUiDoIkq+Pk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MAallv2ag0tJ/oPkN3Vv/AEajyCr4vKtB43rEz1b1g4=;
        b=U4Gzm8huHlrajMCzIrFyJ4LCnLI81MJkoLghZ7EvueeZFkhVtYVQWYJ4QJITsiz2E5
         Rjx+AhXISmYZ1rD/wm1Tyn8OXYZr0CcjNsyditjBd1RVetNXi5ne0WUr3Xn6A6jPeNEJ
         NX047j/qt0ecn/Wo+F/cQS+HAaaeqMeevWBB79OUpS79ouKdZfPPnYKl1kyZNUFO3/D6
         ltYNPbJdhjzpCwzlQT1ykv4liMv24Ae45L1PCHuLH4vstkPYGBOlp/SAdi7l90wOa/h7
         S+ZDO3TC9yBYB8WzV/nuqB8ZbxDGC6cMoOJSVE6UuXoEWLEsSWSdcJoSClxTWA/4AV3u
         Fo1A==
X-Gm-Message-State: APjAAAUf2Mvi1GIKQzkyCVrJg/OPJtTtSTXz0S72j9KCM6jaJ2HCSUar
        MoTiMcUPYYFyv8knzoi+m9/bNA==
X-Google-Smtp-Source: APXvYqzbqhWxvDqfFLKrgcM9d+WPjh0ilYQMVNKyFjCtYRk/YUw1a5BFFJ8g/12nEgxplUEXKGIRpw==
X-Received: by 2002:a17:902:708c:: with SMTP id z12mr1644038plk.173.1567664407839;
        Wed, 04 Sep 2019 23:20:07 -0700 (PDT)
Received: from pihsun-z840.tpe.corp.google.com ([2401:fa00:1:10:7889:7a43:f899:134c])
        by smtp.googlemail.com with ESMTPSA id p14sm443445pfn.138.2019.09.04.23.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2019 23:20:07 -0700 (PDT)
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
Subject: [PATCH v19 4/4] arm64: dts: mt8183: add scp node
Date:   Thu,  5 Sep 2019 14:19:37 +0800
Message-Id: <20190905061943.242729-5-pihsun@chromium.org>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
In-Reply-To: <20190905061943.242729-1-pihsun@chromium.org>
References: <20190905061943.242729-1-pihsun@chromium.org>
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
Changes from v18, v17, v16, v15, v14:
 - No change.

Changes from v13:
 - Change the size of the cfg register region.

Changes from v12, v11, v10:
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
index 97f84aa9fc6e..3dd1b76bbaf5 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -269,6 +269,18 @@
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
 		auxadc: auxadc@11001000 {
 			compatible = "mediatek,mt8183-auxadc",
 				     "mediatek,mt8173-auxadc";
-- 
2.23.0.187.g17f5b7556c-goog

