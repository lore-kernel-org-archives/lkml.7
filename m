Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83BE8C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 14:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A4D32081B
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 14:43:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbfCIOnX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 09:43:23 -0500
Received: from terminus.zytor.com ([198.137.202.136]:53875 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725841AbfCIOnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 09:43:23 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x29Eh3E23109912
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 9 Mar 2019 06:43:03 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x29Eh29H3109909;
        Sat, 9 Mar 2019 06:43:02 -0800
Date:   Sat, 9 Mar 2019 06:43:02 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Qian Cai <tipbot@zytor.com>
Message-ID: <tip-69a106c00e8554a7e6b3f4bb2967332670f89337@git.kernel.org>
Cc:     dave.hansen@linux.intel.com, bp@alien8.de,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        tglx@linutronix.de, torvalds@linux-foundation.org,
        bvanassche@acm.org, peterz@infradead.org, riel@surriel.com,
        luto@kernel.org, cai@lca.pw, mingo@kernel.org, hpa@zytor.com,
        will.deacon@arm.com, paulmck@linux.vnet.ibm.com
Reply-To: torvalds@linux-foundation.org, peterz@infradead.org,
          bvanassche@acm.org, linux-kernel@vger.kernel.org, bp@alien8.de,
          dave.hansen@linux.intel.com, tglx@linutronix.de,
          akpm@linux-foundation.org, will.deacon@arm.com,
          paulmck@linux.vnet.ibm.com, riel@surriel.com, mingo@kernel.org,
          luto@kernel.org, cai@lca.pw, hpa@zytor.com
In-Reply-To: <20190307002731.47371-1-cai@lca.pw>
References: <20190307002731.47371-1-cai@lca.pw>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/urgent] workqueue, lockdep: Fix a memory leak in
 wq->lock_name
Git-Commit-ID: 69a106c00e8554a7e6b3f4bb2967332670f89337
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  69a106c00e8554a7e6b3f4bb2967332670f89337
Gitweb:     https://git.kernel.org/tip/69a106c00e8554a7e6b3f4bb2967332670f89337
Author:     Qian Cai <cai@lca.pw>
AuthorDate: Wed, 6 Mar 2019 19:27:31 -0500
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Sat, 9 Mar 2019 14:15:52 +0100

workqueue, lockdep: Fix a memory leak in wq->lock_name

The following commit:

  669de8bda87b ("kernel/workqueue: Use dynamic lockdep keys for workqueues")

introduced a memory leak as wq_free_lockdep() calls kfree(wq->lock_name),
but wq_init_lockdep() does not point wq->lock_name to the newly allocated
slab object.

This can be reproduced by running LTP fallocate04 followed by oom01 tests:

 unreferenced object 0xc0000005876384d8 (size 64):
  comm "fallocate04", pid 26972, jiffies 4297139141 (age 40370.480s)
  hex dump (first 32 bytes):
    28 77 71 5f 63 6f 6d 70 6c 65 74 69 6f 6e 29 65  (wq_completion)e
    78 74 34 2d 72 73 76 2d 63 6f 6e 76 65 72 73 69  xt4-rsv-conversi
  backtrace:
    [<00000000cb452883>] kvasprintf+0x6c/0xe0
    [<000000004654ddac>] kasprintf+0x34/0x60
    [<000000001c68f311>] alloc_workqueue+0x1f8/0x6ac
    [<0000000003c2ad83>] ext4_fill_super+0x23d4/0x3c80 [ext4]
    [<0000000006610538>] mount_bdev+0x25c/0x290
    [<00000000bcf955ec>] ext4_mount+0x28/0x50 [ext4]
    [<0000000016e08fd3>] legacy_get_tree+0x4c/0xb0
    [<0000000042b6a5fc>] vfs_get_tree+0x6c/0x190
    [<00000000268ab022>] do_mount+0xb9c/0x1100
    [<00000000698e6898>] ksys_mount+0x158/0x180
    [<0000000064e391fd>] sys_mount+0x20/0x30
    [<00000000ba378f12>] system_call+0x5c/0x70

Signed-off-by: Qian Cai <cai@lca.pw>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: catalin.marinas@arm.com
Cc: jiangshanlai@gmail.com
Cc: tj@kernel.org
Fixes: 669de8bda87b ("kernel/workqueue: Use dynamic lockdep keys for workqueues")
Link: https://lkml.kernel.org/r/20190307002731.47371-1-cai@lca.pw
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/workqueue.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index ecdd5e6f2166..e14da4f599ab 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -3348,6 +3348,8 @@ static void wq_init_lockdep(struct workqueue_struct *wq)
 	lock_name = kasprintf(GFP_KERNEL, "%s%s", "(wq_completion)", wq->name);
 	if (!lock_name)
 		lock_name = wq->name;
+
+	wq->lock_name = lock_name;
 	lockdep_init_map(&wq->lockdep_map, lock_name, &wq->key, 0);
 }
 
