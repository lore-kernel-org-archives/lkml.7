Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F7EC06511
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 00:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC94221E71
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 00:26:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="or3ER8GL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbfGCA0x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 20:26:53 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35077 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfGCA0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 20:26:52 -0400
Received: by mail-qt1-f195.google.com with SMTP id d23so694856qto.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 17:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5c4oP4xTk1IBbNBe2Xnvi/hVZ3pLkXGkSfkFWUiE8zI=;
        b=or3ER8GL2VWQXZAyB6TKaLxj3ZFYyknrFx+DqXSLqFoMdoX/GpuCyI8Accipx9XSXu
         7qN7Ep0mMjEOze0iArZLcQaghY0h7AfTzceaWGUg6xA9X+NG6ztolo43eA4dK09rLJH6
         UDQ+gdYIBXGT2OUYEgAjjMhPTuRlsCjnwRpIP8fzur/UOBQEhT5v4++uOi6vy9q2Q41s
         heeBlwdOLLZq4T2WfFmg7MWEv8ML15czbGavD1JSf2FDogclfmr2HtzlrJaqmPOhNF4I
         YtAz6LaBVmDaKQH3Pcj6S6S+8lKrewvtQE+kVftBUH1B7tjPcMY94B1BIPKJSc3+10+U
         MNPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5c4oP4xTk1IBbNBe2Xnvi/hVZ3pLkXGkSfkFWUiE8zI=;
        b=D5lxvmPyEFfhjO78hjSiEoQc3/SFcm9OQpGyvqFK37p+5HJOD58kZTjcRroQl4EL6/
         IDbzR7ojKZs1urrTy4oPUE2VZaArScDvq/9pFotnzSOrtG+CvvbR/H0KqfdbhPwZ+qy8
         T8DdhSLSctl6ZWPkxTLoqGP/eiINWSVlHFZSWZ0lDHkFFNNXkLq+dR1ooEYPOw59Jvwu
         VvIDlMHtO7S5VPnHnMlZPP5PUdP3kLZQtA+b5rPXsz6Mp528gzLoZT1NcnLVXG0/ANo2
         jtY+mqFK2BS5+wVo5bXjKIgViEjSdznixn9zmkuFR+1i++QrtRLRvqkbUOClEimuDiVi
         Jhrw==
X-Gm-Message-State: APjAAAUMQOYezKVYIe+kqBZ9ppq+TEt3JLtl1gES74pbAdoNoVljI+c9
        NN2vdA78WMTsDSo2rCOCGaD/YbypXkpThOj1MLb4bXsyns4=
X-Google-Smtp-Source: APXvYqyngmd2Rg7LbbyIIoGmaR3URsrZvldAi9oHTTvEW7shZpguleHzKCoPWfRQ0zGoAN9CeBeNA81xUQUG0rbjvsw=
X-Received: by 2002:ac8:1a59:: with SMTP id q25mr27066278qtk.76.1562110013149;
 Tue, 02 Jul 2019 16:26:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190702231302.60727-1-nhuck@google.com> <20190702232459.GA14941@archlinux-epyc>
In-Reply-To: <20190702232459.GA14941@archlinux-epyc>
From:   Nathan Huckleberry <nhuck@google.com>
Date:   Tue, 2 Jul 2019 16:26:42 -0700
Message-ID: <CAJkfWY4yvVVmJoQ0WwyoFBkWYsUJnnQPNU+-g23-m-L3ETe_hQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: mm: Fix dead assignment of old_pte
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oops I forgot moving the variable declaration would cause a warning.
Will send a V2.

Thanks,
Nathan Huckleberry

On Tue, Jul 2, 2019 at 4:25 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> On Tue, Jul 02, 2019 at 04:13:02PM -0700, 'Nathan Huckleberry' via Clang Built Linux wrote:
> > When analyzed with the clang static analyzer the
> > following warning occurs
> >
> > line 251, column 2
> > Value stored to 'old_pte' is never read
> >
> > This warning is repeated every time pgtable.h is
> > included by another file and produces ~3500
> > extra warnings.
> >
> > Moving old_pte into preprocessor guard.
> >
> > Cc: clang-built-linux@googlegroups.com
> > Signed-off-by: Nathan Huckleberry <nhuck@google.com>
> > ---
> >  arch/arm64/include/asm/pgtable.h | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> > index fca26759081a..42ca4fc67f27 100644
> > --- a/arch/arm64/include/asm/pgtable.h
> > +++ b/arch/arm64/include/asm/pgtable.h
> > @@ -238,8 +238,6 @@ extern void __sync_icache_dcache(pte_t pteval);
> >  static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
> >                             pte_t *ptep, pte_t pte)
> >  {
> > -     pte_t old_pte;
> > -
> >       if (pte_present(pte) && pte_user_exec(pte) && !pte_special(pte))
> >               __sync_icache_dcache(pte);
> >
> > @@ -248,8 +246,11 @@ static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
> >        * hardware updates of the pte (ptep_set_access_flags safely changes
> >        * valid ptes without going through an invalid entry).
> >        */
> > +     #if IS_ENABLED(CONFIG_DEBUG_VM)
> > +     pte_t old_pte;
> > +
> >       old_pte = READ_ONCE(*ptep);
> > -     if (IS_ENABLED(CONFIG_DEBUG_VM) && pte_valid(old_pte) && pte_valid(pte) &&
> > +     if (pte_valid(old_pte) && pte_valid(pte) &&
> >          (mm == current->active_mm || atomic_read(&mm->mm_users) > 1)) {
> >               VM_WARN_ONCE(!pte_young(pte),
> >                            "%s: racy access flag clearing: 0x%016llx -> 0x%016llx",
> > @@ -258,6 +259,7 @@ static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
> >                            "%s: racy dirty state clearing: 0x%016llx -> 0x%016llx",
> >                            __func__, pte_val(old_pte), pte_val(pte));
> >       }
> > +     #endif
> >
> >       set_pte(ptep, pte);
> >  }
> > --
> > 2.22.0.410.gd8fdbe21b5-goog
> >
>
> Hi Nathan,
>
> This does not apply on -next because of https://git.kernel.org/arm64/c/9b604722059039a1a3ff69fb8dfd024264046024.
> I would get into the habit of testing -next to see if the warning is
> present there first because someone may have independently fixed it
> already (I'd be surprised if it wasn't fixed by that commit from a quick
> glance).
>
> Additionally, when I do apply this patch to mainline and build, I see
> the following warning:
>
> In file included from /home/nathan/cbl/linux/arch/arm64/kernel/asm-offsets.c:10:
> In file included from /home/nathan/cbl/linux/include/linux/arm_sdei.h:14:
> In file included from /home/nathan/cbl/linux/include/acpi/ghes.h:5:
> In file included from /home/nathan/cbl/linux/include/acpi/apei.h:9:
> In file included from /home/nathan/cbl/linux/include/linux/acpi.h:34:
> In file included from /home/nathan/cbl/linux/include/acpi/acpi_io.h:5:
> In file included from /home/nathan/cbl/linux/include/linux/io.h:13:
> In file included from /home/nathan/cbl/linux/arch/arm64/include/asm/io.h:18:
> /home/nathan/cbl/linux/arch/arm64/include/asm/pgtable.h:250:8: warning: ISO C90 forbids mixing declarations and code [-Wdeclaration-after-statement]
>         pte_t old_pte;
>               ^
> 1 warning generated.
>
> Cheers,
> Nathan
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20190702232459.GA14941%40archlinux-epyc.
