Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B44C282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 15:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B4272070E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 15:59:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729334AbgAHP73 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 10:59:29 -0500
Received: from mga11.intel.com ([192.55.52.93]:64327 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729314AbgAHP70 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 10:59:26 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jan 2020 07:59:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,410,1571727600"; 
   d="scan'208";a="395782709"
Received: from xshen14-linux.bj.intel.com ([10.238.155.105])
  by orsmga005.jf.intel.com with ESMTP; 08 Jan 2020 07:59:24 -0800
From:   Xiaochen Shen <xiaochen.shen@intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        tony.luck@intel.com, fenghua.yu@intel.com,
        reinette.chatre@intel.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, pei.p.jia@intel.com,
        xiaochen.shen@intel.com
Subject: [PATCH 2/4] x86/resctrl: Fix use-after-free due to inaccurate refcount of rdtgroup
Date:   Thu,  9 Jan 2020 00:28:04 +0800
Message-Id: <1578500886-21771-3-git-send-email-xiaochen.shen@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1578500886-21771-1-git-send-email-xiaochen.shen@intel.com>
References: <1578500886-21771-1-git-send-email-xiaochen.shen@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a race condition in following scenario which results in
use-after-free issue when reading a monitoring file and deleting the
parent ctrl_mon group concurrently:

Thread 1 calls atomic_inc() to take refcount of rdtgrp and then calls
kernfs_break_active_protection() to drop the active reference of kernfs
node in rdtgroup_kn_lock_live().

In Thread 2, kernfs_remove() is a blocking routine. It waits on all sub
kernfs nodes to drop the active reference when removing all subtree
kernfs nodes recursively. Thread 2 could block on kernfs_remove() until
Thread 1 calls kernfs_break_active_protection(). Only after
kernfs_remove() completes the refcount of rdtgrp could be trusted.

Before Thread 1 calls atomic_inc() and kernfs_break_active_protection(),
Thread 2 could call kfree() when the refcount of rdtgrp (sentry) is 0
instead of 1 due to the race.

In Thread 1, in rdtgroup_kn_unlock(), referring to earlier rdtgrp memory
(rdtgrp->waitcount) which was already freed in Thread 2 results in
use-after-free issue.

Thread 1 (rdtgroup_mondata_show)  Thread 2 (rdtgroup_rmdir)
--------------------------------  -------------------------
rdtgroup_kn_lock_live
  /*
   * kn active protection until
   * kernfs_break_active_protection(kn)
   */
  rdtgrp = kernfs_to_rdtgroup(kn)
                                  rdtgroup_kn_lock_live
                                    atomic_inc(&rdtgrp->waitcount)
                                    mutex_lock
                                  rdtgroup_rmdir_ctrl
                                    free_all_child_rdtgrp
                                      /*
                                       * sentry->waitcount should be 1
                                       * but is 0 now due to the race.
                                       */
                                      kfree(sentry)*[1]
  /*
   * Only after kernfs_remove()
   * completes, the refcount of
   * rdtgrp could be trusted.
   */
  atomic_inc(&rdtgrp->waitcount)
  /* kn->active-- */
  kernfs_break_active_protection(kn)
                                    rdtgroup_ctrl_remove
                                      rdtgrp->flags = RDT_DELETED
                                      /*
                                       * Blocking routine, wait for
                                       * all sub kernfs nodes to drop
                                       * active reference in
                                       * kernfs_break_active_protection.
                                       */
                                      kernfs_remove(rdtgrp->kn)
                                  rdtgroup_kn_unlock
                                    mutex_unlock
                                    atomic_dec_and_test(
                                                &rdtgrp->waitcount)
                                    && (flags & RDT_DELETED)
                                      kernfs_unbreak_active_protection(kn)
                                      kfree(rdtgrp)
  mutex_lock
mon_event_read
rdtgroup_kn_unlock
  mutex_unlock
  /*
   * Use-after-free: refer to earlier rdtgrp
   * memory which was freed in [1].
   */
  atomic_dec_and_test(&rdtgrp->waitcount)
  && (flags & RDT_DELETED)
    /* kn->active++ */
    kernfs_unbreak_active_protection(kn)
    kfree(rdtgrp)

Fix it by moving free_all_child_rdtgrp() to after kernfs_remove() in
rdtgroup_rmdir_ctrl() to ensure it has the accurate refcount of rdtgrp.

Cc: stable@vger.kernel.org
Fixes: f3cbeacaa06e ("x86/intel_rdt/cqm: Add rmdir support")
Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Xiaochen Shen <xiaochen.shen@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index e1df86da48cf..bb911c8f7cac 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2964,13 +2964,13 @@ static int rdtgroup_rmdir_ctrl(struct kernfs_node *kn, struct rdtgroup *rdtgrp,
 	closid_free(rdtgrp->closid);
 	free_rmid(rdtgrp->mon.rmid);
 
+	rdtgroup_ctrl_remove(kn, rdtgrp);
+
 	/*
 	 * Free all the child monitor group rmids.
 	 */
 	free_all_child_rdtgrp(rdtgrp);
 
-	rdtgroup_ctrl_remove(kn, rdtgrp);
-
 	return 0;
 }
 
-- 
1.8.3.1

