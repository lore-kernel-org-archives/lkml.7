Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C9AC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 07:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF2A4206E1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 07:25:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="ka9TFfKo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfKNHZf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 02:25:35 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:46951 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbfKNHZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 02:25:35 -0500
Received: by mail-oi1-f194.google.com with SMTP id n14so4353136oie.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 23:25:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f5d5/bpHoXBtRihRqTs8DB3/xqD8D283lsRAFtLbrfY=;
        b=ka9TFfKoK65lEg8yCbO74ziezgRtQdVgpXv0yhH69HHcnCDQeoZMEx0zXoBS7PR5CR
         HUSM9ldvvNqYmMcaebJWojK6kxK8YredJDVlobIurEivs8HOFwov2jkpRQva3FuViGRf
         ZaqsOLOTzq/jVjwP4ypul0EYWEaO7bvk7hbPzNM96uv6Cgr5HBNYLPmiYoYyOFHvE9hD
         mXVwpyQKlHtexK/PvqnnO2dznfTmoig1liLGmqjelsl+RrlPIQi/2x1HOJVbWTe4SI/d
         3v/ItiNlUzTdLdfu/x+OUPTS84IMvoks4EpIT9ybpTurledVYXiFfLBuX7ocfw5Mez8k
         y+4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f5d5/bpHoXBtRihRqTs8DB3/xqD8D283lsRAFtLbrfY=;
        b=bjfyLPSWD4a9wdC/iZFbYpF8XQgLtFMGt8shdJRWwg/2YSqc3B4fGvEGfSZe55WZ8R
         H5HDSyKwvA0vPfOAfvKj4PgtIAuYL3MDcR50SDRmFeyTPSf2wq4mXm2mTQMOoT3/nUA3
         lK09mTNJVyaReYW2p6JkVZi0kTfMyJzO3ZRa4plqiNYeVB9AEXg7i0zVEl56Zt4jPXO1
         kCp8u2AhQD2WHoZ2VIGCvbchD2+MXm+8gYg8DU0ycqQNY10qDPSaOTiqORVfdZ+F5n6f
         VZP42vVgjgB+ocgr+XgW2ejVfdd+xTvWHs+IewoT3UxubbGHy5/yCtZjII9rS1HMYbuS
         5Q+w==
X-Gm-Message-State: APjAAAXPWUvz1UGSAXGVzJRQ44TlEWjMn7PX0TXpNleXhvP5W+LdEsRk
        GpSACRgxFa1y/ZYfzoj7GOpD/kkPBbRrRGJPBg2vYA==
X-Google-Smtp-Source: APXvYqyw6GUqimMOF1WKHvSfkunTVJ/My/V0dioePYkRQ/odDMDx25P6oQDKSOWhF5aoTpM0cuCpZKOnaci5mnKBdMI=
X-Received: by 2002:a05:6808:1da:: with SMTP id x26mr720739oic.149.1573716334479;
 Wed, 13 Nov 2019 23:25:34 -0800 (PST)
MIME-Version: 1.0
References: <157368992671.2974225.13512647385398246617.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20191114071903.GA26307@lst.de>
In-Reply-To: <20191114071903.GA26307@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 13 Nov 2019 23:25:23 -0800
Message-ID: <CAPcyv4iyD7f-3Ws7HpNvfNwO52CK7W-iF7Vsxv3MrGWzALsMGA@mail.gmail.com>
Subject: Re: [PATCH] mm: Cleanup __put_devmap_managed_page() vs ->page_free()
To:     Christoph Hellwig <hch@lst.de>
Cc:     John Hubbard <jhubbard@nvidia.com>, Jan Kara <jack@suse.cz>,
        Ira Weiny <ira.weiny@intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2019 at 11:19 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Wed, Nov 13, 2019 at 04:07:22PM -0800, Dan Williams wrote:
> >  static int devmap_managed_enable_get(struct dev_pagemap *pgmap)
> >  {
> > -     if (!pgmap->ops || !pgmap->ops->page_free) {
> > +     if (!pgmap->ops || (pgmap->type == MEMORY_DEVICE_PRIVATE
> > +                             && !pgmap->ops->page_free)) {
>
> I don't think this check is correct.  You only want the the ops null check
> or MEMORY_DEVICE_PRIVATE as well now, i.e.:
>
>         if (pgmap->type == MEMORY_DEVICE_PRIVATE &&
>             (!pgmap->ops || !pgmap->ops->page_free)) {
>
> > @@ -476,10 +471,17 @@ void __put_devmap_managed_page(struct page *page)
> >                * handled differently or not done at all, so there is no need
> >                * to clear page->mapping.
> >                */
> > -             if (is_device_private_page(page))
> > -                     page->mapping = NULL;
> > +             if (is_device_private_page(page)) {
> > +                     /* Clear Active bit in case of parallel mark_page_accessed */
>
> This adds a > 80 char line.  But that whole flow of the function seems
> rather odd now.
>
> Why can't we do:
>
>         if (count == 0) {
>                 __put_page(page);
>         } else if (is_device_private_page(page)) {
>                 __ClearPageActive(page);
>                 __ClearPageWaiters(page);
>
>                 mem_cgroup_uncharge(page);
>                 page->mapping = NULL;
>                 page->pgmap->ops->page_free(page);
>         } else {
>                 wake_up_var(&page->_refcount);
>         }
>

All the above looks good to me will spin a v2.

> (except for the fact that I don't get the point of calling __put_page
> on a refcount of zero, but that is separate from this patch).

That looked odd to me as well until I recalled that we did that to
simplify the pgmap reference counting.

71389703839e mm, zone_device: Replace {get, put}_zone_device_page()
with a single reference to fix pmem crash

I'll add a comment in v2.
