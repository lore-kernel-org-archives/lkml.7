Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 295C2C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 18:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBFB02083E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 18:33:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Dys1RAc3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbfDKSdU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 14:33:20 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:36059 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbfDKSdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 14:33:20 -0400
Received: by mail-vs1-f67.google.com with SMTP id n4so4080966vsm.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 11:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ETxANaq/Qz0wt53H7RU5QOss/NV8wuC5HeoYqujoieY=;
        b=Dys1RAc35JFj8zWrj0l62FRQghB7NP9SOfxts6YK8syiZCLqNpDAUG/vOkkS904C5R
         U4IEA/OVQXpfpZo/c9a3ITJDCl/OCA7Q4ICIdj4Qaen233iTKgQdGdWHKStS/v6R9NGK
         nRCiZpTKqHiHEBQ+hwOEXRcU5+Ad/a9bsS3Ho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ETxANaq/Qz0wt53H7RU5QOss/NV8wuC5HeoYqujoieY=;
        b=fjNoJdV4UZyZtWzT5v5hiTxx5O36RDB35OxrjPi5JdJnAZwJ0pIRMcdFiRLn78nrws
         PcWvtatwb4w24dSvxetqzmS3222Dej7t6kiYcaBpIBfEk+XxCgurxLr4EVPdQB2z8JT6
         eFNGLuDC9C9W1gYTccNagfzGItFZP0TioO4axnN9v7hNoL79yQtYnZpajTY9i8pWQj/t
         N+lncEbavmA01VOB9l0RJd2yviMWnxTjnbSfPcU/CwStL9dcMkvgOh3a04MqAc7UWwzT
         FJ75ibxACbsX8z6BgwHdpDtoWvhmahfP+YsoLKzTb+Pk5J/6nDDp9VrEBj1RRa8mJqSZ
         1hAg==
X-Gm-Message-State: APjAAAU8tAPHnHTopCPPDkAfWFkM7iMsc4l81DdtuXPJPKPclPCgvYT0
        dpFteqkdp2KUA5OhU3ZyA6VbJjy11g4=
X-Google-Smtp-Source: APXvYqyNcOEgMFZj7wctLPDS1caWyarrCtf+9i3Ppor6zN1a2rYNlxvCLkIGnwfV7lymQ5PDTOOS4A==
X-Received: by 2002:a67:dd8d:: with SMTP id i13mr29279392vsk.64.1555007597948;
        Thu, 11 Apr 2019 11:33:17 -0700 (PDT)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com. [209.85.222.54])
        by smtp.gmail.com with ESMTPSA id w184sm23742967vkd.0.2019.04.11.11.33.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 11:33:17 -0700 (PDT)
Received: by mail-ua1-f54.google.com with SMTP id h4so2369149uaj.9
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 11:33:16 -0700 (PDT)
X-Received: by 2002:ab0:4eaa:: with SMTP id l42mr22631556uah.80.1555007596300;
 Thu, 11 Apr 2019 11:33:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190319170911.GB202956@gmail.com> <20190320185719.GB180195@gmail.com>
 <CAGXu5jL-5C1ZGZ1JgaNFqK-z1Pp1N1X8gD3_ysKTCa=omD+_VQ@mail.gmail.com>
 <20190321175122.GA1587@sol.localdomain> <20190410031734.GB7140@sol.localdomain>
 <CAGXu5j+SZ2+Zkc=Vp5CXQUHhiR9f_OOnca684JTRW3T0yXdaNQ@mail.gmail.com>
 <20190410190729.GA120258@gmail.com> <CAGXu5j+Gfvj9G6s_UQTw6hE11gJb1edt3BXzpbDQdc_dpcHgag@mail.gmail.com>
 <20190410231156.GB120258@gmail.com> <CAGXu5jKg+oN7yUY=N69U93afOVHBPgwz6Osf=eMDPfiwbzEqmw@mail.gmail.com>
 <20190411175823.GC225654@gmail.com>
