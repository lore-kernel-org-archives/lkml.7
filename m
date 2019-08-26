Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 042C5C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 14:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE34D217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 14:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566829891;
	bh=DCula5wz850U7JxrQ1gzlc8ZfKRh7hzVzTC/fMTmSCU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GGPPCong6Ipa58+oUcF6EgXiTR2sqRTh/4F2iQ/9e00iKQDNdK25jPTNgCtZ1HVsY
	 /8KvF6KJJkV/lD60QE3dUROyMYRFqNTeSU8vAF/xykoyNGIT64oor0IQf+t/FDJR4x
	 1ctqm+fU9YmqbB+mR1QAzsGo4LrVLqRu2XsPcqRE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732498AbfHZOba (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 10:31:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:41358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726484AbfHZOb1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 10:31:27 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E75B021872;
        Mon, 26 Aug 2019 14:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566829886;
        bh=DCula5wz850U7JxrQ1gzlc8ZfKRh7hzVzTC/fMTmSCU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nAPge+57McI/g7uojKda2avW2UEoz4Oymjut9Ca/jxzLVEmqEIVdFu/3hDsoSZdRR
         Eqj1QJIYCLwE8qliXqL1wFvQHyOFO8WK8pGQGdORLh1p3kKWa09ANWprw6D3BbWd0b
         q+G+ZwQzEJ0B0Kl4moof4Epp0yTEKkYW88BW5poA=
From:   Sasha Levin <sashal@kernel.org>
To:     peterz@infradead.org, will@kernel.org, jstancek@redhat.com,
        stable@vger.kernel.org
Cc:     torvalds@linux-foundation.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH v5.2 2/2] lcoking/rwsem: Add missing ACQUIRE to read_slowpath sleep loop
Date:   Mon, 26 Aug 2019 10:31:14 -0400
Message-Id: <20190826143114.23471-2-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190826143114.23471-1-sashal@kernel.org>
References: <20190826143114.23471-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

[ Upstream commit 99143f82a255e7f054bead8443462fae76dd829e ]

While reviewing another read_slowpath patch, both Will and I noticed
another missing ACQUIRE, namely:

  X = 0;

  CPU0			CPU1

  rwsem_down_read()
    for (;;) {
      set_current_state(TASK_UNINTERRUPTIBLE);

                        X = 1;
                        rwsem_up_write();
                          rwsem_mark_wake()
                            atomic_long_add(adjustment, &sem->count);
                            smp_store_release(&waiter->task, NULL);

      if (!waiter.task)
        break;

      ...
    }

  r = X;

Allows 'r == 0'.

Reported-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reported-by: Will Deacon <will@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Will Deacon <will@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

This is a backport for the v5.2 stable tree. There were multiple reports  
of this issue being hit.

Given that there were a few changes to the code around this, I'd
appreciate an ack before pulling it in.

 kernel/locking/rwsem-xadd.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/locking/rwsem-xadd.c b/kernel/locking/rwsem-xadd.c
index 397dedc58432d..385ebcfc31a6d 100644
--- a/kernel/locking/rwsem-xadd.c
+++ b/kernel/locking/rwsem-xadd.c
@@ -485,8 +485,10 @@ __rwsem_down_read_failed_common(struct rw_semaphore *sem, int state)
 	/* wait to be given the lock */
 	while (true) {
 		set_current_state(state);
-		if (!waiter.task)
+		if (!smp_load_acquire(&waiter.task)) {
+			/* Orders against rwsem_mark_wake()'s smp_store_release() */
 			break;
+		}
 		if (signal_pending_state(state, current)) {
 			raw_spin_lock_irq(&sem->wait_lock);
 			if (waiter.task)
-- 
2.20.1

