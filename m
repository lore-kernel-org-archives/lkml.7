Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E82C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 11:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B7772082F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 11:00:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="X5n4D/bJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbfC1LAs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 07:00:48 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44166 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbfC1LAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 07:00:47 -0400
Received: by mail-wr1-f66.google.com with SMTP id y7so18157363wrn.11
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 04:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7PEBtoNKLgx0deDJdkAZ2nPjH5Bf62HdoDJrD4J/cks=;
        b=X5n4D/bJXqwEYAzK15BfhFXIK1pQWiKFB8FIDG6sjGcgiC/3j56V2ouIef47j9nhRT
         G1souaJJhvs4+SbY/4uJcRotu4/pVdX7GrEBiRjuLrsNSxW+uFu3c8q8tH6C2BjkYiBF
         Ri69haTwlrYw3jztaCHvwjJb0MZtRI3r6key1lmhQMFcI2cDS/7WoQT9zsTA0PNGghIy
         X7V81Dn0j155gXs7k8L7fryxXsZH2DCSGKzYDt5XckHstwiK3UuMcwvDTzteO6I/5Idu
         loJpsyXKIdJOz3PP45yFFRE2DPORPXZsX0Y5vezkMIwGKstA8XErmdGflDslNNxMS/iD
         qzUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7PEBtoNKLgx0deDJdkAZ2nPjH5Bf62HdoDJrD4J/cks=;
        b=tQW2kTfjF6IV6KGiHa/rFN2/TKxSzGnATVZp2z/ovQugCNjI6mEo7pnF+Q+VBw5UpA
         tlTeeSEm6gU0SMKe3xa5+Lq4RKeR4wKjbU9p8hLuIm8CEgUEBcKRUoSTmJfy4/4whxmr
         Kqj7fdCl1x69mOfQZiTeZXBOqhR6YDq2uRE5KIDVupN6B2zwyqT0QhqIPkzq7sbAAtWO
         SCSfwnMz4heiP7bH44qIB6Op95n4+zg3536TepHt6rQt4IjPFbetQTwfllXF2ti6s2DP
         VacKmL+9154AqG+KzdWcPBgEyz4gefGRckX3bKry17YDsK0m96/hIJszMeVXAJLHfhEq
         QGgQ==
X-Gm-Message-State: APjAAAV8gQcc+uPSYKZRmxmWfF9/bhuJVX3TXJU9+7Nfu+uBxPY6mQfJ
        bRJ72skWP3/iYVV9P7n3vkXSpQ==
X-Google-Smtp-Source: APXvYqx7zGorUgWGwTNcv0L4mNGkeNbt9g86FvdKEE9f37DBaZrI3puNvM0LunUMHSB1+IW4nRhgFw==
X-Received: by 2002:adf:efc1:: with SMTP id i1mr1798112wrp.199.1553770846015;
        Thu, 28 Mar 2019 04:00:46 -0700 (PDT)
Received: from localhost.localdomain (aputeaux-684-1-20-74.w90-86.abo.wanadoo.fr. [90.86.223.74])
        by smtp.gmail.com with ESMTPSA id d14sm24273035wro.79.2019.03.28.04.00.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 04:00:45 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH] gpio: mockup: use simple_read_from_buffer() in debugfs read callback
Date:   Thu, 28 Mar 2019 12:00:43 +0100
Message-Id: <20190328110043.13391-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Calling read() for a single byte read will return 2 currently. Use
simple_read_from_buffer() which correctly handles all sizes.

Fixes: 2a9e27408e12 ("gpio: mockup: rework debugfs interface")
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/gpio/gpio-mockup.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/gpio/gpio-mockup.c b/drivers/gpio/gpio-mockup.c
index 74ba8b1d71d8..859585dce5c9 100644
--- a/drivers/gpio/gpio-mockup.c
+++ b/drivers/gpio/gpio-mockup.c
@@ -219,12 +219,7 @@ static ssize_t gpio_mockup_debugfs_read(struct file *file,
 	val = gpio_mockup_get(gc, priv->offset);
 	cnt = snprintf(buf, sizeof(buf), "%d\n", val);
 
-	rv = copy_to_user(usr_buf, buf, cnt);
-	if (rv)
-		return rv;
-
-	*ppos += cnt;
-	return cnt;
+	return simple_read_from_buffer(usr_buf, size, ppos, buf, cnt);
 }
 
 static ssize_t gpio_mockup_debugfs_write(struct file *file,
-- 
2.21.0

