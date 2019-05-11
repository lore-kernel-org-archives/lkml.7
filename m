Return-Path: <SRS0=o7UO=TL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAEA5C04AB1
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 05:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB891216C4
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 05:26:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KnpNi/uc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbfEKFQi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 May 2019 01:16:38 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34848 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfEKFQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 May 2019 01:16:38 -0400
Received: by mail-lf1-f65.google.com with SMTP id j20so5556054lfh.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 22:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RubaYD8lmKjs7mOc/w46zB7MTkNoz0PuGk8avcCv1n8=;
        b=KnpNi/ucLh6IWYYptTfkL/B8kBD2j4ymE2Yi5Zbg9F8XKW89fK0cdBydRylStUBQ6F
         eT0qJceyDrRupFQj6FZWqgAUOg977uKXNdeLKNbfXrBfw2BbAJR3hXX4VcbxcsD/482k
         W5tB8xSluxW3w2q2ZVxYLI/XHcbj2aYKEsP9DPOE6ip/2RWzyKVxLcdTFB0gk6Y4FLT8
         O7mIyG7miRN40jOk5dyuN9quiQP6sPGEeAPs4/h5gHG9B8q/gz1x+vH0438pEkLrSQCr
         iMc/2OeX5AqWTYaAtM+8WxliqQn2Q46xIXIoMUfCVNbp+7CriHhh3x7QWmA4946Bya1d
         rUuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RubaYD8lmKjs7mOc/w46zB7MTkNoz0PuGk8avcCv1n8=;
        b=jxHxC8ZI3f8FQD8MVwEdwi7pY59cZPv3IVHKS4owV3vcL1D3QP09g+YtbAjY26U5Az
         E6b6xx6pYXdF4YKgCLUu8s0UhhR88SiOj48vz6sRgYdZfV7IyOVw0aTY2yAVkVi5SkSx
         PTxGMpmVTgtrOFdjX/j9NiYS9X+f/YqEKDq3JK4AdbyMdK+2Px61RIaX2u4eFbUmI8lp
         sAC0XeRsqHiXn7MiVk1vTOFmPU8a21HTAwkaShcOe5PxyiUU/EHSybRlivuqc4n2kDKk
         A/mygu9FCTVpukN5VDaNArnaFkskqkHvGiTrbGnn5+5qPLeH2ZwMngar7Ba5DtuEYNVP
         CAaw==
X-Gm-Message-State: APjAAAWCgDP/z3XMkNAp+XUB7agkXC62wJTfthq10qnr4TDIX6weTPf1
        zHQF09dgDI/omMM0sE15AXmA6wzzCH72kK+LJd4=
X-Google-Smtp-Source: APXvYqzINuOJuvge+HOzITNLiJ0az8yid3Ry6I90eMiHeFr1Pgol9IDFg9QvWgBzNQC5mPuWXYIYhwXXmRz3yvdxBe0=
X-Received: by 2002:a19:ca0e:: with SMTP id a14mr7824921lfg.3.1557551796422;
 Fri, 10 May 2019 22:16:36 -0700 (PDT)
MIME-Version: 1.0
References: <5cd642e1.1c69fb81.4ee83.327d@mx.google.com>
In-Reply-To: <5cd642e1.1c69fb81.4ee83.327d@mx.google.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Sat, 11 May 2019 10:46:24 +0530
Message-ID: <CAFqt6zZLxvXrT4Oky6F3oWa2g8LWhowUL6tz3H8XeBeDnO0y9w@mail.gmail.com>
Subject: Re: [PATCH] mm: Remove duplicate headers
To:     Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Cc:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        rppt@linux.vnet.ibm.com, Andrew Morton <akpm@linux-foundation.org>,
        rostedt@goodmis.org, changbin.du@gmail.com,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 11, 2019 at 9:04 AM Sabyasachi Gupta
<sabyasachi.linux@gmail.com> wrote:
>
> Remove asm/sections.h and asm/fixmap.h which are included more than once
>
> Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>

Acked-by: Souptick Joarder <jrdr.linux@gmail.com>

> ---
>  arch/arm/mm/mmu.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> index fcded2c..29035f4 100644
> --- a/arch/arm/mm/mmu.c
> +++ b/arch/arm/mm/mmu.c
> @@ -23,7 +23,6 @@
>  #include <asm/sections.h>
>  #include <asm/cachetype.h>
>  #include <asm/fixmap.h>
> -#include <asm/sections.h>
>  #include <asm/setup.h>
>  #include <asm/smp_plat.h>
>  #include <asm/tlb.h>
> @@ -36,7 +35,6 @@
>  #include <asm/mach/arch.h>
>  #include <asm/mach/map.h>
>  #include <asm/mach/pci.h>
> -#include <asm/fixmap.h>
>
>  #include "fault.h"
>  #include "mm.h"
> --
> 2.7.4
>
