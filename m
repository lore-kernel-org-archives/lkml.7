Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C08C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 06:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ED68217F4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 06:17:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iKpuC37b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726471AbfDIGRw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 02:17:52 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46345 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbfDIGRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 02:17:52 -0400
Received: by mail-lf1-f67.google.com with SMTP id r25so2758616lfn.13;
        Mon, 08 Apr 2019 23:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XVUI5sWl/mko1IjkbRDCczAOo+DWIKHvVwzZKO9ey8M=;
        b=iKpuC37b/W9gnQHlKyXQsrbKJd+/drf2Hv8V3oXIdmLPXDVZ9PIoNs12K3H/oeXZSd
         ntqA/DPibQG3kCHwVQ1+u5E6p3D1xq3D5anzZWBFdTux4ntxY/u+UD79r72OeMCnFR4v
         +v8oEW8Pce6NPS6evVaWwTmOR8s28EpacqA8lf/PLOsdQOlml8q7m5VaVbiRssH/Cj+I
         lIdgJUEIvd3wzqVYEklHNeJxatPwj86ktRvsFhosFc+61nBn7yd3rTm8VkMoXQXoLx6I
         AfzL866vMcmHkMBVnb2EODlFqUt/Tf6sb5rLwjofq6ZQKlmgWDWmVXOru/yi09PGWw6w
         Hk4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XVUI5sWl/mko1IjkbRDCczAOo+DWIKHvVwzZKO9ey8M=;
        b=lB6hqAdSklcwv6zY3hy4PSfhY2+D+5udTvYc5pjRLqsa1y1gIkKANmDcDFjrCLDmy5
         7ZdPwOADSub5fvQ0auCszjCguWMSh9NwewoKEaHVlzudtjtk9Z1jxifegIwJhYX3UEX1
         duqJAqO+zU6z2O+ypHVrIv6S9HsD6axIiVYxlNNAtIpCvAjlUaDE4DJVPwlVQL1KZDDW
         NNhMpO41nniteQeBd6fs9yy50QNs8lH3FL5VguzwMofhtCiS2HNES5DfuvPyksCpP3/T
         jPSGl/snlHj3z1AsjE0LxAAycHNQ1wrZfTGbzWo4zqNrDa8gMac+wjb+keXNIxRb1ZNO
         W+jg==
X-Gm-Message-State: APjAAAUSTP8fuCJ/DH28gFfPS2jbdRjM2wLwzIgMb+MVY/8LllkRmje3
        pu3zGiXvTdIqr6JmQuJW/YhuDHSQ4qkl4VO7APU=
X-Google-Smtp-Source: APXvYqzRVyYQF95nCiqgET1kk0SjOcmMhC+aOUtHZXTsDUtBuKrygbCT0gC/J5XPE8cvaOujK9I/d9QG6rJVxJTRI3I=
X-Received: by 2002:a19:f013:: with SMTP id p19mr12738522lfc.36.1554790669149;
 Mon, 08 Apr 2019 23:17:49 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1552921225.git.jrdr.linux@gmail.com> <CAFqt6zaV5zcc495BBk1Wi7p+zOF8y=P5KRfKkvwY=stagUFKWQ@mail.gmail.com>
In-Reply-To: <CAFqt6zaV5zcc495BBk1Wi7p+zOF8y=P5KRfKkvwY=stagUFKWQ@mail.gmail.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Tue, 9 Apr 2019 11:47:37 +0530
Message-ID: <CAFqt6zbDk7OAdk-WXG50Frppny0DOpdwR1vnTS7pCpjf66j3aQ@mail.gmail.com>
Subject: Re: [RESEND PATCH v4 0/9] mm: Use vm_map_pages() and
 vm_map_pages_zero() API
To:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        rppt@linux.vnet.ibm.com, Peter Zijlstra <peterz@infradead.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        robin.murphy@arm.com, iamjoonsoo.kim@lge.com, treding@nvidia.com,
        Kees Cook <keescook@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        stefanr@s5r6.in-berlin.de, hjc@rock-chips.com,
        Heiko Stuebner <heiko@sntech.de>, airlied@linux.ie,
        oleksandr_andrushchenko@epam.com, joro@8bytes.org,
        pawel@osciak.com, Kyungmin Park <kyungmin.park@samsung.com>,
        mchehab@kernel.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        linux-arm-kernel@lists.infradead.org,
        linux1394-devel@lists.sourceforge.net,
        dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org, xen-devel@lists.xen.org,
        iommu@lists.linux-foundation.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew/ Michal,

