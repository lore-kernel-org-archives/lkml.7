Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36FA5C31E44
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 22:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0267B2086D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 22:53:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407411AbfFKWx0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 18:53:26 -0400
Received: from gate.crashing.org ([63.228.1.57]:33554 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404048AbfFKWx0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 18:53:26 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x5BMr72S021573;
        Tue, 11 Jun 2019 17:53:08 -0500
Message-ID: <ca81ca5d56a3a12db5a92f5cf9745763a86572e8.camel@kernel.crashing.org>
Subject: Re: [PATCH v2 8/8] habanalabs: enable 64-bit DMA mask in POWER9
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Oded Gabbay <oded.gabbay@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>, linuxppc-dev@ozlabs.org,
        Christoph Hellwig <hch@infradead.org>
Cc:     "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Oliver OHalloran <oliveroh@au1.ibm.com>,
        Russell Currey <ruscur@au1.ibm.com>
Date:   Wed, 12 Jun 2019 08:53:07 +1000
In-Reply-To: <CAFCwf134nTD4FM_9Q+THQ7ZAZzGxhs15O6EheaRJMqM5wxi+aA@mail.gmail.com>
References: <20190611092144.11194-1-oded.gabbay@gmail.com>
         <20190611095857.GB24058@kroah.com> <20190611151753.GA11404@infradead.org>
         <20190611152655.GA3972@kroah.com>
         <CAFCwf13A73AxKzaa7Dk3tU-1NDgTFs4+xCO2os7SuSyUHZ9Z3Q@mail.gmail.com>
         <CAFCwf134nTD4FM_9Q+THQ7ZAZzGxhs15O6EheaRJMqM5wxi+aA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-06-11 at 20:22 +0300, Oded Gabbay wrote:
> 
> > So, to summarize:
> > If I call pci_set_dma_mask with 48, then it fails on POWER9. However,
> > in runtime, I don't know if its POWER9 or not, so upon failure I will
> > call it again with 32, which makes our device pretty much unusable.
> > If I call pci_set_dma_mask with 64, and do the dedicated configuration
> > in Goya's PCIe controller, then it won't work on x86-64, because bit
> > 59 will be set and the host won't like it (I checked it). In addition,
> > I might get addresses above 50 bits, which my device can't generate.
> > 
> > I hope this makes things more clear. Now, please explain to me how I
> > can call pci_set_dma_mask without any regard to whether I run on
> > x86-64 or POWER9, considering what I wrote above ?
> > 
> > Thanks,
> > Oded
> 
> Adding ppc mailing list.

You can't. Your device is broken. Devices that don't support DMAing to
the full 64-bit deserve to be added to the trash pile.

As a result, getting it to work will require hacks. Some GPUs have
similar issues and require similar hacks, it's unfortunate.

Added a couple of guys on CC who might be able to help get those hacks
right.

It's still very fishy .. the idea is to detect the case where setting a
64-bit mask will give your system memory mapped at a fixed high address
(1 << 59 in our case) and program that in your chip in the "Fixed high
bits" register that you seem to have (also make sure it doesn't affect
MSIs or it will break them).

This will only work as long as all of the system memory can be
addressed at an offset from that fixed address that itself fits your
device addressing capabilities (50 bits in this case). It may or may
not be the case but there's no way to check since the DMA mask logic
won't really apply.

You might want to consider fixing your HW in the next iteration... This
is going to bite you when x86 increases the max physical memory for
example, or on other architectures.

Cheers,
Ben.




