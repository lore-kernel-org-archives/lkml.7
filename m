Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA3F2C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 23:22:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 910B92175B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 23:22:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="V/Bo8PyJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbfDXXW4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 19:22:56 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:46333 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbfDXXWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 19:22:55 -0400
Received: by mail-vs1-f65.google.com with SMTP id e2so11403494vsc.13
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 16:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zpUP4bgoXDXJmY6a6D8aHitekGFCVxaOvwDg7tgV9BE=;
        b=V/Bo8PyJkFQNbcYx4omLQnVBlY3dKuCykR0mypN1aYr+Qfq2+/DtqqZWQQinXnCulE
         VzF322pqv3XB8QT+XWGAd8fpR7iTpRmqqCthhMxr3UZaep766hXqO8vifxf+4ghoqm58
         eYntXoWneHCQkrW2mNFamxMMmYlZwos47Jx2A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zpUP4bgoXDXJmY6a6D8aHitekGFCVxaOvwDg7tgV9BE=;
        b=KT/LbmrqxYXgTQHxBIhFhbzyouzzNlpGQPXXyhe/YbYfiKqO0JHVvVqCFzvhR0wVxC
         zbgjTImC8Ji3R4jnYmZC4BpMgNsx8az9Q9/M1cH9nESmfXdXOLPVZM/IEigtLt+t34Yf
         u2RcPBH4Q/nOWyJE4ETsUyIjQ0raWLRe3dJVOjAmgnSZr+MYJEMtghzZH9H4d9OutVJe
         C+CFOG6OmmcDHIxFQJUqe6dRJ+S3tJX3r1KBM+Rx+OvUEQLLj7Zl1rQRpx4vxzlmDygF
         NWs0LvXgwcMFDflstgEfkjTfWmhgBIKNuBNgFgz7uIb+O4Ab1oWDI+YvPaGppv6ih0VB
         naZg==
X-Gm-Message-State: APjAAAWu7pe34dfsG7Dg/MRI5pTDs0l9KHaYZWqHIhGe8mX+ZsNwSJM4
        +oZoPYK8Tpd5EVsVfiEfCi23sxyroQo=
X-Google-Smtp-Source: APXvYqxlpDbocwIV0YLhjOUAySEaSkKaKWaVBsQIgQScWzTD0J853Gp9HC5ff75b8X9/OuFtrOeIvQ==
X-Received: by 2002:a67:bc01:: with SMTP id t1mr19414311vsn.149.1556148173676;
        Wed, 24 Apr 2019 16:22:53 -0700 (PDT)
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com. [209.85.221.170])
        by smtp.gmail.com with ESMTPSA id m39sm5348068uae.14.2019.04.24.16.22.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 16:22:51 -0700 (PDT)
Received: by mail-vk1-f170.google.com with SMTP id d30so2630483vkl.10
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 16:22:51 -0700 (PDT)
X-Received: by 2002:a1f:a4d:: with SMTP id 74mr18982332vkk.13.1556148170875;
 Wed, 24 Apr 2019 16:22:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190424203408.GA11386@beast> <20190424205117.GA5291@brain-police>
 <CAGXu5jJzzku0xjJAyD3T5SDeeoxVtA51wfHPGPrejjn_tNfJ4w@mail.gmail.com>
In-Reply-To: <CAGXu5jJzzku0xjJAyD3T5SDeeoxVtA51wfHPGPrejjn_tNfJ4w@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 24 Apr 2019 16:22:39 -0700
X-Gmail-Original-Message-ID: <CAGXu5jL5LKDe=yxB4ByZOH-5CaDeJteFPpDtR2AH07wpMunTEQ@mail.gmail.com>
Message-ID: <CAGXu5jL5LKDe=yxB4ByZOH-5CaDeJteFPpDtR2AH07wpMunTEQ@mail.gmail.com>
Subject: Re: [PATCH v2] binfmt_elf: Update READ_IMPLIES_EXEC logic for modern CPUs
To:     Will Deacon <will.deacon@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hector Marco-Gisbert <hecmargi@upv.es>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Jason Gunthorpe <jgg@mellanox.com>, X86 ML <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 1:54 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Wed, Apr 24, 2019 at 1:51 PM Will Deacon <will.deacon@arm.com> wrote:
> > Don't you need to hack fs/compat_binfmt_elf.c to pick this up, or am I
> > missing some trick? Should just be something like below.
> >
> > Will
> >
> > --->8
> >
> > diff --git a/fs/compat_binfmt_elf.c b/fs/compat_binfmt_elf.c
> > index 15f6e96b3bd9..694bc3ee77eb 100644
> > --- a/fs/compat_binfmt_elf.c
> > +++ b/fs/compat_binfmt_elf.c
> > @@ -116,6 +116,11 @@
> >  #define        arch_setup_additional_pages compat_arch_setup_additional_pages
> >  #endif
> >
> > +#ifdef compat_elf_read_implies_exec
> > +#undef elf_read_implies_exec
> > +#define elf_read_implies_exec compat_elf_read_implies_exec
> > +#endif
> > +
> >  /*
> >   * Rename a few of the symbols that binfmt_elf.c will define.
> >   * These are all local so the names don't really matter, but it
>
> Argh. I thought I already saw stuff like this somewhere, but I think I
> must have been looking at some other compat silliness. I'll fix this
> and split up the series...

Andrew, can you please drop this patch from -mm for now? I'll pursue
these changes separately through x86 and arm64 trees.

Thanks!

-- 
Kees Cook