On Mon, Apr 1, 2019 at 10:56 AM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> Hi Andrew,
>
> On Tue, Mar 19, 2019 at 7:47 AM Souptick Joarder <jrdr.linux@gmail.com> wrote:
> >
> > Previouly drivers have their own way of mapping range of
> > kernel pages/memory into user vma and this was done by
> > invoking vm_insert_page() within a loop.
> >
> > As this pattern is common across different drivers, it can
> > be generalized by creating new functions and use it across
> > the drivers.
> >
> > vm_map_pages() is the API which could be used to map
> > kernel memory/pages in drivers which has considered vm_pgoff.
> >
> > vm_map_pages_zero() is the API which could be used to map
> > range of kernel memory/pages in drivers which has not considered
> > vm_pgoff. vm_pgoff is passed default as 0 for those drivers.
> >
> > We _could_ then at a later "fix" these drivers which are using
> > vm_map_pages_zero() to behave according to the normal vm_pgoff
> > offsetting simply by removing the _zero suffix on the function
> > name and if that causes regressions, it gives us an easy way to revert.
> >
> > Tested on Rockchip hardware and display is working fine, including talking
> > to Lima via prime.
> >
> > v1 -> v2:
> >         Few Reviewed-by.
> >
> >         Updated the change log in [8/9]
> >
> >         In [7/9], vm_pgoff is treated in V4L2 API as a 'cookie'
> >         to select a buffer, not as a in-buffer offset by design
> >         and it always want to mmap a whole buffer from its beginning.
> >         Added additional changes after discussing with Marek and
> >         vm_map_pages() could be used instead of vm_map_pages_zero().
> >
> > v2 -> v3:
> >         Corrected the documentation as per review comment.
> >
> >         As suggested in v2, renaming the interfaces to -
> >         *vm_insert_range() -> vm_map_pages()* and
> >         *vm_insert_range_buggy() -> vm_map_pages_zero()*.
> >         As the interface is renamed, modified the code accordingly,
> >         updated the change logs and modified the subject lines to use the
> >         new interfaces. There is no other change apart from renaming and
> >         using the new interface.
> >
> >         Patch[1/9] & [4/9], Tested on Rockchip hardware.
> >
> > v3 -> v4:
> >         Fixed build warnings on patch [8/9] reported by kbuild test robot.
> >
> > Souptick Joarder (9):
> >   mm: Introduce new vm_map_pages() and vm_map_pages_zero() API
> >   arm: mm: dma-mapping: Convert to use vm_map_pages()
> >   drivers/firewire/core-iso.c: Convert to use vm_map_pages_zero()
> >   drm/rockchip/rockchip_drm_gem.c: Convert to use vm_map_pages()
> >   drm/xen/xen_drm_front_gem.c: Convert to use vm_map_pages()
> >   iommu/dma-iommu.c: Convert to use vm_map_pages()
> >   videobuf2/videobuf2-dma-sg.c: Convert to use vm_map_pages()
> >   xen/gntdev.c: Convert to use vm_map_pages()
> >   xen/privcmd-buf.c: Convert to use vm_map_pages_zero()
>
> Is it fine to take these patches into mm tree for regression ?

v4 of this series has not received any further comments/ kbuild error
in last 8 weeks (including
the previously posted v4).

Any suggestion, if it safe to take these changes through mm tree ? or any
other tree is preferred ?

>
> >
> >  arch/arm/mm/dma-mapping.c                          | 22 ++----
> >  drivers/firewire/core-iso.c                        | 15 +---
> >  drivers/gpu/drm/rockchip/rockchip_drm_gem.c        | 17 +----
> >  drivers/gpu/drm/xen/xen_drm_front_gem.c            | 18 ++---
> >  drivers/iommu/dma-iommu.c                          | 12 +---
> >  drivers/media/common/videobuf2/videobuf2-core.c    |  7 ++
> >  .../media/common/videobuf2/videobuf2-dma-contig.c  |  6 --
> >  drivers/media/common/videobuf2/videobuf2-dma-sg.c  | 22 ++----
> >  drivers/xen/gntdev.c                               | 11 ++-
> >  drivers/xen/privcmd-buf.c                          |  8 +--
> >  include/linux/mm.h                                 |  4 ++
> >  mm/memory.c                                        | 81 ++++++++++++++++++++++
> >  mm/nommu.c                                         | 14 ++++
> >  13 files changed, 134 insertions(+), 103 deletions(-)
> >
> > --
> > 1.9.1
> >
