Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 343C8C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 09:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 085DF2084D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 09:21:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="l1enudLK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728999AbfIJJU6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 05:20:58 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35996 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389682AbfIJJU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 05:20:57 -0400
Received: by mail-ed1-f66.google.com with SMTP id f2so10012022edw.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 02:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fVGVsESSvCGQOFNvs9wLVPNtEbA+xNhK0Vsp0KuYL0U=;
        b=l1enudLKhX+NelYlOqQKvgNY5xLG29otQPhknZNcMkv0NM6LGktXu52o7Rq9oXni7U
         rT6qa9jJFvVV7DGrQcvT7TkQVr7YPjzLLN2yyQhzqc/3CKUefFYh0Wj1fNGmGs1LrBaU
         +Rt/P8fFgugTd0kFHr2Ss0tY7TIbjyM5B9kitn9D5U0zYDDTKHkZiimf0vIykHPbq2fZ
         mZWj8mIoPkIvn0hdw5gdaffVtvbc7DNotaOw6ScSEUxSsXK+bbSJXldYd/iSPSahFARY
         wygqctO/41VVuzlrbXrPVfgvn1BZBO8SRggWpYtz77R2bRkNGZ3TfXnz9srnNazLkorr
         QBDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fVGVsESSvCGQOFNvs9wLVPNtEbA+xNhK0Vsp0KuYL0U=;
        b=tREthPoDZ4mcXdgzF8n4aEqSRflukJcNIZy48Qh1vgK7UNy+IOWeZVgqS9/U8cc2SI
         2bVAT/YC9/2F1M3pVgg8d12pmzYeiDcDD1q9PYZCWiyVhueLI/0eZimcuJSW7rYuiVcZ
         zR5D2QqVVgH4NGBGKmn3wQ5QE2qUAYZ5X7pXZAla/5MlP5XQvU3BvU9eRLgm6BgBh+6J
         mu49NPQrNUpz8KTYE9VatXY4fJKCiMFWgBqGSzCGClNjrW8K2OOB0pA+K8KM4eh6uDWd
         GfoB6ykoY5tDCx9LAQQt608s8QBT2eQUuKm4jAOxmXhih6vNxwxo4fYyMYbpfP0mQ8ua
         ZfIw==
X-Gm-Message-State: APjAAAUB02RwJfBS5EaxoIZjkkWZxkefz6pA5rYMLC8L2zwX/hDZAl8a
        dyRXbLAhvRusZymKRJkxikBSGkSsJFbucGiXcsERBZHkU34=
X-Google-Smtp-Source: APXvYqxafwr9K7U55nRLBrBFKjJwhzRPMsyqMlNm7SM6xGY0Iw+4afMLkFcRjz7kyMGTKRb774E7d1RrUT7vfuc/ufA=
X-Received: by 2002:aa7:dd17:: with SMTP id i23mr28832869edv.124.1568107254841;
 Tue, 10 Sep 2019 02:20:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190909181221.309510-1-pasha.tatashin@soleen.com>
 <20190909181221.309510-11-pasha.tatashin@soleen.com> <60975350-87f8-56b3-437d-d9ee26ac3bd3@suse.com>
In-Reply-To: <60975350-87f8-56b3-437d-d9ee26ac3bd3@suse.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Tue, 10 Sep 2019 10:20:43 +0100
Message-ID: <CA+CK2bBK40T_DEhNvz8nQaKSsanxXpGYhBm05N_NmZtq+JDVTg@mail.gmail.com>
Subject: Re: [PATCH v4 10/17] arm64: trans_pgd: make trans_pgd_map_page generic
To:     Matthias Brugger <mbrugger@suse.com>
Cc:     James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        kexec mailing list <kexec@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>, will@kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        James Morse <james.morse@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        linux-mm <linux-mm@kvack.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +/*
> > + * Add map entry to trans_pgd for a base-size page at PTE level.
> > + * page:     page to be mapped.
> > + * dst_addr: new VA address for the pages
> > + * pgprot:   protection for the page.
>
> For consistency please describe all function parameters. From my experience
> function parameter description is normally done in the C-file that implements
> the logic. Don't ask me why.

Ok, I move the comment, and will describe every parameter. Thank you.

>
> > + */
> > +int trans_pgd_map_page(struct trans_pgd_info *info, pgd_t *trans_pgd,
> > +                    void *page, unsigned long dst_addr, pgprot_t pgprot);
> >
> >  #endif /* _ASM_TRANS_TABLE_H */
> > diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
> > index 94ede33bd777..9b75b680ab70 100644
> > --- a/arch/arm64/kernel/hibernate.c
> > +++ b/arch/arm64/kernel/hibernate.c
> > @@ -179,6 +179,12 @@ int arch_hibernation_header_restore(void *addr)
> >  }
> >  EXPORT_SYMBOL(arch_hibernation_header_restore);
> >
> > +static void *
> > +hibernate_page_alloc(void *arg)
>
> AFAICS no new line needed here.

Right, will fix it.

>
> > +{
> > +     return (void *)get_safe_page((gfp_t)(unsigned long)arg);
> > +}
> > +
> >  /*
> >   * Copies length bytes, starting at src_start into an new page,
> >   * perform cache maintenance, then maps it at the specified address low
> > @@ -195,6 +201,10 @@ static int create_safe_exec_page(void *src_start, size_t length,
> >                                unsigned long dst_addr,
> >                                phys_addr_t *phys_dst_addr)
> >  {
> > +     struct trans_pgd_info trans_info = {
> > +             .trans_alloc_page       = hibernate_page_alloc,
> > +             .trans_alloc_arg        = (void *)GFP_ATOMIC,
> > +     };
>
> New line between end of struct and other variables.

Sure.

>
> With these changes:
> Reviewed-by: Matthias Brugger <mbrugger@suse.com>

Thank you,
Pasha
