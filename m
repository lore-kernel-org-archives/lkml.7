Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05734C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 17:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7DC120854
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 17:40:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="YZ2AsxI5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388829AbfJORkm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 13:40:42 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36603 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfJORkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 13:40:42 -0400
Received: by mail-lj1-f195.google.com with SMTP id v24so21159588ljj.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 10:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YDPJi8TrGawaOpcP8OGtYJjeE4Q/9ChnD1mirgO1D/8=;
        b=YZ2AsxI5jTxcE+s9YHq5JmcRnqyHc0BJCQP65Q7UCxkzBBh253FUJfiMp0QkRjbIri
         2j61S1MpjMjeTqhrfSLbiV4neQ3H8Xzg4s4+HjY1lEvnwhKYQ/K7B+tICuo/Hz82UKby
         dCeQMPrGTzWbF1eA7Lf8RWxAcRGj/sKqn2c/5I4K4xVHh8G9I4hlYiHCnsgEMdycdf6s
         Wim6ahp/ccBBpGH/I8xIk8NPJYSjhv+5sg2IN69SbgFMXIZTFR9tEENyeQmwNDMyGQn2
         AGypTU3A1Nraiwvl/M+myaO02JaAxiDrPjA5UC/LTx+nnHG+B9IQocSqJ2FWGMV0cqmT
         fm/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YDPJi8TrGawaOpcP8OGtYJjeE4Q/9ChnD1mirgO1D/8=;
        b=Edpe6eQH5NeRzNwwDeUiWNWxwZSjtrqjWJOchvmA14HN1ZwdqaJYTLHqrPp9sqE9Ly
         feWY8jOajRHnYLUyHq+QLdXlosmS10NluXk1bYqVeMQjuTCEkGqlGURd6TxTxWSODQVj
         6szWZzYwtLVXBW94zCjA+zBAUtlj1loASgDsILOgg2jPKvsg18iafoKZVtBZ7vAyEIjI
         4F9Qw8Y3NZVUuUlJzYL2ip4hX4Kqc7ua/Zbc5+nm67WIdlBvQfSXgjhD3b7P9f7Ym7oJ
         H65JI+P72hYwBrXqeWjPrLwPBCrMjcpClJ7tQMVaolmZ3zSjUkzd5QSqmKA8LobwASYy
         7N8g==
X-Gm-Message-State: APjAAAVEt+PVagU4KNK1ys7L+XEcxkuLBM6a+GFTMukvA7S+eVRl/ggm
        tNwdIzdoBz4Il/+rFTzv7VjPEQJuiPetMDS2Gc6bfg==
X-Google-Smtp-Source: APXvYqxOcuUkg1IdARYyWvZO+tCD67zymYgiiXFgiKTyo8G2X0Sg6rV3EfLGohQLzSj9Zfy06Dui3Y9kLfjmMMcKPtY=
X-Received: by 2002:a2e:12d1:: with SMTP id 78mr22777795ljs.76.1571161239947;
 Tue, 15 Oct 2019 10:40:39 -0700 (PDT)
MIME-Version: 1.0
References: <1569885755-10947-1-git-send-email-alan.mikhak@sifive.com>
 <20191007061324.GB17978@infradead.org> <CABEDWGyovfKuXsNpfhsSCJ0sryg3EpAsaqRTHxBGC9LFM+=dww@mail.gmail.com>
 <CABEDWGxZaJp17jhd-CPqc+n9ZjYzvp63PymfMo0JVd=jzQEizQ@mail.gmail.com> <20191015095522.GA22551@infradead.org>
In-Reply-To: <20191015095522.GA22551@infradead.org>
From:   Alan Mikhak <alan.mikhak@sifive.com>
Date:   Tue, 15 Oct 2019 10:40:28 -0700
Message-ID: <CABEDWGwayE1aW26zfTqkYUVY-i=bTdM_Vm3htVB-x-AZQNvw2Q@mail.gmail.com>
Subject: Re: [PATCH] scatterlist: Validate page before calling PageSlab()
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org, martin.petersen@oracle.com,
        alexios.zavras@intel.com, ming.lei@redhat.com,
        gregkh@linuxfoundation.org, tglx@linutronix.de,
        Jason Gunthorpe <jgg@ziepe.ca>, christophe.leroy@c-s.fr,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Logan Gunthorpe <logang@deltatee.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2019 at 2:55 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Mon, Oct 07, 2019 at 02:13:51PM -0700, Alan Mikhak wrote:
> > > My goal is to not modify the Linux NVMe target code at all. The NVMe
> > > endpoint function driver currently does the work that is required.
>
> You will have to do some modifications, as for example in PCIe you can
> have a n:1 relationship between SQs and CQs.  And you need to handle
> the Create/Delete SQ/CQ commands, but not the fabrics commands.  And
> modifying subsystems in Linux is perfectly acceptable, that is how they
> improve.

The NVMe endpoint function driver currently creates the admin ACQ and
ASQ on startup. When the NVMe host connects over PCIe, NVMe endpoint
function driver handles the Create/Delete SQ/CQ commands and any other
commands that cannot go to the NVMe target on behalf of the host. For
example, it creates a pair of I/O CQ and SQ as requested by the Linux
host kernel nvme.ko driver. The NVMe endpoint function driver supports
Controller Memory Buffer (CMB). The I/O SQ is therefore located in CMB
as requested by host nvme.ko.

As for n:1 relationship between SQs and CQs, I have not implemented that
yet since I didn't get such a request from the host nvme.ko yet. I agree. It
needs to be implemented at some point. It is doable. I appreciate your
comment and took note of it.

>
> Do you have a pointer to your code?

The code is still work in progress. It is not stable yet for reliable use or
upstream patch submission. It is stable enough for me to see it work from
my Debian host desktop to capture screenshots of NVMe partition
benchmarking, formatting, mounting, file storage and retrieval activity
such as I mentioned. I could look into possibly submitting an RFC patch
upstream for early review and feedback to improve it but it is not in a
polished state yet.

>
> > > In my current platform, there are no page struct backing for the PCIe
> > > memory address space.
>
> In Linux there aren't struct pages for physical memory remapped using
> ioremap().  But if you want to feed them to the I/O subsystem you have
> to use devm_memremap_pages to create a page backing.  Assuming you are
> on a RISC-V platform given your affiliation you'll need to ensure your
> kernel allows for ZONE_DEVICE pages, which Logan (added to Cc) has been
> working on.  I don't remember what the current status is.

Thanks for this suggestion. I will try using devm_memremap_pages() to
create a page backing. I will also look for Logan's work regarding
ZONE_DEVICE pages.

>
> > Please consider the following information and cost estimate in
> > bytes for requiring page structs for PCI memory if used with
> > scatterlists. For example, a 128GB PCI memory address space
> > could require as much as 256MB of system memory just for
> > page struct backing. In a 1GB 64-bit system with flat memory
> > model, that consumes 25% of available memory. However,
> > not all of the 128GB PCI memory may be mapped for use at
> > a given time depending on the application. The cost of PCI
> > page structs is an upfront cost to be paid at system start.
>
> I know the pages are costly.  But once you want to feed them through
> subsystems that do expect pages you'll have to do that.  And anything
> using scatterlists currently does.  A little hack here and there isn't
> going to solve that.

Feedback on this is clear. Page struct backing is required to use
scatterlists. Thanks.
