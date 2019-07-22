Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA1C0C76190
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 13:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 819E7219BE
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 13:45:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Mbw6mQ9K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730701AbfGVNoo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 09:44:44 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52042 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728637AbfGVNon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 09:44:43 -0400
Received: by mail-wm1-f66.google.com with SMTP id 207so35255524wma.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 06:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ut01oNwMX57rewfZ2xdsVgjWVgPo2hqv1zk7e2eNV1c=;
        b=Mbw6mQ9KduwIta89J1LYlF6kc7o9GduaI0+z36i+2YY7oFXW+PCLPTx4jo/x6p2lrr
         bmnE83LSxvIXiByTDGashJrMHQFIDsfkQOAym7PDLEp7mOrwZdITOnei15kO7/TIwW92
         9UairCADBliTVQSS4u9xdgFDh3yLDQOsfhO4I+F1vjLKSAnjdyh+5v3xVb3mLqlS2zkV
         YxV5QorVrwRlzvMhRYmTt8lY1h8nuFPSnpAeBJT0SLyrhCvYO8ZogPoIl0Huw6jxgnZ0
         o+EJiIkgWqa6jBvcMAH+Cj6fVgT8sENWgCKGrQLxfOCYp7YQxrxvMQdxt/pxvso7qJf9
         6s1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ut01oNwMX57rewfZ2xdsVgjWVgPo2hqv1zk7e2eNV1c=;
        b=aPwe4+lw1slq5hrkmCvZ7hToW0V6uc7I/JgiH7j3BKyce9JolSHhqevZvFKBkQq70J
         /k+5A7FzuaYFnOlDA1BoFnUe3XwYpcDwgqY9RDAQ4U/9iwylRJDn4aB6b5D7M6rCSeuU
         o2ZdfdkV1NmT8dAs4L9hlfcDBY4MBczCBkaWUO2unOurMwgqUnFSZhg1ajfCeeAVEeTL
         U14MF3bTHaWTwfWSFmfxw4BZvYqMJIhTKe1PqTnD4XDtqbhS7N2iC3kYgvbTEf+3qI9k
         AypCcF3HgDknYqaGPRxlTGZzGiCz/0uP6X3oSQnI0NpbFn1wiFYetvGpQ5FjOrA9weYM
         o6Zg==
X-Gm-Message-State: APjAAAVeaax/IlY9Ikp0BheUspxYyR5og/o79BnGabp1JVFWcUWV1pgM
        BgBT/5NvuqpJW8nfa+8KMu58Zfl3
X-Google-Smtp-Source: APXvYqzqrhDn87TPfR0stSfqmLuYDN1SzTLtME8rAq3V9wDoFdme8RgMbrLtcH/C2F3SJsvmcaSLPA==
X-Received: by 2002:a7b:cc86:: with SMTP id p6mr59100904wma.123.1563803081131;
        Mon, 22 Jul 2019 06:44:41 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-652-1-281-69.w109-210.abo.wanadoo.fr. [109.210.96.69])
        by smtp.gmail.com with ESMTPSA id p6sm40652484wrq.97.2019.07.22.06.44.40
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 06:44:40 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        David Lechner <david@lechnology.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-fbdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 2/9] ARM: davinci_all_defconfig: enable GPIO backlight
Date:   Mon, 22 Jul 2019 15:44:16 +0200
Message-Id: <20190722134423.26555-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190722134423.26555-1-brgl@bgdev.pl>
References: <20190722134423.26555-1-brgl@bgdev.pl>
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
index 7c2a39305f2b..56c23f8d9f26 100644
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

