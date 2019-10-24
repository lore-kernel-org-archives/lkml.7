Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D214C47E49
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 13:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28CE221929
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 13:05:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pqYYecC9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393498AbfJXNFz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 09:05:55 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38539 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730366AbfJXNFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 09:05:55 -0400
Received: by mail-lj1-f194.google.com with SMTP id q78so9827541lje.5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 06:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3v7HH2EtuoXM2xnYmFQQeluZt2onP/7EoTuMaBySF5U=;
        b=pqYYecC9th9J+VMMUSolsRioNbW/0/V0vjiWIHl+uu0z7rYYHip2twHnjAB8pA/e4+
         NY06bM0/dAlPMsGT91KAjlvpX1B2sYR++kMK39hV5mBasK3u+6yJPcwXOmeKsosabJcY
         F7nlEXJnzLEY4t47EahMVbav3mRqBdpHxmO/Spi1U7knnubGN91YjpvNMrka6/ELrZzn
         VjyCzI6mEmQ7WrDHaXFlppakXY8WS6MM+yhLTSzTQCDwxxSTzfgbABIB2vAze3KsoLlv
         SvEtrjoPO1h0pB40w+Skj2BcKhdpx1QvMOS2UMXw3gt1T6VvPy1KyKALT5KNK43GlIV2
         8HdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3v7HH2EtuoXM2xnYmFQQeluZt2onP/7EoTuMaBySF5U=;
        b=r+8HGcrWWsgb6u/T6Mq7zXYuVqO81eA/BLWNrVTxsvGEm3aWnFaMARH/LEmFKil2B6
         7eyTEYfiR8gG931TMWhZoD7BPeJDfHVVF9x8Bsam+xHPBiYCwRSosBGxXsPZQoLOLsyP
         wAB9JrHpW9xawwxoGGwYaRMqz1Cfp0v02d1x4ck8XUCVsmzvdcO9pRFvh6iKIe05cAxz
         o5H/yUuxR9NDGGUPHyjZTJo3h53Z0XoCHt8f+k/sxLPlJIia2X519PAc/yiwWDkbpUyu
         OQOwP4/LozfY9KlLX1TD7ilogI9ubq4Qm/mXoz4UScfDAvY3we8jB/So/dRpm9K/jgwf
         E/YQ==
X-Gm-Message-State: APjAAAVMzzpKy3EI5UVR8Q3hx85erIPzu1GaMGN3UNYdqF4pHqPHehRu
        rQ/1aaTnO3UUI7gyDSa2+UznfGqN9Qj2v5Wislk=
X-Google-Smtp-Source: APXvYqyCfZieYyM9plUxMjd6WgwJX7NZdXwGL0kJacHdG/yeJ3DtK/SWrNwnJoNrghLsNdJEWI+EiN9bnEo6avAv3i4=
X-Received: by 2002:a2e:6101:: with SMTP id v1mr26121771ljb.122.1571922353123;
 Thu, 24 Oct 2019 06:05:53 -0700 (PDT)
MIME-Version: 1.0
References: <20191018101248.33727-1-steven.price@arm.com> <20191018101248.33727-13-steven.price@arm.com>
In-Reply-To: <20191018101248.33727-13-steven.price@arm.com>
From:   Zong Li <zongbox@gmail.com>
Date:   Thu, 24 Oct 2019 21:05:41 +0800
Message-ID: <CA+ZOyaiE2w686TmWWPT6tzu1MR3Fkm805k2hY1_VMfAnAwQPuQ@mail.gmail.com>
Subject: Re: [PATCH v12 12/22] mm: pagewalk: Allow walking without vma
To:     Steven Price <steven.price@arm.com>
Cc:     linux-mm@kvack.org, Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        James Morse <james.morse@arm.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Price <steven.price@arm.com> =E6=96=BC 2019=E5=B9=B410=E6=9C=8819=E6=
=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8B=E5=8D=884:12=E5=AF=AB=E9=81=93=EF=BC=9A

>
> Since 48684a65b4e3: "mm: pagewalk: fix misbehavior of walk_page_range
> for vma(VM_PFNMAP)", page_table_walk() will report any kernel area as
> a hole, because it lacks a vma.
>
> This means each arch has re-implemented page table walking when needed,
> for example in the per-arch ptdump walker.
>
> Remove the requirement to have a vma except when trying to split huge
> pages.
>
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
>  mm/pagewalk.c | 25 +++++++++++++++++--------
>  1 file changed, 17 insertions(+), 8 deletions(-)
>
> diff --git a/mm/pagewalk.c b/mm/pagewalk.c
> index fc4d98a3a5a0..4139e9163aee 100644
> --- a/mm/pagewalk.c
> +++ b/mm/pagewalk.c
> @@ -38,7 +38,7 @@ static int walk_pmd_range(pud_t *pud, unsigned long add=
r, unsigned long end,
>         do {
>  again:
>                 next =3D pmd_addr_end(addr, end);
> -               if (pmd_none(*pmd) || !walk->vma) {
> +               if (pmd_none(*pmd)) {
>                         if (ops->pte_hole)
>                                 err =3D ops->pte_hole(addr, next, walk);
>                         if (err)
> @@ -61,9 +61,14 @@ static int walk_pmd_range(pud_t *pud, unsigned long ad=
dr, unsigned long end,
>                 if (!ops->pte_entry)
>                         continue;
>
> -               split_huge_pmd(walk->vma, pmd, addr);
> -               if (pmd_trans_unstable(pmd))
> -                       goto again;
> +               if (walk->vma) {
> +                       split_huge_pmd(walk->vma, pmd, addr);
> +                       if (pmd_trans_unstable(pmd))
> +                               goto again;
> +               } else if (pmd_leaf(*pmd)) {
> +                       continue;
> +               }
> +
>                 err =3D walk_pte_range(pmd, addr, next, walk);
>                 if (err)
>                         break;
> @@ -84,7 +89,7 @@ static int walk_pud_range(p4d_t *p4d, unsigned long add=
r, unsigned long end,
>         do {
>   again:
>                 next =3D pud_addr_end(addr, end);
> -               if (pud_none(*pud) || !walk->vma) {
> +               if (pud_none(*pud)) {
>                         if (ops->pte_hole)
>                                 err =3D ops->pte_hole(addr, next, walk);
>                         if (err)
> @@ -98,9 +103,13 @@ static int walk_pud_range(p4d_t *p4d, unsigned long a=
ddr, unsigned long end,
>                                 break;
>                 }
>
> -               split_huge_pud(walk->vma, pud, addr);
> -               if (pud_none(*pud))
> -                       goto again;
> +               if (walk->vma) {
> +                       split_huge_pud(walk->vma, pud, addr);
> +                       if (pud_none(*pud))
> +                               goto again;
> +               } else if (pud_leaf(*pud)) {
> +                       continue;
> +               }
>
>                 if (ops->pmd_entry || ops->pte_entry)
>                         err =3D walk_pmd_range(pud, addr, next, walk);
> --
> 2.20.1
>

It's good to me.

Tested-by: Zong Li <zong.li@sifive.com>
