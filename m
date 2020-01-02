Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2144C3276C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7328624654
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578003260;
	bh=5AC2xCfCfLqP3A3NDGAvpy3laIQh4tm+18XUEStAY7k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NFceCkhrF+Ki3UmEw7IWjR1cpM1S3xSQPPg+4b1FOCFlZ5BMzNvWN+jzObZGqDhiG
	 VdIK0TpRA99EYUVprH2FNgj/INlviaj3hRUCASFd2zLA1usPaf3Pfug9v9rfebswHC
	 bmz75XKqL4Wb3uXCMFprYf4S9m8W3hweN84/uAgA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbgABWOT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 17:14:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:54502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727879AbgABWOR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 17:14:17 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC17022B48;
        Thu,  2 Jan 2020 22:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578003256;
        bh=5AC2xCfCfLqP3A3NDGAvpy3laIQh4tm+18XUEStAY7k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QjY9ZbYYiMgfwS7zPUrSwNA7vbf61ivlJMprdXm8X17FB15Bxg6acWATiXs4hriD0
         JciwTcbQaeZpUVnuL4WV6SyBh6ALjIV9m6VcVDPHe5psu1jKqefHqu2ckUS9dxEOZ2
         /xwgBR7p9QICPvLzmvbe69A17bUIqFQNT3/R3oHw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Tim Sander <tim@krieglstein.org>,
        Julia Cartwright <julia@ni.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Sasha Levin <sashal@kernel.org>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>
Subject: [PATCH 5.4 084/191] watchdog: prevent deferral of watchdogd wakeup on RT
Date:   Thu,  2 Jan 2020 23:06:06 +0100
Message-Id: <20200102215838.945935110@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200102215829.911231638@linuxfoundation.org>
References: <20200102215829.911231638@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Julia Cartwright <julia@ni.com>

[ Upstream commit a19f89335f4bda3d77d991c96583e3e51856acbb ]

When PREEMPT_RT is enabled, all hrtimer expiry functions are
deferred for execution into the context of ksoftirqd unless otherwise
annotated.

Deferring the expiry of the hrtimer used by the watchdog core, however,
is a waste, as the callback does nothing but queue a kthread work item
and wakeup watchdogd.

It's worst then that, too: the deferral through ksoftirqd also means
that for correct behavior a user must adjust the scheduling parameters
of both watchdogd _and_ ksoftirqd, which is unnecessary and has other
side effects (like causing unrelated expiry functions to execute at
potentially elevated priority).

Instead, mark the hrtimer used by the watchdog core as being _HARD to
allow it's execution directly from hardirq context.  The work done in
this expiry function is well-bounded and minimal.

A user still must adjust the scheduling parameters of the watchdogd
to be correct w.r.t. their application needs.

Link: https://lkml.kernel.org/r/0e02d8327aeca344096c246713033887bc490dd7.1538089180.git.julia@ni.com
Cc: Guenter Roeck <linux@roeck-us.net>
Reported-and-tested-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Reported-by: Tim Sander <tim@krieglstein.org>
Signed-off-by: Julia Cartwright <julia@ni.com>
Acked-by: Guenter Roeck <linux@roeck-us.net>
[bigeasy: use only HRTIMER_MODE_REL_HARD]
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/r/20191105144506.clyadjbvnn7b7b2m@linutronix.de
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/watchdog/watchdog_dev.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index dbd2ad4c9294..d3acc0a7256c 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -158,7 +158,8 @@ static inline void watchdog_update_worker(struct watchdog_device *wdd)
 		ktime_t t = watchdog_next_keepalive(wdd);
 
 		if (t > 0)
-			hrtimer_start(&wd_data->timer, t, HRTIMER_MODE_REL);
+			hrtimer_start(&wd_data->timer, t,
+				      HRTIMER_MODE_REL_HARD);
 	} else {
 		hrtimer_cancel(&wd_data->timer);
 	}
@@ -177,7 +178,7 @@ static int __watchdog_ping(struct watchdog_device *wdd)
 	if (ktime_after(earliest_keepalive, now)) {
 		hrtimer_start(&wd_data->timer,
 			      ktime_sub(earliest_keepalive, now),
-			      HRTIMER_MODE_REL);
+			      HRTIMER_MODE_REL_HARD);
 		return 0;
 	}
 
@@ -971,7 +972,7 @@ static int watchdog_cdev_register(struct watchdog_device *wdd, dev_t devno)
 		return -ENODEV;
 
 	kthread_init_work(&wd_data->work, watchdog_ping_work);
-	hrtimer_init(&wd_data->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	hrtimer_init(&wd_data->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
 	wd_data->timer.function = watchdog_timer_expired;
 
 	if (wdd->id == 0) {
@@ -1019,7 +1020,8 @@ static int watchdog_cdev_register(struct watchdog_device *wdd, dev_t devno)
 		__module_get(wdd->ops->owner);
 		kref_get(&wd_data->kref);
 		if (handle_boot_enabled)
-			hrtimer_start(&wd_data->timer, 0, HRTIMER_MODE_REL);
+			hrtimer_start(&wd_data->timer, 0,
+				      HRTIMER_MODE_REL_HARD);
 		else
 			pr_info("watchdog%d running and kernel based pre-userspace handler disabled\n",
 				wdd->id);
-- 
2.20.1



