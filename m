Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B59EDC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 06:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E3B421582
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 06:30:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jwFzhoYw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbfLSGaB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 01:30:01 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40684 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbfLSGaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 01:30:01 -0500
Received: by mail-pf1-f196.google.com with SMTP id q8so2612352pfh.7
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 22:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=o0Z0PdCY/AlFHef0+0Esdi5iDxbdo7YqxSYlU8fJbE4=;
        b=jwFzhoYwdc9HtucR6mJjAQAG0JREF3qvTM/urqi/hLiZAT7WFrUzPTG0Q+kqqTPZH7
         S0x7uL43FydWWgCS6GrVKwICSK+y++iw5VHpdVH0cgtN5e0fn7S22qfejAQ/lRQYfLdk
         uLZwEaWMv2Gwf2YMRlLH/fA2HP7wnv2QWXQi3O2r4gjyNo+PYbufFzc9KfzyFlpTKfjq
         CW4wy/uHFOfgIEkS8F8d7rLAT22PX88yLP8b07reD3AapYCc7R02Fo+weldfFABkl/DZ
         rQK/9ni51B8U7F+dIex09nzM1FXMNYPv8Dj8I2CHHmd63CqP267g+eyKnCw8qihz3X0m
         F1CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=o0Z0PdCY/AlFHef0+0Esdi5iDxbdo7YqxSYlU8fJbE4=;
        b=VQKDTdIbkISi96fCz9AjyFfP1cCidskBmpz0bI5T6fwsVuMLKcMn2fDgc9WaqGIFg3
         SrCjMU9aNZerSyjlF5ENbV+ThHzFbM3NtfJ7xZ9HblYiO/V7nn1M3GNWGJwYMXFYgYaz
         z8MRbW3UssdQv1rICl4syMr0ERa+xU1Q6DdFtPjKzCJUcQV4XsQ/T8RXhgX0tQ6qWN6i
         APsvtYYwc6teets306RQ+QTuJa7gsKWUCI9yb3FTrmnJdQ8dIvq45ApK7Ex0r4pLBNUK
         2HdgJm/zG5Z8/vCwkEZ9HEJsLCieeCbZSKQm2wwumqqxlGbJnIUTf4lS2HQ/N9IWZdJT
         Gu1g==
X-Gm-Message-State: APjAAAXwb8j6lHrVv45kpR631M+peoKY68g+gVnVlgI154FYcZkAyIm4
        yZ374gOenPJOhej8MzXc5bQ=
X-Google-Smtp-Source: APXvYqy31FODF3lUpKAbAeuXz8+5GC+p8VjMleEl51NnaadC3Z9dAG2pmCwNrcDUdjTdjQ+B/UAfuw==
X-Received: by 2002:a62:ed19:: with SMTP id u25mr8005031pfh.173.1576737000557;
        Wed, 18 Dec 2019 22:30:00 -0800 (PST)
Received: from localhost ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id h26sm6584696pfr.9.2019.12.18.22.29.59
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 18 Dec 2019 22:30:00 -0800 (PST)
From:   qiwuchen55@gmail.com
To:     christian.brauner@ubuntu.com, peterz@infradead.org,
        mingo@kernel.org, oleg@redhat.com, prsood@codeaurora.org
Cc:     kernel-team@android.com, linux-kernel@vger.kernel.org,
        chenqiwu@xiaomi.com
Subject: [PATCH v3] kernel/exit: do panic earlier to get coredump if global init task exit
Date:   Thu, 19 Dec 2019 14:29:53 +0800
Message-Id: <1576736993-10121-1-git-send-email-qiwuchen55@gmail.com>
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
it is all threads exiting and not just the current thread.

Signed-off-by: chenqiwu <chenqiwu@xiaomi.com>
---
changes in v3:
 - move panic into group_dead condition.
 - keep exitcode as the original code does.
 - fix logic error for comment.
---
 kernel/exit.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/kernel/exit.c b/kernel/exit.c
index bcbd598..7271e13 100644
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
@@ -766,6 +762,15 @@ void __noreturn do_exit(long code)
 	acct_update_integrals(tsk);
 	group_dead = atomic_dec_and_test(&tsk->signal->live);
 	if (group_dead) {
+		/*
+		 * If the last thread of global init exit, do panic
+		 * immeddiately to get the coredump to find any clue
+		 * for init task in userspace.
+		 */
+		if (unlikely(is_global_init(tsk)))
+			panic("Attempted to kill init! exitcode=0x%08x\n",
+				tsk->signal->group_exit_code ?: (int)code);
+
 #ifdef CONFIG_POSIX_TIMERS
 		hrtimer_cancel(&tsk->signal->real_timer);
 		exit_itimers(tsk->signal);
-- 
1.9.1

