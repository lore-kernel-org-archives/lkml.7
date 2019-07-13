Return-Path: <SRS0=/nvU=VK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01788C742D7
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 08:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEFBD2084C
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 08:05:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="wg4PnSKC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbfGMIFK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jul 2019 04:05:10 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45833 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbfGMIFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jul 2019 04:05:08 -0400
Received: by mail-wr1-f65.google.com with SMTP id f9so12042351wre.12
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2019 01:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=K7MVo1cgFDsjyODbl6UghYby+bBwKYEV5/hf6CSHL9M=;
        b=wg4PnSKC1zr343VJSPKwlmxqO+ByphpHmnJapoYMhUKUhQYGgEv3SC81CURUjA4PxO
         W+NITGFc22UBcACrUoEd31VcCw/EUDVFRN1PEuBWKNtXaVlVqexeKya6OLMB0TSAVA8e
         AhyNIFCTxUEz+Ft63uZLjUxZJ5GOiwe3YgajBb/Pjm3igmMFBl5y5r1UAeNtm7mxV6ka
         A4mniTSWFEiQXLsKKPI+yk4vzn82/zOhfXi/WYEXuxBBYoABCvhqNQGqM/2+LKtxM3CJ
         NWiPENznVeh0Vkp/STULZA0kq3zwszCg8kmNZGIMwXThCxpJL0eukFkueSVcI/lcQVMi
         6Buw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=K7MVo1cgFDsjyODbl6UghYby+bBwKYEV5/hf6CSHL9M=;
        b=osd69R1H81yR4uBstDAlZNAlsEWKch0w/mnKUm1P4vyyv2nzNICS5D+pnjmzO9mody
         YbM0JSNGunUeOKuQhOe430RnwluynPo4+4u7TkwrKx+2eIpDz4Y2QdIuGyzfNUxRTpU5
         TrI6nxGeRcjkdg0x/mbIv2m1Zvnn+nvNPH34YJsFbLayxTQf7zxXcmdNcxbCb1+YRwgB
         9abj3sk609lJR7almgwdyfBIVaYYUYdHiSP3c0oHSqocc3iUXlIgh1b9QlJUMfs0oO1X
         uH84sAl2TDzC4zI036p64y3KiJGNMYYPeGuRWPgQiRi8w3fQHKwk4GwUTCfuTkJ0Hsjn
         z+Mw==
X-Gm-Message-State: APjAAAVcrvZwKLYSSFxolsXh98EgGR68CfjxdsBP5AiyK1O6L60slUld
        pLX2ZPWVFCDA9E15hxGCFkD2SQ==
X-Google-Smtp-Source: APXvYqwHIkGDbVtUIpi7BaIFcXYTfm6oWcUszrNs0OI2hHBGtooeN8vMx4ADX4HykZvzepsubdgNkQ==
X-Received: by 2002:a5d:4e06:: with SMTP id p6mr16790962wrt.336.1563005106590;
        Sat, 13 Jul 2019 01:05:06 -0700 (PDT)
Received: from pop-os.baylibre.local ([2a01:e35:8ad2:2cb0:2dbb:fac9:5ec0:e3ef])
        by smtp.googlemail.com with ESMTPSA id o26sm9621634wro.53.2019.07.13.01.05.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Jul 2019 01:05:06 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, jic23@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        baylibre-upstreaming@groups.io, dmitry.torokhov@gmail.com,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        Alexandre Mergnat <amergnat@baylibre.com>
Subject: [PATCH v4 2/3] dt-bindings: iio: position: Add docs pat9125
Date:   Sat, 13 Jul 2019 10:04:54 +0200
Message-Id: <20190713080455.17513-3-amergnat@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190713080455.17513-1-amergnat@baylibre.com>
References: <20190713080455.17513-1-amergnat@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for the optical tracker PAT9125 and
"position" directory for chip which can provides position data.

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 .../bindings/iio/position/pat9125.txt          | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/position/pat9125.txt

diff --git a/Documentation/devicetree/bindings/iio/position/pat9125.txt b/Documentation/devicetree/bindings/iio/position/pat9125.txt
new file mode 100644
index 000000000000..4028aeef9b42
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/position/pat9125.txt
@@ -0,0 +1,18 @@
+PixArt Imaging PAT9125 Optical Tracking Miniature Chip device driver
+
+Required properties:
+	- compatible: must be "pixart,pat9125"
+	- reg: i2c address where to find the device
+	- interrupts: the sole interrupt generated by the device
+
+	Refer to interrupt-controller/interrupts.txt for generic
+	interrupt client node bindings.
+
+Example:
+
+pat9125@75 {
+	compatible = "pixart,pat9125";
+	reg = <0x75>;
+	interrupt-parent = <&gpio3>;
+	interrupts = <12 IRQ_TYPE_EDGE_FALLING>;
+};
-- 
2.17.1

