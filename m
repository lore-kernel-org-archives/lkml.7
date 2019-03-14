Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B586C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 15:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BE0521852
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 15:08:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="UPhc1H4H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbfCNPIE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 11:08:04 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44459 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727104AbfCNPID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 11:08:03 -0400
Received: by mail-wr1-f66.google.com with SMTP id w2so6223628wrt.11
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 08:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yLj+m0PQbx7O5SDwZocYe/74u39NFe3CIQFW29ukkrk=;
        b=UPhc1H4HrzDqO0aT/GnqD3u+UoLDffhQ0Aa1MJQ8G2T4kRkFKOo9vs6DBwN2X8EA/D
         /z42e9uR2azHSocrzIPei/8E2iiX4+Tf7S3mDAe1+NR1roqZf5KsiPs5QKg6rVibzdQp
         v2mjv4kasI83mpxg3ljwmLGoy9pCadx43ZmFYEEmmFYUupWoABzOdJu9N07iJrwMbqeL
         w2JcTY9Wb7k5alX3rFTJl5CrZscbxkToa4zztYqd62Q5MNw9E7NQ0VVeWEbjZR4Je7y3
         VF4AgV8rFLa4L11TG7p7lYizugUcbOtCDFk9xRfvwBm697onvmWsuqyPgUmP8z4oqKSy
         uVJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yLj+m0PQbx7O5SDwZocYe/74u39NFe3CIQFW29ukkrk=;
        b=mpGfnsKX1nHf+MJJuXZn1SsNDcVWr6JbmkECuMUs07nMqAdWOBznmhK+qUszNeiDy5
         s7XNPgfotpKqNQZ1P384f/VppyzqBbg6+JVXIZ6/al5YUpbFrfkl993nhdiNyAjg3FJN
         bsT5WyhtkPQbSBDgZsLJxI7Ew0XhKcSNUB/MkhO60IFIPBWBAdXEeDRWkQGs1d79fr60
         +LM2bKsErYYVX+lZ/ub/LBtcCH8bFCFqGjGvqAM8PyijTjnWstZCCEgXH/7EHQeOU5zE
         6ehtotMxDwMXO0kU0+8zO4+LOhD2KTlygQpRlXiDjkBzfb14M48DqlPcbzfBNFOWuSZg
         WTeQ==
X-Gm-Message-State: APjAAAVuE39Ns7CUqFM3ziS8XQctu0e0YuEiTbvR+c2E5a9zAgfwlB3V
        u+ICDWeGkCOAmiAmukr52LynJQ==
X-Google-Smtp-Source: APXvYqza6+m/MtL34xZUQ5aXsmNnl64M2Fn8hDn/NcSxWnPAXrgcqLjEl4OJEZMp9dzAIpczT0aawg==
X-Received: by 2002:adf:cd0f:: with SMTP id w15mr19614633wrm.267.1552576081547;
        Thu, 14 Mar 2019 08:08:01 -0700 (PDT)
Received: from localhost.localdomain (aputeaux-684-1-31-143.w90-86.abo.wanadoo.fr. [90.86.86.143])
        by smtp.gmail.com with ESMTPSA id p6sm42947662wre.63.2019.03.14.08.08.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 08:08:00 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 1/2] gpio: mockup: drop unneeded dependencies from Kconfig
Date:   Thu, 14 Mar 2019 16:07:49 +0100
Message-Id: <20190314150750.9371-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The testing module doesn't need GPIO irqchip nor does it depend on
sysfs. Remove unnecessary dependencies from Kconfig.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/gpio/Kconfig | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 3f50526a771f..e9473e968d9a 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -332,9 +332,7 @@ config GPIO_MM_LANTIQ
 
 config GPIO_MOCKUP
 	tristate "GPIO Testing Driver"
-	depends on GPIOLIB && SYSFS
-	select GPIO_SYSFS
-	select GPIOLIB_IRQCHIP
+	depends on GPIOLIB
 	select IRQ_SIM
 	help
 	  This enables GPIO Testing driver, which provides a way to test GPIO
-- 
2.20.1

