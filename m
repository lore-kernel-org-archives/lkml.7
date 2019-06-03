Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4084C46470
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 03:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD4B527B1F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 03:46:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SaLCmni6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbfFCDqe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Jun 2019 23:46:34 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33072 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726774AbfFCDqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 23:46:33 -0400
Received: by mail-pg1-f193.google.com with SMTP id h17so7478978pgv.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2019 20:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2Nsh8lQFYxZ1lBkrz/qlmC7f5LUpUHKswZjElUU2A74=;
        b=SaLCmni6iGpfWfY98SgX0KEwfmFEgiEJWUJObZVKcEj3JOVhPeqxZOex4hGKOwXyTv
         ENjJ5tXWEOumRlxS1fbhu9b6ViozkxvrqT9nO3AF1G5bDzlF2qVl+pTkKfGiQltMHy8W
         qrdt79nnngaGqxMYo4L4aEcCsr3EDMgKR6m3Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2Nsh8lQFYxZ1lBkrz/qlmC7f5LUpUHKswZjElUU2A74=;
        b=VAGskUmW0OBxrazNrqHWEydx7kBdlKtC/99UBw17aVgItKo15z5koeTMB8BVoYAhjh
         F5BW++3j1PVAW1NrSxWo/A8A7fdOoH1sRHf+pYL8PJghO/msypBq2v39Ya4e0d9rzEX3
         egEyrxSJliDJcLgOcS2hERjs/FEpUGXfkbnoFJHqyjphTYmsgl3IrOG+0233ZIsaV+2Y
         xwyVYwQP9ayoYwQCl3olo9CzQCTa8VhARYbEDFkFgPfB4tDInCI9DpUazKOl9djZGOov
         sp7CxpC7ySCxXh7CqIFZX/ktdit5fUERSFD3fKiaRYKX4C5woUsSD+maKPPO8duiH1nP
         qibw==
X-Gm-Message-State: APjAAAV1LnNqbtRm8cVzL9ouHAyNCinK2IcKCkDc9lPBRooXjkCguYJq
        wO6io5pm/ijBYYm9SXUzwCWvUA==
X-Google-Smtp-Source: APXvYqyE4Jqv+EBCxqiCTrbeSFOS+gUnYBAXLVGT25v8uqqhNSMVSxBUaC6uhzdJ8H3eGcBKH1F58w==
X-Received: by 2002:a17:90a:25af:: with SMTP id k44mr13519004pje.122.1559533592439;
        Sun, 02 Jun 2019 20:46:32 -0700 (PDT)
Received: from pihsun-z840.tpe.corp.google.com ([2401:fa00:1:10:7889:7a43:f899:134c])
        by smtp.googlemail.com with ESMTPSA id i73sm11878960pje.9.2019.06.02.20.46.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Jun 2019 20:46:31 -0700 (PDT)
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
Subject: [PATCH v10 7/7] arm64: dts: mt8183: add scp node
Date:   Mon,  3 Jun 2019 11:45:12 +0800
Message-Id: <20190603034529.154969-8-pihsun@chromium.org>
X-Mailer: git-send-email 2.22.0.rc1.257.g3120a18244-goog
In-Reply-To: <20190603034529.154969-1-pihsun@chromium.org>
References: <20190603034529.154969-1-pihsun@chromium.org>
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
2.22.0.rc1.257.g3120a18244-goog

