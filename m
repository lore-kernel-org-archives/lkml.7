Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0DE6C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 07:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C7562148D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 07:03:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Op71wMrZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729968AbfDXHDn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 03:03:43 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34925 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729705AbfDXHDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 03:03:42 -0400
Received: by mail-ed1-f66.google.com with SMTP id y67so14928161ede.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 00:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nRB+i/1tuEJdKMj9M0VeKTuyHFdrIyU78GY+npYabBc=;
        b=Op71wMrZ6+Av/iy0HU3/Js1ggDY9vXCwhaqR/DppIrFNFQ49dngviU/K4/C//92IZv
         bfgLGrLDpiU7I4LdE6RGbh0ekWMXX5A+WLf0x/4oitJkn3T6CXpPIe6sGNuBmlybvAcb
         6qjWWy0wwtJSWMfuKghrHdjGLIWHSQg1XeARiMdQPP8m9KL4wL3aFctf/JLSdNdlXflR
         DhcdulSVLTsOiNdJC1RJz08rg0/Sm8xSb1xsS7EZwz3Tl5XjYtX4KHJr1/OD4IzUW/y+
         2javbo7G80QRGTLOr3cMUbNEwYJ7BSDndcZGW5gAhIuKyjBi5vcVf5D9p9GkAec1SCwS
         l07w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nRB+i/1tuEJdKMj9M0VeKTuyHFdrIyU78GY+npYabBc=;
        b=AlQY7vYl8tCu/I4gdTd0hCFpqtIFGt7yIUUlWSza/7Ly79GAbE7zojD3He6WYoEWW5
         3tcJhaYGVXXVmn6FtYhSmhUQVjaPYqFRF3xJ4P92SVel7a7W/qqVW75OB9nQ3IltJIAS
         yvmmTVC92yk0diQCx1t5qRTJ6gV+ElDWee+o7ik2fOXANz26vF/hkJY28b6IdZS572Gr
         UMRB1fYI7awqd+VQoP3CVpwxfYocUfHKus07KixkJiq4RS2nP4Shj17A3vIusWn/T++v
         57gyaxUlRXbMNFm+MSNbaveYF0K6+awznpYxJBNxzJEUBQngBRn4FiXAQAnmv62I4bwz
         aSIg==
X-Gm-Message-State: APjAAAXEfhDgn0RiLGDEAf/i2W9fVqz9T+zBRhsVReuE0NGCqj0ES7Ft
        xBQMnUvqshkQ+lBfe6ujSHaF1eurv0+VGhaAC2o=
X-Google-Smtp-Source: APXvYqxJslIfIPxVNkQh2IrVFpa6+eDB3rwZc+UElgpqmcR67cKv/hieGJ1ws+6kWTXn4tQkwpLP/JFYBwr47H7BOUw=
X-Received: by 2002:a17:906:7201:: with SMTP id m1mr12354686ejk.96.1556089421074;
 Wed, 24 Apr 2019 00:03:41 -0700 (PDT)
MIME-Version: 1.0
References: <1554280545-11318-1-git-send-email-yamada.masahiro@socionext.com> <CAK7LNAR6B=O3h3ec6hm-+O=Y+-ZAj97qQoF4kUfw8Z-NU+5NDQ@mail.gmail.com>
In-Reply-To: <CAK7LNAR6B=O3h3ec6hm-+O=Y+-ZAj97qQoF4kUfw8Z-NU+5NDQ@mail.gmail.com>
From:   Greentime Hu <green.hu@gmail.com>
Date:   Wed, 24 Apr 2019 15:03:04 +0800
Message-ID: <CAEbi=3d6DLHDTTbJmkj2LzkMBYEjGL5pi3e8bdLh9z6qakQjvA@mail.gmail.com>
Subject: Re: [PATCH] nds32: add vmlinux.lds and vdso.so to .gitignore
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Vincent Chen <deanbo422@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Masahiro Yamada <yamada.masahiro@socionext.com> =E6=96=BC 2019=E5=B9=B44=E6=
=9C=8818=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=885:38=E5=AF=AB=E9=81=
=93=EF=BC=9A
>
> Hi Greentime,
>
> On Wed, Apr 3, 2019 at 5:39 PM Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
> >
> > These are build artifacts, which should be ignored by git.
> >
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > ---
>
> Ping ?
>
> >
> >  arch/nds32/kernel/.gitignore      | 1 +
> >  arch/nds32/kernel/vdso/.gitignore | 1 +
> >  2 files changed, 2 insertions(+)
> >  create mode 100644 arch/nds32/kernel/.gitignore
> >  create mode 100644 arch/nds32/kernel/vdso/.gitignore
> >
> > diff --git a/arch/nds32/kernel/.gitignore b/arch/nds32/kernel/.gitignor=
e
> > new file mode 100644
> > index 0000000..c5f676c
> > --- /dev/null
> > +++ b/arch/nds32/kernel/.gitignore
> > @@ -0,0 +1 @@
> > +vmlinux.lds
> > diff --git a/arch/nds32/kernel/vdso/.gitignore b/arch/nds32/kernel/vdso=
/.gitignore
> > new file mode 100644
> > index 0000000..f8b69d8
> > --- /dev/null
> > +++ b/arch/nds32/kernel/vdso/.gitignore
> > @@ -0,0 +1 @@
> > +vdso.lds

Hi Yamada,

Thank you.
Acked-by: Greentime Hu <greentime@andestech.com>
