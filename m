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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB7A9CA9EBC
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 13:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DEE121906
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 13:09:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ouz4PbLg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502350AbfJXNJR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 09:09:17 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40667 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730867AbfJXNJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 09:09:16 -0400
Received: by mail-lf1-f66.google.com with SMTP id i15so11660240lfo.7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 06:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UcBPcAPMYq3ql7XZolJWjM40KQcfZi7nEuSg4RQDIuc=;
        b=Ouz4PbLg3SeM/SRzKwbpYWtMvLrdJ6nOXnWQL0oUQhHWeGv2Mw58FeTuy/DJXAzYZ3
         +CGlc91Gh/uDfemb2YnBDYRG4mREUzJ26nWAuYs1id0BVvBF4PKggM4GaRcnWpVoGpVT
         41TqNQx9bbMIK7CxLzbB9PwKXWq4IIEx/oy8U3BBUTeO0s+Tw+7S7QsaJfQfcpzbSC8N
         PSSgzAXE5chQDW2RsAPMrmAsBSXpM/9+FyW7vIYG9iQXXiUTn+9EzpNJ0f3jbj/dZk51
         h+c6HNv46YaTCOw1eXDjFT1HqVBIGHAtTqYVqJTmv/Gk2l2Ao9PUPU7+S4jvenhE/Tzg
         8xUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UcBPcAPMYq3ql7XZolJWjM40KQcfZi7nEuSg4RQDIuc=;
        b=EyKxaBTtAGaPe6mGqwEyMLA+SKzr3UhyBg4LPRW4LPSfcCu+HfWcTSCQ9AlNp+u944
         aJeFZlvPosdi/p/bAOAA6lTpzqQZjNwOIHoT3B7MVVpYTAiRWXS8+F1jZ3ZR8UiWXLXe
         ebTZUUQAxWaK6nzKiZeV4muClXGQhjHzWVWWUae6FrF/ghO6thNKqOBNCoMraZ1BSFPv
         fb/1/2XirAmR8ainu1YMjyNX3EgO3G2ydCJjwXouGu24BXohR13v2sErltRfejify46s
         vCuk7L6zq1PbljkbOBIeCIy0KCppL+detlvIr5olFrzs/fJtBOCvMOgfsN0kr+yA4Jp+
         7xig==
X-Gm-Message-State: APjAAAVEvIRGtdw3vHZ7ZFksSNS9coF47+k3Kk293dwOmmvjMYtIaD/J
        2rcVi+B7kfMYOwUV/CmMpavVfUrM8ePIUAMoodY=
X-Google-Smtp-Source: APXvYqw7AnXk46JAKtrvbMSXREq+EburX1Xswn3NrPh+gx0SKQjxDmlCifTtUoCo+f45tE5PxMdIHbGV2ouTvaD2BAI=
X-Received: by 2002:ac2:4345:: with SMTP id o5mr11786215lfl.60.1571922554635;
 Thu, 24 Oct 2019 06:09:14 -0700 (PDT)
MIME-Version: 1.0
References: <20191024093716.49420-1-steven.price@arm.com> <20191024093716.49420-8-steven.price@arm.com>
In-Reply-To: <20191024093716.49420-8-steven.price@arm.com>
From:   Zong Li <zongbox@gmail.com>
Date:   Thu, 24 Oct 2019 21:09:03 +0800
Message-ID: <CA+ZOyajoTagPdMA=WaQVLZ+aPzKmdX=j+apRVUsvpbVF_HtnQw@mail.gmail.com>
Subject: Re: [PATCH v13 07/22] riscv: mm: Add p?d_leaf() definitions
To:     Steven Price <steven.price@arm.com>
Cc:     linux-mm@kvack.org, Mark Rutland <Mark.Rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-riscv@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        Alexandre Ghiti <alex@ghiti.fr>, x86@kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        James Morse <james.morse@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Price <steven.price@arm.com> =E6=96=BC 2019=E5=B9=B410=E6=9C=8824=E6=
=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=885:40=E5=AF=AB=E9=81=93=EF=BC=9A
>
> walk_page_range() is going to be allowed to walk page tables other than
> those of user space. For this it needs to know when it has reached a
> 'leaf' entry in the page tables. This information is provided by the
> p?d_leaf() functions/macros.
>
> For riscv a page is a leaf page when it has a read, write or execute bit
> set on it.
>
> CC: Palmer Dabbelt <palmer@sifive.com>
> CC: Albert Ou <aou@eecs.berkeley.edu>
> CC: linux-riscv@lists.infradead.org
> Reviewed-by: Alexandre Ghiti <alex@ghiti.fr>
> Acked-by: Paul Walmsley <paul.walmsley@sifive.com> # for arch/riscv
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
>  arch/riscv/include/asm/pgtable-64.h | 7 +++++++
>  arch/riscv/include/asm/pgtable.h    | 7 +++++++
>  2 files changed, 14 insertions(+)
>
> diff --git a/arch/riscv/include/asm/pgtable-64.h b/arch/riscv/include/asm=
/pgtable-64.h
> index 74630989006d..4c4d2c65ba6c 100644
> --- a/arch/riscv/include/asm/pgtable-64.h
> +++ b/arch/riscv/include/asm/pgtable-64.h
> @@ -43,6 +43,13 @@ static inline int pud_bad(pud_t pud)
>         return !pud_present(pud);
>  }
>
> +#define pud_leaf       pud_leaf
> +static inline int pud_leaf(pud_t pud)
> +{
> +       return pud_present(pud) &&
> +              (pud_val(pud) & (_PAGE_READ | _PAGE_WRITE | _PAGE_EXEC));
> +}
> +
>  static inline void set_pud(pud_t *pudp, pud_t pud)
>  {
>         *pudp =3D pud;
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pg=
table.h
> index 7255f2d8395b..3aa972dda75a 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -130,6 +130,13 @@ static inline int pmd_bad(pmd_t pmd)
>         return !pmd_present(pmd);
>  }
>
> +#define pmd_leaf       pmd_leaf
> +static inline int pmd_leaf(pmd_t pmd)
> +{
> +       return pmd_present(pmd) &&
> +              (pmd_val(pmd) & (_PAGE_READ | _PAGE_WRITE | _PAGE_EXEC));
> +}
> +
>  static inline void set_pmd(pmd_t *pmdp, pmd_t pmd)
>  {
>         *pmdp =3D pmd;
> --
> 2.20.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

It's good to me.

Reviewed-by: Zong Li <zong.li@sifive.com>
