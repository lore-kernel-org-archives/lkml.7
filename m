Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A18C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B898220449
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:13:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388259AbfFMPNO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:13:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:46238 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732270AbfFMNfR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 09:35:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 072DDAD08;
        Thu, 13 Jun 2019 13:35:16 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3FE5ADA897; Thu, 13 Jun 2019 15:36:05 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        David Sterba <dsterba@suse.com>
Subject: [PATCH] lockdep: introduce lockdep_assert_not_held()
Date:   Thu, 13 Jun 2019 15:36:04 +0200
Message-Id: <20190613133604.9889-1-dsterba@suse.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an assertion that a lock is not held, suitable for the following
(simplified) usecase in filesystems:

- filesystem write
  - lock(&big_filesystem_lock)
  - kmalloc(GFP_KERNEL)
    - trigger dirty data write to get more memory
      - find dirty pages
      - call filesystem write
        - lock(&big_filesystem_lock)
	  deadlock

The cause here is the use of GFP_KERNEL that does not exclude poking
filesystems to allow freeing some memory. Such scenario is a bug, so the
use of GFP_NOFS is the right flag.

The annotation can help catch such bugs during development because
the actual deadlock could be hard to hit in practice.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 Documentation/locking/lockdep-design.txt | 5 +++++
 include/linux/lockdep.h                  | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/Documentation/locking/lockdep-design.txt b/Documentation/locking/lockdep-design.txt
index 39fae143c9cb..8b3013aaf518 100644
--- a/Documentation/locking/lockdep-design.txt
+++ b/Documentation/locking/lockdep-design.txt
@@ -211,6 +211,11 @@ that nobody tampered with the lock, e.g. kernel/sched/sched.h
 	lockdep_unpin_lock(&rq->lock, rf->cookie);
   }
 
+In some contexts it is useful to assert that a given lock is not held.  A
+typical example are filesystems that must avoid recursion to their code when
+a memory allocation triggers write of dirty data. When the allocation is done
+with a lock taken, re-entering the code would cause a deadlock.
+
 While comments about locking requirements might provide useful information,
 the runtime checks performed by annotations are invaluable when debugging
 locking problems and they carry the same level of details when inspecting
diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 6e2377e6c1d6..a6682104bd95 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -397,6 +397,10 @@ extern void lock_unpin_lock(struct lockdep_map *lock, struct pin_cookie);
 		WARN_ON_ONCE(debug_locks && !lockdep_is_held(l));	\
 	} while (0)
 
+#define lockdep_assert_not_held(l)	do {			\
+		WARN_ON(debug_locks && lockdep_is_held(l));	\
+	} while (0)
+
 #define lockdep_recursing(tsk)	((tsk)->lockdep_recursion)
 
 #define lockdep_pin_lock(l)	lock_pin_lock(&(l)->dep_map)
@@ -469,6 +473,7 @@ struct lockdep_map { };
 #define lockdep_assert_held_exclusive(l)	do { (void)(l); } while (0)
 #define lockdep_assert_held_read(l)		do { (void)(l); } while (0)
 #define lockdep_assert_held_once(l)		do { (void)(l); } while (0)
+#define lockdep_assert_not_held(l)		do { (void)(l); } while (0)
 
 #define lockdep_recursing(tsk)			(0)
 
-- 
2.21.0

