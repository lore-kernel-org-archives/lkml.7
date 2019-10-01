Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13A3CECE58A
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 23:29:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D80E621920
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 23:29:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LoLWuA/z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729066AbfJAX3d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 19:29:33 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43520 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729052AbfJAX33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 19:29:29 -0400
Received: by mail-pf1-f194.google.com with SMTP id a2so9227128pfo.10
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 16:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EcVg9u8V8Uf/idldytEF3NgOMyW0OU8oijTXHZJkyVg=;
        b=LoLWuA/zt6wQo9niY6rS50WlST0jKh8TXiLphIX/HwUpy05ohub5qr5fmX/ajPIl38
         XXY9DeDYzLb3r6VQgb82GF+lkIrTF0YatAYRiWTOyE0EbZ19L9ZzOE4ZksI8EWzk99qF
         HppXuMICfou5mYFPWkwYg/UF2L+14P67qumf0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EcVg9u8V8Uf/idldytEF3NgOMyW0OU8oijTXHZJkyVg=;
        b=jll2ZfuenTrzUDgG4CZp8W9NsVQV9qQwn8dVdB8yFjYSoCEq5sKW03lQGr0L2wY91s
         hWc1u1UK6Zyr/19ZWNPMsSe1pIwyQEkUaCJAboMHCpGWk5Vxjqc+2x7SXHLLYfp36iw4
         MPztOi6OwQ4kMcLg7tsEN5gD/0P2bWyZUcfYiac3o+TpA5a08rLAk7vOh4PjjUvu0fRP
         QlKiRQu7eBq839amRdnssM8UxxFbQTCvBoa/hngMsvvBQn+KmJm8vpv5rIoTmX4balEl
         3LAdeuqpFR0SCUp7ALchsVU8RLr8MMZ8Uhn/1RWr3nkTUBS/emyCHwUgu7lE6DJQeeJI
         Vp1A==
X-Gm-Message-State: APjAAAXGihnJldvJjgv8Hwtlbm6BNHWWSoaUFK0LoQJcKi//3IosjQS6
        h86IFjwtjf6+rVf6Ru+JzpqB+s72NDs=
X-Google-Smtp-Source: APXvYqyttY662qaZ9at4NRsqD7ukXbj1wr2h7SXDVAWfKw7gZzdYntUGCR2evMFpv1BqiZxzO5THcw==
X-Received: by 2002:a62:fc46:: with SMTP id e67mr1005912pfh.153.1569972568837;
        Tue, 01 Oct 2019 16:29:28 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id c8sm20990266pga.42.2019.10.01.16.29.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Oct 2019 16:29:28 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Matthias Kaehlcke <mka@chromium.org>, linux-pwm@vger.kernel.org,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] backlight: pwm_bl: Don't assign levels table repeatedly
Date:   Tue,  1 Oct 2019 16:29:24 -0700
Message-Id: <20191001162835.1.I4f2ede1f55ddd1c72b0303b7fd7f73a782fa33e5@changeid>
X-Mailer: git-send-email 2.23.0.444.g18eeb5a265-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pwm_backlight_probe() re-assigns pb->levels for every brightness
level. This is not needed and was likely not intended, since
neither side of the assignment changes during the loop. Assign
the field only once.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---

 drivers/video/backlight/pwm_bl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index 746eebc411df..959436b9e92b 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -564,6 +564,8 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 	memset(&props, 0, sizeof(struct backlight_properties));
 
 	if (data->levels) {
+		pb->levels = data->levels;
+
 		/*
 		 * For the DT case, only when brightness levels is defined
 		 * data->levels is filled. For the non-DT case, data->levels
@@ -572,8 +574,6 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 		for (i = 0; i <= data->max_brightness; i++) {
 			if (data->levels[i] > pb->scale)
 				pb->scale = data->levels[i];
-
-			pb->levels = data->levels;
 		}
 
 		if (pwm_backlight_is_linear(data))
-- 
2.23.0.444.g18eeb5a265-goog

