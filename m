Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5CBEC4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 11:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88765218DE
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 11:53:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="mz4MBWiu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404472AbfIILxp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 07:53:45 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:33214 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404309AbfIILxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 07:53:45 -0400
Received: by mail-oi1-f194.google.com with SMTP id e12so9963209oie.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 04:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ycSCbtpblwJD3MpI8N6ImHg84InwzDYLHFYqOZ8niWY=;
        b=mz4MBWiu4fN9MF7a/rAaPguBBR4GIwROCt/bPq/ftvjbFNlUohn4A+aX2JuFVp8nhE
         LgjSh23msmWNDMpkK3M04q3kajzcWmF+YY7dnghYFjdplKklAbyZAJHFQCnQcoljLYZr
         glZE6kc3dW8xL2jsOTeR4InXSCB726pZFI9hSEw/vbj4NkxP9OdvCBvQZPu8Ve+OQ9d2
         oArur1zB+gEzQgZv2UGF3/6XDlFQUPlHYn0oB+Kv8AAlnIq8leJFSVmyrOHrmycIKywh
         7RuBgbmXYFtBIb0WivkB14XAsAxBVoRNn5/SgaIA4vOGJq+5qO/2POs73WMzBuciPBqf
         wtOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ycSCbtpblwJD3MpI8N6ImHg84InwzDYLHFYqOZ8niWY=;
        b=ss7rfoLWIcC8HP6rRD48S35LscLZpaKEGVDdVUh2F8KzC0Sk2SNOdF65YMsdkoxrkb
         ijJttLvL8ImtedVz9ocqJr2v3s5qxXT8laLWVwoGvvFrsj9oE4AlZpfAS2H3N9xQoH8y
         e0A7gGKhdpreM0agyZ6aZIatBGxFzDEUToHyWowQJILKPk/CgkPSY4wZUYrtSLoCpbUr
         PB2dfSFh46tOz42grRVbHZCMNCeRT3DIBndkZoZfEwNRUx0v8BJNv+xdzUMysWvL0UD5
         ubhjJKjSFvZ+qJvWxNGSZsHkE4LrqRCPbil0PTZREFYsdGPUt3VpPhR5A6SW+udWij2m
         jMFw==
X-Gm-Message-State: APjAAAUTho0vI8z0aSgheBu2VnmyBcLM319nyRyzlZCcKTBD1fD2XGIo
        SSNN1EqJj9zTtroGvxUM3bFffhLsC4JJu9b4Fr76dg==
X-Google-Smtp-Source: APXvYqwrT1eCBweLj5k+A+JU3QKLfGH+67wPQLvMlZaOKJJETfTmHgD3lUkF7MQS2lqwaC5MLUaCG334nbzuW3KyYa0=
X-Received: by 2002:aca:be43:: with SMTP id o64mr17395031oif.149.1568030024545;
 Mon, 09 Sep 2019 04:53:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190906081027.15477-1-t-fukasawa@vx.jp.nec.com>
 <b7732a55-4a10-2c1d-c2f5-ca38ee60964d@redhat.com> <e762ee45-43e3-975a-ad19-065f07d1440f@vx.jp.nec.com>
 <40a1ce2e-1384-b869-97d0-7195b5b47de0@redhat.com> <6a99e003-e1ab-b9e8-7b25-bc5605ab0eb2@vx.jp.nec.com>
 <e4e54258-e83b-cf0b-b66e-9874be6b5122@redhat.com> <f9b10653-949b-64a6-6539-a32bd980edb9@redhat.com>
In-Reply-To: <f9b10653-949b-64a6-6539-a32bd980edb9@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 9 Sep 2019 04:53:33 -0700
Message-ID: <CAPcyv4gA4mcDEPeCFokn_jy5gX62cK0U40EzL7M8c0iDO7U7bg@mail.gmail.com>
Subject: Re: [RFC PATCH v2] mm: initialize struct pages reserved by
 ZONE_DEVICE driver.
To:     David Hildenbrand <david@redhat.com>
Cc:     Toshiki Fukasawa <t-fukasawa@vx.jp.nec.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "adobriyan@gmail.com" <adobriyan@gmail.com>,
        "hch@lst.de" <hch@lst.de>,
        "longman@redhat.com" <longman@redhat.com>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "mst@redhat.com" <mst@redhat.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Junichi Nomura <j-nomura@ce.jp.nec.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 9, 2019 at 1:11 AM David Hildenbrand <david@redhat.com> wrote:
[..]
> >> It seems that SECTION_IS_ONLINE and SECTION_MARKED_PRESENT can be used to
> >> distinguish uninitialized struct pages if we can apply them to ZONE_DEVICE,
> >> but that is no longer necessary with this approach.
> >
> > Let's take a step back here to understand the issues I am aware of. I
> > think we should solve this for good now:
> >
> > A PFN walker takes a look at a random PFN at a random point in time. It
> > finds a PFN with SECTION_MARKED_PRESENT && !SECTION_IS_ONLINE. The
> > options are:
> >
> > 1. It is buddy memory (add_memory()) that has not been online yet. The
> > memmap contains garbage. Don't access.
> >
> > 2. It is ZONE_DEVICE memory with a valid memmap. Access it.
> >
> > 3. It is ZONE_DEVICE memory with an invalid memmap, because the section
> > is only partially present: E.g., device starts at offset 64MB within a
> > section or the device ends at offset 64MB within a section. Don't access it.
> >
> > 4. It is ZONE_DEVICE memory with an invalid memmap, because the memmap
> > was not initialized yet. memmap_init_zone_device() did not yet succeed
> > after dropping the mem_hotplug lock in mm/memremap.c. Don't access it.
> >
> > 5. It is reserved ZONE_DEVICE memory ("pages mapped, but reserved for
> > driver") with an invalid memmap. Don't access it.
> >
> > I can see that your patch tries to make #5 vanish by initializing the
> > memmap, fair enough. #3 and #4 can't be detected. The PFN walker could
> > still stumble over uninitialized memmaps.
> >
>
> FWIW, I thinkg having something like pfn_zone_device(), similarly
> implemented like pfn_zone_device_reserved() could be one solution to
> most issues.

I've been thinking of a replacement for PTE_DEVMAP with section-level,
or sub-section level flags. The section-level flag would still require
a call to get_dev_pagemap() to validate that the pfn is not section in
the subsection case which seems to be entirely too much overhead. If
ZONE_DEVICE is to be a first class citizen in pfn walkers I think it
would be worth the cost to double the size of subsection_map and to
identify whether a sub-section is ZONE_DEVICE, or not.

Thoughts?
