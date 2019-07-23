Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20DECC7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 15:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8682223A0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 15:07:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388616AbfGWPHh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 11:07:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:64978 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731767AbfGWPHh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 11:07:37 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2E80C81F19;
        Tue, 23 Jul 2019 15:07:37 +0000 (UTC)
Received: from llong.com (dhcp-17-160.bos.redhat.com [10.18.17.160])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 593DC60852;
        Tue, 23 Jul 2019 15:07:32 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>,
        Luis Henriques <lhenriques@suse.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH] locking/rwsem: Don't call owner_on_cpu() on read-owner
Date:   Tue, 23 Jul 2019 11:07:20 -0400
Message-Id: <20190723150720.6540-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Tue, 23 Jul 2019 15:07:37 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For writer, the owner value is cleared on unlock. For reader, it is
left intact on unlock for providing better debugging aid on crash dump
and the unlock of one reader may not mean the lock is free.

As a result, the owner_on_cpu() shouldn't be used on read-owner as
the task pointer value may not be valid and the task structure might
have been freed. That is the case in rwsem_can_spin_on_owner() where
the following use-after-free error from KASAN may appear under certain
circumstances:

  BUG: KASAN: use-after-free in rwsem_down_write_slowpath
  (/home/miguel/kernel/linux/kernel/locking/rwsem.c:669
  /home/miguel/kernel/linux/kernel/locking/rwsem.c:1125)

Fix this by checking for RWSEM_READER_OWNED flag before calling
owner_on_cpu().

Fixes: 94a9717b3c40e ("locking/rwsem: Make rwsem->owner an atomic_long_t")
Signed-off-by: Waiman Long <longman@redhat.com>
Tested-by: Luis Henriques <lhenriques@suse.com>
---
 kernel/locking/rwsem.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 37524a47f002..bc91aacaab58 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -666,7 +666,11 @@ static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem,
 	preempt_disable();
 	rcu_read_lock();
 	owner = rwsem_owner_flags(sem, &flags);
-	if ((flags & nonspinnable) || (owner && !owner_on_cpu(owner)))
+	/*
+	 * Don't check the read-owner as the entry may be stale.
+	 */
+	if ((flags & nonspinnable) ||
+	    (owner && !(flags & RWSEM_READER_OWNED) && !owner_on_cpu(owner)))
 		ret = false;
 	rcu_read_unlock();
 	preempt_enable();
-- 
2.18.1

