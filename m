Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF2D9C10F0B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 05:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A01E21479
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 05:40:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eKENM7Vl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731661AbfDRFkL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 01:40:11 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:34314 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbfDRFkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 01:40:11 -0400
Received: by mail-ua1-f67.google.com with SMTP id c6so399142uan.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 22:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I49wvlYq7D5JlBzIeYIfPLcNWvP+zL3hNSqD7FZ7LkY=;
        b=eKENM7VlYogZiu9LKw1HvlthciY0efM2NRwfvhdnWH5UYz7IY9RnPN4yev4Q+SyM9W
         YdiBLhyiVJeHQ9+caxTPQbD0pWn+V0WnnHXoprAgGsJToXR/dAfi6b1L2J3wzGcPrtzu
         FLBCSBvonUpQIBIMq//yfXcrvRxsfl6ta/QN4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I49wvlYq7D5JlBzIeYIfPLcNWvP+zL3hNSqD7FZ7LkY=;
        b=scfbU2mnMvaH3U51qQNemYay9hdzbtdaWi6MHeoUqMMzQxFhcAomqCB+pta2yyp959
         17gWJXHdBOhskjIIjpvCJHDL5mGLYOgHFnuCT9BJeGUccLim///nWOlDlhUHOAmWJjqL
         XlmSSNY0KthL33GJanPqSTppDTxg7K754idAEEFAUmZUPACMEMSqb5cmKg3+Nw9sQT5T
         VbWnUKCXq1DJ9EprCmDC+w7TT22O7DaVWkQh9DtwALMO3SpeosViboB+DSsioERsSmKc
         dnNgVquB2aT8RzEVg5UjBLva5rLcj/rmoxZiXsB58r87dvgSnUeM1S7d10iJiUJAKyMi
         eGWg==
X-Gm-Message-State: APjAAAWLMmeoPb6cqHtShz/UTpLbuVfHZjtVUrBmQHMP14sASq63+spO
        bgG1v1AssoLu9MCkpY+RL3uj1cTZuoE=
X-Google-Smtp-Source: APXvYqycKZcnmGMEjQNosu8ykOd4Bm9iqvajqVJd//k6G+LTwGhIdI3hqLNxrXx+tVfBGF1SzOykYw==
X-Received: by 2002:ab0:702a:: with SMTP id u10mr9791455ual.5.1555566009368;
        Wed, 17 Apr 2019 22:40:09 -0700 (PDT)
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com. [209.85.221.181])
        by smtp.gmail.com with ESMTPSA id p135sm306074vkd.8.2019.04.17.22.40.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 22:40:09 -0700 (PDT)
Received: by mail-vk1-f181.google.com with SMTP id x2so206860vkx.13
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 22:40:08 -0700 (PDT)
X-Received: by 2002:a1f:3c83:: with SMTP id j125mr2514890vka.92.1555565530282;
 Wed, 17 Apr 2019 22:32:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190417052247.17809-1-alex@ghiti.fr> <20190417052247.17809-12-alex@ghiti.fr>
