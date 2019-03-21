Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D5AC4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 23:02:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85EB021917
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 23:02:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DH0vdrW5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727248AbfCUXCV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 19:02:21 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41809 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbfCUXCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 19:02:20 -0400
Received: by mail-qt1-f196.google.com with SMTP id w30so532445qta.8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 16:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jr0o9aAH8U2i6K1qdS9XGG6vuPudU722Wp+0qgcH1UY=;
        b=DH0vdrW5HrWLC2m5DWcl3u7lzhGbcHNbP5YBsYeIODLg2teReTwDMbqQrWQthtoDKc
         XtyNGw98Bbu0m0uKzfH/bJAd7ONWR/ITjtyU3P5v7Lscw3cyGdhNQgIKrPe25WDzTmYj
         IehzBxhSRxRtSwVAZYasYBxbHn5VjtWXuUVR6S8SwxxtnBqEDplp30k4y4vAPfktIpC6
         8Iypy3RyHoF5soUPEx6P6iVi1iy1YdQjJO3em1xqQo0pk9QkNQ/Vt3tSWv3eMm6exLWv
         c+4Q4Fwcv1qIqinza5RcQ6/3Cfocpm/n37fjEQSicvvMLSY/q2R0Sb+9jq2c6e/gMf9c
         IlrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jr0o9aAH8U2i6K1qdS9XGG6vuPudU722Wp+0qgcH1UY=;
        b=LWx0Z3Js9Idd2nTNyRHPdHdAGa2iZmasIa1kozAblgkYHIXfHBKxq9R5qlNh8Yetqu
         A/iJNlikV4Z78I8JzwZXu6urXGpRq0qSBDJLyJ4o0aM6ErEvZkGPoHqGgSEMxO0vs50a
         qVu5m0g5ljZs3aVp3GtrKTbZmk4M1gXE6f5C+EokW3e+t3t8MT7OLtFHRi2PNKWwz0bT
         BsqeqD8uKcn825kXt9nvMm9WVvUPecbFs2ts9BOWoJ3CxlIXHDbI0rqT++hA9Ug5xC6l
         OY9fZlNpsIw4dvHyutoPuwQDxytWUwNEYoiI1D3h7g0+YUyByF5P9G8BklOl2OBPH6Tu
         N01w==
X-Gm-Message-State: APjAAAUj3nM9Gk6eIvM3wRjAYRHZV56pw+7uoSohzq+n/2fZzsVWtTOa
        z0MmUlbLlSTeHQZOgbQQ1sY7bD9U7H/NYMK4DCs=
X-Google-Smtp-Source: APXvYqxHxi89Srq1zwUqJV8b9yrJ78B4HghLbO4qcrhP/PA7s1rCJ8Lw7BQMe1FVovIdbxt6bxn1cWSIq7iH0hV7Bjg=
X-Received: by 2002:a0c:ea4f:: with SMTP id u15mr5454069qvp.133.1553209339794;
 Thu, 21 Mar 2019 16:02:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190321200157.29678-1-keith.busch@intel.com> <5B5EFBC2-2979-4B9F-A43A-1A14F16ACCE1@nvidia.com>
 <20190321223706.GA29817@localhost.localdomain>
In-Reply-To: <20190321223706.GA29817@localhost.localdomain>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 21 Mar 2019 16:02:07 -0700
Message-ID: <CAHbLzkrLyG-j8kRrrQ==4Y4LDDLubvXMF88muyzXWAQWKw1ZSw@mail.gmail.com>
Subject: Re: [PATCH 0/5] Page demotion for memory reclaim
To:     Keith Busch <keith.busch@intel.com>
Cc:     Zi Yan <ziy@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, linux-nvdimm@lists.01.org,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        John Hubbard <jhubbard@nvidia.com>,
        Michal Hocko <mhocko@suse.com>,
        David Nellans <dnellans@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 3:36 PM Keith Busch <keith.busch@intel.com> wrote:
>
> On Thu, Mar 21, 2019 at 02:20:51PM -0700, Zi Yan wrote:
> > 1. The name of =E2=80=9Cpage demotion=E2=80=9D seems confusing to me, s=
ince I thought it was about large pages
> > demote to small pages as opposite to promoting small pages to THPs. Am =
I the only
> > one here?
>
> If you have a THP, we'll skip the page migration and fall through to
> split_huge_page_to_list(), then the smaller pages can be considered,
> migrated and reclaimed individually. Not that we couldn't try to migrate
> a THP directly. It was just simpler implementation for this first attempt=
.
>
> > 2. For the demotion path, a common case would be from high-performance =
memory, like HBM
> > or Multi-Channel DRAM, to DRAM, then to PMEM, and finally to disks, rig=
ht? More general
> > case for demotion path would be derived from the memory performance des=
cription from HMAT[1],
> > right? Do you have any algorithm to form such a path from HMAT?
>
> Yes, I have a PoC for the kernel setting up a demotion path based on
> HMAT properties here:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/kbusch/linux.git/commit=
/?h=3Dmm-migrate&id=3D4d007659e1dd1b0dad49514348be4441fbe7cadb
>
> The above is just from an experimental branch.
>
> > 3. Do you have a plan for promoting pages from lower-level memory to hi=
gher-level memory,
> > like from PMEM to DRAM? Will this one-way demotion make all pages sink =
to PMEM and disk?
>
> Promoting previously demoted pages would require the application do
> something to make that happen if you turn demotion on with this series.
> Kernel auto-promotion is still being investigated, and it's a little
> trickier than reclaim.

Just FYI. I'm currently working on a patchset which tries to promotes
page from second tier memory (i.e. PMEM) to DRAM via NUMA balancing.
But, NUMA balancing can't deal with unmapped page cache, they have to
be promoted from different path, i.e. mark_page_accessed().

And, I do agree with Keith, promotion is definitely trickier than
reclaim since kernel can't recognize "hot" pages accurately. NUMA
balancing is still corse-grained and inaccurate, but it is simple. If
we would like to implement more sophisticated algorithm, in-kernel
implementation might be not a good idea.

Thanks,
Yang

>
> If it sinks to disk, though, the next access behavior is the same as
> before, without this series.
>
> > 4. In your patch 3, you created a new method migrate_demote_mapping() t=
o migrate pages to
> > other memory node, is there any problem of reusing existing migrate_pag=
es() interface?
>
> Yes, we may not want to migrate everything in the shrink_page_list()
> pages. We might want to keep a page, so we have to do those checks first.=
 At
> the point we know we want to attempt migration, the page is already
> locked and not in a list, so it is just easier to directly invoke the
> new __unmap_and_move_locked() that migrate_pages() eventually also calls.
>
> > 5. In addition, you only migrate base pages, is there any performance c=
oncern on migrating THPs?
> > Is it too costly to migrate THPs?
>
> It was just easier to consider single pages first, so we let a THP split
> if possible. I'm not sure of the cost in migrating THPs directly.
>
