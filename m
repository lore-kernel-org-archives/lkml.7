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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D17C282DA
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 17:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9CA62147A
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 17:15:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="GO3cnXo9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbfDMRPv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 13:15:51 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38444 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbfDMRPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 13:15:49 -0400
Received: by mail-wm1-f68.google.com with SMTP id w15so14636750wmc.3
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2019 10:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9E4DqO8/055EQu/UGPx4DBiSsBA4UG4QMItls5PqPKk=;
        b=GO3cnXo9kZsGfjtyf+gzqQgQqYKamzRbp9AIl30FP6zlcfwC6HZWxb+96HyFGCl/tC
         tAaExNm6/xiVgu+fE0uxop2J60+7hva51T4Kz+rJedJWFAIKwHSvizMYADo5Fm/fekLg
         jIHpKhjdNb+dJeBIfImWiMXlo16mtyhB9LDCbBMVND+Pmw4LvaPq0TTrARRdhObm6FFN
         i6mp7QEGRi9atbWrsbtLBSz3HMKg/U1BVMXua6Xh9Dl9urx07XSgUAC6ZRplI6xbJw4q
         9BNbwvf4A75wQKN9ZsIRW1yDgi7RKvJTcrMJvfrHU3Xv4tn6ywh/Q+TgH1RrXRbz8LfQ
         Xk5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9E4DqO8/055EQu/UGPx4DBiSsBA4UG4QMItls5PqPKk=;
        b=TFBeqgH7VD2CA1g+DJ0iRD2HLEaY0oOFnHZGMJ/0rrsJdF4ZZDqnjazcr6HS1JP8r9
         8XJDWu84biUk9OnlCwDPwUCyt19ZZBM/eXNMmg/Cn3Znehoy7fu8ysJCRMobcX3bVthL
         kjnd+2BJjSh00t6ydDGjcnxvT0/ggLAj8sCMC0l5QUbMTNK8q6WvsZ7Nj6x7IsC254ys
         Fkl9gg4IvBHR5YE66iVHyJozJQMBl4HVHaVWj3sHsLvvFe1PPks1qNGnfoQEQPmZGOd8
         eBj+FGnxt8/7aXzx0fU/LyMszdcpDr32TJ8UzD0hjoFlXgg4WLkDC5/pyO7lsZn8k5TT
         tInA==
X-Gm-Message-State: APjAAAVkwxs/74otRvb0qCWZ9K/lDnussj6dHGLABzsOL2YrKPEMXY9y
        UybgznrVYVW7euqle29IhZQ=
X-Google-Smtp-Source: APXvYqwqulVeTNBwX8bThrfS/jug+deJWy/IZW1GcRXa1i2SC13VSB4fi9ZufadnQs3W+sINIixmXQ==
X-Received: by 2002:a05:600c:d4:: with SMTP id u20mr15272538wmm.88.1555175747733;
        Sat, 13 Apr 2019 10:15:47 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133C8AD0010B8127C043607D1.dip0.t-ipconnect.de. [2003:f1:33c8:ad00:10b8:127c:436:7d1])
        by smtp.googlemail.com with ESMTPSA id h84sm16745965wmf.15.2019.04.13.10.15.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Apr 2019 10:15:47 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, khilman@baylibre.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mjourdan@baylibre.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 2/3] ARM: dts: meson8m2: update the offset of the canvas module
Date:   Sat, 13 Apr 2019 19:15:31 +0200
Message-Id: <20190413171532.25967-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190413171532.25967-1-martin.blumenstingl@googlemail.com>
References: <20190413171532.25967-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the Meson8m2 SoC the canvas module was moved from offset 0x20
(Meson8) to offset 0x48 (same as on Meson8b). The offsets inside the
canvas module are identical.

Correct the offset so the driver uses the correct registers.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson8m2.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/meson8m2.dtsi b/arch/arm/boot/dts/meson8m2.dtsi
index bb87b251e16d..e88c36d47e5c 100644
--- a/arch/arm/boot/dts/meson8m2.dtsi
+++ b/arch/arm/boot/dts/meson8m2.dtsi
@@ -14,6 +14,16 @@
 	compatible = "amlogic,meson8m2-clkc", "amlogic,meson8-clkc";
 };
 
+&dmcbus {
+	/* the offset of the canvas registers has changed compared to Meson8 */
+	/delete-node/ video-lut@20;
+
+	canvas: video-lut@48 {
+		compatible = "amlogic,canvas";
+		reg = <0x48 0x14>;
+	};
+};
+
 &ethmac {
 	compatible = "amlogic,meson8m2-dwmac", "snps,dwmac";
 	reg = <0xc9410000 0x10000
-- 
2.21.0

