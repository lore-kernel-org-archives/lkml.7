Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74311C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 20:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B062218A3
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 20:58:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730875AbfC3U6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 16:58:00 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:33751 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730571AbfC3U57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 16:57:59 -0400
Received: by mail-vs1-f66.google.com with SMTP id a190so3330349vsd.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2019 13:57:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sU5k31hDXmDtm8fePAfmAKLlgTYsFoWtHgD7PbFIOBI=;
        b=uGbchdtRN8V1Rlfpw6QfxHvmq19hnzsaK6LhI3vCBZo9DMLIN8CYTt2Lr33ub3mFay
         KeZelrlTlVDCy51pAdc/uDU0gj4/Ep5sXNQtDPxjZBKJqh/xO8dkCjJj578qMQHLzF5D
         PZkxiTJ05PUUly/GNIQq2J7DnmibTscdqpYYhfpeV923SJ4+LwrTSCpcajDiIE0AttHn
         wy46C4/Gj84ss7zgBRQLYRc242AufofZ//byaW3vsmlH4qA2+HAgG7e9RtP8MPlbBiEU
         Z5f0NsBzafWKqRlCAXu3soVIFz/6NTqIFaE/9DRnTvsNHLdGmnsWC6+Msy1CAsDMkXTE
         8OZw==
X-Gm-Message-State: APjAAAUTUfGJZ2bf1Nlbk0i9Yeruzw6rA3+izws11PYXYE6VzHyPi0MR
        //nxWmh9wLJWGnRf0sp+lGIWY17sci7KlaBN6sg=
X-Google-Smtp-Source: APXvYqw9iUzeya+dzxFWxgcj8aZqF1Opxx4/WXa9vypGw6baCS/aOgPbwOROTRDlApv8A6LEjrB8NeiSLExlAZJhZJk=
X-Received: by 2002:a67:8546:: with SMTP id h67mr15290063vsd.11.1553979477943;
 Sat, 30 Mar 2019 13:57:57 -0700 (PDT)
MIME-Version: 1.0
References: <20181210042352.GA6092@altlinux.org> <20181210043010.GM6131@altlinux.org>
 <CAMuHMdVYq_2P=gb_zbSGFkPWASTds6uSPTyyhyNAgp2Qm5+feQ@mail.gmail.com>
 <20181210124059.GA11942@altlinux.org> <CAMuHMdW8ejp4gm2Xh-8inSQngQ5zRQ9bfsg1SG+BAD8RFV8xcA@mail.gmail.com>
 <20181210133025.GG11942@altlinux.org> <20181212085516.GA13288@altlinux.org> <20190329220425.GA3563@altlinux.org>
In-Reply-To: <20190329220425.GA3563@altlinux.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sat, 30 Mar 2019 21:57:46 +0100
Message-ID: <CAMuHMdWBvEXbxAZtE4nMDRKeaHoiNYbPVkd-bawNMrTb-PTPjw@mail.gmail.com>
Subject: Re: [PATCH v5 13/25] m68k: add asm/syscall.h
To:     "Dmitry V. Levin" <ldv@altlinux.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, Andy Lutomirski <luto@kernel.org>,
        Elvira Khabirova <lineprinter@altlinux.org>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CC Steven

