Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B90FEC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 05:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8742E217F9
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 05:28:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hNSJWi7d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387932AbfDRF2J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 01:28:09 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:37663 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfDRF2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 01:28:08 -0400
Received: by mail-ua1-f68.google.com with SMTP id l17so384258uar.4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 22:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ohjMtnRuoMZoK8NFCIw9UXTAaT8mCgqZCZ9c725i5mE=;
        b=hNSJWi7dfZS6icOBYs4kZRM3P2+rnM98qjGabtZHa2binvsfr93Ocxkw+IwxUASlD/
         pQX01+gyN8BW8yJYMgeqgS/eAzOZQEpQCg6E3xJ+hbrCPgvJPgJJi4wI0J+FiIbsUSP6
         0k+cQm02mdD+oM5hLDG6hhfyjMKa1vlN3OhUw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ohjMtnRuoMZoK8NFCIw9UXTAaT8mCgqZCZ9c725i5mE=;
        b=slPtIjPUyAqgAl40PVBBRJ3a8Va9kNU3+Nj0Je5aEI6chxdlVZOwuM59tNioGlVWgy
         hQpOEoojkguVZ+mGgiDJS3+/Tk/GsVEBGg3u3xsBm/giGhC7FH9jeA/EVFWa0G2+kOpd
         Rx8mVy8ntZLoZizKgaHnyVI5ffERf4Nl8sgdZyjUm8ohNxfeKRc58lFUnmiBsGO+HvJJ
         LhTli0KhXbLH5KQvoEIK/+ikVMhwVs5zCS2rpv3LiQYSrjB3v7HMEhxBWsTeqFqzCXPn
         nfm3sO/dnVTIyuHeRclbPdilDF6AHqom80B03GmI8nJhloCdIhGc0nFF16Srby4sNMKs
         r8Fw==
X-Gm-Message-State: APjAAAU5Vto9XIKkLryzTfAAGjn3EsKcF+mG8pNiE0y8KDFYJL/40SbH
        knAJMe6UXbmIeEJ1JtRKLCACyAELJZE=
X-Google-Smtp-Source: APXvYqw9tmb/CGMGWk+71LHd848nPVJM5EoHI/xtkV6cXR7L0g01OezWW1hEH2KDDAVUJ9PA1jjwng==
X-Received: by 2002:ab0:2b98:: with SMTP id q24mr12438761uar.122.1555565287601;
        Wed, 17 Apr 2019 22:28:07 -0700 (PDT)
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com. [209.85.221.176])
        by smtp.gmail.com with ESMTPSA id b5sm199541vsd.18.2019.04.17.22.28.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 22:28:05 -0700 (PDT)
Received: by mail-vk1-f176.google.com with SMTP id q189so205482vkq.11
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 22:28:05 -0700 (PDT)
X-Received: by 2002:a1f:2e07:: with SMTP id u7mr49260276vku.44.1555565284857;
 Wed, 17 Apr 2019 22:28:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190417052247.17809-1-alex@ghiti.fr> <20190417052247.17809-7-alex@ghiti.fr>
In-Reply-To: <20190417052247.17809-7-alex@ghiti.fr>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 18 Apr 2019 00:27:53 -0500
X-Gmail-Original-Message-ID: <CAGXu5jLFtaiRqvd_Lw2B688bzUyti2O8o_iZVmQhb7rmnEKzBQ@mail.gmail.com>
Message-ID: <CAGXu5jLFtaiRqvd_Lw2B688bzUyti2O8o_iZVmQhb7rmnEKzBQ@mail.gmail.com>
Subject: Re: [PATCH v3 06/11] arm: Use STACK_TOP when computing mmap base address
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

On Wed, Apr 17, 2019 at 12:29 AM Alexandre Ghiti <alex@ghiti.fr> wrote:
>
> mmap base address must be computed wrt stack top address, using TASK_SIZE
> is wrong since STACK_TOP and TASK_SIZE are not equivalent.
>
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> ---
>  arch/arm/mm/mmap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mm/mmap.c b/arch/arm/mm/mmap.c
> index bff3d00bda5b..0b94b674aa91 100644
> --- a/arch/arm/mm/mmap.c
> +++ b/arch/arm/mm/mmap.c
> @@ -19,7 +19,7 @@
>
>  /* gap between mmap and stack */
>  #define MIN_GAP                (128*1024*1024UL)
> -#define MAX_GAP                ((TASK_SIZE)/6*5)
> +#define MAX_GAP                ((STACK_TOP)/6*5)

Parens around STACK_TOP aren't needed, but you'll be removing it
entirely, so I can't complain. ;)

>  #define STACK_RND_MASK (0x7ff >> (PAGE_SHIFT - 12))
>
>  static int mmap_is_legacy(struct rlimit *rlim_stack)
> @@ -51,7 +51,7 @@ static unsigned long mmap_base(unsigned long rnd, struct rlimit *rlim_stack)
>         else if (gap > MAX_GAP)
>                 gap = MAX_GAP;
>
> -       return PAGE_ALIGN(TASK_SIZE - gap - rnd);
> +       return PAGE_ALIGN(STACK_TOP - gap - rnd);
>  }
>
>  /*
> --
> 2.20.1
>

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
