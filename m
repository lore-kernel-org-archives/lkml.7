Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D17FC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 15:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D988320674
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 15:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574697236;
	bh=u7IxnB42cFQJpj/F/nHSdYgFAU/obHCzs4Nxo/wc8jM=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=qp94dVu/2/zmi6yVNhUtwpwwUphJwT9Ek+qmjCQQElyg0senM2aHGEE3fm2a+lOyb
	 bEy0hcEuTbeofZRVdh4KVy0+WwEt3ybwXyrKHFVueje/iYSdp9SPvbLFEqSdmj6/v8
	 NfILKzWEJyHihHB4yX0HHgbQ0Ki//bPqFNxB7LyA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728705AbfKYPxy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 10:53:54 -0500
Received: from mail-wm1-f53.google.com ([209.85.128.53]:50714 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728243AbfKYPxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 10:53:54 -0500
Received: by mail-wm1-f53.google.com with SMTP id l17so16002439wmh.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 07:53:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=PM5QsH2qPOACw3VM1kOq9Acy7QgMqchYGUmrwkfJNtc=;
        b=OVSwXGYP2C8H6usBbva8hSzN/b2xhVggZ7x8lF90Hj2zXTej+cBHvcQQC9Jh1WXkuc
         +5O2rZQ4S0YkNQtCLWOeX/ZVD5Q8n6Qp7W/kTJ+iKsdQZ8mGF75U31Wo/F54dWI7XHgB
         bM7UDJ1pFo7T8lEq+08wuKtLDMsXI3FxSKgaC5i2XryE+DsMpLAW7AztVmm45iOSI2yU
         5YM3g21+Iy4+pCWdBVLudXlOhIcaOu4WlEJxOyqSejnPpCBYpbxrTr80V8XxGxY6+DAr
         pgRi6Bwc8TU8n43gYyus16b7mdLa66YJBB7QxW1o/l/5x4DousvURSLdWngclPSeofae
         yKyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=PM5QsH2qPOACw3VM1kOq9Acy7QgMqchYGUmrwkfJNtc=;
        b=CFAekX5QGJxcf7aewTDk0nJ2fn5CPCw/BoHQT9abG8rbsrBifwz/pPBZhbqRHaXOLC
         qiKMLZUYTPF2JbjBETKNn8ogmVxDMXntYcQB8n/SPnjckdthe/hAJQXEYym4tDo6fM0L
         F818tI8YIiz7/Q6LCsXrN61YmjAz3uu4H3nG+FDRekdgiMfJkuCRMck5/xhyCfeMf3/5
         yLAUSdFS9hmz90iSUikd6PdOz6j+Uf2bTNSOrdnolBk7Fx50UE/jpO2FuEDOwumZ/MBt
         MmPfjyxYpDBnBnk7KQ/SgPxspoaYk97KQgCXAdsVhXXC1N1C9n1dKos/s5t6QdLYMcW8
         vO7w==
X-Gm-Message-State: APjAAAW5UGD0qg7hnvfWiox1UkSNLJboCDQ4iDD4s8tF6r0rMbh6VwUl
        QXLisdXlrhRCoZTyksq3oLA=
X-Google-Smtp-Source: APXvYqxqKe2+ixLQWJ6kSzaBMjEjU3RIpKw44W5Ig5E5OAMnJOhrF7s6yIw5jMpUGIu+lJlqS5lm8A==
X-Received: by 2002:a1c:48c1:: with SMTP id v184mr29173754wma.120.1574697229377;
        Mon, 25 Nov 2019 07:53:49 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id d7sm11196583wrx.11.2019.11.25.07.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 07:53:48 -0800 (PST)
Date:   Mon, 25 Nov 2019 16:53:46 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86 fixes for v5.5
Message-ID: <20191125155346.GA129303@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-for-linus

   # HEAD: 4a13b0e3e10996b9aa0b45a764ecfe49f6fcd360 x86/entry/32: Fix FIXUP_ESPFIX_STACK with user CR3

These are the fixes left over from the v5.4 cycle:

 - Various low level 32-bit entry code fixes and improvements by Andy 
   Lutomirski, Peter Zijlstra and Thomas Gleixner.

 - Fix 32-bit Xen PV breakage, by Jan Beulich.

 Thanks,

	Ingo

------------------>
Andy Lutomirski (7):
      x86/doublefault/32: Fix stack canaries in the double fault handler
      x86/entry/32: Use %ss segment where required
      x86/entry/32: Move FIXUP_FRAME after pushing %fs in SAVE_ALL
      x86/entry/32: Unwind the ESPFIX stack earlier on exception entry
      selftests/x86/mov_ss_trap: Fix the SYSENTER test
      selftests/x86/sigreturn/32: Invalidate DS and ES when abusing the kernel
      x86/entry/32: Fix FIXUP_ESPFIX_STACK with user CR3

Ingo Molnar (1):
      x86/pti/32: Calculate the various PTI cpu_entry_area sizes correctly, make the CPU_ENTRY_AREA_PAGES assert precise

Jan Beulich (3):
      x86/stackframe/32: Repair 32-bit Xen PV
      x86/xen/32: Make xen_iret_crit_fixup() independent of frame layout
      x86/xen/32: Simplify ring check in xen_iret_crit_fixup()

Peter Zijlstra (2):
      x86/entry/32: Fix IRET exception
      x86/entry/32: Fix NMI vs ESPFIX

Thomas Gleixner (2):
      x86/pti/32: Size initial_page_table correctly
      x86/cpu_entry_area: Add guard page for entry stack on 32bit


 arch/x86/entry/entry_32.S                 | 211 +++++++++++++++++++-----------
 arch/x86/include/asm/cpu_entry_area.h     |  18 ++-
 arch/x86/include/asm/pgtable_32_types.h   |   8 +-
 arch/x86/include/asm/segment.h            |  12 ++
 arch/x86/kernel/doublefault.c             |   3 +
 arch/x86/kernel/head_32.S                 |  10 ++
 arch/x86/mm/cpu_entry_area.c              |   4 +-
 arch/x86/xen/xen-asm_32.S                 |  75 ++++-------
 tools/testing/selftests/x86/mov_ss_trap.c |   3 +-
 tools/testing/selftests/x86/sigreturn.c   |  13 ++
 10 files changed, 217 insertions(+), 140 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index f83ca5aa8b77..f07baf0388bc 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -172,7 +172,7 @@
 	ALTERNATIVE "jmp .Lend_\@", "", X86_FEATURE_PTI
 	.if \no_user_check == 0
 	/* coming from usermode? */
-	testl	$SEGMENT_RPL_MASK, PT_CS(%esp)
+	testl	$USER_SEGMENT_RPL_MASK, PT_CS(%esp)
 	jz	.Lend_\@
 	.endif
 	/* On user-cr3? */
@@ -205,64 +205,76 @@
 #define CS_FROM_ENTRY_STACK	(1 << 31)
 #define CS_FROM_USER_CR3	(1 << 30)
 #define CS_FROM_KERNEL		(1 << 29)
+#define CS_FROM_ESPFIX		(1 << 28)
 
 .macro FIXUP_FRAME
 	/*
 	 * The high bits of the CS dword (__csh) are used for CS_FROM_*.
 	 * Clear them in case hardware didn't do this for us.
 	 */
-	andl	$0x0000ffff, 3*4(%esp)
+	andl	$0x0000ffff, 4*4(%esp)
 
 #ifdef CONFIG_VM86
-	testl	$X86_EFLAGS_VM, 4*4(%esp)
+	testl	$X86_EFLAGS_VM, 5*4(%esp)
 	jnz	.Lfrom_usermode_no_fixup_\@
 #endif
-	testl	$SEGMENT_RPL_MASK, 3*4(%esp)
+	testl	$USER_SEGMENT_RPL_MASK, 4*4(%esp)
 	jnz	.Lfrom_usermode_no_fixup_\@
 
-	orl	$CS_FROM_KERNEL, 3*4(%esp)
+	orl	$CS_FROM_KERNEL, 4*4(%esp)
 
 	/*
 	 * When we're here from kernel mode; the (exception) stack looks like:
 	 *
-	 *  5*4(%esp) - <previous context>
-	 *  4*4(%esp) - flags
-	 *  3*4(%esp) - cs
-	 *  2*4(%esp) - ip
-	 *  1*4(%esp) - orig_eax
-	 *  0*4(%esp) - gs / function
+	 *  6*4(%esp) - <previous context>
+	 *  5*4(%esp) - flags
+	 *  4*4(%esp) - cs
+	 *  3*4(%esp) - ip
+	 *  2*4(%esp) - orig_eax
+	 *  1*4(%esp) - gs / function
+	 *  0*4(%esp) - fs
 	 *
 	 * Lets build a 5 entry IRET frame after that, such that struct pt_regs
 	 * is complete and in particular regs->sp is correct. This gives us
-	 * the original 5 enties as gap:
+	 * the original 6 enties as gap:
 	 *
-	 * 12*4(%esp) - <previous context>
-	 * 11*4(%esp) - gap / flags
-	 * 10*4(%esp) - gap / cs
-	 *  9*4(%esp) - gap / ip
-	 *  8*4(%esp) - gap / orig_eax
-	 *  7*4(%esp) - gap / gs / function
-	 *  6*4(%esp) - ss
-	 *  5*4(%esp) - sp
-	 *  4*4(%esp) - flags
-	 *  3*4(%esp) - cs
-	 *  2*4(%esp) - ip
-	 *  1*4(%esp) - orig_eax
-	 *  0*4(%esp) - gs / function
+	 * 14*4(%esp) - <previous context>
+	 * 13*4(%esp) - gap / flags
+	 * 12*4(%esp) - gap / cs
+	 * 11*4(%esp) - gap / ip
+	 * 10*4(%esp) - gap / orig_eax
+	 *  9*4(%esp) - gap / gs / function
+	 *  8*4(%esp) - gap / fs
+	 *  7*4(%esp) - ss
+	 *  6*4(%esp) - sp
+	 *  5*4(%esp) - flags
+	 *  4*4(%esp) - cs
+	 *  3*4(%esp) - ip
+	 *  2*4(%esp) - orig_eax
+	 *  1*4(%esp) - gs / function
+	 *  0*4(%esp) - fs
 	 */
 
 	pushl	%ss		# ss
 	pushl	%esp		# sp (points at ss)
-	addl	$6*4, (%esp)	# point sp back at the previous context
-	pushl	6*4(%esp)	# flags
-	pushl	6*4(%esp)	# cs
-	pushl	6*4(%esp)	# ip
-	pushl	6*4(%esp)	# orig_eax
-	pushl	6*4(%esp)	# gs / function
+	addl	$7*4, (%esp)	# point sp back at the previous context
+	pushl	7*4(%esp)	# flags
+	pushl	7*4(%esp)	# cs
+	pushl	7*4(%esp)	# ip
+	pushl	7*4(%esp)	# orig_eax
+	pushl	7*4(%esp)	# gs / function
+	pushl	7*4(%esp)	# fs
 .Lfrom_usermode_no_fixup_\@:
 .endm
 
 .macro IRET_FRAME
+	/*
+	 * We're called with %ds, %es, %fs, and %gs from the interrupted
+	 * frame, so we shouldn't use them.  Also, we may be in ESPFIX
+	 * mode and therefore have a nonzero SS base and an offset ESP,
+	 * so any attempt to access the stack needs to use SS.  (except for
+	 * accesses through %esp, which automatically use SS.)
+	 */
 	testl $CS_FROM_KERNEL, 1*4(%esp)
 	jz .Lfinished_frame_\@
 
@@ -276,31 +288,40 @@
 	movl	5*4(%esp), %eax		# (modified) regs->sp
 
 	movl	4*4(%esp), %ecx		# flags
-	movl	%ecx, -4(%eax)
+	movl	%ecx, %ss:-1*4(%eax)
 
 	movl	3*4(%esp), %ecx		# cs
 	andl	$0x0000ffff, %ecx
-	movl	%ecx, -8(%eax)
+	movl	%ecx, %ss:-2*4(%eax)
 
 	movl	2*4(%esp), %ecx		# ip
-	movl	%ecx, -12(%eax)
+	movl	%ecx, %ss:-3*4(%eax)
 
 	movl	1*4(%esp), %ecx		# eax
-	movl	%ecx, -16(%eax)
+	movl	%ecx, %ss:-4*4(%eax)
 
 	popl	%ecx
-	lea	-16(%eax), %esp
+	lea	-4*4(%eax), %esp
 	popl	%eax
 .Lfinished_frame_\@:
 .endm
 
-.macro SAVE_ALL pt_regs_ax=%eax switch_stacks=0 skip_gs=0
+.macro SAVE_ALL pt_regs_ax=%eax switch_stacks=0 skip_gs=0 unwind_espfix=0
 	cld
 .if \skip_gs == 0
 	PUSH_GS
 .endif
-	FIXUP_FRAME
 	pushl	%fs
+
+	pushl	%eax
+	movl	$(__KERNEL_PERCPU), %eax
+	movl	%eax, %fs
+.if \unwind_espfix > 0
+	UNWIND_ESPFIX_STACK
+.endif
+	popl	%eax
+
+	FIXUP_FRAME
 	pushl	%es
 	pushl	%ds
 	pushl	\pt_regs_ax
@@ -313,8 +334,6 @@
 	movl	$(__USER_DS), %edx
 	movl	%edx, %ds
 	movl	%edx, %es
-	movl	$(__KERNEL_PERCPU), %edx
-	movl	%edx, %fs
 .if \skip_gs == 0
 	SET_KERNEL_GS %edx
 .endif
@@ -324,8 +343,8 @@
 .endif
 .endm
 
-.macro SAVE_ALL_NMI cr3_reg:req
-	SAVE_ALL
+.macro SAVE_ALL_NMI cr3_reg:req unwind_espfix=0
+	SAVE_ALL unwind_espfix=\unwind_espfix
 
 	BUG_IF_WRONG_CR3
 
@@ -357,6 +376,7 @@
 2:	popl	%es
 3:	popl	%fs
 	POP_GS \pop
+	IRET_FRAME
 .pushsection .fixup, "ax"
 4:	movl	$0, (%esp)
 	jmp	1b
@@ -395,7 +415,8 @@
 
 .macro CHECK_AND_APPLY_ESPFIX
 #ifdef CONFIG_X86_ESPFIX32
-#define GDT_ESPFIX_SS PER_CPU_VAR(gdt_page) + (GDT_ENTRY_ESPFIX_SS * 8)
+#define GDT_ESPFIX_OFFSET (GDT_ENTRY_ESPFIX_SS * 8)
+#define GDT_ESPFIX_SS PER_CPU_VAR(gdt_page) + GDT_ESPFIX_OFFSET
 
 	ALTERNATIVE	"jmp .Lend_\@", "", X86_BUG_ESPFIX
 
@@ -1075,7 +1096,6 @@ restore_all:
 	/* Restore user state */
 	RESTORE_REGS pop=4			# skip orig_eax/error_code
 .Lirq_return:
-	IRET_FRAME
 	/*
 	 * ARCH_HAS_MEMBARRIER_SYNC_CORE rely on IRET core serialization
 	 * when returning from IPI handler and when returning from
@@ -1128,30 +1148,43 @@ ENDPROC(entry_INT80_32)
  * We can't call C functions using the ESPFIX stack. This code reads
  * the high word of the segment base from the GDT and swiches to the
  * normal stack and adjusts ESP with the matching offset.
+ *
+ * We might be on user CR3 here, so percpu data is not mapped and we can't
+ * access the GDT through the percpu segment.  Instead, use SGDT to find
+ * the cpu_entry_area alias of the GDT.
  */
 #ifdef CONFIG_X86_ESPFIX32
 	/* fixup the stack */
-	mov	GDT_ESPFIX_SS + 4, %al /* bits 16..23 */
-	mov	GDT_ESPFIX_SS + 7, %ah /* bits 24..31 */
+	pushl	%ecx
+	subl	$2*4, %esp
+	sgdt	(%esp)
+	movl	2(%esp), %ecx				/* GDT address */
+	/*
+	 * Careful: ECX is a linear pointer, so we need to force base
+	 * zero.  %cs is the only known-linear segment we have right now.
+	 */
+	mov	%cs:GDT_ESPFIX_OFFSET + 4(%ecx), %al	/* bits 16..23 */
+	mov	%cs:GDT_ESPFIX_OFFSET + 7(%ecx), %ah	/* bits 24..31 */
 	shl	$16, %eax
+	addl	$2*4, %esp
+	popl	%ecx
 	addl	%esp, %eax			/* the adjusted stack pointer */
 	pushl	$__KERNEL_DS
 	pushl	%eax
 	lss	(%esp), %esp			/* switch to the normal stack segment */
 #endif
 .endm
+
 .macro UNWIND_ESPFIX_STACK
+	/* It's safe to clobber %eax, all other regs need to be preserved */
 #ifdef CONFIG_X86_ESPFIX32
 	movl	%ss, %eax
 	/* see if on espfix stack */
 	cmpw	$__ESPFIX_SS, %ax
-	jne	27f
-	movl	$__KERNEL_DS, %eax
-	movl	%eax, %ds
-	movl	%eax, %es
+	jne	.Lno_fixup_\@
 	/* switch to normal stack */
 	FIXUP_ESPFIX_STACK
-27:
+.Lno_fixup_\@:
 #endif
 .endm
 
@@ -1341,11 +1374,6 @@ END(spurious_interrupt_bug)
 
 #ifdef CONFIG_XEN_PV
 ENTRY(xen_hypervisor_callback)
-	pushl	$-1				/* orig_ax = -1 => not a system call */
-	SAVE_ALL
-	ENCODE_FRAME_POINTER
-	TRACE_IRQS_OFF
-
 	/*
 	 * Check to see if we got the event in the critical
 	 * region in xen_iret_direct, after we've reenabled
@@ -1353,16 +1381,17 @@ ENTRY(xen_hypervisor_callback)
 	 * iret instruction's behaviour where it delivers a
 	 * pending interrupt when enabling interrupts:
 	 */
-	movl	PT_EIP(%esp), %eax
-	cmpl	$xen_iret_start_crit, %eax
+	cmpl	$xen_iret_start_crit, (%esp)
 	jb	1f
-	cmpl	$xen_iret_end_crit, %eax
+	cmpl	$xen_iret_end_crit, (%esp)
 	jae	1f
-
-	jmp	xen_iret_crit_fixup
-
-ENTRY(xen_do_upcall)
-1:	mov	%esp, %eax
+	call	xen_iret_crit_fixup
+1:
+	pushl	$-1				/* orig_ax = -1 => not a system call */
+	SAVE_ALL
+	ENCODE_FRAME_POINTER
+	TRACE_IRQS_OFF
+	mov	%esp, %eax
 	call	xen_evtchn_do_upcall
 #ifndef CONFIG_PREEMPTION
 	call	xen_maybe_preempt_hcall
@@ -1449,10 +1478,9 @@ END(page_fault)
 
 common_exception_read_cr2:
 	/* the function address is in %gs's slot on the stack */
-	SAVE_ALL switch_stacks=1 skip_gs=1
+	SAVE_ALL switch_stacks=1 skip_gs=1 unwind_espfix=1
 
 	ENCODE_FRAME_POINTER
-	UNWIND_ESPFIX_STACK
 
 	/* fixup %gs */
 	GS_TO_REG %ecx
@@ -1474,9 +1502,8 @@ END(common_exception_read_cr2)
 
 common_exception:
 	/* the function address is in %gs's slot on the stack */
-	SAVE_ALL switch_stacks=1 skip_gs=1
+	SAVE_ALL switch_stacks=1 skip_gs=1 unwind_espfix=1
 	ENCODE_FRAME_POINTER
-	UNWIND_ESPFIX_STACK
 
 	/* fixup %gs */
 	GS_TO_REG %ecx
@@ -1515,6 +1542,10 @@ ENTRY(nmi)
 	ASM_CLAC
 
 #ifdef CONFIG_X86_ESPFIX32
+	/*
+	 * ESPFIX_SS is only ever set on the return to user path
+	 * after we've switched to the entry stack.
+	 */
 	pushl	%eax
 	movl	%ss, %eax
 	cmpw	$__ESPFIX_SS, %ax
@@ -1550,6 +1581,11 @@ ENTRY(nmi)
 	movl	%ebx, %esp
 
 .Lnmi_return:
+#ifdef CONFIG_X86_ESPFIX32
+	testl	$CS_FROM_ESPFIX, PT_CS(%esp)
+	jnz	.Lnmi_from_espfix
+#endif
+
 	CHECK_AND_APPLY_ESPFIX
 	RESTORE_ALL_NMI cr3_reg=%edi pop=4
 	jmp	.Lirq_return
@@ -1557,23 +1593,42 @@ ENTRY(nmi)
 #ifdef CONFIG_X86_ESPFIX32
 .Lnmi_espfix_stack:
 	/*
-	 * create the pointer to lss back
+	 * Create the pointer to LSS back
 	 */
 	pushl	%ss
 	pushl	%esp
 	addl	$4, (%esp)
-	/* copy the iret frame of 12 bytes */
-	.rept 3
-	pushl	16(%esp)
-	.endr
-	pushl	%eax
-	SAVE_ALL_NMI cr3_reg=%edi
+
+	/* Copy the (short) IRET frame */
+	pushl	4*4(%esp)	# flags
+	pushl	4*4(%esp)	# cs
+	pushl	4*4(%esp)	# ip
+
+	pushl	%eax		# orig_ax
+
+	SAVE_ALL_NMI cr3_reg=%edi unwind_espfix=1
 	ENCODE_FRAME_POINTER
-	FIXUP_ESPFIX_STACK			# %eax == %esp
+
+	/* clear CS_FROM_KERNEL, set CS_FROM_ESPFIX */
+	xorl	$(CS_FROM_ESPFIX | CS_FROM_KERNEL), PT_CS(%esp)
+
 	xorl	%edx, %edx			# zero error code
-	call	do_nmi
+	movl	%esp, %eax			# pt_regs pointer
+	jmp	.Lnmi_from_sysenter_stack
+
+.Lnmi_from_espfix:
 	RESTORE_ALL_NMI cr3_reg=%edi
-	lss	12+4(%esp), %esp		# back to espfix stack
+	/*
+	 * Because we cleared CS_FROM_KERNEL, IRET_FRAME 'forgot' to
+	 * fix up the gap and long frame:
+	 *
+	 *  3 - original frame	(exception)
+	 *  2 - ESPFIX block	(above)
+	 *  6 - gap		(FIXUP_FRAME)
+	 *  5 - long frame	(FIXUP_FRAME)
+	 *  1 - orig_ax
+	 */
+	lss	(1+5+6)*4(%esp), %esp			# back to espfix stack
 	jmp	.Lirq_return
 #endif
 END(nmi)
diff --git a/arch/x86/include/asm/cpu_entry_area.h b/arch/x86/include/asm/cpu_entry_area.h
index 8348f7d69fd5..ea866c7bf31d 100644
--- a/arch/x86/include/asm/cpu_entry_area.h
+++ b/arch/x86/include/asm/cpu_entry_area.h
@@ -78,8 +78,12 @@ struct cpu_entry_area {
 
 	/*
 	 * The GDT is just below entry_stack and thus serves (on x86_64) as
-	 * a a read-only guard page.
+	 * a read-only guard page. On 32-bit the GDT must be writeable, so
+	 * it needs an extra guard page.
 	 */
+#ifdef CONFIG_X86_32
+	char guard_entry_stack[PAGE_SIZE];
+#endif
 	struct entry_stack_page entry_stack_page;
 
 	/*
@@ -94,7 +98,6 @@ struct cpu_entry_area {
 	 */
 	struct cea_exception_stacks estacks;
 #endif
-#ifdef CONFIG_CPU_SUP_INTEL
 	/*
 	 * Per CPU debug store for Intel performance monitoring. Wastes a
 	 * full page at the moment.
@@ -105,11 +108,13 @@ struct cpu_entry_area {
 	 * Reserve enough fixmap PTEs.
 	 */
 	struct debug_store_buffers cpu_debug_buffers;
-#endif
 };
 
-#define CPU_ENTRY_AREA_SIZE	(sizeof(struct cpu_entry_area))
-#define CPU_ENTRY_AREA_TOT_SIZE	(CPU_ENTRY_AREA_SIZE * NR_CPUS)
+#define CPU_ENTRY_AREA_SIZE		(sizeof(struct cpu_entry_area))
+#define CPU_ENTRY_AREA_ARRAY_SIZE	(CPU_ENTRY_AREA_SIZE * NR_CPUS)
+
+/* Total size includes the readonly IDT mapping page as well: */
+#define CPU_ENTRY_AREA_TOTAL_SIZE	(CPU_ENTRY_AREA_ARRAY_SIZE + PAGE_SIZE)
 
 DECLARE_PER_CPU(struct cpu_entry_area *, cpu_entry_area);
 DECLARE_PER_CPU(struct cea_exception_stacks *, cea_exception_stacks);
@@ -117,13 +122,14 @@ DECLARE_PER_CPU(struct cea_exception_stacks *, cea_exception_stacks);
 extern void setup_cpu_entry_areas(void);
 extern void cea_set_pte(void *cea_vaddr, phys_addr_t pa, pgprot_t flags);
 
+/* Single page reserved for the readonly IDT mapping: */
 #define	CPU_ENTRY_AREA_RO_IDT		CPU_ENTRY_AREA_BASE
 #define CPU_ENTRY_AREA_PER_CPU		(CPU_ENTRY_AREA_RO_IDT + PAGE_SIZE)
 
 #define CPU_ENTRY_AREA_RO_IDT_VADDR	((void *)CPU_ENTRY_AREA_RO_IDT)
 
 #define CPU_ENTRY_AREA_MAP_SIZE			\
-	(CPU_ENTRY_AREA_PER_CPU + CPU_ENTRY_AREA_TOT_SIZE - CPU_ENTRY_AREA_BASE)
+	(CPU_ENTRY_AREA_PER_CPU + CPU_ENTRY_AREA_ARRAY_SIZE - CPU_ENTRY_AREA_BASE)
 
 extern struct cpu_entry_area *get_cpu_entry_area(int cpu);
 
diff --git a/arch/x86/include/asm/pgtable_32_types.h b/arch/x86/include/asm/pgtable_32_types.h
index b0bc0fff5f1f..1636eb8e5a5b 100644
--- a/arch/x86/include/asm/pgtable_32_types.h
+++ b/arch/x86/include/asm/pgtable_32_types.h
@@ -44,11 +44,11 @@ extern bool __vmalloc_start_set; /* set once high_memory is set */
  * Define this here and validate with BUILD_BUG_ON() in pgtable_32.c
  * to avoid include recursion hell
  */
-#define CPU_ENTRY_AREA_PAGES	(NR_CPUS * 40)
+#define CPU_ENTRY_AREA_PAGES	(NR_CPUS * 39)
 
-#define CPU_ENTRY_AREA_BASE						\
-	((FIXADDR_TOT_START - PAGE_SIZE * (CPU_ENTRY_AREA_PAGES + 1))   \
-	 & PMD_MASK)
+/* The +1 is for the readonly IDT page: */
+#define CPU_ENTRY_AREA_BASE	\
+	((FIXADDR_TOT_START - PAGE_SIZE*(CPU_ENTRY_AREA_PAGES+1)) & PMD_MASK)
 
 #define LDT_BASE_ADDR		\
 	((CPU_ENTRY_AREA_BASE - PAGE_SIZE) & PMD_MASK)
diff --git a/arch/x86/include/asm/segment.h b/arch/x86/include/asm/segment.h
index ac3892920419..6669164abadc 100644
--- a/arch/x86/include/asm/segment.h
+++ b/arch/x86/include/asm/segment.h
@@ -31,6 +31,18 @@
  */
 #define SEGMENT_RPL_MASK	0x3
 
+/*
+ * When running on Xen PV, the actual privilege level of the kernel is 1,
+ * not 0. Testing the Requested Privilege Level in a segment selector to
+ * determine whether the context is user mode or kernel mode with
+ * SEGMENT_RPL_MASK is wrong because the PV kernel's privilege level
+ * matches the 0x3 mask.
+ *
+ * Testing with USER_SEGMENT_RPL_MASK is valid for both native and Xen PV
+ * kernels because privilege level 2 is never used.
+ */
+#define USER_SEGMENT_RPL_MASK	0x2
+
 /* User mode is privilege level 3: */
 #define USER_RPL		0x3
 
diff --git a/arch/x86/kernel/doublefault.c b/arch/x86/kernel/doublefault.c
index 0b8cedb20d6d..d5c9b13bafdf 100644
--- a/arch/x86/kernel/doublefault.c
+++ b/arch/x86/kernel/doublefault.c
@@ -65,6 +65,9 @@ struct x86_hw_tss doublefault_tss __cacheline_aligned = {
 	.ss		= __KERNEL_DS,
 	.ds		= __USER_DS,
 	.fs		= __KERNEL_PERCPU,
+#ifndef CONFIG_X86_32_LAZY_GS
+	.gs		= __KERNEL_STACK_CANARY,
+#endif
 
 	.__cr3		= __pa_nodebug(swapper_pg_dir),
 };
diff --git a/arch/x86/kernel/head_32.S b/arch/x86/kernel/head_32.S
index 30f9cb2c0b55..2e6a0676c1f4 100644
--- a/arch/x86/kernel/head_32.S
+++ b/arch/x86/kernel/head_32.S
@@ -571,6 +571,16 @@ ENTRY(initial_page_table)
 #  error "Kernel PMDs should be 1, 2 or 3"
 # endif
 	.align PAGE_SIZE		/* needs to be page-sized too */
+
+#ifdef CONFIG_PAGE_TABLE_ISOLATION
+	/*
+	 * PTI needs another page so sync_initial_pagetable() works correctly
+	 * and does not scribble over the data which is placed behind the
+	 * actual initial_page_table. See clone_pgd_range().
+	 */
+	.fill 1024, 4, 0
+#endif
+
 #endif
 
 .data
diff --git a/arch/x86/mm/cpu_entry_area.c b/arch/x86/mm/cpu_entry_area.c
index 752ad11d6868..d9643647a9ce 100644
--- a/arch/x86/mm/cpu_entry_area.c
+++ b/arch/x86/mm/cpu_entry_area.c
@@ -178,7 +178,9 @@ static __init void setup_cpu_entry_area_ptes(void)
 #ifdef CONFIG_X86_32
 	unsigned long start, end;
 
-	BUILD_BUG_ON(CPU_ENTRY_AREA_PAGES * PAGE_SIZE < CPU_ENTRY_AREA_MAP_SIZE);
+	/* The +1 is for the readonly IDT: */
+	BUILD_BUG_ON((CPU_ENTRY_AREA_PAGES+1)*PAGE_SIZE != CPU_ENTRY_AREA_MAP_SIZE);
+	BUILD_BUG_ON(CPU_ENTRY_AREA_TOTAL_SIZE != CPU_ENTRY_AREA_MAP_SIZE);
 	BUG_ON(CPU_ENTRY_AREA_BASE & ~PMD_MASK);
 
 	start = CPU_ENTRY_AREA_BASE;
diff --git a/arch/x86/xen/xen-asm_32.S b/arch/x86/xen/xen-asm_32.S
index c15db060a242..cd177772fe4d 100644
--- a/arch/x86/xen/xen-asm_32.S
+++ b/arch/x86/xen/xen-asm_32.S
@@ -126,10 +126,9 @@ hyper_iret:
 	.globl xen_iret_start_crit, xen_iret_end_crit
 
 /*
- * This is called by xen_hypervisor_callback in entry.S when it sees
+ * This is called by xen_hypervisor_callback in entry_32.S when it sees
  * that the EIP at the time of interrupt was between
- * xen_iret_start_crit and xen_iret_end_crit.  We're passed the EIP in
- * %eax so we can do a more refined determination of what to do.
+ * xen_iret_start_crit and xen_iret_end_crit.
  *
  * The stack format at this point is:
  *	----------------
@@ -138,70 +137,46 @@ hyper_iret:
  *	 eflags		}  outer exception info
  *	 cs		}
  *	 eip		}
- *	---------------- <- edi (copy dest)
- *	 eax		:  outer eax if it hasn't been restored
  *	----------------
- *	 eflags		}  nested exception info
- *	 cs		}   (no ss/esp because we're nested
- *	 eip		}    from the same ring)
- *	 orig_eax	}<- esi (copy src)
- *	 - - - - - - - -
- *	 fs		}
- *	 es		}
- *	 ds		}  SAVE_ALL state
- *	 eax		}
- *	  :		:
- *	 ebx		}<- esp
+ *	 eax		:  outer eax if it hasn't been restored
  *	----------------
+ *	 eflags		}
+ *	 cs		}  nested exception info
+ *	 eip		}
+ *	 return address	: (into xen_hypervisor_callback)
  *
- * In order to deliver the nested exception properly, we need to shift
- * everything from the return addr up to the error code so it sits
- * just under the outer exception info.  This means that when we
- * handle the exception, we do it in the context of the outer
- * exception rather than starting a new one.
+ * In order to deliver the nested exception properly, we need to discard the
+ * nested exception frame such that when we handle the exception, we do it
+ * in the context of the outer exception rather than starting a new one.
  *
- * The only caveat is that if the outer eax hasn't been restored yet
- * (ie, it's still on stack), we need to insert its value into the
- * SAVE_ALL state before going on, since it's usermode state which we
- * eventually need to restore.
+ * The only caveat is that if the outer eax hasn't been restored yet (i.e.
+ * it's still on stack), we need to restore its value here.
  */
 ENTRY(xen_iret_crit_fixup)
 	/*
 	 * Paranoia: Make sure we're really coming from kernel space.
 	 * One could imagine a case where userspace jumps into the
 	 * critical range address, but just before the CPU delivers a
-	 * GP, it decides to deliver an interrupt instead.  Unlikely?
-	 * Definitely.  Easy to avoid?  Yes.  The Intel documents
-	 * explicitly say that the reported EIP for a bad jump is the
-	 * jump instruction itself, not the destination, but some
-	 * virtual environments get this wrong.
+	 * PF, it decides to deliver an interrupt instead.  Unlikely?
+	 * Definitely.  Easy to avoid?  Yes.
 	 */
-	movl PT_CS(%esp), %ecx
-	andl $SEGMENT_RPL_MASK, %ecx
-	cmpl $USER_RPL, %ecx
-	je 2f
-
-	lea PT_ORIG_EAX(%esp), %esi
-	lea PT_EFLAGS(%esp), %edi
+	testb $2, 2*4(%esp)		/* nested CS */
+	jnz 2f
 
 	/*
 	 * If eip is before iret_restore_end then stack
 	 * hasn't been restored yet.
 	 */
-	cmp $iret_restore_end, %eax
+	cmpl $iret_restore_end, 1*4(%esp)
 	jae 1f
 
-	movl 0+4(%edi), %eax		/* copy EAX (just above top of frame) */
-	movl %eax, PT_EAX(%esp)
+	movl 4*4(%esp), %eax		/* load outer EAX */
+	ret $4*4			/* discard nested EIP, CS, and EFLAGS as
+					 * well as the just restored EAX */
 
-	lea ESP_OFFSET(%edi), %edi	/* move dest up over saved regs */
-
-	/* set up the copy */
-1:	std
-	mov $PT_EIP / 4, %ecx		/* saved regs up to orig_eax */
-	rep movsl
-	cld
-
-	lea 4(%edi), %esp		/* point esp to new frame */
-2:	jmp xen_do_upcall
+1:
+	ret $3*4			/* discard nested EIP, CS, and EFLAGS */
 
+2:
+	ret
+END(xen_iret_crit_fixup)
diff --git a/tools/testing/selftests/x86/mov_ss_trap.c b/tools/testing/selftests/x86/mov_ss_trap.c
index 3c3a022654f3..6da0ac3f0135 100644
--- a/tools/testing/selftests/x86/mov_ss_trap.c
+++ b/tools/testing/selftests/x86/mov_ss_trap.c
@@ -257,7 +257,8 @@ int main()
 			err(1, "sigaltstack");
 		sethandler(SIGSEGV, handle_and_longjmp, SA_RESETHAND | SA_ONSTACK);
 		nr = SYS_getpid;
-		asm volatile ("mov %[ss], %%ss; SYSENTER" : "+a" (nr)
+		/* Clear EBP first to make sure we segfault cleanly. */
+		asm volatile ("xorl %%ebp, %%ebp; mov %[ss], %%ss; SYSENTER" : "+a" (nr)
 			      : [ss] "m" (ss) : "flags", "rcx"
 #ifdef __x86_64__
 				, "r11"
diff --git a/tools/testing/selftests/x86/sigreturn.c b/tools/testing/selftests/x86/sigreturn.c
index 3e49a7873f3e..57c4f67f16ef 100644
--- a/tools/testing/selftests/x86/sigreturn.c
+++ b/tools/testing/selftests/x86/sigreturn.c
@@ -451,6 +451,19 @@ static void sigusr1(int sig, siginfo_t *info, void *ctx_void)
 	ctx->uc_mcontext.gregs[REG_SP] = (unsigned long)0x8badf00d5aadc0deULL;
 	ctx->uc_mcontext.gregs[REG_CX] = 0;
 
+#ifdef __i386__
+	/*
+	 * Make sure the kernel doesn't inadvertently use DS or ES-relative
+	 * accesses in a region where user DS or ES is loaded.
+	 *
+	 * Skip this for 64-bit builds because long mode doesn't care about
+	 * DS and ES and skipping it increases test coverage a little bit,
+	 * since 64-bit kernels can still run the 32-bit build.
+	 */
+	ctx->uc_mcontext.gregs[REG_DS] = 0;
+	ctx->uc_mcontext.gregs[REG_ES] = 0;
+#endif
+
 	memcpy(&requested_regs, &ctx->uc_mcontext.gregs, sizeof(gregset_t));
 	requested_regs[REG_CX] = *ssptr(ctx);	/* The asm code does this. */
 
