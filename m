Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 073CCC43215
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 08:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D302820740
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 08:41:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IC7OCAsa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbfKRIlT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 03:41:19 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:32833 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbfKRIlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 03:41:19 -0500
Received: by mail-qt1-f195.google.com with SMTP id y39so19384772qty.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 00:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ps8MPX8AyfJLLBwWKE68qZjw9L/Pg8PHKG4fAaJeaII=;
        b=IC7OCAsaSGadT4QqG44yfohuo2GzVYmYF7p9vOgTBOvtQh6Mok3EIWsuW015bvLd8I
         KLddOPSLKd89GkJRs5g60SlRqRF/lJe67XhB3/ORMFsCeH4obofc1n4FyBWsVL9ZSD1r
         AqZzQPUAi1MruJRY0i5nJwkRsfQZSr1EKTRUVkW3/qIWm7SXq5DpDDLoGrIz3+INWJOV
         9NPwnXMWD0KvxAgAEF963L6vDLSVPZcFObWwk6HSbBSKNg9DqCJpI+z+/BDByVKrh4IO
         do4qVjGH148Xp03W4o7cGRdiBWrVFSiRFwDC0FijQw/TOcg/pKcZSljQIN4sUN2PGTk2
         3QJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ps8MPX8AyfJLLBwWKE68qZjw9L/Pg8PHKG4fAaJeaII=;
        b=gEtwmZfvXL+nDd665cAcVM+bFpw8Ltn3BHlThJrj5ltPPRNsPO7s3eVTvUJwDKpFII
         PT0pTorwtIXYmFxreA2YBmsgdNhUTsaanj1/NuYdc3s1tgy74lyr+xiLXgk3kFV9tLgm
         l55Uq8OAatFIGyF7rRe0NArIkeBrCkVw0Rb3bULq+bGiU8jLSnvdz/gb6gLEpOgGObPP
         OqL+nXD0tXhvVK/VAGUo3h6hSVYBpQpqfvQj1HD6d9ne9ztBjlCKi6J3XHRloOEiVHbf
         HwjfaHqK0ayUEzLQSoxZiJ4D9SQbi3KT/4M7BslWiXzpgwAnR8Aym7zp2Gw2+WMy04N/
         DvoQ==
X-Gm-Message-State: APjAAAUibEG7ZVR58Oxf9pPBBkjrGKqKoOv0Kg389QeceN0T9z+6B/Jt
        JpAvF27MPfLN2tCLztGklHt4KmTw6c0PoaO+kRfeyg==
X-Google-Smtp-Source: APXvYqycmhGNQj9GQOvGnwZhD3YJ1muGvboeuF314gc0zshNNbwTi8+MtoHNCjuv9yTAij9KqSEGaKI+HHMznMaAvXU=
X-Received: by 2002:aed:24af:: with SMTP id t44mr25451220qtc.57.1574066477833;
 Mon, 18 Nov 2019 00:41:17 -0800 (PST)
MIME-Version: 1.0
References: <20191028024101.26655-1-nickhu@andestech.com> <20191028024101.26655-2-nickhu@andestech.com>
 <alpine.DEB.2.21.9999.1911162055490.21209@viisi.sifive.com>
In-Reply-To: <alpine.DEB.2.21.9999.1911162055490.21209@viisi.sifive.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 18 Nov 2019 09:41:06 +0100
Message-ID: <CACT4Y+Zv8VDQwiCW=8_qKb1Kja+bopBAtgBjhevM3ZpgMpXmUA@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] kasan: No KASAN's memmove check if archs don't
 have it.
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Nick Hu <nickhu@andestech.com>,
        Jonathan Corbet <corbet@lwn.net>, palmer@sifive.com,
        aou@eecs.berkeley.edu, Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        alankao@andestech.com, Anup.Patel@wdc.com, atish.patra@wdc.com,
        kasan-dev <kasan-dev@googlegroups.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-riscv@lists.infradead.org, Linux-MM <linux-mm@kvack.org>,
        green.hu@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 17, 2019 at 5:58 AM Paul Walmsley <paul.walmsley@sifive.com> wrote:
>
> Hello Andrey, Alexander, Dmitry,
>
> On Mon, 28 Oct 2019, Nick Hu wrote:
>
> > If archs don't have memmove then the C implementation from lib/string.c is used,
> > and then it's instrumented by compiler. So there is no need to add KASAN's
> > memmove to manual checks.
> >
> > Signed-off-by: Nick Hu <nickhu@andestech.com>
>
> If you're happy with this revision of this patch, could you please ack it
> so we can merge it as part of the RISC-V KASAN patch set?
>
> Or if you'd prefer to take this patch yourself, please let me know.

Hi Paul,

Acked-by: Dmitry Vyukov <dvyukov@google.com>

We don't have separate tree for kasan. Merging this via RISC-V tree
should be fine.

Thanks

> -
>
> > ---
> >  mm/kasan/common.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> > index 6814d6d6a023..897f9520bab3 100644
> > --- a/mm/kasan/common.c
> > +++ b/mm/kasan/common.c
> > @@ -107,6 +107,7 @@ void *memset(void *addr, int c, size_t len)
> >       return __memset(addr, c, len);
> >  }
> >
> > +#ifdef __HAVE_ARCH_MEMMOVE
> >  #undef memmove
> >  void *memmove(void *dest, const void *src, size_t len)
> >  {
> > @@ -115,6 +116,7 @@ void *memmove(void *dest, const void *src, size_t len)
> >
> >       return __memmove(dest, src, len);
> >  }
> > +#endif
> >
> >  #undef memcpy
> >  void *memcpy(void *dest, const void *src, size_t len)
> > --
> > 2.17.0
> >
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
> >
>
>
> - Paul
