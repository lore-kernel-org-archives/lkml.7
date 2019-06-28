Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E79EEC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 10:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B708E208E3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 10:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="1kAaf6/E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfF1KDK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 06:03:10 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39250 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbfF1KDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 06:03:08 -0400
Received: by mail-wm1-f65.google.com with SMTP id z23so8401931wma.4
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 03:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7sHmLWUZTOubwniZNmRjFR+C4eT64A3MhAkvvXjkgx8=;
        b=1kAaf6/E5+mGz2iHvV/w6LgbjXUhE1J3FzxAzvc/ZMLUb2zRO7JwW9EipA8C/jmpZz
         5HUle30z3/HdqsLsnPco+ax5qINUWQ4s7k4ggjosmlI/fbBXZm++e4cEugXp9BjHU4Qx
         tDbhB8VtKAOUXH+bWAlP3YAAdpR1/eiNGnr8Lw/R5l0m9gvXcqTTk656VSTq2JetlXPl
         mOFupK5XnTtvkJeO3/5iAsjwwzfMMZDAE3F7gDLzbahlsVVEIgrGTVx5hTTAHoDNnoXS
         n6Ms2cgxcakJiTfWkYmP27eXz32j6fhqow/QWLg8746IpufcteQsu1UzegGhleFtdr8W
         63pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7sHmLWUZTOubwniZNmRjFR+C4eT64A3MhAkvvXjkgx8=;
        b=O4NqECBtWJ8hBTDQDfYedLg9bt9I0wgxLhivWbq2h6ITPWd1CYoBAEasUQTIRC7gek
         MZV6I8F37+Pl4bq7VvQF335C9jaXGq6qT0cFkfn9Gai1wkW9NiAPeWOc5fzAqw3zLExp
         JLZ1t6dHIJZ6t1yDQ6hzs/Th1bPto+CMetWA8JjuagX5vStbrOev3oYGUgeWc58t77T5
         FvvkV/ovC49EGsVOVkSLeDiM7Vwc0IijXX/zw9XcoYwZWl+dRDNI3vAxRV3Wxsf7lU1S
         S6DlsOmaEmPLQRcwtndCebGb6QVxBZ/U7UG+NTlb1chmm5gS6LePjaVgQ1bH7IsP4MWZ
         irow==
X-Gm-Message-State: APjAAAVF6hGVFEvUzi5lH9jx+sWuw1vxAIwr9ZNRFysDafyP09eLkLDv
        Q6I03NrWPA2vu+PrcNZbJ3N2TA==
X-Google-Smtp-Source: APXvYqwJX9x/uwYqffqMsBH3PX5OmMDmgZ/93GpHvTIYXbJMNuLuI1utY/Q3MxYU6lzYE9800yi4Gw==
X-Received: by 2002:a1c:6641:: with SMTP id a62mr6397513wmc.175.1561716186765;
        Fri, 28 Jun 2019 03:03:06 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id l124sm1628874wmf.36.2019.06.28.03.03.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2019 03:03:06 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH RFT 3/4] sh: ecovec24: don't set unused fields in platform data
Date:   Fri, 28 Jun 2019 12:02:52 +0200
Message-Id: <20190628100253.8385-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190628100253.8385-1-brgl@bgdev.pl>
References: <20190628100253.8385-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Platform data fields other than fbdev are no longer used by the
backlight driver. Remove them.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/sh/boards/mach-ecovec24/setup.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index 6926bb3865b9..64a5a1662b6d 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -386,9 +386,6 @@ static struct property_entry gpio_backlight_props[] = {
 
 static struct gpio_backlight_platform_data gpio_backlight_data = {
 	.fbdev = &lcdc_device.dev,
-	.gpio = GPIO_PTR1,
-	.def_value = 1,
-	.name = "backlight",
 };
 
 static const struct platform_device_info gpio_backlight_device_info = {
-- 
2.21.0

