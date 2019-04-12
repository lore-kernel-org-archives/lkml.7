Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AC3AC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 10:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5891E2171F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 10:09:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KZwCiftk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbfDLKJa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 06:09:30 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39457 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726711AbfDLKJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 06:09:29 -0400
Received: by mail-wm1-f65.google.com with SMTP id n25so10277933wmk.4
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 03:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=jBNVmWmGdJt5SodYOmd7AVLKMqCirxIEn4fX+JQEemc=;
        b=KZwCiftkOUwSSadD9CbsJp2D5kbjAJvQS1oIqvBfgfML2VidTeEPfZ8jnfrJ05wnp7
         4M4ZNxRWg8r+bgVa96Js5YG/rJT3NGEjlik9beYUCJr5e0TvYH9vC2UhcWwJt0eT2j+K
         hvR92GeqQ8oT58E5cTLF5oMradyjdGpGQVhNbOD55HVirANTaIYZnWUqJjONwchOYU1F
         ZU8jmYm9xHfEr5TuvpNpUiabn3bjnwO5wGPbTBbRiJpZGsz7mqx3dpAloNTO2IcVR+GK
         KtPe/t48rtp2Yl1rliYyn+My/espgXb6ztBXJvZPEVadpe+7VsC5xhIrN84onAGO2i6T
         uKlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jBNVmWmGdJt5SodYOmd7AVLKMqCirxIEn4fX+JQEemc=;
        b=khL9+L8XYHplN0YWg83TlUUcE2FgrDVqXXI1PJqUpsjmkxMnmAEHcdKvJh/OSr16CG
         dEIIbETPq2Yjm1rIr77gPqvd69sKg5j28qYXxoPizUGWfy37NbGwXi4XOd59+l/ESqSp
         7RAqYaOQ/soHJjjCGJ4NjSm2VD/yB0rvexvaKuOqp1IIt3tJjb2NkBWiWdIjloQQTaoz
         +wa7QuQw/kk47kugH6kNG6QTKQmIjJNf/7z7ZNNCdCNUNQCUunntWC1me9kQ9++NrYsj
         H/0trzqOI63pLKR7TzPicdxAwMWIsVQ6L01xQ7XoYg0VIETL1/lYnFdcg8WY4Xygnp4B
         gWnA==
X-Gm-Message-State: APjAAAUhPeE5rCueq6Toc+C8+I6/JKBfrJbJ97FMrIC3jDiJxPbyylDg
        2xcO3tHb9hxN5yF8w3iaeY8=
X-Google-Smtp-Source: APXvYqyRMKLIyyG90FFjXqo6R9gb5o6z1tpEuOj+DDLHB4p6VpGreXWkLKjZ94F6T8UTpyoUVPx3WQ==
X-Received: by 2002:a1c:9991:: with SMTP id b139mr9883138wme.53.1555063767917;
        Fri, 12 Apr 2019 03:09:27 -0700 (PDT)
Received: from localhost.localdomain (46-243-146.internethome.cytanet.com.cy. [46.199.243.146])
        by smtp.gmail.com with ESMTPSA id b9sm13050472wmc.9.2019.04.12.03.09.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 12 Apr 2019 03:09:27 -0700 (PDT)
From:   Mohan Kumar <mohankumar718@gmail.com>
To:     linus.walleij@linaro.org
Cc:     jic23@kernel.org, knaack.h@gmx.de, linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/iio/gyro/mpu3050-core.c: This patch fix the following checkpatch warning.
Date:   Fri, 12 Apr 2019 13:09:23 +0300
Message-Id: <1555063763-2328-1-git-send-email-mohankumar718@gmail.com>
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

