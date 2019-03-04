Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80CC5C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 13:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F7A32075B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 13:05:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbfCDNFO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 08:05:14 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:46842 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbfCDNFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 08:05:14 -0500
Received: by mail-ua1-f66.google.com with SMTP id j8so4274688uae.13
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 05:05:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+aLkZtp2ES76W2zKnAi6MoOYaAXF6mSyHhQuA8Hq0go=;
        b=q0mjvMT3q87uBAeW/bE4FQRlJFDjQuYUFFdPpz7lc82XYjlCkfwJgFugTzaLRo/lRc
         ytfZV6ap1vXE7gMscy5SrNKPh6xvHVO4Mjh8m7QCrXuLMJljcemV45mIrEEttgRAi/h4
         76rtoHBuT7X6YIVARmd1gbgjAJW5f1eY9SOhvFAsi0yhlgg3ww4w0R9d4H+cocOnLBSw
         vm9yLTNTp78GozpI7XKIRi/VhnZZMY0Sfo/bhMFotQD8jeTCn+d3E1/oyYR5ywSBjQ3L
         cjNdMHRLJIGoI5DqczoWTwVdwYBH35FsZANQga+wE8JwzCQpg07NhZOultEnyvghXdr0
         36jw==
X-Gm-Message-State: APjAAAWfk/9aeKKkQhXyccEYJ1CSUr+N5BVCEnL+I09p9Ka/fDPpd6IN
        IKshJlLsMlk0MEaxoQOJ85eyc7jgvv0C7ug0ibI=
X-Google-Smtp-Source: APXvYqxgUaRbBOYDo1gmA7zB7PFJvuIwV7SGvCn8dkjq/1lnZULOS9sCInSiQsLG0Hvdn0uGnSvhOoRAEtkln1Y5CKw=
X-Received: by 2002:a9f:30dc:: with SMTP id k28mr9864264uab.75.1551704712686;
 Mon, 04 Mar 2019 05:05:12 -0800 (PST)
MIME-Version: 1.0
References: <201903042049.npxcZzps%fengguang.wu@intel.com>
In-Reply-To: <201903042049.npxcZzps%fengguang.wu@intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 4 Mar 2019 14:05:01 +0100
Message-ID: <CAMuHMdX365qmWiii=gQLADpW49EMkdDrVJDPWNBpAZuZM0WQFQ@mail.gmail.com>
Subject: Re: [m68k:master 1174/1174] arch/m68k/include/asm/string.h:72:25:
 warning: '__builtin_memcpy' forming offset 8 is out of the bounds [0, 7]
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Finn Thain <fthain@telegraphics.com.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 4, 2019 at 1:44 PM kbuild test robot <lkp@intel.com> wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git master
> head:   e223cadc191661c67cb419b3a53c7854ecc39e8b
> commit: e223cadc191661c67cb419b3a53c7854ecc39e8b [1174/1174] Merge tag 'v5.0'
> config: m68k-allmodconfig (attached as .config)
> compiler: m68k-linux-gnu-gcc (Debian 8.2.0-11) 8.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout e223cadc191661c67cb419b3a53c7854ecc39e8b
>         # save the attached .config to linux build tree
>         GCC_VERSION=8.2.0 make.cross ARCH=m68k
>
> All warnings (new ones prefixed by >>):
>
>    In file included from include/linux/string.h:20,
>                     from include/linux/bitmap.h:9,
>                     from include/linux/nodemask.h:95,
>                     from include/linux/mmzone.h:17,
>                     from include/linux/gfp.h:6,
>                     from include/linux/umh.h:4,
>                     from include/linux/kmod.h:22,
>                     from include/linux/module.h:13,
>                     from drivers/nvme/target/admin-cmd.c:15:
>    In function 'memcpy_and_pad',
>        inlined from 'nvmet_execute_identify_ctrl' at drivers/nvme/target/admin-cmd.c:309:2:
> >> arch/m68k/include/asm/string.h:72:25: warning: '__builtin_memcpy' forming offset 8 is out of the bounds [0, 7] [-Warray-bounds]
>     #define memcpy(d, s, n) __builtin_memcpy(d, s, n)
>                             ^~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/string.h:456:3: note: in expansion of macro 'memcpy'
>       memcpy(dest, src, dest_len);
>       ^~~~~~
>
> vim +/__builtin_memcpy +72 arch/m68k/include/asm/string.h
>
> ea61bc46 Greg Ungerer 2010-09-07  69
> ea61bc46 Greg Ungerer 2010-09-07  70  #define __HAVE_ARCH_MEMCPY
> ea61bc46 Greg Ungerer 2010-09-07  71  extern void *memcpy(void *, const void *, __kernel_size_t);
> ea61bc46 Greg Ungerer 2010-09-07 @72  #define memcpy(d, s, n) __builtin_memcpy(d, s, n)
> ea61bc46 Greg Ungerer 2010-09-07  73
>
> :::::: The code at line 72 was first introduced by commit
> :::::: ea61bc461d09e8d331a307916530aaae808c72a2 m68k/m68knommu: merge MMU and non-MMU string.h
>
> :::::: TO: Greg Ungerer <gerg@snapgear.com>
> :::::: CC: Geert Uytterhoeven <geert@linux-m68k.org>

