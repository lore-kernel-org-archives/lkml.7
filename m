Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA564C04E84
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 08:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65DAF2089E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 08:01:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bSrlzhhM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbfEPIBZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 04:01:25 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34486 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbfEPIBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 04:01:24 -0400
Received: by mail-pg1-f194.google.com with SMTP id c13so1174243pgt.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 01:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Sq2YROOG33D+u2oBi0Lgr2XAulwfC9GYtiKatyA1xOs=;
        b=bSrlzhhMwBpQBQXKjnZlbAg/vnr5pwaiYuEH8pV1TQZNY2YiptYkc4UTPWn/fo6jzb
         b+or5p2NMw7B793zcbrKaL0IBpygyfctAYMA7wCEMNC3z2KKRvtdmqWdv9aYzAk9Wclr
         HjMnX0hwdwGAteJiGeAvzgEhTpMnLF09sRQxFRStRTNYC8fciBGNTX0scVs9c898jcTd
         ks8GoEk8V5EaJc7U9vxSbTcYl3YG3oI40aAlLmaD2v2aMNb3kblkfr5PjhAC8FGxSzvh
         GRe3Fa7E5NMAUyD3hNZG7If3s2bIF/WdZ18KpXfwKa30Rx/YCttyfXOGVNA+SH88eiXI
         IZJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Sq2YROOG33D+u2oBi0Lgr2XAulwfC9GYtiKatyA1xOs=;
        b=BG+RXfdHjYgXs7vgwh+i6+7qHocSPinHzS95DlkTttnceKabbZGzjae1o/rcW+MHr6
         RFPB8DxtiguGGXgunU1SnDEGGNE6Aav5sylzEud+Db+Dmzy6DOJCaV0Z5iUZS9NgWrGv
         HpjLyl8LatcdV74ehgfNrl6mwnQ+HIDZwI3z8JQBWE9a11G+UF7uBktuFJ4iKvI24diq
         yf9PEcyw9iHeMin5N33m+7cgdWiDSEynl7o3Rf2QSe273A68heEjXsRc6xrH2OOnOmbh
         tg79bY8Ol/sWKjVdMLl6T66fJVL6vLzQVGLGRQt+ptpSZgGsNzZyOpu47I+9GJMMCeQm
         WHng==
X-Gm-Message-State: APjAAAUlofGHZwY+Ku2eBbUiS00FsXuTI7wyAuLks2ZT4lsbnldnNDTK
        Mhu2Ynix9rBnkm5jZiYrCqM=
X-Google-Smtp-Source: APXvYqzn+wmwK6je9NEpVlpTtVOb7EuTOcpZwZSK3MkffSWea6Mn3gSfhlw9lL6kbDSseFeX3bnI1w==
X-Received: by 2002:aa7:8e0d:: with SMTP id c13mr53533990pfr.193.1557993683860;
        Thu, 16 May 2019 01:01:23 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id p7sm2051471pgb.92.2019.05.16.01.01.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 01:01:23 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, boqun.feng@gmail.com, paulmck@linux.ibm.com,
        linux-kernel@vger.kernel.org, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v2 17/17] locking/lockdep: Remove irq-safe to irq-unsafe read check
Date:   Thu, 16 May 2019 16:00:15 +0800
Message-Id: <20190516080015.16033-18-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190516080015.16033-1-duyuyang@gmail.com>
References: <20190516080015.16033-1-duyuyang@gmail.com>
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
index cd1d515..bc36fbf 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -3450,8 +3450,6 @@ static int SOFTIRQ_verbose(struct lock_class *class)
 	return 0;
 }
 
-#define STRICT_READ_CHECKS	1
-
 static int (*state_verbose_f[])(struct lock_class *class) = {
 #define LOCKDEP_STATE(__STATE) \
 	__STATE##_verbose,
@@ -3497,7 +3495,7 @@ typedef int (*check_usage_f)(struct task_struct *, struct held_lock *,
 	 * Validate that the lock dependencies don't have conflicting usage
 	 * states.
 	 */
-	if ((!read || STRICT_READ_CHECKS) &&
+	if ((!read || !dir) &&
 			!usage(curr, this, excl_bit, state_name(new_bit & ~LOCK_USAGE_READ_MASK)))
 		return 0;
 
@@ -3508,7 +3506,7 @@ typedef int (*check_usage_f)(struct task_struct *, struct held_lock *,
 		if (!valid_state(curr, this, new_bit, excl_bit + LOCK_USAGE_READ_MASK))
 			return 0;
 
-		if (STRICT_READ_CHECKS &&
+		if (dir &&
 			!usage(curr, this, excl_bit + LOCK_USAGE_READ_MASK,
 				state_name(new_bit + LOCK_USAGE_READ_MASK)))
 			return 0;
-- 
1.8.3.1

