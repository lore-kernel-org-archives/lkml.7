Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C31C33CA2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 15:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66854206ED
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 15:59:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="T7kSGMJy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732723AbgAIP7Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 10:59:16 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39044 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732702AbgAIP7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 10:59:14 -0500
Received: by mail-pg1-f196.google.com with SMTP id b137so3412878pga.6
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 07:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LMdxInQe1Q4ees5yhUcq0MugLIAZLO3j6ngq+iSNLJM=;
        b=T7kSGMJyRRNKrNr0bhnoqZ41v0tLEn7V6iPrm9Fp9Fetp/w9cI5NleA/iR+K/NeH1l
         VewRwA9rFC+olvMrrgHR1h+Uqqo1YG0kf05Yv2q8i0++u85GsKoKH5CAehDo2aJ8sK9D
         8E7b56Lo67tPzsJ8dpmopcVSi+SM+ST7CzuF4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LMdxInQe1Q4ees5yhUcq0MugLIAZLO3j6ngq+iSNLJM=;
        b=fE1W7ETXFmJXjK5x/cblf75U5L43KOFGSOdjYs/1wlCjjUw2wFnLSJ47JqgRgKacgT
         2JE9OCc/lQlZ+HgnaB22xVwm/VYdnFT5DAOD05+mpLT+pKdEO1MXqeag53XvFzHKj5Gz
         i7P+4lNNjhbg+9BzK30dwP/BybgMyy/WkbyDFSPYcAbQtZnhI6Tof788OLfnrcawCl4E
         ANw5Ys33EUZyzuBDDv6BrB/vkIo78hmEyHo3hi0a6a3oCk9SOYgIihl9KVQWNLnZsPBZ
         ILTEugzILqrTgnEltaThSS1CXQOfvOJ0gCLRKJQcMdPbg17e3f/aS5k5nao9RjbtfKMU
         A9mg==
X-Gm-Message-State: APjAAAU6nIIKGAihmhPKXzVnJJYWF01ViNeSft+l2ehRkPENkoyFLMan
        nIwUylCGPlYK8krAnYX8AVML/Q==
X-Google-Smtp-Source: APXvYqwb5gYBZ7/Ai53IdQeeXgAZtcUiwkTIsmMLa3Gg60Gr0ErommRxsoGsETtZ3EONBGu1CYcgDA==
X-Received: by 2002:aa7:9829:: with SMTP id q9mr11649990pfl.231.1578585552095;
        Thu, 09 Jan 2020 07:59:12 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id j20sm7832793pfe.168.2020.01.09.07.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 07:59:11 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH 1/4] alarmtimer: Unregister wakeup source when module get fails
Date:   Thu,  9 Jan 2020 07:59:07 -0800
Message-Id: <20200109155910.907-2-swboyd@chromium.org>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
In-Reply-To: <20200109155910.907-1-swboyd@chromium.org>
References: <20200109155910.907-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The alarmtimer_rtc_add_device() function creates a wakeup source and
then tries to grab a module reference. If that fails we return early
with a -1, but forget to remove the wakeup source. Cleanup this exit
path so we don't leave a dangling wakeup source allocated and named
'alarmtimer' that will conflict with another RTC device that may be
registered.

Fixes: 51218298a25e ("alarmtimer: Ensure RTC module is not unloaded")
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 kernel/time/alarmtimer.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index 451f9d05ccfe..4b11f0309eee 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -88,6 +88,7 @@ static int alarmtimer_rtc_add_device(struct device *dev,
 	unsigned long flags;
 	struct rtc_device *rtc = to_rtc_device(dev);
 	struct wakeup_source *__ws;
+	int ret = 0;
 
 	if (rtcdev)
 		return -EBUSY;
@@ -102,8 +103,8 @@ static int alarmtimer_rtc_add_device(struct device *dev,
 	spin_lock_irqsave(&rtcdev_lock, flags);
 	if (!rtcdev) {
 		if (!try_module_get(rtc->owner)) {
-			spin_unlock_irqrestore(&rtcdev_lock, flags);
-			return -1;
+			ret = -1;
+			goto unlock;
 		}
 
 		rtcdev = rtc;
@@ -112,11 +113,12 @@ static int alarmtimer_rtc_add_device(struct device *dev,
 		ws = __ws;
 		__ws = NULL;
 	}
+unlock:
 	spin_unlock_irqrestore(&rtcdev_lock, flags);
 
 	wakeup_source_unregister(__ws);
 
-	return 0;
+	return ret;
 }
 
 static inline void alarmtimer_rtc_timer_init(void)
-- 
Sent by a computer, using git, on the internet

