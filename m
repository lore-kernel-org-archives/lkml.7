Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE8E4C28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 11:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF4F220868
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 11:05:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u1DIN3x+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728397AbfFILFQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 07:05:16 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37712 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728095AbfFILFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 07:05:16 -0400
Received: by mail-wm1-f67.google.com with SMTP id 22so5616816wmg.2
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2019 04:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HQKyYTiIHBoxfwUBKiSU0G9vIjxtSN3vc8IsNMrmb2M=;
        b=u1DIN3x+nKwG9rfxkgNXGb6sJ776zgHi1xlNxvj7TBNX1Kh3KamBqes2rtvtFlVPkR
         DyaSkzMaHmd8sBt/x0mNF+23MnZJz+OwWg5+amKDDYexNpo3yn9xSE8cF3ySsFhcYqhA
         B5GoRWQFX/hT7/6w4+eVDbb2DOGDNCDpOJkrB5FZ/n/bUyTW3k7PiXJrXMuopwzbf/Vi
         SV6TZ/rUX3ZwfcRJsnuv4rNbPbJ2KEfuIPOXt0UzmFhgeY9UgO3utJPJZqYxfFteZDBz
         NV4oNCC8kF2gaxv7vxjbBO3veVCgam0b9ZSfsDsj+is+C9XzVfJEBfbiI6qXsMI3tLMY
         vynQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HQKyYTiIHBoxfwUBKiSU0G9vIjxtSN3vc8IsNMrmb2M=;
        b=ZAohmZmCmbJ2E+LYmV1p8vcFryPjcpkoyg9Lq0owZYSjGaxqx7jjc4+rqg+5+HQwQs
         Y8imc2guxxrTRfavS+1ORnIqCk/l3fAPLSx1huhdRnWb1gnn5nZJbJHk3YdZb34eyZ0b
         nav3CSqAGZi70Jp5NZ9LjMounbfaH3ml2JJXS1BtWXVrafjt+Yt4TON8zyWO2deIuHeO
         cyQic0bXzxWXgPRArK/Op5qKpEgl2P8KH9uaRovkidxUXAEE5YxfmaGYv2I8BQxQJDb4
         Ouy+pp/fdAMMTV8OrNZnHCLeWz0kvqYwsbKiGtfPhpAV+yGnXRKccHzEeOMzUF78Z0kD
         ARDA==
X-Gm-Message-State: APjAAAVq2gMPebKmqJ8nOEUONHzuxI3WzeGnHqdMqkMM6MBsNvZWOXE7
        PNbJIseAt6YolzXiVU4X3Slvpw==
X-Google-Smtp-Source: APXvYqxSiYu4/lqfPR260cg+YXXt3uq2iCRmwnXb1YMfhX6/xqObAA6neZPHk3AUXxcNhDXMPawFCA==
X-Received: by 2002:a1c:f20f:: with SMTP id s15mr9469434wmc.33.1560078313528;
        Sun, 09 Jun 2019 04:05:13 -0700 (PDT)
Received: from localhost.localdomain (catv-89-135-96-219.catv.broadband.hu. [89.135.96.219])
        by smtp.gmail.com with ESMTPSA id v67sm7806231wme.24.2019.06.09.04.05.11
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 09 Jun 2019 04:05:11 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH] regulator: max77802: Drop unused includes
Date:   Sun,  9 Jun 2019 13:05:13 +0200
Message-Id: <20190609110513.29220-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver does not use any symbols from <linux/gpio.h>
no <linux/gpio/consumer.h> so just drop the includes.

Cc: Javier Martinez Canillas <javierm@redhat.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/regulator/max77802-regulator.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/regulator/max77802-regulator.c b/drivers/regulator/max77802-regulator.c
index ea7b50397300..7b8ec8c0bd15 100644
--- a/drivers/regulator/max77802-regulator.c
+++ b/drivers/regulator/max77802-regulator.c
@@ -14,9 +14,7 @@
 #include <linux/kernel.h>
 #include <linux/bug.h>
 #include <linux/err.h>
-#include <linux/gpio.h>
 #include <linux/slab.h>
-#include <linux/gpio/consumer.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/driver.h>
-- 
2.20.1

