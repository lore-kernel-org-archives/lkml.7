Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F15C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 15:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44C22206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 15:21:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728222AbfDWPVE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 11:21:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42556 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726655AbfDWPVE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 11:21:04 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7C91B2D806;
        Tue, 23 Apr 2019 15:21:04 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.38])
        by smtp.corp.redhat.com (Postfix) with SMTP id 8095D608A4;
        Tue, 23 Apr 2019 15:21:03 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 23 Apr 2019 17:21:04 +0200 (CEST)
Date:   Tue, 23 Apr 2019 17:21:02 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] uprobes: use DEFINE_STATIC_PERCPU_RWSEM() to initialize
 dup_mmap_sem
Message-ID: <20190423152102.GA28442@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Tue, 23 Apr 2019 15:21:04 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_STATIC_PERCPU_RWSEM() to initialize dup_mmap_sem.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 kernel/events/uprobes.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index c5cde87..76c7380 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -46,7 +46,7 @@ static DEFINE_SPINLOCK(uprobes_treelock);	/* serialize rbtree access */
 static struct mutex uprobes_mmap_mutex[UPROBES_HASH_SZ];
 #define uprobes_mmap_hash(v)	(&uprobes_mmap_mutex[((unsigned long)(v)) % UPROBES_HASH_SZ])
 
-static struct percpu_rw_semaphore dup_mmap_sem;
+DEFINE_STATIC_PERCPU_RWSEM(dup_mmap_sem);
 
 /* Have a copy of original instruction */
 #define UPROBE_COPY_INSN	0
@@ -2301,9 +2301,6 @@ static int __init init_uprobes(void)
 	for (i = 0; i < UPROBES_HASH_SZ; i++)
 		mutex_init(&uprobes_mmap_mutex[i]);
 
-	if (percpu_init_rwsem(&dup_mmap_sem))
-		return -ENOMEM;
-
 	return register_die_notifier(&uprobe_exception_nb);
 }
 __initcall(init_uprobes);
-- 
2.5.0


