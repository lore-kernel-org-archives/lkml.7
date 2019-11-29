Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0982C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 17:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C3BF208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 17:21:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="he8ZjUB1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbfK2RVq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 12:21:46 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:60113 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbfK2RVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 12:21:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575048104;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yO4mbaXaaiDqs59dLTQPwl7pTirdxQl8UxhZbgt1nRw=;
        b=he8ZjUB1f0jFrntvKHV2OoXtTtbO7LgQ1afWJY7Ydq3uaMqzxT4k2TZe9lKwC7IK7F/ekr
        YDzxcsZLbo6ltLtg9SyyWIBXbnIi+RAwlzsZUW5IUzJNUEDgF0zvQIG6OkXNObHrbhO6fV
        FFg8QNFCHeffjd72BBgJQtE545WOkgM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7-b-e4JdX5OUS6eV9nRQ6XdA-1; Fri, 29 Nov 2019 12:21:41 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2FD22101F7C5;
        Fri, 29 Nov 2019 17:21:39 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.44])
        by smtp.corp.redhat.com (Postfix) with SMTP id BDD2010013A1;
        Fri, 29 Nov 2019 17:21:33 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri, 29 Nov 2019 18:21:38 +0100 (CET)
Date:   Fri, 29 Nov 2019 18:21:32 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Jan Kratochvil <jan.kratochvil@redhat.com>,
        Pedro Alves <palves@redhat.com>, Peter Anvin <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [PATCH] ptrace/x86: introduce TS_COMPAT_RESTART to fix
 get_nr_restart_syscall()
Message-ID: <20191129172132.GA3992@redhat.com>
References: <20191126110659.GA14042@redhat.com>
 <20191126110758.GA14051@redhat.com>
 <CAHk-=whrhuNg_53wc3pBVToH-AUwKDbC5P_cb7=8bYfn=BYCJA@mail.gmail.com>
 <20191127170234.GA26180@redhat.com>
 <CAHk-=wi9YO5M-LHuTuczQbK6hBrweCoZHVEsiTak6jGuoFt2Sw@mail.gmail.com>
 <20191128153644.GA5508@redhat.com>
 <CAHk-=whA1h-7MKGdzyViwJR4_rqYKMP91FwuObWneBZE0yH81A@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAHk-=whA1h-7MKGdzyViwJR4_rqYKMP91FwuObWneBZE0yH81A@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: b-e4JdX5OUS6eV9nRQ6XdA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/28, Linus Torvalds wrote:
>
> > --- a/arch/x86/include/asm/signal.h
> > +++ b/arch/x86/include/asm/signal.h
> > @@ -5,6 +5,10 @@
> >  #ifndef __ASSEMBLY__
> >  #include <linux/linkage.h>
> >
> > +struct restart_block;
> > +extern void arch_set_restart_data(struct restart_block *);
> > +#define arch_set_restart_data  arch_set_restart_data
>=20
> I'd just replace this with
>=20
>    /* We need to save TS_COMPAT at the time of the call */
>    #define arch_set_restart_data(blk) (blk)->arch_data =3D
> current_thread_info()->status

OK, but then this code should live in {linux,asm}/thread_info.h. And this
is probably better, linux/thread_info.h already includes restart_block.h.

What do you think about 1-4 below?

Please note that 3/4 adds TS_COMPAT_RESTART you do not like, 4/4 kills it
and adds restart_block->arch_data.

This is because I will need to backport this fix, and 4/4 is not trivially
backportable due to KABI issues.

Oleg.


From d1000d6f52ede3875c633067a5ec34e7ba138bc4 Mon Sep 17 00:00:00 2001
From: Oleg Nesterov <oleg@redhat.com>
Date: Fri, 29 Nov 2019 16:51:12 +0100
Subject: [PATCH 1/4] introduce set_restart_fn()

---
 fs/select.c                    | 10 ++++------
 include/linux/thread_info.h    | 12 ++++++++++++
 kernel/futex.c                 |  3 +--
 kernel/time/alarmtimer.c       |  2 +-
 kernel/time/hrtimer.c          |  2 +-
 kernel/time/posix-cpu-timers.c |  2 +-
 6 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/fs/select.c b/fs/select.c
index 53a0c14..e517960 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -1037,10 +1037,9 @@ static long do_restart_poll(struct restart_block *re=
start_block)
=20
 =09ret =3D do_sys_poll(ufds, nfds, to);
=20
-=09if (ret =3D=3D -ERESTARTNOHAND) {
-=09=09restart_block->fn =3D do_restart_poll;
-=09=09ret =3D -ERESTART_RESTARTBLOCK;
-=09}
+=09if (ret =3D=3D -ERESTARTNOHAND)
+=09=09ret =3D set_restart_fn(restart_block, do_restart_poll);
+
 =09return ret;
 }
