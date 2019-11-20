Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8736DC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 11:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5960F223D0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 11:14:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="uxjV/l32"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729062AbfKTLOq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 06:14:46 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37099 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727777AbfKTLOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 06:14:39 -0500
Received: by mail-wm1-f67.google.com with SMTP id b17so7368783wmj.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 03:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cvIKYbv02jfkUFc5yq+y3wt+kyYSZpa4lPRFM3efvsQ=;
        b=uxjV/l32qVppX/6hMVYuLEHcOzTj2V82Am9eU53lR9/+lCm7uQx0b9YxSnHTPQ2RO2
         kL/nKisP9MMXL2jYLueogpXsVMaPPbGFTCb/jGhjw4leb0TyI0idM0AlU2tAuOWqhNxM
         Bqk/fIB8fJYIkxRuSMzWrXXUER86zpAKud6mSMe1uPEW+wBRA3rKKt83LHZv3tJdfkWY
         TnWsDxjkeZ1Nd32BfTPn0Vqv9FCyLBzt5Vbaunp905EyhrTtIijoXRk7/6RgHOP/7KYx
         lsmVWz5XokU4Yky4+lN8W8NzSRK6N3Ht8/cHS+kEb5i70Q5qlu6u6CpFJo3P6qvgeycm
         /sGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cvIKYbv02jfkUFc5yq+y3wt+kyYSZpa4lPRFM3efvsQ=;
        b=cmjrr+2JQikg5ILQ3dLCZIKHzQAmDH/FKeldkQuiFt6zDvRkr0MLFxPuUdXiMhckfR
         8p0t67/EQmjaomToCWSwbzRcizqZdVb2dSbUzgRyrgCRNvTexpkh5sp6inEQWV955QPE
         4NxI2IAlbylzcBSAJpMQfIeI9OGGX+9YW+3F0Id1b/7M85gG9MjJv/K4It/9/oqzT4kp
         KnXZnzQCC10wmbSHA8baw5tohu1AtZ7NZE9ibJZGY42MK1a2HvIx24+H7ZnRhlxr79RY
         c8InkKdbLu7e2fefTOvw6KeYYbmPD+fN/GzDeEYoibFFNEcSaiWZLwn+rPKLGXCNN/KT
         ZZAw==
X-Gm-Message-State: APjAAAVY7Qosk+jCVYyJlvKnE776POc0qNzIBx2RkdqBgjPoRP8CxI6H
        RFgf9uyXGkUGe+beEjTNe5fGpw==
X-Google-Smtp-Source: APXvYqzweKOlyuKQyMd1c/pQf5Z3HB8SFvqepcvQaZ5FjDPXqF7JOhs3aoQy+ZURieFYrTLyR80vzQ==
X-Received: by 2002:a05:600c:299:: with SMTP id 25mr2616954wmk.50.1574248477850;
        Wed, 20 Nov 2019 03:14:37 -0800 (PST)
Received: from bender.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id u1sm6061748wmc.3.2019.11.20.03.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 03:14:37 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     mjourdan@baylibre.com
Cc:     linux-media@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 4/4] arm64: dts: meson-g12-common: add video decoder node
Date:   Wed, 20 Nov 2019 12:14:30 +0100
Message-Id: <20191120111430.29552-5-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20191120111430.29552-1-narmstrong@baylibre.com>
References: <20191120111430.29552-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxime Jourdan <mjourdan@baylibre.com>

Add the video decoder node for the Amlogic G12A and compatible SoC.

Signed-off-by: Maxime Jourdan <mjourdan@baylibre.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../boot/dts/amlogic/meson-g12-common.dtsi    | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
index 3f39e020f74e..6fe7dead5a92 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
@@ -2152,6 +2152,29 @@
 			};
 		};
 
+		vdec: video-decoder@ff620000 {
+			compatible = "amlogic,g12a-vdec";
+			reg = <0x0 0xff620000 0x0 0x10000>,
+			      <0x0 0xffd0e180 0x0 0xe4>;
+			reg-names = "dos", "esparser";
+			interrupts = <GIC_SPI 44 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 32 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "vdec", "esparser";
+
+			amlogic,ao-sysctrl = <&rti>;
+			amlogic,canvas = <&canvas>;
+
+			clocks = <&clkc CLKID_PARSER>,
+				 <&clkc CLKID_DOS>,
+				 <&clkc CLKID_VDEC_1>,
+				 <&clkc CLKID_VDEC_HEVC>,
+				 <&clkc CLKID_VDEC_HEVCF>;
+			clock-names = "dos_parser", "dos", "vdec_1",
+				      "vdec_hevc", "vdec_hevcf";
+			resets = <&reset RESET_PARSER>;
+			reset-names = "esparser";
+		};
+
 		vpu: vpu@ff900000 {
 			compatible = "amlogic,meson-g12a-vpu";
 			reg = <0x0 0xff900000 0x0 0x100000>,
-- 
2.22.0

