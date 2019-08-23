Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DDD9C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 07:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3024B23402
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 07:03:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="GoHzf8Sk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405026AbfHWHDE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 03:03:04 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54735 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392495AbfHWHDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 03:03:01 -0400
Received: by mail-wm1-f66.google.com with SMTP id p74so7864121wme.4
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 00:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8G0E0ExO/8vd2rGhXGiVb6HSb8G+1dBBdN59XPnX2pY=;
        b=GoHzf8SkZj1+SpCoyVP0Y3ZBaNamHMVTa2ltB0yOI36PwQ+quf7uqr6wqjiPeGBaT9
         edo0ve8cKUP1ou+mFnM+m/6MAHAItTL7Sem8XzG6gVtS68cGxRx8/05t4M2eODJxw7w6
         jhgneNZIMupty7Mek5jp2do8k5Bqr4C14o696uFuHx9CiEHSMBawDDUJedraA1h63Ccq
         zQ4TqdFILCQ6FchVgfQwFB01t6AXfqyUqsPxqGTUZ4j6BJfXxpDNGllhZbAEAEXsGA1h
         d6O639EAXrHr+zeKOkhJ9wnQa/7GTbNTCSFwL3w9A6TWS6phQkzaabtz8NGrQQZxpTIr
         I2Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8G0E0ExO/8vd2rGhXGiVb6HSb8G+1dBBdN59XPnX2pY=;
        b=RkddhjQdp0Q3XJ4MGY6z/QrGLRG/BjdA/bDrnHLxl3PnvhFfFW3+IRmTVxTWRjysbJ
         xduKhnpuynSZlXhtPrfr8ZF7sebXTebxs/D/oh1Jq9Hl+yy16QmEXOS9ioVrjaFd3Q1C
         5kic4e/bnbY9+6yvtJGC+cdqqrbu0/x2cPQHceMepA1Fyr1V2KopBSftIEjlzPxh8JHb
         zabTX6IMrVpV9pvLzyFDT7gEeFS0ZsqVwDm2HmR3I6eIgqN4AisxKMGoGV47sWrN84D8
         O8MKTwcNEgrlruMyosBaMg/xR8sJNjXIXnF0V1r6Su2Q5rG38LEpW+nPMQFLPC90dsOK
         jrug==
X-Gm-Message-State: APjAAAXwvEuVrBQGOFyjEiZVqecogIENniHpVduZxh5QuSBusZnVEjZE
        ZYhHmJBOlf5YLaj/6e4pSm72Cg==
X-Google-Smtp-Source: APXvYqzUKYnWao2Wqg2Ns4yi/vxfNMHPEOhgTpeWMwDQcAu/e5rK+lJa7uHRKL6EwbWcDxwqcZ5Jsw==
X-Received: by 2002:a7b:c4c6:: with SMTP id g6mr3436424wmk.52.1566543778710;
        Fri, 23 Aug 2019 00:02:58 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id a26sm1741833wmg.45.2019.08.23.00.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2019 00:02:57 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [RESEND PATCH v2 05/14] arm64: dts: meson-gx: fix watchdog compatible
Date:   Fri, 23 Aug 2019 09:02:39 +0200
Message-Id: <20190823070248.25832-6-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190823070248.25832-1-narmstrong@baylibre.com>
References: <20190823070248.25832-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the following DT schemas check errors:
meson-gxbb-nanopi-k2.dt.yaml: watchdog@98d0: compatible:0: 'amlogic,meson-gx-wdt' is not one of ['amlogic,meson-gxbb-wdt']
meson-gxl-s805x-libretech-ac.dt.yaml: watchdog@98d0: compatible:0: 'amlogic,meson-gx-wdt' is not one of ['amlogic,meson-gxbb-wdt']

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
index 1c580f42e818..b3fe3268af3e 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
@@ -325,7 +325,7 @@
 			};
 
 			watchdog@98d0 {
-				compatible = "amlogic,meson-gx-wdt", "amlogic,meson-gxbb-wdt";
+				compatible = "amlogic,meson-gxbb-wdt";
 				reg = <0x0 0x098d0 0x0 0x10>;
 				clocks = <&xtal>;
 			};
-- 
2.22.0

