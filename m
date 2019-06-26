Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEEA5C48BD9
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 20:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A516D208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 20:39:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="kVT6f/J1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbfFZUjP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 16:39:15 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:41747 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfFZUjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 16:39:14 -0400
Received: by mail-oi1-f194.google.com with SMTP id g7so150109oia.8
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 13:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VYeWRlp6n/vQnTa+fYFmAoEUxn0NMI33stOLW194NWI=;
        b=kVT6f/J18N4jOGjKVrrG9wNomn8jDVg05k4WFQXf36XrjtMQpEmVpWPIuNysiAbKsx
         n+Z718Sxszq/I1fyvWJXsD01Zp8W0/LbsKFY24ybfeyRgsqfCUshdCH7ZoW7/ONLXJdN
         lD9TT3SmGvQUVxDWCD1qHC1hTkzE10LJ57KQWSYjPlWxqr+J4LzT7uhc9aNdJ7JwhKKB
         kTLAPG10/ZPxQsIMrTIvi7pepmWglKVqEy7PBkHxAU5DIyV7aNyjbNLUdQltXRmZLL9f
         8H0FR7ztfQUo0clbwtw2o44u24imsaxpG3L9ecnsJ6w6WyNKf8/pW5Eab6KslfuserKb
         EmDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VYeWRlp6n/vQnTa+fYFmAoEUxn0NMI33stOLW194NWI=;
        b=ITd1vPtit7PPdP8BqNojAJoYTHaZOAeWTx8mZJOKpQUc8lTjp06rQChAakNXdXFs6J
         N1JDmhY6eRPjJgrA/mOPcg4lvhRtW5j9OjRuIwrCvGzZO3/HvZH77pZb9klzojqR6XvL
         LCehP+b35hWyvwe0OYzxUciyjKRscuP35OhBzAi1zd0GaooeeE+SYXi+kjH+4naBzmzJ
         iYVy9I1A3AO8jJbESf5kWLewYEFZiARUzuZpt+G4WRpxoy3Wou4b3uS4YeJkxeInHF98
         vj7xKFCzJXXklFXcdCna7R6lwQQjsBXd5iVC8Juzj4FmWXWF6Kb2QgVVgfH/32hgXbqG
         E0pQ==
X-Gm-Message-State: APjAAAU27yq/oZk3Qw8mU5PBzEX41y144URyJXubsoLAFPXcpMKhSG7J
        4ROKmAnobmPfgMuyPyHHYhvZOzQvdYxzjVQRUtY6BA==
X-Google-Smtp-Source: APXvYqzOW0zZUogI9bpo993SYdjNzW7+XY8OQvRzfJZPA3+Cc3WWKwMsRZL6wtJbO/WerGOW6fDqo9Ufat9fvVAWYZw=
X-Received: by 2002:aca:d80a:: with SMTP id p10mr179462oig.105.1561581553855;
 Wed, 26 Jun 2019 13:39:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190620161240.22738-1-logang@deltatee.com> <20190624072752.GA3954@lst.de>
 <558a27ba-e7c9-9d94-cad0-377b8ee374a6@deltatee.com> <20190625072008.GB30350@lst.de>
 <f0f002bf-2b94-cd18-d18f-5d0b08311495@deltatee.com> <20190625170115.GA9746@lst.de>
 <41235a05-8ed1-e69a-e7cd-48cae7d8a676@deltatee.com> <20190626065708.GB24531@lst.de>
 <c15d5997-9ba4-f7db-0e7a-a69e75df316c@deltatee.com> <20190626202107.GA5850@ziepe.ca>
In-Reply-To: <20190626202107.GA5850@ziepe.ca>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 26 Jun 2019 13:39:01 -0700
Message-ID: <CAPcyv4hCNoMeFyOE588=kuNUXaPS-rzaXnF2cN2TFejso1SGRw@mail.gmail.com>
Subject: Re: [RFC PATCH 00/28] Removing struct page from P2PDMA
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-rdma <linux-rdma@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>,
        Stephen Bates <sbates@raithlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 1:21 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Wed, Jun 26, 2019 at 12:31:08PM -0600, Logan Gunthorpe wrote:
> > > we have a hole behind len where we could store flag.  Preferably
> > > optionally based on a P2P or other magic memory types config
> > > option so that 32-bit systems with 32-bit phys_addr_t actually
> > > benefit from the smaller and better packing structure.
> >
> > That seems sensible. The one thing that's unclear though is how to get
> > the PCI Bus address when appropriate. Can we pass that in instead of the
> > phys_addr with an appropriate flag? Or will we need to pass the actual
> > physical address and then, at the map step, the driver has to some how
> > lookup the PCI device to figure out the bus offset?
>
> I agree with CH, if we go down this path it is a layering violation
> for the thing injecting bio's into the block stack to know what struct
> device they egress&dma map on just to be able to do the dma_map up
> front.
>
> So we must be able to go from this new phys_addr_t&flags to some BAR
> information during dma_map.
>
> For instance we could use a small hash table of the upper phys addr
> bits, or an interval tree, to do the lookup.

Hmm, that sounds like dev_pagemap without the pages.

There's already no requirement that dev_pagemap point to real /
present pages (DEVICE_PRIVATE) seems a straightforward extension to
use it for helping coordinate phys_addr_t in 'struct bio'. Then
Logan's future plans to let userspace coordinate p2p operations could
build on PTE_DEVMAP.
