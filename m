Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D567C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0006D205ED
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575483567;
	bh=0tJvrCfW3bpP7zzlMrl5a0A/G33lDyFmyoXU2iUME0o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Conl9dXAbTVJkMtA/JEMVzrkutmKXo5/FCqX3yBsbRxNfxT7r/JYyozPptOcPZbLS
	 B4R77z/fF9bK86UFR34JhLgxica/oezZzoWnbB/JHEyBrdrd6oxo8n5S4lBn1P6J5q
	 zZ7bfw+eBXHttOjcsRmD3EzdiBWKb/K9W6cpJbBM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731112AbfLDSJl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 13:09:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:35546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731090AbfLDSJg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 13:09:36 -0500
Received: from localhost (unknown [217.68.49.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF6CA20833;
        Wed,  4 Dec 2019 18:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575482975;
        bh=0tJvrCfW3bpP7zzlMrl5a0A/G33lDyFmyoXU2iUME0o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i3Rvk/5kvUNmtGigWTYeCqnFBnLCRNrXujpMLgEBZoYU/8x/MQfUfHoVMgSFMSggP
         aEIUFei/1kmbP3NZHjYjViRvx5xRYt7MVT6UK7xt8NrGfuRTETFWQtKxFIIHO6XzQ0
         AkBCGxpRja9ArxyW4CjCF3SMNASEOxTejHqg9bek=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [PATCH 4.14 189/209] exit/exec: Seperate mm_release()
Date:   Wed,  4 Dec 2019 18:56:41 +0100
Message-Id: <20191204175336.499583786@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204175321.609072813@linuxfoundation.org>
References: <20191204175321.609072813@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

commit 4610ba7ad877fafc0a25a30c6c82015304120426 upstream.

mm_release() contains the futex exit handling. mm_release() is called from
do_exit()->exit_mm() and from exec()->exec_mm().

In the exit_mm() case PF_EXITING and the futex state is updated. In the
exec_mm() case these states are not touched.

As the futex exit code needs further protections against exit races, this
needs to be split into two functions.

Preparatory only, no functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20191106224556.240518241@linutronix.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/exec.c                |    2 +-
 include/linux/sched/mm.h |    6 ++++--
 kernel/exit.c            |    2 +-
 kernel/fork.c            |   12 +++++++++++-
 4 files changed, 17 insertions(+), 5 deletions(-)

--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1007,7 +1007,7 @@ static int exec_mmap(struct mm_struct *m
 	/* Notify parent that we're no longer interested in the old VM */
 	tsk = current;
 	old_mm = current->mm;
-	mm_release(tsk, old_mm);
+	exec_mm_release(tsk, old_mm);
 
 	if (old_mm) {
 		sync_mm_rss(old_mm);
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -125,8 +125,10 @@ extern struct mm_struct *get_task_mm(str
  * succeeds.
  */
 extern struct mm_struct *mm_access(struct task_struct *task, unsigned int mode);
-/* Remove the current tasks stale references to the old mm_struct */
-extern void mm_release(struct task_struct *, struct mm_struct *);
+/* Remove the current tasks stale references to the old mm_struct on exit() */
+extern void exit_mm_release(struct task_struct *, struct mm_struct *);
+/* Remove the current tasks stale references to the old mm_struct on exec() */
+extern void exec_mm_release(struct task_struct *, struct mm_struct *);
 
 #ifdef CONFIG_MEMCG
 extern void mm_update_next_owner(struct mm_struct *mm);
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -497,7 +497,7 @@ static void exit_mm(void)
 	struct mm_struct *mm = current->mm;
 	struct core_state *core_state;
 
-	mm_release(current, mm);
+	exit_mm_release(current, mm);
 	if (!mm)
 		return;
 	sync_mm_rss(mm);
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1132,7 +1132,7 @@ static int wait_for_vfork_done(struct ta
  * restoring the old one. . .
  * Eric Biederman 10 January 1998
  */
-void mm_release(struct task_struct *tsk, struct mm_struct *mm)
+static void mm_release(struct task_struct *tsk, struct mm_struct *mm)
 {
 	/* Get rid of any futexes when releasing the mm */
 	futex_mm_release(tsk);
@@ -1169,6 +1169,16 @@ void mm_release(struct task_struct *tsk,
 		complete_vfork_done(tsk);
 }
 
+void exit_mm_release(struct task_struct *tsk, struct mm_struct *mm)
+{
+	mm_release(tsk, mm);
+}
+
+void exec_mm_release(struct task_struct *tsk, struct mm_struct *mm)
+{
+	mm_release(tsk, mm);
+}
+
 /*
  * Allocate a new mm structure and copy contents from the
  * mm structure of the passed in task structure.


