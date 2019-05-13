Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D03C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 09:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B712621479
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 09:14:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gz/tnqju"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728806AbfEMJOQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 05:14:16 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44379 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728793AbfEMJOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 05:14:14 -0400
Received: by mail-pf1-f195.google.com with SMTP id g9so6850860pfo.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 02:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XquRGMdkWaM/DcOHkh5rTCme/nLS8Vh3kbKhYIl4Twg=;
        b=gz/tnqjukIUD4RWThkSaxWdDlmQh8HywQm3QrUdGpOG5v4q6hy+r35pZBmCLpNBvP1
         VysEnCoJv098YRymkvsVjA+XH6rkRFBQXsGU1til8+7jkjk23m0Zn+foSPF25SDsT2lG
         fGDmhPTdzTFzZTSiuS9neZvUS96xjKdCie9CQdRMtOuH4K9VNuALxjoiGObDmNYBlu6i
         Sde909IVUyXG1EYqxDALrJ2m4pKXKNO3slb58x2WrxBcnjvi3Q9efNZLmiG8d9WK6IAx
         FNIxQPYHLSDb+zGFh7HJrH4a8OMPz4Xn6b+wLFGQsLbn4RnpNt8hEU+DeNezPjNHWa7O
         E+DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XquRGMdkWaM/DcOHkh5rTCme/nLS8Vh3kbKhYIl4Twg=;
        b=BPBV+RWSMQOCwWUouEQH00d4CVhEBEke3a+cQwVUb/dYEgMXXgE3GXIbUsL5/1ETu6
         AgE1/6i5irEkkEzT8YC6k7ClJq+Dt+/RK9A7waXrAUJCjXd1IyNvea64tvDbhhvbdI0q
         CTbje8DYn6MIER+bLbSk/WH134zfgrwcBT94G3iQABXqfyQ0TlsvpxcpqHq9nbsXQulF
         BE5z4M1Ib07q9S8cFtDCXfrnI2YyWp/CaG9oenvIO8mC5arbwHcYuD9Rf1ixfPviu+UI
         nQrILEmJq36nl1hVbIxwb2gkVdgcbluOGe4kIUP7gFfdkr5mYnL3pbHXxrOHAbelkCzx
         JEPw==
X-Gm-Message-State: APjAAAWbFI9ZnCxPHI3Q1TZZV+Lt5Il/6CjPX53ire+n5Dng1vU+w42e
        4tBlYqh3Ium8drrgeCqBr2Y=
X-Google-Smtp-Source: APXvYqz8fg/gOGGQGPxmA0dBWWM80ayKbjIJVuacCPFHtBhjL6BeE6RM5qbjIOHO3/l/cj41qDHI0Q==
X-Received: by 2002:a63:555a:: with SMTP id f26mr29982607pgm.197.1557738853804;
        Mon, 13 May 2019 02:14:13 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id n18sm35500837pfi.48.2019.05.13.02.14.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 02:14:13 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, boqun.feng@gmail.com,
        linux-kernel@vger.kernel.org, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH 17/17] locking/lockdep: Remove irq-safe to irq-unsafe read check
Date:   Mon, 13 May 2019 17:12:03 +0800
Message-Id: <20190513091203.7299-18-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190513091203.7299-1-duyuyang@gmail.com>
References: <20190513091203.7299-1-duyuyang@gmail.com>
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
index 69d6bd6..62b454c 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -3446,8 +3446,6 @@ static int SOFTIRQ_verbose(struct lock_class *class)
 	return 0;
 }
 
-#define STRICT_READ_CHECKS	1
-
 static int (*state_verbose_f[])(struct lock_class *class) = {
 #define LOCKDEP_STATE(__STATE) \
 	__STATE##_verbose,
@@ -3493,7 +3491,7 @@ typedef int (*check_usage_f)(struct task_struct *, struct held_lock *,
 	 * Validate that the lock dependencies don't have conflicting usage
 	 * states.
 	 */
-	if ((!read || STRICT_READ_CHECKS) &&
+	if ((!read || !dir) &&
 			!usage(curr, this, excl_bit, state_name(new_bit & ~LOCK_USAGE_READ_MASK)))
 		return 0;
 
@@ -3504,7 +3502,7 @@ typedef int (*check_usage_f)(struct task_struct *, struct held_lock *,
 		if (!valid_state(curr, this, new_bit, excl_bit + LOCK_USAGE_READ_MASK))
 			return 0;
 
-		if (STRICT_READ_CHECKS &&
+		if (dir &&
 			!usage(curr, this, excl_bit + LOCK_USAGE_READ_MASK,
 				state_name(new_bit + LOCK_USAGE_READ_MASK)))
 			return 0;
-- 
1.8.3.1

