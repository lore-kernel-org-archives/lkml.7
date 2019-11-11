Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1DD9C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 14:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC43A20679
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 14:32:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfKKOcB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 09:32:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:41938 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726915AbfKKOcB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 09:32:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 11D91B53B;
        Mon, 11 Nov 2019 14:31:59 +0000 (UTC)
Subject: [PATCH 1/2] x86/Xen/32: make xen_iret_crit_fixup independent of frame
 layout
From:   Jan Beulich <jbeulich@suse.com>
To:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Andy Lutomirski <luto@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
References: <d66b1da4-8096-9b77-1ca6-d6b9954b113c@suse.com>
Message-ID: <32d8713d-25a7-84ab-b74b-aa3e88abce6b@suse.com>
Date:   Mon, 11 Nov 2019 15:32:12 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <d66b1da4-8096-9b77-1ca6-d6b9954b113c@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that SS:ESP always get saved by SAVE_ALL, this also needs to be
accounted for in xen_iret_crit_fixup. Otherwise the old_ax value gets
interpreted as EFLAGS, and hence VM86 mode appears to be active all
the time, leading to random "vm86_32: no user_vm86: BAD" log messages
alongside processes randomly crashing.

Since following the previous model (sitting after SAVE_ALL) would
further complicate the code _and_ retain the dependency of
xen_iret_crit_fixup on frame manipulations done by entry_32.S, switch
things around and do the adjustment ahead of SAVE_ALL.

Fixes: 3c88c692c287 ("x86/stackframe/32: Provide consistent pt_regs")
Signed-off-by: Jan Beulich <jbeulich@suse.com>

--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -1341,11 +1341,6 @@ END(spurious_interrupt_bug)
 
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
@@ -1353,16 +1348,17 @@ ENTRY(xen_hypervisor_callback)
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
@@ -138,34 +137,23 @@ hyper_iret:
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
+	pushl %ecx
 	/*
 	 * Paranoia: Make sure we're really coming from kernel space.
 	 * One could imagine a case where userspace jumps into the
@@ -176,32 +164,26 @@ ENTRY(xen_iret_crit_fixup)
 	 * jump instruction itself, not the destination, but some
 	 * virtual environments get this wrong.
 	 */
-	movl PT_CS(%esp), %ecx
+	movl 3*4(%esp), %ecx		/* nested CS */
 	andl $SEGMENT_RPL_MASK, %ecx
 	cmpl $USER_RPL, %ecx
+	popl %ecx
 	je 2f
 
-	lea PT_ORIG_EAX(%esp), %esi
-	lea PT_EFLAGS(%esp), %edi
-
 	/*
 	 * If eip is before iret_restore_end then stack
 	 * hasn't been restored yet.
 	 */
-	cmp $iret_restore_end, %eax
+	cmpl $iret_restore_end, 1*4(%esp)
 	jae 1f
 
-	movl 0+4(%edi), %eax		/* copy EAX (just above top of frame) */
-	movl %eax, PT_EAX(%esp)
-
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
-
+	movl 4*4(%esp), %eax		/* load outer EAX */
+	ret $4*4			/* discard nested EIP, CS, and EFLAGS as
+					 * well as the just restored EAX */
+
+1:
+	ret $3*4			/* discard nested EIP, CS, and EFLAGS */
+
+2:
+	ret
+END(xen_iret_crit_fixup)

