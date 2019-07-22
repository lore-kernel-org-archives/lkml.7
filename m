Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E80BBC76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 13:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B954121921
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 13:43:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="MFQ8IqvX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730572AbfGVNnb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 09:43:31 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45533 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727805AbfGVNnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 09:43:31 -0400
Received: by mail-lf1-f68.google.com with SMTP id u10so26645727lfm.12
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 06:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2eG7XaPVAlrCye8/1z4ZcsR1LBzuaJDGOK1lSLduhTA=;
        b=MFQ8IqvXcdMYGQ4zHiorDbSZYUKiXuPvw+Y39O6Ug8JUHCExyrAYZ6mFd70KuCGsWu
         Ro3lGp0PIcYG6UjQS9pHEejeii+F6ZhzgIwJP56RegyUDObsN6zfJJKCTFqdZZuF1Fpu
         mROnF6Kt0YBbooW2gli6pgsvK+P4qwi7W3YWkJK9N5CorF5g/c6VN/AGgXh3zhas4br1
         /EyJXSAJBK9J2bk3+gam8RjcZRTMZ6dX+aFfPerYdsOONEPSrEeTSaP89Uc8COdNQJ51
         UtIZz4TImneMpqLtzSS1m5dUwM5W679zahXLkBMBPBy5GqMhqS2C0ddZF+N4Zv9WIbzv
         +ndA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2eG7XaPVAlrCye8/1z4ZcsR1LBzuaJDGOK1lSLduhTA=;
        b=MT2tcdWDXsHCkSEtLVOQNMqGCdFtsplrFGmeIQE9KMH/fVShr1kclZnzQRn2gC1kg7
         2JFiRChnBaKjdLMVGqEmAwuURr8dMz5aS/MNZfdIC/iUvRK3JdM0EYGlUl1UAsniWAHA
         soTGMjpFIWL6ZAiORKS7TOldSL/UjnsHf+3hCJ8yGS52A5ywaafpWQU32iqlUGfNhFgE
         WkkeQZOJ9x3JSTZHKjWM3QwvvmOeOZETE6zTl6fxsK5d8buypW/3cpCR2i0qPb551bBJ
         zcURpmYIHQRoApo2fsuFrU18Zw6YrOUBm3YyDnHf6tIpFvNM77cs0uh+S8cbsPG9TCll
         5FiA==
X-Gm-Message-State: APjAAAVw8PvY7WP+bsYUbkZWDOp6q1RxADdKs6doydE5NHPbzpeEQTPQ
        4SltoUtfEmF7/36qfdxggnzXBiyCjzod/1biOZAzcg==
X-Google-Smtp-Source: APXvYqwyNWb9iHgAKI0DUSIdjf5QwgPISRe3Bpiwe+ysWhtEbDDI+5P2Fr2PNgoReoQpIIbhnT+cRwRd48QH5Q4PeIo=
X-Received: by 2002:ac2:4c84:: with SMTP id d4mr31806487lfl.1.1563803009167;
 Mon, 22 Jul 2019 06:43:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190719133135.32418-1-lifei.shirley@bytedance.com>
 <20190719110852-mutt-send-email-mst@kernel.org> <CA+=e4K5rn7-avNT3e07dfXkh=ZO2+RvthjqW15gZv-uFYrCs3A@mail.gmail.com>
 <20190722043707-mutt-send-email-mst@kernel.org>
In-Reply-To: <20190722043707-mutt-send-email-mst@kernel.org>
From:   =?UTF-8?B?5p2O6I+y?= <lifei.shirley@bytedance.com>
Date:   Mon, 22 Jul 2019 21:43:18 +0800
Message-ID: <CA+=e4K7ViADDq84i6ve1+F1=CrgfQJrY-O8LeBVV7eP4gUg21Q@mail.gmail.com>
Subject: Re: [External Email] Re: [PATCH v1 0/2] virtio-mmio: support multiple
 interrupt vectors
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org,
        Jason Wang <jasowang@redhat.com>,
        Pawel Moll <pawel.moll@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Fam Zheng <zhengfeiran@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 4:39 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Jul 22, 2019 at 11:22:02AM +0800, =E6=9D=8E=E8=8F=B2 wrote:
> > On Fri, Jul 19, 2019 at 11:14 PM Michael S. Tsirkin <mst@redhat.com> wr=
ote:
> > >
> > > On Fri, Jul 19, 2019 at 09:31:33PM +0800, Fei Li wrote:
> > > > Hi,
> > > >
> > > > This patch series implements multiple interrupt vectors support for
> > > > virtio-mmio device. This is especially useful for multiqueue vhost-=
net
> > > > device when using firecracker micro-vms as the guest.
> > > >
> > > > Test result:
> > > > With 8 vcpus & 8 net queues set, one vhost-net device with 8 irqs c=
an
> > > > receive 9 times more pps comparing with only one irq:
> > > > - 564830.38 rxpck/s for 8 irqs on
> > > > - 67665.06 rxpck/s for 1 irq on
> > > >
> > > > Please help to review, thanks!
> > > >
> > > > Have a nice day
> > > > Fei
> > >
> > >
> > > Interesting. The spec says though:
> > >
> > >         4.2.3.4
> > >         Notifications From The Device
> > >         The memory mapped virtio device is using a single, dedicated =
interrupt signal, which is asserted when at
> > >         least one of the bits described in the description of Interru=
ptStatus is set. This is how the device sends a
> > >         used buffer notification or a configuration change notificati=
on to the device.
> > >
> > Yes, the spec needs to be updated if we want to use mult-irqs.
> > >
> > > So I'm guessing we need to change the host/guest interface?
> > Just to confirm, does the "the host/guest interface" you mentioned mean=
 how to
> > pass the irq information from the user space tool to guest kernel?
> > In this patch, we do this by passing the [irq_start, irq_end]
> > interface via setting guest
> > kernel command line, that is done in vm_cmdline_set().
> > Also there is another way to do this: add two new registers describing =
irq info
> > (irq_start & irq_end OR irq_start & irq_numbers) to the virtio config s=
pace.
> >
> > Which one do you prefer?
>
> I'm not sure - so far irq was passed on the command line, right?
Yes.
>
> The first step in implementing any spec change would be to update qemu
> code to virtio 1. Which is not a huge project but so far no one
> bothered.
Emm, actually I only did the test with using firecracker to start a
micro-vm, but without qemu.
To be honest, the reason why implementing multi-irq on virtio-mmio is
mainly because the
current firecracker using virtio-mmio device and it has no pci thing,
thus no msi/msix to
handle the interruptions.
On the other hand, considering pci is well supported in qemu, I am
wondering whether we
still need this. If needed, we would like to do this. :)

Have a nice day, thanks
Fei
>
>
> > > If true pls cc virtio-dev.
> > Sure.
> > >
> > > Also, do we need to update dt bindings documentation?
> > You mean the following doc? Sure. :)
> > https://github.com/torvalds/linux/blob/master/Documentation/devicetree/=
bindings/virtio/mmio.txt
> >
> > Thanks for the review!
> >
> > Have a nice day
> > Fei
> >
> >
> > >
> > > >
> > > > Fam Zheng (1):
> > > >   virtio-mmio: Process vrings more proactively
> > > >
> > > > Fei Li (1):
> > > >   virtio-mmio: support multiple interrupt vectors
> > > >
> > > >  drivers/virtio/virtio_mmio.c | 238 +++++++++++++++++++++++++++++++=
++++--------
> > > >  1 file changed, 196 insertions(+), 42 deletions(-)
> > > >
> > > > --
> > > > 2.11.0
