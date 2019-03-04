Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD74C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 17:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D99C5206B8
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 17:21:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbfCDRVA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 12:21:00 -0500
Received: from foss.arm.com ([217.140.101.70]:36322 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726098AbfCDRVA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 12:21:00 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 979BBA78;
        Mon,  4 Mar 2019 09:20:59 -0800 (PST)
Received: from e108454-lin.cambridge.arm.com (e108454-lin.cambridge.arm.com [10.1.196.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8714C3F703;
        Mon,  4 Mar 2019 09:20:58 -0800 (PST)
From:   Julien Grall <julien.grall@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     jslaby@suse.com, gregkh@linuxfoundation.org,
        linux-rt-users@vger.kernel.ort, Julien Grall <julien.grall@arm.com>
Subject: [PATCH] tty/sysrq: Convert show_lock to raw_spinlock_t
Date:   Mon,  4 Mar 2019 17:20:53 +0000
Message-Id: <20190304172053.17340-1-julien.grall@arm.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At the moment show_lock is implemented using spin_lock_t and called from
an interrupt context on Arm64. The following backtrace was triggered by:

42sh# echo l > /proc/sysrq-trigger

[ 4432.073756] sysrq: SysRq : Show backtrace of all active CPUs
[ 4432.403422] BUG: sleeping function called from invalid context at kernel/locking/rtmutex.c:974
[ 4432.403424] sysrq: CPU6:
[ 4432.403426] in_atomic(): 1, irqs_disabled(): 128, pid: 2410, name: kworker/u16:2

[...]

[ 4432.403581] Call trace:
[ 4432.403584]  dump_backtrace+0x0/0x148
[ 4432.403586]  show_stack+0x14/0x20
[ 4432.403588]  dump_stack+0x9c/0xd4
[ 4432.403592]  ___might_sleep+0x1cc/0x298
[ 4432.403595]  rt_spin_lock+0x5c/0x70
[ 4432.403596]  showacpu+0x34/0x68
[ 4432.403599]  flush_smp_call_function_queue+0xd4/0x278
[ 4432.403602]  generic_smp_call_function_single_interrupt+0x10/0x18
[ 4432.403605]  handle_IPI+0x26c/0x668
[ 4432.403607]  gic_handle_irq+0x9c/0xa0
[ 4432.403609]  el1_irq+0xb4/0x13c

With RT-patches, spin_lock can now sleep and therefore cannot be used from
interrupt context. Use a raw_spin_lock instead to prevent the lock to
sleep.

Signed-off-by: Julien Grall <julien.grall@arm.com>
---
 drivers/tty/sysrq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index 1f03078ec352..8473557c7ab2 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -208,7 +208,7 @@ static struct sysrq_key_op sysrq_showlocks_op = {
 #endif
 
 #ifdef CONFIG_SMP
-static DEFINE_SPINLOCK(show_lock);
+static DEFINE_RAW_SPINLOCK(show_lock);
 
 static void showacpu(void *dummy)
 {
@@ -218,10 +218,10 @@ static void showacpu(void *dummy)
 	if (idle_cpu(smp_processor_id()))
 		return;
 
-	spin_lock_irqsave(&show_lock, flags);
+	raw_spin_lock_irqsave(&show_lock, flags);
 	pr_info("CPU%d:\n", smp_processor_id());
 	show_stack(NULL, NULL);
-	spin_unlock_irqrestore(&show_lock, flags);
+	raw_spin_unlock_irqrestore(&show_lock, flags);
 }
 
 static void sysrq_showregs_othercpus(struct work_struct *dummy)
-- 
2.11.0

