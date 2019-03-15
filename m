Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A27ABC10F00
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 18:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7217321871
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 18:51:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ij7uFC2S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbfCOSvQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 14:51:16 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38207 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbfCOSvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 14:51:15 -0400
Received: by mail-pf1-f193.google.com with SMTP id n125so6951071pfn.5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 11:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rleyCUv6zQUmYM5LbtOOGEEQ+pnIQViUngiyeG0e1xI=;
        b=Ij7uFC2S6gp37t9ClA6PMDztNFMLbpvzZpp9It5z6YdN1WnSnuNs+AjuLcvb2qz0Zt
         i4tBALQsUU1wcESUQq7gOLX2u0AYwv4ouF/QQg1C3helQyDN4lRQfotSek6xQ6Tm0MJy
         NGX/+U8qhlwR12iovGZB/TQ3CCAUFoYnzMWnA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rleyCUv6zQUmYM5LbtOOGEEQ+pnIQViUngiyeG0e1xI=;
        b=Bts+z3q+slqNkLPe12kw1Nh3DR6kNbJUwPUigpmw5J5acfPuKbCuEnM7xa8sstoAkJ
         Kt2ozUjH4EVadSjprWQUKvVDxYnnG/KCnSrgd7LxZLdBEutW1OcaQHJN+7OcM4Z4omrg
         INPdCll0aqGEhv/QZvUxZQO3ErWM6nJYZ8wqvDHVisQh/N6qG/2ojZ3IDUW4gzxtY6Qi
         g8l+OikTChrR0enaTuKWrHrZ/NLDWJUoFPnETyMkN4sP++hDcvMMEhF6bo5bL56k1hLd
         aD64vkAy7mNqGMCee8WP8Bd//0L1a+4gsYDd3f4LQAHY9/TqEaQSpTvh+h8g2UXWas0c
         M/Zw==
X-Gm-Message-State: APjAAAUqgIu7msbkCz8nvXdscW4znqyLs1bzNwcV2yNnBdkmfpKXGNNm
        dy+wF7I2joJCRtmxGdF+RrLpXg==
X-Google-Smtp-Source: APXvYqyXh+RREvquWLWqBmX3XGPbzDmkHenQuZYqf1TV5CnW3Xmk3iapY8mACUH7kSERD8TxzqUXRA==
X-Received: by 2002:a62:3282:: with SMTP id y124mr5536379pfy.209.1552675874544;
        Fri, 15 Mar 2019 11:51:14 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id f16sm7560352pga.71.2019.03.15.11.51.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Mar 2019 11:51:13 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Evan Green <evgreen@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH] rtc: cros-ec: Fail suspend/resume if wake IRQ can't be configured
Date:   Fri, 15 Mar 2019 11:51:12 -0700
Message-Id: <20190315185112.97699-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.21.0.225.g810b269d1ac-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we encounter a failure during suspend where this RTC was programmed
to wakeup the system from suspend, but that wakeup couldn't be
configured because the system didn't support wakeup interrupts, we'll
run into the following warning:

	Unbalanced IRQ 166 wake disable
	WARNING: CPU: 7 PID: 3071 at kernel/irq/manage.c:669 irq_set_irq_wake+0x108/0x278

This happens because the suspend process isn't aborted when the RTC
fails to configure the wakeup IRQ. Instead, we continue suspending the
system and then another suspend callback fails the suspend process and
"unwinds" the previously suspended drivers by calling their resume
callbacks. When we get back to resuming this RTC driver, we'll call
disable_irq_wake() on an IRQ that hasn't been configured for wake.

Let's just fail suspend/resume here if we can't configure the system to
wake and the user has chosen to wakeup with this device. This fixes this
warning and makes the code more robust in case there are systems out
there that can't wakeup from suspend on this line but the user has
chosen to do so.

Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Evan Green <evgreen@chromium.org>
Cc: Benson Leung <bleung@chromium.org>
Cc: Guenter Roeck <groeck@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/rtc/rtc-cros-ec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-cros-ec.c b/drivers/rtc/rtc-cros-ec.c
index e5444296075e..4d6bf9304ceb 100644
--- a/drivers/rtc/rtc-cros-ec.c
+++ b/drivers/rtc/rtc-cros-ec.c
@@ -298,7 +298,7 @@ static int cros_ec_rtc_suspend(struct device *dev)
 	struct cros_ec_rtc *cros_ec_rtc = dev_get_drvdata(&pdev->dev);
 
 	if (device_may_wakeup(dev))
-		enable_irq_wake(cros_ec_rtc->cros_ec->irq);
+		return enable_irq_wake(cros_ec_rtc->cros_ec->irq);
 
 	return 0;
 }
@@ -309,7 +309,7 @@ static int cros_ec_rtc_resume(struct device *dev)
 	struct cros_ec_rtc *cros_ec_rtc = dev_get_drvdata(&pdev->dev);
 
 	if (device_may_wakeup(dev))
-		disable_irq_wake(cros_ec_rtc->cros_ec->irq);
+		return disable_irq_wake(cros_ec_rtc->cros_ec->irq);
 
 	return 0;
 }
-- 
Sent by a computer through tubes

