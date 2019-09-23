Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30957C3A5A6
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 03:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03EAA20640
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 03:17:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404753AbfIWDRC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 23:17:02 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:14220 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403994AbfIWDRC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 23:17:02 -0400
Received: from mse-fl2.zte.com.cn (unknown [10.30.14.239])
        by Forcepoint Email with ESMTPS id EFF8484E5BE450315C9E;
        Mon, 23 Sep 2019 11:16:59 +0800 (CST)
Received: from notes_smtp.zte.com.cn (notes_smtp.zte.com.cn [10.30.1.239])
        by mse-fl2.zte.com.cn with ESMTP id x8N3Gn5A049438;
        Mon, 23 Sep 2019 11:16:49 +0800 (GMT-8)
        (envelope-from cui.yunfeng@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019092311165099-3787446 ;
          Mon, 23 Sep 2019 11:16:50 +0800 
From:   Yunfeng Cui <cui.yunfeng@zte.com.cn>
To:     christian@brauner.io
Cc:     keescook@chromium.org, luto@amacapital.net, wad@chromium.org,
        akpm@linux-foundation.org, peterz@infradead.org, mingo@kernel.org,
        mhocko@suse.com, elena.reshetova@intel.com, aarcange@redhat.com,
        ldv@altlinux.org, arunks@codeaurora.org, guro@fb.com,
        joel@joelfernandes.org, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, xue.zhihong@zte.com.cn,
        wang.yi59@zte.com.cn, jiang.xuexin@zte.com.cn,
        Yunfeng Cui <cui.yunfeng@zte.com.cn>
Subject: [PATCH] futex: robust futex maybe never be awaked, on rare situation.
Date:   Mon, 23 Sep 2019 11:18:20 +0800
Message-Id: <1569208700-24044-1-git-send-email-cui.yunfeng@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-09-23 11:16:51,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-09-23 11:16:49,
        Serialize complete at 2019-09-23 11:16:49
X-MAIL: mse-fl2.zte.com.cn x8N3Gn5A049438
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I use model checker find a issue of robust and pi futex. On below
situation, the owner can't find something in pi_state_list, while
the requester will be blocked, never be awaked.

CPU0                       CPU1
                           futex_lock_pi
                           /*some cs code*/
futex_lock_pi
  futex_lock_pi_atomic
    ...
    newval = uval | FUTEX_WAITERS;
    ret = lock_pi_update_atomic(uaddr, uval, newval);
    ...
    attach_to_pi_owner
     ....
     p = find_get_task_by_vpid(pid);
     if (!p)
       return handle_exit_race(uaddr, uval, NULL);
       ....
       raw_spin_lock_irq(&p->pi_lock);
       ....
       pi_state = alloc_pi_state();
       ....
                           do_exit->mm_release
                           if (unlikely(tsk->robust_list)) {
                             exit_robust_list(tsk);
                             tsk->robust_list = NULL;
                           }
                           if (unlikely(!list_empty(&tsk->pi_state_list)))
                             exit_pi_state_list(tsk); /*WILL MISS*/
      list_add(&pi_state->list, &p->pi_state_list);
    WILL BLOCKED, NEVER WAKEUP!

Signed-off-by: Yunfeng Cui <cui.yunfeng@zte.com.cn>
Reviewed-by: Bo Wang <wang.bo116@zte.com.cn>
Reviewed-by: Yi Wang <wang.yi59@zte.com.cn>
---
 kernel/fork.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 53e780748fe3..58b90f21dac4 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1277,15 +1277,16 @@ void mm_release(struct task_struct *tsk, struct mm_struct *mm)
 	if (unlikely(tsk->robust_list)) {
 		exit_robust_list(tsk);
 		tsk->robust_list = NULL;
+		/*Check pi_state_list of task on pi_lock be acquired*/
+		exit_pi_state_list(tsk);
 	}
 #ifdef CONFIG_COMPAT
 	if (unlikely(tsk->compat_robust_list)) {
 		compat_exit_robust_list(tsk);
 		tsk->compat_robust_list = NULL;
+		exit_pi_state_list(tsk);
 	}
 #endif
-	if (unlikely(!list_empty(&tsk->pi_state_list)))
-		exit_pi_state_list(tsk);
 #endif
 
 	uprobe_free_utask(tsk);
-- 
2.15.2

