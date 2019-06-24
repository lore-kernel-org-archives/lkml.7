Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7AC7C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 20:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9676920645
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 20:14:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L+LVVsng"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729585AbfFXUOF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 16:14:05 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33948 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727829AbfFXUOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 16:14:04 -0400
Received: by mail-pf1-f195.google.com with SMTP id c85so8152590pfc.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 13:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gA5g+3BvXIn/jRUNtYVuPBrGxTYGWqRjXHzrOj0QNto=;
        b=L+LVVsngjla9IhiIu1qCjMLss6ub8VVfgUke6Gzkiw5NVrLAvU/gWqkuuHKGDOwMDW
         iKWKiU1MlGwfjkeOFjN1NalBd7eBHsPeYrhg5k+FVzwWHaMVG3/Nr3MLS/ULe22cYYIm
         IL/e1u438sX5K1I7IV95CS2mNWZ5Jx3DECYlJXfFyGyMMV7qeRLRg0T9Ta/abjre95vY
         Al3azFfxrVdCoEM1E08zKV/Gdac9CyZMPq5/qme19eVRYysbxXDDQQnyvWQkH8ELAZhd
         Vfkqazo5h0Y49tV+CODXvwa9eM4sGzGuCTYsu5+dqoaSCIWM0oEts3l4CQxlE8eRtodq
         c5Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gA5g+3BvXIn/jRUNtYVuPBrGxTYGWqRjXHzrOj0QNto=;
        b=cdkv+QQIcDm9GhbKbAh9ENenFO7I3ntjThRkN423HTWvwSy7jDp1jDvES1c29LKdW6
         s/W23u6hotPDEVcgqfKoEWN65YAel/iKxN63OJTCJLrSqxzKCg0mF4AUInFLcj9Z5BEu
         xI912vQagWRzdis6CFytEyiDy0J9O342jDHxli+GH2+izRW0c/pKKPK02YCdqqlhzhym
         1Y+9FSGaV7mq0NiMQeWnoeE82Rj8tJST92XLlk3jPYX0fnt9GptCT3cBCBuW0Z4uwBfG
         1VHZSUQe4eHHjlv6aF9yt1t3EJpTA+iD0Pbg2XTOcYFqQ+FLiEYvL4jH+1wGKLwu/FCR
         Kh+A==
X-Gm-Message-State: APjAAAUhQJSsFnS9vh/7T1E6u376ab4TbvPLnMMuklA2MOUi1UxAE42x
        VIITB2kkySWWOntDAA0QvkOaY4fEhGN58O2Fuh56LKCKhbaqlQ==
X-Google-Smtp-Source: APXvYqwbHSEWWrxjTaNlQU9gt/t2po73l8ewfc3CeWUC+uGjt8eAkQ/DPm2hhyPcDvaU4F0z6E4FQeppylXUxiE/nP4=
X-Received: by 2002:a63:52:: with SMTP id 79mr34338767pga.381.1561407243756;
 Mon, 24 Jun 2019 13:14:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190618020307.50917-1-natechancellor@gmail.com>
In-Reply-To: <20190618020307.50917-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 24 Jun 2019 13:13:52 -0700
Message-ID: <CAKwvOd=U7GOuZm82_-pOAVaU1FejuGASETyxVw00xnnj2rPoHA@mail.gmail.com>
Subject: Re: [PATCH] ARM: iop13xx: Simplify iop13xx_atu{e,x}_pci_status checks
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 7:03 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> clang warns:
>
> arch/arm/mach-iop13xx/pci.c:292:7: warning: logical not is only applied
> to the left hand side of this comparison [-Wlogical-not-parentheses]
>                 if (!iop13xx_atux_pci_status(1) == 0)
>                     ^                           ~~
> arch/arm/mach-iop13xx/pci.c:439:7: warning: logical not is only applied
> to the left hand side of this comparison [-Wlogical-not-parentheses]
>                 if (!iop13xx_atue_pci_status(1) == 0)
>                     ^                           ~~
>
> !func() == 0 is equivalent to func(), which clears up this warning and
> makes the code more readable.

Yep, this is more concise, thanks for the patch.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
please submit this to:
https://www.armlinux.org.uk/developer/patches/add.php

>
> Link: https://github.com/ClangBuiltLinux/linux/issues/543
> Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  arch/arm/mach-iop13xx/pci.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-iop13xx/pci.c b/arch/arm/mach-iop13xx/pci.c
> index 46ea06e906cc..94d30bc7bba1 100644
> --- a/arch/arm/mach-iop13xx/pci.c
> +++ b/arch/arm/mach-iop13xx/pci.c
> @@ -289,7 +289,7 @@ iop13xx_atux_write_config(struct pci_bus *bus, unsigned int devfn, int where,
>
>         if (size != 4) {
>                 val = iop13xx_atux_read(addr);
> -               if (!iop13xx_atux_pci_status(1) == 0)
> +               if (iop13xx_atux_pci_status(1))
>                         return PCIBIOS_SUCCESSFUL;
>
>                 where = (where & 3) * 8;
> @@ -436,7 +436,7 @@ iop13xx_atue_write_config(struct pci_bus *bus, unsigned int devfn, int where,
>
>         if (size != 4) {
>                 val = iop13xx_atue_read(addr);
> -               if (!iop13xx_atue_pci_status(1) == 0)
> +               if (iop13xx_atue_pci_status(1))
>                         return PCIBIOS_SUCCESSFUL;
>
>                 where = (where & 3) * 8;
> --
> 2.22.0
>


-- 
Thanks,
~Nick Desaulniers
