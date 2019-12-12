Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 211F3C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 17:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDAAA2054F
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 17:59:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="aj/3kNTY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730302AbfLLR7i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 12:59:38 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46971 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730281AbfLLR7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 12:59:37 -0500
Received: by mail-ot1-f68.google.com with SMTP id g18so2829728otj.13
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 09:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hyvqVUw30+SZX29bM7+V3jqwHKdXckZsARui5p8wXkE=;
        b=aj/3kNTYpNtUKR7EbJSlbIR7OuvgLrMsg2A0F6fYB2/hgfbnnbl9+8LyBrDy8shOr8
         5jTRk/BMXhnudMowqBHH0S5NYKRgQ9rFxuCKeSDofqeXcfx7uhKtC17UdE8kpSWquJTK
         2BEC9fGPeKSZClELYV/QJzc4je45MeCqEmu8+jh7SGQ9Wn9umQYfHEoAt/brB+rXFcDd
         KNSUTD9SOFqgEMRxqF9sBEz3w7SpWD6Io1lcnEy62y2YhXxStP+4qcvBAPnvD6CQZpO5
         OXEG8ziZSWTPQLVmfvYXsVj6zS+izGC5yMNZ51Z9Ts6g9RBxBSIb8XJVb/S+wzWyoaQQ
         FXXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hyvqVUw30+SZX29bM7+V3jqwHKdXckZsARui5p8wXkE=;
        b=sd50ldC7EkDCvOaklSefa9xdHVaQfEUsVFAGj1lS/xdbKT55FgkNpQJkLYI1O77JLu
         GguBJZdLFTVVSU+2zomsdsZr5n4asQsfzyEJ+YVB3FOoXtHdvYcEWfu4xL9oSPuB9Htw
         QaqjaMnui91+W2E6k+2lWd3t95dMKTF3M2QsC7+QwbMB3IKQlQqTJaVX/3GFif9JBIyE
         +F8Nl76i5Nmk6ZAeqN3SpzxjNerOLpZLewZmxDmHtKEj6sIjFNZrIFC45V8jf4Q3isRO
         9LLGWYwNTpUmozpIciOMd2+S6rBY5hVXsumoaq79KE2AS5Dej/ow9LIkEDWngQq/Wrtt
         FVcg==
X-Gm-Message-State: APjAAAWas6vkS98EptbcwQ5MjRGV0J2e8i0FHVDngiPKsnpqgVmevUT2
        deoBvXiO8o/KbbGkC6nwRwKaJj6+yS6GKSNkVcB43Q==
X-Google-Smtp-Source: APXvYqyspLymJk5JMISgtjN43ATBp0Ct1Ma15zdcNgSN1GXL58ve4+5Bo2yaPsSdIlPxIzbTPZlJpTFkdzRW2z7T/rk=
X-Received: by 2002:a9d:6f11:: with SMTP id n17mr9356386otq.126.1576173576479;
 Thu, 12 Dec 2019 09:59:36 -0800 (PST)
MIME-Version: 1.0
References: <20191211213207.215936-1-brho@google.com> <20191211213207.215936-3-brho@google.com>
 <376DB19A-4EF1-42BF-A73C-741558E397D4@oracle.com> <CAPcyv4gpYF=D323G+69FhFZw4i5W-15_wTRa1xNPdmear0phTw@mail.gmail.com>
 <F19843AB-1974-4E79-A85B-9AE00D58E192@oracle.com>
In-Reply-To: <F19843AB-1974-4E79-A85B-9AE00D58E192@oracle.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 12 Dec 2019 09:59:25 -0800
Message-ID: <CAPcyv4i5ZaiA+KeraXzz-0vs25UGEmZ2ka9Z-PUT3T_7URAFMA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] kvm: Use huge pages for DAX-backed files
To:     Liran Alon <liran.alon@oracle.com>
Cc:     Barret Rhoden <brho@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        X86 ML <x86@kernel.org>, KVM list <kvm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Zeng, Jason" <jason.zeng@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2019 at 9:39 AM Liran Alon <liran.alon@oracle.com> wrote:
>
>
>
> > On 12 Dec 2019, at 18:54, Dan Williams <dan.j.williams@intel.com> wrote=
:
> >
> > On Thu, Dec 12, 2019 at 4:34 AM Liran Alon <liran.alon@oracle.com> wrot=
e:
> >>
> >>
> >>
> >>> On 11 Dec 2019, at 23:32, Barret Rhoden <brho@google.com> wrote:
> >>>
> >>> This change allows KVM to map DAX-backed files made of huge pages wit=
h
> >>> huge mappings in the EPT/TDP.
> >>>
> >>> DAX pages are not PageTransCompound.  The existing check is trying to
> >>> determine if the mapping for the pfn is a huge mapping or not.  For
> >>> non-DAX maps, e.g. hugetlbfs, that means checking PageTransCompound.
> >>> For DAX, we can check the page table itself.
> >>
> >> For hugetlbfs pages, tdp_page_fault() -> mapping_level() -> host_mappi=
ng_level() -> kvm_host_page_size() -> vma_kernel_pagesize()
> >> will return the page-size of the hugetlbfs without the need to parse t=
he page-tables.
> >> See vma->vm_ops->pagesize() callback implementation at hugetlb_vm_ops-=
>pagesize()=3D=3Dhugetlb_vm_op_pagesize().
> >>
> >> Only for pages that were originally mapped as small-pages and later me=
rged to larger pages by THP, there is a need to check for PageTransCompound=
(). Again, instead of parsing page-tables.
> >>
> >> Therefore, it seems more logical to me that:
> >> (a) If DAX-backed files are mapped as large-pages to userspace, it sho=
uld be reflected in vma->vm_ops->page_size() of that mapping. Causing kvm_h=
ost_page_size() to return the right size without the need to parse the page=
-tables.
> >
> > A given dax-mapped vma may have mixed page sizes so ->page_size()
> > can't be used reliably to enumerating the mapping size.
>
> Naive question: Why don=E2=80=99t split the VMA in this case to multiple =
VMAs with different results for ->page_size()?

Filesystems traditionally have not populated ->pagesize() in their
vm_operations, there was no compelling reason to go add it and the
complexity seems prohibitive.

> What you are describing sounds like DAX is breaking this callback semanti=
cs in an unpredictable manner.

It's not unpredictable. vma_kernel_pagesize() returns PAGE_SIZE. Huge
pages in the page cache has a similar issue.

> >> (b) If DAX-backed files small-pages can be later merged to large-pages=
 by THP, then the =E2=80=9Cstruct page=E2=80=9D of these pages should be mo=
dified as usual to make PageTransCompound() return true for them. I=E2=80=
=99m not highly familiar with this mechanism, but I would expect THP to be =
able to merge DAX-backed files small-pages to large-pages in case DAX provi=
des =E2=80=9Cstruct page=E2=80=9D for the DAX pages.
> >
> > DAX pages do not participate in THP and do not have the
> > PageTransCompound accounting. The only mechanism that records the
> > mapping size for dax is the page tables themselves.
>
> What is the rational behind this? Given that DAX pages can be described w=
ith =E2=80=9Cstruct page=E2=80=9D (i.e. ZONE_DEVICE), what prevents THP fro=
m manipulating page-tables to merge multiple DAX PFNs to a larger page?

THP accounting is a function of the page allocator. ZONE_DEVICE pages
are excluded from the page allocator. ZONE_DEVICE is just enough
infrastructure to support pfn_to_page(), page_address(), and
get_user_pages(). Other page allocator services beyond that are not
present.