Yep, that's a funny one, which I saw myself this morning, and decided
to dive into.
Apparently this is due 1) the recently added -ffreestanding and
2) the kernel version being shorter than 8 characters (indeed, it
didn't happen with allmodconfig on v5.0.0-rcX).

The offending code is:

        memcpy_and_pad(id->fr, sizeof(id->fr),
                       UTS_RELEASE, strlen(UTS_RELEASE), ' ');

with UTS_RELEASE being "5.0.0+", which calls into:

    static inline void memcpy_and_pad(void *dest, size_t dest_len,
                                      const void *src, size_t count, int pad)
    {
            if (dest_len > count) {

Of course this branch is taken, right?

                    memcpy(dest, src, count);
                    memset(dest + count, pad,  dest_len - count);
            } else
                    memcpy(dest, src, dest_len);
    }

This assembles to:

    .LC1:
            .string     "5.0.0+"

    | drivers/nvme/target/admin-cmd.c:311:      memcpy_and_pad(id->fr,
sizeof(id->fr),
            pea .LC1            |
            jsr strlen          |

Woops, gcc no longer optimizes this away, due to -ffreestanding.

    | drivers/nvme/target/admin-cmd.c:311:      memcpy_and_pad(id->fr,
sizeof(id->fr),
            lea (64,%a3),%a1    |, ret, _7
    | include/linux/string.h:452:       if (dest_len > count) {
            lea (16,%sp),%sp    |,
            moveq #7,%d1        |,
            cmp.l %d0,%d1       | _6,
            jcs .L53            |

And we end up with retaining both branches:

    | include/linux/string.h:453:               memcpy(dest, src, count);
            move.l %d0,-(%sp)   | _6,
            pea .LC1            |
            move.l %a1,-(%sp)   | _7,
            move.l %d0,-12(%fp) |,
            move.l %a1,-16(%fp) |,
            jsr memcpy          |
    | include/linux/string.h:454:               memset(dest + count,
pad,  dest_len - count);
            move.l -12(%fp),%d0 |,
            moveq #8,%d1        |,
            sub.l %d0,%d1       | _6,
            move.l %d1,-(%sp)   |,
            pea 32.w            |
            move.l -16(%fp),%a1 |,
            pea (%a1,%d0.l)             |
            jsr memset          |
            lea (24,%sp),%sp    |,
            jra .L54            |
    .L53:
    | include/linux/string.h:456:               memcpy(dest, src, dest_len);
            move.l .LC1,(%a1)   | MEM[(void *)"5.0.0+"], MEM[(void *)_7]
            move.l .LC1+4,4(%a1)        | MEM[(void *)"5.0.0+"], MEM[(void *)_7]

But given the warning, the compiler must have devised that taking the
second branch would read beyond the source buffer???

    .L54:


Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
