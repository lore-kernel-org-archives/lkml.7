Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D3EC282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 17:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66304217D7
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 17:30:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LVH32cdp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733149AbfDQRa5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 13:30:57 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37671 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729641AbfDQRa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 13:30:27 -0400
Received: by mail-wr1-f66.google.com with SMTP id w10so33060502wrm.4;
        Wed, 17 Apr 2019 10:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Btaw5CgxhYac28zaC8EYgFvIIeyjC0ToJx7hPAKP9QY=;
        b=LVH32cdp2sDip8uzvIAO2wUQy1tP3Nq1rATlI61WXbGp2/rYljFC2DU+xbmv3WdTxA
         +UgwLuMPzOLok1Ro0yA2qcIfbhoPdqOflpPScLIwn13wToy5pvVEan/Ydx8IgSWO8CvK
         vpWhAKKatVVrex82N8qbCpq2pIpaKKS5nI1d7oZ20FBlou2jaPbK03JF4zPWv8+PlGMr
         PCVz+m+K3mUcNNjDGkJKa6yc6ts/wrL1teZ04pszmYY7ezR34r4ZUEYA90sJIoyc7rpB
         m9humJC5tEjHNgYw3i8wkS3Q26L+JtDKhRhoE+axSTXMziWhvPgalw86kCNxSLrGmOlE
         UA6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Btaw5CgxhYac28zaC8EYgFvIIeyjC0ToJx7hPAKP9QY=;
        b=Xb0XNDPNwpjcW4xPgsI0yBrt5mASzEzs8ULauIF91QRAFMzt+b7abGVZhtwvBLf9nd
         +WUsxbPo7uVNwXSL4B3CRRD57ep4TdvJPMcfpbLD/GakH7NV4e/z/a6CDetqkExWkqAX
         isUcUnP2bmXmEU0GLGBznjfRI4cN2eprpw3JIJv+59hcRSOUFf8ARiZW2Qh7qzmV19DL
         8o6C30GasPZiBrofbQkUQlhCLNZD88AivkC+L1z70flYLzfEKVeWbl0ll9V7fIB0Fuul
         IgHO+r+daI3Qy05Hj7V4xC0y9Xt438a3Qn7TwE0AlV5IXNR8bvkhLzxuYDTSWafJusRx
         TBig==
X-Gm-Message-State: APjAAAUtq3OQBTk2sA2+ULYM+q/VqSA95vAC5v3YOWg/2oCY4ZF41lEe
        I1r142nX5s6+DpAjmfkT2izCvrsonyQ=
X-Google-Smtp-Source: APXvYqyO1A01G9zoTN7MOlGOQ/NoSKZA3ysH220/nNVPMMVjDrjAQI2kXGd7MHy/k0W7uIb/Z9ENqQ==
X-Received: by 2002:adf:ffc2:: with SMTP id x2mr32063041wrs.86.1555522224744;
        Wed, 17 Apr 2019 10:30:24 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::df7e:4a05])
        by smtp.gmail.com with ESMTPSA id c6sm2669306wmb.21.2019.04.17.10.30.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 10:30:23 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v3 4/8] arm64: dts: allwinner: Add ARM Mali GPU node for H6
Date:   Wed, 17 Apr 2019 19:30:27 +0200
Message-Id: <20190417173031.9920-5-peron.clem@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190417173031.9920-1-peron.clem@gmail.com>
References: <20190417173031.9920-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the mali gpu node to the H6 device-tree.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index 16c5c3d0fd81..6aad06095c40 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -157,6 +157,20 @@
 			allwinner,sram = <&ve_sram 1>;
 		};
 
+		gpu: gpu@1800000 {
+			compatible = "allwinner,sun50i-h6-mali",
+				     "arm,mali-t720";
+			reg = <0x01800000 0x4000>;
+			interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "job", "mmu", "gpu";
+			clocks = <&ccu CLK_GPU>, <&ccu CLK_BUS_GPU>;
+			clock-names = "core", "bus";
+			resets = <&ccu RST_BUS_GPU>;
+			status = "disabled";
+		};
+
 		syscon: syscon@3000000 {
 			compatible = "allwinner,sun50i-h6-system-control",
 				     "allwinner,sun50i-a64-system-control";
-- 
2.17.1

