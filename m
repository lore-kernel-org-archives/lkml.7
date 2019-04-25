Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA6AAC10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 12:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 673DA205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 12:43:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YTEL7lcX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731315AbfDYMnV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 08:43:21 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43750 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbfDYMnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 08:43:20 -0400
Received: by mail-ot1-f67.google.com with SMTP id u15so19235929otq.10
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 05:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bXgqURV3byj3cYEdSZNf6ZaP2flQvEPyxHp20vNGNFo=;
        b=YTEL7lcX1b8/OtmLyct2lZre+5wMQQQI6B1dICt0ZW3Kbaog1YmCeYwf1gHyOlV5bS
         XE1yVqlxhZtqALK+Iyh7u1l9XffWkEhM0+3V4f70zgstTgIs68CD9plXvmJZ9pi8KVye
         XVT5GEAJzA+JuSKdM27WhrsKU3oVwTkLxojaRASvPzPCBbFi1zbxWnUoBvGfH0CuFaAN
         TR+Br9nLRVfE8BMbyl4lgA63ehL7UJdFHGAc9yCz4QaGA7VkkpfwDMcHhnsFJdReAWFU
         rjZ/nzOt3YV3EzXQYl9I3BFPpbCCwg0RaklU16hKCngkz42TCwNlfSyU4ecbMd/WCjCd
         aAbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bXgqURV3byj3cYEdSZNf6ZaP2flQvEPyxHp20vNGNFo=;
        b=czWONyy0IopPyKOHqBYo0O08kRsM96h6kCV8u9ScOhddIh0IV6L703N+UeSw+o2tVp
         r6AdKIKIZYRFBoJKjMZDAyRpu54VY3fi13rY3Y2co7vG3rK7GDtCHYocIksLKlvrylB1
         f8hq4zboYcSMMQIxL/xHx352+nbN8NRhFhUSQtBiA0hwydLSThdBN/hVxI30skLiQDE5
         h6zTaMPuzL5IiIUPwfOfsIIBiSFZWG2QDlFNke51wAruG5Ra8EdgMj7PXfNgviFB35hr
         SSTmE3f5o81nqLqQpXBaRpyQNttja4RUqyc7mFslOa+waHm4p5WWdB2z2jBdQMk6oi2G
         UPJw==
X-Gm-Message-State: APjAAAX9HOhdwx46fsWInRRICo1bSWTC2MGfUnxP39mGImMRhIrJhVAw
        wrB69n51mY4hZs1B/m0Wo2/R4UDlcynYSOIoSxnsMA==
X-Google-Smtp-Source: APXvYqyO4UUmMXYBm7UvTINmNgFQslxkKkbn/GniIAn3Jb72SxdCwuR5c637iFcVfaQIFg0OUac6aBiPdhsliABJzGE=
X-Received: by 2002:a9d:7095:: with SMTP id l21mr24116770otj.35.1556196198973;
 Thu, 25 Apr 2019 05:43:18 -0700 (PDT)
MIME-Version: 1.0
References: <CACdnJuup-y1xAO93wr+nr6ARacxJ9YXgaceQK9TLktE7shab1w@mail.gmail.com>
 <20190424211038.204001-1-matthewgarrett@google.com> <20190425121410.GC1144@dhcp22.suse.cz>
In-Reply-To: <20190425121410.GC1144@dhcp22.suse.cz>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 25 Apr 2019 14:42:52 +0200
Message-ID: <CAG48ez0x6QiFpqXbimB9ZV-jS5UJJWhzg9XiAWncQL+phfKkPA@mail.gmail.com>
Subject: Re: [PATCH V2] mm: Allow userland to request that the kernel clear
 memory on release
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Matthew Garrett <matthewgarrett@google.com>,
        Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Matthew Garrett <mjg59@google.com>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 2:14 PM Michal Hocko <mhocko@kernel.org> wrote:
