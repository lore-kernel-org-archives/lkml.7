Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E674EC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 03:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B74FC20717
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 03:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r+VR4/td"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbfLPDTE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Dec 2019 22:19:04 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46861 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbfLPDTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 22:19:04 -0500
Received: by mail-pl1-f193.google.com with SMTP id k20so3809996pll.13
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2019 19:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=0uEDsgHMv4cULjo4F/xF85KkS+R390ZRONMVXKwnCXM=;
        b=r+VR4/tdbWcRiCEf6dJp3Dj+xHgvbG8fG/rzgSWVZQ8eiOFxMwVcQ/D9JsTyEhLYRw
         mzwPE0+y4RyvO3NOlVrhh5P6TEGCQ29CNCYjjMzDVjJ/zQS82+k4UFD7qgByYHBI6n91
         MCeM1J0p+7JA3ut9neePic9BfkiBspY2AyXpLj55xtS/wQQ7sWLgFKjvkou4NsnSOL1y
         THzCNxAGClUdZ1Z35ImW2Srqv40VoRoL+eT6Us8j32hvy+cYt26hrJ6FuIf6sFk0Fw/t
         JoklsYYDRnNSNfWBs5gQWkLJzYgtvC77zqOwkRKV0K5+2cwmGspAWCG3vTiMB4lxn9dm
         lDWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0uEDsgHMv4cULjo4F/xF85KkS+R390ZRONMVXKwnCXM=;
        b=Ewz/vn49abyho9wZdnZ8nj5iQTSVFDYTjbJGTHIqlOgmskgmLOFDXy/jQaNMNY5ndL
         MNmynx/FMkLPSR3jPizNaCEatYVrF41znKkbaj4jJ2of2o82olpWhE9/tC/qlCAJT6jD
         Vg15vy2UGSLfwCogEwlHjEQe8tNNxuvsDoQ9yKlc0G0ygoMMAuQfHDV4D9UXuaB+pdeR
         9E89U8yjL4UNdLK9o7Y7ztYO2KYv04U03LKKOVQ7pFBsPdCVqaZKy47LIKSzLjRW01Xf
         f8C53WT1+qu0jLWUErIAqxOLvbUpfhClReHy98sdqtzktQFVUCBJVHz2QG/C0GmMCW7G
         U8pw==
X-Gm-Message-State: APjAAAXW+RVUs646mfJcb9q9aqAVuURvuE/nHZRuaMaDaB+KXjzfaL/s
        XGu8Gt9ymYVYDdfDg1cBs5M=
X-Google-Smtp-Source: APXvYqyZsejWK8jAP1ashdFJ4pbcGuHs1CBQn+M9278Iwp8tK9mWWOvG0ZXYXYiaZvo7kW+dvnOtgg==
X-Received: by 2002:a17:90a:1b6b:: with SMTP id q98mr15523879pjq.106.1576466344020;
        Sun, 15 Dec 2019 19:19:04 -0800 (PST)
Received: from localhost ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id k16sm20175468pfh.97.2019.12.15.19.19.02
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 15 Dec 2019 19:19:03 -0800 (PST)
From:   qiwuchen55@gmail.com
To:     christian.brauner@ubuntu.com, peterz@infradead.org,
        mingo@kernel.org, oleg@redhat.com
Cc:     kernel-team@android.com, linux-kernel@vger.kernel.org,
        chenqiwu@xiaomi.com
Subject: [PATCH v2] kernel/exit: do panic earlier to get coredump if global init task exit
Date:   Mon, 16 Dec 2019 11:18:44 +0800
Message-Id: <1576466324-6067-1-git-send-email-qiwuchen55@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: chenqiwu <chenqiwu@xiaomi.com>

When global init task get a chance to be killed, panic will happen in
later calling steps by do_exit()->exit_notify()->forget_original_parent()
->find_child_reaper() if all init threads have exited.

However, it's hard to extract the coredump of init task from a kernel
crashdump, since exit_mm() has released its mm before panic. In order
to get the backtrace of init task in userspace, it's better to do panic
earlier at the beginning of exitting route.

It's worth noting that we must take case of a multi-threaded init exitting
issue. We need the test for is_global_init() && group_dead to ensure that
it is all of init threads exiting and not just the current thread.

Signed-off-by: chenqiwu <chenqiwu@xiaomi.com>
---
changes in v2:
 - using is_global_init() && group_dead as panic condition.
 - move up group_dead = atomic_dec_and_test(&tsk->signal->live).
 - add comment for this change in do_exit().
---
 kernel/exit.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/kernel/exit.c b/kernel/exit.c
index bcbd598..33364c8 100644
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
@@ -728,6 +724,14 @@ void __noreturn do_exit(long code)
 		panic("Attempted to kill the idle task!");
 
 	/*
+	 * If all threads of global init have exited, do panic imeddiately
+	 * to get the coredump to find any clue for init task in userspace.
+	 */
+	group_dead = atomic_dec_and_test(&tsk->signal->live);
+	if (unlikely(is_global_init(tsk) && group_dead))
+		panic("Attempted to kill init! exitcode=0x%08lx\n", code);
+
+	/*
 	 * If do_exit is called because this processes oopsed, it's possible
 	 * that get_fs() was left as KERNEL_DS, so reset it to USER_DS before
 	 * continuing. Amongst other possible reasons, this is to prevent
@@ -764,7 +768,6 @@ void __noreturn do_exit(long code)
 	if (tsk->mm)
 		sync_mm_rss(tsk->mm);
 	acct_update_integrals(tsk);
-	group_dead = atomic_dec_and_test(&tsk->signal->live);
 	if (group_dead) {
 #ifdef CONFIG_POSIX_TIMERS
 		hrtimer_cancel(&tsk->signal->real_timer);
-- 
1.9.1

