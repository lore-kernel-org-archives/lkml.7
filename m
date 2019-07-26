Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BCF3C76191
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 12:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 456A022BF5
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 12:46:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="EbxJlKQJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727373AbfGZMqx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 08:46:53 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39163 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbfGZMqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 08:46:52 -0400
Received: by mail-wr1-f67.google.com with SMTP id x4so1162957wrt.6
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 05:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GnVNZrf3NrBA1rEJS3yEc20MogrzrhTJ4K84VxPwt+M=;
        b=EbxJlKQJkFWK+Xju80qYs0AUcIev9OIj1bvka8/3uHjZVTLK6ajBrvJpSOw63+t2bD
         ykTSio0wJbXFYFHZY0WbG9N5dfRVVeaCelFlY0kK+KMgZ3NjEv99RC/dx2lrvTiA2XID
         4dFKdBf8/gJ+hht7efgDFe3KUN8VWINUqyrPfRT8NI3G6wS3W5PkjJx1nqi7ZxM3CnPC
         lBqlQF7nh74Lwp2N5k+eI1omnQcUAr2Z1M3arcPRJP16uXcctKdNVtUaRiRV4Vod5iGz
         G5UOpMCjRF989nTulaQyhQmCFu+FOfsyhol9WRQqDIUyRIp9UiwcLxKpELfeU9Oaz6lQ
         g6+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GnVNZrf3NrBA1rEJS3yEc20MogrzrhTJ4K84VxPwt+M=;
        b=Vn4MPLEeFTmBcfH5IWUGN/mHpnkjr2/c1udwFu9PvlpdqyQ1HeuB3KlELgFcwTc93i
         7naR1camOmlKLN37hJTBIqj7btE8Z43SqjluqwCV+dU6gSD74BovZdvTWj6aGKVwsQ71
         UcrqCk/kJYJLxihI+Hm4OhkSHju1xf3YqMWHuJQYXTZeYTHl5teNQveqJrSmIGUTln4z
         VuPWvYwEDKgVQcQxzJzeIObsCrFQy3yXJk+RKFJeXcKfADTEYpOub5niOCzRP87w+4UM
         NyDLfjI1GKHoNqrcD9tZg9uQp2GNTOWPJ/cX7y/aeEJywO4aJYQSIV1JQwFsG4QL/YK6
         l32w==
X-Gm-Message-State: APjAAAVdqMhUpCZqiWWdNOT3JYSXVZzvjpJCFPDllaCyjYnghAyeKpaD
        X4vWdV6NZoJq+l9IPZiQ69rkAg==
X-Google-Smtp-Source: APXvYqzJugJd3lJHrKUFGoc3lueZYS8pq3Az7Tfvg22mTfEOJ5LzNpMo3dpS+nX/DOufWWarEEiNLg==
X-Received: by 2002:a5d:53c2:: with SMTP id a2mr23921778wrw.8.1564145210215;
        Fri, 26 Jul 2019 05:46:50 -0700 (PDT)
Received: from mjourdan-pc.numericable.fr (abo-99-183-68.mtp.modulonet.fr. [85.68.183.99])
        by smtp.gmail.com with ESMTPSA id x16sm39090124wmj.4.2019.07.26.05.46.49
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Jul 2019 05:46:49 -0700 (PDT)
From:   Maxime Jourdan <mjourdan@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH 2/3] arm64: dts: meson-gx: add video decoder entry
Date:   Fri, 26 Jul 2019 14:46:38 +0200
Message-Id: <20190726124639.7713-3-mjourdan@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190726124639.7713-1-mjourdan@baylibre.com>
References: <20190726124639.7713-1-mjourdan@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the base video decoder node compatible with the meson vdec driver,
for GX* chips.

Signed-off-by: Maxime Jourdan <mjourdan@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
index 74d03fc706be..86e26ed551e0 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
@@ -437,6 +437,20 @@
 			};
 		};
 
+		vdec: video-codec@c8820000 {
+			compatible = "amlogic,gx-vdec";
+			reg = <0x0 0xc8820000 0x0 0x10000>,
+			      <0x0 0xc110a580 0x0 0xe4>;
+			reg-names = "dos", "esparser";
+
+			interrupts = <GIC_SPI 44 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 32 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "vdec", "esparser";
+
+			amlogic,ao-sysctrl = <&sysctrl_AO>;
+			amlogic,canvas = <&canvas>;
+		};
+
 		periphs: periphs@c8834000 {
 			compatible = "simple-bus";
 			reg = <0x0 0xc8834000 0x0 0x2000>;
-- 
2.22.0

