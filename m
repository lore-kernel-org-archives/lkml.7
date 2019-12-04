Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BBF0C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 15:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CFE4206DB
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 15:59:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="sp0X1oV1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728547AbfLDP7W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 10:59:22 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55286 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728382AbfLDP7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 10:59:19 -0500
Received: by mail-wm1-f67.google.com with SMTP id b11so239895wmj.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 07:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mslRHHSp/cuNnBW29h3HN5M5/Ygh6sAx6mKJrlS5yNM=;
        b=sp0X1oV1/HpAXBOrL6SJD4ucAhA5yp4me4sYOvskJPG+WgtnSicq1AE7f3IRNCR+nz
         ubKCiY+s0tqSxNQgr6Mrh0OVhZHGO8Po836TRyl/IIoU/AeuRAO3GZc+ygoozhvY27GD
         ni8goZVEGJLE+3itAVgt76mf4jek0kJtsugsSgBJJ/AvlY5pb0WhvwEorznNM8AQ29yd
         6XGuKGzQKKuI2/f1H5aZmT28BB+UDMVzdbqU9DgeidzeWF/xGh41zroMDp+8GRszlS7r
         b7QoL8lwNWAys6rB8vF3nOXMPWLMdJcimM/56HDYoF+AjAdgIQqeQpXPO7GXxjY4sXiE
         t28A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mslRHHSp/cuNnBW29h3HN5M5/Ygh6sAx6mKJrlS5yNM=;
        b=tdQcdkjo67FUQ4TctX9khxaTNGwo4DwfJ5ZS27o/eJB3vbryeSHLa0uIaXh0v/pdjI
         MOTA1KWjaf2FhBVGXo2Ni4WlG7mKrydojvasg1XrPkedHM/WMXysFZ9OlyqDapbjaima
         7D7CVGG5QPrT0pGWJZoDgXIjKredpNl7dtH7qVHESKsALDAKBO/HN9lOV/VazlPB93bz
         Se6TuaZRCBL6OnMvtiGvXngulzu5rklj8XyBq/S8cyet+9SYn3jUhMCuXBfUmw+jXmzx
         UhvJkQmT92eURr+xhrUNm5pDY4Xtm9JuGSUBd48t9r6Aaoa0SPtTfZ/j5jqMJILgiGNZ
         Uf1A==
X-Gm-Message-State: APjAAAV8UjuGu4+yMcCx14WTbDq60MeaYztQSZRePbvO7dPzPGNoZIDG
        1u/SJmqbjV33Rsr064lWa9o6Nw==
X-Google-Smtp-Source: APXvYqxUV3B6D/kjwYQmFXK7hNpMMPQEwApjdkfCje2gxgeJX1iREqHUEw1ZPy6Y5EnCjGzk2JiU7A==
X-Received: by 2002:a7b:c392:: with SMTP id s18mr153127wmj.169.1575475157805;
        Wed, 04 Dec 2019 07:59:17 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id u18sm8640508wrt.26.2019.12.04.07.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 07:59:17 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 01/11] gpiolib: use 'unsigned int' instead of 'unsigned' in gpio_set_config()
Date:   Wed,  4 Dec 2019 16:59:04 +0100
Message-Id: <20191204155912.17590-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191204155912.17590-1-brgl@bgdev.pl>
References: <20191204155912.17590-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Checkpatch complains about using 'unsigned' instead of 'unsigned int'.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/gpio/gpiolib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 21b02a0064f8..a31797fe78fa 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -3042,7 +3042,7 @@ EXPORT_SYMBOL_GPL(gpiochip_free_own_desc);
  * rely on gpio_request() having been called beforehand.
  */
 
-static int gpio_set_config(struct gpio_chip *gc, unsigned offset,
+static int gpio_set_config(struct gpio_chip *gc, unsigned int offset,
 			   enum pin_config_param mode)
 {
 	unsigned long config;
-- 
2.23.0

