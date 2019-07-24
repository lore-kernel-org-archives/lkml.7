Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 928BDC7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 08:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CA21229FA
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 08:25:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="pjvnwWlg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbfGXIZs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 04:25:48 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36463 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbfGXIZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 04:25:19 -0400
Received: by mail-wr1-f67.google.com with SMTP id n4so46003868wrs.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 01:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PtXEm5EHLkMfau18VS0/ndTlnG64/pDTlbKgiSCBHXM=;
        b=pjvnwWlg1S0JJObJ4VAQYglevZH6RzmSr9LO8Vogmks9DNfq/Ol7Vv994gV+BUd3ea
         BzBvGJRFZG460Sx04z9WdPLd5/AWYUsRQsPfSbsvEdQZbEzWUWAM2vwkxE7EBHXG+iQY
         h3q3/kwA6euG7dAy9zWHIe292Lm41qMYTqLzrGHC6RXOOWBrDIlBoML4fRdfoSzJrh1v
         8924F2s+Z5KscpUb/O8kWJ0k9TcHopYH2o18DLKSTopAiitXP7ZveOS4UIOKF6zdZHJm
         QGVgGP4zLRsWceIkaRs7WzkZzgwaK5qgmUcXdwmgxGYb9fTRcWyQYB+4fwYPsXpV6aCj
         u2xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PtXEm5EHLkMfau18VS0/ndTlnG64/pDTlbKgiSCBHXM=;
        b=h8/hf+zqrzU3Zc1ItQsRQyVDQsJlPPdn+ILP6H/ZGfBjV5unynrI7QQuMueoQq8D14
         xgeRfhIi4KjoEXuD+OC8qL5LPI85CQx1d8AU0H0v86Rz2hwNuFyzsNYLIPq3ND268KAp
         +eZTCAnyU8U0B4PVxejHd3xv9p134V060eluWERXsgTp+/ZB40voEkC0vPWIL8XuAA9d
         NJoK+PVS5GqDll/H43gXq0yLQLgsgf4qKWCyvaH0/ylxqz4lFuvG17Ciz35h5gokhj/5
         zkbuVgVAArKxlkTQRHRYyd3CaTUTt7kBYQOglYrEXBUXxxtUw5mDBF6Vd0DrMQmrnrDP
         Jk0Q==
X-Gm-Message-State: APjAAAWmqR1oXdNgbba7DUq5rODNLDylTUpDjVVi26UYMddHdaJOoQ45
        OwgkTXr3v0SscMFpn/wr3Fw=
X-Google-Smtp-Source: APXvYqwzyOuZJqgrEqGk5ckOvAjzeH6Yh+/HufAQdFV4AXpJer4oPxFe3x+2qPBsY0spQGgjJr4fWA==
X-Received: by 2002:adf:ea45:: with SMTP id j5mr11543282wrn.11.1563956717025;
        Wed, 24 Jul 2019 01:25:17 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-652-1-281-69.w109-210.abo.wanadoo.fr. [109.210.96.69])
        by smtp.gmail.com with ESMTPSA id z7sm42393880wrh.67.2019.07.24.01.25.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 01:25:16 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 4/7] backlight: gpio: remove unused fields from platform data
Date:   Wed, 24 Jul 2019 10:25:05 +0200
Message-Id: <20190724082508.27617-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190724082508.27617-1-brgl@bgdev.pl>
References: <20190724082508.27617-1-brgl@bgdev.pl>
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
2.21.0

