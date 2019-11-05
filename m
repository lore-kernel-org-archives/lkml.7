Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A3DC5DF61
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 14:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFA2F21929
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 14:58:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BezCicS6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389789AbfKEO6f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 09:58:35 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44144 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388842AbfKEO6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 09:58:34 -0500
Received: by mail-ed1-f65.google.com with SMTP id a67so4277382edf.11;
        Tue, 05 Nov 2019 06:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OsGNCpli0aKylNdzfXqGGNk51dXTucSwdxTJSWlZuDo=;
        b=BezCicS6Hxs25abhx2HqWWKnW19usdAdHbmmOP2sbmgjL77FDHp8bVN1/AT3xOfj5+
         udDjWeZ3lJXPL/opmkrCC4myrHN06gDmaHa523NqDfpz5IWjUEzLlxhae2YuPl3gkiB+
         kNwA63wA7d6kdzUFZgXFaIqreDChdIkHhupc7Uc9B5JCVgc213itt0UrYqYTwcLwPH4B
         um7GQlSM1wSTKphTjpiFXqJeX7zoaW07rIO/oTIoIuOKL5MtNTXRZj19NUfYDTFskpxq
         vhNOs547ShZK42QJR3kMK0VllmNCguEZD7l4pdtAWQUZbwx5iwspibI+9d19FoEKKs4F
         Gj3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OsGNCpli0aKylNdzfXqGGNk51dXTucSwdxTJSWlZuDo=;
        b=IPFIrTy+xohUyJDE0dmXs8pJf2njJj601lvj3YHp/S9tgV542VheVfQdNqT5jAoMe2
         OLgCoRdznv4NcRodloT8We6DpkflWcfGVMT1MoURw75THLDoOEWLrxagXX50k0cI4N/F
         kDNjJt8pk26grujIFZB5sZy2aBjIdWRNKnCn3UVH89deoNHU7ZPPseLmL+8Xl2Fx21RW
         SrmK4rr/GTAGhYEkWXwJs8NWjKip2/U/F3xBrQ1criDKFFMLR9WCNCC3UlWmAR2fboiq
         kTe4TozI/9eEZ40ZL+dCan5gsDKj34GIPxKxYQ28RxRLfvo+yV17TlQQc9kep10uM/Jo
         aO7A==
X-Gm-Message-State: APjAAAWyq4JJaE7fixLnO/7GJRdmdJAecj7fUgeN8nBqLU5AyqOVZzUl
        +9b3oAW0muyDoZ4j716yYaCaNPdoOB36hSDF5g8=
X-Google-Smtp-Source: APXvYqy43mMHO0/x0G5HbHOwDOkgrETQbEGRexxUmLoW5TvTDXB/Ovve31RulrcR4/womJ50Dbe66S9RauKfI3+xvyk=
X-Received: by 2002:a17:906:529a:: with SMTP id c26mr5331884ejm.69.1572965911324;
 Tue, 05 Nov 2019 06:58:31 -0800 (PST)
MIME-Version: 1.0
References: <1572938135-31886-1-git-send-email-rppt@kernel.org>
In-Reply-To: <1572938135-31886-1-git-send-email-rppt@kernel.org>
From:   Anatoly Pugachev <matorola@gmail.com>
Date:   Tue, 5 Nov 2019 17:58:20 +0300
Message-ID: <CADxRZqyJewYKn_juVPrxm9KVQjZQngnig-FYf1q3G6wc=oawYQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/13] mm: remove __ARCH_HAS_4LEVEL_HACK
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greentime Hu <green.hu@gmail.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Helge Deller <deller@gmx.de>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Jeff Dike <jdike@addtoit.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Salter <msalter@redhat.com>,
        Matt Turner <mattst88@gmail.com>,
        Michal Simek <monstr@monstr.eu>, Peter Rosin <peda@axentia.se>,
        Richard Weinberger <richard@nod.at>,
        Rolf Eike Beer <eike-kernel@sf-tec.de>,
        Russell King <linux@armlinux.org.uk>,
        Sam Creasey <sammy@sammy.net>,
        Vincent Chen <deanbo422@gmail.com>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        Linux Kernel list <linux-kernel@vger.kernel.org>,
        linux-m68k@lists.linux-m68k.org, linux-parisc@vger.kernel.org,
        linux-um@lists.infradead.org,
        Sparc kernel list <sparclinux@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 5, 2019 at 10:16 AM Mike Rapoport <rppt@kernel.org> wrote:
>
> From: Mike Rapoport <rppt@linux.ibm.com>
>
> Hi,
>
> These patches convert several architectures to use page table folding and
> remove __ARCH_HAS_4LEVEL_HACK along with include/asm-generic/4level-fixup.h.
>
> For the nommu configurations the folding is already implemented by the
> generic code so the only change was to use the appropriate header file.
>
> As for the rest, the changes are mostly about mechanical replacement of
> pgd accessors with pud/pmd ones and the addition of higher levels to page
> table traversals.
>
> With Vineet's patches from "elide extraneous generated code for folded
> p4d/pud/pmd" series [1] there is a small shrink of the kernel size of about
> -0.01% for the defconfig builds.
>
> The set is boot-tested on UML, qemu-{alpha,sparc} and aranym.
>
> v4 changes:
> * m68k: fix sun3x_defconfig build and reorder ifdefs as per Geert's
>   suggestion


Mike,

tested your patch series on a debian sid/unstable sparc64 LDOM running
on a T5-2 sparc server - it boots for me.
