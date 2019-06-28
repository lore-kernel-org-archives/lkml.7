Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9931AC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 09:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63DC5208CB
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 09:18:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W1fXxgpa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbfF1JSA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 05:18:00 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45109 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbfF1JR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 05:17:57 -0400
Received: by mail-pf1-f193.google.com with SMTP id r1so2652661pfq.12
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 02:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kx50gKxxvtisjg2F9jTuTtWq9FlFRr48sDE6Gi1A0+k=;
        b=W1fXxgpa2QJmCiq0E/w5BYay+5rnTBm7AlUrJnOR69m2kZJVJTxibswftMXUZH9Nz9
         2M5VerT/2/t9Hb/RwULHuBcwHXDD2K+yi0hZGhZdhlSfZXUKV+nPZgRccHQzfNt2n5j4
         d7iwpNdXM1L52U3h+QJelMxmHL2TWk1AcKcM/NynCHSG7/B1OGG/g7zvzkgOkE3LQbmx
         PASUcNdRlxAjVx13w7mZqxV/jXXXUAHeZdz/JO4mVTlY95AfNAlPsUhF/BH4nY8HFrvv
         QSY2t7CO67m53JdmjfMd7jl22cpCRHDbFk42JBn5TbGn/YmHh43kKXnD1FqWQ2nSzLj/
         VVOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kx50gKxxvtisjg2F9jTuTtWq9FlFRr48sDE6Gi1A0+k=;
        b=D1lIbfbUziaqVXFolZLhC21WLY9s0UfvIoJNdu7+2xOqa3JMyn5gYbIDHZoEbQ1Nd2
         XFXtrCFn4khkLy0KKU6KS82fj9lN6zMLttL+WW90CC+G3Xsowiykalh6HhUiz2Crt8N/
         e1iD3eOY9mPjkof/FcGlqPgFBbErszHX6aSEHrP6OnTL594d/BzIH1ojXuodj0EUTVco
         VRplYVzuLQwRS4py0vNGFVye539QuF2FY1SIq4eEdwPdQArWFaJuKStRDTD8ALw97Egg
         6M6BegUPpFYWNI5POm5RLylDZME3nfmxgsGElu9l7vZaJ19q4VkbA/2fJkNFjstV3a7o
         Ygkg==
X-Gm-Message-State: APjAAAVbkRpzrEwVNBv+Hw2bbQQVs8XEwvPWN3qc3W4zHD2IBr0UTiWq
        2cDpdbUMX7+c0VY3yq4/vBs=
X-Google-Smtp-Source: APXvYqyZ0TkA/PFv5rMHPnbFiMqpVk10f2MJQ4ofipgVEqOaxKvhOPTTdjBoxl8L8VbHB+puLEGxwQ==
X-Received: by 2002:a63:6155:: with SMTP id v82mr8132865pgb.304.1561713476075;
        Fri, 28 Jun 2019 02:17:56 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id x65sm1754521pfd.139.2019.06.28.02.17.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2019 02:17:55 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        longman@redhat.com, paulmck@linux.vnet.ibm.com,
        boqun.feng@gmail.com, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v3 30/30] locking/lockdep: Remove irq-safe to irq-unsafe read check
Date:   Fri, 28 Jun 2019 17:15:28 +0800
Message-Id: <20190628091528.17059-31-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190628091528.17059-1-duyuyang@gmail.com>
References: <20190628091528.17059-1-duyuyang@gmail.com>
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
index c7ba647..d12ab0e 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -3558,8 +3558,6 @@ static int SOFTIRQ_verbose(struct lock_class *class)
 	return 0;
 }
 
-#define STRICT_READ_CHECKS	1
-
 static int (*state_verbose_f[])(struct lock_class *class) = {
 #define LOCKDEP_STATE(__STATE) \
 	__STATE##_verbose,
@@ -3605,7 +3603,7 @@ typedef int (*check_usage_f)(struct task_struct *, struct held_lock *,
 	 * Validate that the lock dependencies don't have conflicting usage
 	 * states.
 	 */
-	if ((!read || STRICT_READ_CHECKS) &&
+	if ((!read || !dir) &&
 			!usage(curr, this, excl_bit, state_name(new_bit & ~LOCK_USAGE_READ_MASK)))
 		return 0;
 
@@ -3616,7 +3614,7 @@ typedef int (*check_usage_f)(struct task_struct *, struct held_lock *,
 		if (!valid_state(curr, this, new_bit, excl_bit + LOCK_USAGE_READ_MASK))
 			return 0;
 
-		if (STRICT_READ_CHECKS &&
+		if (dir &&
 			!usage(curr, this, excl_bit + LOCK_USAGE_READ_MASK,
 				state_name(new_bit + LOCK_USAGE_READ_MASK)))
 			return 0;
-- 
1.8.3.1

