Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E9ABC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 07:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42E7C22CE3
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 07:03:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="kC/lzVfZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405056AbfHWHDG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 03:03:06 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37764 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405005AbfHWHDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 03:03:03 -0400
Received: by mail-wm1-f67.google.com with SMTP id d16so8025944wme.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 00:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8bvFZYOOWbciidOH/I9lMYm8n7mRLKVoh4XQnIxXums=;
        b=kC/lzVfZUUGHHcb62P+i2HWLr9INMDQhZtTuS0Kq4wKm7wg7inFaRwCJpNk76Bx6So
         CYiDAlrHSUIxo6WCwRzJrEDJH3bqOiOonb17PcyiVgjIHahlQOLr8fwKe1X2PPEzrUuo
         GYxq7XLR9WGQX6zGLYZ6uMM/UiYY7iqmHlke51UUHC0z3FbZlYZTXYXgJ0BlyoTy9ERG
         mrpN+gGOem0lozxhG03hrWjtAfYvlA0kp4T6QmStAZRZEDjKajpigB+H3x8NbWbxN72C
         F4oCPfKynoeEE67PoD8GOOB9uT2FnJ3z5ju01qFhgz0zH9F/LOOzt6l6hgxAQ0fmhjUA
         n+SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8bvFZYOOWbciidOH/I9lMYm8n7mRLKVoh4XQnIxXums=;
        b=XA/g3tU3LN6aFeEbNXUaNCHrXE2MjbudVFnXb00aOSYLsTPLAFKBgZcCGhAUH66+Ti
         bIl7QUW2K6Ajc9Ny1HNXBkX4YzlNuJGfidUj6ZlzA8h7kyMyw2am6PsBXIBJLDRjBgNq
         fQvCC8wHKRVQnYuZ3L25xYia6boWXY4hAd07prQVeQ9BEbHxTOtspLPZMMoXlzHkDQjL
         Z6lKtQ92zJ9jFjPEDaVoe+wHmk3gzFpkCjAS7Vdh6snmukgGfjN+NLza1sqaRyxN3k54
         NjewSSECovpn9I0eBtXS94BCbLVrBoLKlF8MWvPXyKgia3wT9NCnfFHU6yYIv7pcSkhw
         iyBA==
X-Gm-Message-State: APjAAAVWNus72tSj/3gPeAiZkFSVWWOCPx1lH1/uWEaE2Q3wjXHTgS+L
        Zp11FJK+42OoVdT9wK9M2yGDhw==
X-Google-Smtp-Source: APXvYqxlo25gmqlaRYG7TGhQ/LohMFW/zSGas3jbT1AdbAPrDC365o7N9sowEhnteOW5MHE7iRgFHA==
X-Received: by 2002:a05:600c:296:: with SMTP id 22mr3045698wmk.148.1566543781652;
        Fri, 23 Aug 2019 00:03:01 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id a26sm1741833wmg.45.2019.08.23.00.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2019 00:03:01 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [RESEND PATCH v2 08/14] arm64: dts: meson-gxl: fix internal phy compatible
Date:   Fri, 23 Aug 2019 09:02:42 +0200
Message-Id: <20190823070248.25832-9-narmstrong@baylibre.com>
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
meson-gxl-s805x-libretech-ac.dt.yaml: ethernet-phy@8: compatible: ['ethernet-phy-id0181.4400', 'ethernet-phy-ieee802.3-c22'] is not valid under any of the given schemas

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
index 7a3b674db11f..49ff0a7d0210 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
@@ -709,7 +709,7 @@
 			#size-cells = <0>;
 
 			internal_phy: ethernet-phy@8 {
-				compatible = "ethernet-phy-id0181.4400", "ethernet-phy-ieee802.3-c22";
+				compatible = "ethernet-phy-id0181.4400";
 				interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
 				reg = <8>;
 				max-speed = <100>;
-- 
2.22.0

