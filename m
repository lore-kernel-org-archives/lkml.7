Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50547CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 19:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1255B20663
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 19:44:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="N3d5UbzG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733228AbfJ2ToG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 15:44:06 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34774 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbfJ2ToF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 15:44:05 -0400
Received: by mail-ot1-f68.google.com with SMTP id m19so10883486otp.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 12:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rseI2StXRFIWgXi1960y4IJeCU+Pr92yGtIRrRU/tpU=;
        b=N3d5UbzG9b26T28zrvzS/vYdr6Ck3KTI0M21Cur3aYnF4gJ5RF7BSZj116qAXa4+73
         PGzCxLlD7prbz8z7c31yJMXXQ/5ceMVyNQ9MomhYZZeFhQLK33i4hCM/efTyoBD8ez3Z
         X457rU4o2Gc89mS1jh0v5H3fasHzVJpF7z/FMDEm5tuqU/PY1CNyip7d29+KumAe6eFi
         wijvRgmfclpWVJHt///7DsURxwyX+W9qpLZ0UdCPhWU1fPZgRhf5+BE9CiDpqx/qtT3L
         Ku7pteWKTBtsTeard/yx12PcoGb/isnkXMBt0Kn0hkDE/6EOvpmAvUUXH7WFUKMiuQB/
         01CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rseI2StXRFIWgXi1960y4IJeCU+Pr92yGtIRrRU/tpU=;
        b=MaxaEBPNCfqJUFDYWWZ9jYphHZXRIqCjwSG/rIFqJ59LQNUeKpf/foGynpdoYB00wL
         t+nXGM60Rzf5b/11ygLclgD3YJEzsAowqFxokvpc4Z8Z8VDMozlFi1jeV4ghRncL1kZC
         4GLGnLITpqYypNhO3hf30YiNeMDyw/37P3xqOtGRUJzwn3X/ASxh/ot8BQZ3ZZp0J+MT
         V0SJXUEzlAvERokHZd/uFCUymM6p1MHdhm2jSpQhR6ZIeQSoyf4M2i95QW4ZFtq3fTcY
         dzPcKytkiVAdJ9JA/Wi6l5hDRb2OGXh0wtPIHhUy2dDBR75bw2dm6MyEcDQOlCGn/NBU
         KXlg==
X-Gm-Message-State: APjAAAWuqlG7sutPybUIfXbxDAy97ViLTjaLlew/IgpcnU0jNS/zi/TX
        aN3t9d8Y1G40eWFPuYXycXU9pD4RxrdMxj9EES3MkA==
X-Google-Smtp-Source: APXvYqyoVe8XPrLDUa/vztjuSw6fk2NbPkWrowxRCtDlWOiRE7kbO74rCGAw0oFOgIqY2gL1RwKp8aJPbvhf7PuUQCA=
X-Received: by 2002:a05:6830:18d1:: with SMTP id v17mr5402370ote.71.1572378244686;
 Tue, 29 Oct 2019 12:44:04 -0700 (PDT)
MIME-Version: 1.0
References: <1572171452-7958-1-git-send-email-rppt@kernel.org>
 <1572171452-7958-2-git-send-email-rppt@kernel.org> <20191028123124.ogkk5ogjlamvwc2s@box>
 <20191028130018.GA7192@rapoport-lnx> <20191028131623.zwuwguhm4v4s5imh@box>
 <CAA9_cmd7f2y2AAT6646S=tco3yfyLgCAC4Qp=1iTQaJqrQcOwQ@mail.gmail.com> <20191029064318.s4n4gidlfjun3d47@box>
