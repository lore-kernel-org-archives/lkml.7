Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B73C2D0CF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 12:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59C7B20706
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 12:08:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="A0jHUOV3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbfLXMIG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 07:08:06 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33333 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbfLXMHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 07:07:25 -0500
Received: by mail-wm1-f66.google.com with SMTP id d139so1867347wmd.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Dec 2019 04:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RF8DMEiIOiCZXGcqB/d87PY1debd4x/7fTb1Nr5izog=;
        b=A0jHUOV3ih62WkyW72xaeNmDZY6Hv/Cu2TzvtJQFsOJP6ilkXgpknoYH46E2oxfMyb
         X/UUpj2G/WvkNHvpNgW0e27hHJQAwsuibDZhObvXCFnbpuSLGFzkqXB0JDz5oevoNqtm
         q8XDHQpO6MAdYyPglTI7vEI4jHL2E7Q7E1srfq4Skwtq3m7nQ1+T3mcgjSczsZDQznK7
         eoQJjzrGCMDNygRWhRtb7NZHW6fL3p6+9llUrLOo6rI2BY1KKsdVdgq4lfqXD8n1YcuC
         ZmnuX+qVRpbPn7rd8GEdZoJspCJrPCZEPy7Mli7xr8W4iCwvzqbEGAeF7qllkgNoejn0
         blqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RF8DMEiIOiCZXGcqB/d87PY1debd4x/7fTb1Nr5izog=;
        b=BSBD7Md70HSlgPWpFxuYYo5HbMXr+LXOtKkhRzedbPoSHIXtpU1fMoHvjYAIvwNhMb
         7Yz33bmwTrO+H+adcy3vsT7I0NMrdkUsvNnggnc2jsi9l2C58B9xI3qadWSIQKHu6WKA
         7ueWwItqI7nGbB46Q+tr9ghlY/+r6/yhSkfBUR9gvtvQNhJQNJgM7uadOyogl8yGxAH0
         R05cP8zL3NhwJ7uKNO8aGugC4pPXxJk1hHVQ6xbcJv1spHjyc+iQp9GHtyW9x4slhQZ+
         i3slQsa6L0jzxLUV/insmJZPqgNLdd9MAdxfr/GybwYX9gRIRmqyGLcKyY4DBJgHj1U5
         Fo1w==
X-Gm-Message-State: APjAAAWbyyjCY3QKbctMJch8K54fqnXgZFtlxkydtzCu9CPSFx9tpKSd
        HYYD0+qj8WJA6TN1a/MfC3nxxw==
X-Google-Smtp-Source: APXvYqzc7xw2byEmSEkkLzaL+93WllV3MBCJRo9VYYM0apZV2n+xtKSADt4xwNIA+MCgFCnnRpAplg==
X-Received: by 2002:a1c:b456:: with SMTP id d83mr3883612wmf.172.1577189242517;
        Tue, 24 Dec 2019 04:07:22 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id s10sm23829210wrw.12.2019.12.24.04.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2019 04:07:22 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v4 05/13] gpiolib: use gpiochip_get_desc() in lineevent_create()
Date:   Tue, 24 Dec 2019 13:07:01 +0100
Message-Id: <20191224120709.18247-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191224120709.18247-1-brgl@bgdev.pl>
References: <20191224120709.18247-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Unduplicate the ngpio check by simply calling gpiochip_get_desc() and
checking its return value.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/gpio/gpiolib.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index fcec8b090677..007f16fdf782 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1009,8 +1009,9 @@ static int lineevent_create(struct gpio_device *gdev, void __user *ip)
 	lflags = eventreq.handleflags;
 	eflags = eventreq.eventflags;
 
-	if (offset >= gdev->ngpio)
-		return -EINVAL;
+	desc = gpiochip_get_desc(gdev->chip, offset);
+	if (IS_ERR(desc))
+		return PTR_ERR(desc);
 
 	/* Return an error if a unknown flag is set */
 	if ((lflags & ~GPIOHANDLE_REQUEST_VALID_FLAGS) ||
@@ -1048,7 +1049,6 @@ static int lineevent_create(struct gpio_device *gdev, void __user *ip)
 		}
 	}
 
-	desc = &gdev->descs[offset];
 	ret = gpiod_request(desc, le->label);
 	if (ret)
 		goto out_free_label;
-- 
2.23.0

