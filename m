Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8380C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 10:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7A96217D4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 10:48:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oOv+aG0g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbfDKKsQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 06:48:16 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35850 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726838AbfDKKrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 06:47:43 -0400
Received: by mail-wm1-f66.google.com with SMTP id h18so6056079wml.1;
        Thu, 11 Apr 2019 03:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4iIsSq4w5xueJD+Zm+ZuZyaOSt0w4rNwgySBcGo22Xg=;
        b=oOv+aG0g4ut0d1ZEVU6FtEqKAobVLg2RVX1DqkuSxu3ZP6zdcV9fHF+VFBdiE76K4o
         4JtmPaBH8x1h+MljkWOsYYRVM0ElhGG640M66C0Q3lNYoYrrknPh4+roIV/Kg2JDw9re
         UKvYPryCdSl+7B0YZqRN7JS8FDMccEdtgC2MH/ltFkNqWSToYzvflrbfZGqJG/RbVMDv
         d8De6wHT9awsnJLdqSzDKKdcXDgEUjtfYs6mMsC4Eot2DfHj3FxRNlBlonm4pjALtsaz
         gh6DUCuyQvvH5aj3da3kqurbxwdbpSn/yFo3Iq/j9Rdmm0p2IhOxle4LrUk48SmQM9hM
         U2nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4iIsSq4w5xueJD+Zm+ZuZyaOSt0w4rNwgySBcGo22Xg=;
        b=lZvVhnMaOMWE8iIYURPd0N85BSAOUNIWNnTxgwDfZzqiLF2/t6mFwktJ0mwa/dIFtS
         5xuPChi7dKfamTabuLgM0n7yKvb6WHnwOUwKnfLJldxkunZ0gRU6h5uM32wHM7dcqIci
         DfvnjOcphXS1uEm1HdxTruYHH0E9BOLvTWWFiz8Ni6Uuxarlj8NhwIkOX2W2f3gNAgw5
         BbPb5U5gnt/b/8n6S14ks8SnDL7quwX/v35SH2Rsj1iyU4zcI4Et8089rsOZBFIszWNG
         HFTyFZuKscZxVlyv3vQqiah4CeLoPX0mgs9yOFh1XW6GwDflmfkQPx5QDjTby35dYLmr
         TJeQ==
X-Gm-Message-State: APjAAAVLGym9JCiEU3GxH4FNIv0RmxbGDDnekA3T0DtJpaSa8DbZGMdY
        JLYzBj0m2COENP1r1b9lS/M=
X-Google-Smtp-Source: APXvYqxMhVlu18sbgQIpM6jDzAylYDoyfvPo/Zbra458MLtBy5hGswmJra+6A9NZlwknzJcjKTO+1Q==
X-Received: by 2002:a05:600c:2199:: with SMTP id e25mr6072964wme.36.1554979661261;
        Thu, 11 Apr 2019 03:47:41 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::df7e:4a05])
        by smtp.gmail.com with ESMTPSA id k4sm54987587wro.33.2019.04.11.03.47.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 03:47:40 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-sunxi@googlegroups.com,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v2 4/8] arm64: dts: allwinner: Add ARM Mali GPU node for H6
Date:   Thu, 11 Apr 2019 12:57:16 +0200
Message-Id: <20190411105720.32357-5-peron.clem@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190411105720.32357-1-peron.clem@gmail.com>
References: <20190411105720.32357-1-peron.clem@gmail.com>
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
index e0dc4a05c1ba..196753110434 100644
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

