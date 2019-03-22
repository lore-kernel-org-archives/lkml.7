Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87801C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 17:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57111218A1
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 17:30:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="LoexckY1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728311AbfCVRa6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 13:30:58 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34239 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728214AbfCVRa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 13:30:58 -0400
Received: by mail-wr1-f67.google.com with SMTP id p10so3260108wrq.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 10:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n4+h1AwiYWbcvCo2SVfEpk4VI/pUxMw43QNPM3T3NW0=;
        b=LoexckY1HPl6LUnZOzO7JF9845wgvNJsudAL0VUzOp2BQpHgi3RUA3UrI5RyQ0PCI5
         pOBbLsyCX0RWHbXqshAbxggD4RRnf5D8LOeguN9cBEkBhwi1pAvAFslfk7OWzzSvfvzw
         348Q7XsI1YSJi6bTMBt/XucjxoEqtjjOqpmpQJNUfTt1hBapSfhz/PlpmrgcUiWSvNxd
         bnmKGJpJaJ7DHEpxgiIG2T9I6j4wkp4LlTcjPzhDbgAOsXBoeEROvaTKVytpcAvAwONR
         /SN2VY6cqmaiQsoDmZ2J8HC+Be/uDtuJvFK6DNjVMYXJOwHdecALA3dAYN5FdPkbyOEz
         gmNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n4+h1AwiYWbcvCo2SVfEpk4VI/pUxMw43QNPM3T3NW0=;
        b=AvQmddN0WhxmAzqJyWbzDhyQpF/ME7FQy5D1bezlu/BeLKECF/Dbb6aQrW5TrY/Yvr
         PgZi5TvHsWN/RTOWPVxpJeUhzjsGZGCcV4ES9dwQaGsWqL3vHcuDFiNaKeBln+828eCS
         2oqo/7OEjseEewDGSDwvDwqCbjTmTQ4rVN63m9FsTDV7KzTjsCnGNunIYlpCU3aoMuzY
         c2rtyzvh06/eOUrtttGei5/MYDckQ2GiUkr8ZVGWBH71EN5LakJ+UQQfP5PKqG1LQWkt
         eymBYcn4QBT4gKb8pTQKTaNmCmIhukzNVOh8iNAWuaBHRjV7luG4zSaKHfBOiHprHwbT
         l9BA==
X-Gm-Message-State: APjAAAVNiU2gLbpRqfW2Kdb54+iWIA7PQyV+034GeJxrtrycdpXwohpJ
        RgXtrd0DkulHiPz7JtYk8YNANA==
X-Google-Smtp-Source: APXvYqxtmP0JeLppB7oOEtW1q/AVNVbVYKTRYzHrmGsmpeZn/P8Sj8sCC5Bjv7PF3chiASN2azAz/w==
X-Received: by 2002:adf:b741:: with SMTP id n1mr7046736wre.287.1553275856356;
        Fri, 22 Mar 2019 10:30:56 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id z14sm11941881wrv.78.2019.03.22.10.30.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 10:30:55 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH] gpio: mockup: fix debugfs read
Date:   Fri, 22 Mar 2019 18:30:52 +0100
Message-Id: <20190322173052.23763-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The debugfs read callback must advance ppos or users using read() on
the file descriptor will never get the EOL. This wasn't spotted before
as I was using busybox cat for testing which uses sendfile() internally
and only noticed it now when switched to cat from coreutils.

Fixes: 2a9e27408e12 ("gpio: mockup: rework debugfs interface")
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/gpio/gpio-mockup.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-mockup.c b/drivers/gpio/gpio-mockup.c
index 154d959e8993..74ba8b1d71d8 100644
--- a/drivers/gpio/gpio-mockup.c
+++ b/drivers/gpio/gpio-mockup.c
@@ -204,8 +204,9 @@ static ssize_t gpio_mockup_debugfs_read(struct file *file,
 	struct gpio_mockup_chip *chip;
 	struct seq_file *sfile;
 	struct gpio_chip *gc;
+	int val, rv, cnt;
 	char buf[3];
-	int val, rv;
+
 
 	if (*ppos != 0)
 		return 0;
@@ -216,13 +217,14 @@ static ssize_t gpio_mockup_debugfs_read(struct file *file,
 	gc = &chip->gc;
 
 	val = gpio_mockup_get(gc, priv->offset);
-	snprintf(buf, sizeof(buf), "%d\n", val);
+	cnt = snprintf(buf, sizeof(buf), "%d\n", val);
 
-	rv = copy_to_user(usr_buf, buf, sizeof(buf));
+	rv = copy_to_user(usr_buf, buf, cnt);
 	if (rv)
 		return rv;
 
-	return sizeof(buf) - 1;
+	*ppos += cnt;
+	return cnt;
 }
 
 static ssize_t gpio_mockup_debugfs_write(struct file *file,
-- 
2.20.1

