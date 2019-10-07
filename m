Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A372C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 21:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A013206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 21:14:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="LzBxC851"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729244AbfJGVOF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 17:14:05 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42073 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728702AbfJGVOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 17:14:05 -0400
Received: by mail-lj1-f193.google.com with SMTP id y23so15226237lje.9
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 14:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vrcKN6mCbXPcgwtBM9vrQs1ue8feO5uevCMF6526DqM=;
        b=LzBxC851wc+vusnWhebbk2ZXt+iqMZZahVb4CNdu4/FAeK3UQuwtXdSsqHcXkWpMr/
         Im5euDERaWU1r35gIbdVEQUsZHZ1QM2bHq5bf8pcTmQuBexoeN6Ew6ph5cyaAzxvUcna
         UZFOkfLwQ5msU0ZluWeHBfdzYR7LUlJ2ZeEH64oKh1S93Y2iLanHDSPN2gzWXZ2n77Gr
         qbbFm08caMT2tb1Bh7vikeeh6O/FSxIZgkuJ2Nu6yzbkuA8U8hxg8NfBYd7qlAKk0YWm
         OD4WqBgPKrlGHOA0PvWWXeDvVlXCgw/6x91spfrnNwaqRJyez6MhKZTocZZEbgoGz9Rk
         YEWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vrcKN6mCbXPcgwtBM9vrQs1ue8feO5uevCMF6526DqM=;
        b=FX8QgrrUhLVIF4A8Sxqn6fNCLLxzamz7wNzP0loldsb8F++QdjK6z7r2AUYLoGT/8Y
         54XnY2/0PVHOEkPcoW6eIe2tlrrIlZ7BnUQfRuOmg8ZlMC+jRQD/Mh8WqX0iJPxCfr5A
         i7xERaXMXIux9Ep3wgpGLhuSmEtv6SJ2OA00HZ0eJY7RQHJmVVoM++0orY/qEBGF3kPO
         UbI0475We7Xyr7/TtYgggO2O46AzS8aP0ZSR0KwAegm1HINOjF9HsSsp4zgtbRqKmIoI
         sPdSRk41Xy5MmfhsCbvN4v4FQAeGhwka39jRieDsbYMF4zLYV2yNW8LYxIH17Y8rOdKJ
         1BFA==
X-Gm-Message-State: APjAAAUuc904zylL+60zt9o7NHSN0JvWimItlvWXG2NtN/X/LUWdHVSN
        TDCKdej+NF4AvcM6A9K95P6ptb1j020oKc24Z1Q99A==
X-Google-Smtp-Source: APXvYqyqereRXk4dqu65yBhX1TSCy2PKoXaeLFqdOr74uFykL/IWmTjCyv4H4WktYiMkTHBTA1RZxFvJUulsbzm9ISo=
X-Received: by 2002:a2e:8507:: with SMTP id j7mr19146839lji.151.1570482842524;
 Mon, 07 Oct 2019 14:14:02 -0700 (PDT)
MIME-Version: 1.0
References: <1569885755-10947-1-git-send-email-alan.mikhak@sifive.com>
 <20191007061324.GB17978@infradead.org> <CABEDWGyovfKuXsNpfhsSCJ0sryg3EpAsaqRTHxBGC9LFM+=dww@mail.gmail.com>
In-Reply-To: <CABEDWGyovfKuXsNpfhsSCJ0sryg3EpAsaqRTHxBGC9LFM+=dww@mail.gmail.com>
From:   Alan Mikhak <alan.mikhak@sifive.com>
Date:   Mon, 7 Oct 2019 14:13:51 -0700
Message-ID: <CABEDWGxZaJp17jhd-CPqc+n9ZjYzvp63PymfMo0JVd=jzQEizQ@mail.gmail.com>
Subject: Re: [PATCH] scatterlist: Validate page before calling PageSlab()
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org, martin.petersen@oracle.com,
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

