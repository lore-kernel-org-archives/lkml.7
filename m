Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB2C9C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 16:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90652206DB
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 16:01:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="kDu4Z9b9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728865AbfLDQBx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 11:01:53 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33304 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728567AbfLDP71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 10:59:27 -0500
Received: by mail-wr1-f66.google.com with SMTP id b6so9304881wrq.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 07:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mx3ZyJkzQPPgrO9SEUEcMUEUo3OWsFykUUjXQ0ufMTY=;
        b=kDu4Z9b9TDdsQYYk9Aqa2AQIyrhUX8gwTrtcLtcSwl0pJqKg20tfOsdEPijAgMn5+z
         nY/4Nfgt91kwHD1aGecwkRT5WdBHqkxj+s1RvC+ZtbtSLKkGuV9HjV9lG7Q1YrDhpI9o
         oVRiSevz9IxfxKgKJDlzybR18/LNWQKvUNUdGFjJwEpiu9AlXo1nOz+aGNfIbXzFacCg
         DKjwnNc4qvfGZuXuJl6CEdV3m9VvX4wRUy+2X9p+bOECsdUDpnHeViZWGGSMPzoGC7N3
         wPvEeEvy/FYGjjc9b8o/Mf7vAZzBUEbMx8P/7b8fF2jwRHHIDHeGVfsvIUqeC4nQWOw2
         pYwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mx3ZyJkzQPPgrO9SEUEcMUEUo3OWsFykUUjXQ0ufMTY=;
        b=IrqcQ4gVyR1V7ncy7uKii6eadYLF4yedbfrNVjPON2wMU3hG5zFUdyysrLKQs0LZYE
         4/ntywbIIENKjcSr+MotaYo/R0tuBz/AGmgHZ1RFFmKbzrBkRk7GCd5yyaCd7dvVKvjm
         iCY7RTCAbMKERzOz7+/yL0H+6sJBdgTEpH41GOQO5J9hQYmrEVqMTd2xbz+S65b5PQBu
         kxtw+tMR2jv3FVZxX/9Ny5sKWI7WdRDa1lM4jic1R/5e2Fo3VkfNYY2eXxwlm90q06ZG
         TOkojB9POYwde5jFeryj96eEmtWWeck9PIcVmgdr06IkzHkqnL9jMY8l4FCeUYi2OpKi
         a1Pg==
X-Gm-Message-State: APjAAAXyXdpkgfWvdnKLzXN0aLbcSaQ6WoXxTCj/DMgfTiZY2ePV53BQ
        Cm99w3mfTmasXU3ivjxsXKnHow==
X-Google-Smtp-Source: APXvYqzBZmJRWvmbxNfjw0aGh+a1bvW1bU9MEAlgciuDoB8pzU/15i1PHt+f+DRqxgnI4+LF3onsxg==
X-Received: by 2002:a5d:5708:: with SMTP id a8mr5111893wrv.79.1575475165950;
        Wed, 04 Dec 2019 07:59:25 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id u18sm8640508wrt.26.2019.12.04.07.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 07:59:25 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 06/11] gpiolib: use gpiochip_get_desc() in gpio_ioctl()
Date:   Wed,  4 Dec 2019 16:59:09 +0100
Message-Id: <20191204155912.17590-7-brgl@bgdev.pl>
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

Unduplicate the offset check by simply calling gpiochip_get_desc() and
checking its return value.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/gpio/gpiolib.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 17796437d7be..b7043946c029 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1175,10 +1175,11 @@ static long gpio_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 
 		if (copy_from_user(&lineinfo, ip, sizeof(lineinfo)))
 			return -EFAULT;
-		if (lineinfo.line_offset >= gdev->ngpio)
-			return -EINVAL;
 
-		desc = &gdev->descs[lineinfo.line_offset];
+		desc = gpiochip_get_desc(chip, lineinfo.line_offset);
+		if (IS_ERR(desc))
+			return PTR_ERR(desc);
+
 		if (desc->name) {
 			strncpy(lineinfo.name, desc->name,
 				sizeof(lineinfo.name));
-- 
2.23.0

