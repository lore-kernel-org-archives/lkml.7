Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF98BC04E87
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 04:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEFE421019
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 04:53:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbfEUExf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 00:53:35 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:59926 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbfEUExe (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Tue, 21 May 2019 00:53:34 -0400
Received: from emea4-mta.ukb.novell.com ([10.120.13.87])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Tue, 21 May 2019 06:53:33 +0200
Received: from linux-r8p5.suse.de (nwb-a10-snat.microfocus.com [10.120.13.201])
        by emea4-mta.ukb.novell.com with ESMTP (TLS encrypted); Tue, 21 May 2019 05:53:01 +0100
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, willy@infradead.org, mhocko@kernel.org,
        mgorman@techsingularity.net, jglisse@redhat.com,
        ldufour@linux.vnet.ibm.com, dave@stgolabs.net,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 03/14] mm: introduce mm locking wrappers
Date:   Mon, 20 May 2019 21:52:31 -0700
Message-Id: <20190521045242.24378-4-dave@stgolabs.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190521045242.24378-1-dave@stgolabs.net>
References: <20190521045242.24378-1-dave@stgolabs.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the necessary wrappers to encapsulate mmap_sem
locking and will enable any future changes to be a lot more
confined to here. In addition, future users will incrementally
be added in the next patches. mm_[read/write]_[un]lock() naming
is used.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 include/linux/mm.h | 76 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 0e8834ac32b7..780b6097ee47 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -12,6 +12,7 @@
 #include <linux/list.h>
 #include <linux/mmzone.h>
 #include <linux/rbtree.h>
+#include <linux/range_lock.h>
 #include <linux/atomic.h>
 #include <linux/debug_locks.h>
 #include <linux/mm_types.h>
@@ -2880,5 +2881,80 @@ void __init setup_nr_node_ids(void);
 static inline void setup_nr_node_ids(void) {}
 #endif
 
+/*
+ * Address space locking wrappers.
+ */
+static inline bool mm_is_locked(struct mm_struct *mm,
+				struct range_lock *mmrange)
+{
+	return rwsem_is_locked(&mm->mmap_sem);
+}
+
+/* Reader wrappers */
+static inline int mm_read_trylock(struct mm_struct *mm,
+				  struct range_lock *mmrange)
+{
+	return down_read_trylock(&mm->mmap_sem);
+}
+
+static inline void mm_read_lock(struct mm_struct *mm,
+				struct range_lock *mmrange)
+{
+	down_read(&mm->mmap_sem);
+}
+
+static inline void mm_read_lock_nested(struct mm_struct *mm,
+				       struct range_lock *mmrange, int subclass)
+{
+	down_read_nested(&mm->mmap_sem, subclass);
+}
+
+static inline void mm_read_unlock(struct mm_struct *mm,
+				  struct range_lock *mmrange)
+{
+	up_read(&mm->mmap_sem);
+}
+
+/* Writer wrappers */
+static inline int mm_write_trylock(struct mm_struct *mm,
+				   struct range_lock *mmrange)
+{
+	return down_write_trylock(&mm->mmap_sem);
+}
+
+static inline void mm_write_lock(struct mm_struct *mm,
+				 struct range_lock *mmrange)
+{
+	down_write(&mm->mmap_sem);
+}
+
+static inline int mm_write_lock_killable(struct mm_struct *mm,
+					 struct range_lock *mmrange)
+{
+	return down_write_killable(&mm->mmap_sem);
+}
+
+static inline void mm_downgrade_write(struct mm_struct *mm,
+				      struct range_lock *mmrange)
+{
+	downgrade_write(&mm->mmap_sem);
+}
+
+static inline void mm_write_unlock(struct mm_struct *mm,
+				   struct range_lock *mmrange)
+{
+	up_write(&mm->mmap_sem);
+}
+
+static inline void mm_write_lock_nested(struct mm_struct *mm,
+					struct range_lock *mmrange,
+					int subclass)
+{
+	down_write_nested(&mm->mmap_sem, subclass);
+}
+
+#define mm_write_nest_lock(mm, range, nest_lock)		\
+	down_write_nest_lock(&(mm)->mmap_sem, nest_lock)
+
 #endif /* __KERNEL__ */
 #endif /* _LINUX_MM_H */
-- 
2.16.4

