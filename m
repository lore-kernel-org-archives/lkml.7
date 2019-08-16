Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 197FAC3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 03:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5C97206C1
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 03:55:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="UuG8eAXm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbfHPDy7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 23:54:59 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:42318 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbfHPDy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 23:54:59 -0400
Received: by mail-oi1-f194.google.com with SMTP id o6so3850796oic.9
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 20:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9WkJUtJNJm1DYJ7j8k6+uYXDk5DFrU4ee4of/nPzT1s=;
        b=UuG8eAXmgl5Ru6cZIUQval2jXosANzNztFowRGWtct0jh7nOw1RR8555FMU+nuNAIP
         hmNhO7WbphDv2TTdAW10rg5waTsTbjLcnYhBRfr41484IBkk2zzz7p9gLfQtEo8k3k8m
         D+7tNjsByy4DJfUxtdhaoGs8AvT+4s1lX1R/mEHDukPk8BI8cXzKSG1fEF6eZggnI3P9
         plDLFIrc97OcWruXoxlanf1L/2EonM9E/kePByjuPM4mI2WrapZLGn0IUw/ARkxljJQC
         NvoZCpeoatjh6hV+PeNEIdEkVlMp/Ery6H3K0EazoowLKweCQYqY52AWrRnf6LANfgT1
         2WbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9WkJUtJNJm1DYJ7j8k6+uYXDk5DFrU4ee4of/nPzT1s=;
        b=T/0yow69egK0aHZWfkVulmz50uA3ycftliRL7QWgg1TPHH/eqgB4XG9vcQfV7ygLqF
         VivIUsrTZc1b+nZD4zxx+/tYQmFv964EzmMvVkv/rAR+93VH9+TspjYAgPHP9GPJeNd0
         G4h5HphV5y2WY6tgQzymyfJqYKWeAIb6NgBM3QgsJ+ZJuTVPzOywrXc3+zKOQzGzb5Z7
         bLRYCFq6KBfpk7YqMRtnN3yioa1FehWfa0I/rXx3/HMPnruhhVdg281g5deQSOQQc2sI
         ReNl9jSzTJ+W6yjgv/T2TdBqd/ls1+vK4rswOb7Wq/YGVOVVZUj9Hc6rFaSZdTqTK/Q8
         vFIA==
X-Gm-Message-State: APjAAAW5lksKSkRAfAAf5TrXeLazNJdqu7aj2an7QTYNcOiVLLRQi4oN
        uyCQFxfjNO81RngN2NVnutu44dj35A2GcwN5qqKO6A==
X-Google-Smtp-Source: APXvYqw0v1bupBcNpuGMzOb6gFqgIVMWL20JZ4dMzSV9AZI53fkTfPLzczhfySURu9PlRzbqDeiTYIjA7bTKAQW3IH8=
X-Received: by 2002:aca:be43:: with SMTP id o64mr3905357oif.149.1565927698048;
 Thu, 15 Aug 2019 20:54:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190814073854.GA27249@lst.de> <20190814132746.GE13756@mellanox.com>
 <CAPcyv4g8usp8prJ+1bMtyV1xuedp5FKErBp-N8+KzR=rJ-v0QQ@mail.gmail.com>
 <20190815180325.GA4920@redhat.com> <CAPcyv4g4hzcEA=TPYVTiqpbtOoS30ahogRUttCvQAvXQbQjfnw@mail.gmail.com>
 <20190815194339.GC9253@redhat.com> <CAPcyv4jid8_=-8hBpn_Qm=c4S8BapL9B9RGT7e9uu303yH=Yqw@mail.gmail.com>
 <20190815203306.GB25517@redhat.com> <20190815204128.GI22970@mellanox.com>
 <CAPcyv4j_Mxbw+T+yXTMdkrMoS_uxg+TXXgTM_EPBJ8XfXKxytA@mail.gmail.com> <20190816004053.GB9929@mellanox.com>
In-Reply-To: <20190816004053.GB9929@mellanox.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 15 Aug 2019 20:54:46 -0700
Message-ID: <CAPcyv4gMPVmY59aQAT64jQf9qXrACKOuV=DfVs4sNySCXJhkdA@mail.gmail.com>
Subject: Re: [PATCH 04/15] mm: remove the pgmap field from struct hmm_vma_walk
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Jerome Glisse <jglisse@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Ben Skeggs <bskeggs@redhat.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2019 at 5:41 PM Jason Gunthorpe <jgg@mellanox.com> wrote:
>
> On Thu, Aug 15, 2019 at 01:47:12PM -0700, Dan Williams wrote:
> > On Thu, Aug 15, 2019 at 1:41 PM Jason Gunthorpe <jgg@mellanox.com> wrote:
> > >
> > > On Thu, Aug 15, 2019 at 04:33:06PM -0400, Jerome Glisse wrote:
> > >
> > > > So nor HMM nor driver should dereference the struct page (i do not
> > > > think any iommu driver would either),
> > >
> > > Er, they do technically deref the struct page:
> > >
> > > nouveau_dmem_convert_pfn(struct nouveau_drm *drm,
> > >                          struct hmm_range *range)
> > >                 struct page *page;
> > >                 page = hmm_pfn_to_page(range, range->pfns[i]);
> > >                 if (!nouveau_dmem_page(drm, page)) {
> > >
> > >
> > > nouveau_dmem_page(struct nouveau_drm *drm, struct page *page)
> > > {
> > >         return is_device_private_page(page) && drm->dmem == page_to_dmem(page)
> > >
> > >
> > > Which does touch 'page->pgmap'
> > >
> > > Is this OK without having a get_dev_pagemap() ?
> > >
> > > Noting that the collision-retry scheme doesn't protect anything here
> > > as we can have a concurrent invalidation while doing the above deref.
> >
> > As long take_driver_page_table_lock() in Jerome's flow can replace
> > percpu_ref_tryget_live() on the pagemap reference. It seems
> > nouveau_dmem_convert_pfn() happens after:
> >
> >                         mutex_lock(&svmm->mutex);
> >                         if (!nouveau_range_done(&range)) {
> >
> > ...so I would expect that to be functionally equivalent to validating
> > the reference count.
>
> Yes, OK, that makes sense, I was mostly surprised by the statement the
> driver doesn't touch the struct page..
>
> I suppose "doesn't touch the struct page out of the driver lock" is
> the case.
>
> However, this means we cannot do any processing of ZONE_DEVICE pages
> outside the driver lock, so eg, doing any DMA map that might rely on
> MEMORY_DEVICE_PCI_P2PDMA has to be done in the driver lock, which is
> a bit unfortunate.

Wouldn't P2PDMA use page pins? Not needing to hold a lock over
ZONE_DEVICE page operations was one of the motivations for plumbing
get_dev_pagemap() with a percpu-ref.
