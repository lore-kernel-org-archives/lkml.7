Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC66C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 19:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 537A3206A5
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 19:13:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728302AbfLKTNY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 14:13:24 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:51148 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbfLKTNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 14:13:23 -0500
Received: from mail-wm1-f72.google.com ([209.85.128.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <ioanna-maria.alifieraki@canonical.com>)
        id 1if7QH-00071V-7U
        for linux-kernel@vger.kernel.org; Wed, 11 Dec 2019 19:13:21 +0000
Received: by mail-wm1-f72.google.com with SMTP id s25so2003717wmj.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 11:13:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=jzYT29QgY+7UHFgdoHu0QBm0Uqa+lUShkE/eEJ71gVk=;
        b=BVCssLHHxsMFFKVdev/CrCrrPPA5Vla5sScVsC3CaTKOobHNCDaUDeUVu2Hn/rimea
         px850lHN8Nx+GnUOr5EUFMeyHZ3u7Li7Og0JNIciopycAyWEZiOKDmxZ7ncEv0lNuiId
         A82zVMUKCrA/UtX6cLBHUMXZ5C3YInNU0M9awNzUtcLLLWo7QZZuzfEaEBvqLTH7NZAC
         t0COmcfRlzcXfVNbQ5h4qrfcDEy2osyqsvnZKq8nSUK0Q9uCdTiNHbHw1OsOe6pPk07p
         +JMO2N8eYfJtohQec4bYSXRx7xFCn9vpf4V3Uc/qVeJZFDhVuX+8ojKT9UKBymOG5aMj
         7WjQ==
X-Gm-Message-State: APjAAAXFGomm8p6sKDHlyqR51q8Iz2jQZRdwlsm9TqtwS7kNFVjyeyv3
        ZPd2MO4J63pHTj+w4V/gtLJIYXfu3hgRkAO37Ak3fR20rotU+8/9efp94NNdBaNTfeJQNVSfMa5
        bAzpbsg25PQXoPaZqxjQQnwvtny/f3W4jpHfSV2l8vw==
X-Received: by 2002:adf:f6c1:: with SMTP id y1mr1610788wrp.17.1576091600764;
        Wed, 11 Dec 2019 11:13:20 -0800 (PST)
X-Google-Smtp-Source: APXvYqzwFzE2pv93DS4d1vxLF0UprQQCPMIj/lOhvP+CMy7YGTagIRrGQrD4LprUPCgxFUROkCmeXA==
X-Received: by 2002:adf:f6c1:: with SMTP id y1mr1610764wrp.17.1576091600469;
        Wed, 11 Dec 2019 11:13:20 -0800 (PST)
Received: from localhost ([2a02:587:2809:f00:490b:2c5e:1140:fdf2])
        by smtp.gmail.com with ESMTPSA id l3sm3295180wrt.29.2019.12.11.11.13.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Dec 2019 11:13:19 -0800 (PST)
From:   Ioanna Alifieraki <ioanna-maria.alifieraki@canonical.com>
To:     akpm@linux-foundation.org, manfred@colorfullife.com,
        herton@redhat.com, arnd@arndb.de, catalin.marinas@arm.com,
        malat@debian.org, joel@joelfernandes.org, gustavo@embeddedor.com,
        linux-kernel@vger.kernel.org, jay.vosburgh@canonical.com,
        ioanna.alifieraki@gmail.com
Subject: [PATCH] Revert "ipc,sem: remove uneeded sem_undo_list lock usage in exit_sem()"
Date:   Wed, 11 Dec 2019 19:13:18 +0000
Message-Id: <20191211191318.11860-1-ioanna-maria.alifieraki@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit a97955844807e327df11aa33869009d14d6b7de0.

Commit a97955844807 ("ipc,sem: remove uneeded sem_undo_list lock usage
in exit_sem()") removes a lock that is needed. This leads to a process
looping infinitely in exit_sem() and can also lead to a crash.  There is
a reproducer available in [1] and with the commit reverted the issue
does not reproduce anymore.

Using the reproducer found in [1] is fairly easy to reach a point where
one of the child processes is looping infinitely in exit_sem between
for(;;) and if (semid == -1) block, while it's trying to free its last
sem_undo structure which has already been freed by freeary().

Each sem_undo struct is on two lists: one per semaphore set (list_id)
and one per process (list_proc).  The list_id list tracks undos by
semaphore set, and the list_proc by process.

Undo structures are removed either by freeary() or by exit_sem().  The
freeary function is invoked when the user invokes a syscall to remove a
semaphore set.  During this operation freeary() traverses the list_id
associated with the semaphore set and removes the undo structures from
both the list_id and list_proc lists.

For this case, exit_sem() is called at process exit.  Each process
contains a struct sem_undo_list (referred to as "ulp") which contains
the head for the list_proc list. When the process exits, exit_sem()
traverses this list to remove each sem_undo struct. As in freeary(),
whenever a sem_undo struct is removed from list_proc, it is also removed
from the list_id list.

Removing elements from list_id is safe for both exit_sem() and freeary()
due to sem_lock().  Removing elements from list_proc is not safe;
freeary() locks &un->ulp->lock when it performs
list_del_rcu(&un->list_proc) but exit_sem() does not (locking was
removed by commit a97955844807 ("ipc,sem: remove uneeded sem_undo_list
lock usage in exit_sem()").

This can result in the following situation while executing the
reproducer [1] : Consider a child process in exit_sem() and the parent
in freeary() (because of semctl(sid[i], NSEM, IPC_RMID)).  The list_proc
for the child contains the last two undo structs A and B (the rest have
been removed either by exit_sem() or freeary()).  The semid for A is 1
and semid for B is 2.  exit_sem() removes A and at the same time
freeary() removes B. Since A and B have different semid sem_lock() will
acquire different locks for each process and both can proceed.  The bug
is that they remove A and B from the same list_proc at the same time
because only freeary() acquires the ulp lock.  When exit_sem() removes A
it makes ulp->list_proc.next to point at B and at the same time
freeary() removes B setting B->semid=-1.  At the next iteration of
for(;;) loop exit_sem() will try to remove B.  The only way to break
from for(;;) is for (&un->list_proc == &ulp->list_proc) to be true which
is not.  Then exit_sem() will check if B->semid=-1 which is and will
continue looping in for(;;) until the memory for B is reallocated and
the value at B->semid is changed. At that point, exit_sem() will crash
attempting to unlink B from the lists (this can be easily triggered by
running the reproducer [1] a second time).

To prove this scenario instrumentation was added to keep information
about each sem_undo (un) struct that is removed per process and per
semaphore set (sma).

        CPU0                                CPU1
[caller holds sem_lock(sma for A)]      ...
freeary()                               exit_sem()
...                                     ...
...                                     sem_lock(sma for B)
spin_lock(A->ulp->lock)                 ...
list_del_rcu(un_A->list_proc)           list_del_rcu(un_B->list_proc)

Undo structures A and B have different semid and sem_lock() operations
proceed. However they belong to the same list_proc list and they are
removed at the same time. This results into ulp->list_proc.next pointing
to the address of B which is already removed.

After reverting commit a97955844807 ("ipc,sem: remove uneeded
sem_undo_list lock usage in exit_sem()") the issue was no longer
reproducible.

[1] https://bugzilla.redhat.com/show_bug.cgi?id=1694779

Fixes: a97955844807 ("ipc,sem: remove uneeded sem_undo_list lock usage in exit_sem()")
Signed-off-by: Ioanna Alifieraki <ioanna-maria.alifieraki@canonical.com>
---
 ipc/sem.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/ipc/sem.c b/ipc/sem.c
index ec97a7072413..fe12ea8dd2b3 100644
--- a/ipc/sem.c
+++ b/ipc/sem.c
@@ -2368,11 +2368,9 @@ void exit_sem(struct task_struct *tsk)
 		ipc_assert_locked_object(&sma->sem_perm);
 		list_del(&un->list_id);
 
-		/* we are the last process using this ulp, acquiring ulp->lock
-		 * isn't required. Besides that, we are also protected against
-		 * IPC_RMID as we hold sma->sem_perm lock now
-		 */
+		spin_lock(&ulp->lock);
 		list_del_rcu(&un->list_proc);
+		spin_unlock(&ulp->lock);
 
 		/* perform adjustments registered in un */
 		for (i = 0; i < sma->sem_nsems; i++) {
-- 
2.17.1

