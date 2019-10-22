Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C950CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 08:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3EF220679
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 08:36:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Fl1qTLhB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731317AbfJVIgz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 04:36:55 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35948 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731284AbfJVIgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 04:36:48 -0400
Received: by mail-wr1-f65.google.com with SMTP id w18so16464379wrt.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 01:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fJb9zTJUFk5gt04WV606l1pH2Oso/m6U1KjJZ/jsQAQ=;
        b=Fl1qTLhBQubCYTQvRFZGlqbpTFflj9tu3q08e1MlJzphl6MWRcspjYmiPTZQO2Nj6m
         L8FuqvAa/MmSqZfgRT8BK0odPTKh92doGHJtbxLFNYQ3Jq2IqO3h+/SX7sLrKDVjoZtO
         NcsW0dTxbzZRRQW+zVYC1/6FTVbUgWunR1cAtZ3QCODI0ZCAAS2VbKr/ZExzWJTjRnsS
         KZLvPQUIrnpg2BtCQrB5jK7IDHSB+/Xb4so9Es0sPAL3l52ve8BH3H/ygjsm0WkUjgPo
         z2OAjaxIvLaCP34M2mpYEXRyVWyNDFawxbs0agydIqrrRAhnwOhSTieVDVfZL8yBb/J3
         YAug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fJb9zTJUFk5gt04WV606l1pH2Oso/m6U1KjJZ/jsQAQ=;
        b=o5ia8Km6rABGnCzomArtj0RklbkopNi8v4WeH8/tXQYCcwwON7/JemfcCYbyYO/Bjw
         61xf6Xe3O9Nz+punB0gYK3Fkp/YIVjPEYxwDH10If9gTJ+jJco0BvpqM9Ikb+W/Oe/VD
         YVhozn6ycEdUCvQQr3rIGXgBAm10HWeSQih3lhPQV2Nc/JHM9Qzf6gmvWEjDO1QTY7LF
         Bp6gskVHZ2/NJadNSb3sbgSikQ192bcpOoCNZr/Co5oB/dJOegDbFnWMQkUVvKK6C9gb
         U2hX3BxkuJcmCv4lGeecy7Ed96gmwiAufgPzAbs8kDrnZs2NAA+56D1O+v6WNPiZ614d
         3xAA==
X-Gm-Message-State: APjAAAUruDQbornaioDjUI7zZaduRTI4jkf59jDU9Du7MZG6tmXNJ6ba
        v/P+gVGk97+bcmuBfQgrk4/l7Q==
X-Google-Smtp-Source: APXvYqw+u7/kRo/kyLMNI3vyXRrtnO/cCP4ewAM9p5Okg1CflyD/yuwcP6eDPcrZB/Mod7dBy1vY5g==
X-Received: by 2002:a5d:44c8:: with SMTP id z8mr2324652wrr.66.1571733404239;
        Tue, 22 Oct 2019 01:36:44 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-652-1-281-69.w109-210.abo.wanadoo.fr. [109.210.96.69])
        by smtp.gmail.com with ESMTPSA id g17sm17115253wrq.58.2019.10.22.01.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 01:36:43 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jacopo Mondi <jacopo@jmondi.org>
Cc:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v7 7/9] backlight: gpio: remove unused fields from platform data
Date:   Tue, 22 Oct 2019 10:36:28 +0200
Message-Id: <20191022083630.28175-8-brgl@bgdev.pl>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191022083630.28175-1-brgl@bgdev.pl>
References: <20191022083630.28175-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Remove the platform data fields that nobody uses.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 include/linux/platform_data/gpio_backlight.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/linux/platform_data/gpio_backlight.h b/include/linux/platform_data/gpio_backlight.h
index 34179d600360..1a8b5b1946fe 100644
--- a/include/linux/platform_data/gpio_backlight.h
+++ b/include/linux/platform_data/gpio_backlight.h
@@ -9,9 +9,6 @@ struct device;
 
 struct gpio_backlight_platform_data {
 	struct device *fbdev;
-	int gpio;
-	int def_value;
-	const char *name;
 };
 
 #endif
-- 
2.23.0

