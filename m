Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82FCAC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 09:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65B1C2073B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 09:54:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727439AbfKOJyt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 04:54:49 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42982 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727590AbfKOJyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 04:54:46 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iVYJM-0004n4-0a; Fri, 15 Nov 2019 10:54:40 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id AB2131C08AC;
        Fri, 15 Nov 2019 10:54:39 +0100 (CET)
Date:   Fri, 15 Nov 2019 09:54:39 -0000
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irq_work: Fix IRQ_WORK_BUSY bit clearing
Cc:     kernel test robot <rong.a.chen@intel.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191113171201.14032-1-frederic@kernel.org>
References: <20191113171201.14032-1-frederic@kernel.org>
MIME-Version: 1.0
Message-ID: <157381167919.29467.977752896796863165.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     e9838bd51169af87ae248336d4c3fc59184a0e46
Gitweb:        https://git.kernel.org/tip/e9838bd51169af87ae248336d4c3fc59184a0e46
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Wed, 13 Nov 2019 18:12:01 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 15 Nov 2019 10:48:37 +01:00

irq_work: Fix IRQ_WORK_BUSY bit clearing

While attempting to clear the busy bit at the end of a work execution,
atomic_cmpxchg() expects the value of the flags with the pending bit
cleared as the old value. However by mistake the value of the flags is
passed without clearing the pending bit first.

As a result, clearing the busy bit fails and irq_work_sync() may stall:

 watchdog: BUG: soft lockup - CPU#0 stuck for 22s! [blktrace:4948]
 CPU: 0 PID: 4948 Comm: blktrace Not tainted 5.4.0-rc7-00003-gfeb4a51323bab #1
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

Fixes: feb4a51323ba ("irq_work: Slightly simplify IRQ_WORK_PENDING clearing")
Reported-by: kernel test robot <rong.a.chen@intel.com>
Reported-by: Leonard Crestez <leonard.crestez@nxp.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Leonard Crestez <leonard.crestez@nxp.com>
Link: https://lkml.kernel.org/r/20191113171201.14032-1-frederic@kernel.org

---
 kernel/irq_work.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/irq_work.c b/kernel/irq_work.c
index 49c53f8..828cc30 100644
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
