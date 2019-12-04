Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C768C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 15:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10005206DB
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 15:59:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="T6VXt8MI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728602AbfLDP7a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 10:59:30 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53829 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728539AbfLDP70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 10:59:26 -0500
Received: by mail-wm1-f66.google.com with SMTP id u18so247520wmc.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 07:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PwQtKdAUQY+SBl5OsHs80mv2U9tLV35lkOjHDH8uz/U=;
        b=T6VXt8MIgYcU7MsY3TdXMqG4/4HRWYESABPYgT0VZoaE8H5/6QTNNqzLD5Fongh5Tb
         b5c6LbaV+5bgyTMxcNS6MkTu6OfOzoVpNioIMUXWSWd90IWYsnDEpqZfY/23mJoRMli7
         JIk+qU5sKkCujWkOd5jh43Xg3azL//AlEYWP7TzpLe7pvRmELIiukwSk/bxGz4HuAdfe
         6dkSfCEPXYp5Z8FfDp+FUAu4y8/065sYSdQbVu2Q0+Rk8Xdxi6rvgiv9el7E0+qH+Y8I
         lkBW1FXom8XEsWCOoity9VRoOjQxd0/TZ4qcBcuS2TIzgZIzvCfP0o4iZ1ourYKA0Ux0
         IvMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PwQtKdAUQY+SBl5OsHs80mv2U9tLV35lkOjHDH8uz/U=;
        b=qzxal3fvRU+K1Y7ER0v+tZbCRlAn9tDOHGn7Sdc/C8OMYC8BXONljqAbBV4EjY0dJC
         gw4mTlK/bnryzqmj0Mp8vkczGvwWJuiTXpgXsLB5xN7MkuW6qVHxilnTyRTM3nYJo6rI
         D6tw4SXLotBDWun4kVRM0SD4PRXc1eJOeZM/gNO8QY5xfwRAzBm6bhXYLxKbx/3VuhFa
         oInq42f9WQRu1d2uE/q9nkT+Zyms9ICBR3JX2aucyeKtPhsHHRyp4LfyGa9NYHJ53nAR
         DrNizyMhmyzHRgR5UezSry1OVoqeHNRCaex768Gfpkqo7NTpjXp+X/MPCH4CdENDJz8s
         SbGA==
X-Gm-Message-State: APjAAAU3Hm8WBwFsVtbrIUn22f4KmVRRYRNiQGp6QZ/LgLBeXSokl4j6
        95F5hGYN/GdswD4d9AQOiUXgDw==
X-Google-Smtp-Source: APXvYqw3j9t+sv27rxv6BsQ+49qDiWvcgmeoGIG7o/TNn3GxBxvIPxAHFn+65IIuWJboL7cqmVfOJw==
X-Received: by 2002:a1c:8055:: with SMTP id b82mr159701wmd.127.1575475164550;
        Wed, 04 Dec 2019 07:59:24 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id u18sm8640508wrt.26.2019.12.04.07.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 07:59:23 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 05/11] gpiolib: use gpiochip_get_desc() in lineevent_create()
Date:   Wed,  4 Dec 2019 16:59:08 +0100
Message-Id: <20191204155912.17590-6-brgl@bgdev.pl>
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

Unduplicate the ngpio check by simply calling gpiochip_get_desc() and
checking its return value.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/gpio/gpiolib.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 6ef55cc1188b..17796437d7be 100644
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

