Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40FBEC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 05:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10A8B2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 05:03:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i8UFD5s1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725763AbfC0FDW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 01:03:22 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44478 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbfC0FDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 01:03:22 -0400
Received: by mail-ed1-f66.google.com with SMTP id x10so12761668edh.11
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 22:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nzcDs41+bF9IYKPkkrV2hJJFQfxuniuuSYIMDt/XAyc=;
        b=i8UFD5s1IJ3QStsQ392FhCE0Cl5ffy6dMe9jqyxqj/jl+YmWA5uwdU+i3vJOjTRFvW
         jXGCQYYIb/4/+fcGKL0vPuAModCHhTx/gaOq8OkRtQrAMsz3FWkJEkPJ5lJZmHb5jhWD
         1NLi5FLd6kKM2ONltraoPb8Dttdp+ZPmtFhCZj7gy9D41jHqnIcqN7gARLXc/OPQd9cy
         gyQ2QueuMmaXP3IXIAxXBTQ/UHpx00tmQ6RjC3HfYWLiKtjfjQBOHtzgDZDG8znNepJs
         aaQfQL3TdmS+fOYOJhx4LdRMbk2wPcaXldaBQOoCDAL2AWE6aBXe84KctcQV13Hdu4b/
         5mUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nzcDs41+bF9IYKPkkrV2hJJFQfxuniuuSYIMDt/XAyc=;
        b=f5Mb7t+FDxLRFzoTIGUIcqr5DGnEb2q27SHMuwW5co1hE7kwg/5LZSBT2D2XKifGz+
         THtPH3yOVA3b0s1EOGuo5o+x4pdYLKKuPC2gl4rc80gHJe9Yqfm8m0HJerRbe9imkzJV
         S+04zDukTRHQyEcwXptGUJpFQvaUPKT2lYN/t0EqVR2VpL/UtLbpt+VyWrvOSuOhy6m5
         6rVd7qa2G21yqScWjhpLuk30sLAuHWFLH0IpU3N74aPlPl/XDRM+qTxauu/oUuztlEpV
         itd6IR0nzXJbi5w+wMApCWzp89UoBp9wVZ/nFOLyZ0DzHNGNzobiJijvSOjp6cvd6fRI
         6AWQ==
X-Gm-Message-State: APjAAAV/FBD3FiuziZRap31coxDbSrIorDjbeP6dpK9PWsEKuRbqHbQp
        EE4ba8iNxhN0WVFEMS0kjgA=
X-Google-Smtp-Source: APXvYqzj/qDo2JHfZ9hfGg7rEJLYfZDc85U8a8O6idCUIGlQMuc6oxD8/1jMy6lz9ncEnJR0SFPw6Q==
X-Received: by 2002:a50:91c2:: with SMTP id h2mr22782235eda.54.1553663000057;
        Tue, 26 Mar 2019 22:03:20 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id 35sm6872287edh.43.2019.03.26.22.03.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 22:03:19 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Ladislav Michl <ladis@linux-mips.org>,
        Tony Lindgren <tony@atomide.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] clocksource/drivers/timer-ti-dm: Remove omap_dm_timer_set_load_start
Date:   Tue, 26 Mar 2019 22:01:27 -0700
Message-Id: <20190327050126.12064-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---

My apologies if this has already been sent, I didn't see anything in tip
or on LKML.

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
2.21.0

