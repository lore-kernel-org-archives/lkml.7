Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8610C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 14:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B4C820868
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 14:36:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="i8HkI+1m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729759AbfFGOgn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 10:36:43 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35606 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729708AbfFGOg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 10:36:26 -0400
Received: by mail-wr1-f66.google.com with SMTP id m3so2435689wrv.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 07:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g2wkRe5K1IXma8bNYhCvI+fQ4IJioh9uPMWZ6j+ulzE=;
        b=i8HkI+1m1F1SjP6xDeqTAfAYetKgkZ/Em+zIBfQQh3kynYXqEcMfz160AgDZA8iDaA
         06lkdIC79LRvXhW047p7ZoqLc/2Sh+dA10/I0kdaSJYHmD8JA5BR5L3oNe2iqU18U06d
         cKVM5iIk8pnUu+/Ed/f3+2jUTyYt4yRhet84OBGS+q9S8l8RNbqT+dZpF8ZL57vKEz/P
         rNvQZdDAU3IGhYD5NaXjYoa7fyW4v9jTxrV3zXgE8RlOAeYl2QkASxQ6KOsPCae0rMJ8
         RNum6oZ+ITgyLp0dfZMIfrRedOXm8aP7m36HllmlQcJaQJAOE6HgCjHdVshVfa5SspJO
         JghA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g2wkRe5K1IXma8bNYhCvI+fQ4IJioh9uPMWZ6j+ulzE=;
        b=DXCeWTCXtkWPA8KLyUfuSYmMLcyXVLNEXDT/Tbdzj5QLAn0NTOThkGDvlPM4vr5de0
         8arY1kg1u/bBnij0VSszyEaOjxbDs8XHTfAwWEuIlIgkOuCT+My2O2od0fyZ65HoXhoB
         72bgss1wME5/SVHlCnLcpOb1laNf/cl6ocX8MIIK2lIb1bB8OlX8fjOggSN3J4h2Ou+U
         IUNovNFEqjdjbmHC3F0Z6mAYD6VOOidfhPb8zthpozvf637EbTuTpQ54mB08rDJ96v9j
         hQj59ItfWbXBGPAkg5Zj+4Fb/oIiL/aVnUGg6QRQl+IP9nbg3gKscHtdOHeXHCDj/R6q
         /l1Q==
X-Gm-Message-State: APjAAAUVMqcFeR1Pq1R/qBverEXOQu0aUDeHFwaVHh3UZpUhid36xRRu
        KbDcOpx1t1b3xvtajDYJB2Cq2A==
X-Google-Smtp-Source: APXvYqyUsOBv907VjCYDLz/AiagnuEkdBp024RTB1LRi5oXy9F1Zcoly0Zy5U2l1bvTxAA3qupE9Aw==
X-Received: by 2002:adf:f04d:: with SMTP id t13mr13846456wro.36.1559918184659;
        Fri, 07 Jun 2019 07:36:24 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id t63sm2999829wmt.6.2019.06.07.07.36.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 07 Jun 2019 07:36:23 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 2/4] arm64: dts: meson-g12a-x96-max: add 32k clock to bluetooth node
Date:   Fri,  7 Jun 2019 16:36:16 +0200
Message-Id: <20190607143618.32213-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190607143618.32213-1-narmstrong@baylibre.com>
References: <20190607143618.32213-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 32k low power clock is necessary for the bluetooth part of the
combo module to initialize correctly, simply add the same clock we
use for the sdio pwrseq.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
index 2c10ebfd9e7c..aa9da5de5c2d 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
@@ -206,6 +206,8 @@
 	bluetooth {
 		compatible = "brcm,bcm43438-bt";
 		shutdown-gpios = <&gpio GPIOX_17 GPIO_ACTIVE_HIGH>;
+		clocks = <&wifi32k>;
+		clock-names = "lpo";
 	};
 };
 
-- 
2.21.0

