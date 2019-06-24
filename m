Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85538C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 20:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58EEB20663
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 20:31:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="G/bUhQsl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731926AbfFXUbb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 16:31:31 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36567 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731819AbfFXUb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 16:31:26 -0400
Received: by mail-pl1-f194.google.com with SMTP id k8so7552545plt.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 13:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uZKHvCx8L/nRTrUb/ohywx0d3IXX3vcHyiOoGdIF2Vg=;
        b=G/bUhQslRBb9yDeN/Ju1v2H78Jn3pcV6lvi6ZsyGVCuBbzJ+oIhAcvU04QfS10U/4R
         pdE3J6hWbwxyP4QcHwwtH00UNcd1LgYEz2XOvY5wmOr4tiTSrA/9uD0OATvj9bqrmoPn
         id+vaY8rgFoQ9n7vUdhFL4XPoNNii/WHKNs9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uZKHvCx8L/nRTrUb/ohywx0d3IXX3vcHyiOoGdIF2Vg=;
        b=CAMdTPt4BbKPwk8uttgMaF6queNWcQE+4iEo72FWDe5HMgrKyN1tknDC1qKa1djDl1
         jrYozWkBZz+NXF+zLKP0Vv/h5YKO79moBy6GSvkYI5rhPCLNZI4xK93wLUIbdmUyxnk3
         9LiBXBkP4k5HCM2KKiml7XxfmduOoIM8cI/2NKv1cVqs7NOTRO+C3KlFDkaSZEtRe04W
         LOLSxZ+3uK6UaGCe4CWfWD27QxPpuHiMVFPf8NF+6JvWJkXN2n5rg4xStbQsHpjfl4P/
         p4vi+X4O5X7ih0zZbQu3aGhNrh9k/yIMrYzwskokYAv3VNK6fl3ZWdqxX90yzJIas/+J
         Ng1w==
X-Gm-Message-State: APjAAAX+HAO46GCWZJj+aWHcbtyZDnkrRKWEqJb9huUhmHI6/pt5fxZT
        f32LUAtWiL/CDnffRt453xm6dg==
X-Google-Smtp-Source: APXvYqzY0+srP89wCVDbPca+cx8EHxAJHQuHwUe5lX3IaE2YnttbyJ+9Ii8mxU7OnlFea1FBJZ1y0Q==
X-Received: by 2002:a17:902:2006:: with SMTP id n6mr94261265pla.232.1561408286127;
        Mon, 24 Jun 2019 13:31:26 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id r2sm21887470pfl.67.2019.06.24.13.31.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 13:31:25 -0700 (PDT)
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
Subject: [PATCH v2 4/4] backlight: pwm_bl: Set scale type for brightness curves specified in the DT
Date:   Mon, 24 Jun 2019 13:31:13 -0700
Message-Id: <20190624203114.93277-5-mka@chromium.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
In-Reply-To: <20190624203114.93277-1-mka@chromium.org>
References: <20190624203114.93277-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check if a brightness curve specified in the device tree is linear or
not and set the corresponding property accordingly. This makes the
scale type available to userspace via the 'scale' sysfs attribute.

To determine if a curve is linear it is compared to a interpolated linear
curve between min and max brightness. The curve is considered linear if
no value deviates more than +/-5% of ${brightness_range} from their
interpolated value.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
---
Changes in v2:
- use 128 (power of two) instead of 100 as factor for the slope
- add comment about max quantization error
- added Daniel's 'Acked-by' tag
---
 drivers/video/backlight/pwm_bl.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index f067fe7aa35d..2297fb4af49d 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -404,6 +404,31 @@ int pwm_backlight_brightness_default(struct device *dev,
 }
 #endif
 
+static bool pwm_backlight_is_linear(struct platform_pwm_backlight_data *data)
+{
+	unsigned int nlevels = data->max_brightness + 1;
+	unsigned int min_val = data->levels[0];
+	unsigned int max_val = data->levels[nlevels - 1];
+	/*
+	 * Multiplying by 128 means that even in pathological cases such
+	 * as (max_val - min_val) == nlevels the error at max_val is less
+	 * than 1%.
+	 */
+	unsigned int slope = (128 * (max_val - min_val)) / nlevels;
+	unsigned int margin = (max_val - min_val) / 20; /* 5% */
+	int i;
+
+	for (i = 1; i < nlevels; i++) {
+		unsigned int linear_value = min_val + ((i * slope) / 128);
+		unsigned int delta = abs(linear_value - data->levels[i]);
+
+		if (delta > margin)
+			return false;
+	}
+
+	return true;
+}
+
 static int pwm_backlight_initial_power_state(const struct pwm_bl_data *pb)
 {
 	struct device_node *node = pb->dev->of_node;
@@ -567,6 +592,11 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 
 			pb->levels = data->levels;
 		}
+
+		if (pwm_backlight_is_linear(data))
+			props.scale = BACKLIGHT_SCALE_LINEAR;
+		else
+			props.scale = BACKLIGHT_SCALE_NON_LINEAR;
 	} else if (!data->max_brightness) {
 		/*
 		 * If no brightness levels are provided and max_brightness is
-- 
2.22.0.410.gd8fdbe21b5-goog

