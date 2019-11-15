Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C71D9C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 21:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76EC32073B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 21:57:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="OLLTy3QH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbfKOV5S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 16:57:18 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34926 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbfKOV5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 16:57:17 -0500
Received: by mail-wr1-f66.google.com with SMTP id s5so12532516wrw.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 13:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from:cc;
        bh=NNEr+DraBKP4Q84AEs3rc2BBZYGiFTPMFLwi71NC/N8=;
        b=OLLTy3QHWpvAPt+hAZ7Tg02E4GBZqjd8GN3Tymvc3KddLMx8/KQ3RD90Cnq2u5KNMB
         ZsEAOwwKFGTDA7MHrBREBDpLnKeITHntz6l1q29RiRE3taDGz/xnW/OiCBfCurGcFFOa
         KXJAVf3D03r0diw3SavaLVcf1rkhV7y89xZZydQ7uxKvKwy35Gsfs4gcypfDUJFFitRZ
         6eHu7Es2pdjoxNiRyaPmIPEbT4GbKI3bRdqrxpj+8+gZz2zPq4DDae2HNwfPn1/hq9yv
         5O9Y2yfvDGOjFtWr+DjWw6y03Ph050OXi7YACeA11s9Cz5iOaGGe66UCE8SNx1eQqvys
         uXVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from:cc;
        bh=NNEr+DraBKP4Q84AEs3rc2BBZYGiFTPMFLwi71NC/N8=;
        b=PKC1Gl+H4ecdJwIpJ8TBGwuE0jOy39i2gK7lGl+5Tn7wzvbZE17UnnEl4LT7YtMQ0U
         i/h7x6/mCp6GhzeC3zWoG/rhm1xC4wD3VBnKI1C82fbIgInQqfXTMcSYW7FUbJr4d/S/
         HSqBGIUfi658GKx0pwOgy0cLVmIXVrsNuMD0jYpJwhZmNqOzXF0FVzheixoljPlN4niD
         lQ0hB1lnOCm0zAqoA+m5+PSMeOIl9CTzusmKgji22z6fMrkSXFScNH/6ZlVDlSpN5IJ3
         UZDhLa50zB207LlzCFY8q2lVaGos3uxfGcnpKmNgfjGzdLOJXKJOYJ76WzsuQ/5uhZB9
         0jVg==
X-Gm-Message-State: APjAAAWbw+LOCdYSCdRtoiRnGU31vC8P1BJlUNlbZfKEzaIaCNTOq+Wy
        JlZX0jOHFq3DZ7i5QtpH/7XxqA==
X-Google-Smtp-Source: APXvYqyVp8sFnDK32WayyhhGPS1hvVJYT1EeJkQP0TIhnlkjI58jNXORsQxr3T56ANKIAt6+a0JOpQ==
X-Received: by 2002:adf:ed48:: with SMTP id u8mr17083744wro.28.1573855033710;
        Fri, 15 Nov 2019 13:57:13 -0800 (PST)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id r25sm5192397wmh.6.2019.11.15.13.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 13:57:13 -0800 (PST)
Message-ID: <5dcf1f39.1c69fb81.409da.a39c@mx.google.com>
Date:   Fri, 15 Nov 2019 13:57:13 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Lab-Name: lab-baylibre
X-Kernelci-Branch: master
X-Kernelci-Tree: next
X-Kernelci-Report-Type: bisect
X-Kernelci-Kernel: next-20191115
Subject: next/master bisection: boot on qemu_i386
To:     tomeu.vizoso@collabora.com, guillaume.tucker@collabora.com,
        mgalka@collabora.com, Thomas Gleixner <tglx@linutronix.de>,
        broonie@kernel.org, matthew.hart@linaro.org, khilman@baylibre.com,
        enric.balletbo@collabora.com, Andy Lutomirski <luto@kernel.org>
From:   "kernelci.org bot" <bot@kernelci.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Babu Moger <Babu.Moger@amd.com>,
        Borislav Petkov <bp@alien8.de>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Rik van Riel <riel@surriel.com>,
        linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "kernelci.org bot" <bot@kernelci.org>,
        Waiman Long <longman@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
* This automated bisection report was sent to you on the basis  *
* that you may be involved with the breaking commit it has      *
* found.  No manual investigation has been done to verify it,   *
* and the root cause of the problem may be somewhere else.      *
*                                                               *
* If you do send a fix, please include this trailer:            *
*   Reported-by: "kernelci.org bot" <bot@kernelci.org>          *
*                                                               *
* Hope this helps!                                              *
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

