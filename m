Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E7E7C43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 21:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0591420707
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 21:53:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ozemrwwu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbfLFVxm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 16:53:42 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:33586 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbfLFVxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 16:53:42 -0500
Received: by mail-pj1-f67.google.com with SMTP id r67so3308423pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 13:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wgbrrDuo9KT2VuS+Gs4279E2o1vOVAlLL3nSGtqW8DY=;
        b=Ozemrwwuyi08WKYdrqeDvEUA0VKXcycEnLhArtNrKi1EITBZFJugSj0QMq9TkIIjbB
         8/r4S3ORJlJJekvljVN8bvEEeVt/sJa9vWtJr/0Q/Bajz2cyrokgHDxTbYTt9VedSnfz
         Mero7BlriFQOArhsO+Eyh09G6K3nFhgzUB2z6qr7r4+Ldd5NyfPtj84FWbzg+ph4jPZW
         GxtKzITAG3P02VMa/XJfSaqlY7EELeScerGNF0vlGwoDtENoMicOTFp/krmVNTzLamqW
         EMGs2bDxq+Pyg9PvvFI9e4utvBX5YPZbiWLGeGGbmUAlT1U0H3+uxLsxeW0HKMBoX/Bu
         cOwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wgbrrDuo9KT2VuS+Gs4279E2o1vOVAlLL3nSGtqW8DY=;
        b=GRPfWatWaojz3cY10AwvDrWQm0I18VOt0F+EJhP4JOQArdxqu4eQH/BwJmIJDCiwbM
         YRhrp4bDj3Aa450sHEJ0lta8JMxpgBXG8oMgz2CZ0JG/2uN3pqWTZveTbB98zwLOUxRN
         U6FNrwjS/ZztwjUVcnVYMb+HdNnk/16QsC3TcCtidhc7Ay3MVXsSSMcl4MbBlPf6aowC
         fmXsNMsza/ZvG7Abtnk25FZSPj05ie2MY7ObdH7WI/BnvrQxgJ4f0qQSNo9XdgDKFXAs
         YbyfTGmLV/RWMXnKqsXXw9aySXGoVqM85fVONH5Z0p9qnxw8ndO6Oss2PWoYQFSu23Ua
         QqlQ==
X-Gm-Message-State: APjAAAWzOevfMQOzhMdEWVo6CSEomKvguZ2V3H/hGtsb6fhuLqYNw93G
        oIaDgsj9XHPL8PehCRfZ2I0b2RhPPW48hYEIyGSpSA==
X-Google-Smtp-Source: APXvYqwHFE7B9l/bOUjiqqTbPMDvQ0ZQ1K7xQIoh6caWQGriwpU1VZK5VYOZS2efO2Fqw0Y+u6sOzBaNEG7/iX00kqI=
X-Received: by 2002:a17:90b:8cf:: with SMTP id ds15mr18285159pjb.134.1575669221285;
 Fri, 06 Dec 2019 13:53:41 -0800 (PST)
MIME-Version: 1.0
References: <20191118175223.GM6363@zn.tnic> <20191126144545.19354-1-ilie.halip@gmail.com>
 <CAKwvOdn0x4jc0=25O+Xy5BsUisAPrz_hjzmBbMS0ubpfPMLgrg@mail.gmail.com>
In-Reply-To: <CAKwvOdn0x4jc0=25O+Xy5BsUisAPrz_hjzmBbMS0ubpfPMLgrg@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 6 Dec 2019 13:53:30 -0800
Message-ID: <CAKwvOd=1B4Fqqwfu58mObS37N5Ocg4Hm35BwzOvbKVX4c10uKQ@mail.gmail.com>
Subject: Re: [PATCH v3] x86/boot: discard .eh_frame sections
To:     Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, Andy <luto@kernel.org>,
        Ilie Halip <ilie.halip@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bumping for review (I couldn't find if this was merged already in tip/tip)

On Tue, Nov 26, 2019 at 9:16 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Tue, Nov 26, 2019 at 6:46 AM Ilie Halip <ilie.halip@gmail.com> wrote:
> >
> > When using GCC as compiler and LLVM's lld as linker, linking
> > setup.elf fails:
> >       LD      arch/x86/boot/setup.elf
> >     ld.lld: error: init sections too big!
> >
> > This happens because GCC generates .eh_frame sections for most
> > of the files in that directory, then ld.lld places the merged
> > section before __end_init, triggering an assert in the linker
> > script.
> >
> > Fix this by discarding the .eh_frame sections, as suggested by
> > Boris. The kernel proper linker script discards them too.
> >
> > Signed-off-by: Ilie Halip <ilie.halip@gmail.com>
> > Link: https://lore.kernel.org/lkml/20191118175223.GM6363@zn.tnic/
> > Link: https://github.com/ClangBuiltLinux/linux/issues/760
> > Suggested-by: Borislav Petkov <bp@alien8.de>
>
> Ilie, thanks for following up with a v3.
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
>
> > ---
> >
> > Changes in V3:
> >  * discard .eh_frame instead of placing it after .rodata
> >
> > Changes in V2:
> >  * removed wildcard for input sections (.eh_frame* -> .eh_frame)
> >
> >  arch/x86/boot/setup.ld | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/boot/setup.ld b/arch/x86/boot/setup.ld
> > index 0149e41d42c2..3da1c37c6dd5 100644
> > --- a/arch/x86/boot/setup.ld
> > +++ b/arch/x86/boot/setup.ld
> > @@ -51,7 +51,10 @@ SECTIONS
> >         . = ALIGN(16);
> >         _end = .;
> >
> > -       /DISCARD/ : { *(.note*) }
> > +       /DISCARD/       : {
> > +               *(.eh_frame)
> > +               *(.note*)
> > +       }
> >
> >         /*
> >          * The ASSERT() sink to . is intentional, for binutils 2.14 compatibility:
> > --
> > 2.17.1
> >
>
>
> --
> Thanks,
> ~Nick Desaulniers



-- 
Thanks,
~Nick Desaulniers
