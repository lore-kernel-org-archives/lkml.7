Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4242C28D16
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 09:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89EE928039
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 09:47:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Ut4CpPOc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbfFCJru (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 05:47:50 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53499 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727048AbfFCJrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 05:47:49 -0400
Received: by mail-wm1-f65.google.com with SMTP id d17so2716632wmb.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 02:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MoxNzpWQVj3xGf+AW7qTWtzH4kDOxsop7x8jayF4ITg=;
        b=Ut4CpPOcIzFoSm2DnrLirVaBtT//sE/onDrTVZt0GIGlHIdgULDH1oHO8vcGa6UH8M
         5H128okQ2iVCIbiFe8oHfPPSZtoffh6qcZiNiRKOkIyHvjAqbRJA4Q+Mz907K+xwB+CA
         rrmbEJxs/jT/zv5b5OmFv3s/oyz3M/C1o6yie9LaySajfCkHTt02mNB05k6EyC+nf8Q7
         P+r3ocNo56AK4ES9pVjfx84lfe5BrvbZImD7Qep7hY0XjOCfDIOop9/Q8tl8Oa9Hn2Bm
         9gRzJn+Kihhn6BXEcbk5fmUkUUbIq69Y2yNkinwyOMncL0Q6veEmufbbf7dcQnion7ia
         sWUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MoxNzpWQVj3xGf+AW7qTWtzH4kDOxsop7x8jayF4ITg=;
        b=givh6mwgQw5nL9SAniqP9Abey0ngwo6Sn9kWovASfJdHdq5aQ0BWeL5UuRxSBBwFuX
         CdCNp06cm/FmMkOZhox3JtbY2rAj/riRfrmkoHuQPWTm82J+ZzbIQHDerW/SA3UxJOwm
         O9sZjPNvx087y6YEuyYzPoXpdIvX6XQ7zvBarQIZSBq2oGnHhj80DxBJ4QlW90WUoEaO
         HbKPiRuR5wW94WHZvq+/UtOU01bZoUsGSijTjr0aB+1oqw5J3Xj5q8Me/I0fPHzAxU18
         YcfcDRYiIZcvLL3VMkKWrFiRgjQxh+8l+IHKNov5JMYzrqXBomiC7Y0ASF5bVfGBig6U
         JVvw==
X-Gm-Message-State: APjAAAXb1L0ngsJWS6H3biptaXXaGcGj6vxP4iyjpz1lqAxHZ0qwDc6S
        zMM68sN+buDDmjvpp0qc/Hixew==
X-Google-Smtp-Source: APXvYqysDwK7C0l+WDPz6vO304cArW9VR5HPMJmOZlDtDrMmMaHe/bWLKBDfTEI9DaeyyZ3xt5eHVQ==
X-Received: by 2002:a1c:e90f:: with SMTP id q15mr10003607wmc.89.1559555267708;
        Mon, 03 Jun 2019 02:47:47 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id z14sm11235375wrh.86.2019.06.03.02.47.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 03 Jun 2019 02:47:47 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 1/4] arm64: dts: meson-g12a-sei510: add 32k clock to bluetooth node
Date:   Mon,  3 Jun 2019 11:47:37 +0200
Message-Id: <20190603094740.12255-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190603094740.12255-1-narmstrong@baylibre.com>
References: <20190603094740.12255-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 32k low power clock is necessary for the bluetooth part of the
combo module to initialize correctly, simply add the same clock we
use for the sdio pwrseq.

Fixes: d1c023af1988 ("arm64: dts: meson-g12a-sei510: Add ADC Key and BT support")
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
index eac57d997e0b..3e0e119c13ce 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
@@ -530,6 +530,8 @@
 	bluetooth {
 		compatible = "brcm,bcm43438-bt";
 		shutdown-gpios = <&gpio GPIOX_17 GPIO_ACTIVE_HIGH>;
+		clocks = <&wifi32k>;
+		clock-names = "lpo";
 		vbat-supply = <&vddao_3v3>;
 		vddio-supply = <&vddio_ao1v8>;
 	};
-- 
2.21.0