next/master bisection: boot on qemu_i386

Summary:
  Start:      5a6fcbeabe3e Add linux-next specific files for 20191115
  Details:    https://kernelci.org/boot/id/5dcebd0459b514519dcf54be
  Plain log:  https://storage.kernelci.org//next/master/next-20191115/i386/=
i386_defconfig/gcc-8/lab-baylibre/boot-qemu_i386.txt
  HTML log:   https://storage.kernelci.org//next/master/next-20191115/i386/=
i386_defconfig/gcc-8/lab-baylibre/boot-qemu_i386.html
  Result:     bc1aca4ab8e0 x86/process: Unify copy_thread_tls()

Checks:
  revert:     PASS
  verify:     PASS

Parameters:
  Tree:       next
  URL:        git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next=
.git
  Branch:     master
  Target:     qemu_i386
  CPU arch:   i386
  Lab:        lab-baylibre
  Compiler:   gcc-8
  Config:     i386_defconfig
  Test suite: boot

Breaking commit found:

---------------------------------------------------------------------------=
----
commit bc1aca4ab8e08c01678e14138bea2fc433cd8068
Author: Thomas Gleixner <tglx@linutronix.de>
Date:   Mon Nov 11 23:03:16 2019 +0100

    x86/process: Unify copy_thread_tls()
    =

    While looking at the TSS io bitmap it turned out that any change in that
    area would require identical changes to copy_thread_tls(). The 32 and 64
    bit variants share sufficient code to consolidate them into a common
    function to avoid duplication of upcoming modifications.
    =

    Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
    Acked-by: Andy Lutomirski <luto@kernel.org>

diff --git a/arch/x86/include/asm/ptrace.h b/arch/x86/include/asm/ptrace.h
index 332eb3525867..5057a8ed100b 100644
--- a/arch/x86/include/asm/ptrace.h
+++ b/arch/x86/include/asm/ptrace.h
@@ -361,5 +361,11 @@ extern int do_get_thread_area(struct task_struct *p, i=
nt idx,
 extern int do_set_thread_area(struct task_struct *p, int idx,
 			      struct user_desc __user *info, int can_allocate);
 =

+#ifdef CONFIG_X86_64
+# define do_set_thread_area_64(p, s, t)	do_arch_prctl_64(p, s, t)
+#else
+# define do_set_thread_area_64(p, s, t)	(0)
+#endif
+
 #endif /* !__ASSEMBLY__ */
 #endif /* _ASM_X86_PTRACE_H */
diff --git a/arch/x86/include/asm/switch_to.h b/arch/x86/include/asm/switch=
_to.h
index 18a4b6890fa8..0e059b73437b 100644
--- a/arch/x86/include/asm/switch_to.h
+++ b/arch/x86/include/asm/switch_to.h
@@ -103,7 +103,17 @@ static inline void update_task_stack(struct task_struc=
t *task)
 	if (static_cpu_has(X86_FEATURE_XENPV))
 		load_sp0(task_top_of_stack(task));
 #endif
+}
 =

+static inline void kthread_frame_init(struct inactive_task_frame *frame,
+				      unsigned long fun, unsigned long arg)
+{
+	frame->bx =3D fun;
+#ifdef CONFIG_X86_32
+	frame->di =3D arg;
+#else
+	frame->r12 =3D arg;
+#endif
 }
 =

 #endif /* _ASM_X86_SWITCH_TO_H */
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 5e94c4354d4e..c09130a39954 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -132,6 +132,100 @@ void exit_thread(struct task_struct *tsk)
 	fpu__drop(fpu);
 }
 =

