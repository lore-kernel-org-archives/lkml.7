Return-Path: <SRS0=lz0T=XK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FDB8C2BA1D
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 22:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68A3A20692
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 22:21:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tnPBDrO9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbfIOWV6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Sep 2019 18:21:58 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45879 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfIOWV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Sep 2019 18:21:58 -0400
Received: by mail-qk1-f193.google.com with SMTP id z67so34232711qkb.12
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2019 15:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AfjoPCOD52jjFgBq/i5FYuS0UjsI4UNOYM48ZVeX3bE=;
        b=tnPBDrO9qOYjSRmifs/kFutlE6E1HUrxpCCIivLA7x8+Zw4O1bf6X85jC7M7aumm5F
         N/L93c6/ZdO7Q1Qejnli6ibosiEaiAWwAsIeMVQbIP9uXou+LLBQ1Jl+nPf8SGR6JEPb
         6AV7ySCf4N4HPU4FJzhLrs0ktYrGknOxPkRaJjLTC5K/lALC58JiAo+cW/f9sx9o7zmu
         3rqGYI/62mDMUQ/kGN/wbpVPCra1e5cazfePzj/+AR7iP38W+UxErkwNf6hsL/rycTh3
         pZpMd5b4FsuzaXnpo3OgDgi4sqaO5HTttg7UQn6gRa2jyLVYIdcSP4J07d9UeP2nTeFF
         r0Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AfjoPCOD52jjFgBq/i5FYuS0UjsI4UNOYM48ZVeX3bE=;
        b=hC5GOOZubt4cBfO+ptxVrYmi2R7kYmDWptot+uWefwa0UWhDr9v14n0s4kneFvpdEn
         JWkX+qbIjeScBrimJyQVl5V51c0RRguGrc5uMOL/4uTH7nJqLGTUcMKsWskhG04Z0ItM
         4QxQ0Eqdosfyv1U6Y4AMalb1y8pbzdM/uxe5EUh5CUM6V35qjs5OypB+o5IJVbjuaenE
         q3MYaDlqMJZxrNbj9jorIL7MCNfDbVgrFp9R1pBWV2fG6UEWPPbz0vs42QPc0Lz2KtNX
         FEHSPMjZacwMiqQvkPZq+bIhQix5Xqt/Ts/9WbJVfMu/uQY1ogN+V9/o8AWhyLS/UTNM
         pHdg==
X-Gm-Message-State: APjAAAVOymE5ePENB5Czw8QPGjWvVL84tfqkHAoYXKko5OtwgIrw2wje
        GOdVqGkt+FnyjO6h+JCGhXzhya+utR1H/hNRLbi+ZwPKFu0=
X-Google-Smtp-Source: APXvYqzBYKegH8vmzwFoL27HDmfSnlzgRRw4WatjG7yk6CecWiFjmVQdYKvh3yDtbOQWSwIZ1kLaObi4NxNEOHnahXY=
X-Received: by 2002:a37:b07:: with SMTP id 7mr56662105qkl.386.1568586115474;
 Sun, 15 Sep 2019 15:21:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190911141552.rtpdazx3ekfgsh3v@raspberrypi>
In-Reply-To: <20190911141552.rtpdazx3ekfgsh3v@raspberrypi>
From:   Austin Kim <austindh.kim@gmail.com>
Date:   Mon, 16 Sep 2019 07:21:45 +0900
Message-ID: <CADLLry5B07+Bqh5iys4tHi9OKsGGonmus0xZ4SzfK_ktceS9AQ@mail.gmail.com>
Subject: Re: [RESEND PATCH] ARM: module: Drop 'rel->r_offset < 0' statement
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        allison@lohutok.net, info@metux.net,
        matthias.schiffer@ew.tq-group.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Maintainer(Russell King)...
Would you please update the feedback for this patch?

2019=EB=85=84 9=EC=9B=94 11=EC=9D=BC (=EC=88=98) =EC=98=A4=ED=9B=84 11:16, =
Austin Kim <austindh.kim@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> Since rel->r_offset is declared as Elf32_Addr,
> this value is always non-negative.
> typedef struct elf32_rel {
>   Elf32_Addr    r_offset;
>   Elf32_Word  r_info;
> } Elf32_Rel;
>
> typedef __u32   Elf32_Addr;
> typedef unsigned int __u32;
>
> Drop 'rel->r_offset < 0' statement which is always false.
> Also change %u to %d in pr_err() for rel->r_offset.
>
> Signed-off-by: Austin Kim <austindh.kim@gmail.com>
> ---
>  arch/arm/kernel/module.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/kernel/module.c b/arch/arm/kernel/module.c
> index deef17f34..f805bcbda 100644
> --- a/arch/arm/kernel/module.c
> +++ b/arch/arm/kernel/module.c
> @@ -92,8 +92,8 @@ apply_relocate(Elf32_Shdr *sechdrs, const char *strtab,=
 unsigned int symindex,
>                 sym =3D ((Elf32_Sym *)symsec->sh_addr) + offset;
>                 symname =3D strtab + sym->st_name;
>
> -               if (rel->r_offset < 0 || rel->r_offset > dstsec->sh_size =
- sizeof(u32)) {
> -                       pr_err("%s: section %u reloc %u sym '%s': out of =
bounds relocation, offset %d size %u\n",
> +               if (rel->r_offset > dstsec->sh_size - sizeof(u32)) {
> +                       pr_err("%s: section %u reloc %u sym '%s': out of =
bounds relocation, offset %u size %u\n",
>                                module->name, relindex, i, symname,
>                                rel->r_offset, dstsec->sh_size);
>                         return -ENOEXEC;
> --
> 2.11.0
>
