Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9146C47404
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 05:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 901E420873
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 05:32:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="NNRfug62"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729877AbfJNFcK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 01:32:10 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55677 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729108AbfJNFcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 01:32:09 -0400
Received: by mail-wm1-f67.google.com with SMTP id a6so15709148wma.5
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2019 22:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZPt3z/LPUQkZF7XPmauch+PD9uKUNhmmb16ZUBya544=;
        b=NNRfug62qVkpYI5/OmgtlawaQdrdObsbLahRD4b1X+pEB4TI3PY+sWHTOXSyOHOirm
         Ce+H6/yjXGCfFtDG8W+U0RwGTH0O0IiPBEoiApb41LtzjOwhmtzx08jFXjIe68DoKmCZ
         9UdgBZxg/+LRD26L/G+jStWdo1BiiIo81MeQ5jbi7DjnH+5261kWY2Po2gKqatvHmYqV
         ERG7ggaNVspcKlrQbgdFFoZsiFoimeA5urMrQCEWdNENKrRaI2h6094spyqFLco8xDip
         NdVqD66DChwE+0vFHkAYgEXQdHywk55nQo9jO9CqejbyW6D0dN9No68dgAPHLKRtacPn
         HQhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZPt3z/LPUQkZF7XPmauch+PD9uKUNhmmb16ZUBya544=;
        b=XRgEO0T7R+8REErrdNUmxKXDi2K6WoXW04gToIF3PvZVNMPM5G/kUTo3qkzHamJ1PF
         IeKMiXtrFNiYUrQ9yYiYpf8St5PJ68W9d8RnOjRpm8DMt8bPEhUlgg10dpE2JFeIpOtV
         Rf0iSRStvBnGSEuefUswcgTMgTP3THpBYjRhaWtVcglf8eyXed6jVQqHjZ69toTXsO0H
         K0OTOyvj/LAmdgA679c2Pzwm5pQ3Ibar7rUmv/fqBUENDtvjM0SgBoUzwOiztoIQHqYP
         8cScXcYhi8XfFDQ7tarz8RUnJ6B8Ji7l/Bb3ShkMoe9huoqKo/lJg+t3FdXsrToi5cSC
         5f8g==
X-Gm-Message-State: APjAAAUHNu/X707j+SCXnXKrE8It1Y3Rdw6Hdw4ly8WrO5FHwCqFt/r8
        nrayRvae2XF051DYf7uMo8Wt2w==
X-Google-Smtp-Source: APXvYqyjAenIih3BVCa7xP8YhcqlBP28JppFbg1KMQZ9deITlv3xYcilyH/KYDEuYgH3Y9jQjhqckg==
X-Received: by 2002:a7b:c006:: with SMTP id c6mr13743896wmb.45.1571031127404;
        Sun, 13 Oct 2019 22:32:07 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id o18sm44238772wrw.90.2019.10.13.22.32.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 13 Oct 2019 22:32:06 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        khilman@baylibre.com, mark.rutland@arm.com, robh+dt@kernel.org,
        martin.blumenstingl@googlemail.com
Cc:     devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v2 4/4] ARM64: dts: amlogic: adds crypto hardware node
Date:   Mon, 14 Oct 2019 05:31:44 +0000
Message-Id: <1571031104-6880-5-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1571031104-6880-1-git-send-email-clabbe@baylibre.com>
References: <1571031104-6880-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the GXL crypto hardware node for all GXL SoCs.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
index 49ff0a7d0210..ed33d8efaf62 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
@@ -36,6 +36,16 @@
 				phys = <&usb3_phy>, <&usb2_phy0>, <&usb2_phy1>;
 			};
 		};
+
+		crypto: crypto@c883e000 {
+			compatible = "amlogic,gxl-crypto";
+			reg = <0x0 0xc883e000 0x0 0x36>;
+			interrupts = <GIC_SPI 188 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 189 IRQ_TYPE_EDGE_RISING>;
+			clocks = <&clkc CLKID_BLKMV>;
+			clock-names = "blkmv";
+			status = "okay";
+		};
 	};
 };
 
-- 
2.21.0

