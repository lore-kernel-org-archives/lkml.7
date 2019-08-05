Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB6FC0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 10:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25C7020679
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 10:50:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="h5KXqf32"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbfHEKuK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 06:50:10 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39664 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728508AbfHEKuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 06:50:08 -0400
Received: by mail-pg1-f196.google.com with SMTP id u17so39531153pgi.6
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 03:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5l1zAX3tglSu17y0+NcdOXZzpHJOvHxR1MkiGIIYKYo=;
        b=h5KXqf32FSQbMokwSJ8p/c8n2g5wvIMvxooRpQ0DNAg2WEY1vuugf/r+2gktgjCj06
         5WYIBkDizFPNWrCnFOcfmAEBkOTTAjNIyb7UBlg7PDdC3RbES46qAFeBO2htwpagcbpp
         zqlJXAGKh3lpmz0drPRWGQKqW5kQ+x/z0vXJw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5l1zAX3tglSu17y0+NcdOXZzpHJOvHxR1MkiGIIYKYo=;
        b=ZDVTDXcLbshKEdTdDLfSMLdgUjZv01b63TAuaoFp39UDdoCIAFMAFlYi2LvORGqvm4
         Qy34tQHJvU52K5NR3h+SzaPONUVVX+hZ1r4jU/EGHLqQ88kPYRR++A+o6SF116dZQtFf
         isT+MKyxHuuOM5isLqLfXkjJqnF3ITLTdwDBIsXfVaWL3usn+vS5omtdSzKZNgdLfdEh
         PxxpHUL2/denm9dXu3pTnGc7UHAQL3vD8rfBrF0omvEIpePDhxTRti9wvwVvHKE79Ptx
         D+rI85lwODVHXAS5HlDiBwxdrRwdZ1QB+wYNq3pogDW8UBVBXNJqVH4m835biI8IMlgl
         hjwQ==
X-Gm-Message-State: APjAAAXpqFLxeU1FXGBAy7ChcLXyTSmW1LZMSOJro+4Togfxvc9i/XqM
        MHc5Zyzzk8gUgGRGQ9+/JFRsIuPsT9g=
X-Google-Smtp-Source: APXvYqwEq6/5cD4xyHXFqv3BQONYfA4Ng+lXNpMRcPk0mKjRAZiubJ1JEQ/cIp71hIsNz2fTMcls7A==
X-Received: by 2002:a17:90a:c20e:: with SMTP id e14mr15282099pjt.0.1565002207586;
        Mon, 05 Aug 2019 03:50:07 -0700 (PDT)
Received: from pihsun-z840.tpe.corp.google.com ([2401:fa00:1:10:7889:7a43:f899:134c])
        by smtp.googlemail.com with ESMTPSA id 65sm88693864pgf.30.2019.08.05.03.50.05
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 05 Aug 2019 03:50:07 -0700 (PDT)
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
Subject: [PATCH v14 5/5] arm64: dts: mt8183: add scp node
Date:   Mon,  5 Aug 2019 18:49:26 +0800
Message-Id: <20190805104932.96745-6-pihsun@chromium.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190805104932.96745-1-pihsun@chromium.org>
References: <20190805104932.96745-1-pihsun@chromium.org>
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
index c2749c4631bc..871754c2f477 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -254,6 +254,18 @@
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
2.22.0.770.g0f2c4a37fd-goog

