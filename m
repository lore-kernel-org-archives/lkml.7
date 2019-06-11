Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26758C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 17:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8E8420896
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 17:04:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KPBwYPpA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405783AbfFKREB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 13:04:01 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:36495 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404885AbfFKREA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 13:04:00 -0400
Received: by mail-ua1-f66.google.com with SMTP id 94so4812753uam.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 10:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/fnirGe+UEdM6gLPxeyAhDbf8WnoU77O3LvcE+alXcI=;
        b=KPBwYPpAf7dSXO+ICKNhnOHyHNMDU6fJjkkdxix7g0sORxGBisk5o76yiNFf8NhGpu
         zVXKa2U8exmGY+7n+A6RWwhemNkgj+QFI8vMNYkwlH60w+xC19MUxzGkn2zVNMdVK9Tr
         lyETDGvs5Zk5S5GKokofEc9NcC/kfV9kWiihbtAeptbOrX7VGxMeQIIaZo+iJoYZ+Pjw
         q3uTNLy93FZE+DnWu41zUxB+sCgUrfCHWtYwkK36nNFxlf7wqjTki2MQpqRrTOl7v11k
         ZYEMGGxIUl/T2Cc0Qwicu7rXbdopZc9ajkx1TQJDrIRjGsn9Pzb4iGTr16qJFTbzCDh9
         osyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/fnirGe+UEdM6gLPxeyAhDbf8WnoU77O3LvcE+alXcI=;
        b=DVKj64bxFoBDw1zNSMqhf9xecjm4lF9144GW258poS/P+Um0aGMsQFs2xll3HF4BDT
         RkWpzbtY54cAMtOM4l6iGVDyD4JawoRR+b5uFdkwjyO2TgV+v2oc4soQDAoiezpTaFGL
         vn0qeZzV3b6IazY68cE2VXVCwYntCeAiX3Y3wph9GoiVDlCHJsKHK2ZaTabdU9b+dmMH
         jxHXZutLDs+l0OnJCxdNxK5ooDCBjZfp1uEpvY20LnSARfday9J1T7s/sqtjI5t6Yj1U
         d3itIb8tiRrxdwqtu2lj8h9FWD9VyZvdvu99W5I2tK/CDIT7oRtg9C6Niti/smAaB3J1
         Bx8A==
X-Gm-Message-State: APjAAAUMotMwyei+H5GBGxhXiU8AyD6eeo4xLpuGfSyNgBRywRNFx5BB
        +IWU8ZqVrfJQ1M0l+JjAVTFvng99DY+VOxXYDTOTBJdu5UI=
X-Google-Smtp-Source: APXvYqz4kp6S1mGTDLdfbXY0282bMEq7CsCkzv1u5DNE+FFV9WGf3/Jg/9mmLwo/GJdRnhmDTwQRQTBeA1LOyCm03z4=
X-Received: by 2002:a9f:2372:: with SMTP id 105mr2715141uae.85.1560272638784;
 Tue, 11 Jun 2019 10:03:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190611092144.11194-1-oded.gabbay@gmail.com> <20190611095857.GB24058@kroah.com>
 <20190611151753.GA11404@infradead.org> <20190611152655.GA3972@kroah.com>
In-Reply-To: <20190611152655.GA3972@kroah.com>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Tue, 11 Jun 2019 20:03:31 +0300
Message-ID: <CAFCwf13A73AxKzaa7Dk3tU-1NDgTFs4+xCO2os7SuSyUHZ9Z3Q@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] habanalabs: enable 64-bit DMA mask in POWER9
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 6:26 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Jun 11, 2019 at 08:17:53AM -0700, Christoph Hellwig wrote:
> > On Tue, Jun 11, 2019 at 11:58:57AM +0200, Greg KH wrote:
> > > That feels like a big hack.  ppc doesn't have any "what arch am I
> > > running on?" runtime call?  Did you ask on the ppc64 mailing list?  I'm
> > > ok to take this for now, but odds are you need a better fix for this
> > > sometime...
> >
> > That isn't the worst part of it.  The whole idea of checking what I'm
> > running to set a dma mask just doesn't make any sense at all.
>
> Oded, I thought I asked if there was a dma call you should be making to
> keep this type of check from being needed.  What happened to that?  As
> Christoph points out, none of this should be needed, which is what I
> thought I originally said :)
>
> thanks,
>
> greg k-h

I'm sorry, but it seems I can't explain what's my problem because you
and Christoph keep mentioning the pci_set_dma_mask() but it doesn't
help me.
I'll try again to explain.

The main problem specifically for Goya device, is that I can't call
this function with *the same parameter* for POWER9 and x86-64, because
x86-64 supports dma mask of 48-bits while POWER9 supports only 32-bits
or 64-bits.

The main limitation in my Goya device is that it can generate PCI
outbound transactions with addresses from 0 to (2^50 - 1).
That's why when we first integrated it in x86-64, we used a DMA mask
of 48-bits, by calling pci_set_dma_mask(pdev, 48). That way, the
kernel ensures me that all the DMA addresses are from 0 to (2^48 - 1),
and that address range is accessible by my device.

If for some reason, the x86-64 machine doesn't support 48-bits, the
standard fallback code in ALL the drivers I have seen is to set the
DMA mask to 32-bits. And that's how my current driver's code is
written.

Now, when I tried to integrate Goya into a POWER9 machine, I got a
reject from the call to pci_set_dma_mask(pdev, 48). The standard code,
as I wrote above, is to call the same function with 32-bits. That
works BUT it is not practical, as our applications require much more
memory mapped then 32-bits. In addition, once you add more cards which
are all mapped to the same range, it is simply not usable at all.

Therefore, I consulted with POWER people and they told me I can call
to pci_set_dma_mask with the mask as 64, but I must make sure that ALL
outbound transactions from Goya will be with bit 59 set in the
address.
I can achieve that with a dedicated configuration I make in Goya's
PCIe controller. That's what I did and that works.

So, to summarize:
If I call pci_set_dma_mask with 48, then it fails on POWER9. However,
in runtime, I don't know if its POWER9 or not, so upon failure I will
call it again with 32, which makes our device pretty much unusable.
If I call pci_set_dma_mask with 64, and do the dedicated configuration
in Goya's PCIe controller, then it won't work on x86-64, because bit
59 will be set and the host won't like it (I checked it). In addition,
I might get addresses above 50 bits, which my device can't generate.

I hope this makes things more clear. Now, please explain to me how I
can call pci_set_dma_mask without any regard to whether I run on
x86-64 or POWER9, considering what I wrote above ?

Thanks,
Oded
