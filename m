Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1602CC2D0CD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 17:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECB5320684
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 17:59:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbfLQR7z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 12:59:55 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34165 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbfLQR7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 12:59:55 -0500
Received: by mail-ot1-f68.google.com with SMTP id a15so1702017otf.1;
        Tue, 17 Dec 2019 09:59:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wK7RpCiVdVyaaZCOMN25L+DZY2FpzdO9c3L/eVcc0/k=;
        b=ARk1YcVOE+nRODrHDPY8vE3mpAcPxutQmYQ/mVnhaKVLjyk3cO5LZjqfEpYhAO450X
         PGYbRky920eAyLJPVhAQFat6sAMgv9jxhLGVJA9mSxyuL5mmHK07/QgVWWZpSPJ9FlBj
         e78O4wYJsld7EaMif0Uj0oIUst+bHSozRoi5QgnyVCPcD3VU1LPTqQ0XY1rKktPmzSo/
         ML8Op9KYFcLmJPUaeUHoU2czaoXYWGgN9oyKwrOCbD3jfz5L19sPQjZuAxpZ9n1Ghehb
         k8og97qRlLaT8eFuhhXCfbdbh+C60jcUUgC+ptGzoSzNFvdZW+J6DUoRjzxr9aiNsnSu
         UEng==
X-Gm-Message-State: APjAAAVVg8rBOQd4Lown6WlGp3fnAnDvhInLYgGeBmyfzn/Gh7FPnDoH
        9SPbGEvf/mXc/Rz2uzl17pgpsWiCbLZZk+fBrsryGqJD
X-Google-Smtp-Source: APXvYqy76pypOvmXMlSj6fN8IDUrZ+NRfMvj3jokpd1MPvEWP4uV2AVQ3JHTyazdJmpB9NsQCNbl0iZC0HTuVGr6gt0=
X-Received: by 2002:a05:6830:18e2:: with SMTP id d2mr9264567otf.107.1576605594480;
 Tue, 17 Dec 2019 09:59:54 -0800 (PST)
MIME-Version: 1.0
References: <20191217142150.10392-1-rppt@kernel.org> <20191217142150.10392-3-rppt@kernel.org>
In-Reply-To: <20191217142150.10392-3-rppt@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 17 Dec 2019 18:59:43 +0100
Message-ID: <CAMuHMdXYp7EBK446EsDt_HLDvc96TPP9oPZmsLtFL5VvhSejjw@mail.gmail.com>
Subject: Re: [PATCH 2/2] sh: add support for folded p4d page tables
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Linux-sh list <linux-sh@vger.kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

On Tue, Dec 17, 2019 at 3:23 PM Mike Rapoport <rppt@kernel.org> wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
>
> Implement primitives necessary for the 4th level folding, add walks of p4d
> level where appropriate and remove usage of __ARCH_USE_5LEVEL_HACK.
>
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>

Thanks for your patch!

> --- a/arch/sh/mm/fault.c
> +++ b/arch/sh/mm/fault.c
> @@ -65,7 +66,20 @@ static void show_pte(struct mm_struct *mm, unsigned long addr)
>                         break;
>                 }
>
> -               pud = pud_offset(pgd, addr);
> +               p4d = p4d_offset(pgd, addr);
> +               if (PTRS_PER_P4D != 1)
> +                       printk(", *p4d=%0*Lx", (u32)(sizeof(*p4d) * 2),
> +                              (u64)p4d_val(*p4d));

This (and the prints below) is gonna cause lots of broken output lines.
You should use pr_cont() instead, and probably rebase on top of  my
"[PATCH 7/7] sh: fault: Modernize printing of kernel messages"
(https://lore.kernel.org/lkml/20191203162645.19950-8-geert+renesas@glider.be/).

> +
> +               if (p4d_none(*p4d))
> +                       break;
> +
> +               if (p4d_bad(*p4d)) {
> +                       printk("(bad)");
> +                       break;
> +               }
> +
> +               pud = pud_offset(p4d, addr);
>                 if (PTRS_PER_PUD != 1)
>                         printk(", *pud=%0*Lx", (u32)(sizeof(*pud) * 2),
>                                (u64)pud_val(*pud));

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
