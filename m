Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC2B2C3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 14:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D9AB23400
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 14:22:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arm-com.20150623.gappssmtp.com header.i=@arm-com.20150623.gappssmtp.com header.b="1snVJDaz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731028AbfIDOWQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 10:22:16 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39850 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730075AbfIDOWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 10:22:15 -0400
Received: by mail-pl1-f193.google.com with SMTP id bd8so3321151plb.6
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 07:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zLfyPE0SwETDkvtq1bsqjNVDjHFo5NFhYLI0JJDHf+U=;
        b=1snVJDaz07aE2jmpN2RYpCQk1j6M/Srf+5TWc6mM9g3qTtc/LGhpFS8SBr3wKWtEUs
         2vYCnwXgW9GP8u+jBChNFuPMJ8iwZ9V7Xcr5VSkZ9pwacLNBnQbE0mDlDmHrKh6ex7KU
         dEWnsOFqHjya8jp54mNersHodjBUqcvphyH7IfadVYLHKiPHrbJWewxG3TVx7nFeFjiN
         rQk268Xl9j6jNOHV5Tft4pL4TgqePxl2lKQ7MPMfBiNESFOZceoezwFHn8NU4khM2WX0
         p/zEYa4oRctpb7xuorIQkOq1Zv3b4yQo/bzlGSKATz5xFIwT+rPVQBDntFMkz5DnGdMA
         4y8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zLfyPE0SwETDkvtq1bsqjNVDjHFo5NFhYLI0JJDHf+U=;
        b=LUaPhug79zW8m5vSCuZbG9+W16CbaUfROI6+gdEZL8pzwJ5Gk+JwtQcCFb6Isyjv7p
         OiRmUeNT/JJnoiscM7HEcQo1VE927xuENYfClJcRhn6CnZP28zqGmuYk3YHM5SUN8ut3
         zy19Cc6XIjQEyUptvBL36cDos12a50rDWGuteScPVa8EU+jaTFwC3QuGFScW6aNf9Vs5
         RSSkW3JyZyq/o+aksl9+TU9XN30Jv8UNTSjv6Vh76RptuzRO+GaspqyM3Np/YUZdrXJE
         X3RjVGasTG0ByeQS6isB33OIkZg+TYNmd9GCnaKwVlxIWL3wXnVMXCxDUOn6BwZD//lF
         zfVg==
X-Gm-Message-State: APjAAAXVfIk6MenytO7qn9+er4qV9YliE0/EZSFUTg7vUG5aM++UnHIy
        ZhAE1Es/4V58BwfL9ZC57QXx/cIK0iYVhsCH/yw=
X-Google-Smtp-Source: APXvYqwXlRS/Ftz/KVLDn4/l/NIOLb/ncyHE2q5troSsqlmTwDtLGgmlgtnwK5RjJr9zJVjSABvjyUk7dHWl92vOS74=
X-Received: by 2002:a17:902:8a93:: with SMTP id p19mr41493501plo.106.1567606935073;
 Wed, 04 Sep 2019 07:22:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190904005831.153934-1-justin.he@arm.com> <fd22d787-3240-fe42-3ca3-9e8a98f86fce@arm.com>
In-Reply-To: <fd22d787-3240-fe42-3ca3-9e8a98f86fce@arm.com>
From:   Catalin Marinas <catalin.marinas@arm.com>
Date:   Wed, 4 Sep 2019 15:22:03 +0100
Message-ID: <CAHkRjk6cQTu7N+UanTspWm_LyABRhfPHQn1+PPdaHYrTC3PtfQ@mail.gmail.com>
Subject: Re: [PATCH] mm: fix double page fault on arm64 if PTE_AF is cleared
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Jia He <justin.he@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Airlie <airlied@redhat.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        linux-mm <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Sep 2019 at 04:20, Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
> On 09/04/2019 06:28 AM, Jia He wrote:
> > @@ -2152,20 +2153,30 @@ static inline void cow_user_page(struct page *dst, struct page *src, unsigned lo
> >        */
> >       if (unlikely(!src)) {
> >               void *kaddr = kmap_atomic(dst);
> > -             void __user *uaddr = (void __user *)(va & PAGE_MASK);
> > +             void __user *uaddr = (void __user *)(vmf->address & PAGE_MASK);
> > +             pte_t entry;
> >
> >               /*
> >                * This really shouldn't fail, because the page is there
> >                * in the page tables. But it might just be unreadable,
> >                * in which case we just give up and fill the result with
> > -              * zeroes.
> > +              * zeroes. If PTE_AF is cleared on arm64, it might
> > +              * cause double page fault here. so makes pte young here
> >                */
> > +             if (!pte_young(vmf->orig_pte)) {
> > +                     entry = pte_mkyoung(vmf->orig_pte);
> > +                     if (ptep_set_access_flags(vmf->vma, vmf->address,
> > +                             vmf->pte, entry, vmf->flags & FAULT_FLAG_WRITE))
> > +                             update_mmu_cache(vmf->vma, vmf->address,
> > +                                             vmf->pte);
> > +             }
> > +
> >               if (__copy_from_user_inatomic(kaddr, uaddr, PAGE_SIZE))
>
> Should not page fault be disabled when doing this ?

Page faults are already disabled by the kmap_atomic(). But that only
means that you don't deadlock trying to take the mmap_sem again.

> Ideally it should
> have also called access_ok() on the user address range first.

Not necessary, we've already got a vma and the access to the vma checked.

> The point
> is that the caller of __copy_from_user_inatomic() must make sure that
> there cannot be any page fault while doing the actual copy.

When you copy from a user address, in general that's not guaranteed,
more of a best effort.

> But also it
> should be done in generic way, something like in access_ok(). The current
> proposal here seems very specific to arm64 case.

The commit log didn't explain the problem properly. On arm64 without
hardware Access Flag, copying from user will fail because the pte is
old and cannot be marked young. So we always end up with zeroed page
after fork() + CoW for pfn mappings.

-- 
Catalin
