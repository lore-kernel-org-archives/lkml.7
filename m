Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A85DAC04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 13:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 792D2208C2
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 13:26:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="g8eRb+2Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729415AbfEMN0m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 09:26:42 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:35436 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728973AbfEMN0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 09:26:42 -0400
Received: by mail-wr1-f49.google.com with SMTP id w12so15294608wrp.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 06:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vPE3jxCO3dCQR+ybH4Gy+efpIpySYIwlVy/qEuYWDIY=;
        b=g8eRb+2Ye5bChbQzqB5uao6VM8WXp8fKutdZSzNyT+KSAaYvR0EequtAtjOPxZAiPW
         geHXsBfDa5q4YSH7jEEHce3pQ480eBTmAVgtGKTksz96oPgnZ9sDb3kXpi5Rxx7MUKD6
         Q7x8NplJmezylTtJYTzw8t+vhFN0VRk93+whQ/cIJgosstN6HundDjINH409Xu2RTNn3
         W92hgrAd/KiabsLQaEtIbKXWSlJ/2TIf3ueJ/qyec6sVPaMTV0YbGapLgU0Ywyh2VyVG
         g/hPZvO9EVWWi4Uj6JvDdoVSzzu4JMRcTe3JaLFMj9aZpBmxMV7NdK18KkQysCDvKryy
         29zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vPE3jxCO3dCQR+ybH4Gy+efpIpySYIwlVy/qEuYWDIY=;
        b=o3f3m3QUyr4K3lR81IKliobicG6w1Nqh7Vrk0xpNUBxPc9tf/saQo/LaCMxfcOaWbQ
         HzmhDQd/GjRFOdienRh8/lu2Ex7/loKE+8lhFHEkNKIFP7NJ2vA5s9hDcXP6e0OeqzFq
         UP0j7+JyPvR9ErkqcvcEmpXRpUX3ZySQY1HtwMjbLyLM9M9uPTLAZn1mbtdl5pBGSCRO
         GXFD84jjRjzIKqc4N6kRt1HI5E+R9AIB/dYD8yiYS2oj+xpMbJpR+o5ggHq1aTYbV2r+
         6jZfChs/m2pQFM9AKXBcjRbQe2DU+PduN0TuY6rgrdQFcYWwJwTbIGSjqqY/novSRW04
         L3fQ==
X-Gm-Message-State: APjAAAXLfCzMF1/jy2pIgE8br7iDLbuhp6nzdOBMxfX6U49eviTRe831
        tL3wmWDo4RfMP62JYlbzVJ9f2A==
X-Google-Smtp-Source: APXvYqySFgPHBjr/wKnTqEBG02gIwRobVpzN22Zu5VUMEwIG0+8bMfpops6VWDvfUHaJpt3uXuot2g==
X-Received: by 2002:adf:f6cb:: with SMTP id y11mr18657626wrp.67.1557754000110;
        Mon, 13 May 2019 06:26:40 -0700 (PDT)
Received: from boomer.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id t13sm16400701wra.81.2019.05.13.06.26.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 May 2019 06:26:39 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH/RFT] arm64: dts: meson: odroid-c2: add missing mmc modes
Date:   Mon, 13 May 2019 15:26:27 +0200
Message-Id: <20190513132627.25149-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add sdcard uhs modes up to DDR50 and push eMMC up to 200Mhz
With the new tuning method, these modes appear to be stable

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---

 This particular board has always been painful when it comes to
 its eMMC modules. While testing the new tuning method introduced
 in the last cycle, I have not seen any issue with HS200@200Mhz.
 That being said, I only have the 16GB module.

 In the past, problems have been reported with other modules while
 it was fine on the one I have. Clearly, I don't have the full
 picture.

 Kevin, I don't know how you prefer to proceed. I am personally in
 no rush to see this applied. I'm sending this mainly to make sure
 it is shared and give people a chance to report issues.

 arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
index 1cc9dc68ef00..5a139e7b1c60 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
@@ -255,6 +255,10 @@
 
 	bus-width = <4>;
 	cap-sd-highspeed;
+	sd-uhs-sdr12;
+	sd-uhs-sdr25;
+	sd-uhs-sdr50;
+	sd-uhs-ddr50;
 	max-frequency = <100000000>;
 	disable-wp;
 
@@ -272,7 +276,7 @@
 	pinctrl-names = "default", "clk-gate";
 
 	bus-width = <8>;
-	max-frequency = <100000000>;
+	max-frequency = <200000000>;
 	non-removable;
 	disable-wp;
 	cap-mmc-highspeed;
-- 
2.20.1