In-Reply-To: <20190417052247.17809-12-alex@ghiti.fr>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 18 Apr 2019 00:31:58 -0500
X-Gmail-Original-Message-ID: <CAGXu5jJcQzDQGy907H0WXu-q1sPQaXgjuFbHHW60ajUuksZb3A@mail.gmail.com>
Message-ID: <CAGXu5jJcQzDQGy907H0WXu-q1sPQaXgjuFbHHW60ajUuksZb3A@mail.gmail.com>
Subject: Re: [PATCH v3 11/11] riscv: Make mmap allocation top-down by default
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 12:34 AM Alexandre Ghiti <alex@ghiti.fr> wrote:
>
> In order to avoid wasting user address space by using bottom-up mmap
> allocation scheme, prefer top-down scheme when possible.
>
> Before:
> root@qemuriscv64:~# cat /proc/self/maps
> 00010000-00016000 r-xp 00000000 fe:00 6389       /bin/cat.coreutils
> 00016000-00017000 r--p 00005000 fe:00 6389       /bin/cat.coreutils
> 00017000-00018000 rw-p 00006000 fe:00 6389       /bin/cat.coreutils
> 00018000-00039000 rw-p 00000000 00:00 0          [heap]
> 1555556000-155556d000 r-xp 00000000 fe:00 7193   /lib/ld-2.28.so
> 155556d000-155556e000 r--p 00016000 fe:00 7193   /lib/ld-2.28.so
> 155556e000-155556f000 rw-p 00017000 fe:00 7193   /lib/ld-2.28.so
> 155556f000-1555570000 rw-p 00000000 00:00 0
> 1555570000-1555572000 r-xp 00000000 00:00 0      [vdso]
> 1555574000-1555576000 rw-p 00000000 00:00 0
> 1555576000-1555674000 r-xp 00000000 fe:00 7187   /lib/libc-2.28.so
> 1555674000-1555678000 r--p 000fd000 fe:00 7187   /lib/libc-2.28.so
> 1555678000-155567a000 rw-p 00101000 fe:00 7187   /lib/libc-2.28.so
> 155567a000-15556a0000 rw-p 00000000 00:00 0
> 3fffb90000-3fffbb1000 rw-p 00000000 00:00 0      [stack]
>
> After:
> root@qemuriscv64:~# cat /proc/self/maps
> 00010000-00016000 r-xp 00000000 fe:00 6389       /bin/cat.coreutils
> 00016000-00017000 r--p 00005000 fe:00 6389       /bin/cat.coreutils
> 00017000-00018000 rw-p 00006000 fe:00 6389       /bin/cat.coreutils
> 00018000-00039000 rw-p 00000000 00:00 0          [heap]
> 3ff7eb6000-3ff7ed8000 rw-p 00000000 00:00 0
> 3ff7ed8000-3ff7fd6000 r-xp 00000000 fe:00 7187   /lib/libc-2.28.so
> 3ff7fd6000-3ff7fda000 r--p 000fd000 fe:00 7187   /lib/libc-2.28.so
> 3ff7fda000-3ff7fdc000 rw-p 00101000 fe:00 7187   /lib/libc-2.28.so
> 3ff7fdc000-3ff7fe2000 rw-p 00000000 00:00 0
> 3ff7fe4000-3ff7fe6000 r-xp 00000000 00:00 0      [vdso]
> 3ff7fe6000-3ff7ffd000 r-xp 00000000 fe:00 7193   /lib/ld-2.28.so
> 3ff7ffd000-3ff7ffe000 r--p 00016000 fe:00 7193   /lib/ld-2.28.so
> 3ff7ffe000-3ff7fff000 rw-p 00017000 fe:00 7193   /lib/ld-2.28.so
> 3ff7fff000-3ff8000000 rw-p 00000000 00:00 0
> 3fff888000-3fff8a9000 rw-p 00000000 00:00 0      [stack]
>
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  arch/riscv/Kconfig | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index eb56c82d8aa1..f5897e0dbc1c 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -49,6 +49,17 @@ config RISCV
>         select GENERIC_IRQ_MULTI_HANDLER
>         select ARCH_HAS_PTE_SPECIAL
>         select HAVE_EBPF_JIT if 64BIT
> +       select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT if MMU
> +       select HAVE_ARCH_MMAP_RND_BITS
> +
> +config ARCH_MMAP_RND_BITS_MIN
> +       default 18
> +
> +# max bits determined by the following formula:
> +#  VA_BITS - PAGE_SHIFT - 3
> +config ARCH_MMAP_RND_BITS_MAX
> +       default 33 if 64BIT # SV48 based
> +       default 18
>
>  config MMU
>         def_bool y
> --
> 2.20.1
>


-- 
Kees Cook
