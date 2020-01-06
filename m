Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6873DC33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 21:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B2D82072A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 21:52:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gQK8DrKl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbgAFVwW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 16:52:22 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37274 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbgAFVwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 16:52:21 -0500
Received: by mail-pg1-f196.google.com with SMTP id q127so27474343pga.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 13:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WhqR1/1MlVUjoENfjGDIreOdfy6GfxPgEoAWtDhN0Q4=;
        b=gQK8DrKlDGQnDMNra0PlNsTOHREW1yC3sxVpzB0qZCb9UM+p091dInwOxPher9gV/n
         I2s8vDLkf6BIdgh67RftE5yaQ7X9Mcj9sFwRdkbu2b4fzWO/I4rY4FZNAnlTDPjNtVsy
         u7rqiyjs9BcaCVv7oGWGA8AeC2lBHg9f4lRr4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WhqR1/1MlVUjoENfjGDIreOdfy6GfxPgEoAWtDhN0Q4=;
        b=FS7S8h7nbsQ/lWlTjbEvp3x0Zu34xBuRuztkFZ3//WEG5yhN+OHDmDVxlMAeX57gYy
         d4dSBBqYSbbiyCbDEMYlKN+KLht3at6oi92BjOWKfFYYE2NaVjr9uPUs9UAvoHwO/PG8
         T8FfvTGqDIbBvuXYpj+bV0GPntrX33Vs0WOBHECbWKYwY0lN4N5v6nM99A91Fu8g2CQL
         0lDWbv7XFwtskQkyoqWmOtu+tWFPMCALjsffGUhHPqKeE10YHK2V0jGxXN+7t/xCHPA0
         YjsM7NydRy+7bmbF12jsShi7Sin5hTeFAhU2X+K/mkrTFr8DRAh9e75MrynbDCzxhAJ8
         ycXQ==
X-Gm-Message-State: APjAAAVOvir+qXZmCxeaMPo3PUB7mwJafLy315RSx9pM51VG6PFv9SIJ
        8dG5x5EaOY+DtSyA2LlGgmkRCA==
X-Google-Smtp-Source: APXvYqxyWaoI/OIl6fTrlNo3OKnYhN6S0VeCnD1VQu7xJTxqyHXS7GKPxBP+33HmV2tCGrUvChFyxQ==
X-Received: by 2002:a63:5920:: with SMTP id n32mr111368952pgb.443.1578347541160;
        Mon, 06 Jan 2020 13:52:21 -0800 (PST)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id b193sm71513996pfb.57.2020.01.06.13.52.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2020 13:52:20 -0800 (PST)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-rockchip@lists.infradead.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH] ARM: dts: rockchip: Use ABI name for write protect pin on veyron fievel/tiger
Date:   Mon,  6 Jan 2020 13:52:13 -0800
Message-Id: <20200106135142.1.I3f99ac8399a564c88ff48ae6290cc691b47c16ae@changeid>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The flash write protect pin is currently named 'FW_WP_AP', which is
how the signal is called in the schematics. The Chrome OS ABI
requires the pin to be named 'AP_FLASH_WP_L', which is also how
it is called on all other veyron devices. Rename the pin to match
the ABI.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---

 arch/arm/boot/dts/rk3288-veyron-fievel.dts | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/rk3288-veyron-fievel.dts b/arch/arm/boot/dts/rk3288-veyron-fievel.dts
index 9a0f55085839d9..d66e720390121d 100644
--- a/arch/arm/boot/dts/rk3288-veyron-fievel.dts
+++ b/arch/arm/boot/dts/rk3288-veyron-fievel.dts
@@ -382,7 +382,11 @@ &gpio7 {
 			  "PWR_LED1",
 			  "TPM_INT_H",
 			  "SPK_ON",
-			  "FW_WP_AP",
+			  /*
+			   * AP_FLASH_WP_L is Chrome OS ABI.  Schematics call
+			   * it FW_WP_AP.
+			   */
+			  "AP_FLASH_WP_L",
 			  "",
 
 			  "CPU_NMI",
-- 
2.24.1.735.g03f4e72817-goog

