Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1DB9C10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 17:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDCA9206C2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 17:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570554431;
	bh=L33sy+OezUROJsHem3255Ics0vCeLJX9JturixwZC60=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=bQnpnaebN2gasOwogU/LuDaOWr6sQfvyRj6nShrelmXYsXp8Bgs3wMuEtw3bgYsHe
	 k8iHS4N9KPNVYgXfSc4KXT93qrx2/1lzs3/4/C7CinUkdCZyE38vB+6oGzy8OMvl3c
	 /hCZzOrudcFVLrvme487HVCzMMXI+z7sP8qChKN0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729034AbfJHRHL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 13:07:11 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43065 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbfJHRHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 13:07:10 -0400
Received: by mail-lf1-f67.google.com with SMTP id u3so12506394lfl.10
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 10:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XJM/CmZg6Z5jzXw4aAwQQ7njeCb11d/hVxoFBeKQhrY=;
        b=ReRkzdzi+v9g+NGO+NDFI7PGCcrUVdY64ueoH7j4mlWoK/n86aa4CYeKK3a6u/8tBy
         fYGyPyxGFTm6AWff8+32JPNdkEYWn+z7CJfoNmJULOWfvrjOKYwkyJl1Wkb1GuERxeAl
         BvLkCTZtIFczxB0eRfSwKT7Q8WRPg5p92N3TA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XJM/CmZg6Z5jzXw4aAwQQ7njeCb11d/hVxoFBeKQhrY=;
        b=KLBiBaaqiUNmFkKzIAl5CDzYkxKJ9P297OryO2FHE14V38c0TkfNV8As/ncNvDKIVu
         YAG82f7fRAeHAzS7DKlBNyKmMq0ELxUUrzxheMv29Th7bw2hVy/IwCNCPOM04C50zVyv
         Q3PLKQafvdStMlExE49vVtMELL6sv764OfMxAWRZF2wROaCW87precXka3VMv53RfdV4
         DB1cfwhDPofTmUNURdLAnbcQV939Elbl5b245L3BO0LQCoKfqqBV0CWHTJYdJhBn9ATs
         Dh6nN8XmVC/9LeXTaa0zJcfF57Kf99kCACFzlo24DQydMH26S5u7aP8SIdFyShfFi0Hw
         tqKg==
X-Gm-Message-State: APjAAAVkH70GBhpDgPIvNg9N1obUJ9H7e1W/iXA+QUDGd1BXuH7p6cmh
        kCbDqUx380UBma3qIGRKuq31EcfdQuw=
X-Google-Smtp-Source: APXvYqw7/s3zGto7osh4P57B2lqpnxQ/eAAD/n1WW/jQRfEnbkLscp4rGQrrhCjWd0kUzzoeCNtroA==
X-Received: by 2002:a19:c7d3:: with SMTP id x202mr20826342lff.124.1570554424813;
        Tue, 08 Oct 2019 10:07:04 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id t8sm5309054ljd.18.2019.10.08.10.07.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2019 10:07:03 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id y127so12578758lfc.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 10:07:02 -0700 (PDT)
X-Received: by 2002:a19:7d55:: with SMTP id y82mr20982648lfc.106.1570554422608;
 Tue, 08 Oct 2019 10:07:02 -0700 (PDT)
MIME-Version: 1.0
References: <20191008091508.2682-1-thomas_os@shipmail.org> <20191008091508.2682-6-thomas_os@shipmail.org>
In-Reply-To: <20191008091508.2682-6-thomas_os@shipmail.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 8 Oct 2019 10:06:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi-7QgG5_gJEGu73xVXUDW-pUwRFDLrkx+VjbY_HzMp9w@mail.gmail.com>
Message-ID: <CAHk-=wi-7QgG5_gJEGu73xVXUDW-pUwRFDLrkx+VjbY_HzMp9w@mail.gmail.com>
Subject: Re: [PATCH v4 5/9] mm: Add write-protect and clean utilities for
 address space ranges
To:     =?UTF-8?Q?Thomas_Hellstr=C3=B6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Huang Ying <ying.huang@intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 8, 2019 at 2:15 AM Thomas Hellstr=C3=B6m (VMware)
<thomas_os@shipmail.org> wrote:
>
> Add two utilities to 1) write-protect and 2) clean all ptes pointing into
> a range of an address space.

The code looks much simpler and easier to understand now, I think, but
that also makes some thing more obvious..

> +static int clean_record_pte(pte_t *pte, unsigned long addr,
> +                           unsigned long end, struct mm_walk *walk)
> +{
> +       struct wp_walk *wpwalk =3D walk->private;
> +       struct clean_walk *cwalk =3D to_clean_walk(wpwalk);
> +       pte_t ptent =3D *pte;
> +
> +       if (pte_dirty(ptent)) {
> +               pgoff_t pgoff =3D ((addr - walk->vma->vm_start) >> PAGE_S=
HIFT) +
> +                       walk->vma->vm_pgoff - cwalk->bitmap_pgoff;
> +               pte_t old_pte =3D ptep_modify_prot_start(walk->vma, addr,=
 pte);
> +
> +               ptent =3D pte_mkclean(old_pte);
> +               ptep_modify_prot_commit(walk->vma, addr, pte, old_pte, pt=
ent);
> +
> +               wpwalk->total++;
> +               wpwalk->tlbflush_start =3D min(wpwalk->tlbflush_start, ad=
dr);
> +               wpwalk->tlbflush_end =3D max(wpwalk->tlbflush_end,
> +                                          addr + PAGE_SIZE);
> +
> +               __set_bit(pgoff, cwalk->bitmap);

The above looks fundamentally racy.

You clean the pte in memory, but it remains dirty and writable in the
TLB, and you only flush it much later.

So now writes can continue to happen to that page, without it
necessarily being marked dirty again in the page tables, because all
the CPU TLB caches say "it's already dirty".

This may be ok - you've moved the diry bit into that bitmap, and you
will flush the TLB before then taking action on the bitmap. So you
haven't really _lost_ any dirty bits, but it still may be worth a
comment.

You do have comments about the _other_ issues (ie the whole "If a
caller needs to make sure all dirty ptes are picked up and none
additional are added..") but you don't actually have comments about
the TLB race basically potentially now causing "missing" dirty stuff.

And this may actually be a big problem on some architectures. Not x86,
and maybe nothing else, but I have this dim memory of some
architectures being unhappy due to virtual caches, and writeback when
the page table entry says it's read-only and clean.

Our normal "clean pages" is very anal about this, and does

                        flush_cache_page(vma, address, pte_pfn(*pte));
                        entry =3D ptep_clear_flush(vma, address, pte);
                        entry =3D pte_wrprotect(entry);
                        entry =3D pte_mkclean(entry);
                        set_pte_at(vma->vm_mm, address, pte, entry);

when it cleans a page, and I note both the cache flush and the
"clear_flush()" (which invalidates the pte and does a synchronous TLB
flush) and we have magic semantics for that at least on s390 because
there are some low-level architecture details wrt flushing TLB entries
and modifying them.

End result: I think the code is probably ok in practice because you
don't mind the slightly fuzzy dirty bit state, and it's _probably_ ok
on all architectures that use drm for the TLB invalidation side. But I
think it bears a bit of thinking about.

              Linus
