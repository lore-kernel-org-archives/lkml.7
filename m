Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81649C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 15:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A10320714
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 15:57:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R/OI2aqO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732064AbfKTP5g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 10:57:36 -0500
Received: from mail-wm1-f73.google.com ([209.85.128.73]:52386 "EHLO
        mail-wm1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729198AbfKTP5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 10:57:36 -0500
Received: by mail-wm1-f73.google.com with SMTP id x16so5459991wmk.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 07:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=KDvfqn9QURm+KEF2yectv0d+1MEDhuQ1dR+OnEQyAsI=;
        b=R/OI2aqOJID2PpeKdWzROqw3canFAEDDaWXZPjuP5r4HI1DtMo8mpK/dbh8YOe1rK4
         0N4pxvRXYJX8TBZRhM/iNzgrmpyIUUuCutogT6J8lJ6hzF2LXIFsbdUTOAREEqXEr7mU
         TpaUjPmlRTFutGGCRs2K6jg17p+IDvK3XvCWSK6n+ueCgav1Gwh80pxs807Iyqb7HWef
         0rVzAXToE2nysrO0yiEJyAdUzjeBbudmwaqK5jXsipZoqsrn6/lJFVSA2akDUFCTQ2Pu
         DyO4I91iKEV+GiY/11G0alfgrVRg2n443ueay4pS+Rimnd5u3CcNhRHTE06gcXGJsrzx
         p3dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=KDvfqn9QURm+KEF2yectv0d+1MEDhuQ1dR+OnEQyAsI=;
        b=muzmRBOp3OmFdeKq5B5qkhEG7zJO/YkPPEuVQBGChh+eoBfetbBPU5NuAbGjS/nG4u
         W6pOFdbW52XYq17sBKJSSo9ctHXrzTnXJO4CJSuSk3LfQ+QnHTHBvTyw6kjqMSTLDumH
         bvep0GK+SYHEPtMFN5dOC6rJZ1TwfOMYjUH4MzhTou1hWOcBKN1zsSDExyzlEv86z8KX
         LTCpy/tBWm3QTXAd6VAkQ7HF3H2bXB/3vQo58jLMDalN3QFp89WbtShpOT4/PQfnz96t
         MrpyuL1loIpLOhBaKD+waXZKneKG8xmqw42RGKcKuLnBcJ+6Lq3POY9k8WQngDlp4ort
         4gGg==
X-Gm-Message-State: APjAAAUa7b8we02ARMyuLJfweFeB4tDnGbTxl8ZSF34Yih1mewwaeLvm
        XQEmiB2Y/ijBiS6Rq5yTrM+HpNUEIQ==
X-Google-Smtp-Source: APXvYqzjvj0OuyZipX3zEcxwwcP46Kfl3Y0SMZPzthCRX+xjarNLAaeDn+HLIVIOgZUI3y2FMtrOjLvSOQ==
X-Received: by 2002:adf:ec44:: with SMTP id w4mr4456350wrn.274.1574265453254;
 Wed, 20 Nov 2019 07:57:33 -0800 (PST)
Date:   Wed, 20 Nov 2019 16:57:15 +0100
Message-Id: <20191120155715.28089-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: [PATCH] spinlock_debug: Fix various data races
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes various data races in spinlock_debug. By testing with KCSAN,
it is observable that the console gets spammed with data races reports,
suggesting these are extremely frequent.

Example data race report:

read to 0xffff8ab24f403c48 of 4 bytes by task 221 on cpu 2:
 debug_spin_lock_before kernel/locking/spinlock_debug.c:85 [inline]
 do_raw_spin_lock+0x9b/0x210 kernel/locking/spinlock_debug.c:112
 __raw_spin_lock include/linux/spinlock_api_smp.h:143 [inline]
 _raw_spin_lock+0x39/0x40 kernel/locking/spinlock.c:151
 spin_lock include/linux/spinlock.h:338 [inline]
 get_partial_node.isra.0.part.0+0x32/0x2f0 mm/slub.c:1873
 get_partial_node mm/slub.c:1870 [inline]
<snip>

write to 0xffff8ab24f403c48 of 4 bytes by task 167 on cpu 3:
 debug_spin_unlock kernel/locking/spinlock_debug.c:103 [inline]
 do_raw_spin_unlock+0xc9/0x1a0 kernel/locking/spinlock_debug.c:138
 __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:159 [inline]
 _raw_spin_unlock_irqrestore+0x2d/0x50 kernel/locking/spinlock.c:191
 spin_unlock_irqrestore include/linux/spinlock.h:393 [inline]
 free_debug_processing+0x1b3/0x210 mm/slub.c:1214
 __slab_free+0x292/0x400 mm/slub.c:2864
<snip>

As a side-effect, with KCSAN, this eventually locks up the console, most
likely due to deadlock, e.g. .. -> printk lock -> spinlock_debug ->
KCSAN detects data race -> kcsan_print_report() -> printk lock ->
deadlock.

This fix will 1) avoid the data races, and 2) allow using lock debugging
together with KCSAN.

