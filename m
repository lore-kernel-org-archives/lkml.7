Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C59BC48BD6
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 15:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34D1E2133F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 15:16:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="ksJu/lYM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732056AbfFYPQR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 11:16:17 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34218 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731615AbfFYPQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 11:16:16 -0400
Received: by mail-wr1-f68.google.com with SMTP id k11so18367592wrl.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 08:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JJ65PYSwq9lHbap5+/eYVEe6uBbmNNIS8cKuG+4aQHM=;
        b=ksJu/lYM5QnmLSPoluMTTQ/cRukJmIwktRNyGqrTaY8uKdSyPKM/jut3sVcnj0Tmg0
         DnfK/chEnLFtZdjJS956/3EWm5SzHKDhS1UbhcA3sD3BlxJihPZC1bMYQXDWbRhRanUp
         ujrecaXEJCukCWUei7CBPwk8ltCtCE8rNbKaLsdwPXBk6TZXe5NyY+zbz3HsnvyyseFj
         xD5c9zeMa0bv2T0ySY0AEOEB7dYek8fV8xNMGLcKouZOu3mtYDmKaZrdbyBd2WxrNJfN
         bWAk/hZNI9gjFaav3pHFluT/VzVMHUUQ2t5qnXO4khDGV0I1gZebTv0CUjrPkFXHbOJP
         1Jyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JJ65PYSwq9lHbap5+/eYVEe6uBbmNNIS8cKuG+4aQHM=;
        b=L7PPLiKdYIrqa+phH6YJl1xbRHsbnstCz3WPKdHLoMbp1p72Zvt06++Ren3s8U6y5I
         8oXFCXsYN9G8fAnrL90Go4TOLguW9YCk4DkMWRpPT6rLCMY8sjAYaVL91y2/RIKtcGm5
         kxWGj15NU0WXiN4FBcrbpgwU0o6F9dPRuAhu299CAsHMPpzOON2uY6hc5L7UYLIJiSIu
         4wNTFOUq7l32DR/u7H9o8o81g8K8AMrj6+eW1YcISAeKMyfi6ZwrfXYJvr0hy1f0kRsm
         7a5AknGewpljkGHD+5/OZYsLxzJgRjVIdyg3wo/qkbd7dZpHw5R/qPLKfFYtMHZyX6eR
         HTrg==
X-Gm-Message-State: APjAAAV+0dfbqg9aHl4Z37VOezndUyvWUSN1fryGmWfGRXQsoSv/3EOy
        /vgVnoI3M2CaBZwJ71I1yJ6fpA==
X-Google-Smtp-Source: APXvYqxcAJrcmpvr7/K/LFeB9QoRDG9hoW/+Wh0dvHT93oYnsjvEnWP3OfC0MlMmKOgGg6wJ4n/yag==
X-Received: by 2002:a05:6000:112:: with SMTP id o18mr29440105wrx.153.1561475774684;
        Tue, 25 Jun 2019 08:16:14 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id t1sm18456995wra.74.2019.06.25.08.16.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 08:16:14 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        stable@vger.kernel.org
Subject: [PATCH] ARM: davinci: da830-evm: fix GPIO lookup for OHCI
Date:   Tue, 25 Jun 2019 17:16:12 +0200
Message-Id: <20190625151612.6204-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The fixed regulator driver doesn't specify any con_id for gpio lookup
so it must be NULL in the table entry.

Fixes: 274e4c336192 ("ARM: davinci: da830-evm: add a fixed regulator for ohci-da8xx")
Cc: stable@vger.kernel.org
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/board-da830-evm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
index 51a892702e27..aba10a2bc6b9 100644
--- a/arch/arm/mach-davinci/board-da830-evm.c
+++ b/arch/arm/mach-davinci/board-da830-evm.c
@@ -88,7 +88,7 @@ static struct gpiod_lookup_table da830_evm_usb_oc_gpio_lookup = {
 static struct gpiod_lookup_table da830_evm_usb_vbus_gpio_lookup = {
 	.dev_id		= "reg-fixed-voltage.0",
 	.table = {
-		GPIO_LOOKUP("davinci_gpio", ON_BD_USB_DRV, "vbus", 0),
+		GPIO_LOOKUP("davinci_gpio", ON_BD_USB_DRV, NULL, 0),
 		{ }
 	},
 };
-- 
2.21.0

