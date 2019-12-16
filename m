Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E955CC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 12:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7B8C206CB
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 12:21:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbfLPMVO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 07:21:14 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:33847 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727542AbfLPMVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 07:21:13 -0500
Received: by mail-oi1-f195.google.com with SMTP id l136so3223340oig.1;
        Mon, 16 Dec 2019 04:21:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PaEE6lhNeiZHy4KX5OI+M2Odz2KC3Vc0bGM8VMqQydA=;
        b=aHyXoGV1+hGxLRV5Mj/TNaeHx0GrB2udC+GEeefeaV9iVVwRrzBnZQ0cgx5AAQ8/pQ
         bqWB+BWXAUjVlPGR0z9BP81O5RDMan8ojENxWos5w3VxCTX+j3AmEiyObaFg7K+4BbbE
         olQGzkRUy/4Lguz6kIW7Iy0PqNDDMoagfnP9akLnmcmr1Wo9ZYdPcXMrEfNdk84igr8N
         wzF0Ckewcm0opJ5/IF+XemvGRp8jsD849jrx4Yo8p1YZLpieta7oOCZ0b8X5n+OWy3xd
         OKEVAe0rpLX9bDvHEbI6mNPETy382ucp22a8+adNqORkR7zifliGXZHSnlsCLfmKedt/
         YkVg==
X-Gm-Message-State: APjAAAUI+YOvGPRxdFpUtxmFtgbd8T+K5cN/XxQoS3bK0N0QSZOEK5Hh
        37FW2U6jI1PU1+eMdhsItN1BloU2jUREqQW4E5w=
X-Google-Smtp-Source: APXvYqy6onpOUTgf6z2jN9osF6V/McSOeQd2O46aAeuU0K1NP+rtNUJUkzvE01f4B5snojrBbPKV7HFpiLzS2uYeA3U=
X-Received: by 2002:aca:36c5:: with SMTP id d188mr9650688oia.54.1576498873004;
 Mon, 16 Dec 2019 04:21:13 -0800 (PST)
MIME-Version: 1.0
References: <20191216103522.32215-1-gonsolo@gmail.com> <20191216103522.32215-2-gonsolo@gmail.com>
In-Reply-To: <20191216103522.32215-2-gonsolo@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 16 Dec 2019 13:21:01 +0100
Message-ID: <CAMuHMdVotJuotVKa3rxgR3ujCedoWM19-HhwhbTC9g6gV_EVNw@mail.gmail.com>
Subject: Re: [PATCH 1/1] Fix undefined reference to 'node_reclaim_distance'.
To:     Gon Solo <gonsolo@gmail.com>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gon,

Thanks for your patch!

On Mon, Dec 16, 2019 at 11:35 AM Gon Solo <gonsolo@gmail.com> wrote:
> According to https://lkml.org/lkml/2019/12/16/101 and
> http://kisskb.ellerman.id.au/kisskb/buildresult/14067948/ building on
> sh4 is broken due to a
>
> page_alloc.c:(.text+0x3148): undefined reference to `node_reclaim_distance'.
>
> This only happens with CONFIG_NUMA=y (variable used with #ifdef
> CONFIG_NUMA at mm/page_alloc.c:3529) and CONFIG_SMP=n (variable defined at
> kernel/sched/topology.c:2291 but the whole file to be built depends on
> CONFIG_SMP in kernel/sched/Makefile:23.
>
> Follow the lead of arch/x86/Kconfig:1547 and depend on SMP.
>
> This assumes that there are no NUMA systems without SMP which is
> reasonable I guess.

Unfortunately that may be an x86-centric assumption: on other platforms,
there do exist systems with multiple memory banks with different access
performance figures.

> Signed-off-by: Gon Solo <gonsolo@gmail.com>
> ---
>  arch/sh/mm/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/sh/mm/Kconfig b/arch/sh/mm/Kconfig
> index 5c8a2ebfc720..cf655d8e8758 100644
> --- a/arch/sh/mm/Kconfig
> +++ b/arch/sh/mm/Kconfig
> @@ -108,7 +108,7 @@ config VSYSCALL
>
>  config NUMA
>         bool "Non Uniform Memory Access (NUMA) Support"
> -       depends on MMU && SYS_SUPPORTS_NUMA
> +       depends on MMU && SMP && SYS_SUPPORTS_NUMA
>         select ARCH_WANT_NUMA_VARIABLE_LOCALITY
>         default n
>         help

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
