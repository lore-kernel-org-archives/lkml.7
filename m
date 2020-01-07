Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B65C33C99
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 09:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D4202073D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 09:30:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="wrc9Vunk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbgAGJaJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 04:30:09 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37626 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727787AbgAGJaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 04:30:02 -0500
Received: by mail-wr1-f66.google.com with SMTP id w15so40484921wru.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 01:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+zVKW7Z5M1Pn7ywv7BWmy0SCc1R2kgjLBm9t5CbmGWk=;
        b=wrc9Vunkf4kLN6VeE6wbLPENMS2ZJ6WvBJ9FOqaCha+aFRBq8jwO2D+dWW0Po9UlSB
         m4OMbLNHzaslQEOhWEZLB8BFsfCjsXzZNmKLXz5vbFz16holUT73n9DsSW+jZCW6sD5K
         rbm7sx71LQv//oeVvgBfnLNojja2Xyn2b/dvteq5fLWIgwH6B1SLASLfLtRl3EGbeXFP
         EgLJWpoO5oGARy5WsqipPieuVxPvjrGLc1Rc7QVEnw/kxaxwGbC0CLAi3UOMyL9WjvAG
         W+KvUlDBJHkFSzLnsAHwBMWFCa5pw1j4exCsyU5HJaiyf7i8a5MaM8zBhtfJ4XHtQgEo
         ALGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+zVKW7Z5M1Pn7ywv7BWmy0SCc1R2kgjLBm9t5CbmGWk=;
        b=n0L2BSE9d1bZFRHl093I8L0D/ydzAj2tQ3SNoX2xH5GmZHKozt9yTAXu35Y6zpuUt2
         AnCAcIMUXjKrVZQfPz7w8qGM5RkivJZE+Zi2zHyCJqfzrSsfT9cpJvz4j77v5mOXyvB7
         ML2XXTeZhLKp4ApOxXga0bDqCHP1YzaeDy6avatqtwIosZ3Gz8XK/F7pVHcgdwbPh2aa
         7IokKjyanvm5JJeJMibH7yWilWWrzFwnPkosZe7nunxtmpLWZU1VbZpQSSvmmogJeNyw
         Npg1mx1huN254UbtiSoe57vVkGT+Ww/6cLFL824d9cgRGqYqbHl3itFj1CVfbH2q8jqH
         dpoQ==
X-Gm-Message-State: APjAAAWI6E8izXoXL0XD066lHof501BN+3+JZ3oMuTDpc1MLkKfSFD6D
        wVxr+46vV3QFpXV8dhsf/lh/OA==
X-Google-Smtp-Source: APXvYqw/pzX0lAAL6CfIrq94JtHzKgsgQRV8usuW69PxGYPjqF3Sy5k5AB6v7us4fgKEsSaY/RsFQA==
X-Received: by 2002:adf:f3d0:: with SMTP id g16mr112185389wrp.2.1578389400207;
        Tue, 07 Jan 2020 01:30:00 -0800 (PST)
Received: from localhost.localdomain (i16-les01-ntr-213-44-229-207.sfr.lns.abo.bbox.fr. [213.44.229.207])
        by smtp.googlemail.com with ESMTPSA id x14sm25959969wmj.42.2020.01.07.01.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 01:29:59 -0800 (PST)
From:   Khouloud Touil <ktouil@baylibre.com>
To:     bgolaszewski@baylibre.com, robh+dt@kernel.org,
        mark.rutland@arm.com, srinivas.kandagatla@linaro.org,
        baylibre-upstreaming@groups.io
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-i2c@vger.kernel.org, linus.walleij@linaro.org,
        Khouloud Touil <ktouil@baylibre.com>
Subject: [PATCH v4 4/5] dt-bindings: at25: add reference for the wp-gpios property
Date:   Tue,  7 Jan 2020 10:29:21 +0100
Message-Id: <20200107092922.18408-5-ktouil@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200107092922.18408-1-ktouil@baylibre.com>
References: <20200107092922.18408-1-ktouil@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the at25 uses the NVMEM subsystem, and the property is now being
handled, adding reference for it in the device tree binding document,
which allows to specify the GPIO line to which the write-protect pin
is connected.

Signed-off-by: Khouloud Touil <ktouil@baylibre.com>
---
 Documentation/devicetree/bindings/eeprom/at25.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/eeprom/at25.txt b/Documentation/devicetree/bindings/eeprom/at25.txt
index 42577dd113dd..fcacd97abd0a 100644
--- a/Documentation/devicetree/bindings/eeprom/at25.txt
+++ b/Documentation/devicetree/bindings/eeprom/at25.txt
@@ -20,6 +20,7 @@ Optional properties:
 - spi-cpha : SPI shifted clock phase, as per spi-bus bindings.
 - spi-cpol : SPI inverse clock polarity, as per spi-bus bindings.
 - read-only : this parameter-less property disables writes to the eeprom
+- wp-gpios : GPIO to which the write-protect pin of the chip is connected
 
 Obsolete legacy properties can be used in place of "size", "pagesize",
 "address-width", and "read-only":
@@ -36,6 +37,7 @@ Example:
 		spi-max-frequency = <5000000>;
 		spi-cpha;
 		spi-cpol;
+		wp-gpios = <&gpio1 3 0>;
 
 		pagesize = <64>;
 		size = <32768>;
-- 
2.17.1

