Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDCEDC282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 16:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1DE520989
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 16:56:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="tFbxiFCj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731474AbfDEQ4f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 12:56:35 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:33174 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbfDEQ4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 12:56:34 -0400
Received: by mail-oi1-f196.google.com with SMTP id e5so5460998oii.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 09:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xavCft+C6hfoU6dVK4RbtLhBzX2Anxg99S9rWxDEYx0=;
        b=tFbxiFCj5OvH6SJQqvHiAcjrMt5420iIjxgkILb1RM44b50Hjp33zCOaEC5xyj3KqT
         5Ll2LohthpbLBhxt1bJa1rwmN/4K2IB2YEcqVqbEn/DSpS59gBFy/B/hc0eFUDxaPu9J
         N884im08a3qquWjvqFxOvDe63X8T4h3IQ6v6JirVrBDd43mUL4bxO4y85XdfhPqmgAnF
         aCCjQFKNmXTdrMkkLZmfSV9N+S7bwwBVl+HNgCZdUE8s2s0JdEZ8gV0JEOOL5oqaEG3S
         U9DMqbfD68OfH3E4iYFyo8jmWEMK5rh8fNOAW1y8f+gy/8fGTWo4JTUyepMASxcIvC1Y
         wMfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xavCft+C6hfoU6dVK4RbtLhBzX2Anxg99S9rWxDEYx0=;
        b=jACkhEgRkQx5a74ddO2ssWAj2RHZZjQj5AyPhaUNQaE5aYGHEPyuCehY+ysTwCzXAe
         IbigdRxbXZsOEhErfjcCnWxkN7YaTIqVi9ezDIU4MIKjy9agiQInOzRfLR5P/Rs174wd
         d23q3FXn1eDOprMvmwPP5ayf87HPKfn3tn2hEkWNn1qvPMk3wkJtionRd1P+XXuZIv0m
         ckIBw0SVq7QXXRbV6f7ZNsu5w7LCgdVzZPOpiUU7yONqXUUtEUqqSOiJOw6KBn1sNspF
         9X6hYqHagb/5mAqYET2SRuYTWi801bW+/Y2ufv8NFcXgZiLGNYq1hoB+7dkneaUSzvNW
         9qmw==
X-Gm-Message-State: APjAAAVO56YW72KJRH+0t0i8t3WbdZ21EMkKt9mLOQK8tZcbtMdQlOZk
        oPdMDuH/dLPRJbfwjJcT6RrLnrjGn9vksaQjFyNbWQ==
X-Google-Smtp-Source: APXvYqwBHpXfBFhHch+BoQ2/9YwlCAStfJv2kGHIns1Jas0uMBB5rQNTCvAIXmb/6bBYetz/3sIH2fwI0z826ndqqUI=
X-Received: by 2002:aca:e64f:: with SMTP id d76mr8406772oih.105.1554483393559;
 Fri, 05 Apr 2019 09:56:33 -0700 (PDT)
MIME-Version: 1.0
References: <155440490809.3190322.15060922240602775809.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155440492988.3190322.4475460421334178449.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190405121857.0000718a@huawei.com> <CAPcyv4hpKkWm0x2jecvmtLNgmwUnAZn3jM_9sKyBAUFaRLj=cQ@mail.gmail.com>
 <20190405172342.00006a56@huawei.com>
