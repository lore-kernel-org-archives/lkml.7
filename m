Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E12D2C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 17:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7D1224679
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 17:15:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="ZJkxoUwb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfLSRPk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 12:15:40 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36037 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726855AbfLSRPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 12:15:38 -0500
Received: by mail-wm1-f68.google.com with SMTP id p17so6463160wma.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 09:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3OFnQ2ohkFOq1yFTbDsXqXVWgfUM3/3VsiEYW/xfV9E=;
        b=ZJkxoUwb4DVcfMAileD3Rrt4x+EKOgSLdMnpFC1TEp6dU/JTboLmO7y4DuO85qIzmi
         VEFQbLqdzuO7KfCN4KG1ONhGaXoEwmWmUNfy1bSBFJaAZcHCIAOzx1Vzdk7/W5CquaXS
         Zq/6bIUxmH5KsvpZdoxvMiO8zHrcP+DRQDGQFYUXnIfsSKgjeJskckgeEdKakLql5e0v
         nU93JZ3aaSBt7b3PF0rpIQYEoy7aGtfoF3jx4r1bVrrKi5QS0qZr+NHQC5fu7dZOQpj6
         YLr9juvDhwUb+Ul0uUAH8uzK1U2LnShS7wtPI/h8P0IdEsncXnOLN7VRKJcUd1o/M9Sw
         VWLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3OFnQ2ohkFOq1yFTbDsXqXVWgfUM3/3VsiEYW/xfV9E=;
        b=CqR9aVkAzX8WhRUrGF0CFlvHB2OqtZQeNHlFbt757/wC3V35zLrxACEH7JMwGM2Ap2
         lli0f63hedSu4FOUw+kf6lxetDAZ5paGH3Be+ZWCrN5DTPLbLFFUFXxnyARSa0Zr12Ty
         HyIRIpA78wi9LDJbZ78L36rKuHsMJ6W1/qBoDlqEzG4zTqcJU0ZOzTp5TqtGCX08MdPo
         qo8FS/nTvV+VcwOXXSyXLp02qPnqjPw/yovqfTpiEgyvmc9c1F0glzZNguJ0vPxvOZ20
         /R/DdKSafVslnKe/JfWKama4+/hRAq/AdARUopu7WNoWdjLwPXJat65fJzxS2Fj9KvrB
         uL4A==
X-Gm-Message-State: APjAAAVDLeOTXEXTZnNxphZSlzt+l12aX0HB9GxadWn/antuQdybAt/V
        ru7NGyixzcHi0EVItrJPluL8bw==
X-Google-Smtp-Source: APXvYqx9BtOSw9b/9nstUr0iQlAvNQJd9cEDr2v+n60w9iwCiyxGVsOgz2izpl/1jAsmTzYtP3PDXA==
X-Received: by 2002:a7b:c956:: with SMTP id i22mr11184767wml.67.1576775736179;
        Thu, 19 Dec 2019 09:15:36 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id q6sm7401428wrx.72.2019.12.19.09.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 09:15:35 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v3 01/13] gpiolib: use 'unsigned int' instead of 'unsigned' in gpio_set_config()
Date:   Thu, 19 Dec 2019 18:15:16 +0100
Message-Id: <20191219171528.6348-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191219171528.6348-1-brgl@bgdev.pl>
References: <20191219171528.6348-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Checkpatch complains about using 'unsigned' instead of 'unsigned int'.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
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