Signed-off-by: Marco Elver <elver@google.com>
Reported-by: Qian Cai <cai@lca.pw>
---
 kernel/locking/spinlock_debug.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/kernel/locking/spinlock_debug.c b/kernel/locking/spinlock_debug.c
index 399669f7eba8..472dd462a40c 100644
--- a/kernel/locking/spinlock_debug.c
+++ b/kernel/locking/spinlock_debug.c
@@ -51,19 +51,19 @@ EXPORT_SYMBOL(__rwlock_init);
 
 static void spin_dump(raw_spinlock_t *lock, const char *msg)
 {
-	struct task_struct *owner = NULL;
+	struct task_struct *owner = READ_ONCE(lock->owner);
 
-	if (lock->owner && lock->owner != SPINLOCK_OWNER_INIT)
-		owner = lock->owner;
+	if (owner == SPINLOCK_OWNER_INIT)
+		owner = NULL;
 	printk(KERN_EMERG "BUG: spinlock %s on CPU#%d, %s/%d\n",
 		msg, raw_smp_processor_id(),
 		current->comm, task_pid_nr(current));
 	printk(KERN_EMERG " lock: %pS, .magic: %08x, .owner: %s/%d, "
 			".owner_cpu: %d\n",
-		lock, lock->magic,
+		lock, READ_ONCE(lock->magic),
 		owner ? owner->comm : "<none>",
 		owner ? task_pid_nr(owner) : -1,
-		lock->owner_cpu);
+		READ_ONCE(lock->owner_cpu));
 	dump_stack();
 }
 
@@ -80,16 +80,16 @@ static void spin_bug(raw_spinlock_t *lock, const char *msg)
 static inline void
 debug_spin_lock_before(raw_spinlock_t *lock)
 {
-	SPIN_BUG_ON(lock->magic != SPINLOCK_MAGIC, lock, "bad magic");
-	SPIN_BUG_ON(lock->owner == current, lock, "recursion");
-	SPIN_BUG_ON(lock->owner_cpu == raw_smp_processor_id(),
+	SPIN_BUG_ON(READ_ONCE(lock->magic) != SPINLOCK_MAGIC, lock, "bad magic");
+	SPIN_BUG_ON(READ_ONCE(lock->owner) == current, lock, "recursion");
+	SPIN_BUG_ON(READ_ONCE(lock->owner_cpu) == raw_smp_processor_id(),
 							lock, "cpu recursion");
 }
 
 static inline void debug_spin_lock_after(raw_spinlock_t *lock)
 {
-	lock->owner_cpu = raw_smp_processor_id();
-	lock->owner = current;
+	WRITE_ONCE(lock->owner_cpu, raw_smp_processor_id());
+	WRITE_ONCE(lock->owner, current);
 }
 
 static inline void debug_spin_unlock(raw_spinlock_t *lock)
@@ -99,8 +99,8 @@ static inline void debug_spin_unlock(raw_spinlock_t *lock)
 	SPIN_BUG_ON(lock->owner != current, lock, "wrong owner");
 	SPIN_BUG_ON(lock->owner_cpu != raw_smp_processor_id(),
 							lock, "wrong CPU");
-	lock->owner = SPINLOCK_OWNER_INIT;
-	lock->owner_cpu = -1;
+	WRITE_ONCE(lock->owner, SPINLOCK_OWNER_INIT);
+	WRITE_ONCE(lock->owner_cpu, -1);
 }
 
 /*
@@ -187,8 +187,8 @@ static inline void debug_write_lock_before(rwlock_t *lock)
 
 static inline void debug_write_lock_after(rwlock_t *lock)
 {
-	lock->owner_cpu = raw_smp_processor_id();
-	lock->owner = current;
+	WRITE_ONCE(lock->owner_cpu, raw_smp_processor_id());
+	WRITE_ONCE(lock->owner, current);
 }
 
 static inline void debug_write_unlock(rwlock_t *lock)
@@ -197,8 +197,8 @@ static inline void debug_write_unlock(rwlock_t *lock)
 	RWLOCK_BUG_ON(lock->owner != current, lock, "wrong owner");
 	RWLOCK_BUG_ON(lock->owner_cpu != raw_smp_processor_id(),
 							lock, "wrong CPU");
-	lock->owner = SPINLOCK_OWNER_INIT;
-	lock->owner_cpu = -1;
+	WRITE_ONCE(lock->owner, SPINLOCK_OWNER_INIT);
+	WRITE_ONCE(lock->owner_cpu, -1);
 }
 
 void do_raw_write_lock(rwlock_t *lock)
-- 
2.24.0.432.g9d3f5f5b63-goog

