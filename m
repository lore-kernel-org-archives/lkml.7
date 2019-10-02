Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3336C352AA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 16:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B507221D81
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 16:56:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BNCWbn4Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728149AbfJBQ4K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 12:56:10 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39796 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728063AbfJBQ4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 12:56:09 -0400
Received: by mail-pf1-f193.google.com with SMTP id v4so10694636pff.6
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 09:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0V6I7vxpenGYwQo+a0w9xjv8KE9amu4CMjrShydQWuc=;
        b=BNCWbn4YoFqFl6WmXRRnHBUsgZ15/0sG7ZoaJNoV2ERMyL0F2sh9H6Yz4aKEHvZdvj
         FJID9ANMx4kNqAyZ9Z+YtoAd6pfJacgQhQywuPzDjBbBLhTtZwVTI3CUZKUGgL2PHSrq
         QB9oc/76C2javT9MA1DwV78kZ9l7USnccItEI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0V6I7vxpenGYwQo+a0w9xjv8KE9amu4CMjrShydQWuc=;
        b=JadjZeEVvUBNzzuKyphizUEvbrlvCAeNigFm59vzLRU0/2WKmHmLCGH3v2AoWsRGwi
         ZIKQfuKPi1toPAIJyY0E8Oytqk+3Oqu9sD1YGB8KAJ3LT6TGQADwlSfvASptpgyjGsdE
         PXNoDk0gloojbdbvwABN3rdMoiBZWzNICE7z4RprNyr4s6vzmUDV07Qyxe+1q2NHA6d8
         nvqCbXvgG1Pjt982WZBdN/KwVlJz2Jy9veL2LK6D+b5OcyeG3V1Oh68Fow7pCDRqgl79
         O6W1MjSUDSUdIXWy3e6ROYp95j+LbDjkqKZnkZYl2xWLefHHzvok0wcZY3AMMMivMcPl
         4KRQ==
X-Gm-Message-State: APjAAAWg2T2Rs4jPTpU51oKL5rUENan2pB1mBVTT70D4FMRYsJ9NtMX6
        vDsjDlOjaumiEj9rB5XOInp9YQ==
X-Google-Smtp-Source: APXvYqw7iJb+eM19mWGTE2rmb9T/7FR39PHihYj+YtlS7q6rqzp4liG+5Pq1fL6s78/n2zPG//C9Cw==
X-Received: by 2002:a17:90a:cf93:: with SMTP id i19mr5509952pju.72.1570035368715;
        Wed, 02 Oct 2019 09:56:08 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id b123sm27546480pgc.72.2019.10.02.09.56.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2019 09:56:07 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Matthias Kaehlcke <mka@chromium.org>, linux-pwm@vger.kernel.org,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] backlight: pwm_bl: Don't assign levels table repeatedly
Date:   Wed,  2 Oct 2019 09:56:01 -0700
Message-Id: <20191002095541.v2.1.I4f2ede1f55ddd1c72b0303b7fd7f73a782fa33e5@changeid>
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

Changes in v2:
- removed curly braces from for loop

 drivers/video/backlight/pwm_bl.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index 746eebc411df..05d3b3802658 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -564,18 +564,17 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 	memset(&props, 0, sizeof(struct backlight_properties));
 
 	if (data->levels) {
+		pb->levels = data->levels;
+
 		/*
 		 * For the DT case, only when brightness levels is defined
 		 * data->levels is filled. For the non-DT case, data->levels
 		 * can come from platform data, however is not usual.
 		 */
-		for (i = 0; i <= data->max_brightness; i++) {
+		for (i = 0; i <= data->max_brightness; i++)
 			if (data->levels[i] > pb->scale)
 				pb->scale = data->levels[i];
 
-			pb->levels = data->levels;
-		}
-
 		if (pwm_backlight_is_linear(data))
 			props.scale = BACKLIGHT_SCALE_LINEAR;
 		else
-- 
2.23.0.444.g18eeb5a265-goog