+static int set_new_tls(struct task_struct *p, unsigned long tls)
+{
+	struct user_desc __user *utls =3D (struct user_desc __user *)tls;
+
+	if (in_ia32_syscall())
+		return do_set_thread_area(p, -1, utls, 0);
+	else
+		return do_set_thread_area_64(p, ARCH_SET_FS, tls);
+}
+
+static inline int copy_io_bitmap(struct task_struct *tsk)
+{
+	if (likely(!test_tsk_thread_flag(current, TIF_IO_BITMAP)))
+		return 0;
+
+	tsk->thread.io_bitmap_ptr =3D kmemdup(current->thread.io_bitmap_ptr,
+					    IO_BITMAP_BYTES, GFP_KERNEL);
+	if (!tsk->thread.io_bitmap_ptr) {
+		tsk->thread.io_bitmap_max =3D 0;
+		return -ENOMEM;
+	}
+	set_tsk_thread_flag(tsk, TIF_IO_BITMAP);
+	return 0;
+}
+
+static inline void free_io_bitmap(struct task_struct *tsk)
+{
+	if (tsk->thread.io_bitmap_ptr) {
+		kfree(tsk->thread.io_bitmap_ptr);
+		tsk->thread.io_bitmap_ptr =3D NULL;
+		tsk->thread.io_bitmap_max =3D 0;
+	}
+}
+
+int copy_thread_tls(unsigned long clone_flags, unsigned long sp,
+		    unsigned long arg, struct task_struct *p, unsigned long tls)
+{
+	struct inactive_task_frame *frame;
+	struct fork_frame *fork_frame;
+	struct pt_regs *childregs;
+	int ret;
+
+	childregs =3D task_pt_regs(p);
+	fork_frame =3D container_of(childregs, struct fork_frame, regs);
+	frame =3D &fork_frame->frame;
+
+	frame->bp =3D 0;
+	frame->ret_addr =3D (unsigned long) ret_from_fork;
+	p->thread.sp =3D (unsigned long) fork_frame;
+	p->thread.io_bitmap_ptr =3D NULL;
+	memset(p->thread.ptrace_bps, 0, sizeof(p->thread.ptrace_bps));
+
+#ifdef CONFIG_X86_64
+	savesegment(gs, p->thread.gsindex);
+	p->thread.gsbase =3D p->thread.gsindex ? 0 : current->thread.gsbase;
+	savesegment(fs, p->thread.fsindex);
+	p->thread.fsbase =3D p->thread.fsindex ? 0 : current->thread.fsbase;
+	savesegment(es, p->thread.es);
+	savesegment(ds, p->thread.ds);
+#else
+	/* Clear all status flags including IF and set fixed bit. */
+	frame->flags =3D X86_EFLAGS_FIXED;
+#endif
+
+	/* Kernel thread ? */
+	if (unlikely(p->flags & PF_KTHREAD)) {
+		memset(childregs, 0, sizeof(struct pt_regs));
+		kthread_frame_init(frame, sp, arg);
+		return 0;
+	}
+
+	frame->bx =3D 0;
+	*childregs =3D *current_pt_regs();
+	childregs->ax =3D 0;
+	if (sp)
+		childregs->sp =3D sp;
+
+#ifdef CONFIG_X86_32
+	task_user_gs(p) =3D get_user_gs(current_pt_regs());
+#endif
+
+	ret =3D copy_io_bitmap(p);
+	if (ret)
+		return ret;
+
+	/* Set a new TLS for the child thread? */
+	if (clone_flags & CLONE_SETTLS) {
+		ret =3D set_new_tls(p, tls);
+		if (ret)
+			free_io_bitmap(p);
+	}
+	return ret;
+}
+
 void flush_thread(void)
 {
 	struct task_struct *tsk =3D current;
diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
index b8ceec4974fe..6c7d90527156 100644
--- a/arch/x86/kernel/process_32.c
+++ b/arch/x86/kernel/process_32.c
@@ -112,74 +112,6 @@ void release_thread(struct task_struct *dead_task)
 	release_vm86_irqs(dead_task);
 }
 =

