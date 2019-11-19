Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9360C432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 07:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84D592186D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 07:38:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbfKSHik (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 02:38:40 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45721 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbfKSHij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 02:38:39 -0500
Received: by mail-ot1-f67.google.com with SMTP id r24so17007726otk.12;
        Mon, 18 Nov 2019 23:38:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xkk8ZmmhL1Tvq4SyXNXmWfQK6jIKt9U01DfpeWL7Exg=;
        b=U3qky6gZAJASs8j5fw8I68kepKBzc613R6y8/xtUJEhoSSqwD+m6omFaFI9P7yE9/W
         n0N7mUD3M/JRSaXc67yvO8dqTxAl5xmlMC6Ov/+laeJ6c7vQ2l77ylN4GrhGZdzfIkrO
         TjjLZ9Yy6Uy4VCnB39zbB7G6cNAD17R+lFSgukfVxUg0vO2L31XDYN17ELABRA2jSZBK
         wbbI2tKUy/KVHw96S/Ikv8uKVVi5h6w9DE33XInB58OZ4ZKD30lPic1LxP2kmq7CON3x
         9lpWNAJu36W5/gp6WeHwNZ/NQuCeMxjuUB9IEK7qKPguL5VimoduRq8+Noo3HnAPzzMl
         ECwA==
X-Gm-Message-State: APjAAAWyiZBOEkChyNoqeKsKAe/zvP7WWkZkRYhGiAYV8mruVhmWnlTK
        2ACRXeEwTE7NP2RDFCqMIf2qrmu6Qe2DBC6iz+M=
X-Google-Smtp-Source: APXvYqyyRGl+VnIo7G8JoHpe7CM1DZDcx0jvynVczgsZNDCB7eI/tKx/44kJ+KYHVQUomn+I8tITzps/uhar16e+VaE=
X-Received: by 2002:a9d:5511:: with SMTP id l17mr2644213oth.145.1574149118761;
 Mon, 18 Nov 2019 23:38:38 -0800 (PST)
MIME-Version: 1.0
References: <20d33517-6df0-9104-fc0a-7f621f87192e@infradead.org>
In-Reply-To: <20d33517-6df0-9104-fc0a-7f621f87192e@infradead.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 19 Nov 2019 08:38:27 +0100
Message-ID: <CAMuHMdU0Vx1E9V+h8XYTyAJitPT42NdGvgzLAfG-=1BVZd-rbA@mail.gmail.com>
Subject: Re: [PATCH] arch/sh/: fix NUMA build errors
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

On Tue, Nov 19, 2019 at 1:55 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> Fix SUPERH builds that select SYS_SUPPORTS_NUMA but do not select
> SYS_SUPPORTS_SMP and SMP.
>
> kernel/sched/topology.c is only built for CONFIG_SMP and then the NUMA
> code + data inside topology.c is only built when CONFIG_NUMA is
> set/enabled, so these arch/sh/ configs need to select SMP and
> SYS_SUPPORTS_SMP to build the NUMA support.
>
> Fixes this build error in 3 different SUPERH configs:
>
> mm/page_alloc.o: In function `get_page_from_freelist':
> page_alloc.c:(.text+0x2ca8): undefined reference to `node_reclaim_distance'
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> Cc: linux-sh@vger.kernel.org
> ---
> or maybe these should be fixed in the defconfig files?
>
> or alternatively, does it make any sense to support NUMA without SMP?

I think it does.  From arch/sh/mm/Kconfig config NUMA help:

        Some SH systems have many various memories scattered around
        the address space, each with varying latencies. This enables
        support for these blocks by binding them to nodes and allowing
        memory policies to be used for prioritizing and controlling
        allocation behaviour.

Probably the NUMA-core is too server/x86-centric, by assuming NUMA is
used only on systems with multiple CPUs, each with their own RAM.

AFAIK, none of the SoCs below are SMP:

> --- lnx-54-rc8.orig/arch/sh/Kconfig
> +++ lnx-54-rc8/arch/sh/Kconfig
> @@ -508,6 +508,8 @@ config CPU_SUBTYPE_SH7722
>         select CPU_SHX2
>         select ARCH_SHMOBILE
>         select ARCH_SPARSEMEM_ENABLE
> +       select SYS_SUPPORTS_SMP
> +       select SMP
>         select SYS_SUPPORTS_NUMA
>         select SYS_SUPPORTS_SH_CMT
>         select PINCTRL
> @@ -518,6 +520,8 @@ config CPU_SUBTYPE_SH7366
>         select CPU_SHX2
>         select ARCH_SHMOBILE
>         select ARCH_SPARSEMEM_ENABLE
> +       select SYS_SUPPORTS_SMP
> +       select SMP
>         select SYS_SUPPORTS_NUMA
>         select SYS_SUPPORTS_SH_CMT

BTW, you didn't have the issue with CPU_SHX3 and CPU_SUBTYPE_SH7785?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
