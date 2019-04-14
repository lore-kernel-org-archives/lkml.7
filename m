Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0A3EC282CE
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 15:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADCA820880
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 15:53:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z3ri1bD0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbfDNPxp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 11:53:45 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38933 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbfDNPxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 11:53:45 -0400
Received: by mail-lf1-f67.google.com with SMTP id z9so11107766lfh.6;
        Sun, 14 Apr 2019 08:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=jBNVmWmGdJt5SodYOmd7AVLKMqCirxIEn4fX+JQEemc=;
        b=Z3ri1bD0oai3KDlWqY6xF1aHilAVOR5IqrUBQ9GqRGhoOe0sqp7K5g/tZ2j6vk0PMS
         q6wyYyWHV7/iWiA3UZ7Z5CJR8uCeyzm52Gcw2mP0RvM+UuzkoSC9H4qwig6/ys0nWHSA
         cb8671Jxumig82tZQLbmu0xvQpC4rKUtygPPhnBGILe1DxOAYzitPzCVYjKXJb5DPfuS
         41Z7pZzyMJAFubi0X/uxEC6cd14O88v1X5Cny0GHjzqdOMNbLkFNppvV5QQkN3GFFxB1
         oICB2rNRRPrUTpw5dALpKJ9XCHsCM5q7EPveB7SXaa/Ep0xlU1nOde/IV5PxVFJZT2qA
         9y3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jBNVmWmGdJt5SodYOmd7AVLKMqCirxIEn4fX+JQEemc=;
        b=ly+4ea8zDAqHhOPQA4RRQVJSqufFQ1sOEuxOyN7kejV+KY1rvPp6EkEZHkKa67xrZf
         Tnt8ydMy+/Ex2E9jh1wZ1La5EI8gheBtH/Yx169/uXZUsQrP52Bm5kFVNHMMMTtQbWY2
         bti6++UpDaeauQx3hgAzUz18HIkNyHhyXrJiMMunFVhCv/eM0ERHSRwcBiBJxFveb6A5
         AvtXNBM8ec5U80iOWyiUpIii9DVsacecm8zeSQS2cjp2VToWxXiRsggw3nrfOWS4nfu4
         fnsnpfNTDCAKZUhM48C2s+2vjt/5wx1QAirNdsbt/X4hcanjUtghlTF3LKHKBpt6G/fu
         LOnQ==
X-Gm-Message-State: APjAAAU6y9rnD66HzWCwj0Lv9rEvitjzBxVk+H+wkeWYKlz+zmUWmSgU
        ULJkTr9ec+5DUAXX9YwTRZU=
X-Google-Smtp-Source: APXvYqw8nMyyo05K9FPvErxSOrwQydowseV9zHMC3BH/J6FsCt9bwXj8Mh4VTIro4Qc+PjORBZWkQw==
X-Received: by 2002:a19:48cb:: with SMTP id v194mr6494194lfa.20.1555257222801;
        Sun, 14 Apr 2019 08:53:42 -0700 (PDT)
Received: from localhost.localdomain (46-243-146.internethome.cytanet.com.cy. [46.199.243.146])
        by smtp.gmail.com with ESMTPSA id q6sm6265301lfj.36.2019.04.14.08.53.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 14 Apr 2019 08:53:41 -0700 (PDT)
From:   Mohan Kumar <mohankumar718@gmail.com>
To:     linus.walleij@linaro.org
Cc:     jic23@kernel.org, knaack.h@gmx.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] drivers/iio/gyro/mpu3050-core.c: This patch fix the following checkpatch warning.
Date:   Sun, 14 Apr 2019 18:53:38 +0300
Message-Id: <1555257218-3830-1-git-send-email-mohankumar718@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per Documentation/timers/timers-howto.txt Msleep < 20ms can sleep for
up to 20ms. so use usleep_range.

Signed-off-by: Mohan Kumar <mohankumar718@gmail.com>
---
 drivers/iio/gyro/mpu3050-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
index 85b7ac4..0a40616 100644
--- a/drivers/iio/gyro/mpu3050-core.c
+++ b/drivers/iio/gyro/mpu3050-core.c
@@ -865,7 +865,7 @@ static int mpu3050_power_up(struct mpu3050 *mpu3050)
 		dev_err(mpu3050->dev, "error setting power mode\n");
 		return ret;
 	}
-	msleep(10);
+	usleep_range(10000, 20000);
 
 	return 0;
 }
-- 
2.7.4