On Mon, Oct 7, 2019 at 9:44 AM Alan Mikhak <alan.mikhak@sifive.com> wrote:
>
> On Sun, Oct 6, 2019 at 11:13 PM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > On Mon, Sep 30, 2019 at 04:22:35PM -0700, Alan Mikhak wrote:
> > > From: Alan Mikhak <alan.mikhak@sifive.com>
> > >
> > > Modify sg_miter_stop() to validate the page pointer
> > > before calling PageSlab(). This check prevents a crash
> > > that will occur if PageSlab() gets called with a page
> > > pointer that is not backed by page struct.
> > >
> > > A virtual address obtained from ioremap() for a physical
> > > address in PCI address space can be assigned to a
> > > scatterlist segment using the public scatterlist API
> > > as in the following example:
> >
> > As Jason pointed out that is not a valid use of scatterlist.  What
> > are you trying to do here at a higher level?
>
> I am developing a PCI endpoint framework function driver to bring-up
> an NVMe device over PCIe. The NVMe endpoint function driver connects
> to an x86_64 or other root-complex host over PCIe. Internally, the
> NVMe endpoint function driver connects to the unmodified Linux NVMe
> target driver running on the embedded CPU. The Linux NVMe target
> operates an NVMe namespace as determined for the application.
> Currently, the Linux NVMe target code operates a file-based namespace
> which is backed by the loop device. However, the application can be
> expanded to operate on non-volatile storage such as flash or
> battery-backed RAM. Currently, I am able to mount such an NVMe
> namespace from the x86_64 Debian Linux host across PCIe using the
> Disks App and perform Partition Benchmarking. I am also able to save
> and load files, such as trace files for debugging the NVMe endpoint
> with KernelShark, on the NVMe namespace partition nvme0n1p1.
>
> My goal is to not modify the Linux NVMe target code at all. The NVMe
> endpoint function driver currently does the work that is required. It
> maps NVMe PRPs and PRP Lists from the host, formats a scatterlist that
> NVMe target driver can consume, and executes the NVMe command with the
> scatterlist on the NVMe target controller on behalf of the host. The
> NVMe target controller can therefore read and write directly to host
> buffers using the scatterlist as it does if the scatterlist had
> arrived over the NVMe fabric.
>
> In my current platform, there are no page struct backing for the PCIe
> memory address space. Nevertheless, I am able to feed the virtual
> addresses I obtain from ioremap() to the scatterlist as shown in my
> example earlier. The scatterlist code has no problem traversing the
> scatterlist that is formed from such addresses that were obtained from
> ioremap(). The only place the scatterlist code prevents such usage is
> in sg_miter_stop() when it calls PageSlab() to decide if it should
> flush the page. I added a check to see if the page is valid and not
> call PageSlab() if it is not a page struct backed page. That is all I
> had to do to be able to pass scatterlists to the NVMe target.
>
> Given that the PCIe memory address space is large, the cost of adding
> page structs for that region is substantial enough for me to ask that
> it be considered here to modify scatterlist code to support such
> memory pointers that were obtained from ioremap(). If not acceptable,
> the solution would be to pay to price and add page structs for the
> PCIe memory address space.
>

Please consider the following information and cost estimate in
bytes for requiring page structs for PCI memory if used with
scatterlists. For example, a 128GB PCI memory address space
could require as much as 256MB of system memory just for
page struct backing. In a 1GB 64-bit system with flat memory
model, that consumes 25% of available memory. However,
not all of the 128GB PCI memory may be mapped for use at
a given time depending on the application. The cost of PCI
page structs is an upfront cost to be paid at system start.

pci memory start: 0x2000000000
pci memory size: 128GB  0x2000000000

pci page_size: 64KB  0x10000
pci page_shift: 16  0x10
pci pages: 2MB  0x200000
pci epc bitmap_size: 256KB  0x40000

pci page_size: 4KB  0x1000
pci page_shift: 12  0xc
pci pages: 32MB  0x2000000
pci epc bitmap_size: 4MB  0x400000

system page size: 4KB  0x1000
linux page struct size: 8B
pci page struct cost: 256MB  0x10000000

Regards,
Alan
