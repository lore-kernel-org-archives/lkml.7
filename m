Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E502EC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 19:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C09C6217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 19:09:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j1WQtp9e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728583AbfIZTJa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 15:09:30 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35360 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727707AbfIZTJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 15:09:30 -0400
Received: by mail-qk1-f194.google.com with SMTP id w2so2753249qkf.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 12:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0YzzG8xxLRO9x05MMXHNcmaWt4m3lyixn3G0cfw2LTY=;
        b=j1WQtp9el6RXeSS/dMWW2hEkAa2+QmSTgqf/WCfndmMkgGSwKeb0WsBZXeIs4TVO8K
         44LxE9aKNaDTVUkYl7+iZOQFKAQH3MQHKRKnQNmJOo31EhyFWyf6WAB/nXbdHl33hQ+v
         tdonJhz8db6WvQJr5eKInwpziJBIJD7r8/xOk0Ao8vsyXQzSIlhJGCjGJe1d87r9y6Ww
         izr4jPsKA5Ubm/kt9AvwF3ofJyRzOTu0k5rr/uGDgFWJqK60P7geo/U5mHDbYUjbs+Do
         Oy27ns7sXbqJN0vKgAqTfn/09tU6oTn9SmlLDwRS/qRMdmCNQxHI70XWNSEzoN09no++
         Uomw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0YzzG8xxLRO9x05MMXHNcmaWt4m3lyixn3G0cfw2LTY=;
        b=QQtXjx+dk/wmxEgy2+7bpV9siUxYekhGrNsPz6i0liulWdhZR4b6VPYng+V+Bo5Ec3
         wec0lKWIgXtJxGU1dFum+0EnJ3TRe0JUfNwbfi4tG7Zf9Voz9Y22WrMb9kpjzzU7Rqwq
         0WUmq07JUZyCxpKl6upCLnUpPr+341/rIQFI4H4ZmR0LHdLwagm7BlNM+3YKuccz/jQB
         MWFuC2F3fnaMAeBHiknGv85s6Q9sE/XG901B4xyooHn7Gd6gmU086bcWMbLdAK1bvnzl
         zYUU18dh2+hcv3JH8GrwS97fEDGjjYFrMxEmA8b404sPBxvfrOy+hMHxLU/o/g4WOufE
         X2EQ==
X-Gm-Message-State: APjAAAW38wU/6WizzJAcH4oNaW7VtyfSEJFt5bmUXNnMMaWj0gmDJDH7
        /4iaJlAIIDAnf6Y64ptcng==
X-Google-Smtp-Source: APXvYqwSOSysU8P4nrm7m2YCc3HaQgA+s3t7B4xfHD2euxlUm4qo1UJU3wTeA5BCin4DflQBMogvNA==
X-Received: by 2002:a37:dc06:: with SMTP id v6mr400739qki.163.1569524967525;
        Thu, 26 Sep 2019 12:09:27 -0700 (PDT)
Received: from gabell.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id f144sm40062qke.132.2019.09.26.12.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 12:09:27 -0700 (PDT)
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] arm64/sve: Fix wrong free for task->thread.sve_state
Date:   Thu, 26 Sep 2019 15:08:46 -0400
Message-Id: <20190926190846.3072-2-msys.mizuma@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190926190846.3072-1-msys.mizuma@gmail.com>
References: <20190926190846.3072-1-msys.mizuma@gmail.com>
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

Add a flag in task->thread which shows the fork is in progress.
If the fork is in progress, that means the child has the pointer
to the parent's sve_state, doesn't free the sve_state.

Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Reported-by: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
---
 arch/arm64/include/asm/processor.h | 1 +
 arch/arm64/kernel/fpsimd.c         | 6 ++++--
 arch/arm64/kernel/process.c        | 2 ++
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index 5623685c7d13..3ca3e350145a 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -143,6 +143,7 @@ struct thread_struct {
 	unsigned long		fault_address;	/* fault info */
 	unsigned long		fault_code;	/* ESR_EL1 value */
 	struct debug_info	debug;		/* debugging */
+	unsigned int		fork_in_progress;
 #ifdef CONFIG_ARM64_PTR_AUTH
 	struct ptrauth_keys	keys_user;
 #endif
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 37d3912cfe06..8641db4cb062 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -202,8 +202,10 @@ static bool have_cpu_fpsimd_context(void)
  */
 static void __sve_free(struct task_struct *task)
 {
-	kfree(task->thread.sve_state);
-	task->thread.sve_state = NULL;
+	if (!task->thread.fork_in_progress) {
+		kfree(task->thread.sve_state);
+		task->thread.sve_state = NULL;
+	}
 }
 
 static void sve_free(struct task_struct *task)
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index a47462def04b..8ac0ee4e5f76 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -347,6 +347,7 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 	if (current->mm)
 		fpsimd_preserve_current_state();
 	*dst = *src;
+	dst->thread.fork_in_progress = 1;
 
 	return 0;
 }
@@ -365,6 +366,7 @@ int copy_thread(unsigned long clone_flags, unsigned long stack_start,
 	 * and disable discard SVE state for p:
 	 */
 	clear_tsk_thread_flag(p, TIF_SVE);
+	p->thread.fork_in_progress = 0;
 	p->thread.sve_state = NULL;
 
 	/*
-- 
2.18.1

