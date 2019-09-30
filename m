Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 452ABC32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 20:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 182BD20679
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 20:56:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mL+wonIS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731201AbfI3U4P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 16:56:15 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:44870 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbfI3U4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 16:56:15 -0400
Received: by mail-qk1-f193.google.com with SMTP id u22so9111433qkk.11
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 13:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=BEh0LfONw8WWbMYYoNzYq2HBhr7sqFPDv5NouMGgnRI=;
        b=mL+wonISTN9PlMPaMX0BT3yopdGljaFqMOjYIYk42pG2SXxOoN0BOcCi3ZRop9Ga90
         5tQdhA+raRVQM7iTIQTIxNSWHpDKSySYYS+bWtBACqghZmHl1txliDIQKkYC+knzrTYq
         KZ5sglKEe1Md7nj23AebrKQKNt8mTaPpk9CBhZINTwZ430kPMSzYBX5UGJV9Rle+fhYF
         65C9PhiB8oESqG/YZXuQQY5rsoLxvqdwWcM3cueLqirHWPgAhh2Noj9UcHQV7NytpmXA
         KpiawEdDMXb2TXpuYXcOcC9BKtH67lb9RfKMFeV5F0rqaa4euGvGVxI0H8NlerUg1+qg
         DRsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BEh0LfONw8WWbMYYoNzYq2HBhr7sqFPDv5NouMGgnRI=;
        b=FO8vDH5ZWxrhAiq8NcarI76F5NZoHpqJv695vEVjhb1cKXLhahKuO1jjyHgEP1eSjp
         d0XrWrmL/J/SWRbnnVYO9tK9+eCjzkkQzfwj5FqmOnsOucCl2XD3LzF9TZtLow3MA40A
         g8fOH1FI5iqbG224mDbzQDWh7ZLAsh+fbsN9I7HPvv2Ojd9A0irNnjZUg2TbDtb4ZDbz
         7XyN1FMwC1cgg42z/92ebhxaEjsRQBANB3zyapd4DyaYuehF7LXNDUBZBbLmfdDY+wTg
         Bt1l9YnksKobf1f+nRHBA+ONa0oaTkZIVziShkjQF6/M2t+yuHceZeE7dzQ+heyfXGSy
         M5gA==
X-Gm-Message-State: APjAAAVA7ay7ZmNNQ83ERiw/AnseHZhVVd+UckTxir/ykeCg2XuUj0ko
        FngxQ4ktY6u8ASSz7feTHQ==
X-Google-Smtp-Source: APXvYqyN3kJm6L2nnYMhwowAqdviIW7EdlUTti17K9HaILnrKAQb3VoCSzpIoW2ZSAlzM6kmFGCcZg==
X-Received: by 2002:a37:bc84:: with SMTP id m126mr2247705qkf.196.1569876973826;
        Mon, 30 Sep 2019 13:56:13 -0700 (PDT)
Received: from gabell.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id j17sm6213041qki.99.2019.09.30.13.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 13:56:12 -0700 (PDT)
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Dave Martin <Dave.Martin@arm.com>,
        Julien Grall <julien.grall@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] arm64/sve: Fix wrong free for task->thread.sve_state
Date:   Mon, 30 Sep 2019 16:56:00 -0400
Message-Id: <20190930205600.25542-1-msys.mizuma@gmail.com>
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
There is no need to wait until copy_process() to clear TIF_SVE for
dst, because the thread flags for dst are initialized already by
copying the src task_struct.
This change simplifies the code, so get rid of comments that are no
longer needed.

As a note, arm64 used to have thread_info on the stack. So it
would not be possible to clear TIF_SVE until the stack is initialized.
From commit c02433dd6de3 ("arm64: split thread_info from task stack"),
the thread_info is part of the task, so it should be valid to modify
the flag from arch_dup_task_struct().

Cc: stable@vger.kernel.org # 4.15.x-
Fixes: bc0ee4760364 ("arm64/sve: Core task context handling")
Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Reported-by: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Suggested-by: Dave Martin <Dave.Martin@arm.com>
Tested-by: Julien Grall <julien.grall@arm.com>
---
 arch/arm64/kernel/process.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index a47462def04b..ef7aa909bfda 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -332,22 +332,27 @@ void arch_release_task_struct(struct task_struct *tsk)
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
 
+	/* We rely on the above assignment to initialize dst's thread_flags: */
+	BUILD_BUG_ON(!IS_ENABLED(CONFIG_THREAD_INFO_IN_TASK));
+
+	/*
+	 * Detach src's sve_state (if any) from dst so that it does not
+	 * get erroneously used or freed prematurely.  dst's sve_state
+	 * will be allocated on demand later on if dst uses SVE.
+	 * For consistency, also clear TIF_SVE here: this could be done
+	 * later in copy_process(), but to avoid tripping up future
+	 * maintainers it is best not to leave TIF_SVE and sve_state in
+	 * an inconsistent state, even temporarily.
+	 */
+	dst->thread.sve_state = NULL;
+	clear_tsk_thread_flag(dst, TIF_SVE);
+
 	return 0;
 }
 
@@ -360,13 +365,6 @@ int copy_thread(unsigned long clone_flags, unsigned long stack_start,
 
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

