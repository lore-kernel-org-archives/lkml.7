Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2011C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 05:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7658720874
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 05:45:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MMp6AnWD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730642AbfFLFp3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 01:45:29 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:35542 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbfFLFp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 01:45:29 -0400
Received: by mail-io1-f66.google.com with SMTP id m24so11971519ioo.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 22:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MEsvB5fyfvbyP3599I1p81WWc20wTxokr+RDfF0sbmk=;
        b=MMp6AnWDzd6KBcaZ05OJj4lxPNM4qSHKTHwrNpVrZ6ybQr2zPK2djNtQPFmTBjpyxx
         3zMDD1ABcGN/hggjsojOwF5gDw0N019Go6xCg+jQbC7QiDEBY5KDb8L7w52J7wk6djL7
         LevIYXcqmW6kumT1P6CdW1N6dlNJqSod/jQGwFyfrxO9KW3vg1O+AbvCxC9omfwpbJwx
         Dnu/RNlSn4zHBIhPOU5lxN6jS8ksoqnzLrUm1/ofe2JegPxv5OcJh4+TmeVXvmsYE0mh
         8fSnavXYZBZDpnWmzWzIOiaOrHny6a71h2HBLD95a417HOxtpPywxe2+A16PcESVS/06
         pheg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MEsvB5fyfvbyP3599I1p81WWc20wTxokr+RDfF0sbmk=;
        b=lWK2GoOsbXV0A7SHJKNemDQJGTSxAGC/dq4UIMT32/uey/ZtKjl+qdvAx1YF9PVS3X
         UkIj7qIejWfIgQiY2ouSILgWCt1WLtUeJ+UjJpwCNKZhZyUqlOpC9EfAyP73MLAlJBbA
         s9r3JfMOyiWchi/rxEjbhKvcmWexoeDLOM28S6ERVzY4mFgthj3Suibrw1ChPIXbYiQd
         0tDlFIdfu1qGkrdY7xOzjsJUha2x9rqHbdt1NLuiCNZSVbikk+GavhE4iybmG0g2hKyq
         xyQ71OnikGS4MucWVhwhCX43yjJQuq+kHt1UiEHV0LiV/2oiYsiTYw3SGd3kZiR07LV2
         Z+Gw==
X-Gm-Message-State: APjAAAVqW4hP5CyEw5KRl80TrPe+934Qrhj/Wudkbt0gU1DVY2Am6zHJ
        JTNApF7NNiyuzoXgnUrPjJyeWn+WNW/bHuFpIfM=
X-Google-Smtp-Source: APXvYqyNZJk2JtmF9+zZry0oIFRzIeDg8CaNRuF7MiywyUo6BfIfixNhhb9KAbPbdN9/svG6rZSoslFGyGzak7gAUZE=
X-Received: by 2002:a5e:c70c:: with SMTP id f12mr31599418iop.293.1560318328476;
 Tue, 11 Jun 2019 22:45:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190611092144.11194-1-oded.gabbay@gmail.com> <20190611095857.GB24058@kroah.com>
 <20190611151753.GA11404@infradead.org> <20190611152655.GA3972@kroah.com>
 <CAFCwf13A73AxKzaa7Dk3tU-1NDgTFs4+xCO2os7SuSyUHZ9Z3Q@mail.gmail.com>
 <CAFCwf134nTD4FM_9Q+THQ7ZAZzGxhs15O6EheaRJMqM5wxi+aA@mail.gmail.com> <ca81ca5d56a3a12db5a92f5cf9745763a86572e8.camel@kernel.crashing.org>
In-Reply-To: <ca81ca5d56a3a12db5a92f5cf9745763a86572e8.camel@kernel.crashing.org>
From:   "Oliver O'Halloran" <oohall@gmail.com>
Date:   Wed, 12 Jun 2019 15:45:17 +1000
Message-ID: <CAOSf1CFcYnhKf0EJkm+E5uHg4e=QYGe+vAUz_TjX-v6UsmNtFA@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] habanalabs: enable 64-bit DMA mask in POWER9
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Oded Gabbay <oded.gabbay@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>, linuxppc-dev@ozlabs.org,
        Christoph Hellwig <hch@infradead.org>,
        Russell Currey <ruscur@au1.ibm.com>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 8:54 AM Benjamin Herrenschmidt
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
> As a result, getting it to work will require hacks. Some GPUs have
> similar issues and require similar hacks, it's unfortunate.
>
> Added a couple of guys on CC who might be able to help get those hacks
> right.

> It's still very fishy .. the idea is to detect the case where setting a
> 64-bit mask will give your system memory mapped at a fixed high address
> (1 << 59 in our case) and program that in your chip in the "Fixed high
> bits" register that you seem to have (also make sure it doesn't affect
> MSIs or it will break them).

Judging from the patch (https://lkml.org/lkml/2019/6/11/59) this is
what they're doing.

Also, are you sure about the MSI thing? The IODA3 spec says the only
important bits for a 64bit MSI are bits 61:60 (to hit the window) and
the lower bits that determine what IVE to use. Everything in between
is ignored so ORing in bit 59 shouldn't break anything.

> This will only work as long as all of the system memory can be
> addressed at an offset from that fixed address that itself fits your
> device addressing capabilities (50 bits in this case). It may or may
> not be the case but there's no way to check since the DMA mask logic
> won't really apply.
>
> You might want to consider fixing your HW in the next iteration... This
> is going to bite you when x86 increases the max physical memory for
> example, or on other architectures.

Yes, do this. The easiest way to avoid this sort of wierd hack is to
just design the PCIe interface to the spec in the first place.