=20
@@ -1062,7 +1061,6 @@ SYSCALL_DEFINE3(poll, struct pollfd __user *, ufds, u=
nsigned int, nfds,
 =09=09struct restart_block *restart_block;
=20
 =09=09restart_block =3D &current->restart_block;
-=09=09restart_block->fn =3D do_restart_poll;
 =09=09restart_block->poll.ufds =3D ufds;
 =09=09restart_block->poll.nfds =3D nfds;
=20
@@ -1073,7 +1071,7 @@ SYSCALL_DEFINE3(poll, struct pollfd __user *, ufds, u=
nsigned int, nfds,
 =09=09} else
 =09=09=09restart_block->poll.has_timeout =3D 0;
=20
-=09=09ret =3D -ERESTART_RESTARTBLOCK;
+=09=09ret =3D set_restart_fn(restart_block, do_restart_poll);
 =09}
 =09return ret;
 }
diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
index 659a440..df8e3fb 100644
--- a/include/linux/thread_info.h
+++ b/include/linux/thread_info.h
@@ -39,6 +39,18 @@ enum {
=20
 #ifdef __KERNEL__
=20
+#ifndef arch_set_restart_data
+#define arch_set_restart_data(restart) do { } while (0)
+#endif
+
+static inline long set_restart_fn(struct restart_block *restart,
+=09=09=09=09=09long (*fn)(struct restart_block *))
+{
+=09restart->fn =3D fn;
+=09arch_set_restart_data(restart);
+=09return -ERESTART_RESTARTBLOCK;
+}
+
 #ifndef THREAD_ALIGN
 #define THREAD_ALIGN=09THREAD_SIZE
 #endif
diff --git a/kernel/futex.c b/kernel/futex.c
index bd18f60..f4f20e9 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -2753,14 +2753,13 @@ static int futex_wait(u32 __user *uaddr, unsigned i=
nt flags, u32 val,
 =09=09goto out;
=20
 =09restart =3D &current->restart_block;
-=09restart->fn =3D futex_wait_restart;
 =09restart->futex.uaddr =3D uaddr;
 =09restart->futex.val =3D val;
 =09restart->futex.time =3D *abs_time;
 =09restart->futex.bitset =3D bitset;
 =09restart->futex.flags =3D flags | FLAGS_HAS_TIMEOUT;
=20
-=09ret =3D -ERESTART_RESTARTBLOCK;
+=09ret =3D set_restart_fn(restart, futex_wait_restart);
=20
 out:
 =09if (to) {
diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index 451f9d0..a2ddf56 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -829,9 +829,9 @@ static int alarm_timer_nsleep(const clockid_t which_clo=
ck, int flags,
 =09if (flags =3D=3D TIMER_ABSTIME)
 =09=09return -ERESTARTNOHAND;
=20
-=09restart->fn =3D alarm_timer_nsleep_restart;
 =09restart->nanosleep.clockid =3D type;
 =09restart->nanosleep.expires =3D exp;
+=09set_restart_fn(restart, alarm_timer_nsleep_restart);
 =09return ret;
 }
=20
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 6560553..55f71c4 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1932,9 +1932,9 @@ long hrtimer_nanosleep(const struct timespec64 *rqtp,
 =09}
=20
 =09restart =3D &current->restart_block;
-=09restart->fn =3D hrtimer_nanosleep_restart;
 =09restart->nanosleep.clockid =3D t.timer.base->clockid;
 =09restart->nanosleep.expires =3D hrtimer_get_expires_tv64(&t.timer);
+=09set_restart_fn(restart, hrtimer_nanosleep_restart);
 out:
 =09destroy_hrtimer_on_stack(&t.timer);
 =09return ret;
diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.=
c
index 42d512f..eacb0ca 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -1335,8 +1335,8 @@ static int posix_cpu_nsleep(const clockid_t which_clo=
ck, int flags,
 =09=09if (flags & TIMER_ABSTIME)
 =09=09=09return -ERESTARTNOHAND;
=20
-=09=09restart_block->fn =3D posix_cpu_nsleep_restart;
 =09=09restart_block->nanosleep.clockid =3D which_clock;
+=09=09set_restart_fn(restart_block, posix_cpu_nsleep_restart);
 =09}
 =09return error;
 }
--=20
2.5.0


From 54301a07a645a27c982c99e4e975321cf73c5456 Mon Sep 17 00:00:00 2001
From: Oleg Nesterov <oleg@redhat.com>
Date: Fri, 29 Nov 2019 17:45:16 +0100
Subject: [PATCH 2/4] x86: mv TS_COMPAT from asm/processor.h to
 asm/thread_info.h

---
 arch/x86/include/asm/processor.h   | 9 ---------
 arch/x86/include/asm/thread_info.h | 9 +++++++++
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/proces=
sor.h
index 54f5d54..d247a24 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -507,15 +507,6 @@ static inline void arch_thread_struct_whitelist(unsign=
ed long *offset,
 }
=20
 /*
- * Thread-synchronous status.
- *
- * This is different from the flags in that nobody else
- * ever touches our thread-synchronous status, so we don't
- * have to worry about atomic accesses.
- */
-#define TS_COMPAT=09=090x0002=09/* 32bit syscall active (64BIT)*/
-
-/*
  * Set IOPL bits in EFLAGS from given mask
  */
 static inline void native_set_iopl_mask(unsigned mask)
diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thre=
ad_info.h
index f945353..b2125c4 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -221,6 +221,15 @@ static inline int arch_within_stack_frames(const void =
* const stack,
=20
 #endif
=20
+/*
+ * Thread-synchronous status.
+ *
+ * This is different from the flags in that nobody else
+ * ever touches our thread-synchronous status, so we don't
+ * have to worry about atomic accesses.
+ */
+#define TS_COMPAT=09=090x0002=09/* 32bit syscall active (64BIT)*/
+
 #ifdef CONFIG_COMPAT
 #define TS_I386_REGS_POKED=090x0004=09/* regs poked by 32-bit ptracer */
 #endif
--=20
2.5.0


From db3784d4100cf3bc3097738da9a80fcfb6933fc6 Mon Sep 17 00:00:00 2001
From: Oleg Nesterov <oleg@redhat.com>
Date: Fri, 29 Nov 2019 17:52:42 +0100
Subject: [PATCH 3/4] ptrace/x86: introduce TS_COMPAT_RESTART to fix
 get_nr_restart_syscall()

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


From f3b1ab409152d2c8ea9c75f7688b54aa6a3cf518 Mon Sep 17 00:00:00 2001
From: Oleg Nesterov <oleg@redhat.com>
Date: Fri, 29 Nov 2019 18:05:04 +0100
Subject: [PATCH 4/4] x86: turn TS_COMPAT_RESTART into restart_block->arch_d=
ata

---
 arch/x86/include/asm/thread_info.h | 12 ++----------
 arch/x86/kernel/signal.c           |  2 +-
 include/linux/restart_block.h      |  1 +
 3 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thre=
ad_info.h
index a4de7aa..75c4a0a 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -233,18 +233,10 @@ static inline int arch_within_stack_frames(const void=
 * const stack,
 #ifndef __ASSEMBLY__
 #ifdef CONFIG_COMPAT
 #define TS_I386_REGS_POKED=090x0004=09/* regs poked by 32-bit ptracer */
-#define TS_COMPAT_RESTART=090x0008
=20
-#define arch_set_restart_data=09arch_set_restart_data
+#define arch_set_restart_data(restart)=09\
+=09do { restart->arch_data =3D current_thread_info()->status; } while (0)
=20
-static inline void arch_set_restart_data(struct restart_block *restart)
-{
-=09struct thread_info *ti =3D current_thread_info();
-=09if (ti->status & TS_COMPAT)
-=09=09ti->status |=3D TS_COMPAT_RESTART;
-=09else
-=09=09ti->status &=3D ~TS_COMPAT_RESTART;
-}
 #endif
=20
 #ifdef CONFIG_X86_32
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 2fdbf5e..2e52767 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -771,7 +771,7 @@ handle_signal(struct ksignal *ksig, struct pt_regs *reg=
s)
 static inline unsigned long get_nr_restart_syscall(const struct pt_regs *r=
egs)
 {
 #ifdef CONFIG_IA32_EMULATION
-=09if (current_thread_info()->status & TS_COMPAT_RESTART)
+=09if (current->restart_block.arch_data & TS_COMPAT)
 =09=09return __NR_ia32_restart_syscall;
 #endif
 #ifdef CONFIG_X86_X32_ABI
diff --git a/include/linux/restart_block.h b/include/linux/restart_block.h
index bba2920..980a655 100644
--- a/include/linux/restart_block.h
+++ b/include/linux/restart_block.h
@@ -23,6 +23,7 @@ enum timespec_type {
  * System call restart block.
  */
 struct restart_block {
+=09unsigned long arch_data;
 =09long (*fn)(struct restart_block *);
 =09union {
 =09=09/* For futex_wait and futex_wait_requeue_pi */
--=20
2.5.0


