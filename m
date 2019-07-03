Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DBF8C5B578
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 08:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11B4B218A0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 08:47:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="ya7HF0SC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbfGCIrn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 04:47:43 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51447 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbfGCIrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 04:47:43 -0400
Received: by mail-wm1-f65.google.com with SMTP id 207so1312879wma.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 01:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vToO8p1g9fcXX+PhVJh6ccrR2JJj+qaLGHac875fuoU=;
        b=ya7HF0SCJS7/lw63dHyStkFXeBgGqRCZr5oVuE2MJ4fjoX2KS14jmsuTRZSYk/27Wp
         +ugvp7jtNkcycrDNDT8HnmTYFSxjRbuUl/DcpEeD9J4Q9DW9npCkTvnUmCkc0Q5vIhfY
         ZMW7DYk5A/Oog+aqQRD6fhuV+8U7aud+caXVLw91OLAXH5qolczQ2sLITrEeg/7RewS8
         K5fuYkc/xfyFk2N5drRiUeNA0+Cdp/AJvtE5hSbYObZz4PpS0GItlYWt5/YZvDJ9mkg1
         STAbw69epP6gZPXrZwLKsfQJE8LruNlAEf0RA94wkzkbNBII3XP+ukymAYW5B7eKCSwd
         R1TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vToO8p1g9fcXX+PhVJh6ccrR2JJj+qaLGHac875fuoU=;
        b=L6xaR6dFIm2wjiDjExzF2/d28Pa/4Vw3omIVUEoCFJTJ1J9GepyPj6FKfB7CDl+x54
         88JUHVuJ5xa811EWB08hFzWeKIwi2ffdUVaI8iBg+po7nu/aMerhLy8V45KCJ9aioj8+
         RnZIYS0NkhI0NC/QEm8cCSk/QT3I+q1rJNmE/AX85In3HQ2fDnLLBGPEJpdxeMHXQNGN
         lw0ZzFhyXnqbCya42osSyaUflja5iDL40W7yy//IU8mJaaq8c2RjvGoNBiVBbqbdEpcg
         j61chUn4loghWKzopa5qMYkA0rmP3o84zB7ey65Kd439L31NHnnteLkX+uRj8P8QMpCL
         bcZw==
X-Gm-Message-State: APjAAAUTAWC22frcmmY+at9+NjUA3OmWgE/aCnC5EvS1PnNcM21lQxbP
        8QmH8g5p10wqGXvShrjxUJE=
X-Google-Smtp-Source: APXvYqxWyocLK7e4QV2o5aZyfxZMd2py5upZayOd6/FoAhxElUp8QUkZ4T5jht5X+E1+cBnlQ1+X/Q==
X-Received: by 2002:a7b:c4c1:: with SMTP id g1mr1534498wmk.14.1562143661194;
        Wed, 03 Jul 2019 01:47:41 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id b2sm1797968wrp.72.2019.07.03.01.47.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 01:47:40 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>
Cc:     linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH] leds: max77650: add MODULE_ALIAS()
Date:   Wed,  3 Jul 2019 10:47:38 +0200
Message-Id: <20190703084738.9501-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Define a MODULE_ALIAS() in the LED sub-driver for max77650 so that
the appropriate module gets loaded together with the core mfd driver.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/leds/leds-max77650.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/leds/leds-max77650.c b/drivers/leds/leds-max77650.c
index 6b74ce9cac12..70166cd3816c 100644
--- a/drivers/leds/leds-max77650.c
+++ b/drivers/leds/leds-max77650.c
@@ -145,3 +145,4 @@ module_platform_driver(max77650_led_driver);
 MODULE_DESCRIPTION("MAXIM 77650/77651 LED driver");
 MODULE_AUTHOR("Bartosz Golaszewski <bgolaszewski@baylibre.com>");
 MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:max77650-led");
-- 
2.21.0

