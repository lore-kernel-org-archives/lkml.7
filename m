Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB40C282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 15:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01BDC2070E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 15:59:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729325AbgAHP72 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 10:59:28 -0500
Received: from mga11.intel.com ([192.55.52.93]:64327 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729306AbgAHP7Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 10:59:24 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jan 2020 07:59:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,410,1571727600"; 
   d="scan'208";a="395782702"
Received: from xshen14-linux.bj.intel.com ([10.238.155.105])
  by orsmga005.jf.intel.com with ESMTP; 08 Jan 2020 07:59:21 -0800
From:   Xiaochen Shen <xiaochen.shen@intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        tony.luck@intel.com, fenghua.yu@intel.com,
        reinette.chatre@intel.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, pei.p.jia@intel.com,
        xiaochen.shen@intel.com
Subject: [PATCH 1/4] x86/resctrl: Fix use-after-free when deleting resource groups
Date:   Thu,  9 Jan 2020 00:28:03 +0800
Message-Id: <1578500886-21771-2-git-send-email-xiaochen.shen@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1578500886-21771-1-git-send-email-xiaochen.shen@intel.com>
References: <1578500886-21771-1-git-send-email-xiaochen.shen@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A resource group (rdtgrp) contains a reference count (rdtgrp->waitcount)
that indicates how many waiters expect this rdtgrp to exist. Waiters
could be waiting on rdtgroup_mutex or some work sitting on a task's
workqueue for when the task returns from kernel mode or exits. The
deletion of a rdtgrp is intended to have two phases: (1) while holding
rdtgroup_mutex the necessary cleanup is done and rdtgrp->flags is set to
RDT_DELETED, (2) after releasing the rdtgroup_mutex the rdtgrp structure
is freed only if there are no waiters and it's flag is set to
RDT_DELETED. Upon gaining access to rdtgroup_mutex or rdtgrp a waiter is
required to check for the RDT_DELETED flag.

When unmounting resctrl file system or deleting ctrl_mon groups, all of
the subdirectories are removed and the data structure of rdtgrp is
forcibly freed without checking rdtgrp->waitcount. If at this point
there was a waiter on rdtgrp then a use-after-free issue occurs when the
waiter starts running accessing the rdtgrp structure it was waiting on.

See kfree() calls in [1], [2] and [3] in these two call paths in
following scenarios:
(1) rdt_kill_sb() -> rmdir_all_sub() -> free_all_child_rdtgrp()
(2) rdtgroup_rmdir() -> rdtgroup_rmdir_ctrl() -> free_all_child_rdtgrp()

There are several scenarios that result in use-after-free issue in
following:

Scenario 1:
-----------
In Thread 1, rdtgroup_tasks_write() adds a task_work callback
move_myself(). If move_myself() is scheduled to execute after Thread 2
rdt_kill_sb() is finished, referring to earlier rdtgrp memory
(rdtgrp->waitcount) which was already freed in Thread 2 results in
use-after-free issue.

Thread 1 (rdtgroup_tasks_write)        Thread 2 (rdt_kill_sb)
-------------------------------        ----------------------
rdtgroup_kn_lock_live
  atomic_inc(&rdtgrp->waitcount)
  mutex_lock
rdtgroup_move_task
  __rdtgroup_move_task
    /*
     * Take an extra refcount, so rdtgrp cannot be freed
     * before the call back move_myself has been invoked
     */
    atomic_inc(&rdtgrp->waitcount)
    /* Callback move_myself will be scheduled for later */
    task_work_add(move_myself)
rdtgroup_kn_unlock
  mutex_unlock
  atomic_dec_and_test(&rdtgrp->waitcount)
  && (flags & RDT_DELETED)
                                       mutex_lock
                                       rmdir_all_sub
                                         /*
                                          * sentry and rdtgrp are freed
                                          * without checking refcount
                                          */
                                         free_all_child_rdtgrp
                                           kfree(sentry)*[1]
                                         kfree(rdtgrp)*[2]
                                       mutex_unlock
/*
 * Callback is scheduled to execute
 * after rdt_kill_sb is finished
 */
move_myself
  /*
   * Use-after-free: refer to earlier rdtgrp
   * memory which was freed in [1] or [2].
   */
  atomic_dec_and_test(&rdtgrp->waitcount)
  && (flags & RDT_DELETED)
    kfree(rdtgrp)

Scenario 2:
-----------
In Thread 1, rdtgroup_tasks_write() adds a task_work callback
move_myself(). If move_myself() is scheduled to execute after Thread 2
rdtgroup_rmdir() is finished, referring to earlier rdtgrp memory
(rdtgrp->waitcount) which was already freed in Thread 2 results in
use-after-free issue.

Thread 1 (rdtgroup_tasks_write)        Thread 2 (rdtgroup_rmdir)
-------------------------------        -------------------------
rdtgroup_kn_lock_live
  atomic_inc(&rdtgrp->waitcount)
  mutex_lock
rdtgroup_move_task
  __rdtgroup_move_task
    /*
     * Take an extra refcount, so rdtgrp cannot be freed
     * before the call back move_myself has been invoked
     */
    atomic_inc(&rdtgrp->waitcount)
    /* Callback move_myself will be scheduled for later */
    task_work_add(move_myself)
rdtgroup_kn_unlock
  mutex_unlock
  atomic_dec_and_test(&rdtgrp->waitcount)
  && (flags & RDT_DELETED)
                                       rdtgroup_kn_lock_live
                                         atomic_inc(&rdtgrp->waitcount)
                                         mutex_lock
                                       rdtgroup_rmdir_ctrl
                                         free_all_child_rdtgrp
                                           /*
                                            * sentry is freed without
                                            * checking refcount
                                            */
                                           kfree(sentry)*[3]
                                         rdtgroup_ctrl_remove
                                           rdtgrp->flags = RDT_DELETED
                                       rdtgroup_kn_unlock
                                         mutex_unlock
                                         atomic_dec_and_test(
                                                     &rdtgrp->waitcount)
                                         && (flags & RDT_DELETED)
                                           kfree(rdtgrp)
/*
 * Callback is scheduled to execute
 * after rdt_kill_sb is finished
 */
move_myself
  /*
   * Use-after-free: refer to earlier rdtgrp
   * memory which was freed in [3].
   */
  atomic_dec_and_test(&rdtgrp->waitcount)
  && (flags & RDT_DELETED)
    kfree(rdtgrp)

If CONFIG_DEBUG_SLAB=y, Slab corruption on kmalloc-2k can be observed
like following. Note that "0x6b" is POISON_FREE after kfree(). The
corrupted bits "0x6a", "0x64" at offset 0x424 correspond to
waitcount member of struct rdtgroup which was freed:

  Slab corruption (Not tainted): kmalloc-2k start=ffff9504c5b0d000, len=2048
  420: 6b 6b 6b 6b 6a 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkjkkkkkkkkkkk
  Single bit error detected. Probably bad RAM.
  Run memtest86+ or a similar memory test tool.
  Next obj: start=ffff9504c5b0d800, len=2048
  000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
  010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk

  Slab corruption (Not tainted): kmalloc-2k start=ffff9504c58ab800, len=2048
  420: 6b 6b 6b 6b 64 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkdkkkkkkkkkkk
  Prev obj: start=ffff9504c58ab000, len=2048
  000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
  010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk

Fix this by taking reference count (waitcount) of rdtgrp into account in
the two call paths that currently do not do so. Instead of always
freeing the resource group it will only be freed if there are no waiters
on it, if there are waiters the resource group will have its flags set
to RDT_DELETED. It will be left to the waiter to free the resource group
when it starts running and finding that it was the last waiter and the
resource group has been removed (rdtgrp->flags & RDT_DELETED) since.
(1) rdt_kill_sb() -> rmdir_all_sub() -> free_all_child_rdtgrp()
(2) rdtgroup_rmdir() -> rdtgroup_rmdir_ctrl() -> free_all_child_rdtgrp()

Cc: stable@vger.kernel.org
Fixes: f3cbeacaa06e ("x86/intel_rdt/cqm: Add rmdir support")
Fixes: 60cf5e101fd4 ("x86/intel_rdt: Add mkdir to resctrl file system")
Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Xiaochen Shen <xiaochen.shen@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 205925d802d8..e1df86da48cf 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2209,7 +2209,11 @@ static void free_all_child_rdtgrp(struct rdtgroup *rdtgrp)
 	list_for_each_entry_safe(sentry, stmp, head, mon.crdtgrp_list) {
 		free_rmid(sentry->mon.rmid);
 		list_del(&sentry->mon.crdtgrp_list);
-		kfree(sentry);
+
+		if (atomic_read(&sentry->waitcount) != 0)
+			sentry->flags = RDT_DELETED;
+		else
+			kfree(sentry);
 	}
 }
 
@@ -2247,7 +2251,11 @@ static void rmdir_all_sub(void)
 
 		kernfs_remove(rdtgrp->kn);
 		list_del(&rdtgrp->rdtgroup_list);
-		kfree(rdtgrp);
+
+		if (atomic_read(&rdtgrp->waitcount) != 0)
+			rdtgrp->flags = RDT_DELETED;
+		else
+			kfree(rdtgrp);
 	}
 	/* Notify online CPUs to update per cpu storage and PQR_ASSOC MSR */
 	update_closid_rmid(cpu_online_mask, &rdtgroup_default);
-- 
1.8.3.1

