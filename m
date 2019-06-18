Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99EB7C46477
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 18:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7756F2147A
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 18:30:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="ub6bbFJz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730156AbfFRSag (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 14:30:36 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38538 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729642AbfFRSaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 14:30:35 -0400
Received: by mail-ot1-f68.google.com with SMTP id d17so16413581oth.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 11:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QURH9BlGMn5ivsBiRhffgAaGzwMxDE7JjHw07LOOJ3U=;
        b=ub6bbFJz3cGKP4DJvWt4cUVqnMPw0tYXYidWbWXz5IxojFBYfjQ8+NZNM0A1parMjg
         XuFtTjWosbXHYsKY5pvZ5h+rYeB1mauKvpUBx4cgQrogpBjgrJMwYDtS3nIClop4mXlI
         K1OFS3VCjjxATk1/fHRb3qM66QJ7N04Z7iRdxfnsHDIM6jfupT4uo0uS34WafuE5lwzp
         FurJGKVyNOq9jawJJg3WekhcWtRoOty1/Qq2q6C4tCl2eJFzHji0sZCBR/nizOARyhOi
         iudVj04uNutBsNfwMWZMlqzV1RPKKk1YzjBxEEfA/qewB6FXwktk1tkFRmWhTOP2u+7Q
         /VDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QURH9BlGMn5ivsBiRhffgAaGzwMxDE7JjHw07LOOJ3U=;
        b=rFBmQrJqrpvQMc/WGhq7h3mnYLXpZh5PFNGAd7ZbD2UlWPxx0NZ7tx6oE8R1bG9xCX
         EqLRQag7unU1pNbS/C23dT35xHVxSrphhe59uoKqI5cL9R7FxY+xUmjxUvNvVjzBL3an
         vz+XR84O64sQYLv1iXebnsROrbQPiyKu+chWg2hsjEW1C7UTK6oVEsjjrnGMeHqcDzuE
         QJ3j1GvHjiGyH7Ikl9WICDIOccGCRcgf/ure3iGLeWCXpfiiEm6CYzKaWfulkS/MA+LJ
         FVluYxOkUG8Gshd7m1Cp1V7ig95xMkqaQE6NlidsI23qFI1rXRjxlC7SR4vnaA/G5eB+
         lCbQ==
X-Gm-Message-State: APjAAAU4y3V2b2iSrIGE9vVeBowsOOwQNuPpECURXr28w6s7zD4N5R30
        NnFdbxnAqfvunQl/9rWFJ1EmxJNuxW2ewn9T8SmKtA==
X-Google-Smtp-Source: APXvYqzgZ0IGDjeEZoDLAA85SSKphkLslMWxC7Pq+36Ps83jAVNEXt1pNtzBuZDXh16tYO6i1b9YAg3RzegDs+Djppw=
X-Received: by 2002:a9d:7a46:: with SMTP id z6mr281269otm.2.1560882635053;
 Tue, 18 Jun 2019 11:30:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190613045903.4922-1-namit@vmware.com> <CAPcyv4hpWg5DWRhazS-ftyghiZP-J_M-7Vd5tiUd5UKONOib8g@mail.gmail.com>
 <9387A285-B768-4B58-B91B-61B70D964E6E@vmware.com>
In-Reply-To: <9387A285-B768-4B58-B91B-61B70D964E6E@vmware.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 18 Jun 2019 11:30:23 -0700
Message-ID: <CAPcyv4hstt+0teXPtAq2nwFQaNb9TujgetgWPVMOnYH8JwqGeA@mail.gmail.com>
Subject: Re: [PATCH 0/3] resource: find_next_iomem_res() improvements
To:     Nadav Amit <namit@vmware.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, Borislav Petkov <bp@suse.de>,
        Toshi Kani <toshi.kani@hpe.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2019 at 10:42 AM Nadav Amit <namit@vmware.com> wrote:
>
> > On Jun 17, 2019, at 11:44 PM, Dan Williams <dan.j.williams@intel.com> w=
rote:
> >
> > On Wed, Jun 12, 2019 at 9:59 PM Nadav Amit <namit@vmware.com> wrote:
> >> Running some microbenchmarks on dax keeps showing find_next_iomem_res(=
)
> >> as a place in which significant amount of time is spent. It appears th=
at
> >> in order to determine the cacheability that is required for the PTE,
> >> lookup_memtype() is called, and this one traverses the resources list =
in
> >> an inefficient manner. This patch-set tries to improve this situation.
> >
> > Let's just do this lookup once per device, cache that, and replay it
> > to modified vmf_insert_* routines that trust the caller to already
> > know the pgprot_values.
>
> IIUC, one device can have multiple regions with different characteristics=
,
> which require difference cachability.

Not for pmem. It will always be one common cacheability setting for
the entirety of persistent memory.

> Apparently, that is the reason there
> is a tree of resources. Please be more specific about where you want to
> cache it, please.

The reason for lookup_memtype() was to try to prevent mixed
cacheability settings of pages across different processes . The
mapping type for pmem/dax is established by one of:

drivers/nvdimm/pmem.c:413:              addr =3D
devm_memremap_pages(dev, &pmem->pgmap);
drivers/nvdimm/pmem.c:425:              addr =3D
devm_memremap_pages(dev, &pmem->pgmap);
drivers/nvdimm/pmem.c:432:              addr =3D devm_memremap(dev,
pmem->phys_addr,
drivers/nvdimm/pmem.c-433-                              pmem->size,
ARCH_MEMREMAP_PMEM);

...and is constant for the life of the device and all subsequent mappings.

> Perhaps you want to cache the cachability-mode in vma->vm_page_prot (whic=
h I
> see being done in quite a few cases), but I don=E2=80=99t know the code w=
ell enough
> to be certain that every vma should have a single protection and that it
> should not change afterwards.

No, I'm thinking this would naturally fit as a property hanging off a
'struct dax_device', and then create a version of vmf_insert_mixed()
and vmf_insert_pfn_pmd() that bypass track_pfn_insert() to insert that
saved value.
