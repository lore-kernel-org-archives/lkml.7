Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DBB0C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 17:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C168E206F0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 17:02:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iXf/BFVW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbfK0RCr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 12:02:47 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:27659 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726984AbfK0RCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 12:02:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574874166;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PFznFDlZHRH6jRkPfupU/SWMKG2b5n/tHVJYWZ7aun8=;
        b=iXf/BFVW6/MXIIqck8MXGoL690M3sZdGrwHiAhkZleptYQEAkajSZioUZgKIDUiQ8BpWqB
        RmFN5cjgwaEt0jK6DUrCoxBrl/ClWonOeg3Tjrq+3ptrx4qh4SOyArHH91nWnOCm82P5H3
        qoStCUDt0Y6d38OKV1oJXDlaTf5MM48=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-400-so-q2ANANmuDtfaY4tta0Q-1; Wed, 27 Nov 2019 12:02:43 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 38EBA8017D9;
        Wed, 27 Nov 2019 17:02:41 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.44])
        by smtp.corp.redhat.com (Postfix) with SMTP id 841AB5C219;
        Wed, 27 Nov 2019 17:02:36 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 27 Nov 2019 18:02:40 +0100 (CET)
Date:   Wed, 27 Nov 2019 18:02:35 +0100
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
Message-ID: <20191127170234.GA26180@redhat.com>
References: <20191126110659.GA14042@redhat.com>
 <20191126110758.GA14051@redhat.com>
 <CAHk-=whrhuNg_53wc3pBVToH-AUwKDbC5P_cb7=8bYfn=BYCJA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAHk-=whrhuNg_53wc3pBVToH-AUwKDbC5P_cb7=8bYfn=BYCJA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: so-q2ANANmuDtfaY4tta0Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/26, Linus Torvalds wrote:
>
> On Tue, Nov 26, 2019 at 3:08 AM Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > Alternatively we could add ->compat_restart into struct restart_block,
> > logically this is the same thing.
>
> That sounds like the better model to me. That's what the restart_block
> is about: it's supposed to contain the restart information.

I knew ;) OK, I won't argue, I'll send V2.

> I'd much rather see the system call number added into the restart
> block (or just the "compat bit" - but we have that X32 case too, so
> why not put it all there).

apart from x86, who else can use it? after the quick grep I think nobody,
even arm64 and mips which have compat nr_restart's do not need it.

restart_block.arch_restart_block_infp makes more sense, but that would be
even more painful, I do not want to add asm/restart_block.h or
HAVE_ARCH_RESTART_INFO, or use CONFIG_IA32_EMULATION.

OK, lets add the new restart_block.nr_restart_syscall field, then we need

=09void set_restart_block_fn(restart, fn)
=09{
=09=09restart->nr_restart_syscall =3D arch_get_nr_restart_syscall()
=09=09restart->fn =3D fn;
=09}

but somehow I do not see a good place for

=09#ifndef arch_get_nr_restart_syscall()
=09#define arch_get_nr_restart_syscall()=090
=09#endif

Can you suggest a simple solution?

Hmm. Or may be HAVE_ARCH_RESTART is better after all? Say, just

=09--- a/include/linux/restart_block.h
=09+++ b/include/linux/restart_block.h
=09@@ -24,6 +24,9 @@ enum timespec_type {
=09  */
=09 struct restart_block {
=09=09long (*fn)(struct restart_block *);
=09+#ifdef=09CONFIG_HAVE_ARCH_RESTART_XXX
=09+=09int=09nr_restart_syscall;
=09+#endif
=09=09union {
=09=09=09/* For futex_wait and futex_wait_requeue_pi */
=09=09=09struct {
=09@@ -55,6 +58,15 @@ struct restart_block {
=09=09};
=09 };
=09=20
=09+static inline void set_restart_block_fn(restart, fn)
=09+{
=09+#ifdef=09CONFIG_HAVE_ARCH_RESTART_XXX
=09+=09extern int arch_get_nr_restart_syscall();
=09+=09restart->nr_restart_syscall =3D arch_get_nr_restart_syscall();
=09+#endif
=09+=09restart->fn =3D fn;
=09+}
=09+
=09 extern long do_no_restart_syscall(struct restart_block *parm);
=09=20
=09 #endif /* __LINUX_RESTART_BLOCK_H */

?

Oleg.

