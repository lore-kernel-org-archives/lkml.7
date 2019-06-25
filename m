Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC21FC48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 16:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C58182133F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 16:35:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="G4Pw99p7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731343AbfFYQfD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 12:35:03 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38597 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730134AbfFYQfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 12:35:00 -0400
Received: by mail-wr1-f67.google.com with SMTP id d18so18647483wrs.5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 09:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sFDObtAhBFoq+e3uGBncXCZh94u1gqoIy533R027F8g=;
        b=G4Pw99p7XQ8OGBF3dnF0u8nsP2gzt973olZmzxwCvcharaKDy85867vLHAfEEMeOY6
         WbvGNVaQTvX6o6k0m03Dbg3bqJePqRGuhQt3WSt/PGG8Cb/oCVEqY2X6FLotNA0IXfJm
         ARyniYvJZe/t7VQyJcxGxpDqPU66WCtZIWCej1JRYrPbhTKgeT2by3xxii6Mp4ieweY4
         kcGKmEFn2Ow9kyf3HS2AOfy4WfOxqLajkqnTEHqnZVLC2+gcImOh2N06MabRO5E7+Uh0
         Rz8cDgo9FQcCj48JgPkYsVbGknrWRKT8C9/qsCP3bGmyaklMqjuX8zcNjbTiVOhmz5fy
         wOUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sFDObtAhBFoq+e3uGBncXCZh94u1gqoIy533R027F8g=;
        b=P9rPxCBC6QZ9QBYye0AvEBj+IaND/E4jmB7vm/CkyPn/EeY8g8IrHkAdH7hC5MywtK
         yNztn6Vm0JV7Kq4rKLg5ur/i2c6QOy/qj0rhcLai6ZyRtzzE3FhCXAnFjS6l6dKnLBjm
         FdwRvVFxggBMhRAnVBBbbQOIpTsz3eGTzCGvfXnqOJlWdxoUbUa6VRbZPG8A4Pkz0cmc
         QImDUac2RwwWjH5Gk4tD+nxtdXG4ATmvKwI1QJ4D9DAyTU9vLha2p4w9aEeAIxQXCHHJ
         6JtnK6s3cTeCogYSbV56K7DNk8sA5Ay/nRGnp5/B6DY3l2tGi0scwsn08M1qOcRvVJaB
         KcyQ==
X-Gm-Message-State: APjAAAXFMqku+2NHGlTxfVSRCOH81V4W7Yge4ucvAQn6sPiS/Wf5L/RZ
        JMeB+BFLu06xHq57Fj5V4XSu7g==
X-Google-Smtp-Source: APXvYqw0FlaqXL9keBHWR7KbT8zOx0gQKa57yMr4s6cP5zk/w1cWEybKYPn7W1s8wCZ4fu5o6W6zoA==
X-Received: by 2002:adf:fc91:: with SMTP id g17mr25182759wrr.194.1561480498103;
        Tue, 25 Jun 2019 09:34:58 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id g8sm2683795wme.20.2019.06.25.09.34.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 09:34:57 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        David Lechner <david@lechnology.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 05/12] ARM: davinci_all_defconfig: enable GPIO backlight
Date:   Tue, 25 Jun 2019 18:34:27 +0200
Message-Id: <20190625163434.13620-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190625163434.13620-1-brgl@bgdev.pl>
References: <20190625163434.13620-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Enable the GPIO backlight module in davinci_all_defconfig.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/configs/davinci_all_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/davinci_all_defconfig b/arch/arm/configs/davinci_all_defconfig
index 13d7846c613d..06855b2bce7e 100644
--- a/arch/arm/configs/davinci_all_defconfig
+++ b/arch/arm/configs/davinci_all_defconfig
@@ -158,6 +158,7 @@ CONFIG_FB=y
 CONFIG_FIRMWARE_EDID=y
 CONFIG_FB_DA8XX=y
 CONFIG_BACKLIGHT_PWM=m
+CONFIG_BACKLIGHT_GPIO=m
 CONFIG_FRAMEBUFFER_CONSOLE=y
 CONFIG_LOGO=y
 CONFIG_SOUND=m
-- 
2.21.0

