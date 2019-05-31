Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B2EFC04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 10:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56142266EB
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 10:06:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbfEaKG4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 06:06:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:40054 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726002AbfEaKG4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 06:06:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 15D9AAF4C;
        Fri, 31 May 2019 10:06:54 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     peterz@infradead.org
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] lockdep: Rename lockdep_assert_held_exclusive -> lockdep_assert_held_write
Date:   Fri, 31 May 2019 13:06:51 +0300
Message-Id: <20190531100651.3969-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All callers of lockdep_assert_held_exclusive use it to verify the
correct locking state of either a semaphore (ldisc_sem in tty,
mmap_sem for perf events, i_rwsem of inode for dax) or rwlock by
apparmor. Thus it makes sense to rename _exclusive to _write since
that's the semantics callers care. Additionally there is already
locdep_assert_held_read, this bring asymmetry to the naming.

No functional changes.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
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
index 78dc07c6ac4b..bbf72f995d1b 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -440,7 +440,7 @@ static int alloc_name(struct ib_device *ibdev, const char *name)
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
index f74386293632..1224275f79d7 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1196,7 +1196,7 @@ dax_iomap_rw(struct kiocb *iocb, struct iov_iter *iter,
 	unsigned flags = 0;
 
 	if (iov_iter_rw(iter) == WRITE) {
-		lockdep_assert_held_exclusive(&inode->i_rwsem);
+		lockdep_assert_held_write(&inode->i_rwsem);
 		flags |= IOMAP_WRITE;
 	} else {
 		lockdep_assert_held(&inode->i_rwsem);
diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 6e2377e6c1d6..d6d6a857fe52 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -385,7 +385,7 @@ extern void lock_unpin_lock(struct lockdep_map *lock, struct pin_cookie);
 		WARN_ON(debug_locks && !lockdep_is_held(l));	\
 	} while (0)
 
-#define lockdep_assert_held_exclusive(l)	do {			\
+#define lockdep_assert_held_write(l)	do {			\
 		WARN_ON(debug_locks && !lockdep_is_held_type(l, 0));	\
 	} while (0)
 
@@ -466,7 +466,7 @@ struct lockdep_map { };
 #define lockdep_is_held_type(l, r)		(1)
 
 #define lockdep_assert_held(l)			do { (void)(l); } while (0)
-#define lockdep_assert_held_exclusive(l)	do { (void)(l); } while (0)
+#define lockdep_assert_held_write(l)	do { (void)(l); } while (0)
 #define lockdep_assert_held_read(l)		do { (void)(l); } while (0)
 #define lockdep_assert_held_once(l)		do { (void)(l); } while (0)
 
diff --git a/security/apparmor/label.c b/security/apparmor/label.c
index ba11bdf9043a..3cab01eec805 100644
--- a/security/apparmor/label.c
+++ b/security/apparmor/label.c
@@ -80,7 +80,7 @@ void __aa_proxy_redirect(struct aa_label *orig, struct aa_label *new)
 
 	AA_BUG(!orig);
 	AA_BUG(!new);
-	lockdep_assert_held_exclusive(&labels_set(orig)->lock);
+	lockdep_assert_held_write(&labels_set(orig)->lock);
 
 	tmp = rcu_dereference_protected(orig->proxy->label,
 					&labels_ns(orig)->lock);
@@ -570,7 +570,7 @@ static bool __label_remove(struct aa_label *label, struct aa_label *new)
 
 	AA_BUG(!ls);
 	AA_BUG(!label);
-	lockdep_assert_held_exclusive(&ls->lock);
+	lockdep_assert_held_write(&ls->lock);
 
 	if (new)
 		__aa_proxy_redirect(label, new);
@@ -607,7 +607,7 @@ static bool __label_replace(struct aa_label *old, struct aa_label *new)
 	AA_BUG(!ls);
 	AA_BUG(!old);
 	AA_BUG(!new);
-	lockdep_assert_held_exclusive(&ls->lock);
+	lockdep_assert_held_write(&ls->lock);
 	AA_BUG(new->flags & FLAG_IN_TREE);
 
 	if (!label_is_stale(old))
@@ -644,7 +644,7 @@ static struct aa_label *__label_insert(struct aa_labelset *ls,
 	AA_BUG(!ls);
 	AA_BUG(!label);
 	AA_BUG(labels_set(label) != ls);
-	lockdep_assert_held_exclusive(&ls->lock);
+	lockdep_assert_held_write(&ls->lock);
 	AA_BUG(label->flags & FLAG_IN_TREE);
 
 	/* Figure out where to put new node */
-- 
2.17.1

