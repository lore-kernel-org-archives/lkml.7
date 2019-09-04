Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2AA6C3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 06:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB78923402
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 06:17:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hwQ0ejc7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729012AbfIDGRS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 02:17:18 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38989 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728979AbfIDGRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 02:17:16 -0400
Received: by mail-pl1-f196.google.com with SMTP id bd8so2767022plb.6
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 23:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oal3IaO/tErsls7uIk50scCx56FqEWZJT9dcXkh2oYs=;
        b=hwQ0ejc7gawIBUqdMX1cbLVlApO4fA4Mriygvn96fnvODntwLTrFDhyto/By1coVfL
         rKsVdgKTo7+0OCayATD3gwspix/ktFDP/Ut/HGTin9J74PdE4wCQqx5wNFFQ7nrAeAZl
         cMYTk8cN20mzzMHGRVDsRphub4z4ZeDAISZO0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oal3IaO/tErsls7uIk50scCx56FqEWZJT9dcXkh2oYs=;
        b=qT0XNuZOFUZVEK7GEM0Y0qOjlQ8dyMfJeOkQzQALhX2+kmUyqlrKC2pX2GwgDuclRz
         CUqka/8KJ00zQuLp1sf6s2UH2OWbz7IPcYVjmzZFFnSpazVEHOWnj9r2v7lorH6DiXD6
         nYCOPmiKaLauBdAo/8OxToR6UDlAO2DCwVxY4m3fkSOStkPUsncuMtlw43kEhldChY0k
         37r+DRsGAOuxkUH+O2RARYXIYQNtbxD3w6CqLfE2UTp6B/DJcl4ZA67Ay6vHu6R5kLaj
         ad96Xx/MZJ2Ze+jJdHvS8ENhGY3H99zMhKxc0tXxordxWkGS9J+NlwaE71QuRlMD3wiN
         pv1Q==
X-Gm-Message-State: APjAAAXhQiEeCJLZCqxu3jIbK2AO6daHGNKdIEDbPwt2kIpjFKwfan4K
        1k+jz09OnW4a9ZB3K+NSNGiniA==
X-Google-Smtp-Source: APXvYqxrOY+4WKbKVfDkYMJaSzR20/rot1ZjReA7xzONnTysPAGS6CaTgjER2YlWbqyDmzQvGoq6Pw==
X-Received: by 2002:a17:902:e407:: with SMTP id ci7mr39693277plb.326.1567577835907;
        Tue, 03 Sep 2019 23:17:15 -0700 (PDT)
Received: from pihsun-z840.tpe.corp.google.com ([2401:fa00:1:10:7889:7a43:f899:134c])
        by smtp.googlemail.com with ESMTPSA id r2sm27248750pfq.60.2019.09.03.23.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 23:17:15 -0700 (PDT)
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
Subject: [PATCH v17 5/5] arm64: dts: mt8183: add scp node
Date:   Wed,  4 Sep 2019 14:16:43 +0800
Message-Id: <20190904061649.69099-6-pihsun@chromium.org>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
In-Reply-To: <20190904061649.69099-1-pihsun@chromium.org>
References: <20190904061649.69099-1-pihsun@chromium.org>
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
Changes from v16, v15, v14:
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

