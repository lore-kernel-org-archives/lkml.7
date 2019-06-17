Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B07CC31E50
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAA262084B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:17:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="NqS8nYiJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbfFQORc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 10:17:32 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51747 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfFQORc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 10:17:32 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5HEHJ7q3452569
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 17 Jun 2019 07:17:19 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5HEHJ7q3452569
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560781039;
        bh=IhSRg6Q/GvLXffLEpoF6WB6zBoZ9J4LxYzZ3dB/FoE0=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=NqS8nYiJ7IrKMEeY3+8hhw304IYNIwCaOGpVz1W84EU/jZ0EtP5RUa+q0fHotZYw3
         HzJ1aV7eNdBpXLSpoF4kAZTuv9fT10xSXpKMbddXmY5RyC6btlYh5M+gibbeMnlTk7
         CVY3vzIJXYvoKj8SHPuxlfNQ1csiub4tZKvigNlr5HgPYs2G/pGe1E1UC5vnPbQiz6
         adS2+aLqbOxAzoqF9SqaivI70fSn7+DFwd4w3N/FRnToVkKosnPGFgetwlun/gFFte
         teDn9QmdkKZ4FnP9rYjjcFVjZLF19jJoExw138ePoi2WbRKg3hcaGgkVlLih7oAeBm
         cnORZhmXKt7KQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5HEHJpo3452566;
        Mon, 17 Jun 2019 07:17:19 -0700
Date:   Mon, 17 Jun 2019 07:17:19 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Nikolay Borisov <tipbot@zytor.com>
Message-ID: <tip-9ffbe8ac05dbb4ab4a4836a55a47fc6be945a38f@git.kernel.org>
Cc:     peterz@infradead.org, hpa@zytor.com, torvalds@linux-foundation.org,
        mingo@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        nborisov@suse.com
Reply-To: nborisov@suse.com, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, hpa@zytor.com,
          peterz@infradead.org, torvalds@linux-foundation.org,
          mingo@kernel.org
In-Reply-To: <20190531100651.3969-1-nborisov@suse.com>
References: <20190531100651.3969-1-nborisov@suse.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/lockdep: Rename
 lockdep_assert_held_exclusive() -> lockdep_assert_held_write()
Git-Commit-ID: 9ffbe8ac05dbb4ab4a4836a55a47fc6be945a38f
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

Commit-ID:  9ffbe8ac05dbb4ab4a4836a55a47fc6be945a38f
Gitweb:     https://git.kernel.org/tip/9ffbe8ac05dbb4ab4a4836a55a47fc6be945a38f
Author:     Nikolay Borisov <nborisov@suse.com>
AuthorDate: Fri, 31 May 2019 13:06:51 +0300
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 17 Jun 2019 12:09:24 +0200

locking/lockdep: Rename lockdep_assert_held_exclusive() -> lockdep_assert_held_write()

All callers of lockdep_assert_held_exclusive() use it to verify the
correct locking state of either a semaphore (ldisc_sem in tty,
mmap_sem for perf events, i_rwsem of inode for dax) or rwlock by
apparmor. Thus it makes sense to rename _exclusive to _write since
that's the semantics callers care. Additionally there is already
lockdep_assert_held_read(), which this new naming is more consistent with.

No functional changes.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190531100651.3969-1-nborisov@suse.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/core.c           | 2 +-
 drivers/infiniband/core/device.c | 2 +-
 drivers/tty/tty_ldisc.c          | 8 ++++----
 fs/dax.c                         | 2 +-
 include/linux/lockdep.h          | 4 ++--
 security/apparmor/label.c        | 8 ++++----
 6 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index f315425d8468..cf91d80b8452 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2179,7 +2179,7 @@ static void x86_pmu_event_mapped(struct perf_event *event, struct mm_struct *mm)
 	 * For now, this can't happen because all callers hold mmap_sem
 	 * for write.  If this changes, we'll need a different solution.
 	 */
-	lockdep_assert_held_exclusive(&mm->mmap_sem);
+	lockdep_assert_held_write(&mm->mmap_sem);
 
 	if (atomic_inc_return(&mm->context.perf_rdpmc_allowed) == 1)
 		on_each_cpu_mask(mm_cpumask(mm), refresh_pce, NULL, 1);
diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 29f7b15c81d9..d020bb4d03d5 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -457,7 +457,7 @@ static int alloc_name(struct ib_device *ibdev, const char *name)
 	int rc;
 	int i;
 
