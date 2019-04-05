Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE71C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 12:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C34921872
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 12:21:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iWrOH57m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730086AbfDEMVd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 08:21:33 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55256 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbfDEMVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 08:21:32 -0400
Received: by mail-wm1-f67.google.com with SMTP id c1so6434104wml.4;
        Fri, 05 Apr 2019 05:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9erJsT3n6dGNMQxxddzCZxm7IcW+kl6q+eqaPEHvZcI=;
        b=iWrOH57m5fpyudvh0sbyL46Wusnl7Oof2qo6ig439LN7rVogmff8qlxQhP6j79Bf7s
         p0XA/JkOwas/P//xWMP9XK7cxTB2jY5RAwae6CklMw4FMWJO2Tj1tw3stPo+ix0Vajm0
         sWaIMM0YVr5qFOpftOJY+7o1/KdTSGTKp08NKa9jTLIBjDHDplvdmFf09hqK3awQKQoA
         v0vSzJH1P6D0MSi3aNh0kmmiX/RrzrUSNBPdECry7hwXhhTK2yj+hLK3WV2E5snbmhl+
         YU+/Y7eFJVXmtMe4xlB0kgywcSqPwEvtZd9+uFu7mjmoW/UfRfEZMBt0FwEUkfmN0l32
         Z2lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9erJsT3n6dGNMQxxddzCZxm7IcW+kl6q+eqaPEHvZcI=;
        b=nGObpCp3v1IoLVCLObwA4rSPm6V0twBC1W1r/MnDGIUX6RgTxdpF08E2hHXMMSD7kN
         D7hXvzedZji5eYSQo7wpELvtBeISWYnyaDIolMZeZfgPfrVVEJxsB6YlbVSdjq0eVylo
         EeXXSwO42HR2REGWHb84o8UmKJ5uJf2i5ZRm09y+FaOtjDrnIwgcNiUMgy181FPE0QMv
         3bVnbwCe1ezH4s9LD0z4u3COy/bkI0K2UlOd15K4NikT5sappkXFnn+LVc1rcVGI/z1v
         4bxYTZDxn6AXLnTnhFtMdAjJQs9G3USak3iaeyPiHiKfVGk+vjwuiPSCxDEeHstGoWTL
         hF9g==
X-Gm-Message-State: APjAAAXLO5sWlkvpofMDiWzcnVAl+EKYngwq9rsntwu5bWtCBKyOSExi
        GPBXmk3de6TvFjMpmWVXHQw=
X-Google-Smtp-Source: APXvYqxvVPVf1XOyZkTiHwSEDbmbjmPPSCj+x9SIhee/LXm5/v0mKRdm5HiEkSYK1n+7oUpchgreWg==
X-Received: by 2002:a1c:9d8f:: with SMTP id g137mr8147243wme.26.1554466891124;
        Fri, 05 Apr 2019 05:21:31 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::df7e:4a05])
        by smtp.gmail.com with ESMTPSA id d14sm34454123wro.79.2019.04.05.05.21.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2019 05:21:29 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jagan Teki <jagan@amarulasolutions.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v2 1/5] arm64: allwinner: h6: orangepi: Add PIO regulators
Date:   Fri,  5 Apr 2019 14:24:42 +0200
Message-Id: <20190405122446.2101-1-peron.clem@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OrangePi One Plus and OrangePi Lite2 use the same PIO regulators.

Add this in the common device tree.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
index b2526dac2fcf..fd2af5095425 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
@@ -72,6 +72,12 @@
 	status = "okay";
 };
 
+&pio {
+        vcc-pc-supply = <&reg_bldo2>;
+        vcc-pd-supply = <&reg_cldo1>;
+        vcc-pg-supply = <&reg_bldo3>;
+};
+
 &r_i2c {
 	status = "okay";
 
@@ -191,6 +197,11 @@
 	};
 };
 
+&r_pio {
+        vcc-pl-supply = <&reg_aldo1>;
+        vcc-pm-supply = <&reg_bldo3>;
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_ph_pins>;
-- 
2.17.1

