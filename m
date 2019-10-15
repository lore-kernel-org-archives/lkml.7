Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B120C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 19:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6B5720663
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 19:03:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="jZ3Ju6BS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389126AbfJOTDJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 15:03:09 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35773 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729150AbfJOTDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 15:03:09 -0400
Received: by mail-lj1-f196.google.com with SMTP id m7so21400890lji.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 12:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z/FruCz6goZhz2LwFFKHFfWVFx1MlrNSYnv6sunLzFo=;
        b=jZ3Ju6BSv9VcUQfmDzevMJuXapBp9ZMFgGDq+twH8OgTREViNOi8R8fx6xnxNkeE7j
         S6/fO6HaBYVu85BUYdMxN0+8WbXuvIX7ZW+axhFVu7vDdEFeTlsFtkJKtSXg1VMoJav5
         JKmCtceLLgkkFhH27lnqwZ+Lx7XQ70MCNt3GFLhKYe8lu2eJyie9KAIrvOnypWHdhcWL
         8wq8+8APKoEK96ueRIeYjG3ZARoBegexHaklkKuOJot1CHUu7hkrkJPtA6hLLC7+Xc9w
         JwOajBwSS9gnc0NKgid0Qy176ytbyw3+Bd4XktqLZC2P1pw3EoHxqP3LMOrSp5t5wpQa
         CIXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z/FruCz6goZhz2LwFFKHFfWVFx1MlrNSYnv6sunLzFo=;
        b=tt+OJmv9fENv9zG/9nuqsgDf9c6OXGweGJmh5Bw7x1kwH+/x7EZoPO0iXY0yUUuy5B
         V0BE4dfjIjMwBdl52S3PZTklfArD1zuJY5bPhms1p39ko/XAdNqLcvZwL58WQCs8bPTk
         j7khlJ0H5nDkIjXXmtN7beVlW/t95AdWBcVJVYzm85C4MacT2sehWg1v7nTSpbq4A8mI
         f0uZjka+I5xACzOT5q4BaS1qc86wpEhCHSdbift8L7Uc6iahCtFcslyoxE0oWfoe3ObU
         490aE5KGtxv8kTLcTdQIA0OS3NHsVooa7p41uI6YiKLvwUSHNo9ZHdd1byRuEmOHCH5M
         FMqQ==
X-Gm-Message-State: APjAAAU8Z5/b4ZMjlKwH5l+1PW3GS5ZrlUKRX4AoL0IAI6BrqjJYUlEm
        cwFkTwAJkZoFYpNgNMRpBKw1UUs+7X9fC2gX+fhLaQ==
X-Google-Smtp-Source: APXvYqxg/t7fa7ziqMwCKuP1ZZENtWturNVe+RQ3Qgq/bISTQHuqo9tonp6A7NWCV0VDJD/nTzdpDrS0SOi+J5MTUx4=
X-Received: by 2002:a2e:9a43:: with SMTP id k3mr22187367ljj.70.1571166185660;
 Tue, 15 Oct 2019 12:03:05 -0700 (PDT)
MIME-Version: 1.0
References: <1569885755-10947-1-git-send-email-alan.mikhak@sifive.com>
 <20191007061324.GB17978@infradead.org> <CABEDWGyovfKuXsNpfhsSCJ0sryg3EpAsaqRTHxBGC9LFM+=dww@mail.gmail.com>
 <CABEDWGxZaJp17jhd-CPqc+n9ZjYzvp63PymfMo0JVd=jzQEizQ@mail.gmail.com>
 <20191015095522.GA22551@infradead.org> <a218d5bd-93cd-2332-de95-195ccbe41995@deltatee.com>
In-Reply-To: <a218d5bd-93cd-2332-de95-195ccbe41995@deltatee.com>
From:   Alan Mikhak <alan.mikhak@sifive.com>
Date:   Tue, 15 Oct 2019 12:02:54 -0700
Message-ID: <CABEDWGwtKDB=r_pjvTvdsnwxtLof4H0ZzTwT_c6LngFLk2oAZQ@mail.gmail.com>
Subject: Re: [PATCH] scatterlist: Validate page before calling PageSlab()
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, martin.petersen@oracle.com,
        alexios.zavras@intel.com, ming.lei@redhat.com,
        gregkh@linuxfoundation.org, tglx@linutronix.de,
        Jason Gunthorpe <jgg@ziepe.ca>, christophe.leroy@c-s.fr,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2019 at 9:12 AM Logan Gunthorpe <logang@deltatee.com> wrote:
