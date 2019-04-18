Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09ACFC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 05:31:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEEE9217F9
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 05:31:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EzI3iDp3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387488AbfDRFbW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 01:31:22 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:33806 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731806AbfDRFbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 01:31:21 -0400
Received: by mail-vs1-f65.google.com with SMTP id t78so526004vsc.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 22:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x/TP6sA5sajZCj+xhLCrRc8XOgk3i0sdPUEQY20nxic=;
        b=EzI3iDp3/PwAWlzrGsEJt8pSHXmaq0t/LgPtPVDCMvm+jD1PtYJaid1ZV/xGYcmd5I
         lwY7VI0ze2TcOE31b8X8Debj5ZrSlCq5cQ8C17/vua658wrm2sWXYl5IeWCxo5rmKiWr
         /FetUT2kibkKsifqxGloTOoB5vk3HAZhnG57A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x/TP6sA5sajZCj+xhLCrRc8XOgk3i0sdPUEQY20nxic=;
        b=F484ZxW2hxNmQKEvB/rKGR+XCD4MEsvk3LrBq3tKGBeS2YAVpuQMiVPz64Pa6/FLR0
         IUDv9Tl1JfQOBZoBDQcIuxncVkDmCUJga/Z2EBfihCY9nm3GuNm8QQsL/FwD0b3GdbmH
         CZ0iff2IfTU223Uy+MT6/E6qiokjuetA6hEFRYu99re0ar8yqZGg/6pcfupfMn/MJ6+c
         nznA3KQq3R268WnrjQCd0qRF/7DFKQ9EDzER2z93sseWb30C4gA4qGzIf+qZAjJ54uuQ
         nGA0mP1qsrH5nvUYEt34voKI+6iivU1vf/VLRSNJr8XhqXcKTYdCHXTuv1N+T8P2d3tw
         F2Ag==
X-Gm-Message-State: APjAAAV6ETyhIvANzYrqXnSEbCind1wmgIQnPm0/vc6PsdLCNNRXuWyR
        o/wcpf56MkR+pvDJPCYFNG8oZfgFbFY=
X-Google-Smtp-Source: APXvYqw7g0cZ5mlXG565hVHgjLtAjNQv/6g8ULHpkvVBauV6Et6VAF/wYSIqdvCaFEe8UfOj11FG7w==
X-Received: by 2002:a05:6102:25a:: with SMTP id a26mr47581713vsq.187.1555565479884;
        Wed, 17 Apr 2019 22:31:19 -0700 (PDT)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com. [209.85.217.48])
        by smtp.gmail.com with ESMTPSA id q190sm445043vkd.50.2019.04.17.22.31.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 22:31:19 -0700 (PDT)
Received: by mail-vs1-f48.google.com with SMTP id j184so495001vsd.11
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 22:31:18 -0700 (PDT)
X-Received: by 2002:a67:bc13:: with SMTP id t19mr2611825vsn.222.1555565478030;
 Wed, 17 Apr 2019 22:31:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190417052247.17809-1-alex@ghiti.fr> <20190417052247.17809-10-alex@ghiti.fr>
In-Reply-To: <20190417052247.17809-10-alex@ghiti.fr>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 18 Apr 2019 00:31:06 -0500
X-Gmail-Original-Message-ID: <CAGXu5jKx_A8GsFWWABKwEXmL5dTMKjk3Ub9GoE7Do9NcZ_ai=A@mail.gmail.com>
Message-ID: <CAGXu5jKx_A8GsFWWABKwEXmL5dTMKjk3Ub9GoE7Do9NcZ_ai=A@mail.gmail.com>
Subject: Re: [PATCH v3 09/11] mips: Use STACK_TOP when computing mmap base address
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

On Wed, Apr 17, 2019 at 12:32 AM Alexandre Ghiti <alex@ghiti.fr> wrote:
>
> mmap base address must be computed wrt stack top address, using TASK_SIZE
> is wrong since STACK_TOP and TASK_SIZE are not equivalent.
>
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  arch/mips/mm/mmap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/mips/mm/mmap.c b/arch/mips/mm/mmap.c
> index 3ff82c6f7e24..ffbe69f3a7d9 100644
> --- a/arch/mips/mm/mmap.c
> +++ b/arch/mips/mm/mmap.c
> @@ -22,7 +22,7 @@ EXPORT_SYMBOL(shm_align_mask);
>
>  /* gap between mmap and stack */
>  #define MIN_GAP                (128*1024*1024UL)
> -#define MAX_GAP                ((TASK_SIZE)/6*5)
> +#define MAX_GAP                ((STACK_TOP)/6*5)
>  #define STACK_RND_MASK (0x7ff >> (PAGE_SHIFT - 12))
>
>  static int mmap_is_legacy(struct rlimit *rlim_stack)
> @@ -54,7 +54,7 @@ static unsigned long mmap_base(unsigned long rnd, struct rlimit *rlim_stack)
>         else if (gap > MAX_GAP)
>                 gap = MAX_GAP;
>
> -       return PAGE_ALIGN(TASK_SIZE - gap - rnd);
> +       return PAGE_ALIGN(STACK_TOP - gap - rnd);
>  }
>
>  #define COLOUR_ALIGN(addr, pgoff)                              \
> --
> 2.20.1
>


-- 
Kees Cook
