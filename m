Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45CFEC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 19:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09A2F207FC
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 19:03:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="QEPDQCvv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406208AbfIFTD4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 15:03:56 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35782 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406198AbfIFTDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 15:03:55 -0400
Received: by mail-ed1-f67.google.com with SMTP id t50so7272123edd.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 12:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y/7qqRveiNTR8UpDJH9jJYLPMgNqGjPqi5VfF21WzFE=;
        b=QEPDQCvvF/sjHN2kJrzUVeb7IcXP2HWnSdRgACaIl585w3ZTFPm+c7jIRgZK0q2kuM
         92rKkxhkJNdxqD2rTigoeHOOBgEZvMLX1jEIN2PMc+bXuokn+I7auIRx3xEn1ykJyf1u
         CXLkGSvmkg2ksV0wgOa7ekkr38WY61xs1odE9/PBZA3P7HsDw85795v0qIS9QWC3f1Mi
         whJST2fStGwvRAp/SN37FFgS8pip/MVJJ1R051L4sBuMq5NVauiRReOfNiZJ14PNzP/r
         tzF75BO2LMAqLB/WKPYKhZweNmKjX5bKa3K+ThUussgLwJ2PIJ50AROtJu9cwcDhVCk1
         bJng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y/7qqRveiNTR8UpDJH9jJYLPMgNqGjPqi5VfF21WzFE=;
        b=TRnYNw0CwrHz4iLyCwDIcZiTVImTQuyLhCo5GCFmIePMkvLmSbk1PFTBlQ0rZ7wnMu
         KF01OrksepSgux3rwK7aF281+R8trp32av6lTyQdftshK2TuSmM0OrWOpb5S0XxLVmq/
         cKxa6N9uQ7WcKRQeKNrSD2xfiYQp4JIXK3RUZ1ZD5Cpbgadur4fuHW+wcdBoNdMLqm5v
         G2DixndwjK03ZJmUnHhxV+FDfpxBSHe8neWssEG3TCLA0abDmQqFXDHkwKSjeZ918SBT
         nsopU4bxcCHZlhjaSO8dSN+ulocN4ZCue6crUqfNXhQFZTsctwcjESwHqiesRvQHGN2w
         OIeA==
X-Gm-Message-State: APjAAAUkBUlv/JC4m7eG+PJwZ8GMDlFhzo0dL56O9hA0lkhTCGdyR8Am
        SeF1NwAdiR+NkwCNQ0rJ6/nG5O01DWzRzwPWEo43qg==
X-Google-Smtp-Source: APXvYqxBZr4A/XPsx9DL6X3UVVIiqZlxxSg15azW0Vlg1Y/GEwtp0qO5WsKKt8HfTWnnuA9cZMhLLr/nV3+FiR+zkNw=
X-Received: by 2002:a17:906:bb0f:: with SMTP id jz15mr8592077ejb.264.1567796633333;
 Fri, 06 Sep 2019 12:03:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190821183204.23576-1-pasha.tatashin@soleen.com>
 <20190821183204.23576-11-pasha.tatashin@soleen.com> <21f6eb6f-be3a-a715-a37c-2f59183ed183@arm.com>
In-Reply-To: <21f6eb6f-be3a-a715-a37c-2f59183ed183@arm.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Fri, 6 Sep 2019 15:03:42 -0400
Message-ID: <CA+CK2bAS37vPa0FD7Ya1vnZR29hiEsNfkq6q7+UreNRjRgUEFw@mail.gmail.com>
Subject: Re: [PATCH v3 10/17] arm64, trans_pgd: adjust trans_pgd_create_copy interface
To:     James Morse <james.morse@arm.com>
Cc:     James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        kexec mailing list <kexec@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>, will@kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        linux-mm <linux-mm@kvack.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > -int trans_pgd_create_copy(pgd_t **dst_pgdp, unsigned long start,
> > +/*
> > + * Create trans_pgd and copy entries from from_table to trans_pgd in range
> > + * [start, end)
> > + */
> > +int trans_pgd_create_copy(struct trans_pgd_info *info, pgd_t **trans_pgd,
> > +                       pgd_t *from_table, unsigned long start,
> >                         unsigned long end);
>
> This creates a copy of the linear-map. Why does it need to be told from_table?

This what done as a generic page table entries copy, but I agree, will
remove the from_table.

>
>
> > diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
> > index 8c2641a9bb09..8bb602e91065 100644
> > --- a/arch/arm64/kernel/hibernate.c
> > +++ b/arch/arm64/kernel/hibernate.c
> > @@ -323,15 +323,42 @@ int swsusp_arch_resume(void)
> >       phys_addr_t phys_hibernate_exit;
> >       void __noreturn (*hibernate_exit)(phys_addr_t, phys_addr_t, void *,
> >                                         void *, phys_addr_t, phys_addr_t);
> > +     struct trans_pgd_info trans_info = {
> > +             .trans_alloc_page       = hibernate_page_alloc,
> > +             .trans_alloc_arg        = (void *)GFP_ATOMIC,
> > +             /*
> > +              * Resume will overwrite areas that may be marked read only
> > +              * (code, rodata). Clear the RDONLY bit from the temporary
> > +              * mappings we use during restore.
> > +              */
> > +             .trans_flags            = TRANS_MKWRITE,
> > +     };
>
>
> > +     /*
> > +      * debug_pagealloc will removed the PTE_VALID bit if the page isn't in
> > +      * use by the resume kernel. It may have been in use by the original
> > +      * kernel, in which case we need to put it back in our copy to do the
> > +      * restore.
> > +      *
> > +      * Before marking this entry valid, check the pfn should be mapped.
> > +      */
> > +     if (debug_pagealloc_enabled())
> > +             trans_info.trans_flags |= (TRANS_MKVALID | TRANS_CHECKPFN);
>
> The debug_pagealloc_enabled() check should be with the code that generates a different
> entry. Whether the different entry is correct needs to be considered with
> debug_pagealloc_enabled() in mind. You are making this tricky logic less clear.
>
> There is no way the existing code invents an entry for a !pfn_valid() page. With your
> 'checkpfn' flag, this thing can. You don't need to generalise this for hypothetical users.

Ok

>
>
> If kexec needs to create mappings for bogus pages, I'd like to know why.
>

It does not.

>
> >       /*
> >        * Restoring the memory image will overwrite the ttbr1 page tables.
> >        * Create a second copy of just the linear map, and use this when
> >        * restoring.
> >        */
> > -     rc = trans_pgd_create_copy(&tmp_pg_dir, PAGE_OFFSET, 0);
> > -     if (rc)
> > +     rc = trans_pgd_create_copy(&trans_info, &tmp_pg_dir, init_mm.pgd,
> > +                                PAGE_OFFSET, 0);
>
> > +     if (rc) {
> > +             if (rc == -ENOMEM)
> > +                     pr_err("Failed to allocate memory for temporary page tables.\n");
> > +             else if (rc == -ENXIO)
> > +                     pr_err("Tried to set PTE for PFN that does not exist\n");
> >               goto out;
> > +     }
>
> If you think the distinction for this error message is useful, it would be clearer to
> change it in the current hibernate code before you move it. (_copy_pte() to return an
> error, instead of silently failing). Done here, this is unrelated noise.
>

Ok, will do that.
