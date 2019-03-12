Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68F1CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 08:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38C8A214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 08:34:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h3I4+3iP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727603AbfCLIeD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 04:34:03 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46255 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbfCLIeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 04:34:03 -0400
Received: by mail-pg1-f195.google.com with SMTP id a22so1237704pgg.13;
        Tue, 12 Mar 2019 01:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YaS6aHe0kRTPL5Iqbsoq/7uixJilo8Mg28xKFsRpmY0=;
        b=h3I4+3iP0oUEuI++w5E6dcBVUOPlYPWOt0W2F5/k+Is/p/g2MPcAL858+xgOxv1mZN
         5EZ+FGjafrQ9VX36lbM5WP+qMMb6UMHHm2EbiYcAhIBz4j+jj7KwxVpcXSXXpcxtPqS1
         dOukY1YaD3czqtwNcXZmX+3+g0iZO6E3uvsB/A6JG5vPbXF+1YlHoq7oFfBNfVgfTtqy
         /kpVfkHVvNAmIMdTUdZM5kUURIGs3qJVgFz+zpVxmhuYxIzsFLwI2EyRQXeBRrU34GRg
         MaAToQX5zcKFR4UTRCTfMyJrIoG+31he5uNQ3Bj87Hrxi9bl7FPQHxBo/XbsHv1nm3lb
         xAvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YaS6aHe0kRTPL5Iqbsoq/7uixJilo8Mg28xKFsRpmY0=;
        b=gy3gnP6yZ//Zgi6DxElHKL+lWf7SIoPa0Ty7GYXKKYcP4itslFHaUYGa8nNqt3F3DP
         2HWP5tUpis1ZMAt9m5bVN4A3VGZoGv46hBpI1eAZH0WAOBBRA0FOnWQtF6h26kZOSrfe
         GMvFjyiMw65XG8X0TiutqJdjM1Q6Pq6cIC68YUQJWhKYPzz4Vt92oIQmr9PEifWkFQxS
         PCAXk67hcbQdKMjEzKLYWEebdIbOAbBfylB2xkVeEC8fPSeVvevQE0nM26GCgAWl+krU
         02a0QAST8x323BzNKjcmvDzkJiuKO9fOvPHPOFF0RfY0FUdYi0PwQZIH9zRaV5+3CMLH
         gNhA==
X-Gm-Message-State: APjAAAWv2uG12tLTgT/LhE+N2LduH731WwjkQ/rQOMTZ+bxQzM51cS01
        IZ+RiXPehkV+coyHbgHH5kE3Gg82J8A=
X-Google-Smtp-Source: APXvYqyZhZFrYKrnAY5RjwZZj7tRDVck34+l46DWwBI7q5YeV2e0Rgp+wv/t49m58PL5O0JGP7QKmg==
X-Received: by 2002:a65:63c1:: with SMTP id n1mr33652298pgv.339.1552379642272;
        Tue, 12 Mar 2019 01:34:02 -0700 (PDT)
Received: from GuoGuo-OMEN.lan ([107.151.139.128])
        by smtp.gmail.com with ESMTPSA id v22sm15605576pfa.49.2019.03.12.01.33.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 01:34:01 -0700 (PDT)
From:   Chuanhong Guo <gch981213@gmail.com>
To:     devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chuanhong Guo <gch981213@gmail.com>
Subject: [PATCH] arm64: dts: meson-gxl-s905d-phicomm-n1: add status LED
Date:   Tue, 12 Mar 2019 16:33:26 +0800
Message-Id: <20190312083326.18029-1-gch981213@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a white LED on the front panel behind the logo and the
manufacturer uses that LED to indicate network and USB drive status.

Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
---
 .../boot/dts/amlogic/meson-gxl-s905d-phicomm-n1.dts    | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-phicomm-n1.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-phicomm-n1.dts
index 9a8a8a7e4b53..b5667f1fb2c8 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-phicomm-n1.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-phicomm-n1.dts
@@ -14,6 +14,16 @@
 	cvbs-connector {
 		status = "disabled";
 	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		status {
+			label = "n1:white:status";
+			gpios = <&gpio_ao GPIOAO_9 GPIO_ACTIVE_HIGH>;
+			default-state = "on";
+		};
+	};
 };
 
 &cvbs_vdac_port {
-- 
2.20.1

