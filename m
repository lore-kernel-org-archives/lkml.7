Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57167C31E49
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 19:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28F0420B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 19:43:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Yxrvkmix"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729716AbfFMTnu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 15:43:50 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38754 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729287AbfFMTng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 15:43:36 -0400
Received: by mail-pl1-f194.google.com with SMTP id f97so8588471plb.5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 12:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AB616NjBSa9Vj9zUvVGBmMFoqPgqn8QM9MSbUPc9ICQ=;
        b=Yxrvkmixlfb/dkkn3muC+q7KBymUNvGxf3uq8JFtc1veDsLcXzlkkbky+1KOMyJJy5
         AUXgm4wSct7l+DLpaom1h3YgZ53bhvH7VMit/r23M13Zf7UJXpiZNBMpf5qKt8L5WZzR
         JCW00YgMSqhmw+cLWJ4x1BT1ucklGqtUb1zYA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AB616NjBSa9Vj9zUvVGBmMFoqPgqn8QM9MSbUPc9ICQ=;
        b=ghvohSrTsJ/wcKYG6CSSOgB2cdfo2J+Qccz0/b7h0zk7XQGgcbE59cHo76m0brYGmL
         PAynV9W31dC5+oVlKHL/gJeodPf5V0QA9MvYUHc2je7GwesmxLDTCbuHCA4GWyf6e6yX
         AG7E29oC8t0CM7VMndQ1UZ+1OIiAz7p4oA6K6kLqfJBZByq9WD6Jv+D4bZj/ujA9RCne
         N6KddABkdIt1vYePvQ67Qfy2LPo+LAMmDKK9Vmxu6OPvslTILSKxTVUDa7UBKDRo0V4a
         NP2LZZYGl4RS87ALEtFpgFI6ICdMN8MJl3UFDx1oRjqbKMGoaQ+D27lQZeN6uzvfB3bA
         FrzA==
X-Gm-Message-State: APjAAAXXS8CsLzErJTDDC2UBM9Xaw9UiDuvcbibgulEFcs1+j2iugH5Z
        kcrWb6wgSFBu+631ZrRw7RZOtw==
X-Google-Smtp-Source: APXvYqzSKXohZs3Y1MuNYqnEVn0RY46WZktUdfaBzLXLJbhxNFxqybOloZxPtO9z7gXgrhS6QV+9tg==
X-Received: by 2002:a17:902:d695:: with SMTP id v21mr72975853ply.342.1560455016086;
        Thu, 13 Jun 2019 12:43:36 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id b17sm525029pfb.18.2019.06.13.12.43.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 12:43:35 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Douglas Anderson <dianders@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Pavel Machek <pavel@ucw.cz>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH 3/4] backlight: pwm_bl: Set scale type for CIE 1931 curves
Date:   Thu, 13 Jun 2019 12:43:25 -0700
Message-Id: <20190613194326.180889-4-mka@chromium.org>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
In-Reply-To: <20190613194326.180889-1-mka@chromium.org>
References: <20190613194326.180889-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For backlight curves calculated with the CIE 1931 algorithm set
the brightness scale type property accordingly. This makes the
scale type available to userspace via the 'scale' sysfs attribute.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/video/backlight/pwm_bl.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index fb45f866b923..f067fe7aa35d 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -553,6 +553,8 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 		goto err_alloc;
 	}
 
+	memset(&props, 0, sizeof(struct backlight_properties));
+
 	if (data->levels) {
 		/*
 		 * For the DT case, only when brightness levels is defined
@@ -591,6 +593,8 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 
 			pb->levels = data->levels;
 		}
+
+		props.scale = BACKLIGHT_SCALE_CIE1931;
 	} else {
 		/*
 		 * That only happens for the non-DT case, where platform data
@@ -601,7 +605,6 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 
 	pb->lth_brightness = data->lth_brightness * (state.period / pb->scale);
 
-	memset(&props, 0, sizeof(struct backlight_properties));
 	props.type = BACKLIGHT_RAW;
 	props.max_brightness = data->max_brightness;
 	bl = backlight_device_register(dev_name(&pdev->dev), &pdev->dev, pb,
-- 
2.22.0.rc2.383.gf4fbbf30c2-goog

