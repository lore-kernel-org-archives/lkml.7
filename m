Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1DD8C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 20:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9F9620823
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 20:37:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732735AbfCZUh0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 16:37:26 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42761 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbfCZUhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 16:37:25 -0400
Received: by mail-lj1-f194.google.com with SMTP id v22so12363883lje.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 13:37:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JhLyn48nA6q2U7w5eOLrSrVD+Xv83Es5B1I3uCqZReg=;
        b=dL2xPAJ2YBi4NBJZZbjtE+PycOXk/xW/XYikVeOncmmPEBt16SkjoVbqSXF+q+ULTX
         tDKC0Rho/6voKPiXyZGJ8NPsjWFd+TaWaddsQ4hWC2HOy33HWUXaJYuqcwoazGmYP/F/
         DziY0BC7fbB4abXG5ljxKlPGTmAvDoR2gGUpKVqiePhqZ4ztiGGlToe+OjMjPnElxEpl
         cYomNDjuGrAY/rrmskuXZeFf21X5W/TtrhFrqhH3dBmGxkeQVyJIdXcJ0IBCtaPq2zUB
         cgcQIed/KfgEuXcpfBLz7iUvvoRC83DcvdiLzN/yDbWq8bY2ZA5CtNqNqr/g5HEQuxKr
         GX0A==
X-Gm-Message-State: APjAAAWZtOkknS9wWn8/vS81ofANyLMgn/mtuVK0d25GB7cDJuw9vjLA
        QXnnvpOllW/HgUa8auJEZXXrJ0fXnGS1NG+xtj3QZw==
X-Google-Smtp-Source: APXvYqzT7pf03UVcmOmi/OlhaeKSyuuLcMMawyVz1zxhdWDgUkp3UoOLjWVFSY1qjpSfTe/TZTfE92xkIIkYqzt0mgA=
X-Received: by 2002:a2e:9a0f:: with SMTP id o15mr1768397lji.130.1553632644200;
 Tue, 26 Mar 2019 13:37:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190324190504.29906-1-mcroce@redhat.com> <20190326161457.GN1867@zn.tnic>
In-Reply-To: <20190326161457.GN1867@zn.tnic>
From:   Matteo Croce <mcroce@redhat.com>
Date:   Tue, 26 Mar 2019 21:36:48 +0100
Message-ID: <CAGnkfhwtXdjaHFChFBMNiSnh+cpDRi=e20J0EZ039xWuRTcouQ@mail.gmail.com>
Subject: Re: [PATCH v2] x86/realmode: don't leak kernel addresses
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 5:15 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Sun, Mar 24, 2019 at 08:05:04PM +0100, Matteo Croce wrote:
> > Since commit ad67b74d2469d9b8 ("printk: hash addresses printed with %p"),
> > at boot "____ptrval____" is printed instead of the trampoline addresses:
> >
> >     Base memory trampoline at [(____ptrval____)] 99000 size 24576
> >
> > Remove the address from the print as we don't want to leak kernel
> > addresses.
> >
> > Fixes: ad67b74d2469d9b8 ("printk: hash addresses printed with %p")
> > Signed-off-by: Matteo Croce <mcroce@redhat.com>
> > ---
> >  arch/x86/realmode/init.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/x86/realmode/init.c b/arch/x86/realmode/init.c
> > index d10105825d57..d76a1380ec37 100644
> > --- a/arch/x86/realmode/init.c
> > +++ b/arch/x86/realmode/init.c
> > @@ -20,8 +20,8 @@ void __init set_real_mode_mem(phys_addr_t mem, size_t size)
> >       void *base = __va(mem);
> >
> >       real_mode_header = (struct real_mode_header *) base;
> > -     printk(KERN_DEBUG "Base memory trampoline at [%p] %llx size %zu\n",
> > -            base, (unsigned long long)mem, size);
> > +     printk(KERN_DEBUG "Base memory trampoline at %llx size %zu\n",
> > +            (unsigned long long)mem, size);
>
> In case this wasn't clear, please remove the whole printk. And don't
> forget to CC lkml on your submissions. CCed now.
>
> --
> Regards/Gruss,
>     Boris.
>
> Good mailing practices for 400: avoid top-posting and trim the reply.

Got it, sent a v3 with the printk removed.
Anyway, I wonder if we can remove the 'size' argument and/or moving
set_real_mode_mem() into realmode.h to have it inlined.
Or maybe it's not worth it.

Regards,
-- 
Matteo Croce
per aspera ad upstream
