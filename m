Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF07C10F00
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 10:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACC9420661
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 10:27:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728712AbfCFK1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 05:27:08 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:32866 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728559AbfCFK1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 05:27:07 -0500
Received: by mail-qt1-f193.google.com with SMTP id z39so12217383qtz.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 02:27:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CSeOuhnVpG+O/XMLRISqa+zO/p/JxBsd2lVZegfOtAE=;
        b=VP3gL1hJJTbAP9aY6j6hx7J1SiwIfacAzLpfJcfctbb1gab0CHna9JH3mJYxeh319a
         3hReTNRgcdSmQSjhqfCyWX+iNwAvmqSLdTFQF2B73xjrI98ODXmoCqJhKqQ1xy6r7qjY
         f2ufnVa8QzzbtJmaemkIKpFyZGkagVayHudqQ5FXf6GMnBMrNJFvwznN7YMYnsqs7k4z
         Lxe4aE+pYk3Puj48Zoe2k0JO0JrXPChDRaR2fXXLlzIO3hecsWrW2xM4RxoPB1gUMdbM
         2wcGquJpkj6kXm8V6KOduMI5czqKOCKCuGf+BasY4ds8eMGr/Ejv51xL4YRSvBO4yI60
         IdQw==
X-Gm-Message-State: APjAAAUA4BooxYMF3viuHIsIzS0W9ZEpDCYKovPEgbs8uShATv/KTHyo
        VzG7KdLmRLFNKJ5hvc2mZvyqnHfpClFJFHyHdkqfm/rV
X-Google-Smtp-Source: APXvYqx8KXF2sVH+kCoN66rCFdIhCx5S1tAN7BNbc9XkL0WASGOtHPlJRmgDHIyw4pXWTxuHzbi+XfPwGYdOq6NGtk4=
X-Received: by 2002:a0c:b501:: with SMTP id d1mr5728256qve.115.1551868026847;
 Wed, 06 Mar 2019 02:27:06 -0800 (PST)
MIME-Version: 1.0
References: <20190304200026.1140281-1-arnd@arndb.de> <be817f74-3441-47c1-6958-233d6e1172c4@arm.com>
In-Reply-To: <be817f74-3441-47c1-6958-233d6e1172c4@arm.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 6 Mar 2019 11:26:49 +0100
Message-ID: <CAK8P3a3FUtGceVWK530E-iOWqh=p=Q-KKZCkNCeXh2UhFc3m9A@mail.gmail.com>
Subject: Re: [PATCH] mm/hmm: fix unused variable warnings
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        John Hubbard <jhubbard@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 5, 2019 at 1:18 PM Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
> On 03/05/2019 01:30 AM, Arnd Bergmann wrote:
> > When CONFIG_HUGETLB_PAGE is disabled, the only use of the variable 'h'
> > is compiled out, and the compiler thinks it is unnecessary:
> >
> > mm/hmm.c: In function 'hmm_range_snapshot':
> > mm/hmm.c:1015:19: error: unused variable 'h' [-Werror=unused-variable]
> >     struct hstate *h = hstate_vma(vma);
>
> After doing some Kconfig hacks like (ARCH_WANT_GENERAL_HUGETLB = n) on an
> X86 system I got (HUGETLB_PAGE = n and HMM = y) config. But was unable to
> hit the build error. Helper is_vm_hugetlb_page() seems to always return
> false when HUGETLB_PAGE = n. Would not the compiler remove the entire code
> block including the declaration for 'h' ?
>
> #ifdef CONFIG_HUGETLB_PAGE
> #include <linux/mm.h>
> static inline bool is_vm_hugetlb_page(struct vm_area_struct *vma)
> {
>         return !!(vma->vm_flags & VM_HUGETLB);
> }
> #else
> static inline bool is_vm_hugetlb_page(struct vm_area_struct *vma)
> {
>         return false;
> }
> #endif

The is_vm_hugetlb_page() check is unrelated to the warning here,
the problem is that huge_page_shift() is defined as

#define huge_page_shift(h) PAGE_SHIFT

when CONFIG_HUGETLB_PAGE is disabled, so after preprocessing,
the only reference to the variable is removed.

     Arnd
