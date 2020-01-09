Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB54C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 15:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64DC0206ED
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 15:59:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JKmLYh76"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732732AbgAIP7T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 10:59:19 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46861 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732714AbgAIP7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 10:59:15 -0500
Received: by mail-pf1-f196.google.com with SMTP id n9so3547991pff.13
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 07:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nXeS+ouA9N1i5qwsZQvBHp9ywLVGIMgkBuIimwXxsas=;
        b=JKmLYh76Glb/+LD2AOn/d24gD8ZdhYqsiIopZq90nxjan5djoLTVmn1pDGdTdLWRjJ
         wVcd6DEmmD7FxxJeQx4St8uxS2kVUHuAfJUDeVgpHHlaEmFOhpN5w/jd+VkO7jsUMPKY
         CqRxvXwb8uIZ63a3TcNIG4dRuleeRauOyW2DY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nXeS+ouA9N1i5qwsZQvBHp9ywLVGIMgkBuIimwXxsas=;
        b=OGqhE62uroAkTG+W3xAh06gX87l4jF8joXT8EV1NlIQloA7J7Mnv5NQuaCa/k2/Ea4
         IxP9UsdV+Z8lGZCuTKXr9nx5ukZd6QJY7bkl6GkMZn1DGqP0BNI+NG1ivtPWk2PNc2bF
         SFa6xVL4h3x2IrX/kTVKmHLQT4HllnMu6PM7BZ9IGQ6Lnt4gypB4TuBy0hslhWLKeOZm
         tDHNN6xmkXw7PFg46B/43m1xGaduLX9and8F10VGNawOoIKkILSpDkoBnGpyjh56mHq3
         qGoX+qCYuUKvzE/74aMgrh+4S3YKerxuNiGJ2bELYosuOExJh0wQCQo0AvEr1WmUjpQH
         vkxg==
X-Gm-Message-State: APjAAAWGNBl9hh1K5ZggBFWSrgy4aN6EhWtwIsgs7gCPp0T/Gh0F3cpc
        P4diKnIzuSduabx5Pt/OQnlw9w==
X-Google-Smtp-Source: APXvYqydkJbjdH41BgUDyFKNd0kKSGCw1CblLwqe6bJi5fgYETzwsf4N/Jxu5Jod5R2qpPqVrHg4fQ==
X-Received: by 2002:a62:8202:: with SMTP id w2mr12191386pfd.100.1578585553586;
        Thu, 09 Jan 2020 07:59:13 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id j20sm7832793pfe.168.2020.01.09.07.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 07:59:13 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH 3/4] alarmtimer: Use wakeup source from alarmtimer platform device
Date:   Thu,  9 Jan 2020 07:59:09 -0800
Message-Id: <20200109155910.907-4-swboyd@chromium.org>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
In-Reply-To: <20200109155910.907-1-swboyd@chromium.org>
References: <20200109155910.907-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the wakeup source that can be associated with the 'alarmtimer'
platform device instead of registering another one by hand.

Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 kernel/time/alarmtimer.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index ccb6aea4f1d4..be057638e89d 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -55,8 +55,6 @@ static DEFINE_SPINLOCK(freezer_delta_lock);
 #endif
 
 #ifdef CONFIG_RTC_CLASS
-static struct wakeup_source *ws;
-
 /* rtc timer and device for setting alarm wakeups at suspend */
 static struct rtc_timer		rtctimer;
 static struct rtc_device	*rtcdev;
@@ -87,7 +85,6 @@ static int alarmtimer_rtc_add_device(struct device *dev,
 {
 	unsigned long flags;
 	struct rtc_device *rtc = to_rtc_device(dev);
-	struct wakeup_source *__ws;
 	struct platform_device *pdev;
 	int ret = 0;
 
@@ -99,8 +96,9 @@ static int alarmtimer_rtc_add_device(struct device *dev,
 	if (!device_may_wakeup(rtc->dev.parent))
 		return -1;
 
-	__ws = wakeup_source_register(dev, "alarmtimer");
 	pdev = platform_device_register_data(dev, "alarmtimer", -1, NULL, 0);
+	if (pdev)
+		device_init_wakeup(&pdev->dev, true);
 
 	spin_lock_irqsave(&rtcdev_lock, flags);
 	if (!rtcdev) {
@@ -112,15 +110,12 @@ static int alarmtimer_rtc_add_device(struct device *dev,
 		rtcdev = rtc;
 		/* hold a reference so it doesn't go away */
 		get_device(dev);
-		ws = __ws;
-		__ws = NULL;
 		pdev = NULL;
 	}
 unlock:
 	spin_unlock_irqrestore(&rtcdev_lock, flags);
 
 	platform_device_unregister(pdev);
-	wakeup_source_unregister(__ws);
 
 	return ret;
 }
@@ -287,7 +282,7 @@ static int alarmtimer_suspend(struct device *dev)
 		return 0;
 
 	if (ktime_to_ns(min) < 2 * NSEC_PER_SEC) {
-		__pm_wakeup_event(ws, 2 * MSEC_PER_SEC);
+		pm_wakeup_event(dev, 2 * MSEC_PER_SEC);
 		return -EBUSY;
 	}
 
@@ -302,7 +297,7 @@ static int alarmtimer_suspend(struct device *dev)
 	/* Set alarm, if in the past reject suspend briefly to handle */
 	ret = rtc_timer_start(rtc, &rtctimer, now, 0);
 	if (ret < 0)
-		__pm_wakeup_event(ws, MSEC_PER_SEC);
+		pm_wakeup_event(dev, MSEC_PER_SEC);
 	return ret;
 }
 
-- 
Sent by a computer, using git, on the internet

