Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA9AC432C3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 14:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DFC42073F
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 14:14:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="INd/WVTf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbfLCOOI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 09:14:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33574 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726017AbfLCOOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 09:14:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575382442;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9ebzd+uNWc/5eikpXG6X8wD6ENGSQPttT3QKjOX9sXk=;
        b=INd/WVTflx9CbSAAYtyK0rQLhN9SxHYDwrvAgXsPlrhx7lnsdE6e7H+fVm0GjTI8G/o/Ff
        HiXM/6F56j1yY4GYxx0MJPcH1AUzz6Gpy1WBf1yYWvFkiF3OeZke7xn++C1zqKQcurPmYC
        h4HHJGsqhyCqOMR5DnLORaxqTEv0gTQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-289-7q8u2yL2OhGwAiFwpUu7pA-1; Tue, 03 Dec 2019 09:13:59 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3EA291883552;
        Tue,  3 Dec 2019 14:13:58 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.44])
        by smtp.corp.redhat.com (Postfix) with SMTP id A624A5DA60;
        Tue,  3 Dec 2019 14:13:53 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue,  3 Dec 2019 15:13:57 +0100 (CET)
Date:   Tue, 3 Dec 2019 15:13:52 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Ingo Molnar <mingo@kernel.org>,
        Jan Kratochvil <jan.kratochvil@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Pedro Alves <palves@redhat.com>, Peter Anvin <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [PATCH v2 3/4] x86: introduce TS_COMPAT_RESTART to fix
 get_nr_restart_syscall()
Message-ID: <20191203141352.GD30688@redhat.com>
References: <20191126110659.GA14042@redhat.com>
 <20191203141239.GA30688@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191203141239.GA30688@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: 7q8u2yL2OhGwAiFwpUu7pA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The comment in get_nr_restart_syscall() says:

=09 * The problem is that we can get here when ptrace pokes
=09 * syscall-like values into regs even if we're not in a syscall
=09 * at all.

Yes. but if we are not in syscall then the

=09status & (TS_COMPAT|TS_I386_REGS_POKED)

check below can't really help:

=09- TS_COMPAT can't be set

=09- TS_I386_REGS_POKED is only set if regs->orig_ax was changed by
=09  32bit debugger; and even in this case get_nr_restart_syscall()
=09  is only correct if the tracee is 32bit too.

Suppose that 64bit debugger plays with 32bit tracee and

=09* Tracee calls sleep(2)=09// TS_COMPAT is set
=09* User interrupts the tracee by CTRL-C after 1 sec and does
=09  "(gdb) call func()"
=09* gdb saves the regs by PTRACE_GETREGS
=09* does PTRACE_SETREGS to set %rip=3D'func' and %orig_rax=3D-1
=09* PTRACE_CONT=09=09// TS_COMPAT is cleared
=09* func() hits int3.
=09* Debugger catches SIGTRAP.
=09* Restore original regs by PTRACE_SETREGS.
=09* PTRACE_CONT

get_nr_restart_syscall() wrongly returns __NR_restart_syscall=3D=3D219, the
tracee calls ia32_sys_call_table[219] =3D=3D sys_madvise.

This patch adds the sticky TS_COMPAT_RESTART flag which survives after
return to user mode, hopefully it allows us to kill TS_I386_REGS_POKED
but this needs another patch.

Test-case:

  $ cvs -d :pserver:anoncvs:anoncvs@sourceware.org:/cvs/systemtap co ptrace=
-tests
  $ gcc -o erestartsys-trap-debuggee ptrace-tests/tests/erestartsys-trap-de=
buggee.c --m32
  $ gcc -o erestartsys-trap-debugger ptrace-tests/tests/erestartsys-trap-de=
bugger.c -lutil
  $ ./erestartsys-trap-debugger
  Unexpected: retval 1, errno 22
  erestartsys-trap-debugger: ptrace-tests/tests/erestartsys-trap-debugger.c=
:421

Reported-by: Jan Kratochvil <jan.kratochvil@redhat.com>
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 arch/x86/include/asm/thread_info.h | 14 +++++++++++++-
 arch/x86/kernel/signal.c           | 24 +-----------------------
 2 files changed, 14 insertions(+), 24 deletions(-)

diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thre=
ad_info.h
index b2125c4..a4de7aa 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -230,10 +230,22 @@ static inline int arch_within_stack_frames(const void=
 * const stack,
  */
 #define TS_COMPAT=09=090x0002=09/* 32bit syscall active (64BIT)*/
=20
+#ifndef __ASSEMBLY__
 #ifdef CONFIG_COMPAT
 #define TS_I386_REGS_POKED=090x0004=09/* regs poked by 32-bit ptracer */
+#define TS_COMPAT_RESTART=090x0008
+
+#define arch_set_restart_data=09arch_set_restart_data
+
+static inline void arch_set_restart_data(struct restart_block *restart)
+{
+=09struct thread_info *ti =3D current_thread_info();
+=09if (ti->status & TS_COMPAT)
+=09=09ti->status |=3D TS_COMPAT_RESTART;
+=09else
+=09=09ti->status &=3D ~TS_COMPAT_RESTART;
+}
 #endif
-#ifndef __ASSEMBLY__
=20
 #ifdef CONFIG_X86_32
 #define in_ia32_syscall() true
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 8eb7193..2fdbf5e 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -770,30 +770,8 @@ handle_signal(struct ksignal *ksig, struct pt_regs *re=
gs)
=20
 static inline unsigned long get_nr_restart_syscall(const struct pt_regs *r=
egs)
 {
-=09/*
-=09 * This function is fundamentally broken as currently
-=09 * implemented.
-=09 *
-=09 * The idea is that we want to trigger a call to the
-=09 * restart_block() syscall and that we want in_ia32_syscall(),
-=09 * in_x32_syscall(), etc. to match whatever they were in the
-=09 * syscall being restarted.  We assume that the syscall
-=09 * instruction at (regs->ip - 2) matches whatever syscall
-=09 * instruction we used to enter in the first place.
-=09 *
-=09 * The problem is that we can get here when ptrace pokes
-=09 * syscall-like values into regs even if we're not in a syscall
-=09 * at all.
-=09 *
-=09 * For now, we maintain historical behavior and guess based on
-=09 * stored state.  We could do better by saving the actual
-=09 * syscall arch in restart_block or (with caveats on x32) by
-=09 * checking if regs->ip points to 'int $0x80'.  The current
-=09 * behavior is incorrect if a tracer has a different bitness
-=09 * than the tracee.
-=09 */
 #ifdef CONFIG_IA32_EMULATION
-=09if (current_thread_info()->status & (TS_COMPAT|TS_I386_REGS_POKED))
+=09if (current_thread_info()->status & TS_COMPAT_RESTART)
 =09=09return __NR_ia32_restart_syscall;
 #endif
 #ifdef CONFIG_X86_X32_ABI
--=20
2.5.0