>
>
>
> On 2019-10-15 3:55 a.m., Christoph Hellwig wrote:
> > On Mon, Oct 07, 2019 at 02:13:51PM -0700, Alan Mikhak wrote:
> >>> My goal is to not modify the Linux NVMe target code at all. The NVMe
> >>> endpoint function driver currently does the work that is required.
> >
> > You will have to do some modifications, as for example in PCIe you can
> > have a n:1 relationship between SQs and CQs.  And you need to handle
> > the Create/Delete SQ/CQ commands, but not the fabrics commands.  And
> > modifying subsystems in Linux is perfectly acceptable, that is how they
> > improve.
> >
> > Do you have a pointer to your code?
> >
> >>> In my current platform, there are no page struct backing for the PCIe
> >>> memory address space.
> >
> > In Linux there aren't struct pages for physical memory remapped using
> > ioremap().  But if you want to feed them to the I/O subsystem you have
> > to use devm_memremap_pages to create a page backing.  Assuming you are
> > on a RISC-V platform given your affiliation you'll need to ensure your
> > kernel allows for ZONE_DEVICE pages, which Logan (added to Cc) has been
> > working on.  I don't remember what the current status is.
>
> The last patchset submission was here [1]. It had some issues but the
> main one was that they wanted the page tables to be created and removed
> dynamically. I took a crack at it and ran into some issues and haven't
> had time to touch it since. I was waiting to see how arm64[2] solves
> similar problems and then maybe it can be made common.

Thanks Logan for the links to your patchset.

>
> It's also a bit of a PITA because the RISC-V hardware we have with hacky
> PCI support is fragile and stopped working on recent kernels, last I
> tried. So this hasn't been a priority for us.

I would be interested in hearing more about PCI issues on RISC-V hardware.
Please include me, if you like.

>
> >> Please consider the following information and cost estimate in
> >> bytes for requiring page structs for PCI memory if used with
> >> scatterlists. For example, a 128GB PCI memory address space
> >> could require as much as 256MB of system memory just for
> >> page struct backing. In a 1GB 64-bit system with flat memory
> >> model, that consumes 25% of available memory. However,
> >> not all of the 128GB PCI memory may be mapped for use at
> >> a given time depending on the application. The cost of PCI
> >> page structs is an upfront cost to be paid at system start.
> >
> > I know the pages are costly.  But once you want to feed them through
> > subsystems that do expect pages you'll have to do that.  And anything
> > using scatterlists currently does.  A little hack here and there isn't
> > going to solve that.
> >
>
> Agreed. I tried expanding the SG-list to allow for page-less entries and
> it was a much bigger mess than what you describe.
>
> Also, I think your analysis is a bit unfair, we don't need to create
> pages for the entire 128GB of PCI memory space, we typically only need
> the BARs of a subset of devices which is far less. If a system has only
> 1GB of memory it probably doesn't actually have 128GB of PCI bar spaces
> that are sensibly usable.

I appreciate your comment and your attempt and experience with expanding
the scatterlist to allow for page-less entries. Feedback is clear.
Such expansion
is bigger than it looks at first glance.

An NVMe endpoint has to map Physical Region Pages (PRP) that sit
across the PCIe bus anywhere in host memory. PRPs are typically 4KB
pages which may be scattered throughout host memory. The PCIe address
space of NVMe endpoint is larger than its local physical memory space or
that of the host system. 128GB is not the typical amount of physical memory
populated on a PCIe host or endpoint. However, PCIe address space
of an NVMe endpoint needs to address much larger regions than physical
memory on either side of the PCIe bus.

NVMe endpoint function driver access to host PRPs is not BAR-based. NVMe
endpoint accesses host memory as PCIe bus master. PCIe hosts typically
access endpoint memory using BARs.

Finding an economical solution for page struct backing for large PCIe address
space, which is not itself backed by physical memory, is desirable. Clearly,
page structs are a requirement for using scatterlists. Since scatterlists
are the mechanism that Linux NVMe target driver uses, the NVMe endpoint
function driver needs to convert PRPs to scatterlist using mappings that have
proper page struct backing.

As Christoph Hellwig suggested, devm_memremap_pages() may be a solution
if the kernel supports ZONE_DEVICE.

Regards,
Alan

>
> Yes, it would be nice to get rid of this overhead, but that's a much
> bigger long-term project.
>
> Logan
>
>
> [1]
> https://lore.kernel.org/linux-riscv/20190327213643.23789-1-logang@deltatee.com/
> [2]
> https://lore.kernel.org/linux-arm-kernel/1570788852-12402-1-git-send-email-anshuman.khandual@arm.com/
