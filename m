Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68753C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 15:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 410822084D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 15:36:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wi0CNiKn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbfK1Pg6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 10:36:58 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:37105 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726401AbfK1Pg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 10:36:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574955416;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YC/yOmLYDa2qCJXbkoxWtK75q4ey4hZxhcY9IKRFnMU=;
        b=Wi0CNiKnMuFmyM9mi73ko4XZE6fiQ/icwaA27db4aTsIuytTmFjanGeqSKQWMJyCwzFzTt
        0woLsYs15+i3oqt3g6zqTJdIQ/bMBACveGqMrP1kPybkJYqtFaRDGbaY475Zq1Hzqj7Gj1
        yG9VipncOHNQKHI2gYERL39iNwaVmPs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215-NMvYYFpDPHKfBuiGbcDclA-1; Thu, 28 Nov 2019 10:36:53 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 37766100F76F;
        Thu, 28 Nov 2019 15:36:51 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.44])
        by smtp.corp.redhat.com (Postfix) with SMTP id 5132B60161;
        Thu, 28 Nov 2019 15:36:45 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 28 Nov 2019 16:36:50 +0100 (CET)
Date:   Thu, 28 Nov 2019 16:36:44 +0100
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
Message-ID: <20191128153644.GA5508@redhat.com>
References: <20191126110659.GA14042@redhat.com>
 <20191126110758.GA14051@redhat.com>
 <CAHk-=whrhuNg_53wc3pBVToH-AUwKDbC5P_cb7=8bYfn=BYCJA@mail.gmail.com>
 <20191127170234.GA26180@redhat.com>
 <CAHk-=wi9YO5M-LHuTuczQbK6hBrweCoZHVEsiTak6jGuoFt2Sw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAHk-=wi9YO5M-LHuTuczQbK6hBrweCoZHVEsiTak6jGuoFt2Sw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: NMvYYFpDPHKfBuiGbcDclA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/27, Linus Torvalds wrote:
>
> On Wed, Nov 27, 2019 at 9:02 AM Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > OK, lets add the new restart_block.nr_restart_syscall field, then we ne=
ed
> >
> >         void set_restart_block_fn(restart, fn)
> >         {
> >                 restart->nr_restart_syscall =3D arch_get_nr_restart_sys=
call()
> >                 restart->fn =3D fn;
> >         }
>
> No, I'd suggest just adding an arch-specific "unsigned long" to the
> restart data (and not force the naming to something like the system
> call number - that's just an x86 detail), and then something like this
> on x86:
>
>    void arch_set_restart_data(restart)
>    {
>       restart->arch_data =3D x86_get_restart_syscall();
>   }
>   #define arch_set_restart_data arch_set_restart_data
>
> and then we'd have in generic code something like
>
>   #ifndef arch_set_restart_data
>   #define arch_set_restart_data(block) do { } while (0)
>   #endif

OK, let it be arch_data/arch_set_restart_data, the same thing.

You misunderstood my question, I do not see a good place for the code
above. So I am going to uglify */signal.[ch] files.

See the incomplete patch below, everything else is trivial.

Please tell me if you think I should move this code somewhere else.

Oleg.


diff --git a/arch/x86/include/asm/signal.h b/arch/x86/include/asm/signal.h
index 33d3c88..f536bcb 100644
--- a/arch/x86/include/asm/signal.h
+++ b/arch/x86/include/asm/signal.h
@@ -5,6 +5,10 @@
 #ifndef __ASSEMBLY__
 #include <linux/linkage.h>
=20
+struct restart_block;
+extern void arch_set_restart_data(struct restart_block *);
+#define arch_set_restart_data=09arch_set_restart_data
+
 /* Most things should be clean enough to redefine this at will, if care
    is taken to make libc match.  */
=20
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 8eb7193..ede5443 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -768,6 +768,11 @@ handle_signal(struct ksignal *ksig, struct pt_regs *re=
gs)
 =09signal_setup_done(failed, ksig, stepping);
 }
=20
+void arch_set_restart_data(struct restart_block *restart)
+{
+=09// TODO
+}
+
 static inline unsigned long get_nr_restart_syscall(const struct pt_regs *r=
egs)
 {
 =09/*
diff --git a/include/linux/restart_block.h b/include/linux/restart_block.h
index bba2920..d39f836 100644
--- a/include/linux/restart_block.h
+++ b/include/linux/restart_block.h
@@ -55,6 +55,8 @@ struct restart_block {
 =09};
 };
=20
+extern long set_restart_fn(struct restart_block *restart,
+=09=09=09=09long (*fn)(struct restart_block *));
 extern long do_no_restart_syscall(struct restart_block *parm);
=20
 #endif /* __LINUX_RESTART_BLOCK_H */
diff --git a/include/linux/signal.h b/include/linux/signal.h
index 1a5f883..542499f 100644
--- a/include/linux/signal.h
+++ b/include/linux/signal.h
@@ -5,12 +5,17 @@
 #include <linux/bug.h>
 #include <linux/signal_types.h>
 #include <linux/string.h>
+#include <linux/restart_block.h>
=20
 struct task_struct;
=20
 /* for sysctl */
 extern int print_fatal_signals;
=20
+#ifndef arch_set_restart_data
+#define arch_set_restart_data(restart) do { } while (0)
+#endif
+
 static inline void copy_siginfo(kernel_siginfo_t *to,
 =09=09=09=09const kernel_siginfo_t *from)
 {
diff --git a/kernel/signal.c b/kernel/signal.c
index bcd46f5..d6402e6 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -4493,6 +4493,14 @@ SYSCALL_DEFINE3(sigsuspend, int, unused1, int, unuse=
d2, old_sigset_t, mask)
 }
 #endif
=20
+long set_restart_fn(struct restart_block *restart,
+=09=09=09long (*fn)(struct restart_block *))
+{
+=09restart->fn =3D fn;
+=09arch_set_restart_data(restart);
+=09return -ERESTART_RESTARTBLOCK;
+}
+
 __weak const char *arch_vma_name(struct vm_area_struct *vma)
 {
 =09return NULL;

