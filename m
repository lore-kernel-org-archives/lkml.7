Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA35C76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 15:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B44A52190F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 15:03:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="mrJgOxH8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbfGVPDW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 11:03:22 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37522 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727346AbfGVPDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 11:03:21 -0400
Received: by mail-wr1-f66.google.com with SMTP id n9so14719849wrr.4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 08:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7sHmLWUZTOubwniZNmRjFR+C4eT64A3MhAkvvXjkgx8=;
        b=mrJgOxH8FNxXre25hO4e4JqY5KaSUwL9WKRb7av9PtAPr5yDAKsxN/QNtIEQbMtuXa
         jPjtGQMpFU6ZerdbIG2E5QmtaGj4FkqGBq/hRl+7EGoTSVdZEkAKoQ2B3HjHMrCnc6Rh
         IesPYBLjmdiz5wyfddmoB1EROajzaw2hurkPAf3sjXCNrHA4jrTSOL4dLzyQfzrhZ/O9
         eJLTNmT/646NjjFcp+oYe+2reOatt6QB32QDVcnuEEcI5WAnQpXNx1i23Jgijiux/ZwD
         FKycwkiGTXeeRKkMtPDHeNx+ydKt/8sLZeJjPtJXHLw0FaBI/69FiyYVR7tpJblh3Npv
         06oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7sHmLWUZTOubwniZNmRjFR+C4eT64A3MhAkvvXjkgx8=;
        b=tiXCANQYb6OzvCHfuBpoCbS3B5Ej2AuGhC858yJaI+CQdlKAwm2aXLTLRRuOwNqWwM
         4Ck9MkWb4wE0D/Iz2Jim9o+lOu7hsMVOlT1y9eEtRgoqJqz1jyToKWiZo7BmE+cYWx/Q
         3u4+iN9M9PTEaxM7uVORtRFdMNRm1ROq60ZAfSAUFEh+Nd4/fq8JH4OV3ksgxQSfmpGu
         UesAQwqTQxs2g1sV1xyZ8YKvox1K0yE+pfL3ru0h/b6qkUJlsFhSKMsZ0zUccyxHdBc0
         iGC+UlaBjhpsh0M05gqKt/XXUrDxJyUrmvxHiX2VBDVIBgo0Xw9dDtgMeAm1/gsLOVAw
         96BQ==
X-Gm-Message-State: APjAAAV0PdiMblRPTIFR4RM4KUoFaUphdqa6bxVVO8i5N+NDCMRZmM4Z
        YTyUN2AIEes66UEULaV8Rkc=
X-Google-Smtp-Source: APXvYqyD0gk37PBxpZeYy+SsBHOhPvxzoF1iNnmz4Uolt36vrAsN2WrWgoxaLjg7dKr/eB3qFIj57g==
X-Received: by 2002:adf:ea88:: with SMTP id s8mr69095285wrm.68.1563807799269;
        Mon, 22 Jul 2019 08:03:19 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-652-1-281-69.w109-210.abo.wanadoo.fr. [109.210.96.69])
        by smtp.gmail.com with ESMTPSA id v23sm36310460wmj.32.2019.07.22.08.03.18
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 08:03:18 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 3/7] sh: ecovec24: don't set unused fields in platform data
Date:   Mon, 22 Jul 2019 17:02:58 +0200
Message-Id: <20190722150302.29526-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190722150302.29526-1-brgl@bgdev.pl>
References: <20190722150302.29526-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Platform data fields other than fbdev are no longer used by the
backlight driver. Remove them.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/sh/boards/mach-ecovec24/setup.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index 6926bb3865b9..64a5a1662b6d 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -386,9 +386,6 @@ static struct property_entry gpio_backlight_props[] = {
 
 static struct gpio_backlight_platform_data gpio_backlight_data = {
 	.fbdev = &lcdc_device.dev,
-	.gpio = GPIO_PTR1,
-	.def_value = 1,
-	.name = "backlight",
 };
 
 static const struct platform_device_info gpio_backlight_device_info = {
-- 
2.21.0