On Fri, Mar 29, 2019 at 11:04 PM Dmitry V. Levin <ldv@altlinux.org> wrote:
> On Wed, Dec 12, 2018 at 11:55:16AM +0300, Dmitry V. Levin wrote:
> > On Mon, Dec 10, 2018 at 04:30:25PM +0300, Dmitry V. Levin wrote:
> > > On Mon, Dec 10, 2018 at 02:06:28PM +0100, Geert Uytterhoeven wrote:
> > > > On Mon, Dec 10, 2018 at 1:41 PM Dmitry V. Levin <ldv@altlinux.org> wrote:
> > > > > On Mon, Dec 10, 2018 at 09:45:42AM +0100, Geert Uytterhoeven wrote:
> > > > > > On Mon, Dec 10, 2018 at 5:30 AM Dmitry V. Levin <ldv@altlinux.org> wrote:
> > > > > > > syscall_get_* functions are required to be implemented on all
> > > > > > > architectures in order to extend the generic ptrace API with
> > > > > > > PTRACE_GET_SYSCALL_INFO request.
> > > > > > >
> > > > > > > This introduces asm/syscall.h on m68k implementing all 5 syscall_get_*
> > > > > > > functions as documented in asm-generic/syscall.h: syscall_get_nr,
> > > > > > > syscall_get_arguments, syscall_get_error, syscall_get_return_value,
> > > > > > > and syscall_get_arch.
> > > > > > >
> > > > > > > Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> > > > > > > Cc: Oleg Nesterov <oleg@redhat.com>
> > > > > > > Cc: Andy Lutomirski <luto@kernel.org>
> > > > > > > Cc: Elvira Khabirova <lineprinter@altlinux.org>
> > > > > > > Cc: Eugene Syromyatnikov <esyr@redhat.com>
> > > > > > > Cc: linux-m68k@lists.linux-m68k.org
> > > > > > > Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
> > > > > > > ---
> > > > > > >
> > > > > > > Notes:
> > > > > > >     v5: added syscall_get_nr, syscall_get_arguments, syscall_get_error,
> > > > > > >         and syscall_get_return_value
> > > > > > >     v1: added syscall_get_arch
> > > > > >
> > > > > > > --- /dev/null
> > > > > > > +++ b/arch/m68k/include/asm/syscall.h
> > > > > > > @@ -0,0 +1,39 @@
> > > > > >
> > > > > > > +static inline void
> > > > > > > +syscall_get_arguments(struct task_struct *task, struct pt_regs *regs,
> > > > > > > +                     unsigned int i, unsigned int n, unsigned long *args)
> > > > > > > +{
> > > > > > > +       BUG_ON(i + n > 6);
> > > > > >
> > > > > > Does this have to crash the kernel?
> > > > >
> > > > > This is what most of other architectures do, but we could choose
> > > > > a softer approach, e.g. use WARN_ON_ONCE instead.
> > > > >
> > > > > > Perhaps you can return an error code instead?
> > > > >
> > > > > That would be problematic given the signature of this function
> > > > > and the nature of the potential bug which would most likely be a usage error.
> > > >
> > > > Of course to handle that, the function's signature need to be changed.
> > > > Changing it has the advantage that the error handling can be done at the
> > > > caller, in common code, instead of duplicating it for all
> > > > architectures, possibly
> > > > leading to different semantics.
> > >
> > > Given that *all* current users of syscall_get_arguments specify i == 0
> > > (and there is an architecture that has BUG_ON(i)),
> > > it should be really a usage error to get into situation where i + n > 6,
> > > I wish a BUILD_BUG_ON could be used here instead.
> > >
> > > I don't think it worths pushing the change of API just to convert
> > > a "cannot happen" assertion into an error that would have to be dealt with
> > > on the caller side.
> >
> > I suggest the following BUG_ON replacement for syscall_get_arguments:
> >
> > #define SYSCALL_MAX_ARGS 6
> >
> > static inline void
> > syscall_get_arguments(struct task_struct *task, struct pt_regs *regs,
> >                     unsigned int i, unsigned int n, unsigned long *args)
> > {
> >       /*
> >        * Ideally there should have been
> >        * BUILD_BUG_ON(i + n > SYSCALL_MAX_ARGS);
> >        * instead of these checks.
> >        */
> >       if (unlikely(i > SYSCALL_MAX_ARGS)) {
> >               WARN_ONCE(1, "i > SYSCALL_MAX_ARGS");
> >               return;
> >       }
> >       if (unlikely(n > SYSCALL_MAX_ARGS - i)) {
> >               WARN_ONCE(1, "i + n > SYSCALL_MAX_ARGS");
> >               n = SYSCALL_MAX_ARGS - i;
> >       }
> >       BUILD_BUG_ON(sizeof(regs->d1) != sizeof(args[0]));
> >       memcpy(args, &regs->d1 + i, n * sizeof(args[0]));
> > }
>
> There seems to be a more straightforward approach to this issue.
>
> Assuming there is a general consensus [1] to get rid of "i" and "n"
> arguments of syscall_get_arguments(), the implementation could be
> simplified to
>
> static inline void
> syscall_get_arguments(struct task_struct *task, struct pt_regs *regs,
>                       unsigned long *args)
> {
>         memcpy(args, &regs->d1, 6 * sizeof(args[0]));
> }
>
> [1] https://lore.kernel.org/lkml/20190328230512.486297455@goodmis.org/

Yeah, no longer a need for all these ugly checks, good.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
