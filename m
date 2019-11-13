Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3899C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 17:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D90FC206DA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 17:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573665129;
	bh=kdtwDODNLE4YWiNVPQry0buhIpkJQq9tKqW/8U/Aylo=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=jCGpyzzU2jkUP8tY1fdDcXEgCM3R4gT/o6HfiEeTnpFmfHMSwfyjZOuICp+ZcoPK6
	 n7wbBmeXLoJWukpMaoFd7fYEZVmxOKukKUksFfb340f72AlTnQm4NgL2OH6UKYsQMr
	 GfFhRBrk1qgEWRL0uDLF2UuJCYgIwkegcQaajCRs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728220AbfKMRMI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 12:12:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:37052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726105AbfKMRMI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 12:12:08 -0500
Received: from lenoir.home (lfbn-ncy-1-150-155.w83-194.abo.wanadoo.fr [83.194.232.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1653D206D9;
        Wed, 13 Nov 2019 17:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573665126;
        bh=kdtwDODNLE4YWiNVPQry0buhIpkJQq9tKqW/8U/Aylo=;
        h=From:To:Cc:Subject:Date:From;
        b=GYsSB3XJk2D3uObJ6kucsTytOJuFkfiicfpmrlr/4whLQZH2zdEClf6kJ0kv8g8yu
         bHUlEAKZcDP4Dd8p1PaJUd15D1QyzkssyCjaVN8CDlOCPGo1DwvD/GxMGoAT2567Z8
         gNlanMwRLkYByIAmPRdj2Y/DeE5raG4PhP9GeYCA=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        kernel test robot <rong.a.chen@intel.com>
Subject: [PATCH] irq_work: Fix IRQ_WORK_BUZY bit clearing
Date:   Wed, 13 Nov 2019 18:12:01 +0100
Message-Id: <20191113171201.14032-1-frederic@kernel.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While attempting to clear the buzy bit at the end of a work execution,
atomic_cmpxchg() expects the value of the flags with the pending bit
cleared as the old value. However we are passing by mistake the value of
the flags before we actually cleared the pending bit.

As a result, clearing the buzy bit fails and irq_work_sync() may stall:

	watchdog: BUG: soft lockup - CPU#0 stuck for 22s! [blktrace:4948]
	CPU: 0 PID: 4948 Comm: blktrace Not tainted 5.4.0-rc7-00003-gfeb4a51323bab #1
	Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
	RIP: 0010:irq_work_sync+0x4/0x10
	Call Trace:
	  relay_close_buf+0x19/0x50
	  relay_close+0x64/0x100
	  blk_trace_free+0x1f/0x50
	  __blk_trace_remove+0x1e/0x30
	  blk_trace_ioctl+0x11b/0x140
	  blkdev_ioctl+0x6c1/0xa40
	  block_ioctl+0x39/0x40
	  do_vfs_ioctl+0xa5/0x700
	  ksys_ioctl+0x70/0x80
	  __x64_sys_ioctl+0x16/0x20
	  do_syscall_64+0x5b/0x1d0
	  entry_SYSCALL_64_after_hwframe+0x44/0xa9

So clear the appropriate bit before passing the old flags to cmpxchg().

Reported-by: kernel test robot <rong.a.chen@intel.com>
Reported-by: Leonard Crestez <leonard.crestez@nxp.com>
Fixes: feb4a51323ba ("irq_work: Slightly simplify IRQ_WORK_PENDING clearing")
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Paul E . McKenney <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
---
 kernel/irq_work.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/irq_work.c b/kernel/irq_work.c
index 49c53f80a13a..828cc30774bc 100644
--- a/kernel/irq_work.c
+++ b/kernel/irq_work.c
@@ -158,6 +158,7 @@ static void irq_work_run_list(struct llist_head *list)
 		 * Clear the BUSY bit and return to the free state if
 		 * no-one else claimed it meanwhile.
 		 */
+		flags &= ~IRQ_WORK_PENDING;
 		(void)atomic_cmpxchg(&work->flags, flags, flags & ~IRQ_WORK_BUSY);
 	}
 }
-- 
2.23.0

