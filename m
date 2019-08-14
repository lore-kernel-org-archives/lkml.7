Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B5AC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 01:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D82D20842
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 01:36:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="xIgh+scF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbfHNBgp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 21:36:45 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46314 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbfHNBgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 21:36:45 -0400
Received: by mail-ot1-f67.google.com with SMTP id z17so60219444otk.13
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 18:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T79FqmE4omVh8KvKRr9Ji1NiYF1jwWoBp2a4S3wYfUE=;
        b=xIgh+scFlFZaMbyoMV1IkOIlX/nYvIEVasdGR+4vgGYHLeiewku5FhfmMF/u82KCRX
         MSErqkN/DgEQsqSvd4X7p+lT0oNexeTRv86qeokYYdUP0BOeLCGjOX9Sd/JWMKEQoS6g
         PwX/lC9BqsULCOBZLAvJixho5nREePWl5uOPg2jE9g0vQx3cZII3Ilx0J7oUMkt8HCC0
         jWbfmfOLvoT/mbKLqBnkK54WVKRXTWevpUb9oXR/7WiAJXekPzezsPzhCgDd3il+q6/O
         WYUwutEc9PedlqPBB8PVWWm7kSFEs6Fj841/WMzEqYowG5ogcen99NisCiTcA9kQF5+G
         eqrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T79FqmE4omVh8KvKRr9Ji1NiYF1jwWoBp2a4S3wYfUE=;
        b=fY7OYkhynjBbY+QCm27vUNXSSuc12H0XW+cpfJgKpRmXIc7HTWorpTnHTqx3qbtsEO
         zcoc+Xq7RD00XwBnqkBcr75LRUo+dCulvP6LT3sPZP6YBy8PMDt1GccWD78BPZqkYny+
         oaNhCAGdobdpRZ4q6ofOj9/1tmtzTEXTHMqgdTVPLKBg88HIE2lyyPCx1YpPhEVC/Khk
         E6NhlCBX/Wy2OL1Am4xdshbaGUNbkTJoEbS0nFcrpP/ade+CwuYDaU1nDQupbI/jEyJ7
         NjjfT4zIaWmEau/YEr2d5Fal+R3bxXKgkBB1T0H65icwZZn91C6b24Xcx+yICaicens1
         P4mg==
X-Gm-Message-State: APjAAAU3BrS/eKbR7QQuu2GV7jUBVDPtr34jjReGAuYy8mhMevSi9+PH
        jPYlx92kDlQHWQ7LBKdJBaYITFR/EEiQRJBALHB9Ug==
X-Google-Smtp-Source: APXvYqyFhSP3HBfgQ2MsiomdR7DRqtrfZ8oKVdlDOpd867Al47Dg9XQhd7rDLmPFJUa0Wi698T8sKjV8Y2VXZELxn2I=
X-Received: by 2002:a9d:5f13:: with SMTP id f19mr28233915oti.207.1565746604730;
 Tue, 13 Aug 2019 18:36:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190806160554.14046-1-hch@lst.de> <20190806160554.14046-5-hch@lst.de>
 <20190807174548.GJ1571@mellanox.com> <CAPcyv4hPCuHBLhSJgZZEh0CbuuJNPLFDA3f-79FX5uVOO0yubA@mail.gmail.com>
 <20190808065933.GA29382@lst.de>
In-Reply-To: <20190808065933.GA29382@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 13 Aug 2019 18:36:33 -0700
Message-ID: <CAPcyv4hMUzw8vyXFRPe2pdwef0npbMm9tx9wiZ9MWkHGhH1V6w@mail.gmail.com>
Subject: Re: [PATCH 04/15] mm: remove the pgmap field from struct hmm_vma_walk
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
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

On Wed, Aug 7, 2019 at 11:59 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Wed, Aug 07, 2019 at 11:47:22AM -0700, Dan Williams wrote:
> > > Unrelated to this patch, but what is the point of getting checking
> > > that the pgmap exists for the page and then immediately releasing it?
> > > This code has this pattern in several places.
> > >
> > > It feels racy
> >
> > Agree, not sure what the intent is here. The only other reason call
> > get_dev_pagemap() is to just check in general if the pfn is indeed
> > owned by some ZONE_DEVICE instance, but if the intent is to make sure
> > the device is still attached/enabled that check is invalidated at
> > put_dev_pagemap().
> >
> > If it's the former case, validating ZONE_DEVICE pfns, I imagine we can
> > do something cheaper with a helper that is on the order of the same
> > cost as pfn_valid(). I.e. replace PTE_DEVMAP with a mem_section flag
> > or something similar.
>
> The hmm literally never dereferences the pgmap, so validity checking is
> the only explanation for it.
>
> > > +               /*
> > > +                * We do put_dev_pagemap() here so that we can leverage
> > > +                * get_dev_pagemap() optimization which will not re-take a
> > > +                * reference on a pgmap if we already have one.
> > > +                */
> > > +               if (hmm_vma_walk->pgmap)
> > > +                       put_dev_pagemap(hmm_vma_walk->pgmap);
> > > +
> >
> > Seems ok, but only if the caller is guaranteeing that the range does
> > not span outside of a single pagemap instance. If that guarantee is
> > met why not just have the caller pass in a pinned pagemap? If that
> > guarantee is not met, then I think we're back to your race concern.
>
> It iterates over multiple ptes in a non-huge pmd.  Is there any kind of
> limitations on different pgmap instances inside a pmd?  I can't think
> of one, so this might actually be a bug.

Section alignment constraints somewhat save us here. The only example
I can think of a PMD not containing a uniform pgmap association for
each pte is the case when the pgmap overlaps normal dram, i.e. shares
the same 'struct memory_section' for a given span. Otherwise, distinct
pgmaps arrange to manage their own exclusive sections (and now
subsections as of v5.3). Otherwise the implementation could not
guarantee different mapping lifetimes.

That said, this seems to want a better mechanism to determine "pfn is
ZONE_DEVICE".
