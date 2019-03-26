Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EE1CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 17:32:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2F8D206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 17:32:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="avBvz9GQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732382AbfCZRct (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 13:32:49 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35581 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732293AbfCZRci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 13:32:38 -0400
Received: by mail-wr1-f68.google.com with SMTP id w1so15422296wrp.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 10:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y2vBgqG62dEqhYLrbn7654YScA/5gj4YzakQT4vpJ6E=;
        b=avBvz9GQGlWx5m3xjjCIcq4bAD9tFJ+aUBE1HJq0IKKwpoy1d4WLMOJkd7Ql6YuZ+2
         RPlawgcLtzYV8M1+kzFKGCDps1lay07asPLAk+5T25D6+Ox8Z1kOHa/yspYK7dElsY++
         YPxfdG+q15fju9/vXBhYllHQG2W+7VWCGe21HSiMWmsdXuqXTQtiYX0GNgEbAJ+Yk5O0
         jZNU4g82STbtX0LVMRqnBoHKk6yxP38ya8bsdsUHSkGfGBc/ov/eeg1wiv+dUvIGc6Rz
         uwEJR4UBnAliH7YLjxNRDpx8gtQQVx7NL6dYmjw0o6DfqTKj1vIvdNdSN60IsKe+poad
         HVyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y2vBgqG62dEqhYLrbn7654YScA/5gj4YzakQT4vpJ6E=;
        b=IhLNhVKaMnoZKFjvENn853BZhkO2lgcEQ4/a9MvF1f+IJYs50VmIMWo/iRFGwuCxMt
         ACBAjlBkzFmK+pKSckyi047/1zKX6lGGkWV3pUiQ+xZ6sSkeNhAENnCzd23+6SDNQrW1
         zmPfX86BvaX+1mk1D0E3pV25SClq1nzr2gncX5baReeul9T9mG37tNFo8eWR6TIPPbo8
         5PFopngv9W4tV2pd91S153yom7AhzGi/j8RJD09Y/hAIYgH9+30hm/C+TIzde6ntjQZG
         mOV1sPr6EZwWiBHVsMqXj+3pRU0VMUo/BECwHV65dL4YDunDgWRgWviU643Vgk+QJA3M
         BQxQ==
X-Gm-Message-State: APjAAAVwfxP32XvBf6+B0HJ8jhOORWb9yPvU/yfwLSRCMaohHspwXqwu
        sg51LRNnnj++J35awXOCGyZjTA==
X-Google-Smtp-Source: APXvYqwk46JpweNo//OkbvVrVIet6hbRlrW3TRR48Xy+UCGwOFvkBBv8GhB1uPghSiZXsI1RqyAJfg==
X-Received: by 2002:adf:dbce:: with SMTP id e14mr15364086wrj.249.1553621556951;
        Tue, 26 Mar 2019 10:32:36 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id 4sm2534541wmg.12.2019.03.26.10.32.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 10:32:36 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-pm@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v7 11/11] MAINTAINERS: add an entry for max77650 mfd driver
Date:   Tue, 26 Mar 2019 18:32:08 +0100
Message-Id: <20190326173208.30614-12-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190326173208.30614-1-brgl@bgdev.pl>
References: <20190326173208.30614-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

I plan on extending this set of drivers so add myself as maintainer.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 MAINTAINERS | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3e5a5d263f29..b32fe859c341 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9407,6 +9407,20 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/sound/max9860.txt
 F:	sound/soc/codecs/max9860.*
 
+MAXIM MAX77650 PMIC MFD DRIVER
+M:	Bartosz Golaszewski <bgolaszewski@baylibre.com>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/*/*max77650.txt
+F:	Documentation/devicetree/bindings/*/max77650*.txt
+F:	include/linux/mfd/max77650.h
+F:	drivers/mfd/max77650.c
+F:	drivers/regulator/max77650-regulator.c
+F:	drivers/power/supply/max77650-charger.c
+F:	drivers/input/misc/max77650-onkey.c
+F:	drivers/leds/leds-max77650.c
+F:	drivers/gpio/gpio-max77650.c
+
 MAXIM MAX77802 PMIC REGULATOR DEVICE DRIVER
 M:	Javier Martinez Canillas <javier@dowhile0.org>
 L:	linux-kernel@vger.kernel.org
-- 
2.20.1

