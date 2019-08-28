Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D700DC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 08:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE3ED214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 08:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OFQAKSEK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbfH1IeU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 04:34:20 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53461 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbfH1IeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 04:34:17 -0400
Received: by mail-wm1-f68.google.com with SMTP id 10so1792441wmp.3;
        Wed, 28 Aug 2019 01:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=smxwejZdMZZUqvmIMjajMjCkxwj4EEjkJYnSTausqgs=;
        b=OFQAKSEK4jCaLeKz2+A+WaOVuJXZRU4LiD+DNMU9wktMO/RQ8YhQUgT92iBjNEbOlj
         jvyN+jyYdxzUFOlEV8lpiP47ELYLUQ8LTnS7C1Tvze0OLzsFQsruKHd6NS5ZEvjh7UuL
         sU1v2/ZRb8OhgRJMVcedfO8hl6vMj37tzKx4C0SyBzEPppHpC8hSHvOzXuzgLRzPqjdq
         2zb73wn6j5qZo0cH10zr4EWyxjeghH2MOh/9oei0Y6nx3JiR0xySS6wjpYWhPmN7/eIy
         xi/fmxJ30F4Cz5ZINZzaBLlUzEPi8Y9s/gLWM0ZrFGZlaZBKb3toTi3lpYjX8ERPYekO
         RfNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=smxwejZdMZZUqvmIMjajMjCkxwj4EEjkJYnSTausqgs=;
        b=LAzVN3e4rk0rAYmIARySmULo/91J+5MUfK1kS+wy9IIKOZ1ioC6dh6v2x5E/qnkiBT
         bcBJ4lDnsG1UmQBWYULRSEWBN2ydwGbUm89EnR6XwMCA2A8z/hR06Pi7PAefIHFHthzl
         JtR4pbPHeW2zEH+hW85DQqZoYGtHGRva7bSz6F41ICY7nxwi7vI2ETyvz9nzH4nd8Usb
         OwjO0Xf8gY8/KdJeA3EmUOVuOgWe8UenfaWD99CC2pdwy5XPIv3bP1JMRhVmyItem3wF
         Hc4lcYxx2zZsVFv7wthrySjXYrduTRS4eE7sUMGtT4U8ioUWhqC6AFZ8ZYeTkbbsi4cr
         Na8Q==
X-Gm-Message-State: APjAAAXNXQhbFUJLAeOnag7MjU5pxALwy3MFksRRw/QAclFvXK7n7xH6
        SPXKR0FZBY+u51lep50Prr8=
X-Google-Smtp-Source: APXvYqwNSQvlzLzWVWRovL5DhGpmH6zUc3Ntsm8YzG8OJJBh4M/ghmHUD+hy84ZiI2Rud5avettFmw==
X-Received: by 2002:a7b:c753:: with SMTP id w19mr3231534wmk.91.1566981255985;
        Wed, 28 Aug 2019 01:34:15 -0700 (PDT)
Received: from localhost (pD9E51890.dip0.t-ipconnect.de. [217.229.24.144])
        by smtp.gmail.com with ESMTPSA id r5sm1211055wmh.35.2019.08.28.01.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 01:34:15 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Kamil Debski <kamil@wypas.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Stephen Boyd <swboyd@chromium.org>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] hwmon: pwm-fan: Use platform_get_irq_optional()
Date:   Wed, 28 Aug 2019 10:34:11 +0200
Message-Id: <20190828083411.2496-2-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190828083411.2496-1-thierry.reding@gmail.com>
References: <20190828083411.2496-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

The PWM fan interrupt is optional, so we don't want an error message in
the kernel log if it wasn't specified.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/hwmon/pwm-fan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
index 54c0ff00d67f..42ffd2e5182d 100644
--- a/drivers/hwmon/pwm-fan.c
+++ b/drivers/hwmon/pwm-fan.c
@@ -304,7 +304,7 @@ static int pwm_fan_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, ctx);
 
-	ctx->irq = platform_get_irq(pdev, 0);
+	ctx->irq = platform_get_irq_optional(pdev, 0);
 	if (ctx->irq == -EPROBE_DEFER)
 		return ctx->irq;
 
-- 
2.22.0

