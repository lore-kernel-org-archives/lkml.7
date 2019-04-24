Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6930AC282E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36AFF20652
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:08:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="n35r7HLE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388851AbfDXSIF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 14:08:05 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:41002 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387633AbfDXSIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 14:08:04 -0400
Received: by mail-oi1-f194.google.com with SMTP id v7so15051374oie.8
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 11:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8q9yPvjgU1Dmc3BqSRsYFTk9ExzQt5bmVmZcuF82af8=;
        b=n35r7HLELoguC4+CDnNmcyHD93QJUumktU3TTYTT85K1K93kZndcMpl7JZesyoPmNR
         jExL9hZ2+RXj4TANemwSx12DYO6BcMPdE5APBpgYQAQodtB0+JR+vmO82L0DVaUiA6Qo
         quxRikkZsR9RQUFUFtxbtBnY+a1yYn2QZqOnZ4yPEh2uZl2+Bl3jQihIzoRRIP2TqP3O
         WY3tx1QeXl1tl8V14appaRj2bC+66o204Bey5C/7QXCdJJv7BONvI7a+8z8BLSVRI4oB
         T8P5fgoJKdXi2KNELRKXOGkWm5p5MiNBceHQv5mw5z2c4ID9RPWjLk0oy43G3O5Q+zNz
         zG7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8q9yPvjgU1Dmc3BqSRsYFTk9ExzQt5bmVmZcuF82af8=;
        b=GAaqfooqv8ZIsebsItwlzXr7nje+fYhKdPZOWIFzj1DmC5aeareDLDOnb4wGVctutZ
         hsK/XbtQVPQ0USQTV0N5YKL9QncvEXT9FoIIz9zyaLthbwBZfW5VJXNOyz+DbnpXX5y1
         kfrNzQNO5OV7dFZ9dDxSKBrlX4tfBVbKy7fCHWRIpcBFZMht+Wmm5PUT+V7AYyn7XN7a
         8uR7oZC57VSHDsZkvdzXXEHLIPR34olvH32sOdvdNUq+v6iRw1/u1EAb5KNmHZHQT5mQ
         J0Ac/vHue3keZXyeyfSXXTiFJuW/9XK2Mt4KhX41BPGSaH0455V3JJ0cpJVxHy3Gdh5o
         d1rw==
X-Gm-Message-State: APjAAAVif+msbeIIfRG/ygNd7KJp41zTFQKGcFJl8EY/sjWkiWk0qc/7
        7bO2MC1fIuH/yfNlkIbJP30ZpHWlKKVBjMWFAKGlug==
X-Google-Smtp-Source: APXvYqwUscsee1H3tWh0LwutS4rgxqlReQCcuMcrIVSy6LAXYPTW+nyIjR2WiohPRoNbvVXrkWOUWHNWNhknw/nsrb8=
X-Received: by 2002:aca:b108:: with SMTP id a8mr297824oif.0.1556129283720;
 Wed, 24 Apr 2019 11:08:03 -0700 (PDT)
MIME-Version: 1.0
References: <155552633539.2015392.2477781120122237934.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155552636696.2015392.12612320706815016081.stgit@dwillia2-desk3.amr.corp.intel.com>
 <3dda9d08-a572-65b9-2f2f-da978a008deb@redhat.com>
In-Reply-To: <3dda9d08-a572-65b9-2f2f-da978a008deb@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 24 Apr 2019 11:07:52 -0700
Message-ID: <CAPcyv4imzm5reh7d-p4Xyt=Sdoi5WDFC6t9FgLaZVexbWfGG5Q@mail.gmail.com>
Subject: Re: [PATCH v6 06/12] mm/hotplug: Add mem-hotplug restrictions for remove_memory()
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Linux MM <linux-mm@kvack.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 2:21 PM David Hildenbrand <david@redhat.com> wrote:
>
> On 17.04.19 20:39, Dan Williams wrote:
> > Teach the arch_remove_memory() path to consult the same 'struct
> > mhp_restrictions' context as was specified at arch_add_memory() time.
> >
> > No functional change, this is a preparation step for teaching
> > __remove_pages() about how and when to allow sub-section hot-remove, and
> > a cleanup for an unnecessary "is_dev_zone()" special case.
>
> I am not yet sure if this is the right thing to do. When adding memory,
> we obviously have to specify the "how". When removing memory, we usually
> should be able to look such stuff up.

True, the implementation can just use find_memory_block(), and no need
to plumb this flag.

>
>
> >  void __remove_pages(struct zone *zone, unsigned long phys_start_pfn,
> > -                 unsigned long nr_pages, struct vmem_altmap *altmap)
> > +             unsigned long nr_pages, struct mhp_restrictions *restrictions)
> >  {
> >       unsigned long i;
> > -     unsigned long map_offset = 0;
> >       int sections_to_remove;
> > +     unsigned long map_offset = 0;
> > +     struct vmem_altmap *altmap = restrictions->altmap;
> >
> > -     /* In the ZONE_DEVICE case device driver owns the memory region */
> > -     if (is_dev_zone(zone)) {
> > -             if (altmap)
> > -                     map_offset = vmem_altmap_offset(altmap);
> > -     }
> > +     if (altmap)
> > +             map_offset = vmem_altmap_offset(altmap);
> >
>
> Why weren't we able to use this exact same hunk before? (after my
> resource deletion cleanup of course)
>
> IOW, do we really need struct mhp_restrictions here?

We don't need it. It was only the memblock info why I added the
"restrictions" argument.

> After I factor out memory device handling into the caller of
> arch_remove_memory(), also the next patch ("mm/sparsemem: Prepare for
> sub-section ranges") should no longer need it. Or am I missing something?

That patch is still needed for the places where it adds the @nr_pages
argument, but the mhp_restrictions related bits can be dropped. The
subsection_check() helper needs to be refactored a bit to not rely on
mhp_restrictions.
