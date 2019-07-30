Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B669C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 20:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D87782087F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 20:26:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728240AbfG3U0Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 16:26:24 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:37955 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727579AbfG3U0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 16:26:24 -0400
Received: by mail-vs1-f65.google.com with SMTP id k9so44524634vso.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 13:26:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=8d2fnAS3OQ8PaLiBpAHqC1O32vTJ8VVqG3Mu89Cd9xg=;
        b=Wau2RAXwdBM1bkPTJWuXbM4MWOB5JrrgyAHPgE5CQaC47LuKA+/Rh+Cxo/htbZiEo7
         9zVV0bw4v+xRzQCYGpovUknI0jqLmf1XTsyVEF57Ojg5Ngy7b0brO47GwZsKa3g5+BWy
         bWP3btwrB9GkSulcbKHQySmlLmlHu4h/CxuzJ7g0V5O411z5Qv/MvnjMnCZgDHbHQ+SO
         L7rvS2tEg3nYiqSHUYtAVFkg657OJDg/VcwanbikA1rFfXlWLYPox7QcsxIBT6P35g/Y
         No/onxBoHK/0X6ZQ0z1fcuz+2uUo91xbgVNsAnerBfGUpBvGweYWWDdHchEqvS41CC+k
         LgYA==
X-Gm-Message-State: APjAAAWDz0bYwqp5JuA90u9WZcxEeeuyPnc7wssuOojHnNatrRkQj7hs
        qxeHFASitvQ5P+1rVM7t1TvYqw==
X-Google-Smtp-Source: APXvYqzyCo2qGnWyQ/ivv1uIJQf/Mt6X1RWsrcRtAPwyboCMGKiKHlKAesrmakCIGRcWn0A8Jr4gEw==
X-Received: by 2002:a67:f495:: with SMTP id o21mr74811084vsn.54.1564518383217;
        Tue, 30 Jul 2019 13:26:23 -0700 (PDT)
Received: from redhat.com (bzq-79-181-91-42.red.bezeqint.net. [79.181.91.42])
        by smtp.gmail.com with ESMTPSA id t200sm28124441vke.5.2019.07.30.13.26.19
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 13:26:22 -0700 (PDT)
Date:   Tue, 30 Jul 2019 16:26:17 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     =?utf-8?B?5p2O6I+y?= <lifei.shirley@bytedance.com>
Cc:     virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org,
        Jason Wang <jasowang@redhat.com>,
        Pawel Moll <pawel.moll@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Fam Zheng <zhengfeiran@bytedance.com>
Subject: Re: [External Email] Re: [PATCH v1 0/2] virtio-mmio: support
 multiple interrupt vectors
Message-ID: <20190730162337-mutt-send-email-mst@kernel.org>
References: <20190719133135.32418-1-lifei.shirley@bytedance.com>
 <20190719110852-mutt-send-email-mst@kernel.org>
 <CA+=e4K5rn7-avNT3e07dfXkh=ZO2+RvthjqW15gZv-uFYrCs3A@mail.gmail.com>
 <20190722043707-mutt-send-email-mst@kernel.org>
 <CA+=e4K7ViADDq84i6ve1+F1=CrgfQJrY-O8LeBVV7eP4gUg21Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+=e4K7ViADDq84i6ve1+F1=CrgfQJrY-O8LeBVV7eP4gUg21Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 09:43:18PM +0800, 李菲 wrote:
> On Mon, Jul 22, 2019 at 4:39 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Jul 22, 2019 at 11:22:02AM +0800, 李菲 wrote:
> > > On Fri, Jul 19, 2019 at 11:14 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Fri, Jul 19, 2019 at 09:31:33PM +0800, Fei Li wrote:
> > > > > Hi,
> > > > >
> > > > > This patch series implements multiple interrupt vectors support for
> > > > > virtio-mmio device. This is especially useful for multiqueue vhost-net
> > > > > device when using firecracker micro-vms as the guest.
> > > > >
> > > > > Test result:
> > > > > With 8 vcpus & 8 net queues set, one vhost-net device with 8 irqs can
> > > > > receive 9 times more pps comparing with only one irq:
> > > > > - 564830.38 rxpck/s for 8 irqs on
> > > > > - 67665.06 rxpck/s for 1 irq on
> > > > >
> > > > > Please help to review, thanks!
> > > > >
> > > > > Have a nice day
> > > > > Fei
> > > >
> > > >
> > > > Interesting. The spec says though:
> > > >
> > > >         4.2.3.4
> > > >         Notifications From The Device
> > > >         The memory mapped virtio device is using a single, dedicated interrupt signal, which is asserted when at
> > > >         least one of the bits described in the description of InterruptStatus is set. This is how the device sends a
> > > >         used buffer notification or a configuration change notification to the device.
> > > >
> > > Yes, the spec needs to be updated if we want to use mult-irqs.
> > > >
> > > > So I'm guessing we need to change the host/guest interface?
> > > Just to confirm, does the "the host/guest interface" you mentioned mean how to
> > > pass the irq information from the user space tool to guest kernel?
> > > In this patch, we do this by passing the [irq_start, irq_end]
> > > interface via setting guest
> > > kernel command line, that is done in vm_cmdline_set().
> > > Also there is another way to do this: add two new registers describing irq info
> > > (irq_start & irq_end OR irq_start & irq_numbers) to the virtio config space.
> > >
> > > Which one do you prefer?
> >
> > I'm not sure - so far irq was passed on the command line, right?
> Yes.
> >
> > The first step in implementing any spec change would be to update qemu
> > code to virtio 1. Which is not a huge project but so far no one
> > bothered.
> Emm, actually I only did the test with using firecracker to start a
> micro-vm, but without qemu.
> To be honest, the reason why implementing multi-irq on virtio-mmio is
> mainly because the
> current firecracker using virtio-mmio device and it has no pci thing,
> thus no msi/msix to
> handle the interruptions.
> On the other hand, considering pci is well supported in qemu, I am
> wondering whether we
> still need this. If needed, we would like to do this. :)
> 
> Have a nice day, thanks
> Fei


Sergio Lopez is now working on updating mmio to v1 support in qemu.
Maybe get in touch with him on how he looks at this extension.

Not asking you to work on qemu, but it makes sense
to get an ack for guest bits from another popular hypervisor.



> >
> >
> > > > If true pls cc virtio-dev.
> > > Sure.
> > > >
> > > > Also, do we need to update dt bindings documentation?
> > > You mean the following doc? Sure. :)
> > > https://github.com/torvalds/linux/blob/master/Documentation/devicetree/bindings/virtio/mmio.txt
> > >
> > > Thanks for the review!
> > >
> > > Have a nice day
> > > Fei
> > >
> > >
> > > >
> > > > >
> > > > > Fam Zheng (1):
> > > > >   virtio-mmio: Process vrings more proactively
> > > > >
> > > > > Fei Li (1):
> > > > >   virtio-mmio: support multiple interrupt vectors
> > > > >
> > > > >  drivers/virtio/virtio_mmio.c | 238 +++++++++++++++++++++++++++++++++++--------
> > > > >  1 file changed, 196 insertions(+), 42 deletions(-)
> > > > >
> > > > > --
> > > > > 2.11.0