[...]
> On Wed 24-04-19 14:10:39, Matthew Garrett wrote:
> > From: Matthew Garrett <mjg59@google.com>
> >
> > Applications that hold secrets and wish to avoid them leaking can use
> > mlock() to prevent the page from being pushed out to swap and
> > MADV_DONTDUMP to prevent it from being included in core dumps. Applications
> > can also use atexit() handlers to overwrite secrets on application exit.
> > However, if an attacker can reboot the system into another OS, they can
> > dump the contents of RAM and extract secrets. We can avoid this by setting
> > CONFIG_RESET_ATTACK_MITIGATION on UEFI systems in order to request that the
> > firmware wipe the contents of RAM before booting another OS, but this means
> > rebooting takes a *long* time - the expected behaviour is for a clean
> > shutdown to remove the request after scrubbing secrets from RAM in order to
> > avoid this.
> >
> > Unfortunately, if an application exits uncleanly, its secrets may still be
> > present in RAM. This can't be easily fixed in userland (eg, if the OOM
> > killer decides to kill a process holding secrets, we're not going to be able
> > to avoid that), so this patch adds a new flag to madvise() to allow userland
> > to request that the kernel clear the covered pages whenever the page
> > reference count hits zero. Since vm_flags is already full on 32-bit, it
> > will only work on 64-bit systems.
[...]
> > diff --git a/mm/madvise.c b/mm/madvise.c
> > index 21a7881a2db4..989c2fde15cf 100644
> > --- a/mm/madvise.c
> > +++ b/mm/madvise.c
> > @@ -92,6 +92,22 @@ static long madvise_behavior(struct vm_area_struct *vma,
> >       case MADV_KEEPONFORK:
> >               new_flags &= ~VM_WIPEONFORK;
> >               break;
> > +     case MADV_WIPEONRELEASE:
> > +             /* MADV_WIPEONRELEASE is only supported on anonymous memory. */
> > +             if (VM_WIPEONRELEASE == 0 || vma->vm_file ||
> > +                 vma->vm_flags & VM_SHARED) {
> > +                     error = -EINVAL;
> > +                     goto out;
> > +             }
> > +             new_flags |= VM_WIPEONRELEASE;
> > +             break;

An interesting effect of this is that it will be possible to set this
on a CoW anon VMA in a fork() child, and then the semantics in the
parent will be subtly different - e.g. if the parent vmsplice()d a
CoWed page into a pipe, then forked an unprivileged child, the child
set MADV_WIPEONRELEASE on its VMA, the parent died somehow, and then
the child died, the page in the pipe would be zeroed out. A child
should not be able to affect its parent like this, I think. If this
was an mmap() flag instead of a madvise() command, that issue could be
avoided. Alternatively, if adding more mmap() flags doesn't work,
perhaps you could scan the VMA and ensure that it contains no pages
yet, or something like that?

> > diff --git a/mm/memory.c b/mm/memory.c
> > index ab650c21bccd..ff78b527660e 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -1091,6 +1091,9 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
> >                       page_remove_rmap(page, false);
> >                       if (unlikely(page_mapcount(page) < 0))
> >                               print_bad_pte(vma, addr, ptent, page);
> > +                     if (unlikely(vma->vm_flags & VM_WIPEONRELEASE) &&
> > +                         page_mapcount(page) == 0)
> > +                             clear_highpage(page);
> >                       if (unlikely(__tlb_remove_page(tlb, page))) {
> >                               force_flush = 1;
> >                               addr += PAGE_SIZE;

Should something like this perhaps be added in page_remove_rmap()
instead? That's where the mapcount is decremented; and looking at
other callers of page_remove_rmap(), in particular the following ones
look interesting:

 - do_huge_pmd_wp_page()/do_huge_pmd_wp_page_fallback() might be
relevant in the case where a forking process contains transparent
hugepages?
 - zap_huge_pmd() is relevant when transparent hugepages are used, I
think (otherwise transparent hugepages might not be wiped?)
 - there are various callers related to migration; I think this is
relevant on a NUMA system where memory is moved between nodes to
improve locality (moving memory to a new page and freeing the old one,
in which case you'd want to wipe the old page)

I think all the callers have a reference to the VMA, so perhaps you
could add a VMA parameter to page_remove_rmap() and then look at the
VMA in there?
