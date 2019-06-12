Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C181FC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0FDB2080A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:19:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436884AbfFLITH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 04:19:07 -0400
Received: from gate.crashing.org ([63.228.1.57]:33437 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730984AbfFLITH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 04:19:07 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x5C8Iqah008654;
        Wed, 12 Jun 2019 03:18:53 -0500
Message-ID: <8fa52f5f1455b9f3d81c71517ed499b93b357044.camel@kernel.crashing.org>
Subject: Re: [PATCH v2 8/8] habanalabs: enable 64-bit DMA mask in POWER9
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, linuxppc-dev@ozlabs.org,
        Christoph Hellwig <hch@infradead.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Oliver OHalloran <oliveroh@au1.ibm.com>,
        Russell Currey <ruscur@au1.ibm.com>
Date:   Wed, 12 Jun 2019 18:18:52 +1000
In-Reply-To: <CAFCwf11naDCqotNx2mrr18WpJ80T=9=jfsJWMSBu7KPrF5paJw@mail.gmail.com>
References: <20190611092144.11194-1-oded.gabbay@gmail.com>
         <20190611095857.GB24058@kroah.com> <20190611151753.GA11404@infradead.org>
         <20190611152655.GA3972@kroah.com>
         <CAFCwf13A73AxKzaa7Dk3tU-1NDgTFs4+xCO2os7SuSyUHZ9Z3Q@mail.gmail.com>
         <CAFCwf134nTD4FM_9Q+THQ7ZAZzGxhs15O6EheaRJMqM5wxi+aA@mail.gmail.com>
         <ca81ca5d56a3a12db5a92f5cf9745763a86572e8.camel@kernel.crashing.org>
         <CAFCwf11naDCqotNx2mrr18WpJ80T=9=jfsJWMSBu7KPrF5paJw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-06-12 at 09:25 +0300, Oded Gabbay wrote:
> 
> > You can't. Your device is broken. Devices that don't support DMAing to
> > the full 64-bit deserve to be added to the trash pile.
> > 
> 
> Hmm... right know they are added to customers data-centers but what do I know ;)

Well, some customers don't know they are being sold a lemon :)

> > As a result, getting it to work will require hacks. Some GPUs have
> > similar issues and require similar hacks, it's unfortunate.
> > 
> > Added a couple of guys on CC who might be able to help get those hacks
> > right.
> 
> Thanks :)
> > 
> > It's still very fishy .. the idea is to detect the case where setting a
> > 64-bit mask will give your system memory mapped at a fixed high address
> > (1 << 59 in our case) and program that in your chip in the "Fixed high
> > bits" register that you seem to have (also make sure it doesn't affect
> > MSIs or it will break them).
> 
> MSI-X are working. The set of bit 59 doesn't apply to MSI-X
> transactions (AFAICS from the PCIe controller spec we have).

Ok.

> > This will only work as long as all of the system memory can be
> > addressed at an offset from that fixed address that itself fits your
> > device addressing capabilities (50 bits in this case). It may or may
> > not be the case but there's no way to check since the DMA mask logic
> > won't really apply.
> 
> Understood. In the specific system we are integrated to, that is the
> case - we have less then 48 bits. But, as you pointed out, it is not a
> generic solution but with my H/W I can't give a generic fit-all
> solution for POWER9. I'll settle for the best that I can do.
> 
> > 
> > You might want to consider fixing your HW in the next iteration... This
> > is going to bite you when x86 increases the max physical memory for
> > example, or on other architectures.
> 
> Understood and taken care of.

Cheers,
Ben.

> > 
> > Cheers,
> > Ben.
> > 
> > 
> > 
> > 