-int copy_thread_tls(unsigned long clone_flags, unsigned long sp,
-	unsigned long arg, struct task_struct *p, unsigned long tls)
-{
-	struct pt_regs *childregs =3D task_pt_regs(p);
-	struct fork_frame *fork_frame =3D container_of(childregs, struct fork_fra=
me, regs);
-	struct inactive_task_frame *frame =3D &fork_frame->frame;
-	struct task_struct *tsk;
-	int err;
-
-	/*
-	 * For a new task use the RESET flags value since there is no before.
-	 * All the status flags are zero; DF and all the system flags must also
-	 * be 0, specifically IF must be 0 because we context switch to the new
-	 * task with interrupts disabled.
-	 */
-	frame->flags =3D X86_EFLAGS_FIXED;
-	frame->bp =3D 0;
-	frame->ret_addr =3D (unsigned long) ret_from_fork;
-	p->thread.sp =3D (unsigned long) fork_frame;
-	p->thread.sp0 =3D (unsigned long) (childregs+1);
-	memset(p->thread.ptrace_bps, 0, sizeof(p->thread.ptrace_bps));
-
-	if (unlikely(p->flags & PF_KTHREAD)) {
-		/* kernel thread */
-		memset(childregs, 0, sizeof(struct pt_regs));
-		frame->bx =3D sp;		/* function */
-		frame->di =3D arg;
-		p->thread.io_bitmap_ptr =3D NULL;
-		return 0;
-	}
-	frame->bx =3D 0;
-	*childregs =3D *current_pt_regs();
-	childregs->ax =3D 0;
-	if (sp)
-		childregs->sp =3D sp;
-
-	task_user_gs(p) =3D get_user_gs(current_pt_regs());
-
-	p->thread.io_bitmap_ptr =3D NULL;
-	tsk =3D current;
-	err =3D -ENOMEM;
-
-	if (unlikely(test_tsk_thread_flag(tsk, TIF_IO_BITMAP))) {
-		p->thread.io_bitmap_ptr =3D kmemdup(tsk->thread.io_bitmap_ptr,
-						IO_BITMAP_BYTES, GFP_KERNEL);
-		if (!p->thread.io_bitmap_ptr) {
-			p->thread.io_bitmap_max =3D 0;
-			return -ENOMEM;
-		}
-		set_tsk_thread_flag(p, TIF_IO_BITMAP);
-	}
-
-	err =3D 0;
-
-	/*
-	 * Set a new TLS for the child thread?
-	 */
-	if (clone_flags & CLONE_SETTLS)
-		err =3D do_set_thread_area(p, -1,
-			(struct user_desc __user *)tls, 0);
-
-	if (err && p->thread.io_bitmap_ptr) {
-		kfree(p->thread.io_bitmap_ptr);
-		p->thread.io_bitmap_max =3D 0;
-	}
-	return err;
-}
-
 void
 start_thread(struct pt_regs *regs, unsigned long new_ip, unsigned long new=
_sp)
 {
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index af64519b2695..e93a1b8fd7f9 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -371,81 +371,6 @@ void x86_gsbase_write_task(struct task_struct *task, u=
nsigned long gsbase)
 	task->thread.gsbase =3D gsbase;
 }
 =

