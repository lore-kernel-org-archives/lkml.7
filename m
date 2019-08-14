Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C80ADC32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 14:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E1EE208C2
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 14:30:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="IQDESnm0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbfHNO3c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 10:29:32 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38580 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728116AbfHNO3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 10:29:30 -0400
Received: by mail-wr1-f68.google.com with SMTP id g17so111306444wrr.5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 07:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sUeYe8BSGZYWQw5KBHRzy6qEBjOndmbbSL6rQBInc7k=;
        b=IQDESnm0QeHd8PxFb+DODakqpsJeW8gEOHzHbnzOttRsosCnMlxmFW7+AMWQ/Fdow8
         P1Uamy0iVppznk/vnkk+jkMO6G9Zf23VAoVx/hrGXF6Cw94j1BHYAuR67hLIlOBb9+OT
         ax/zAEuXVqqNRxiZiuKqc1YBZGHm8tu4Tkh43lFHlaxdEV+t1h7kJUWpcj4iGMJVnBB7
         w5v9Ert8LYp07L3wxHEU6i93Th3+2oLFnFpeMv/b6LNLZ0lPubbmKy85kj8ECrY3B/c0
         Bu3XHE4R+/ecqoWWoie9T4z5katAo8GcsjwrbFJaOK+Ym62GOKlzwwT6sOGxK7UtC6w+
         UfDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sUeYe8BSGZYWQw5KBHRzy6qEBjOndmbbSL6rQBInc7k=;
        b=PtkiV74iB+1EP4bWZd9wbvc9LE0QgNgYe2wk5un77dOa30Fiv2UjJuFm/jzHdLZrxM
         esCsiUQul6mu64lGIgrn3lNJ9BajfroLDVA4iKInhkiTMadH1/Lcu/VSMkfsQba0sqge
         KKbRpDJhtVwl3drTFXEuAnFr6nbzMiv1S+gDgvJ0tBP/FjxPgPuOW1/WbA8riMvWtNZ8
         myseUSpsGkXZmv5toKst+3aOwOOoCQFea4xhT2ZAElnKJmT/zuMzSGjcdGDjo9AaCV/p
         3+KAALOHcmR4K78yPHs6XbMYzPcIjVPkcGCGbh3EBStX5SVS/CtdBROnzTqQgMgYvrt0
         e67A==
X-Gm-Message-State: APjAAAXVvibKiJMYCXHN+7hYL0VPjf2AE0Uxh5TqWNX8TzZas3wbaxRr
        KDiDy2gFiPAzWnm6Q7g9lkDW9A==
X-Google-Smtp-Source: APXvYqxxKH1Vq43+PK9iSDPYgqIOMfuab9ammjtTuWznJWzNy7m6bWGj8TCVArpoFQ4uJgdU68pT+g==
X-Received: by 2002:a05:6000:104f:: with SMTP id c15mr25058503wrx.225.1565792968020;
        Wed, 14 Aug 2019 07:29:28 -0700 (PDT)
Received: from bender.baylibre.local (wal59-h01-176-150-251-154.dsl.sta.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id o7sm4202908wmc.36.2019.08.14.07.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2019 07:29:27 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 05/14] arm64: dts: meson-gx: fix watchdog compatible
Date:   Wed, 14 Aug 2019 16:29:09 +0200
Message-Id: <20190814142918.11636-6-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190814142918.11636-1-narmstrong@baylibre.com>
References: <20190814142918.11636-1-narmstrong@baylibre.com>
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
---
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
index e2cdc9fce21c..00215ece17c8 100644
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

