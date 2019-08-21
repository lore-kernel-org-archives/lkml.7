Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC4A4C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 14:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B191D233A1
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 14:21:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="qe/OLHqY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729450AbfHUOVF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 10:21:05 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35812 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729386AbfHUOVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 10:21:01 -0400
Received: by mail-wr1-f66.google.com with SMTP id k2so2247402wrq.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 07:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VmjppQ9kSJIbmhrJG4zlGsF2GtCs0UQY5wgxZMdQ2C8=;
        b=qe/OLHqYfp7Cha4Xtsn+k5Rie/1zqnA6BkAn3UbobgKnv99doCcDfCsT9raoT3DwWT
         Duhbp2Hwv0aRCwQfhGw5tpmTAmWOdGnULdiMCy1yEbqByk2k1lKkTFiC7zmAO5gUqxAP
         3Et7hXC7VNpt42QmpSkjWQEYIJAM8GvqXKv5Ho5g04tcn1eIaUVzTQ5NKz0E373InoI3
         zRHRK62m8CFRYBP7dJloJs3OSI4her46DbZH5FpPa/cYLZKzTHBAt6dzB1I/84vjA3rH
         wJoKT6EGUV2Ye9SNj2kpA9pguKVzpJndsNGqN45Lle5YHxz651jNSUvzeGORzqbmC9JL
         aFDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VmjppQ9kSJIbmhrJG4zlGsF2GtCs0UQY5wgxZMdQ2C8=;
        b=lPmik7/O5tAGonL3qTK4+o+9r6cXeIzg3HBYpff1H78qdIaGefTDNK3nnzG3Md1UnN
         LgF4SpjDvhn10V5U9BHK8n9nS1+rKlWq6Qvh+cKiYkvxr+0IBpGyI3wg3+bQoGyH3sDA
         COjiMTjaVZHfkKZ875g7nc/XPDBiiEHgotoP1nviqfsgwpbLdYhu1pdGl1ruWTcYYcKY
         juMkvx169W+XENVzSIqhTq1fZi/J0Vy8n3sJ3rqt5MXUMlzBLWwoMn1i1a3c74p1JqF1
         x8YLWqvW9QHHMEcThyooyU2Kr/HRKF9Z3g03V+ExPu6IUBzrB7NlMhvM5PWSaF4zVY+w
         GJ4A==
X-Gm-Message-State: APjAAAW5gG9b+0J9msvGi7MEmJE2Af7vmyEKfCeZryYoZxNG1V6LhKf0
        fZ835YcVUN4dON8r9R6FjIP1Ew==
X-Google-Smtp-Source: APXvYqyuJkv1+UxkiRrWbP6jf1b1y5tgQuhS+XTokxV95Wiw+0BUZP4OEBBqYv5ZWcVHzVadhPsHZw==
X-Received: by 2002:adf:eac3:: with SMTP id o3mr688501wrn.264.1566397259055;
        Wed, 21 Aug 2019 07:20:59 -0700 (PDT)
Received: from bender.baylibre.local (wal59-h01-176-150-251-154.dsl.sta.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id o9sm33418939wrm.88.2019.08.21.07.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 07:20:58 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 05/14] arm64: dts: meson-gx: fix watchdog compatible
Date:   Wed, 21 Aug 2019 16:20:34 +0200
Message-Id: <20190821142043.14649-6-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190821142043.14649-1-narmstrong@baylibre.com>
References: <20190821142043.14649-1-narmstrong@baylibre.com>
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

