Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B71C2D0D2
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 11:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DD2424692
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 11:52:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="g9BqwR2T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfLSLwC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 06:52:02 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:32933 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbfLSLwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 06:52:00 -0500
Received: by mail-wm1-f67.google.com with SMTP id d139so6872114wmd.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 03:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tY1YFADtaZKXzMf5Ie7W6ruxIu2Bb0htwIWWuGbAKcM=;
        b=g9BqwR2T1/I9UWMAVp/ZqXBkfesKLtxfql62Ats6JCmHyrgeqIcvyF5bBUnfb71mMy
         QP4vUYVPzSIO7PPHg0+ASpHinxdROHkqmPkLRKUTO2aiJ8QMyzo+Mzww2couC1OVe+qS
         2j1PYVjLW27+L5u+IgU4B0z+DmkQdgGptoWBtL64wPFWXJAkiyS7r3M771dmzoXDnJOp
         nc/vWUYzH04qcXn3ayS4jzZLRTt5SrbfmBEA3WTISAO29jIaM1ccONkGGpiy9LQ2PzBp
         7av5v7DTa3eZt2rCQOMMIWGeEqUb4ydb4BqCeAqWFQXQYku29EQGVtKvY95Xt4zqqB1X
         YJ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tY1YFADtaZKXzMf5Ie7W6ruxIu2Bb0htwIWWuGbAKcM=;
        b=CVNQsL2KA1WTVQ1rLHWgCGlt6+jTan/rjsnvj2L+Jh0KXUVJuRd7N0MktUNGyVfh3N
         9I4ml2ehexixk97LlNx59tRFkAZspAhg4xjIMl9YPvPQP22Jy7UgzKGdWfKMDnu7I7Qn
         grheoYseH2/MAN2x9VVIDfZUnKDLyvQTLN3aOKBXFWvI5bI+hYQp2G+kk4B2Ti88X6MO
         nA6PDFlvkI3dfqNEC+5m9jRCte+SffR4kdGQxVPzVb2KFKH5EXkKEoWLjf900XBxY867
         ITvLXwTraD1GjGkxFZYoHlDh3MPCyc3M9pcm+gNrQFkZjM+qJWWFjUPXxVYWTMnqMkO0
         xN6g==
X-Gm-Message-State: APjAAAX8awxrgdacuXgGdfhEZxt/bH58vN9bzXS9ZqzvDC2SZih3H+B2
        J8cb9NPcNNr2AO6fzR34/1R8xQ==
X-Google-Smtp-Source: APXvYqzlwjvltFbDap8RdkQ64BKs2O//iQJUD+y6qLqzurI6gy3wxklpvAm+GERYUdoyUdGko4ntpA==
X-Received: by 2002:a7b:c851:: with SMTP id c17mr9872505wml.71.1576756318833;
        Thu, 19 Dec 2019 03:51:58 -0800 (PST)
Received: from localhost.localdomain (i16-les01-ntr-213-44-229-207.sfr.lns.abo.bbox.fr. [213.44.229.207])
        by smtp.googlemail.com with ESMTPSA id k16sm6489660wru.0.2019.12.19.03.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 03:51:58 -0800 (PST)
From:   Khouloud Touil <ktouil@baylibre.com>
To:     bgolaszewski@baylibre.com, robh+dt@kernel.org,
        mark.rutland@arm.com, srinivas.kandagatla@linaro.org,
        baylibre-upstreaming@groups.io
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-i2c@vger.kernel.org, linus.walleij@linaro.org,
        Khouloud Touil <ktouil@baylibre.com>
Subject: [PATCH v3 1/4] dt-bindings: nvmem: new optional property write-protect-gpios
Date:   Thu, 19 Dec 2019 12:51:38 +0100
Message-Id: <20191219115141.24653-2-ktouil@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191219115141.24653-1-ktouil@baylibre.com>
References: <20191219115141.24653-1-ktouil@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several memories have a write-protect pin, that when pulled high, it
blocks the write operation.

On some boards, this pin is connected to a GPIO and pulled high by
default, which forces the user to manually change its state before
writing.

Instead of modifying all the memory drivers to check this pin, make
the NVMEM subsystem check if the write-protect GPIO being passed
through the nvmem_config or defined in the device tree and pull it
low whenever writing to the memory.

Add a new optional property to the device tree binding document, which
allows to specify the GPIO line to which the write-protect pin is
connected.

Signed-off-by: Khouloud Touil <ktouil@baylibre.com>
---
 Documentation/devicetree/bindings/nvmem/nvmem.yaml | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/nvmem/nvmem.yaml b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
index 1c75a059206c..b43c6c65294e 100644
--- a/Documentation/devicetree/bindings/nvmem/nvmem.yaml
+++ b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
@@ -34,6 +34,14 @@ properties:
     description:
       Mark the provider as read only.
 
+  wp-gpios:
+    description:
+      GPIO to which the write-protect pin of the chip is connected.
+      The write-protect GPIO is asserted, when it's driven high
+      (logical '1') to block the write operation. It's deasserted,
+      when it's driven low (logical '0') to allow writing.
+    maxItems: 1
+
 patternProperties:
   "^.*@[0-9a-f]+$":
     type: object
@@ -63,9 +71,12 @@ patternProperties:
 
 examples:
   - |
+      #include <dt-bindings/gpio/gpio.h>
+
       qfprom: eeprom@700000 {
           #address-cells = <1>;
           #size-cells = <1>;
+          wp-gpios = <&gpio1 3 GPIO_ACTIVE_HIGH>;
 
           /* ... */
 
-- 
2.17.1

