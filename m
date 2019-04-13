Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A17C282CE
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 17:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA42E214D8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 17:15:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="YNBV7o+D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbfDMRPt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 13:15:49 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55571 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727048AbfDMRPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 13:15:48 -0400
Received: by mail-wm1-f66.google.com with SMTP id o25so14989754wmf.5
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2019 10:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3t2VA5TTre+AZliJf9BQLiPu2UPCQMoeVa/gyjIW8SY=;
        b=YNBV7o+DMqHuxMHouOE/GNfPBXveM9hvT5oc9C4FrVqZy8LuDEfwi9/SETrPKnMNvA
         C+Kqk6/Fa2Ud1yKfudDbcA0f10DSxhjZitAisi2DIfhVbX2YVkxXRHF8OVPWHctBRnW6
         m3wmdo7dHjzRAZdsG03XiQnbbOz5r88t8TFknjlZMYDJ5j0OtxwinZlUrNhENO2uyKDB
         i5Ih2P3jclBMhU9FVRb01pmUo2U8RpCW21QGR3JgOwbeH9HC3xzmQ6opKPI/+oY8P3/A
         i/ZibEXHLn9utIHzFwUFewN+vv4BHngdOf/JQTALq6UTWHjUpkgJlaC2vBUmwvBeoV2F
         2eiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3t2VA5TTre+AZliJf9BQLiPu2UPCQMoeVa/gyjIW8SY=;
        b=Snhegb7zpqVE8RXEsmX37cl9Ct8gUkF3f9VR6kG/MYNHJEIlhoR1t8xmX21+p/srw5
         BE7y4W3LP/hQ+T0HOIEjeJQHEJ6WshsmUgRD5jz5WlR4e0F/nGiVOmUcY1olUSTt2xJZ
         EWXSz+SoyHg0KCF/GhdOxgj1Z6M6Zxk8FLAGbl0gjAUD8FFxhpj9XJoDACsDo62IhFQx
         oDrVjuxNubsZCS0I0BJe2xZ5VXF1kTGH3wa4r3mHe4dI3x5F4owTa2F5bj3mX0YGivkm
         a3hD1TGjp58EDTMZSTMtOAmAbespdMKq5gA+CPdYvnbh5klYziKu81al36bn4gkBWhaY
         KoTw==
X-Gm-Message-State: APjAAAXbbWq9jMJj16cz3PEvnwhyu5/LBggASDhZr+yZt046VPGMGOmw
        8bRWHj1PLE+xTWWNH523KX4=
X-Google-Smtp-Source: APXvYqxdocTQnfviHVwHfmzUPilRZK9Z+H8UpylYEkwgI1prhyx5CDMUlAOI4buWF98nqmXS90m26g==
X-Received: by 2002:a1c:c186:: with SMTP id r128mr15209469wmf.100.1555175746655;
        Sat, 13 Apr 2019 10:15:46 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133C8AD0010B8127C043607D1.dip0.t-ipconnect.de. [2003:f1:33c8:ad00:10b8:127c:436:7d1])
        by smtp.googlemail.com with ESMTPSA id h84sm16745965wmf.15.2019.04.13.10.15.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Apr 2019 10:15:45 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, khilman@baylibre.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mjourdan@baylibre.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 1/3] ARM: dts: meson8: add the canvas module
Date:   Sat, 13 Apr 2019 19:15:30 +0200
Message-Id: <20190413171532.25967-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190413171532.25967-1-martin.blumenstingl@googlemail.com>
References: <20190413171532.25967-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the canvas module to Meson8 because it's required for the VPU
(video output) and video decoders.

The canvas module is located inside thie "DMC bus" (where also some of
the memory controller registers are located). The "DMC bus" itself is
part of the so-called "MMC bus".

Amlogic's vendor kernel has an explicit #define for the "DMC" register
range on Meson8m2 while there's no such #define for Meson8. However, the
canvas and memory controller registers on Meson8 are all expressed as
"0x6000 + actual offset", while Meson8m2 uses "DMC + actual offset".
Thus it's safe to assume that the DMC bus exists on both SoCs even
though the registers inside are slightly different.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson8.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/meson8.dtsi b/arch/arm/boot/dts/meson8.dtsi
index 7ef442462ea4..6b5c90bb960b 100644
--- a/arch/arm/boot/dts/meson8.dtsi
+++ b/arch/arm/boot/dts/meson8.dtsi
@@ -228,6 +228,27 @@
 		};
 	};
 
+	mmcbus: bus@c8000000 {
+		compatible = "simple-bus";
+		reg = <0xc8000000 0x8000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0xc8000000 0x8000>;
+
+		dmcbus: bus@6000 {
+			compatible = "simple-bus";
+			reg = <0x6000 0x400>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x0 0x6000 0x400>;
+
+			canvas: video-lut@20 {
+				compatible = "amlogic,canvas";
+				reg = <0x20 0x14>;
+			};
+		};
+	};
+
 	apb: bus@d0000000 {
 		compatible = "simple-bus";
 		reg = <0xd0000000 0x200000>;
-- 
2.21.0

