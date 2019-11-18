Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB5DC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 17:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 528BC21939
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 17:46:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wQrjgRzX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfKRRqi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 12:46:38 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39846 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbfKRRqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 12:46:37 -0500
Received: by mail-pg1-f195.google.com with SMTP id 29so9969693pgm.6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 09:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ki0H6S7cVChNwUc/0rcIcDCU3ILmIaD21XDlOPzBqM4=;
        b=wQrjgRzXlywD442PsIejVX5AFGs8sKDlfQfJ+fk5Hp1hDGUKNcICrY95AgskVL+nR9
         K6OXZbCSQBNHDxnqvTRhA8jTz0L0qJL8V05lBRSyTC49LtWdtrrZ3/k//rYS4CoDh0/G
         qO3tg3Ol05+hyFSbIbQHoCQ5zS93nLICz1aBMxDh3PhKuze1yjKEq4E+XDvRJB98TioI
         nb51eKfdfJoj3aVBdEWu76B9pWtjbJ/hWUXV5cHOmT2Z69tawaC28n88nYwknnMinrER
         36SSR16G+lxXMj0S1wgjYkj6IPffXDb9ry2uby4HMID4QR5mlKNvnwUBC88yT/oKg8Ob
         OKGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ki0H6S7cVChNwUc/0rcIcDCU3ILmIaD21XDlOPzBqM4=;
        b=mudRRVpHg3rMZ/O9sUtfVAjIwsM4b+dFos9/TJ5Xo5ObZWCZt66j2gFVtsFTGTkInT
         5sjlynbFPtHnxCBHK0q+gOSt/Mju+Q24kTNdhCKmOb7uJbJ0WL1QlRnc7CykevBfXuyu
         1Dpu1AO/Bty66+mZK2zNb63LIxJWE6FOBOblhubvU0zzP+IaArpzB4Kxd5jBv6LxBTQW
         3gfRi+aIx0mvjBC4oCxdtFXmXPnbbq4PEHnj2oRV8qXdJ5bMRU7xTiObjKTAaaKX7BpE
         VfXpfeZQviN5kG1naPD8A6q4ojNPlNiwCDddauLri23v8LPN30BEHv9q0zwx8oKibN9i
         O0pw==
X-Gm-Message-State: APjAAAUqnkNfmHF3H1qMYh9IE2DP6JJ+XdyBX18WARrpW6e4NdHeM68w
        JB0oMWnLtlbjoFf3cWcvyXY5fs8hfw5+qVuKKvqw9g==
X-Google-Smtp-Source: APXvYqz229EMlTPCbxTb6aLUBwhnLeFPPHwMhClKoRcwat/R7xpkmEl3vP6rmr9BlLDfEsb2nTGtgeqTelLhDeubP7A=
X-Received: by 2002:a63:d70e:: with SMTP id d14mr578934pgg.10.1574099194932;
 Mon, 18 Nov 2019 09:46:34 -0800 (PST)
MIME-Version: 1.0
References: <CAKwvOdmSo=BWGnaVeejez6K0Tukny2niWXrr52YvOPDYnXbOsg@mail.gmail.com>
 <20191106120629.28423-1-ilie.halip@gmail.com> <20191118143553.GD6363@zn.tnic>
In-Reply-To: <20191118143553.GD6363@zn.tnic>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 18 Nov 2019 09:46:23 -0800
Message-ID: <CAKwvOdmWoHqrUyZ-_ino9z7KRzizpdoY2ZL5ngUzwGy55MuZ4g@mail.gmail.com>
Subject: Re: [PATCH V2] x86/boot: explicitly place .eh_frame after .rodata
To:     Borislav Petkov <bp@alien8.de>
Cc:     Ilie Halip <ilie.halip@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2019 at 6:36 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Wed, Nov 06, 2019 at 02:06:28PM +0200, Ilie Halip wrote:
> > diff --git a/arch/x86/boot/setup.ld b/arch/x86/boot/setup.ld
> > index 0149e41d42c2..30ce52635cd0 100644
> > --- a/arch/x86/boot/setup.ld
> > +++ b/arch/x86/boot/setup.ld
> > @@ -25,6 +25,7 @@ SECTIONS
> >
> >       . = ALIGN(16);
> >       .rodata         : { *(.rodata*) }
> > +     .eh_frame       : { *(.eh_frame) }
>
> The kernel proper linker script does
>
>         /DISCARD/ : {
>                 *(.eh_frame)
>         }
>
> with the .eh_frame section.
>
> Wouldn't that solve your issue too, if you add it to the /DISCARD/
> section in that linker script too?

Yep. Looks like:
- arch/x86/kernel/vmlinux.lds.S
- arch/x86/realmode/rm/realmode.lds.S

discard .eh_frame, while
- arch/x86/entry/vdso/vdso-layout.lds.S
- arch/x86/um/vdso/vdso-layout.lds.S

keep it.  I assume then that just vdso code that get linked into
userspace needs to preserve this.  This suggestion would be a
functional change, which is why we pursued the conservative change
preserving it.
https://github.com/ClangBuiltLinux/linux/issues/760#issuecomment-549192213

Ilie, would you mind sending a v3 with Boris' recommendation?

-- 
Thanks,
~Nick Desaulniers
