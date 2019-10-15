Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46448C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 18:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1744620663
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 18:11:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="SoXgoOQV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729979AbfJOSL2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 14:11:28 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42715 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbfJOSL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 14:11:28 -0400
Received: by mail-lf1-f65.google.com with SMTP id c195so15229222lfg.9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 11:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xnPEfL78UBO2r2XJdt4zQeTdfQ9ddXYh7BFrYBIc/fA=;
        b=SoXgoOQVQLauUowaAlcBiWdj0ylpX0lFoZ5fhkIn6UZmDfxGpBn9ymd6qHSsFXMuWC
         TBO7TXrn/wjkbHAzZeF3uqbG7BkBTTUpYbqGnM82c0lMtbuZM4CHhuN/skmPY15QVmMv
         7MLdswEi7OJG1En5EzLuRwQ6gKMC0IID7+wC5Ji+TdEc9NNrdClvMVoTPnfSaJaj/8Zk
         uBdkcFCd8mPj0NMcLHYay15RBHbESvmoXde2qrmq/ItaPvNcYaSgbi970A1HPxrgr4tw
         d/Oz/i75RNnxv4VFSt0qwtGI6MKNwaHuUPA65IaOZFDpFoiLdvUhaAa+W/mvKohRhmuB
         5YEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xnPEfL78UBO2r2XJdt4zQeTdfQ9ddXYh7BFrYBIc/fA=;
        b=jnVylkCYquqhC+pNVPkQJfTQCxsWGcYvfO6svQMxRBHCqRsMQBXYf72DMzrDHcRzL+
         GOlUdNg/c2vxWFBdWiukw/pNJp073UgPJmNN5zHwcbpVhUqn97KGm/w2d1wzGfo2tex3
         G50bsU8v9nn/0A7RjkmiR4Bog+/aBIjV0iei3d+3Nbrtc3wmJ5zLszYz/9JtW3obZFxi
         TZrWVaJDtmEpAJuFHuXTmAaq/Dce+hqFwixrSZiRlpYjzH3pmTIdlhd29q+WCYPVYKu/
         pp3baBTZ/WC3RVm+rOcMfvjxKCXlyvlQ7u5qd7fHBdxwyPim9kFKaqVxkA4snQ97/ect
         FzcQ==
X-Gm-Message-State: APjAAAWXWEvMpn5FJDJDZQ1bCI2FwRV61e9KNyOu5kUc9jApEc68AMsO
        1OtiRrlhK5bBj5Syyh+oO8+PwwB02TBHAYdNkngt1A==
X-Google-Smtp-Source: APXvYqwB5ar8/HoUDaYFl3pbcRRKtXmuDrsFwTmahcM9n0Mudz3CF6YX8rkbY/bUGT2ULmr+2o8cpZPFprS4yII7LCk=
X-Received: by 2002:a19:6917:: with SMTP id e23mr205204lfc.4.1571163085524;
 Tue, 15 Oct 2019 11:11:25 -0700 (PDT)
MIME-Version: 1.0
References: <1569885755-10947-1-git-send-email-alan.mikhak@sifive.com>
 <20191007061324.GB17978@infradead.org> <CABEDWGyovfKuXsNpfhsSCJ0sryg3EpAsaqRTHxBGC9LFM+=dww@mail.gmail.com>
 <CABEDWGxZaJp17jhd-CPqc+n9ZjYzvp63PymfMo0JVd=jzQEizQ@mail.gmail.com>
 <20191015095522.GA22551@infradead.org> <CABEDWGwayE1aW26zfTqkYUVY-i=bTdM_Vm3htVB-x-AZQNvw2Q@mail.gmail.com>
 <268fdc04-f471-7869-1e1f-cb9f30b85066@deltatee.com>
In-Reply-To: <268fdc04-f471-7869-1e1f-cb9f30b85066@deltatee.com>
From:   Alan Mikhak <alan.mikhak@sifive.com>
Date:   Tue, 15 Oct 2019 11:11:14 -0700
Message-ID: <CABEDWGyrGS1L0fA++6PfMjUGhtfXvG8cmeaESL_KUZTTH0WsuA@mail.gmail.com>
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

