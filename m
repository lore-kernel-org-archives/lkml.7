Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DBA1FA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 313992168B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571263694;
	bh=2Tsuf/x7x8Qu4OmA+RXThjpu0zdA5BvecDWcuUxBmm0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mk+Vi2ItvH7JJCNRzM39cnvWBtwsLMbaWoyjq1epKd8eJUNy8IyR38O9d99vrehK2
	 /dqpYMm8kTnLSd+GKM2r6NbCPCSbm35kugW4y0gZXo1aroHzs6IBC5175ttgh9xILo
	 TC0w88+IrWqK2ZYAAmGjk7KQcgJUUa4TX+IvkB68=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407063AbfJPWIN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 18:08:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:50934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438064AbfJPV5y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 17:57:54 -0400
Received: from localhost (unknown [192.55.54.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8556821D7E;
        Wed, 16 Oct 2019 21:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571263073;
        bh=2Tsuf/x7x8Qu4OmA+RXThjpu0zdA5BvecDWcuUxBmm0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lHP3/NC4Mk+Tyv3+P62SoePi7mRz//NBlZws9bVFw+n1t4OyNtSpUKzODtTFTxpOZ
         W4e/J7VlsvW/x4KibanVKNLAaKnJHvOkjJg8pRoC5SDzFiC3o+qlpsWAOqZc2y8zIN
         aFqCT0A2TqkssYJkmRDgr/oTEnwBfIXGxZC2erG8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Julien Grall <julien.grall@arm.com>,
        Will Deacon <will@kernel.org>
Subject: [PATCH 4.19 73/81] arm64/sve: Fix wrong free for task->thread.sve_state
Date:   Wed, 16 Oct 2019 14:51:24 -0700
Message-Id: <20191016214847.124955413@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016214805.727399379@linuxfoundation.org>
References: <20191016214805.727399379@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

commit 4585fc59c0e813188d6a4c5de1f6976fce461fc2 upstream.

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
>From commit c02433dd6de3 ("arm64: split thread_info from task stack"),
the thread_info is part of the task, so it should be valid to modify
the flag from arch_dup_task_struct().

Cc: stable@vger.kernel.org # 4.15.x-
Fixes: bc0ee4760364 ("arm64/sve: Core task context handling")
Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Reported-by: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Suggested-by: Dave Martin <Dave.Martin@arm.com>
Reviewed-by: Dave Martin <Dave.Martin@arm.com>
Tested-by: Julien Grall <julien.grall@arm.com>
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/kernel/process.c |   32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -285,22 +285,27 @@ void arch_release_task_struct(struct tas
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
 
@@ -314,13 +319,6 @@ int copy_thread(unsigned long clone_flag
 	memset(&p->thread.cpu_context, 0, sizeof(struct cpu_context));
 
 	/*
-	 * Unalias p->thread.sve_state (if any) from the parent task
-	 * and disable discard SVE state for p:
-	 */
-	clear_tsk_thread_flag(p, TIF_SVE);
-	p->thread.sve_state = NULL;
-
-	/*
 	 * In case p was allocated the same task_struct pointer as some
 	 * other recently-exited task, make sure p is disassociated from
 	 * any cpu that may have run that now-exited task recently.


