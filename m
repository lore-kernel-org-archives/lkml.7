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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9710FC10F14
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 17:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FEC52147A
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 17:15:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="HJ/Kh2VD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbfDMRPw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 13:15:52 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54594 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727048AbfDMRPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 13:15:50 -0400
Received: by mail-wm1-f67.google.com with SMTP id c1so14994985wml.4
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2019 10:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hh4yQhBPQBAdSO+xFdJJMR708sMAiI2dTB3FREcZ1hY=;
        b=HJ/Kh2VDa75prfApuD4ohFKbR59qt3c33FjtOX9Syf/JVbkhZspLRmb5DIIt+lheAs
         nWrn4rqtDiPcVFtE2lH2and3RpljIQ1OykU9DeRuGXzG9/Wf4wHIYq99mkrDVwp4duis
         XNGCFuIydP3UluqgcMxDdIzaB3o+O86RXSipzq4iSca5wRStLlkZl3LOyplX8jRpImyl
         ix8KcTtLR07fCoBGp0+QS3bdx2e7EgcDFu0NLPullRshvvU3nbDFBHxfytIfDjw7sVPv
         1VY5kzV5PNgtLr3Sgj4ICzys3q+0uMHolqGNadM/7CCaMcxa2PlUuDNa4XWVK7eAZh/c
         uTlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hh4yQhBPQBAdSO+xFdJJMR708sMAiI2dTB3FREcZ1hY=;
        b=iyOScZBQ6l3HNnCjPGJYKzjn2RNMtLFgNAfWqySo4lgyj+lfrml4gYxq82s5sQi8HT
         8fyUujVhORdYyCGAjcL8h75i5R8gAthRwmKtb1P1/kJ3BWxjpalbs8Db7BgFr9Dm16dM
         Zi5eKeDa0N/jzABAzMQHpC9nTkeCCqtdzqyaeowUTQ9hCIeq81AHBTj0ysjBbMHSGkD0
         OLvWdsiPwqrWkJwOwyeUvns4EzCZWKDQhYcYldpRGWZ43td7j957n0xiWywJOEwTDilp
         eAKpf9resr8RlBWMLRtrxRawu1Ma1b8R3aQC+GOwFy7n6OtMDCaPTgX0w49KqU770hba
         szFg==
X-Gm-Message-State: APjAAAVRWvGbmLTuoh+vsi2CQ4/403YSS934jv8iCKf3XUdCJgjcDR0J
        jnwHloT4kftwWOB02fN4KXU=
X-Google-Smtp-Source: APXvYqwGOIyVec7OvKYIPCbs4ICpJgtfXHVwGRFw1T99hR9Eoj+/h4tXMYu24BOuFeGlD7h6IVpfIA==
X-Received: by 2002:a1c:e188:: with SMTP id y130mr15041584wmg.83.1555175748947;
        Sat, 13 Apr 2019 10:15:48 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133C8AD0010B8127C043607D1.dip0.t-ipconnect.de. [2003:f1:33c8:ad00:10b8:127c:436:7d1])
        by smtp.googlemail.com with ESMTPSA id h84sm16745965wmf.15.2019.04.13.10.15.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Apr 2019 10:15:48 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, khilman@baylibre.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mjourdan@baylibre.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 3/3] ARM: dts: meson8b: add the canvas module
Date:   Sat, 13 Apr 2019 19:15:32 +0200
Message-Id: <20190413171532.25967-4-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190413171532.25967-1-martin.blumenstingl@googlemail.com>
References: <20190413171532.25967-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the canvas module to Meson8b because it's required for the VPU
(video output) and video decoders.

The canvas module is located inside the "DMC bus" (where also some of
the memory controller registers are located). The "DMC bus" itself is
part of the so-called "MMC bus".

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson8b.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/meson8b.dtsi b/arch/arm/boot/dts/meson8b.dtsi
index 800cd65fc50a..f4e832638e9c 100644
--- a/arch/arm/boot/dts/meson8b.dtsi
+++ b/arch/arm/boot/dts/meson8b.dtsi
@@ -205,6 +205,27 @@
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
+			canvas: video-lut@48 {
+				compatible = "amlogic,canvas";
+				reg = <0x48 0x14>;
+			};
+		};
+	};
+
 	apb: bus@d0000000 {
 		compatible = "simple-bus";
 		reg = <0xd0000000 0x200000>;
-- 
2.21.0