-int copy_thread_tls(unsigned long clone_flags, unsigned long sp,
-		unsigned long arg, struct task_struct *p, unsigned long tls)
-{
-	int err;
-	struct pt_regs *childregs;
-	struct fork_frame *fork_frame;
-	struct inactive_task_frame *frame;
-	struct task_struct *me =3D current;
-
-	childregs =3D task_pt_regs(p);
-	fork_frame =3D container_of(childregs, struct fork_frame, regs);
-	frame =3D &fork_frame->frame;
-
-	frame->bp =3D 0;
-	frame->ret_addr =3D (unsigned long) ret_from_fork;
-	p->thread.sp =3D (unsigned long) fork_frame;
-	p->thread.io_bitmap_ptr =3D NULL;
-
-	savesegment(gs, p->thread.gsindex);
-	p->thread.gsbase =3D p->thread.gsindex ? 0 : me->thread.gsbase;
-	savesegment(fs, p->thread.fsindex);
-	p->thread.fsbase =3D p->thread.fsindex ? 0 : me->thread.fsbase;
-	savesegment(es, p->thread.es);
-	savesegment(ds, p->thread.ds);
-	memset(p->thread.ptrace_bps, 0, sizeof(p->thread.ptrace_bps));
-
-	if (unlikely(p->flags & PF_KTHREAD)) {
-		/* kernel thread */
-		memset(childregs, 0, sizeof(struct pt_regs));
-		frame->bx =3D sp;		/* function */
-		frame->r12 =3D arg;
-		return 0;
-	}
-	frame->bx =3D 0;
-	*childregs =3D *current_pt_regs();
-
-	childregs->ax =3D 0;
-	if (sp)
-		childregs->sp =3D sp;
-
-	err =3D -ENOMEM;
-	if (unlikely(test_tsk_thread_flag(me, TIF_IO_BITMAP))) {
-		p->thread.io_bitmap_ptr =3D kmemdup(me->thread.io_bitmap_ptr,
-						  IO_BITMAP_BYTES, GFP_KERNEL);
-		if (!p->thread.io_bitmap_ptr) {
-			p->thread.io_bitmap_max =3D 0;
-			return -ENOMEM;
-		}
-		set_tsk_thread_flag(p, TIF_IO_BITMAP);
-	}
-
-	/*
-	 * Set a new TLS for the child thread?
-	 */
-	if (clone_flags & CLONE_SETTLS) {
-#ifdef CONFIG_IA32_EMULATION
-		if (in_ia32_syscall())
-			err =3D do_set_thread_area(p, -1,
-				(struct user_desc __user *)tls, 0);
-		else
-#endif
-			err =3D do_arch_prctl_64(p, ARCH_SET_FS, tls);
-		if (err)
-			goto out;
-	}
-	err =3D 0;
-out:
-	if (err && p->thread.io_bitmap_ptr) {
-		kfree(p->thread.io_bitmap_ptr);
-		p->thread.io_bitmap_max =3D 0;
-	}
-
-	return err;
-}
-
 static void
 start_thread_common(struct pt_regs *regs, unsigned long new_ip,
 		    unsigned long new_sp,
---------------------------------------------------------------------------=
----


Git bisection log:

---------------------------------------------------------------------------=
----
git bisect start
# good: [633739b2fedb6617d782ca252797b7a8ad754347] rbd: silence bogus unini=
tialized warning in rbd_object_map_update_finish()
git bisect good 633739b2fedb6617d782ca252797b7a8ad754347
# bad: [5a6fcbeabe3e20459ed8504690b2515dacc5246f] Add linux-next specific f=
iles for 20191115
git bisect bad 5a6fcbeabe3e20459ed8504690b2515dacc5246f
# good: [280c9e8802370ed562bf1360fb6906c91fd3c190] Merge remote-tracking br=
anch 'crypto/master'
git bisect good 280c9e8802370ed562bf1360fb6906c91fd3c190
# good: [c49494c35c91edb2013a696c5ab335789c5d3df4] Merge remote-tracking br=
anch 'devicetree/for-next'
git bisect good c49494c35c91edb2013a696c5ab335789c5d3df4
# bad: [518d37a6ac8907ce017751fd985a53fa8a354e6f] Merge remote-tracking bra=
nch 'char-misc/char-misc-next'
git bisect bad 518d37a6ac8907ce017751fd985a53fa8a354e6f
# bad: [3d75c03b3bf024c7f25d57da072e0ffacee52499] Merge remote-tracking bra=
nch 'edac/edac-for-next'
git bisect bad 3d75c03b3bf024c7f25d57da072e0ffacee52499
# good: [9dc21c69c61512356dc002266e5b10636f75e3f2] Merge branch 'x86/urgent'
git bisect good 9dc21c69c61512356dc002266e5b10636f75e3f2
# good: [8e970f74efde16ae67b33eead1d2f9b6c59b25a6] Merge branch 'efi/core'
git bisect good 8e970f74efde16ae67b33eead1d2f9b6c59b25a6
# good: [5eb263ef08b5014cfc2539a838f39d2fd3531423] spi: pxa2xx: Add missed =
security checks
git bisect good 5eb263ef08b5014cfc2539a838f39d2fd3531423
# bad: [3b0a842355f77f12dcf71a61b02b49b3cbc5ed1c] Merge branch 'locking/cor=
e'
git bisect bad 3b0a842355f77f12dcf71a61b02b49b3cbc5ed1c
# bad: [3e4d603f40ddaf797067dedfe07c07357c901386] selftests/x86/iopl: Exten=
d test to cover IOPL emulation
git bisect bad 3e4d603f40ddaf797067dedfe07c07357c901386
# bad: [78a53d4aabebbda7328aadf6a2821cf75d8d089d] x86/ioperm: Move iobitmap=
 data into a struct
git bisect bad 78a53d4aabebbda7328aadf6a2821cf75d8d089d
# bad: [f07d5e256894dc74266c7639f44e68dcfc961aa3] x86/iopl: Cleanup include=
 maze
git bisect bad f07d5e256894dc74266c7639f44e68dcfc961aa3
# bad: [bc1aca4ab8e08c01678e14138bea2fc433cd8068] x86/process: Unify copy_t=
hread_tls()
git bisect bad bc1aca4ab8e08c01678e14138bea2fc433cd8068
# good: [a66770766fb3152b38ef324b9ed5e98e6d9b89b2] x86/ptrace: Prevent trun=
cation of bitmap size
git bisect good a66770766fb3152b38ef324b9ed5e98e6d9b89b2
# first bad commit: [bc1aca4ab8e08c01678e14138bea2fc433cd8068] x86/process:=
 Unify copy_thread_tls()
---------------------------------------------------------------------------=
----
