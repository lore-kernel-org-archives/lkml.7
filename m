Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E76E6C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 05:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6D9F206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 05:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556256698;
	bh=cbBtnSxu0YdpcwH8zh+orXx9QRSBuLQJZXmDbZW0zgo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tykEawwJUARzc+k2y57GQV+BXlM7D1en2pPy1/fdpdBRnT091akAQiQCxZdUb4H60
	 mBEm0toTERZv/nHkXV5dAZDCMy1dmvx7gaTgIQ9NCreDJH/6C6P8NGoI64XKR0Wh7O
	 4sNFJc4HVXnB58u7Jtpae0OsHw5Ytusv6eBiFe84=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728397AbfDZFbh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 01:31:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:42550 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725854AbfDZFbh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 01:31:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DF8F9AD64;
        Fri, 26 Apr 2019 05:31:35 +0000 (UTC)
Date:   Fri, 26 Apr 2019 07:31:35 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Jann Horn <jannh@google.com>
Cc:     Matthew Garrett <matthewgarrett@google.com>,
        Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Matthew Garrett <mjg59@google.com>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH V2] mm: Allow userland to request that the kernel clear
 memory on release
Message-ID: <20190426053135.GC12337@dhcp22.suse.cz>
References: <CACdnJuup-y1xAO93wr+nr6ARacxJ9YXgaceQK9TLktE7shab1w@mail.gmail.com>
 <20190424211038.204001-1-matthewgarrett@google.com>
 <20190425121410.GC1144@dhcp22.suse.cz>
 <CAG48ez0x6QiFpqXbimB9ZV-jS5UJJWhzg9XiAWncQL+phfKkPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez0x6QiFpqXbimB9ZV-jS5UJJWhzg9XiAWncQL+phfKkPA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 25-04-19 14:42:52, Jann Horn wrote:
> On Thu, Apr 25, 2019 at 2:14 PM Michal Hocko <mhocko@kernel.org> wrote:
> [...]
> > On Wed 24-04-19 14:10:39, Matthew Garrett wrote:
> > > From: Matthew Garrett <mjg59@google.com>
> > >
> > > Applications that hold secrets and wish to avoid them leaking can use
> > > mlock() to prevent the page from being pushed out to swap and
> > > MADV_DONTDUMP to prevent it from being included in core dumps. Applications
> > > can also use atexit() handlers to overwrite secrets on application exit.
> > > However, if an attacker can reboot the system into another OS, they can
> > > dump the contents of RAM and extract secrets. We can avoid this by setting
> > > CONFIG_RESET_ATTACK_MITIGATION on UEFI systems in order to request that the
> > > firmware wipe the contents of RAM before booting another OS, but this means
> > > rebooting takes a *long* time - the expected behaviour is for a clean
> > > shutdown to remove the request after scrubbing secrets from RAM in order to
> > > avoid this.
> > >
> > > Unfortunately, if an application exits uncleanly, its secrets may still be
> > > present in RAM. This can't be easily fixed in userland (eg, if the OOM
> > > killer decides to kill a process holding secrets, we're not going to be able
> > > to avoid that), so this patch adds a new flag to madvise() to allow userland
> > > to request that the kernel clear the covered pages whenever the page
> > > reference count hits zero. Since vm_flags is already full on 32-bit, it
> > > will only work on 64-bit systems.
> [...]
> > > diff --git a/mm/madvise.c b/mm/madvise.c
> > > index 21a7881a2db4..989c2fde15cf 100644
> > > --- a/mm/madvise.c
> > > +++ b/mm/madvise.c
> > > @@ -92,6 +92,22 @@ static long madvise_behavior(struct vm_area_struct *vma,
> > >       case MADV_KEEPONFORK:
> > >               new_flags &= ~VM_WIPEONFORK;
> > >               break;
> > > +     case MADV_WIPEONRELEASE:
> > > +             /* MADV_WIPEONRELEASE is only supported on anonymous memory. */
> > > +             if (VM_WIPEONRELEASE == 0 || vma->vm_file ||
> > > +                 vma->vm_flags & VM_SHARED) {
> > > +                     error = -EINVAL;
> > > +                     goto out;
> > > +             }
> > > +             new_flags |= VM_WIPEONRELEASE;
> > > +             break;
> 
> An interesting effect of this is that it will be possible to set this
> on a CoW anon VMA in a fork() child, and then the semantics in the
> parent will be subtly different - e.g. if the parent vmsplice()d a
> CoWed page into a pipe, then forked an unprivileged child, the child

Maybe a stupid question. How do you fork an unprivileged child (without
exec)? Child would have to drop priviledges on its own, no?

> set MADV_WIPEONRELEASE on its VMA, the parent died somehow, and then
> the child died, the page in the pipe would be zeroed out. A child
> should not be able to affect its parent like this, I think. If this
> was an mmap() flag instead of a madvise() command, that issue could be
> avoided.

With a VMA flag underneath, I think you can do an early CoW during fork
to prevent from that.

> Alternatively, if adding more mmap() flags doesn't work,
> perhaps you could scan the VMA and ensure that it contains no pages
> yet, or something like that?
> 
> > > diff --git a/mm/memory.c b/mm/memory.c
> > > index ab650c21bccd..ff78b527660e 100644
> > > --- a/mm/memory.c
> > > +++ b/mm/memory.c
> > > @@ -1091,6 +1091,9 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
> > >                       page_remove_rmap(page, false);
> > >                       if (unlikely(page_mapcount(page) < 0))
> > >                               print_bad_pte(vma, addr, ptent, page);
> > > +                     if (unlikely(vma->vm_flags & VM_WIPEONRELEASE) &&
> > > +                         page_mapcount(page) == 0)
> > > +                             clear_highpage(page);
> > >                       if (unlikely(__tlb_remove_page(tlb, page))) {
> > >                               force_flush = 1;
> > >                               addr += PAGE_SIZE;
> 
> Should something like this perhaps be added in page_remove_rmap()
> instead? That's where the mapcount is decremented; and looking at
> other callers of page_remove_rmap(), in particular the following ones
> look interesting:

Well spotted!

-- 
Michal Hocko
SUSE Labs
