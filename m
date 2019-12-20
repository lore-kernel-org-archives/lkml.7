Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A9AC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 12:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07AB62146E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 12:53:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbfLTMxb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 07:53:31 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:50994 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727362AbfLTMxa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 07:53:30 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 4F011375F1562EBCE835;
        Fri, 20 Dec 2019 20:53:27 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.439.0; Fri, 20 Dec 2019 20:53:17 +0800
From:   John Garry <john.garry@huawei.com>
To:     <naveen.n.rao@linux.ibm.com>, <anil.s.keshavamurthy@intel.com>,
        <davem@davemloft.net>, <mhiramat@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <paulmck@kernel.org>,
        <anders.roxell@linaro.org>, John Garry <john.garry@huawei.com>
Subject: [RFC PATCH] kprobes: Fix suspicious RCU usage WARN in get_kprobe()
Date:   Fri, 20 Dec 2019 20:49:51 +0800
Message-ID: <1576846191-18801-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With CONFIG_PROVE_RCU_LIST set, we may get the following WARN in the
test code:

Kprobe smoke test: started

=============================
WARNING: suspicious RCU usage
5.5.0-rc1-00013-ge15bd404ed10-dirty #802 Not tainted
-----------------------------
kernel/kprobes.c:329 RCU-list traversed in non-reader section!!

other info that might help us debug this:

rcu_scheduler_active = 2, debug_locks = 1
1 lock held by swapper/0/1:
#0: ffff800011bf3648 (kprobe_mutex){+.+.}, at: register_kprobe+0x94/0x5a0

stack backtrace:
CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.5.0-rc1-00013-ge15bd404ed10-dirty #802
Hardware name: Huawei Taishan 2280 /D05, BIOS Hisilicon D05 IT21 Nemo 2.0 RC0 04/18/2018
Call trace:
dump_backtrace+0x0/0x1a0
show_stack+0x14/0x20
dump_stack+0xe8/0x150
lockdep_rcu_suspicious+0xcc/0x110
get_kprobe+0xb8/0xc0
__get_valid_kprobe+0x18/0xc8
register_kprobe+0x9c/0x5a0
init_test_probes+0x80/0x400
init_kprobes+0x13c/0x154
do_one_initcall+0x88/0x428
kernel_init_freeable+0x21c/0x2c4
kernel_init+0x10/0x108
ret_from_fork+0x10/0x18
Kprobe smoke test: passed successfully

The code comment tells us the locking requirements:

/*
 * This routine is called either:
 * 	- under the kprobe_mutex - during kprobe_[un]register()
 * 				OR
 * 	- with preemption disabled - from arch/xxx/kernel/kprobes.c
 */
struct kprobe *get_kprobe(void *addr)
{
	struct hlist_head *head;
	struct kprobe *p;

	head = &kprobe_table[hash_ptr(addr, KPROBE_HASH_BITS)];
	hlist_for_each_entry_rcu(p, head, hlist,

And we have the kprobe_mutex held in the path of concern, so add a
RCU list traversal check condition for this.

Signed-off-by: John Garry <john.garry@huawei.com>
---
I sent as an RFC as I am not 100% certain that this is the right fix.
It does solve my WARN.

I also assume __get_valid_kprobe() will require a similar change for
similar reason.

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 53534aa258a6..908abdac77f1 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -326,7 +326,8 @@ struct kprobe *get_kprobe(void *addr)
 	struct kprobe *p;
 
 	head = &kprobe_table[hash_ptr(addr, KPROBE_HASH_BITS)];
-	hlist_for_each_entry_rcu(p, head, hlist) {
+	hlist_for_each_entry_rcu(p, head, hlist,
+				 mutex_is_locked(&kprobe_mutex)) {
 		if (p->addr == addr)
 			return p;
 	}
-- 
2.17.1

