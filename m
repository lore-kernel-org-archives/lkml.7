Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 544E0C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 17:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F6CC206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 17:57:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/bvpK8P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730030AbfC2R5l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 13:57:41 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:44867 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729662AbfC2R5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 13:57:41 -0400
Received: by mail-io1-f66.google.com with SMTP id u12so2433127iop.11
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 10:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y1v+uCgxFSWrPHlA8nDgBEvt4sMWQvF4EIO/pVD58yw=;
        b=c/bvpK8P6hBeKfZVURQ2OhxnVe/RQZH6TP4rxNPzie9GwDFKU7MeGPOnIf6M+5AHtR
         JXSpiFr3gL4PH7bHsoFl7jpMXWJgFotW/zwfIHIaVhUftRoTK9HbUDNVNwyW/XgvQJ9R
         4DrYAx6yNQMPMV7pugW/2BKTmNP1s7epgjY04u6uXTcJKS8pWwFU+0qpcXl1AYxH/4aZ
         +c5z3Or3YSNz0uGL/gVyNXBDJ6fmxzdSY5XefsRq+Dr/sqAJtIGLlqQnCD2Cq36HN8sK
         kZCfQn7GG1vSq3gRBIhcZZeWU8aZ8F3QYynjVYhisK3AB6gt5JX7e0/miCvx1kwc/Tob
         NOVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y1v+uCgxFSWrPHlA8nDgBEvt4sMWQvF4EIO/pVD58yw=;
        b=tOR4S8jsUp/N3f7jwaXa1kFH4CYnEtzka2eb12VHmmDcTIXrJbEPD6ZogC4XbaIQoI
         RLTYeH37vw3eQEfxy+svm8l2mt0IeJAzKpp3ydAFAvX08iA0wcHk7y2Nd0yd5TELgntm
         5aLFTetIVxOd7gq72knm3AnLyVHFUiyDi8WwuDbsUPX60/8IubDa7x70sWy8VvkjPbRl
         MkxiXq5LaF+k5mFgYhMRCSR/BzK6hdVaz0Uyui92cOlVvTSs8yIT46t6RynneKbLTLK+
         t+sPfXbNZJHv/lDrqDFIGExFp1PYZlNU3I5tZKSmalVB8ZGW2U73c1JP2AVqkwT8in8d
         6xjQ==
X-Gm-Message-State: APjAAAVnXSMNJsw5EzyzEqx/MiSq64+7Dtiiup0ZKqPX7qB+ReFueVIB
        oBi9mNzthlV/zA4jmTa1lYb8/WC6uZjrty0Ismw=
X-Google-Smtp-Source: APXvYqxA40FZCF59ajzplwJ7CPQ+psoYYD9KHYi/j+ZPyhjzruwp2MTV7PMNhWY78wnM9XDBaeM6K+ER77VW6r56unM=
X-Received: by 2002:a6b:f813:: with SMTP id o19mr15147750ioh.70.1553881949929;
 Fri, 29 Mar 2019 10:52:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190329171221.GA32456@altlinux.org> <20190329131514.3e4ec93e@gandalf.local.home>
In-Reply-To: <20190329131514.3e4ec93e@gandalf.local.home>
From:   David Abdurachmanov <david.abdurachmanov@gmail.com>
Date:   Fri, 29 Mar 2019 18:52:18 +0100
Message-ID: <CAEn-LTpY6Tto1N9irXJeOb4iB=qSYhb=jM0E=Z9ppumbPX6GSw@mail.gmail.com>
Subject: Re: [PATCH] riscv: fix syscall_get_arguments() and syscall_set_arguments()
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     "Dmitry V. Levin" <ldv@altlinux.org>,
        Will Drewry <wad@chromium.org>,
        Kees Cook <keescook@chromium.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@redhat.com>, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2019 at 6:15 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Fri, 29 Mar 2019 20:12:21 +0300
> "Dmitry V. Levin" <ldv@altlinux.org> wrote:
>
> > RISC-V syscall arguments are located in orig_a0,a1..a5 fields
> > of struct pt_regs.
> >
> > Due to an off-by-one bug and a bug in pointer arithmetic
> > syscall_get_arguments() was reading s3..s7 fields instead of a1..a5.
> > Likewise, syscall_set_arguments() was writing s3..s7 fields
> > instead of a1..a5.
>
> Should I add this to my series? And then rebase on top of it?

I have alternative version posted in December part of SECCOMP
patchset which is based on arm64 implementation.

http://lists.infradead.org/pipermail/linux-riscv/2018-December/002450.html

I noticed that SECCOMP wasn't working properly if filters were
checking syscall arguments, because populated arguments were wrong.

Btw, I plan to send v2 of SECCOMP patchset soonish.

david

>
> -- Steve
>
> >
> > Fixes: e2c0cdfba7f69 ("RISC-V: User-facing API")
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Andy Lutomirski <luto@amacapital.net>
> > Cc: Will Drewry <wad@chromium.org>
> > Cc: linux-riscv@lists.infradead.org
> > Cc: stable@vger.kernel.org # v4.15+
> > Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
> > ---
> >  arch/riscv/include/asm/syscall.h | 12 +++++++-----
> >  1 file changed, 7 insertions(+), 5 deletions(-)
> >
> > diff --git a/arch/riscv/include/asm/syscall.h b/arch/riscv/include/asm/syscall.h
> > index bba3da6ef157..6ea9e1804233 100644
> > --- a/arch/riscv/include/asm/syscall.h
> > +++ b/arch/riscv/include/asm/syscall.h
> > @@ -79,10 +79,11 @@ static inline void syscall_get_arguments(struct task_struct *task,
> >       if (i == 0) {
> >               args[0] = regs->orig_a0;
> >               args++;
> > -             i++;
> >               n--;
> > +     } else {
> > +             i--;
> >       }
> > -     memcpy(args, &regs->a1 + i * sizeof(regs->a1), n * sizeof(args[0]));
> > +     memcpy(args, &regs->a1 + i, n * sizeof(args[0]));
> >  }
> >
> >  static inline void syscall_set_arguments(struct task_struct *task,
> > @@ -94,10 +95,11 @@ static inline void syscall_set_arguments(struct task_struct *task,
> >          if (i == 0) {
> >                  regs->orig_a0 = args[0];
> >                  args++;
> > -                i++;
> >                  n--;
> > -        }
> > -     memcpy(&regs->a1 + i * sizeof(regs->a1), args, n * sizeof(regs->a0));
> > +     } else {
> > +             i--;
> > +     }
> > +     memcpy(&regs->a1 + i, args, n * sizeof(regs->a1));
> >  }
> >
> >  static inline int syscall_get_arch(void)
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
