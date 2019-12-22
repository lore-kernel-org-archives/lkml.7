Return-Path: <SRS0=7h0X=2M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 300EBC2D0C8
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Dec 2019 16:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02A79206CB
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Dec 2019 16:56:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbfLVQ4o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Dec 2019 11:56:44 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:39808 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbfLVQ4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Dec 2019 11:56:44 -0500
Received: from [172.58.30.161] (helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1ij4Wz-0007EQ-LL; Sun, 22 Dec 2019 16:56:38 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     christian.brauner@ubuntu.com
Cc:     chenqiwu@xiaomi.com, kernel-team@android.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org, oleg@redhat.com,
        peterz@infradead.org, prsood@codeaurora.org, qiwuchen55@gmail.com
Subject: Applied patch "exit: panic before exit_mm() on global init exit"
Date:   Sun, 22 Dec 2019 17:56:11 +0100
Message-Id: <20191222165610.17637-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <1211FB6C-ECD6-4D4A-8353-4D103C1C5054@ubuntu.com>
References: <1211FB6C-ECD6-4D4A-8353-4D103C1C5054@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've added the patch:

  exit: panic before exit_mm() on global init exit

to
  https://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git/log/?h=fixes

I've rewritten the commit message and fixed a typo in the comment.

If noone objects this will be part of the threads-fixes pr early next week.

Thanks!
Christian

From 43cf75d96409a20ef06b756877a2e72b10a026fc Mon Sep 17 00:00:00 2001
From: chenqiwu <chenqiwu@xiaomi.com>
Date: Thu, 19 Dec 2019 14:29:53 +0800
Subject: [PATCH] exit: panic before exit_mm() on global init exit

Currently, when global init and all threads in its thread-group have exited
we panic via:
do_exit()
-> exit_notify()
   -> forget_original_parent()
      -> find_child_reaper()
This makes it hard to extract a useable coredump for global init from a
kernel crashdump because by the time we panic exit_mm() will have already
released global init's mm.
This patch moves the panic futher up before exit_mm() is called. As was the
case previously, we only panic when global init and all its threads in the
thread-group have exited.

Signed-off-by: chenqiwu <chenqiwu@xiaomi.com>
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
Acked-by: Oleg Nesterov <oleg@redhat.com>
[christian.brauner@ubuntu.com: fix typo, rewrite commit message]
Link: https://lore.kernel.org/r/1576736993-10121-1-git-send-email-qiwuchen55@gmail.com
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 kernel/exit.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/kernel/exit.c b/kernel/exit.c
index a46a50d67002..fc364272759d 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -517,10 +517,6 @@ static struct task_struct *find_child_reaper(struct task_struct *father,
 	}
 
 	write_unlock_irq(&tasklist_lock);
-	if (unlikely(pid_ns == &init_pid_ns)) {
-		panic("Attempted to kill init! exitcode=0x%08x\n",
-			father->signal->group_exit_code ?: father->exit_code);
-	}
 
 	list_for_each_entry_safe(p, n, dead, ptrace_entry) {
 		list_del_init(&p->ptrace_entry);
@@ -786,6 +782,14 @@ void __noreturn do_exit(long code)
 	acct_update_integrals(tsk);
 	group_dead = atomic_dec_and_test(&tsk->signal->live);
 	if (group_dead) {
+		/*
+		 * If the last thread of global init has exited, panic
+		 * immediately to get a useable coredump.
+		 */
+		if (unlikely(is_global_init(tsk)))
+			panic("Attempted to kill init! exitcode=0x%08x\n",
+				tsk->signal->group_exit_code ?: (int)code);
+
 #ifdef CONFIG_POSIX_TIMERS
 		hrtimer_cancel(&tsk->signal->real_timer);
 		exit_itimers(tsk->signal);
-- 
2.24.0

