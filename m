Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AECFC4360C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 01:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04A1E21835
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 01:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570582999;
	bh=VLCuRsT/MfVMhiZm4dpxA6L+PvxonwyYTic44/Y8bTk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=wy43vEOHai20khYwLrj82OrwusR205c1hzarsZKJ2ABoTwEYSNCZQGpWCvjrFgcT0
	 siOZtxI9NPD7flx5PSnX/8WMkIL9hFphknUHep4Zfw7HXBkDt/FPrXbxo4dfFVmZdL
	 W8LR/387HY48bN/XLed/dnudqC7YastZ+tXLl0Z8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729983AbfJIBDQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 21:03:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:35874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729700AbfJIBDQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 21:03:16 -0400
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8FDEA2190F;
        Wed,  9 Oct 2019 01:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570582995;
        bh=VLCuRsT/MfVMhiZm4dpxA6L+PvxonwyYTic44/Y8bTk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VVdn5FnpZ2LW7gOeC0iXD/4eMjkljyV0uaiMQuEzBESoDaT45DoQVIEfx+T3qvbgZ
         Nx/M4hs0e17oXxWj4zabjE0GgFI2QwABFO8uYmkjbk4FAY/UMRubyrKsZoCf4YrPsH
         sU4OR5NoROArKqTPJQE3e8b9NyiiP/Y0G54k6/7k=
Received: by mail-qt1-f172.google.com with SMTP id c4so963766qtn.10;
        Tue, 08 Oct 2019 18:03:15 -0700 (PDT)
X-Gm-Message-State: APjAAAVOCT0k8WNC6nlyzkrIpkZ8A8ZL0XpR9oDudEH9s2P362RyxSX3
        wPxwdsOvtdSNPTsvdR0vznR3cR40MoQA0k3N+Q==
X-Google-Smtp-Source: APXvYqwRe4KvCR0oZcnhRteOV94HuZo93EGdhT82sy+BCEmzxu67B5XFk6sBiEIoEiq0xHLNZS9g8EJr+Zb0qOVzX0k=
X-Received: by 2002:ac8:19f4:: with SMTP id s49mr986458qtk.136.1570582994663;
 Tue, 08 Oct 2019 18:03:14 -0700 (PDT)
MIME-Version: 1.0
References: <20191008195239.12852-1-robh@kernel.org> <4f6b26f8779a4fd98712b966bff3491dc31e26c2.camel@suse.de>
In-Reply-To: <4f6b26f8779a4fd98712b966bff3491dc31e26c2.camel@suse.de>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 8 Oct 2019 20:03:02 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+RjC0b1ZXzgmMdn5Gd1=3zkN62Jdq_QKeZ8-X4pCiDPw@mail.gmail.com>
Message-ID: <CAL_Jsq+RjC0b1ZXzgmMdn5Gd1=3zkN62Jdq_QKeZ8-X4pCiDPw@mail.gmail.com>
Subject: Re: [PATCH v2] of: Make of_dma_get_range() work on bus nodes
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     devicetree@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>,
        Frank Rowand <frowand.list@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Simon Horman <horms+renesas@verge.net.au>,
        Robin Murphy <robin.murphy@arm.com>,
        Stefan Wahren <wahrenst@gmx.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 8, 2019 at 3:52 PM Nicolas Saenz Julienne
<nsaenzjulienne@suse.de> wrote:
>
> Hi Rob/Robin,
>
> On Tue, 2019-10-08 at 14:52 -0500, Rob Herring wrote:
> > From: Robin Murphy <robin.murphy@arm.com>
> >
> > Since the "dma-ranges" property is only valid for a node representing a
> > bus, of_dma_get_range() currently assumes the node passed in is a leaf
> > representing a device, and starts the walk from its parent. In cases
> > like PCI host controllers on typical FDT systems, however, where the PCI
> > endpoints are probed dynamically the initial leaf node represents the
> > 'bus' itself, and this logic means we fail to consider any "dma-ranges"
> > describing the host bridge itself. Rework the logic such that
> > of_dma_get_range() also works correctly starting from a bus node
> > containing "dma-ranges".
> >
> > While this does mean "dma-ranges" could incorrectly be in a device leaf
> > node, there isn't really any way in this function to ensure that a leaf
> > node is or isn't a bus node.
>
> Sorry, I'm not totally sure if this is what you're pointing out with the last
> sentence. But, what about the case of a bus configuring a device which also
> happens to be a memory mapped bus (say a PCI platform device). It'll get it's
> dma config based on its own dma-ranges which is not what we want.

What I was trying to say is we just can't tell if we should be looking
in the current node or the parent. 'dma-ranges' in a leaf node can be
correct or incorrect.

Your example is a bit different. I'm not sure that case is valid or
can ever work if it is. It's certainly valid that a PCI bridge's
parent has dma-ranges and now we'll actually handle any translation.
The bridge itself is not a DMA-capable device, but just passing thru
DMA. Do we ever need to know the parent's dma-ranges in that case? Or
to put it another way, is looking at anything other than leaf
dma-ranges useful?

Rob
