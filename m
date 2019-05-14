Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D50EC04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 09:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9F1A2147A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 09:45:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="VjNwcN6Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbfENJps (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 05:45:48 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43097 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbfENJps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 05:45:48 -0400
Received: by mail-wr1-f66.google.com with SMTP id r4so18402022wro.10
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 02:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AImHa44p0mDvOU1NWVHOPq3uhogoe7GyDrgo2WEXj/c=;
        b=VjNwcN6YD8r8chxHjTjcst6CSr1XuWPV3akry0c2LVIIlO2oxGYjnN3DcNSWBl0b/d
         oEp7GfwJqAJEeljYW8HW+FBJTRJ9fDkORslgbwem3e/dUpvMuGkDLXpzfJxwn+XACW5X
         OuCDrRzpgTynjSYhsony0A6maZCmOV5IL49Na7ViefXpKF7DykUNn2nnCc3SRtg57O7f
         0IJDcUh6j/6D6Tq1Te5UnL35aFPK9aeh47tNlGI2Ne8qITWHvd6JyMQUlJ6BhAGjhLu7
         aAYCrHKaJWq8AZzOHY/galHkdMJrjfHyCaPE4C8plGwAmx2w925YrSUeAf+sjYVz0veE
         LZCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AImHa44p0mDvOU1NWVHOPq3uhogoe7GyDrgo2WEXj/c=;
        b=fgYQA5GhVIq15URBM8DUPRxXvoo3n5G1gSQDdy1FIYpOkvjZfDAAURwloXCzuVO6go
         7PFhnfkVM4dbCexJrm5vhlgAMO8YGqocFzPOBDmKR+wr0OjMV3nNHw8JyCG6yT+LHcAS
         /hTm+uxbGefc06Ou32+hEj6ChVnGbbhMPSYGkh/xSsTl5LFWDztHEj0kfooJbp5yEHNK
         mRca8twfjGsNncZ7P36zcXVRtlOFmqSswEVv6cQkJeOae0DLIagTLBEqn9UVFM1XlxYH
         kXcfBjjrx80s73EI5q+JtkPBh+MxSdmTT0NdcHl1CIjG2q8GZwnVbgmVY1Bd+miHmgTx
         dsnQ==
X-Gm-Message-State: APjAAAX3sSQS6s+N29L5Zimf792cxb2A6pDF1sx6A/cjWiY8+wKqmMrm
        qQpC1gmceODe8M1CBuH4lgqI/w==
X-Google-Smtp-Source: APXvYqzSVHJmToHiREG3mWCkBwVsO8AwYFyO/y+AxQxPWtyxHM5C4VI+AE7HytatFMM38AV+Ys7+ZA==
X-Received: by 2002:a5d:688a:: with SMTP id h10mr20000592wru.211.1557827146709;
        Tue, 14 May 2019 02:45:46 -0700 (PDT)
Received: from boomer.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id n4sm5319216wmb.22.2019.05.14.02.45.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 02:45:46 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: meson: g12a: set uart_ao clocks
Date:   Tue, 14 May 2019 11:45:37 +0200
Message-Id: <20190514094537.8765-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the AO clock controller is available, make the uarts of the
always-on domain claim the appropriate peripheral clock.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
index b2f08fc96568..ca01064a771a 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
@@ -708,7 +708,7 @@
 					     "amlogic,meson-ao-uart";
 				reg = <0x0 0x3000 0x0 0x18>;
 				interrupts = <GIC_SPI 193 IRQ_TYPE_EDGE_RISING>;
-				clocks = <&xtal>, <&xtal>, <&xtal>;
+				clocks = <&xtal>, <&clkc_AO CLKID_AO_UART>, <&xtal>;
 				clock-names = "xtal", "pclk", "baud";
 				status = "disabled";
 			};
@@ -718,7 +718,7 @@
 					     "amlogic,meson-ao-uart";
 				reg = <0x0 0x4000 0x0 0x18>;
 				interrupts = <GIC_SPI 197 IRQ_TYPE_EDGE_RISING>;
-				clocks = <&xtal>, <&xtal>, <&xtal>;
+				clocks = <&xtal>, <&clkc_AO CLKID_AO_UART2>, <&xtal>;
 				clock-names = "xtal", "pclk", "baud";
 				status = "disabled";
 			};
-- 
2.20.1