In-Reply-To: <20191029064318.s4n4gidlfjun3d47@box>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 29 Oct 2019 12:43:53 -0700
Message-ID: <CAPcyv4hDPdmHxhMF753Jt5Dk6V9bTAkGqzkyYHCiG6xowT4Ncg@mail.gmail.com>
Subject: Re: [PATCH RFC] mm: add MAP_EXCLUSIVE to create exclusive user mappings
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Mike Rapoport <rppt@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2019 at 11:43 PM Kirill A. Shutemov
<kirill@shutemov.name> wrote:
>
> On Mon, Oct 28, 2019 at 10:43:51PM -0700, Dan Williams wrote:
> > On Mon, Oct 28, 2019 at 6:16 AM Kirill A. Shutemov <kirill@shutemov.name> wrote:
> > >
> > > On Mon, Oct 28, 2019 at 02:00:19PM +0100, Mike Rapoport wrote:
> > > > On Mon, Oct 28, 2019 at 03:31:24PM +0300, Kirill A. Shutemov wrote:
> > > > > On Sun, Oct 27, 2019 at 12:17:32PM +0200, Mike Rapoport wrote:
> > > > > > From: Mike Rapoport <rppt@linux.ibm.com>
> > > > > >
> > > > > > The mappings created with MAP_EXCLUSIVE are visible only in the context of
> > > > > > the owning process and can be used by applications to store secret
> > > > > > information that will not be visible not only to other processes but to the
> > > > > > kernel as well.
> > > > > >
> > > > > > The pages in these mappings are removed from the kernel direct map and
> > > > > > marked with PG_user_exclusive flag. When the exclusive area is unmapped,
> > > > > > the pages are mapped back into the direct map.
> > > > >
> > > > > I probably blind, but I don't see where you manipulate direct map...
> > > >
> > > > __get_user_pages() calls __set_page_user_exclusive() which in turn calls
> > > > set_direct_map_invalid_noflush() that makes the page not present.
> > >
> > > Ah. okay.
> > >
> > > I think active use of this feature will lead to performance degradation of
> > > the system with time.
> > >
> > > Setting a single 4k page non-present in the direct mapping will require
> > > splitting 2M or 1G page we usually map direct mapping with. And it's one
> > > way road. We don't have any mechanism to map the memory with huge page
> > > again after the application has freed the page.
> > >
> > > It might be okay if all these pages cluster together, but I don't think we
> > > have a way to achieve it easily.
> >
> > Still, it would be worth exploring what that would look like if not
> > for MAP_EXCLUSIVE then set_mce_nospec() that wants to punch out poison
> > pages from the direct map. In the case of pmem, where those pages are
> > able to be repaired, it would be nice to also repair the mapping
> > granularity of the direct map.
>
> The solution has to consist of two parts: finding a range to collapse and
> actually collapsing the range into a huge page.
>
> Finding the collapsible range will likely require background scanning of
> the direct mapping as we do for THP with khugepaged. It should not too
> hard, but likely require long and tedious tuning to be effective, but not
> too disturbing for the system.
>
> Alternatively, after any changes to the direct mapping, we can initiate
> checking if the range is collapsible. Up to 1G around the changed 4k.
> It might be more taxing than scanning if direct mapping changes often.
>
> Collapsing itself appears to be simple: re-check if the range is
> collapsible under the lock, replace the page table with the huge page and
> flush the TLB.
>
> But some CPUs don't like to have two TLB entries for the same memory with
> different sizes at the same time. See for instance AMD erratum 383.

That basic description would seem to defeat most (all?) interesting
huge page use cases. For example dax makes no attempt to make sure
aliased mappings of pmem are the same size between the direct map that
the driver uses, and userspace dax mappings. So I assume there are
more details than "all aliased mappings must be the same size".

> Getting it right would require making the range not present, flush TLB and
> only then install huge page. That's what we do for userspace.
>
> It will not fly for the direct mapping. There is no reasonable way to
> exclude other CPU from accessing the range while it's not present (call
> stop_machine()? :P). Moreover, the range may contain the code that doing
> the collapse or data required for it...

At least for pmem all the access points can be controlled. pmem is
never used for kernel text at least in the dax mode where it is
accessed via file-backed shared mappings, or the pmem driver. So when
I say "direct-map repair" I mean the incidental direct-map that pmem
uses since it maps pmem with arch_add_memory(), not the typical DRAM
direct-map that may house kernel text. Poison consumed from the kernel
DRAM direct-map is fatal, poison consumed from dax mappings and the
pmem driver path is recoverable and repairable.