On Tue, Oct 15, 2019 at 10:45 AM Logan Gunthorpe <logang@deltatee.com> wrote:
>
>
>
> On 2019-10-15 11:40 a.m., Alan Mikhak wrote:
> > On Tue, Oct 15, 2019 at 2:55 AM Christoph Hellwig <hch@infradead.org> wrote:
> >>
> >> On Mon, Oct 07, 2019 at 02:13:51PM -0700, Alan Mikhak wrote:
> >>>> My goal is to not modify the Linux NVMe target code at all. The NVMe
> >>>> endpoint function driver currently does the work that is required.
> >>
> >> You will have to do some modifications, as for example in PCIe you can
> >> have a n:1 relationship between SQs and CQs.  And you need to handle
> >> the Create/Delete SQ/CQ commands, but not the fabrics commands.  And
> >> modifying subsystems in Linux is perfectly acceptable, that is how they
> >> improve.
> >
> > The NVMe endpoint function driver currently creates the admin ACQ and
> > ASQ on startup. When the NVMe host connects over PCIe, NVMe endpoint
> > function driver handles the Create/Delete SQ/CQ commands and any other
> > commands that cannot go to the NVMe target on behalf of the host. For
> > example, it creates a pair of I/O CQ and SQ as requested by the Linux
> > host kernel nvme.ko driver. The NVMe endpoint function driver supports
> > Controller Memory Buffer (CMB). The I/O SQ is therefore located in CMB
> > as requested by host nvme.ko.
> >
> > As for n:1 relationship between SQs and CQs, I have not implemented that
> > yet since I didn't get such a request from the host nvme.ko yet. I agree. It
> > needs to be implemented at some point. It is doable. I appreciate your
> > comment and took note of it.
> >
> >>
> >> Do you have a pointer to your code?
> >
> > The code is still work in progress. It is not stable yet for reliable use or
> > upstream patch submission. It is stable enough for me to see it work from
> > my Debian host desktop to capture screenshots of NVMe partition
> > benchmarking, formatting, mounting, file storage and retrieval activity
> > such as I mentioned. I could look into possibly submitting an RFC patch
> > upstream for early review and feedback to improve it but it is not in a
> > polished state yet.
> >
> >>
> >>>> In my current platform, there are no page struct backing for the PCIe
> >>>> memory address space.
> >>
> >> In Linux there aren't struct pages for physical memory remapped using
> >> ioremap().  But if you want to feed them to the I/O subsystem you have
> >> to use devm_memremap_pages to create a page backing.  Assuming you are
> >> on a RISC-V platform given your affiliation you'll need to ensure your
> >> kernel allows for ZONE_DEVICE pages, which Logan (added to Cc) has been
> >> working on.  I don't remember what the current status is.
> >
> > Thanks for this suggestion. I will try using devm_memremap_pages() to
> > create a page backing. I will also look for Logan's work regarding
> > ZONE_DEVICE pages.
>
> The nvme driver already creates struct pages for the CMB with
> devm_memremap_pages(). At least since v4.20. Though, it probably won't
> do anything with the CMB on platforms that don't yet support ZONE_DEVICE
> (ie riscv).

Hi Logan, Thanks for your comments. I look forward to looking for the work
you have done on ZONE_DEVICE.

The NVMe endpoint function driver that I am developing runs on a PCIe endpoint
device running Linux sitting across the PCIe bus from nvme.ko running on the
Linux host. It interacts as an NVMe endpoint across the PCIe bus with the NVMe
host. The NVMe host may be Linux, Windows, etc. In the case of Linux host, it
interacts with nvme.ko. The Linux NVMe endpoint is a Linux PCIe endpoint device
which implements a PCI Endpoint Framework function driver which implements
the NVMe endpoint functionality on Linux.

>
> Logan
