Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF4FC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 08:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DB882341C
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 08:32:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="la2+M+eu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbfH2Icb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 04:32:31 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38973 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727087AbfH2Ic2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 04:32:28 -0400
Received: by mail-pf1-f194.google.com with SMTP id y200so1571078pfb.6
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 01:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k3M8uiAuXetNpwkP9uV7FXy08rtc6zGtFBjvOrw/zz4=;
        b=la2+M+eun68Ai5V5l+dVPftM47EwLer5oHtEAKclYQjMQNF10DVS+dOoYWhQy1OsIj
         +QSWj1o+V+Mhb9Q0VR2lHC7T81gk8ivVxWMKHD2d8RiMmMUPc01ceQQkWTEoPY6GWcmu
         6RUIb7y0XKExGImC/zdAxr4758JSWyDocwAZqNLa8l76d2lfho438ryi4rxR4wdFg/d1
         AhjwqLEjhlGpnGOfHHfy4d5tpGmgzvwoItdtlZYs5MoGc8zCsSqmnjAmr6VBrFOP0Hu5
         Oz4kSDqSxib/RwKKbneU5PPpjQfs+BKHhbOFcTvWwzoijlxg3aTerFOgGhNTn3/rpil5
         xBxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k3M8uiAuXetNpwkP9uV7FXy08rtc6zGtFBjvOrw/zz4=;
        b=d1zj4f55bnue5LSvXGFzau2p3rlkPt9FfID47YmWSdvuCyCk/S3Rt8yzk2cKMGRrUW
         uTzAHzaW2vYVE/eQnZQcIeMBT7NFF4rXL6176BV21kdRLqJcjwcoShJNzx8zZS0vk0yh
         d7qpHocG4LM2kTVX8Bfv1k3l5ggVtPGxjm5Nt8s6slAklowzqRq3WMJxOyIvg9iimf2q
         n/t0iO0xf8R++2RcGVLyWSop/1yGbXyfPIleHRcxPHphhkLQeNypC4GTPIYQFaZ2Sqbw
         w3U9Cm4FFkfr/fxP0ZR8he6aqb+rb6AolZkx2c4xz2uLKN5f6TJdyAdfcscBBF1BLM+B
         T+Dw==
X-Gm-Message-State: APjAAAUCq6RCuFtRQhSg8dN2nwYk1TN9tgKE/ClcfL6k47PCcGo6rocS
        Eqs2x3ConBE5lL6/qXN6VcY=
X-Google-Smtp-Source: APXvYqwOW2TBF97D5oKrX/ivHtQx0UM+j+WhcIJ2/fylzH124O93U13aZMmr/416+9a23i2/+leHoA==
X-Received: by 2002:aa7:8a0a:: with SMTP id m10mr10131373pfa.100.1567067548109;
        Thu, 29 Aug 2019 01:32:28 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id v22sm1260155pgk.69.2019.08.29.01.32.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Aug 2019 01:32:27 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        longman@redhat.com, paulmck@linux.vnet.ibm.com,
        boqun.feng@gmail.com, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v4 11/30] locking/lockdep: Remove irq-safe to irq-unsafe read check
Date:   Thu, 29 Aug 2019 16:31:13 +0800
Message-Id: <20190829083132.22394-12-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190829083132.22394-1-duyuyang@gmail.com>
References: <20190829083132.22394-1-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have a lockdep warning:

  ========================================================
  WARNING: possible irq lock inversion dependency detected
  5.1.0-rc7+ #141 Not tainted
  --------------------------------------------------------
  kworker/8:2/328 just changed the state of lock:
  0000000007f1a95b (&(&host->lock)->rlock){-...}, at: ata_bmdma_interrupt+0x27/0x1c0 [libata]
  but this lock took another, HARDIRQ-READ-unsafe lock in the past:
   (&trig->leddev_list_lock){.+.?}

and interrupts could create inverse lock ordering between them.

other info that might help us debug this:
   Possible interrupt unsafe locking scenario:

         CPU0                    CPU1
         ----                    ----
    lock(&trig->leddev_list_lock);
                                 local_irq_disable();
                                 lock(&(&host->lock)->rlock);
                                 lock(&trig->leddev_list_lock);
    <Interrupt>
      lock(&(&host->lock)->rlock);

 *** DEADLOCK ***

This splat is a false positive, which is enabled by the addition of
recursive read locks in the graph. Specifically, trig->leddev_list_lock is a
rwlock_t type, which was not in the graph before recursive read lock support
was added in lockdep.

This false positve is caused by a "false-positive" check in IRQ usage check.

In mark_lock_irq(), the following checks are currently performed:

   ----------------------------------
  |   ->      | unsafe | read unsafe |
  |----------------------------------|
  | safe      |  F  B  |    F* B*    |
  |----------------------------------|
  | read safe |  F* B* |      -      |
   ----------------------------------

Where:
F: check_usage_forwards
B: check_usage_backwards
*: check enabled by STRICT_READ_CHECKS

But actually the safe -> unsafe read dependency does not create a deadlock
scenario.

Fix this by simply removing those two checks, and since safe read -> unsafe
is indeed a problem, these checks are not actually strict per se, so remove
the macro STRICT_READ_CHECKS, and we have the following checks:

   ----------------------------------
  |   ->      | unsafe | read unsafe |
  |----------------------------------|
  | safe      |  F  B  |      -      |
  |----------------------------------|
  | read safe |  F  B  |      -      |
   ----------------------------------

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 kernel/locking/lockdep.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index acbd538..1dda9de 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -3221,8 +3221,6 @@ static int SOFTIRQ_verbose(struct lock_class *class)
 	return 0;
 }
 
-#define STRICT_READ_CHECKS	1
-
 static int (*state_verbose_f[])(struct lock_class *class) = {
 #define LOCKDEP_STATE(__STATE) \
 	__STATE##_verbose,
@@ -3268,7 +3266,7 @@ typedef int (*check_usage_f)(struct task_struct *, struct held_lock *,
 	 * Validate that the lock dependencies don't have conflicting usage
 	 * states.
 	 */
-	if ((!read || STRICT_READ_CHECKS) &&
+	if ((!read || !dir) &&
 			!usage(curr, this, excl_bit, state_name(new_bit & ~LOCK_USAGE_READ_MASK)))
 		return 0;
 
@@ -3279,7 +3277,7 @@ typedef int (*check_usage_f)(struct task_struct *, struct held_lock *,
 		if (!valid_state(curr, this, new_bit, excl_bit + LOCK_USAGE_READ_MASK))
 			return 0;
 
-		if (STRICT_READ_CHECKS &&
+		if (dir &&
 			!usage(curr, this, excl_bit + LOCK_USAGE_READ_MASK,
 				state_name(new_bit + LOCK_USAGE_READ_MASK)))
 			return 0;
-- 
1.8.3.1

