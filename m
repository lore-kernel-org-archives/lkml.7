Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB068C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 11:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8637820835
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 11:12:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="x3Nyybdz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbfCDLM0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 06:12:26 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35530 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbfCDLMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 06:12:23 -0500
Received: by mail-wr1-f65.google.com with SMTP id t18so5079382wrx.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 03:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=huYYvdEpFxCFjP75DhKts6t3iRU+/ADtXiPr1UtrObc=;
        b=x3NyybdzJeZNmlrkI6b1h6t5/pU0Qvi5aheMzAZWqllJETTK6ngS23tCUgH9osrPxe
         w/o/zUgNwIs6x9JQlRsa2UoXcpN8mK1nzw4vYDxN9Ue2oS3+8F8DBXHZeCYhPgZEGkRz
         rDNgHobNe0eycGrwuHDyzfhFI90R4MuZ2sR9cqCYhV2C82nicP1JOsAh4ZNa1wPVPhId
         8LPH6BqydtaF8uSs35hWwGW7D5rci0FS4dTxgIB0cHaMybLB4IWxnkjN3mdPRumXjcTS
         XmrF5R3DVEg+d1xMCci5o1vqeoTTUdBuMGj7bZpQxZOXmCrDdkv+3uMrQ1IWxxCVEfTg
         WkDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=huYYvdEpFxCFjP75DhKts6t3iRU+/ADtXiPr1UtrObc=;
        b=o+2LhzCWVEnUFsyAqA2qB5kuUer6Y9CDByKPja0ZThPyWXrBVdN0QTU1fK95NnXT1P
         wKA8Q3Bs/YwrO/Pk/IlaIuzSDFaB0wHyZNcEMOfB+VcPVv088AsBU43fQU9t71hryj7O
         qIxRDEZ0hzXU12x9k/EJ9dc1iWzPHkjR4Ww5lZoB7HWBWQWuWkSqVzSrHoXLVGKbJZrr
         qHKelW3rmgjwe+m1GTsiw6KIYnxJEPohrd9TtfB9cW55hvxXf0rUX0gqmwTPEDCETirV
         FgbqZ+dDD2RC/fm9Gj9iD8D52Z5GbyZLBDAu7M41FbaKvvVdwrpdH1wn0KfBrrDo0ogE
         p4ew==
X-Gm-Message-State: APjAAAXEZAiaDXz20C7XoRgX2mEj8UX7dowWpI+uC3P5JGEy5lCDbTJI
        itZk3Tkd0oJqBwkJd4O/vIOG/Q==
X-Google-Smtp-Source: APXvYqzzRcU1AKZO5QNzCT9OrAGawWovvqVZkdbXE6YzUzywV3OWLgRwpwFEt6fmVR1TUnXthT3qVQ==
X-Received: by 2002:a05:6000:92:: with SMTP id m18mr12067852wrx.258.1551697940971;
        Mon, 04 Mar 2019 03:12:20 -0800 (PST)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id x22sm37727402wmc.19.2019.03.04.03.12.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Mar 2019 03:12:20 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     linux-iio@vger.kernel.org, martin.blumenstingl@googlemail.com,
        devicetree@vger.kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: iio: adc: document the Meson G12A support
Date:   Mon,  4 Mar 2019 12:12:16 +0100
Message-Id: <20190304111217.882-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190304111217.882-1-narmstrong@baylibre.com>
References: <20190304111217.882-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the documentation to expicitly support the Meson-G12A SoC.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../devicetree/bindings/iio/adc/amlogic,meson-saradc.txt         | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt b/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt
index 325090e43ce6..0d134e0ac600 100644
--- a/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt
+++ b/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt
@@ -9,6 +9,7 @@ Required properties:
 			- "amlogic,meson-gxl-saradc" for GXL
 			- "amlogic,meson-gxm-saradc" for GXM
 			- "amlogic,meson-axg-saradc" for AXG
+			- "amlogic,meson-g12a-saradc" for AXG
 		along with the generic "amlogic,meson-saradc"
 - reg:		the physical base address and length of the registers
 - interrupts:	the interrupt indicating end of sampling
-- 
2.20.1

