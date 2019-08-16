Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D602CC3A59D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 18:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AF7F2133F
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 18:45:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="li2IDh4m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727570AbfHPSpX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 14:45:23 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:34574 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbfHPSpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 14:45:23 -0400
Received: by mail-oi1-f193.google.com with SMTP id l12so5528150oil.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2019 11:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8m/PnUmMNG5r4K8qxwTrufqLXmjy5RNoUVedVSyDCas=;
        b=li2IDh4mr+UAvox0w8zYX5tehUMkPPvP7XXDZCuFsaYSIFIidndEttxHLIPHalJnbr
         NjPHIAX42dtPi/AoVxuy5mtla/nzfy/BXFISPwcgG5eg7CKIeWppsVo+M1yV0O1Ivv6x
         ZkGpP31kNHoxf/lHiet4xJZ4Hrg989UdKskSM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8m/PnUmMNG5r4K8qxwTrufqLXmjy5RNoUVedVSyDCas=;
        b=cMnoJQnljtv69+ZKawboDYFzE5ST9JTXP/fcFZ09L1ZeFvjs7QCEnaKwzTenuZMcK7
         ff6xT16ZUlODsOKCJ/eQ5BghPHAHg2iwdjp57ZFvrvaPrJDd1rDs/2OjIu5bgg9xsUAR
         vhh+oif3GgYktvG+K+xpz23vnSdibtxhPx45G4uHw04WZa1hLXU8fKbIhRYTjDr71BA1
         QDVhlszSUN/5NEBWaJtskBdQcNLTGbdjZxdwACjk6ST+pHC8t3bN3BlR6TRLPVWyIW7a
         U3/bg3n/opI//V6sgAnONBZz1gSCHOOpJNjahzp1Bv3CN41sZbJ6alBL4pVoBb3ixeU3
         B2Bw==
X-Gm-Message-State: APjAAAXhTfJSAK+RXlgk/jHEw9OleZ5wMvFBHtriWIdus/8gEITxqeBp
        PBiZcE3/8Q1aOdjnNc1qfJhNNPve640yL5nTLDHCWQ==
X-Google-Smtp-Source: APXvYqxtlu0LEJa8psV6E/U/IwuYFYQU5hM+C5zSCrQVLfT7Mz2rnMfcYn79/qmwJoa+Ktloe0ld4rH3kcVpmdEdjao=
X-Received: by 2002:a05:6808:28d:: with SMTP id z13mr5408599oic.101.1565981122323;
 Fri, 16 Aug 2019 11:45:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190814145033.GA11190@Red> <20190814174927.GT7444@phenom.ffwll.local>
 <20190816143146.GB30445@Red>
In-Reply-To: <20190816143146.GB30445@Red>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Fri, 16 Aug 2019 20:45:11 +0200
Message-ID: <CAKMK7uGb0twmXUXS5GVN0mmGW-csWH524psJFfdFYuou9YXFDw@mail.gmail.com>
Subject: Re: DMA-API: cacheline tracking ENOMEM, dma-debug disabled due to
 nouveau ?
To:     Corentin Labbe <clabbe.montjoie@gmail.com>
Cc:     Ben Skeggs <bskeggs@redhat.com>, Dave Airlie <airlied@linux.ie>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Nouveau Dev <nouveau@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 4:31 PM Corentin Labbe
<clabbe.montjoie@gmail.com> wrote:
> On Wed, Aug 14, 2019 at 07:49:27PM +0200, Daniel Vetter wrote:
> > On Wed, Aug 14, 2019 at 04:50:33PM +0200, Corentin Labbe wrote:
> > > Hello
> > >
> > > Since lot of release (at least since 4.19), I hit the following error message:
> > > DMA-API: cacheline tracking ENOMEM, dma-debug disabled
> > >
> > > After hitting that, I try to check who is creating so many DMA mapping and see:
> > > cat /sys/kernel/debug/dma-api/dump | cut -d' ' -f2 | sort | uniq -c
> > >       6 ahci
> > >     257 e1000e
> > >       6 ehci-pci
> > >    5891 nouveau
> > >      24 uhci_hcd
> > >
> > > Does nouveau having this high number of DMA mapping is normal ?
> >
> > Yeah seems perfectly fine for a gpu.
>
> Note that it never go down and when I terminate my X session, it stays the same.
> So without any "real" GPU work, does it is still normal to have so many active mapping ?

Might just be the dma_alloc cache. It should go down under memory
pressure I think. Otherwise might also be a leak.

> For example, when doing some transfer, the ahci mapping number changes and then always go down to 6.

gpu drivers tend to cache everything, all the time ...
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
