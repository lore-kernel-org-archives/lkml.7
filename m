Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF9BC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 15:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D62DD21773
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 15:11:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yve2LgbR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731091AbfEWPLS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 11:11:18 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34730 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730913AbfEWPLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 11:11:01 -0400
Received: by mail-wr1-f65.google.com with SMTP id f8so6720226wrt.1;
        Thu, 23 May 2019 08:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fvwl941ZyZparX8brXidU5HoO9Ig5nxnHgPKZgnW/1Y=;
        b=Yve2LgbRgQFXq5aIqAwhcfwMswZWViqZB/KmVUu3hw5Tf73rg8LXrUSIFyFiDaI1oo
         rDv9GPVjh5m3Q5qUsWY4Ogxgi96iD32VdLDa55OJPVCRLfYFidu8o4go8sGRrevZbD3+
         mHTE/bHUk1wWnyiviVnrdU8HWICQGOBgbqtiT8ojO64FvNg/gnIKyJ42j43fpTfxaiHc
         uzDLS7aB5+U0jAXgSiMn1IG9dop6BCSzKO4uJWrUbed27A+G2p8zl6rSfCVdDnDYY1fb
         e/6vygjTUuhM8CixQDAe3hSJxMK70dOguE4Fbz0psqe8D4ViNOcLMU5DCtM7mDbt0N0J
         yyrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fvwl941ZyZparX8brXidU5HoO9Ig5nxnHgPKZgnW/1Y=;
        b=lrRqpWUk5VoiA6vXUOchUnQ3d006VRYPG/5UYem+iVBgqqonP5hgfAT78DS307lZIE
         0mLg+LPQjfvnhahUs260q4lYZfhyZvhYLjYvnSVVCf4Gyt+8ktaPGMTNCgcVpmLuO9+i
         sspYCIpsgsbxZlMJkmhFdErQvAychSkFIqaGYGSERTa86asPtDiFAYsWftiKzu5ieCQ7
         boXsUUlALdoXc4saSuL8e8DmYKX8F5J4goTTARd9FH7Lk1iCMJZilB6wxGZqgKNmOVCn
         oXlky8v7pG8d87EbcXkwcv2LuV+pPXYw3Gyn5RcAi1PNntl02uNQjAxup9jmZbrhE2wq
         kXQg==
X-Gm-Message-State: APjAAAXzYlcT0q9ACg/MxSU1do9XzJ3UWvhHGARPUwl1CAkUz2BDjzPK
        0AZVibvBRMl+Cd8/siP6Vkw=
X-Google-Smtp-Source: APXvYqxAcBpYdRU3uQXQXxzbY6tmx0nOvPyZ2p1H1iqb2oHivmiO7eV7p5Mn9yabh14Q8bSMmaRF6g==
X-Received: by 2002:adf:f6c4:: with SMTP id y4mr33608596wrp.37.1558624259318;
        Thu, 23 May 2019 08:10:59 -0700 (PDT)
Received: from localhost.localdomain (18.189-60-37.rdns.acropolistelecom.net. [37.60.189.18])
        by smtp.gmail.com with ESMTPSA id q15sm11436324wrr.19.2019.05.23.08.10.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 08:10:58 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v5 3/4] arm64: dts: allwinner: h6: add r_watchog node
Date:   Thu, 23 May 2019 17:10:49 +0200
Message-Id: <20190523151050.27302-4-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190523151050.27302-1-peron.clem@gmail.com>
References: <20190523151050.27302-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner H6 has a r_watchdog similar to A64.

Declare it in the device-tree.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index 13e70aebddbe..b9a7dc8d2a40 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -631,6 +631,13 @@
 			#reset-cells = <1>;
 		};
 
+		r_watchdog: watchdog@7020400 {
+			compatible = "allwinner,sun50i-h6-wdt",
+				     "allwinner,sun6i-a31-wdt";
+			reg = <0x07020400 0x20>;
+			interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
 		r_intc: interrupt-controller@7021000 {
 			compatible = "allwinner,sun50i-h6-r-intc",
 				     "allwinner,sun6i-a31-r-intc";
-- 
2.20.1

