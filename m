Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D2E6C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 06:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2EB620896
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 06:26:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eyDsg02x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731061AbfFLG0M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 02:26:12 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:38216 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbfFLG0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 02:26:12 -0400
Received: by mail-vs1-f67.google.com with SMTP id k9so386830vso.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 23:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lKi9fDU0Lxa/G5VIecJ7zcekWrVtK+7i/1xldaoGnKM=;
        b=eyDsg02xExXKcTNUxPVULiXqWMYD105i/SYss3Q7V7I4w3D6V8UOwCLq2ZoHI3mfQg
         OTOZo+12wHolv7tBGv3sdkmuSCqRtGRtsH/CXaw+WsTDMgkJfbsIxMXGQHVukIrCMeIp
         WMJtP4K8mh4CfnD/OzA0LsD4n5zUmMJFuZbqIliJxj+/ysyNeX8d0WMZJkgvyDtB53cj
         r8AAjqQ2NGyvklSU8TGfeou44Ndc8sZVnQxufRmi9ZUNRSE31V2H7I8bSiLHmCPd18cI
         IzURSSp1riW/tb78SPfnulXCdtyqSevY9l/dVLxcqTLtox2ZZPsTDydfn6bTGUfVyk/U
         s8xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lKi9fDU0Lxa/G5VIecJ7zcekWrVtK+7i/1xldaoGnKM=;
        b=oGUp/1YCtsc2dayZuFucHQpVA8VonfwIWWJGBtZwZVG3UAvlXZjeOHdC+asa5tweom
         WeIyZCvrU72BEB8dR8+1L0u+k4Y4X7v0xf+mGNEWeweoocfqfpZq+WJkR/z3ujlqPcPt
         iqJuoiscHUlUJl9rNisD2lAmqyspuq2RiPZDIELiCbRZqD/1XkShlxwGpxC7uEWBiqyh
         bG+qN65PJRHaoyoasS9JA/bV+2OM+4cT/IIwyxM83vyb3gsa5+6QS+4afrO3J87tGqfH
         LEBbkzUQ+3XN7QO1dwRrU+x64bKzqParWSPz5m2zp1HkEwdlpOS9QDXiiSutTbvj9JWQ
         bt/A==
X-Gm-Message-State: APjAAAXNxnO4Qyj5RvTe2AVfWBnHYjZLiPPSVgszJlL76T4L/LdL3vQA
        EUw7IvOAjnyw3jdiFmVGDmp4JhqWoYZ/Ao4gfu0=
X-Google-Smtp-Source: APXvYqwH8H0IVDzCPTEFhE+jcQW08UumKLElWDBxov+7klCRUS6XvGsbE9i0ORzHeyhkcLy76VZViwB8rgx59DVP6D8=
X-Received: by 2002:a67:e3d5:: with SMTP id k21mr28292559vsm.172.1560320771385;
 Tue, 11 Jun 2019 23:26:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190611092144.11194-1-oded.gabbay@gmail.com> <20190611095857.GB24058@kroah.com>
 <20190611151753.GA11404@infradead.org> <20190611152655.GA3972@kroah.com>
 <CAFCwf13A73AxKzaa7Dk3tU-1NDgTFs4+xCO2os7SuSyUHZ9Z3Q@mail.gmail.com>
 <CAFCwf134nTD4FM_9Q+THQ7ZAZzGxhs15O6EheaRJMqM5wxi+aA@mail.gmail.com> <ca81ca5d56a3a12db5a92f5cf9745763a86572e8.camel@kernel.crashing.org>
In-Reply-To: <ca81ca5d56a3a12db5a92f5cf9745763a86572e8.camel@kernel.crashing.org>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Wed, 12 Jun 2019 09:25:45 +0300
Message-ID: <CAFCwf11naDCqotNx2mrr18WpJ80T=9=jfsJWMSBu7KPrF5paJw@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] habanalabs: enable 64-bit DMA mask in POWER9
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>, linuxppc-dev@ozlabs.org,
        Christoph Hellwig <hch@infradead.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Oliver OHalloran <oliveroh@au1.ibm.com>,
        Russell Currey <ruscur@au1.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 1:53 AM Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>
> On Tue, 2019-06-11 at 20:22 +0300, Oded Gabbay wrote:
> >
> > > So, to summarize:
> > > If I call pci_set_dma_mask with 48, then it fails on POWER9. However,
> > > in runtime, I don't know if its POWER9 or not, so upon failure I will
> > > call it again with 32, which makes our device pretty much unusable.
> > > If I call pci_set_dma_mask with 64, and do the dedicated configuration
> > > in Goya's PCIe controller, then it won't work on x86-64, because bit
> > > 59 will be set and the host won't like it (I checked it). In addition,
> > > I might get addresses above 50 bits, which my device can't generate.
> > >
> > > I hope this makes things more clear. Now, please explain to me how I
> > > can call pci_set_dma_mask without any regard to whether I run on
> > > x86-64 or POWER9, considering what I wrote above ?
> > >
> > > Thanks,
> > > Oded
> >
> > Adding ppc mailing list.
>
> You can't. Your device is broken. Devices that don't support DMAing to
> the full 64-bit deserve to be added to the trash pile.
>
Hmm... right know they are added to customers data-centers but what do I know ;)

> As a result, getting it to work will require hacks. Some GPUs have
> similar issues and require similar hacks, it's unfortunate.
>
> Added a couple of guys on CC who might be able to help get those hacks
> right.
Thanks :)
>
> It's still very fishy .. the idea is to detect the case where setting a
> 64-bit mask will give your system memory mapped at a fixed high address
> (1 << 59 in our case) and program that in your chip in the "Fixed high
> bits" register that you seem to have (also make sure it doesn't affect
> MSIs or it will break them).
MSI-X are working. The set of bit 59 doesn't apply to MSI-X
transactions (AFAICS from the PCIe controller spec we have).
>
> This will only work as long as all of the system memory can be
> addressed at an offset from that fixed address that itself fits your
> device addressing capabilities (50 bits in this case). It may or may
> not be the case but there's no way to check since the DMA mask logic
> won't really apply.
Understood. In the specific system we are integrated to, that is the
case - we have less then 48 bits. But, as you pointed out, it is not a
generic solution but with my H/W I can't give a generic fit-all
solution for POWER9. I'll settle for the best that I can do.

>
> You might want to consider fixing your HW in the next iteration... This
> is going to bite you when x86 increases the max physical memory for
> example, or on other architectures.
Understood and taken care of.

>
> Cheers,
> Ben.
>
>
>
>
