Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C74C04AB4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 07:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C367D20848
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 07:14:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="hIzpxAqG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfEPHOE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 03:14:04 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46072 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbfEPHOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 03:14:04 -0400
Received: by mail-wr1-f67.google.com with SMTP id b18so2017794wrq.12
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 00:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VfCCJLVSfHmoPDAPoxVwjeh8RznaZsaWhre6aDFNPIM=;
        b=hIzpxAqGm2mhKRJYGO+YsjXJtG3/Y3HV1euq2BEEfoOJk4PDOeGY/qCyeApBn8Ueq0
         V7kJVjFDtawFjNmvTzpxqx1rbpRxVdsqbNJ4cC3WcC6pzlKnLht0aS1u8/PMjDvJnCeK
         nfzR9L6tlulhvTKK9hFXNqtrubFaHwYa0BhMwPzRgdUFY8HASnBcI9uy1IZLcZJ5NAHp
         o5lqypEEXV96kU4+iefo6p+9eXh5YLnFPiZRwzx5/06TL77E9tJozgTquElaAF6VA3/S
         RA9kg3I6agdjesBqj4Is+osqQ9hLHrzxTcs6N5hsuGH3dixd4Mf4NVgIEip32AHIpJ74
         rVGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VfCCJLVSfHmoPDAPoxVwjeh8RznaZsaWhre6aDFNPIM=;
        b=SPWMgmKHV9OZgZ1qpJ2iqDSBQZM9dnUUqvSX5F7OGP471t3KqeIi0XDnhlcvEitqdk
         qRMYbo+O/wiU0Ubu1lvMu3QatjQDaw0FJBqBIhCwcrnFax4+pLrkC1jonY+UOyJbwz5f
         bJ1YdExxnaHW6yQXXCyrhdct09SLXsYdPYSrMuLQZty2B4fVLXs6UsdLuB3GEC4b5dAI
         ZjDst6AowrEHM3RalBqUiqPg+dFtHwrovIHa8afQ62qrHy6izxyarNg7ZFo1cDPUrjdG
         3oS6knYQpj+B9RW7/sfA+zaFiuVI7bEpEqlsdSJigyw78kRO46O2Z+xj0y35z3PvROFX
         2SjQ==
X-Gm-Message-State: APjAAAXXoC5JyUVls5QSQHu+Jp0CbCb29SAxJrLsxBWY8OircWg3Qku3
        71SjA287ydjjngpelZIOSEWGlQ==
X-Google-Smtp-Source: APXvYqy6tYfmy3A5aGFSOaSVHlYWAwVjpgeh4xahSE6WzNjqgCYsJB/OQVjBgZAzXUNEhgfdt/0vEQ==
X-Received: by 2002:a5d:49d0:: with SMTP id t16mr19217158wrs.324.1557990842582;
        Thu, 16 May 2019 00:14:02 -0700 (PDT)
Received: from boomer.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id x187sm5454331wmb.33.2019.05.16.00.14.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 May 2019 00:14:02 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: meson: sei510: add bluetooth supplies
Date:   Thu, 16 May 2019 09:13:55 +0200
Message-Id: <20190516071355.26938-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bluetooth vbat and vddio power supplies

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
index 61fb30047d7f..dbfbd50359e5 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
@@ -170,6 +170,8 @@
 	bluetooth {
 		compatible = "brcm,bcm43438-bt";
 		shutdown-gpios = <&gpio GPIOX_17 GPIO_ACTIVE_HIGH>;
+		vbat-supply = <&vddao_3v3>;
+		vddio-supply = <&vddio_ao1v8>;
 	};
 };
 
-- 
2.20.1

