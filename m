Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 206C0C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 09:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9D9C21479
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 09:03:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="UFZ36oLK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbfEUJDO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 05:03:14 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53200 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbfEUJDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 05:03:12 -0400
Received: by mail-wm1-f65.google.com with SMTP id y3so2093292wmm.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 02:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gYAhmVJgkHA+N2QnfUw5rqlqXxgQ3j6KVbsfq1tlZMM=;
        b=UFZ36oLKvX+AyXAL5nBQnC1qDCWWRrbfH0PozmB8HyvyoDlKvokj7BmHtKfsRST0eM
         eybFag24qHXOs0w22rgVTfxJ4hpMkJN0U/gNSlD/03mQA7xEqfhgnfJMUQByxWq6q4K1
         ketUdVCeKml9tZk15s7E51XrcBBA56Iezl5+6KY7rNL+J7StZgjFMHtLove61AyuUhST
         Gt1tROiyikHmf7H4OqCWa6iQ0JC/XEhMgSGrXLg6poSr2n2SUlILi5JfXPuUKp21zlnk
         s5WrepjFiqFxyyG4Sta1RKTDrS6hLSVgH5tiH9nuqcswNcg1ObyqHamwSu4a1BYf6KWS
         9grA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gYAhmVJgkHA+N2QnfUw5rqlqXxgQ3j6KVbsfq1tlZMM=;
        b=jak0X1wCJ813R/4aneSaNNAC3fPCU73AX/wmECzMerM9a1mJRg04j05FzBaO+001og
         SPSZPE8La/hSrbxFnV/xX+01OZGJi3FA/s15KM6IpOZ02vhIPjwblTeTmapFwjPbUsfY
         kRNU3ZQKeZ8/xw1MIPK7DRey2Rgffm2xzN/OrJ1evuZ4YqqtRsjP5lbPRoM3pU3biqB4
         P3EskgbGhMpsdT7ZBpM9Wo1cP+g0DW2Q1fPMpCfeGMdcuAhyLxWA5rHiJW/AFmkhvTaV
         FW50/vBWJR/yWWEa2cTZuc+Kjj9eC1tee2PCxOQ9wC3jPUsIqv9mr0tkrseSaaeHTTwB
         IW7A==
X-Gm-Message-State: APjAAAURoJ5ZjCuJLf7VdOKUttZrKga5Sd553i+N1RBo7dkYtMUyt2Xv
        4JJ5bYUXVZeyUQbo5kvudq5zwQ==
X-Google-Smtp-Source: APXvYqzQFUH3mqLm/FE4fhZMNjE0sMSpeNtW+zoz6zvRZGpviSrxRVUCwwBB+AeiucqksJdT2sXCLQ==
X-Received: by 2002:a1c:f415:: with SMTP id z21mr2480549wma.100.1558429390261;
        Tue, 21 May 2019 02:03:10 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id j28sm35898692wrd.64.2019.05.21.02.03.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2019 02:03:09 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 2/2] gpio: max732x: use devm_gpiochip_add_data()
Date:   Tue, 21 May 2019 11:03:06 +0200
Message-Id: <20190521090306.28113-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190521090306.28113-1-brgl@bgdev.pl>
References: <20190521090306.28113-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We can simplify the code a bit with a resource managed variant of
gpiochip_add_data().

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/gpio/gpio-max732x.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpio/gpio-max732x.c b/drivers/gpio/gpio-max732x.c
index 7fd1bdfe00e5..42c9b6ce4227 100644
--- a/drivers/gpio/gpio-max732x.c
+++ b/drivers/gpio/gpio-max732x.c
@@ -698,15 +698,13 @@ static int max732x_probe(struct i2c_client *client,
 			return ret;
 	}
 
-	ret = gpiochip_add_data(&chip->gpio_chip, chip);
+	ret = devm_gpiochip_add_data(&client->dev, &chip->gpio_chip, chip);
 	if (ret)
 		return ret;
 
 	ret = max732x_irq_setup(chip, id);
-	if (ret) {
-		gpiochip_remove(&chip->gpio_chip);
+	if (ret)
 		return ret;
-	}
 
 	if (pdata && pdata->setup) {
 		ret = pdata->setup(client, chip->gpio_chip.base,
@@ -736,8 +734,6 @@ static int max732x_remove(struct i2c_client *client)
 		}
 	}
 
-	gpiochip_remove(&chip->gpio_chip);
-
 	return 0;
 }
 
-- 
2.21.0

