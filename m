Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 411EEC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 06:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 124032073D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 06:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JKwHnJc2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbfLLGOY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 01:14:24 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44552 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbfLLGOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 01:14:24 -0500
Received: by mail-pl1-f194.google.com with SMTP id az3so121868plb.11
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 22:14:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=1IZDs0iYiahgJEGSYbddkxkQujB2cMWGSHF0L+ZwSZo=;
        b=JKwHnJc2jYiNvGmsXPAObMNQADjvaWf8HH6d05W/W1oaoGBxyE4DFp8d863Wq9DNCK
         YV4kU+QNZ8Frw+TUkl5pu2R5AAqMuDsZnmIrnRCes8UbXqRIrPDjqjv88x6KeRmpeR5s
         R4KRMVRVT/O4cn6dE3R0W6HbcuCmPycoH5mIqs9bBzkrtEilP18sMYAoeohXPIlxtzRZ
         fo5yDX5hrSaNJhWKZ13I78iQU9+BSek1+lSVI2PM6DgBur2cQiopdw0fpn13JB0poO7H
         tRmyXyrtrgg1zJJ7xvFBddh0jT7+0HLYuqgA61nI5/oThgKtZTGyVBjqvb1XzzVzYso7
         eYKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1IZDs0iYiahgJEGSYbddkxkQujB2cMWGSHF0L+ZwSZo=;
        b=ahWepZ8sfpU2ZRoV1Jouou/lhw5xwbZwiaC9p2tBkLZXSN1u+fNeJgajdiD/7zWnS8
         sD4WiF3Kvq+xHcKs/64qyCecH+ynl1KA+pWTLC1qmFook9ExAboidEGqXz1MDeX7cS0L
         IT0lOKYtgLcCUX844yJBXHyMGajnb7tnZSbte2VKhWAV0ppaTvSnodyJUQP6EMl3Krpj
         Hq3MjYg2usAFpdr2mCKVUWQ6Xg5C8jJXcXZ4wpX9kzOhVyzlc/aUXqeY/sSvfvKsSfhD
         90RObo1bysRICTtYoC6BdZnQIHJHQdvXdh+6mVsa4goS9EgpA7YHD2JRBkwpggRuZUxE
         /qLg==
X-Gm-Message-State: APjAAAUIXgbmH90njPS3p6cqMUkyHe3c61Jg+e1jpCnIC5QO3SjpuvGt
        5nYCSo0M8VxXU31EeAfmbKM=
X-Google-Smtp-Source: APXvYqwWU5nRYfUe9rm1EOwmrfNBQdfc0meSTc6V0Kdz2roaHaIP6wS8z3p4cSckwmC9IhAgwzNvBw==
X-Received: by 2002:a17:902:9308:: with SMTP id bc8mr7896052plb.18.1576131263843;
        Wed, 11 Dec 2019 22:14:23 -0800 (PST)
Received: from localhost ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id p186sm5266532pfp.56.2019.12.11.22.14.22
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 11 Dec 2019 22:14:23 -0800 (PST)
From:   qiwuchen55@gmail.com
To:     peterz@infradead.org, mingo@kernel.org, oleg@redhat.com,
        christian.brauner@ubuntu.com
Cc:     kernel-team@android.com, linux-kernel@vger.kernel.org,
        chenqiwu <chenqiwu@xiaomi.com>
Subject: [PATCH] kernel/exit: do panic earlier to get coredump if global init task exit
Date:   Thu, 12 Dec 2019 14:14:15 +0800
Message-Id: <1576131255-3433-1-git-send-email-qiwuchen55@gmail.com>
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
issue. We need the test for signal_group_exit() to ensure that it is all
threads exiting and not just the current thread.

Of course testing signal_group_exit() is not sufficient. It is still
possible that this is someone calling exit(2) in an old binary or someone
calling pthread_exit(3) from the last thread of init. To handle that case,
we need the test to be:

(signal_group_exit(tsk->signal) || thread_group_empty(tsk)).

Because exiting the final thread of init should also trigger the panic.

Signed-off-by: chenqiwu <chenqiwu@xiaomi.com>
---
 kernel/exit.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/exit.c b/kernel/exit.c
index e10de98..ba7d1aa 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -578,10 +578,6 @@ static struct task_struct *find_child_reaper(struct task_struct *father,
 	}
 
 	write_unlock_irq(&tasklist_lock);
-	if (unlikely(pid_ns == &init_pid_ns)) {
-		panic("Attempted to kill init! exitcode=0x%08x\n",
-			father->signal->group_exit_code ?: father->exit_code);
-	}
 
 	list_for_each_entry_safe(p, n, dead, ptrace_entry) {
 		list_del_init(&p->ptrace_entry);
@@ -785,6 +781,9 @@ void __noreturn do_exit(long code)
 		panic("Aiee, killing interrupt handler!");
 	if (unlikely(!tsk->pid))
 		panic("Attempted to kill the idle task!");
+	if (unlikely(is_global_init(tsk) &&
+		(signal_group_exit(tsk->signal) || thread_group_empty(tsk))))
+		panic("Attempted to kill init! exitcode=0x%08lx\n", code);
 
 	/*
 	 * If do_exit is called because this processes oopsed, it's possible
-- 
1.9.1

