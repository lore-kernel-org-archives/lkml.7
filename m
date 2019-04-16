Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C95F5C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 12:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9559020868
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 12:46:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ArR+V5ww"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729275AbfDPMq4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 08:46:56 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41303 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729131AbfDPMqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 08:46:53 -0400
Received: by mail-wr1-f67.google.com with SMTP id r4so26854846wrq.8
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 05:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pUZNmtUp8w0ve+d9Kspes7pbniIquQvm2umi/KT+H7I=;
        b=ArR+V5ww45wsYMYtzRXHaS4Y1f49Y8P5vdyWngOTaqv8zJPsX8TEMvW84OcIfTjYdS
         8z1ySXMmuxz+2IeeGdQvhIDFLL28iS2AUy1Wf9yhh249yAQCbN1j+rWKLNEjtbIQqtJy
         ae3wRSpKgdZYQyZdrAsJUPZ3lpClKIqTESCfYpvg777OCxgwYOoiCqIQrS8pyk4tox7x
         ib1DHLtl/lW5y91zYKbFzJG5KyHVO6UBXVhPgFwcgoFUlyL+Jj5a6KySV1uUxovzcfdP
         d0wnPBtaW5qqoqfz1PC27k45v/6qyzlepHzXgASGZAWNW/zGnvK1cI6+J6YDUm1cVfkR
         FMrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pUZNmtUp8w0ve+d9Kspes7pbniIquQvm2umi/KT+H7I=;
        b=WL6fkNWJBixmIMoNx87yc2iT7xYagePP1YVRIqLFZqVcWPlAINFYVq4JfiyZ59dkow
         4/QgUB2VFHkq3wEEyWCNUKOa91DEuZm9CYN+PM2Y3YpEHz93Sgu7z9fld2I1xz9/YwCt
         zDW07Na9FjGVoPda/U2PpSZ5oO8/wpklz8DlyMT4ygTMgQO2+Ig4lX9WxrYKfE9c0uZr
         CFBdC0VfSpz+KZY0lcOAKdYwXh80uSi0FgPbVl/C8nyjeIrUjUsLhWxsxellurpdPmf2
         jSmeVhspeAR5M2fpD4GQtCvoKxis66GxJyiEn2g3hr2TK7qr+BUeqSoq3fRocBrotLRW
         R+DA==
X-Gm-Message-State: APjAAAWSohwl9tDMz5PwyqsVwEBzS2b4J2QlVkI9DcctA2whMM797KPG
        ch3u4emxdGcnoOtXa9GV2eUVANUre2Q=
X-Google-Smtp-Source: APXvYqz9yqaQui5JDwglsEipJxzXhe+poXIi39JmETZKpFmOeU3T/yA3X18d3FSqlimY+JYgywHtSw==
X-Received: by 2002:a5d:6150:: with SMTP id y16mr29924698wrt.13.1555418811640;
        Tue, 16 Apr 2019 05:46:51 -0700 (PDT)
Received: from mai.imgcgcw.net (50.251.95.92.rev.sfr.net. [92.95.251.50])
        by smtp.gmail.com with ESMTPSA id p6sm42823732wrs.6.2019.04.16.05.46.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 05:46:51 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Tony Lindgren <tony@atomide.com>
Subject: [PATCH 4/4] clocksource/drivers/timer-ti-dm: Remove omap_dm_timer_set_load_start
Date:   Tue, 16 Apr 2019 14:46:40 +0200
Message-Id: <20190416124640.20058-4-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190416124640.20058-1-daniel.lezcano@linaro.org>
References: <92427592-507b-e280-01bf-763d795c8a2f@linaro.org>
 <20190416124640.20058-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>

Commit 008258d995a6 ("clocksource/drivers/timer-ti-dm: Make
omap_dm_timer_set_load_start() static") made omap_dm_time_set_load_start
static because its prototype was not defined in a header. Unfortunately,
this causes a build warning on multi_v7_defconfig because this function
is not used anywhere in this translation unit:

drivers/clocksource/timer-ti-dm.c:589:12: error: unused function
'omap_dm_timer_set_load_start' [-Werror,-Wunused-function]

In fact, omap_dm_timer_set_load_start hasn't been used anywhere since
commit f190be7f39a5 ("staging: tidspbridge: remove driver") and the
prototype was removed in commit 592ea6bd1fad ("clocksource: timer-ti-dm:
Make unexported functions static"), which is probably where this should
have happened.

Fixes: 592ea6bd1fad ("clocksource: timer-ti-dm: Make unexported functions static")
Fixes: 008258d995a6 ("clocksource/drivers/timer-ti-dm: Make omap_dm_timer_set_load_start() static")
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Acked-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-ti-dm.c | 28 ----------------------------
 1 file changed, 28 deletions(-)

diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
index 3352da6ed61f..ee8ec5a8cb16 100644
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -585,34 +585,6 @@ static int omap_dm_timer_set_load(struct omap_dm_timer *timer, int autoreload,
 	return 0;
 }
 
-/* Optimized set_load which removes costly spin wait in timer_start */
-static int omap_dm_timer_set_load_start(struct omap_dm_timer *timer,
-					int autoreload, unsigned int load)
-{
-	u32 l;
-
-	if (unlikely(!timer))
-		return -EINVAL;
-
-	omap_dm_timer_enable(timer);
-
-	l = omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
-	if (autoreload) {
-		l |= OMAP_TIMER_CTRL_AR;
-		omap_dm_timer_write_reg(timer, OMAP_TIMER_LOAD_REG, load);
-	} else {
-		l &= ~OMAP_TIMER_CTRL_AR;
-	}
-	l |= OMAP_TIMER_CTRL_ST;
-
-	__omap_dm_timer_load_start(timer, l, load, timer->posted);
-
-	/* Save the context */
-	timer->context.tclr = l;
-	timer->context.tldr = load;
-	timer->context.tcrr = load;
-	return 0;
-}
 static int omap_dm_timer_set_match(struct omap_dm_timer *timer, int enable,
 				   unsigned int match)
 {
-- 
2.17.1

