Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECF1DC4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 15:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0A192146E
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 15:39:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uuB0lD3f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbfI0Pj5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 11:39:57 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43569 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727427AbfI0Pj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 11:39:57 -0400
Received: by mail-qt1-f193.google.com with SMTP id c3so7783488qtv.10
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 08:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Cpv5ZNVm9yUOsy7vshEHjPrRDw5bm6guIdo54Z4wEpg=;
        b=uuB0lD3fcX2NayhCWqNwWoaQ88d7SNLOxTyN4fzAmIqh8st6lYIXQC+nvvTJBHS0NL
         KiFSFOo7oS7qcCNMq1H3zbtN5RRxQ/0pUTPeLFjs1ewSzaJu0cQX0zn6ljqwWNH1gBQ4
         dP1bI3AqhMO1jDx71uSRcuzRXDAbfZjfFAcG+pbeOtQSCu6ZrqIA7f0JOEM0GowXTcqw
         TGh4qbSEAcN8L5aIceACCVcqBUUcIlASjkTxVczSVYHCACkOK/la/iMONawnFo2RVBeL
         cJdp3OC90dbVziwQS9BssT9M3NWJYRHnqY43xXtI5ULv9VmxuDjknrND3GmVF1RuvWfG
         ZhLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Cpv5ZNVm9yUOsy7vshEHjPrRDw5bm6guIdo54Z4wEpg=;
        b=g/nmdd2f1h9V8r6F/iF+xSAFQ5xYXcBRgPEbk2BiXa606qZHMVk8bbBgCn443ogaPE
         JlwLyHU6IheUEclUZc3B209SG5+gl3gSx6OIeG+IeAzFvOJ8tOpWWzvHATB8ScmRG/XW
         tMFfQA8JAQbsRXtNWlnLhymUYLk1/gMr8lVnnA8HJLEYeKbqYR8xlckYqpBJLZHiJB3+
         L7HnjRCCvkbCIZfFQ40mefDuvYQp44ScXk5dq5E9Ln/ZqyqNadS1uHXHUAS3gDSJcH3M
         2SEYKHbOsPCtLmIMHXVzEgAmCY2WXMA+esvBXlbny8izosQ5Y2PjPRzBMVBHhA4FCVai
         vO9w==
X-Gm-Message-State: APjAAAWpZ5MCuv2KRU/1bYVf+zbdUfJZ5huNxjK86YrD7Bpfj0g9dP0/
        MFHKtelDmW25CCX3NYn4gg==
X-Google-Smtp-Source: APXvYqxjo3cjsefaUMK6ihV7YZ9PbwXglYSh5Frdyx7pyyNvt1hnrtIPMjj+3egFABrR+y/qG6ILeQ==
X-Received: by 2002:a0c:d6c9:: with SMTP id l9mr8321121qvi.179.1569598796511;
        Fri, 27 Sep 2019 08:39:56 -0700 (PDT)
Received: from gabell.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id n42sm3030137qta.31.2019.09.27.08.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2019 08:39:55 -0700 (PDT)
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Dave Martin <Dave.Martin@arm.com>,
        Julien Grall <julien.grall@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64/sve: Fix wrong free for task->thread.sve_state
Date:   Fri, 27 Sep 2019 11:39:49 -0400
Message-Id: <20190927153949.29870-1-msys.mizuma@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

The system which has SVE feature crashed because of
the memory pointed by task->thread.sve_state was destroyed
by someone.

That is because sve_state is freed while the forking the
child process. The child process has the pointer of sve_state
which is same as the parent's because the child's task_struct
is copied from the parent's one. If the copy_process()
fails as an error on somewhere, for example, copy_creds(),
then the sve_state is freed even if the parent is alive.
The flow is as follows.

copy_process
        p = dup_task_struct
            => arch_dup_task_struct
                *dst = *src;  // copy the entire region.
:
        retval = copy_creds
        if (retval < 0)
                goto bad_fork_free;
:
bad_fork_free:
...
        delayed_free_task(p);
          => free_task
             => arch_release_task_struct
                => fpsimd_release_task
                   => __sve_free
                      => kfree(task->thread.sve_state);
                         // free the parent's sve_state

Move child's sve_state = NULL and clearing TIF_SVE flag
to arch_dup_task_struct() so that the child doesn't free the
parent's one.

Cc: stable@vger.kernel.org
Fixes: bc0ee4760364 ("arm64/sve: Core task context handling")
Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Reported-by: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Suggested-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm64/kernel/process.c | 21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index f674f28df..6937f5935 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -323,22 +323,16 @@ void arch_release_task_struct(struct task_struct *tsk)
 	fpsimd_release_task(tsk);
 }
 
-/*
- * src and dst may temporarily have aliased sve_state after task_struct
- * is copied.  We cannot fix this properly here, because src may have
- * live SVE state and dst's thread_info may not exist yet, so tweaking
- * either src's or dst's TIF_SVE is not safe.
- *
- * The unaliasing is done in copy_thread() instead.  This works because
- * dst is not schedulable or traceable until both of these functions
- * have been called.
- */
 int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 {
 	if (current->mm)
 		fpsimd_preserve_current_state();
 	*dst = *src;
 
+	BUILD_BUG_ON(!IS_ENABLED(CONFIG_THREAD_INFO_IN_TASK));
+	dst->thread.sve_state = NULL;
+	clear_tsk_thread_flag(dst, TIF_SVE);
+
 	return 0;
 }
 
@@ -351,13 +345,6 @@ int copy_thread(unsigned long clone_flags, unsigned long stack_start,
 
 	memset(&p->thread.cpu_context, 0, sizeof(struct cpu_context));
 
-	/*
-	 * Unalias p->thread.sve_state (if any) from the parent task
-	 * and disable discard SVE state for p:
-	 */
-	clear_tsk_thread_flag(p, TIF_SVE);
-	p->thread.sve_state = NULL;
-
 	/*
 	 * In case p was allocated the same task_struct pointer as some
 	 * other recently-exited task, make sure p is disassociated from
-- 
2.18.1

