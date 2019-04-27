Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FBADC43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57792208C2
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:26:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728474AbfD0P0J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:26:09 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34856 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728433AbfD0P0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:26:08 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP3B-0000zG-I7; Sat, 27 Apr 2019 16:15:37 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2i-0004Ra-HR; Sat, 27 Apr 2019 16:15:08 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "William Kucharski" <william.kucharski@oracle.com>,
        "Vineet Gupta" <vgupta@synopsys.com>
Date:   Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.69420292@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 050/202] ARC: show_regs: lockdep: avoid page allocator...
In-Reply-To: <lsq.1556377988.384060557@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.66-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Vineet Gupta <vgupta@synopsys.com>

commit ab6c03676cb190156603cf4c5ecf97aa406c9c53 upstream.

and use smaller/on-stack buffer instead

The motivation for this change was lockdep splat like below.

| potentially unexpected fatal signal 11.
| BUG: sleeping function called from invalid context at ../mm/page_alloc.c:4317
| in_atomic(): 1, irqs_disabled(): 0, pid: 57, name: segv
| no locks held by segv/57.
| Preemption disabled at:
| [<8182f17e>] get_signal+0x4a6/0x7c4
| CPU: 0 PID: 57 Comm: segv Not tainted 4.17.0+ #23
|
| Stack Trace:
|  arc_unwind_core.constprop.1+0xd0/0xf4
|  __might_sleep+0x1f6/0x234
|  __get_free_pages+0x174/0xca0
|  show_regs+0x22/0x330
|  get_signal+0x4ac/0x7c4     # print_fatal_signals() -> preempt_disable()
|  do_signal+0x30/0x224
|  resume_user_mode_begin+0x90/0xd8

So signal handling core calls show_regs() with preemption disabled but
an ensuing GFP_KERNEL page allocator call is flagged by lockdep.

We could have switched to GFP_NOWAIT, but turns out that is not enough
anways and eliding page allocator call leads to less code and
instruction traces to sift thru when debugging pesky crashes.

FWIW, this patch doesn't cure the lockdep splat (which next patch does).

Reviewed-by: William Kucharski <william.kucharski@oracle.com>
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/arc/kernel/troubleshoot.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

--- a/arch/arc/kernel/troubleshoot.c
+++ b/arch/arc/kernel/troubleshoot.c
@@ -15,6 +15,8 @@
 #include <linux/file.h>
 #include <asm/arcregs.h>
 
+#define ARC_PATH_MAX	256
+
 /*
  * Common routine to print scratch regs (r0-r12) or callee regs (r13-r25)
  *   -Prints 3 regs per line and a CR.
@@ -52,12 +54,13 @@ static void show_callee_regs(struct call
 	print_reg_file(&(cregs->r13), 13);
 }
 
-static void print_task_path_n_nm(struct task_struct *tsk, char *buf)
+static void print_task_path_n_nm(struct task_struct *tsk)
 {
 	struct path path;
 	char *path_nm = NULL;
 	struct mm_struct *mm;
 	struct file *exe_file;
+	char buf[ARC_PATH_MAX];
 
 	mm = get_task_mm(tsk);
 	if (!mm)
@@ -70,7 +73,7 @@ static void print_task_path_n_nm(struct
 		path = exe_file->f_path;
 		path_get(&exe_file->f_path);
 		fput(exe_file);
-		path_nm = d_path(&path, buf, 255);
+		path_nm = d_path(&path, buf, ARC_PATH_MAX-1);
 		path_put(&path);
 	}
 
@@ -78,13 +81,12 @@ done:
 	pr_info("Path: %s\n", path_nm);
 }
 
-static void show_faulting_vma(unsigned long address, char *buf)
+static void show_faulting_vma(unsigned long address)
 {
 	struct vm_area_struct *vma;
 	struct inode *inode;
 	unsigned long ino = 0;
 	dev_t dev = 0;
-	char *nm = buf;
 	struct mm_struct *active_mm = current->active_mm;
 
 	/* can't use print_vma_addr() yet as it doesn't check for
@@ -98,9 +100,12 @@ static void show_faulting_vma(unsigned l
 	 */
 	if (vma && (vma->vm_start <= address)) {
 		struct file *file = vma->vm_file;
+		char buf[ARC_PATH_MAX];
+		char *nm = "?";
+
 		if (file) {
 			struct path *path = &file->f_path;
-			nm = d_path(path, buf, PAGE_SIZE - 1);
+			nm = d_path(path, buf, ARC_PATH_MAX-1);
 			inode = file_inode(vma->vm_file);
 			dev = inode->i_sb->s_dev;
 			ino = inode->i_ino;
@@ -165,13 +170,8 @@ void show_regs(struct pt_regs *regs)
 {
 	struct task_struct *tsk = current;
 	struct callee_regs *cregs;
-	char *buf;
 
-	buf = (char *)__get_free_page(GFP_TEMPORARY);
-	if (!buf)
-		return;
-
-	print_task_path_n_nm(tsk, buf);
+	print_task_path_n_nm(tsk);
 	show_regs_print_info(KERN_INFO);
 
 	show_ecr_verbose(regs);
@@ -181,7 +181,7 @@ void show_regs(struct pt_regs *regs)
 		(void *)regs->blink, (void *)regs->ret);
 
 	if (user_mode(regs))
-		show_faulting_vma(regs->ret, buf); /* faulting code, not data */
+		show_faulting_vma(regs->ret); /* faulting code, not data */
 
 	pr_info("[STAT32]: 0x%08lx", regs->status32);
 
@@ -205,8 +205,6 @@ void show_regs(struct pt_regs *regs)
 	cregs = (struct callee_regs *)current->thread.callee_reg;
 	if (cregs)
 		show_callee_regs(cregs);
-
-	free_page((unsigned long)buf);
 }
 
 void show_kernel_fault_diag(const char *str, struct pt_regs *regs,

