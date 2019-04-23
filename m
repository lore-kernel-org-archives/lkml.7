Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D885C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 16:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17911218B0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 16:32:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729069AbfDWQcr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 12:32:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60940 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728967AbfDWQcn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 12:32:43 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 61CC7307E04F;
        Tue, 23 Apr 2019 16:32:43 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.38])
        by smtp.corp.redhat.com (Postfix) with SMTP id 3BF6E1A913;
        Tue, 23 Apr 2019 16:32:42 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 23 Apr 2019 18:32:43 +0200 (CEST)
Date:   Tue, 23 Apr 2019 18:32:41 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] locking/percpu-rwsem: Add DEFINE_PERCPU_RWSEM(), use it to
 initialize cgroup_threadgroup_rwsem
Message-ID: <20190423163241.GA15866@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Tue, 23 Apr 2019 16:32:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Turn DEFINE_STATIC_PERCPU_RWSEM() into __DEFINE_PERCPU_RWSEM() with the
additional "is_static" argument to introduce DEFINE_PERCPU_RWSEM().

Change cgroup.c to use DEFINE_PERCPU_RWSEM(cgroup_threadgroup_rwsem).

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 include/linux/percpu-rwsem.h | 8 ++++++--
 kernel/cgroup/cgroup.c       | 3 +--
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/include/linux/percpu-rwsem.h b/include/linux/percpu-rwsem.h
index 6887636..2809b44 100644
--- a/include/linux/percpu-rwsem.h
+++ b/include/linux/percpu-rwsem.h
@@ -17,14 +17,18 @@ struct percpu_rw_semaphore {
 	int			readers_block;
 };
 
-#define DEFINE_STATIC_PERCPU_RWSEM(name)				\
+#define __DEFINE_PERCPU_RWSEM(name, is_static)				\
 static DEFINE_PER_CPU(unsigned int, __percpu_rwsem_rc_##name);		\
-static struct percpu_rw_semaphore name = {				\
+is_static struct percpu_rw_semaphore name = {				\
 	.rss = __RCU_SYNC_INITIALIZER(name.rss),			\
 	.read_count = &__percpu_rwsem_rc_##name,			\
 	.rw_sem = __RWSEM_INITIALIZER(name.rw_sem),			\
 	.writer = __RCUWAIT_INITIALIZER(name.writer),			\
 }
+#define DEFINE_PERCPU_RWSEM(name)		\
+	__DEFINE_PERCPU_RWSEM(name, /* not static */)
+#define DEFINE_STATIC_PERCPU_RWSEM(name)	\
+	__DEFINE_PERCPU_RWSEM(name, static)
 
 extern int __percpu_down_read(struct percpu_rw_semaphore *, int);
 extern void __percpu_up_read(struct percpu_rw_semaphore *);
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 3f2b4bd..2510017 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -101,7 +101,7 @@ static DEFINE_SPINLOCK(cgroup_idr_lock);
  */
 static DEFINE_SPINLOCK(cgroup_file_kn_lock);
 
-struct percpu_rw_semaphore cgroup_threadgroup_rwsem;
+DEFINE_PERCPU_RWSEM(cgroup_threadgroup_rwsem);
 
 #define cgroup_assert_mutex_or_rcu_locked()				\
 	RCU_LOCKDEP_WARN(!rcu_read_lock_held() &&			\
@@ -5432,7 +5432,6 @@ int __init cgroup_init(void)
 	int ssid;
 
 	BUILD_BUG_ON(CGROUP_SUBSYS_COUNT > 16);
-	BUG_ON(percpu_init_rwsem(&cgroup_threadgroup_rwsem));
 	BUG_ON(cgroup_init_cftypes(NULL, cgroup_base_files));
 	BUG_ON(cgroup_init_cftypes(NULL, cgroup1_base_files));
 
-- 
2.5.0


