Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21CBCC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 20:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7F5420663
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 20:31:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Mg4fv0I1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731840AbfFXUb1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 16:31:27 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38472 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731825AbfFXUbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 16:31:25 -0400
Received: by mail-pf1-f194.google.com with SMTP id y15so3521584pfn.5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 13:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lSYYVqhHYII5ViyDtFOkp4I/i31+agPnClo/p5CN7rU=;
        b=Mg4fv0I1KvsvYo7P+k+I0/jzY0DpnxpM73UwzZA397nYxCv69Pmx51bd0IZKJQS/T0
         e/T2av1TRlRVmfz56FF9Jew1DTrqN5iqbEIH15c5yTcYw4xPo9wLhvaIaKD96sdi5ihi
         w7DU16/nElyk+XneNHQnooeQwSyLleBKKFhyY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lSYYVqhHYII5ViyDtFOkp4I/i31+agPnClo/p5CN7rU=;
        b=KJXuORgqIYysnAzhVqZ0sOfYAEhPgXnR5yfIb1j+w1PYlgILmDwDV7z2ITr6lTKBP7
         RjNF+wlAgqNQdMoZgwWq3W4Lb5lb3XC+2T1AYJpSaXosEKWAfLV6JJGWs3bu+LpHBIo2
         WyzQi2Fj59LZk4ZYuJ9CC2AEPXFPqkT+5KGc7qDciE10IhEbYILOtRcTNXieYKvRHFzD
         FDQTPLIsRGTWcxVIjY8lkIbeDNddHGX4KmWHkOdrrRXvMGhhV0fXyFm5JuOIfk0Wc8/V
         GecW7i64RDFGHfkEEKIxK6kdBp5ADhx+Gb0phs5bZJLOec9BPDtyG0/NX8EZq0IYE5E8
         Poxw==
X-Gm-Message-State: APjAAAW9G8xTlQR2O3iNFQ58Nn1izd2vdWA+/lG/y3vtdbhCEc1xk2E6
        mcKNraC+jmlBttSLnG6cpLWlIw==
X-Google-Smtp-Source: APXvYqzbWxM5xrdZvQVssIkJ108K28bRsNta+aYXMp4VczMFyBnMpEFk0/3OUZMH3nt4zl2HLpoBMQ==
X-Received: by 2002:a65:62ca:: with SMTP id m10mr34696355pgv.57.1561408284531;
        Mon, 24 Jun 2019 13:31:24 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id e10sm9833411pfi.153.2019.06.24.13.31.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 13:31:24 -0700 (PDT)
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
Subject: [PATCH v2 3/4] backlight: pwm_bl: Set scale type for CIE 1931 curves
Date:   Mon, 24 Jun 2019 13:31:12 -0700
Message-Id: <20190624203114.93277-4-mka@chromium.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
In-Reply-To: <20190624203114.93277-1-mka@chromium.org>
References: <20190624203114.93277-1-mka@chromium.org>
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
Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
---
Changes in v2:
- added Enric's 'Tested-by' tag
- added Daniel's 'Acked-by' tag
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
2.22.0.410.gd8fdbe21b5-goog

