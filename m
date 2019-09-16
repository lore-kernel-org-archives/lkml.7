Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A44C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 13:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2BC921881
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 13:37:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733302AbfIPNh6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 09:37:58 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39254 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733264AbfIPNh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 09:37:57 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i9rCV-0006vZ-SQ; Mon, 16 Sep 2019 15:37:55 +0200
Date:   Mon, 16 Sep 2019 13:30:20 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] timers/urgent for 5.4-rc1
References: <156864062018.3407.16580572772546914005.tglx@nanos.tec.linutronix.de>
Message-ID: <156864062018.3407.10822767012822306757.tglx@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest timers-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-for-linus

up to:  f18ddc13af98: alarmtimer: Use EOPNOTSUPP instead of ENOTSUPP

A single fix to prevent the alarm timer code from returning ENOTSUPP to
user space. ENOTSUPP is a purely kernel internal error code related to
NFSv3 and should never be handed back to user space. The risk for ABI
breakage is low as the number of systems which do not have a working RTC is
very limited.

Thanks,

	tglx

------------------>
Thadeu Lima de Souza Cascardo (1):
      alarmtimer: Use EOPNOTSUPP instead of ENOTSUPP


 kernel/time/alarmtimer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index 57518efc3810..b7d75a9e8ccf 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -672,7 +672,7 @@ static int alarm_timer_create(struct k_itimer *new_timer)
 	enum  alarmtimer_type type;
 
 	if (!alarmtimer_get_rtcdev())
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 
 	if (!capable(CAP_WAKE_ALARM))
 		return -EPERM;
@@ -790,7 +790,7 @@ static int alarm_timer_nsleep(const clockid_t which_clock, int flags,
 	int ret = 0;
 
 	if (!alarmtimer_get_rtcdev())
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 
 	if (flags & ~TIMER_ABSTIME)
 		return -EINVAL;