In-Reply-To: <20190405172342.00006a56@huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 5 Apr 2019 09:56:22 -0700
Message-ID: <CAPcyv4hxBFcJKbVVgNiE4UYXZS4XY9hfE8W9mN+VrcWS9AvJLw@mail.gmail.com>
Subject: Re: [RFC PATCH 4/5] acpi/hmat: Register special purpose memory as a device
To:     Jonathan Cameron <jonathan.cameron@huawei.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Keith Busch <keith.busch@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        X86 ML <x86@kernel.org>, Linux MM <linux-mm@kvack.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 5, 2019 at 9:24 AM Jonathan Cameron
<jonathan.cameron@huawei.com> wrote:
>
> On Fri, 5 Apr 2019 08:43:03 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
>
> > On Fri, Apr 5, 2019 at 4:19 AM Jonathan Cameron
> > <jonathan.cameron@huawei.com> wrote:
> > >
> > > On Thu, 4 Apr 2019 12:08:49 -0700
> > > Dan Williams <dan.j.williams@intel.com> wrote:
> > >
> > > > Memory that has been tagged EFI_SPECIAL_PURPOSE, and has performance
> > > > properties described by the ACPI HMAT is expected to have an application
> > > > specific consumer.
> > > >
> > > > Those consumers may want 100% of the memory capacity to be reserved from
> > > > any usage by the kernel. By default, with this enabling, a platform
> > > > device is created to represent this differentiated resource.
> > > >
> > > > A follow on change arranges for device-dax to claim these devices by
> > > > default and provide an mmap interface for the target application.
> > > > However, if the administrator prefers that some or all of the special
> > > > purpose memory is made available to the core-mm the device-dax hotplug
> > > > facility can be used to online the memory with its own numa node.
> > > >
> > > > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > > > Cc: Len Brown <lenb@kernel.org>
> > > > Cc: Keith Busch <keith.busch@intel.com>
> > > > Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > >
> > > Hi Dan,
> > >
> > > Great to see you getting this discussion going so fast and in
> > > general the approach makes sense to me.
> > >
> > > I'm a little confused why HMAT has anything to do with this.
> > > SPM is defined either via the attribute in SRAT SPA entries,
> > > EF_MEMORY_SP or via the EFI memory map.
> > >
> > > Whether it is in HMAT or not isn't all that relevant.
> > > Back in the days of the reservation hint (so before yesterday :)
> > > it was relevant obviously but that's no longer true.
> > >
> > > So what am I missing?
> >
> > It's a good question, and an assumption I should have explicitly
> > declared in the changelog. The problem with EFI_MEMORY_SP is the same
> > as the problem with the EfiPersistentMemory type, it isn't precise
> > enough on its own for the kernel to delineate 'type' or
> > device/replaceable-unit boundaries. For example, I expect one
> > EFI_MEMORY_SP range of a specific type may be contiguous with another
> > range of a different type. Similar to the NFIT there is no requirement
> > in the specification that platform firmware inject multiple range
> > entries. Instead that precision is left to the SRAT + HMAT, or the
> > NFIT in the case of PMEM.
>
> Absolutely, as long as they are all SPM, they could be anywhere in
> the system.
>
> >
> > Conversely, and thinking through this a bit more, if a memory range is
> > "special", but the platform fails to enumerate it in HMAT I think
> > Linux should scream loudly that the firmware is broken and leave the
> > range alone. The "scream loudly" piece is missing in the current set,
> > but the "leave the range alone" functionality is included.
>
> I am certainly keen on screaming if the various entries are inconsistent
> but am not sure they necessarily are here.
>
> So there are a couple of ways we could get an SPM range defined.
> The key thing here is that firmware should be attempting to describe
> what it has to some degree somewhere.  If not it won't get a good
> result ;)  So if there is no SRAT then you are on your own. SCREAM!
>
> 1. Directly in the memory map.  If there is no other information then
>    tough luck the kernel can only sensibly handle it as one device.
>    Or not at all, which seems like a reasonable decision to me.
>    SCREAM
>
> 2. In memory map + a proximity domain entry in SRAT.  Given memory
>    with different characteristics should be in different proximity
>    domains anyway - this should be fairly precise. The slight snag
>    here is that the fine grained nature of SRAT is actually a side
>    effect of HMAT, so not sure well platforms have traditional
>    describe their more subtle differences.
>
> 3. In NFIT as NFIT SPA carries the memory attribute.  Not sure if
>    we should scream if this disagrees with the memory map.
>
> 4. In HMAT?  Now this changed in ACPI 6.3 to clean up the 'messy'
>    prior relationship between it and SRAT.  Now HMAT no longer has
>    memory address ranges as you observed.  That means, to describe
>    properties of memory, it has to use the proximity domains of
>    SRAT.  It provides lots of additional info about those domains
>    but it is SRAT that defines them.
>
> So I would argue that HMAT itself doesn't tell us anything useful.
> SRAT certainly does though so I think this should be coming from
> SRAT (or NFIT as that also defines the required precision)

I agree, yes, SRAT by itself is sufficient for this "precision"
concern. However, do we, core Linux developers, really want to
encourage platform vendors that they can ignore deploying HMAT data
and get Linux to honor that sub-case for EFI_MEMORY_SP? My personal
experience is that platform firmware will take advantage of almost any
opportunity to minimize the data it provides to the OS. The only hard
lever Linux has to encourage platform firmware to give complete data
is to decline to support configurations that have incomplete data.
