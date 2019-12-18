Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37751C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 22:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 081442176D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 22:34:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OvOglgIp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbfLRWeV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 17:34:21 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38420 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbfLRWeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 17:34:21 -0500
Received: by mail-ot1-f67.google.com with SMTP id d7so30604otf.5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 14:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q0o+3IFWqjXrZk2VGX8AZpqrFD1hgC3oeYUhyHktLWk=;
        b=OvOglgIpCOvAU0KUmMs8x4iozSWSqM+yDOyefrFtCr2OVCpfsjJ7pnWEnXeEBMD0A7
         dcjpSo5tP1TdSit6XHXofae91ynxxjN33wttHo9/PkuR1cQpHtnXOEt8YZMQDifUZQ2L
         inAlja5nVFJgaMkKbocgiGlM7eskKOyL5cDOlyJEDEaPFrmvYPf6XGLW7jL0jKVa/Lfy
         +xOtBtwKlaja0TfAcQJ0VYwDDhkPQFIDjW/oLwrRSpinQV6s2k4O0GaSwy1uoMBPtmq8
         9NyURifh80gzG9Po7lDjW9xXjm5HU2xWTmRiQdzfPOlKbbD1ThuVVX2hP7JZaTtLGX+x
         vibg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q0o+3IFWqjXrZk2VGX8AZpqrFD1hgC3oeYUhyHktLWk=;
        b=NXNtDQzQAhzR/cLR7aEc/S9HgVTFKZdt/C9r3H1sX833+XykOsTyKrSeXhrC6yg8Vk
         3MqpRBiG+qEykuycwuJJGhDHCbHVkbOG4VAK86hO+4NWgYJSyNltu44pwhjGSodoiZsF
         zazjGXySQRqnM5vwuC7Yafk3i4axWYgSZF/GWwdFWiWUNd6kqGC2NQNRGLYgmNnk7Vai
         LK/sH5zKhOxkbmJVPjaiLIhXOhsDryJKih68hhtHFSnEV+icxqJYrP6AZVxQFRRChXYb
         u98L0S+XsB6MtJ8NXN8eqEylgJQqAawWmELigy+/IwVpiULF4TtVW4DJgdXQ/axsw/iN
         0lEw==
X-Gm-Message-State: APjAAAWCpsdvCsPnuFkFJJCB7Xy1xD4FL/p1aRbH8PzaTBGnXqBFsPOz
        CwNJo3lRSxPuD+rFGJZwLcty20WHpXh1lVsIq6ZJ2nJXqIg=
X-Google-Smtp-Source: APXvYqwMnOJnqiiU5PdDj4bWsPLkyAyK7HjGgPt4cyMj0QNS4/FD/W0Art0KzjBqfz4nroAZ1UYCVscxfEw92u6lZEw=
X-Received: by 2002:a05:6830:2057:: with SMTP id f23mr659352otp.110.1576708460339;
 Wed, 18 Dec 2019 14:34:20 -0800 (PST)
MIME-Version: 1.0
References: <20191209143120.60100-1-jannh@google.com> <20191209143120.60100-4-jannh@google.com>
 <20191211173711.GF14821@zn.tnic>
In-Reply-To: <20191211173711.GF14821@zn.tnic>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 18 Dec 2019 23:33:54 +0100
Message-ID: <CAG48ez1-u8DbxSAu9DXTEEy3-ADquQLWXB6ufV+By7TnuxWOsQ@mail.gmail.com>
Subject: Re: [PATCH v6 4/4] x86/kasan: Print original address on #GP
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 6:37 PM Borislav Petkov <bp@alien8.de> wrote:
> On Mon, Dec 09, 2019 at 03:31:20PM +0100, Jann Horn wrote:
> >  arch/x86/kernel/traps.c     | 12 ++++++++++-
> >  arch/x86/mm/kasan_init_64.c | 21 -------------------
> >  include/linux/kasan.h       |  6 ++++++
> >  mm/kasan/report.c           | 40 +++++++++++++++++++++++++++++++++++++
> >  4 files changed, 57 insertions(+), 22 deletions(-)
>
> I need a KASAN person ACK here, I'd guess.

Right, I got a Reviewed-by from Dmitry for v2, but cleared that when I
made changes to the patch later - I'll ask Dmitry for a fresh ack on
the v7 patch.

[...]
> > -             die(desc, regs, error_code);
> > +             flags = oops_begin();
> > +             sig = SIGSEGV;
> > +             __die_header(desc, regs, error_code);
> > +             if (hint == GP_NON_CANONICAL)
> > +                     kasan_non_canonical_hook(gp_addr);
> > +             if (__die_body(desc, regs, error_code))
> > +                     sig = 0;
> > +             oops_end(flags, regs, sig);
>
> Instead of opencoding it like this, can we add a
>
>         die_addr(desc, regs, error_code, gp_addr);
>
> to arch/x86/kernel/dumpstack.c and call it from here:
>
>         if (hint != GP_NON_CANONICAL)
>                 gp_addr = 0;
>
>         die_addr(desc, regs, error_code, gp_addr);

Okay, so I'll make __die_header() and __die_body() static, introduce
and hook up die_addr() in patch 3/4, and then in patch 4/4 insert the
call to the KASAN hook.

> This way you won't need to pass down to die_addr() the hint too - you
> code into gp_addr whether it was non-canonical or not.
>
> The
>
> +       if (addr < KASAN_SHADOW_OFFSET)
> +               return;
>
> check in kasan_non_canonical_hook() would then catch it when addr == 0.

I'll add an explicit check for nonzero address before calling
kasan_non_canonical_hook() so that the semantics are a bit more
cleanly split.
