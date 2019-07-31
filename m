Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB1FC32753
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 479B6208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:40:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="zEzqFVja"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387974AbfGaMkX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 08:40:23 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36822 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728963AbfGaMkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 08:40:08 -0400
Received: by mail-wr1-f65.google.com with SMTP id n4so69591048wrs.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 05:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U87qbGqOizt6mcWi4ZafXpAVErJ10/2GJDrgCn/BFng=;
        b=zEzqFVja0Fqsg11qypzSTOGn9YUbHxrTCRpomYU2xnSk4RqosdMU3RsLKQ5IHrk01v
         gZa8uGmAP550xts1ob0QR4t+ujj6f6l4TPGUMJBTI1aXnFAHRLDITtONU9DDzGDNd6fH
         b9UA6re8oJh0ZuRd7oJljeKVy1nwM2wt9MzpO1rIUn6rSJcD8SKFHAT+zvtKXc8CrPSL
         Cw4OLEzT9m02WDlPC3JU4Wc9Y+o69mwLzcaIL3DBzErWh8oaqJOcNs1bZjxyGSYXOBNW
         Zs3wlfRxgPz3+Wv+dW7ILng2azVJyENzMtL3tbafMQGYvkRSgsAFFrpNh6hbT/q8W/gN
         0enQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U87qbGqOizt6mcWi4ZafXpAVErJ10/2GJDrgCn/BFng=;
        b=ApqYOUXLkO3fEGGYoQatD/C0Boe7aluKfs/FDIZaBWYYdlr5xpD7s1v0wNqh8IjQpG
         QDADZqIIrNvQEFvsUFQ0SrZTB8/hR39X0N5odwTuZ30m4bs+5mWhS8r13V8kRVc1CNKk
         ESZINY48lh0NKpWR6Z1Fc3aCiUZN2laPgp/ebufDGlLoaarjYZqU2G7HEsBiDasBF+0R
         GmapfIQwqg94ctsftjT4aboiy+PzDDl+sDJzzhNTp7KlqtzDxEMr3V5RwczLzZb1szCe
         Yzud1U/6EojzcFzfuRMuni6tFaQ/9hC0lW07AhIL54+kXRPWmqpa/oJ0JVkineok0IN0
         JIJg==
X-Gm-Message-State: APjAAAUOL9jvz7V8MDoxPwRe93IyY19DwuE7uabHgRBpaFZ6ePod3Sis
        7qtRCMNlPlxBXq9d8rW7jx/w0Q==
X-Google-Smtp-Source: APXvYqwRvaDIRDg5/7CHt0j5vI443O9wSUNUp31+MGhBKdXuOhMOSbWoNqXVYU+B1ah5lM6/dpyi7Q==
X-Received: by 2002:a5d:428a:: with SMTP id k10mr15513765wrq.329.1564576806822;
        Wed, 31 Jul 2019 05:40:06 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id x185sm62504271wmg.46.2019.07.31.05.40.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 05:40:06 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, devicetree@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 4/6] dt-bindings: arm: amlogic: add support for the Khadas VIM3
Date:   Wed, 31 Jul 2019 14:39:58 +0200
Message-Id: <20190731124000.22072-5-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190731124000.22072-1-narmstrong@baylibre.com>
References: <20190731124000.22072-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Hewitt <christianshewitt@gmail.com>

The Khadas VIM3 uses the Amlogic S922X or A311S SoC, both based on the
Amlogic G12B SoC family, on a board with the same form factor as the
VIM/VIM2 models. It ships in two variants; basic and
pro which differ in RAM and eMMC size:

- 2GB (basic) or 4GB (pro) LPDDR4 RAM
- 16GB (basic) or 32GB (pro) eMMC 5.1 storage
- 16MB SPI flash
- 10/100/1000 Base-T Ethernet
- AP6398S Wireless (802.11 a/b/g/n/ac, BT5.0)
- HDMI 2.1 video
- 1x USB 2.0 + 1x USB 3.0 ports
- 1x USB-C (power) with USB 2.0 OTG
- 3x LED's (1x red, 1x blue, 1x white)
- 3x buttons (power, function, reset)
- IR receiver
- M2 socket with PCIe, USB, ADC & I2C
- 40pin GPIO Header
- 1x micro SD card slot

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 Documentation/devicetree/bindings/arm/amlogic.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
index efa032d12402..04a2b0ef34c6 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
@@ -137,6 +137,8 @@ properties:
 
       - description: Boards with the Amlogic Meson G12B A311D SoC
         items:
+          - enum:
+              - khadas,vim3
           - const: amlogic,a311d
           - const: amlogic,g12b
 
@@ -144,6 +146,7 @@ properties:
         items:
           - enum:
               - hardkernel,odroid-n2
+              - khadas,vim3
           - const: amlogic,s922x
           - const: amlogic,g12b
 
-- 
2.22.0

