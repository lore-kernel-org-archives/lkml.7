Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD63C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 13:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F41D920820
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 13:28:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731802AbfDJN2T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 09:28:19 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42265 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729060AbfDJN2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 09:28:19 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3ADSA5I788544
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 10 Apr 2019 06:28:10 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3ADSADS788541;
        Wed, 10 Apr 2019 06:28:10 -0700
Date:   Wed, 10 Apr 2019 06:28:10 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andrei Vagin <tipbot@zytor.com>
Message-ID: <tip-07d7e12091f4ab869cc6a4bb276399057e73b0b3@git.kernel.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        mojha@codeaurora.org, hpa@zytor.com, mingo@kernel.org,
        john.stultz@linaro.org, avagin@gmail.com, sboyd@kernel.org
Reply-To: avagin@gmail.com, john.stultz@linaro.org, mingo@kernel.org,
          sboyd@kernel.org, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, hpa@zytor.com, mojha@codeaurora.org
In-Reply-To: <20190408041542.26338-1-avagin@gmail.com>
References: <20190408041542.26338-1-avagin@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/urgent] alarmtimer: Return correct remaining time
Git-Commit-ID: 07d7e12091f4ab869cc6a4bb276399057e73b0b3
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  07d7e12091f4ab869cc6a4bb276399057e73b0b3
Gitweb:     https://git.kernel.org/tip/07d7e12091f4ab869cc6a4bb276399057e73b0b3
Author:     Andrei Vagin <avagin@gmail.com>
AuthorDate: Sun, 7 Apr 2019 21:15:42 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 10 Apr 2019 15:23:26 +0200

alarmtimer: Return correct remaining time

To calculate a remaining time, it's required to subtract the current time
from the expiration time. In alarm_timer_remaining() the arguments of
ktime_sub are swapped.

Fixes: d653d8457c76 ("alarmtimer: Implement remaining callback")
Signed-off-by: Andrei Vagin <avagin@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: John Stultz <john.stultz@linaro.org>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20190408041542.26338-1-avagin@gmail.com

---
 kernel/time/alarmtimer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index 2c97e8c2d29f..0519a8805aab 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -594,7 +594,7 @@ static ktime_t alarm_timer_remaining(struct k_itimer *timr, ktime_t now)
 {
 	struct alarm *alarm = &timr->it.alarm.alarmtimer;
 
-	return ktime_sub(now, alarm->node.expires);
+	return ktime_sub(alarm->node.expires, now);
 }
 
 /**
