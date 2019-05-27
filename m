Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B85C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 20:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F67F2133F
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 20:15:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jjj410Ze"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbfE0UP1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 16:15:27 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39567 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727406AbfE0UPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 16:15:15 -0400
Received: by mail-wr1-f66.google.com with SMTP id e2so9109387wrv.6;
        Mon, 27 May 2019 13:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=73BBHLN3/j83VURt6icEiGox4hUhqX1WgPxiVFKyQjI=;
        b=Jjj410ZeHWwlayFNF0jrGAPFyOoTQiP1kjbcBvmAQ/e3GaAcESI59VKdqX1RP6RL5Z
         mmrcWuuPCm1Qg4/gZOvi7gs5P3CdqpCovoiTAGhX5c1dvdR9wZNEL55pit+tZmdL2cM7
         DIzsd01uhPa/GA3lh1keC6C0hhx03CSmsE1HRPPIrge4A30Bf/+mmA29Sl74UNM0i/Hs
         /thGaDiaoyWegb4n/9HeErnDwSCtRKuIEXC/z7VEG41Wyv+y7F0q3kVKgSffA808mCcV
         QRO+7aYhLRubWPEczcjGnU9oJIGGjAOiWBUaho31KnC4Wh2l69gI0XaOTFUC5hgyzuxU
         wx7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=73BBHLN3/j83VURt6icEiGox4hUhqX1WgPxiVFKyQjI=;
        b=HMV45skVy+yZzdR5KvoGkKKV5EEsVdK6qkhvVHY498i13WoT0ZM5U5o53Ssq5gjNho
         jfnXaNhMGaIOxwIlw6YvgyFgJ4473X5pr5afe7CJyaKOXTfL98fZwBOfb3rWiAG5Wx7h
         Usz8guKWcZwxa9UqjLH9VZP9NPUhhOfZCXvP7IAKOk2K5daO6cEOcOdAO9MrfcTfazUY
         q7sqEfiRf3MsKYkBWKBmMaFkHN9H1NfIRm8whBNh1q6fanvneHDBBwEzr0ivs/Vkt6NO
         yG2uHF7p8k7/BYDZq0fZ0O7RLrdfq2Q+bZ2HBfUq8fvUDW0VL6IvnW9TqWNZMByrV3Ms
         qiJQ==
X-Gm-Message-State: APjAAAVEz5uYUVFwKMd5cuuGR3w+CKCUlHfGyeGE1jJUCHxQzUz/ywfy
        VH0DoR7Q8a3qBE9b39egNXJMsHbc9yPe9w==
X-Google-Smtp-Source: APXvYqw1x6X+1tOy2nRxBSSrXmDfeXwrAz5IFs9NcfUGfl99IeNgcxaVX24W7F5DRobRLswT46Lh0A==
X-Received: by 2002:a5d:4d84:: with SMTP id b4mr31631083wru.102.1558988112645;
        Mon, 27 May 2019 13:15:12 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::4e2b:d7ca])
        by smtp.gmail.com with ESMTPSA id i27sm347146wmb.16.2019.05.27.13.15.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 May 2019 13:15:11 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v3 6/7] arm64: dts: allwinner: h6: Add DMA node
Date:   Mon, 27 May 2019 22:14:58 +0200
Message-Id: <20190527201459.20130-7-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190527201459.20130-1-peron.clem@gmail.com>
References: <20190527201459.20130-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jernej Skrabec <jernej.skrabec@siol.net>

H6 has DMA controller which supports 16 channels.

Add a node for it.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index 16c5c3d0fd81..f4ea596c82ce 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -208,6 +208,18 @@
 			reg = <0x03006000 0x400>;
 		};
 
+		dma: dma-controller@3002000 {
+			compatible = "allwinner,sun50i-h6-dma";
+			reg = <0x03002000 0x1000>;
+			interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_DMA>, <&ccu CLK_MBUS_DMA>;
+			clock-names = "bus", "mbus";
+			dma-channels = <16>;
+			dma-requests = <46>;
+			resets = <&ccu RST_BUS_DMA>;
+			#dma-cells = <1>;
+		};
+
 		pio: pinctrl@300b000 {
 			compatible = "allwinner,sun50i-h6-pinctrl";
 			reg = <0x0300b000 0x400>;
-- 
2.20.1