In-Reply-To: <20190411175823.GC225654@gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 11 Apr 2019 11:33:04 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+u3f3qUVkQO+zYLN7BDh3r7w-W3k3aa+qdAP11k7A1dw@mail.gmail.com>
Message-ID: <CAGXu5j+u3f3qUVkQO+zYLN7BDh3r7w-W3k3aa+qdAP11k7A1dw@mail.gmail.com>
Subject: Re: crypto: Kernel memory overwrite attempt detected to spans
 multiple pages
To:     Eric Biggers <ebiggers@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Rik van Riel <riel@surriel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 10:58 AM Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Wed, Apr 10, 2019 at 04:27:28PM -0700, Kees Cook wrote:
> > On Wed, Apr 10, 2019 at 4:12 PM Eric Biggers <ebiggers@kernel.org> wrote:
> > > You've explained *what* it does again, but not *why*.  *Why* do you want
> > > hardened usercopy to detect copies across page boundaries, when there is no
> > > actual buffer overflow?
> >
> > But that *is* how it determines it was a buffer overflow: "if you
> > cross page boundaries (of a non-compound allocation), it *is* a buffer
> > overflow". This assertion, however, is flawed because many contiguous
> > allocations are not marked as being grouped together when it reality
> > they were. It was an attempt to get allocation size information out of
> > the page allocator, similar to how slab can be queries about
> > allocation size. I'm open to improvements here, since it's obviously
> > broken in its current state. :)
> >
> > --
> > Kees Cook
>
> Well, I'm still at a loss as to whether I'm actually supposed to "fix" this by
> adding __GFP_COMP, or whether you're saying the option is broken anyway so I

I would love it if you could fix it, yes.

> shouldn't bother doing anything.  IIUC, even the kernel stack is still not
> marked __GFP_COMP, so copies to/from the stack can trigger this too, despite
> this being reported over 2 years ago
> (http://lkml.iu.edu/hypermail/linux/kernel/1701.2/01450.html)?
> CONFIG_HARDENED_USERCOPY_PAGESPAN is even disabled in syzbot because you already
> said the option is broken and should not be used.

stacks are checked before PAGESPAN, so that particular problem should
no longer be present since commit 7bff3c069973 ("mm/usercopy.c: no
check page span for stack objects").

> I worry that people will enable all the hardened usercopy options "because
> security", then when the pagespan check breaks something they will disable all
> hardened usercopy options, because they don't understand the individual options.
> Providing broken options is actively harmful, IMO.

It's behind EXPERT, default-n, and says:

          When a multi-page allocation is done without __GFP_COMP,
          hardened usercopy will reject attempts to copy it. There are,
          however, several cases of this in the kernel that have not all
          been removed. This config is intended to be used only while
          trying to find such users.

I'd rather leave it since it's still useful.

Perhaps it could be switched to WARN by default and we reenable it in
syzbot to improve its utility there?

diff --git a/mm/usercopy.c b/mm/usercopy.c
index 14faadcedd06..6e7e28fe062b 100644
--- a/mm/usercopy.c
+++ b/mm/usercopy.c
@@ -208,8 +208,13 @@ static inline void check_page_span(const void
*ptr, unsigned long n,
         */
        is_reserved = PageReserved(page);
        is_cma = is_migrate_cma_page(page);
-       if (!is_reserved && !is_cma)
-               usercopy_abort("spans multiple pages", NULL, to_user, 0, n);
+       if (!is_reserved && !is_cma) {
+               usercopy_warn("spans multiple pages without __GFP_COMP",
+                               NULL, to_user,
+                               (unsigned long)ptr & (unsigned long)PAGE_MASK,
+                               n);
+               return;
+       }

        for (ptr += PAGE_SIZE; ptr <= end; ptr += PAGE_SIZE) {
                page = virt_to_head_page(ptr);


-- 
Kees Cook
