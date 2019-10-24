Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 163C3CA9EBB
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 13:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D624D21906
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 13:06:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aoticqkn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393508AbfJXNGk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 09:06:40 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43278 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbfJXNGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 09:06:40 -0400
Received: by mail-lf1-f65.google.com with SMTP id 21so10154505lft.10
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 06:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HDI1nMpN8cFss4OwSUFkCMchIJFxmoHYUy+Ih0fewHU=;
        b=aoticqknGS4hVpEf8tkwGg+bleUukTVXvfVLJTxI90RUTbPJ5Q9xNJ+xkQm55yZvxI
         AOVRhD7HbgRi29Elo40E9ltluUbz0DeUsPAPogsGTEXbd6oet2qBNt+nN3CQhC5uVS3H
         faS8ugVOL5fySQFEZzZg5GHg+4N385CqIGUtW6tVcOokhfwfISQBj+DTCT71YV1N6xIO
         aBqBs36ywc8f6oD7pyyDtADBbRq+K3uGxhtrXYK4516KviInn2P9IwU3OkMZQflcNJmp
         NZljDflPC2r+EIcKv8uk0ccx4WHEnniJkQtThEDf5Wey4GrTJDeY4Iv+RJZhfM6jHLYN
         piUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HDI1nMpN8cFss4OwSUFkCMchIJFxmoHYUy+Ih0fewHU=;
        b=DevP6QgZGcQZASuteH+/oIQWYHiLEdEKj1Q5/uM/eUEhDsTeNLx7p0N6w7YmZQWGxd
         sgK9pEkafdQyTG2n+18pR+oCgLO0RNLArBVbhzw6pBQhM0O8rzsUTEMR+eAYzHpHqsM6
         uM7BGDGarahKLe7h1B7BXy5RB4qvhnsxizil4FVJbTE8BXeBvo0HXWNrAKUKxxYK1Gk4
         q0Ue6pA3lPaKfUyfuHRFKA3JjXb/l59fuj2tRTm/duE2VsmtmukRQSxj/j6XXHT2JqeJ
         Hs9jG54Nqg+v3NvsRs4UBGfwJqBZX8KSscwuNgW4n75FsBATRgMODaLeCqVy6+/2C+bm
         Xxug==
X-Gm-Message-State: APjAAAUtuHupw60SVWbTTcBO8gsyAUUrvSWEl99El6dvSzNemluXrx27
        ga+ymlC5uxlmc0EHNzYfbWaNalqfSkoJoL3eiLk=
X-Google-Smtp-Source: APXvYqx8YXIxrwmTEpKXWITnQbu1h5M4d0TVoM9rBpsl5zJVo47ouTa6cTDmUbarEsDlDPx7JrS89w2MervyEJbX/28=
X-Received: by 2002:a19:40cf:: with SMTP id n198mr19674953lfa.189.1571922397191;
 Thu, 24 Oct 2019 06:06:37 -0700 (PDT)
MIME-Version: 1.0
References: <20191018101248.33727-1-steven.price@arm.com> <20191018101248.33727-14-steven.price@arm.com>
In-Reply-To: <20191018101248.33727-14-steven.price@arm.com>
From:   Zong Li <zongbox@gmail.com>
Date:   Thu, 24 Oct 2019 21:06:25 +0800
Message-ID: <CA+ZOyahE7Z8jw60iu__wE5eeBSvmE57eAY8XY4q3fDdJb6gDrQ@mail.gmail.com>
Subject: Re: [PATCH v12 13/22] mm: pagewalk: Add test_p?d callbacks
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
> It is useful to be able to skip parts of the page table tree even when
> walking without VMAs. Add test_p?d callbacks similar to test_walk but
> which are called just before a table at that level is walked. If the
> callback returns non-zero then the entire table is skipped.
>
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
>  include/linux/pagewalk.h | 11 +++++++++++
>  mm/pagewalk.c            | 24 ++++++++++++++++++++++++
>  2 files changed, 35 insertions(+)
>
> diff --git a/include/linux/pagewalk.h b/include/linux/pagewalk.h
> index 12004b097eae..df424197a25a 100644
> --- a/include/linux/pagewalk.h
> +++ b/include/linux/pagewalk.h
> @@ -24,6 +24,11 @@ struct mm_walk;
>   *                     "do page table walk over the current vma", return=
ing
>   *                     a negative value means "abort current page table =
walk
>   *                     right now" and returning 1 means "skip the curren=
t vma"
> + * @test_pmd:          similar to test_walk(), but called for every pmd.
> + * @test_pud:          similar to test_walk(), but called for every pud.
> + * @test_p4d:          similar to test_walk(), but called for every p4d.
> + *                     Returning 0 means walk this part of the page tabl=
es,
> + *                     returning 1 means to skip this range.
>   *
>   * p?d_entry callbacks are called even if those levels are folded on a
>   * particular architecture/configuration.
> @@ -46,6 +51,12 @@ struct mm_walk_ops {
>                              struct mm_walk *walk);
>         int (*test_walk)(unsigned long addr, unsigned long next,
>                         struct mm_walk *walk);
> +       int (*test_pmd)(unsigned long addr, unsigned long next,
> +                       pmd_t *pmd_start, struct mm_walk *walk);
> +       int (*test_pud)(unsigned long addr, unsigned long next,
> +                       pud_t *pud_start, struct mm_walk *walk);
> +       int (*test_p4d)(unsigned long addr, unsigned long next,
> +                       p4d_t *p4d_start, struct mm_walk *walk);
>  };
>
>  /**
> diff --git a/mm/pagewalk.c b/mm/pagewalk.c
> index 4139e9163aee..43acffefd43f 100644
> --- a/mm/pagewalk.c
> +++ b/mm/pagewalk.c
> @@ -34,6 +34,14 @@ static int walk_pmd_range(pud_t *pud, unsigned long ad=
dr, unsigned long end,
>         const struct mm_walk_ops *ops =3D walk->ops;
>         int err =3D 0;
>
> +       if (ops->test_pmd) {
> +               err =3D ops->test_pmd(addr, end, pmd_offset(pud, 0UL), wa=
lk);
> +               if (err < 0)
> +                       return err;
> +               if (err > 0)
> +                       return 0;
> +       }
> +
>         pmd =3D pmd_offset(pud, addr);
>         do {
>  again:
> @@ -85,6 +93,14 @@ static int walk_pud_range(p4d_t *p4d, unsigned long ad=
dr, unsigned long end,
>         const struct mm_walk_ops *ops =3D walk->ops;
>         int err =3D 0;
>
> +       if (ops->test_pud) {
> +               err =3D ops->test_pud(addr, end, pud_offset(p4d, 0UL), wa=
lk);
> +               if (err < 0)
> +                       return err;
> +               if (err > 0)
> +                       return 0;
> +       }
> +
>         pud =3D pud_offset(p4d, addr);
>         do {
>   again:
> @@ -128,6 +144,14 @@ static int walk_p4d_range(pgd_t *pgd, unsigned long =
addr, unsigned long end,
>         const struct mm_walk_ops *ops =3D walk->ops;
>         int err =3D 0;
>
> +       if (ops->test_p4d) {
> +               err =3D ops->test_p4d(addr, end, p4d_offset(pgd, 0UL), wa=
lk);
> +               if (err < 0)
> +                       return err;
> +               if (err > 0)
> +                       return 0;
> +       }
> +
>         p4d =3D p4d_offset(pgd, addr);
>         do {
>                 next =3D p4d_addr_end(addr, end);
> --
> 2.20.1
>

It's good to me.

Tested-by: Zong Li <zong.li@sifive.com>
