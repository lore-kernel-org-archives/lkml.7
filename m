Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A190BC31E46
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 21:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79B0A20665
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 21:41:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tDpq1FPh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436578AbfFKVlH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 17:41:07 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45813 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404005AbfFKVlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 17:41:06 -0400
Received: by mail-lj1-f193.google.com with SMTP id m23so13111476lje.12;
        Tue, 11 Jun 2019 14:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3ii1oya7iM4Av9Rw52ktXKCBjEV+f23dDHXfRcuKC7U=;
        b=tDpq1FPh+8DoAEFemXdFgNmDrzuVv7HGs7bDdX0R9e3N1l3s9MVEGOQ5pryKvmwcbc
         OUT9v/DYKJ4pSzu/37eK6FUyNNXM3gCClZFQnjYRNVjKWbBM5O7Ek7i7xrKjBz7cGwjt
         RN+1YHuMwvnWKElb5PrcetXueToyb+Vu/Nfmy7BVXshrF77WMUJ6q8jrSY6PjiwoH/bL
         HUUQDm8NYRZEofJrRjX7eK99zGFmbUFj1qAP0zcpM0wDC++KxbneuxugHM8AZ6kEO6HC
         Qrkx+g3DrsHDMivJ3D6yuAE9+7qkSVAbK4Q5ACEJwtRmKD0pYMXYKo7LLe0DMdAxZdEt
         37pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3ii1oya7iM4Av9Rw52ktXKCBjEV+f23dDHXfRcuKC7U=;
        b=PoDlVWBV3d2q6D0HMPuFFYsdwxakK6lGkuCbPvFThyGYwdUXBMMu6KOjG7zz6pkHFK
         e6R10C1y6Al0PmvUXEZb8/NnjReMItM3uS8cRjVYIEXtaLxwYNllrwwUHxhSHHOQ5dKm
         EfWVgJvSi9sG1bZL/S5R+x2FIhDCuesq97F6uRkMIDt/qPKrJ94gj/xVNmsZnsAssvUt
         SQfbrfz9Tn1tCXbVkNS3zBQaQrXlPhR1FbK4eKDxG2Vcbz39HpFnP6j43IZSDeW+qg70
         q+LiKaBWYmoJNicJBUxXWpznLmIC1EfwXvXvyST9/rDUUj6Q4QPnF+2ALmK4+bfDusvg
         jVdA==
X-Gm-Message-State: APjAAAU+ddTPkxhn63XLY15SbTdU+ggZQleSjgK9AIlZMBBrYakFAw3o
        dSZlLzlHDdU8vyrEmt/hVN7XkwSI1iMn1A==
X-Google-Smtp-Source: APXvYqwpbdaBbT64OJKC3t9fsLS0BFJ1owt5dbrSWV35mRrRMwtNVEd1E9+KBDaYKDDjJry0MrJTJQ==
X-Received: by 2002:a2e:751c:: with SMTP id q28mr16897532ljc.178.1560289264111;
        Tue, 11 Jun 2019 14:41:04 -0700 (PDT)
Received: from localhost.localdomain (80-248-250-227.cust.suomicom.net. [80.248.250.227])
        by smtp.gmail.com with ESMTPSA id o187sm2695914lfa.88.2019.06.11.14.41.02
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 11 Jun 2019 14:41:03 -0700 (PDT)
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
Subject: [PATCH v4] arm64: dts: allwinner: h6: Add DMA node
Date:   Tue, 11 Jun 2019 23:40:55 +0200
Message-Id: <20190611214055.25613-1-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
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

Changes since v3:
 - Rebase on top of sunxi/for-next
 - Sort by physical address

 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index b9a7dc8d2a40..7628a7c83096 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -203,6 +203,18 @@
 			#reset-cells = <1>;
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
 		sid: sid@3006000 {
 			compatible = "allwinner,sun50i-h6-sid";
 			reg = <0x03006000 0x400>;
-- 
2.20.1