-	lockdep_assert_held_exclusive(&devices_rwsem);
+	lockdep_assert_held_write(&devices_rwsem);
 	ida_init(&inuse);
 	xa_for_each (&devices, index, device) {
 		char buf[IB_DEVICE_NAME_MAX];
diff --git a/drivers/tty/tty_ldisc.c b/drivers/tty/tty_ldisc.c
index e38f104db174..fde8d4073e74 100644
--- a/drivers/tty/tty_ldisc.c
+++ b/drivers/tty/tty_ldisc.c
@@ -487,7 +487,7 @@ static int tty_ldisc_open(struct tty_struct *tty, struct tty_ldisc *ld)
 
 static void tty_ldisc_close(struct tty_struct *tty, struct tty_ldisc *ld)
 {
-	lockdep_assert_held_exclusive(&tty->ldisc_sem);
+	lockdep_assert_held_write(&tty->ldisc_sem);
 	WARN_ON(!test_bit(TTY_LDISC_OPEN, &tty->flags));
 	clear_bit(TTY_LDISC_OPEN, &tty->flags);
 	if (ld->ops->close)
@@ -509,7 +509,7 @@ static int tty_ldisc_failto(struct tty_struct *tty, int ld)
 	struct tty_ldisc *disc = tty_ldisc_get(tty, ld);
 	int r;
 
-	lockdep_assert_held_exclusive(&tty->ldisc_sem);
+	lockdep_assert_held_write(&tty->ldisc_sem);
 	if (IS_ERR(disc))
 		return PTR_ERR(disc);
 	tty->ldisc = disc;
@@ -633,7 +633,7 @@ EXPORT_SYMBOL_GPL(tty_set_ldisc);
  */
 static void tty_ldisc_kill(struct tty_struct *tty)
 {
-	lockdep_assert_held_exclusive(&tty->ldisc_sem);
+	lockdep_assert_held_write(&tty->ldisc_sem);
 	if (!tty->ldisc)
 		return;
 	/*
@@ -681,7 +681,7 @@ int tty_ldisc_reinit(struct tty_struct *tty, int disc)
 	struct tty_ldisc *ld;
 	int retval;
 
-	lockdep_assert_held_exclusive(&tty->ldisc_sem);
+	lockdep_assert_held_write(&tty->ldisc_sem);
 	ld = tty_ldisc_get(tty, disc);
 	if (IS_ERR(ld)) {
 		BUG_ON(disc == N_TTY);
diff --git a/fs/dax.c b/fs/dax.c
index 2e48c7ebb973..bf8686d48b2d 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1188,7 +1188,7 @@ dax_iomap_rw(struct kiocb *iocb, struct iov_iter *iter,
 	unsigned flags = 0;
 
 	if (iov_iter_rw(iter) == WRITE) {
-		lockdep_assert_held_exclusive(&inode->i_rwsem);
+		lockdep_assert_held_write(&inode->i_rwsem);
 		flags |= IOMAP_WRITE;
 	} else {
 		lockdep_assert_held(&inode->i_rwsem);
diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 30a0f81aa130..151d55711082 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -394,7 +394,7 @@ extern void lock_unpin_lock(struct lockdep_map *lock, struct pin_cookie);
 		WARN_ON(debug_locks && !lockdep_is_held(l));	\
 	} while (0)
 
-#define lockdep_assert_held_exclusive(l)	do {			\
+#define lockdep_assert_held_write(l)	do {			\
 		WARN_ON(debug_locks && !lockdep_is_held_type(l, 0));	\
 	} while (0)
 
@@ -479,7 +479,7 @@ struct lockdep_map { };
 #define lockdep_is_held_type(l, r)		(1)
 
 #define lockdep_assert_held(l)			do { (void)(l); } while (0)
-#define lockdep_assert_held_exclusive(l)	do { (void)(l); } while (0)
+#define lockdep_assert_held_write(l)	do { (void)(l); } while (0)
 #define lockdep_assert_held_read(l)		do { (void)(l); } while (0)
 #define lockdep_assert_held_once(l)		do { (void)(l); } while (0)
 
diff --git a/security/apparmor/label.c b/security/apparmor/label.c
index 068e93c5d29c..59f1cc2557a7 100644
--- a/security/apparmor/label.c
+++ b/security/apparmor/label.c
@@ -76,7 +76,7 @@ void __aa_proxy_redirect(struct aa_label *orig, struct aa_label *new)
 
 	AA_BUG(!orig);
 	AA_BUG(!new);
-	lockdep_assert_held_exclusive(&labels_set(orig)->lock);
+	lockdep_assert_held_write(&labels_set(orig)->lock);
 
 	tmp = rcu_dereference_protected(orig->proxy->label,
 					&labels_ns(orig)->lock);
@@ -566,7 +566,7 @@ static bool __label_remove(struct aa_label *label, struct aa_label *new)
 
 	AA_BUG(!ls);
 	AA_BUG(!label);
-	lockdep_assert_held_exclusive(&ls->lock);
+	lockdep_assert_held_write(&ls->lock);
 
 	if (new)
 		__aa_proxy_redirect(label, new);
@@ -603,7 +603,7 @@ static bool __label_replace(struct aa_label *old, struct aa_label *new)
 	AA_BUG(!ls);
 	AA_BUG(!old);
 	AA_BUG(!new);
-	lockdep_assert_held_exclusive(&ls->lock);
+	lockdep_assert_held_write(&ls->lock);
 	AA_BUG(new->flags & FLAG_IN_TREE);
 
 	if (!label_is_stale(old))
@@ -640,7 +640,7 @@ static struct aa_label *__label_insert(struct aa_labelset *ls,
 	AA_BUG(!ls);
 	AA_BUG(!label);
 	AA_BUG(labels_set(label) != ls);
-	lockdep_assert_held_exclusive(&ls->lock);
+	lockdep_assert_held_write(&ls->lock);
 	AA_BUG(label->flags & FLAG_IN_TREE);
 
 	/* Figure out where to put new node */
