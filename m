Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F1AC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 11:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D58F4206A3
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 11:01:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392207AbfHBLBO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 07:01:14 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41837 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729751AbfHBLBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 07:01:13 -0400
Received: by mail-wr1-f67.google.com with SMTP id c2so73496196wrm.8
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2019 04:01:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=+VheU4fXBKJ7f6AGSTFH1gY5Af90v9UL4C0cGsvHyUY=;
        b=KY6cuaDO7+ukRZWeglxdCFIE2FdswXJWE50BrpPhqJvz0CtVg+x7jeuDViqEnrKCxD
         nnOPodXYuH5MmvBSkt2bXLu7dM6MbztIc1Lz+rk+4OTqz999tJQGm6nWxicfjBP5ccL+
         xftL+MZUQJ6fSntf9/vo2AKf7/YTNNOGOhR8u1JunnbIGs4xKRZi6nzM8Rz1zYbJld3c
         Dj7R1YZtjEVLz29ec0nRX8T3tx64Et431lpa7XS4efsKOTFzaSYhycbMC41jjxlGBKso
         kXRgADCoZrCyLKvw/3rWnDswFHdDXGDsVUVNBmuiuUmMYgE/HNuytNlXo0RRQrpe91Y0
         Hdqw==
X-Gm-Message-State: APjAAAVnBEA0bbJ7QZ8kd5xYDFQuJqGPCCcCq0pU8C4Lb5C3iaspXMN6
        0LPX1TvEya09Q0WsGBHADL5JDOAl45I=
X-Google-Smtp-Source: APXvYqz0WOuMnD5RN6Uz9Isomdcpsx6kA/bTFk9DZN7zg9aPgheUq3AATUGRQCM1LNqGM5+uUVkj6A==
X-Received: by 2002:adf:f812:: with SMTP id s18mr9787719wrp.32.1564743671061;
        Fri, 02 Aug 2019 04:01:11 -0700 (PDT)
Received: from dritchie.redhat.com (18.red-83-35-20.dynamicip.rima-tde.net. [83.35.20.18])
        by smtp.gmail.com with ESMTPSA id x6sm79220965wrt.63.2019.08.02.04.01.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 02 Aug 2019 04:01:10 -0700 (PDT)
References: <20190719133135.32418-1-lifei.shirley@bytedance.com> <20190719110852-mutt-send-email-mst@kernel.org> <CA+=e4K5rn7-avNT3e07dfXkh=ZO2+RvthjqW15gZv-uFYrCs3A@mail.gmail.com> <20190722043707-mutt-send-email-mst@kernel.org> <CA+=e4K7ViADDq84i6ve1+F1=CrgfQJrY-O8LeBVV7eP4gUg21Q@mail.gmail.com> <20190730162337-mutt-send-email-mst@kernel.org> <CA+=e4K6P++n_mHEbsR_a3Er214DEq=RXBuX2_BuQfQ_B15OdAA@mail.gmail.com>
User-agent: mu4e 1.2.0; emacs 26.2
From:   Sergio Lopez <slp@redhat.com>
To:     =?utf-8?B?5p2O6I+y?= <lifei.shirley@bytedance.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org,
        Jason Wang <jasowang@redhat.com>,
        Pawel Moll <pawel.moll@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Fam Zheng <zhengfeiran@bytedance.com>,
        Xiongchun Duan <duanxiongchun@bytedance.com>
Subject: Re: [External Email] Re: [PATCH v1 0/2] virtio-mmio: support multiple interrupt vectors
In-reply-to: <CA+=e4K6P++n_mHEbsR_a3Er214DEq=RXBuX2_BuQfQ_B15OdAA@mail.gmail.com>
Date:   Fri, 02 Aug 2019 13:01:00 +0200
Message-ID: <87tvaz25n7.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


=E6=9D=8E=E8=8F=B2 <lifei.shirley@bytedance.com> writes:

> On Wed, Jul 31, 2019 at 4:26 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>>
>> On Mon, Jul 22, 2019 at 09:43:18PM +0800, =E6=9D=8E=E8=8F=B2 wrote:
>> > On Mon, Jul 22, 2019 at 4:39 PM Michael S. Tsirkin <mst@redhat.com> wr=
ote:
>> > >
>> > > On Mon, Jul 22, 2019 at 11:22:02AM +0800, =E6=9D=8E=E8=8F=B2 wrote:
>> > > > On Fri, Jul 19, 2019 at 11:14 PM Michael S. Tsirkin <mst@redhat.co=
m> wrote:
>> > > > >
>> > > > > On Fri, Jul 19, 2019 at 09:31:33PM +0800, Fei Li wrote:
>> > > > > > Hi,
>> > > > > >
>> > > > > > This patch series implements multiple interrupt vectors suppor=
t for
>> > > > > > virtio-mmio device. This is especially useful for multiqueue v=
host-net
>> > > > > > device when using firecracker micro-vms as the guest.
>> > > > > >
>> > > > > > Test result:
>> > > > > > With 8 vcpus & 8 net queues set, one vhost-net device with 8 i=
rqs can
>> > > > > > receive 9 times more pps comparing with only one irq:
>> > > > > > - 564830.38 rxpck/s for 8 irqs on
>> > > > > > - 67665.06 rxpck/s for 1 irq on
>> > > > > >
>> > > > > > Please help to review, thanks!
>> > > > > >
>> > > > > > Have a nice day
>> > > > > > Fei
>> > > > >
>> > > > >
>> > > > > Interesting. The spec says though:
>> > > > >
>> > > > >         4.2.3.4
>> > > > >         Notifications From The Device
>> > > > >         The memory mapped virtio device is using a single, dedic=
ated interrupt signal, which is asserted when at
>> > > > >         least one of the bits described in the description of In=
terruptStatus is set. This is how the device sends a
>> > > > >         used buffer notification or a configuration change notif=
ication to the device.
>> > > > >
>> > > > Yes, the spec needs to be updated if we want to use mult-irqs.
>> > > > >
>> > > > > So I'm guessing we need to change the host/guest interface?
>> > > > Just to confirm, does the "the host/guest interface" you mentioned=
 mean how to
>> > > > pass the irq information from the user space tool to guest kernel?
>> > > > In this patch, we do this by passing the [irq_start, irq_end]
>> > > > interface via setting guest
>> > > > kernel command line, that is done in vm_cmdline_set().
>> > > > Also there is another way to do this: add two new registers descri=
bing irq info
>> > > > (irq_start & irq_end OR irq_start & irq_numbers) to the virtio con=
fig space.
>> > > >
>> > > > Which one do you prefer?
>> > >
>> > > I'm not sure - so far irq was passed on the command line, right?
>> > Yes.
>> > >
>> > > The first step in implementing any spec change would be to update qe=
mu
>> > > code to virtio 1. Which is not a huge project but so far no one
>> > > bothered.
>> > Emm, actually I only did the test with using firecracker to start a
>> > micro-vm, but without qemu.
>> > To be honest, the reason why implementing multi-irq on virtio-mmio is
>> > mainly because the
>> > current firecracker using virtio-mmio device and it has no pci thing,
>> > thus no msi/msix to
>> > handle the interruptions.
>> > On the other hand, considering pci is well supported in qemu, I am
>> > wondering whether we
>> > still need this. If needed, we would like to do this. :)
>> >
>> > Have a nice day, thanks
>> > Fei
>>
>>
>> Sergio Lopez is now working on updating mmio to v1 support in qemu.
>> Maybe get in touch with him on how he looks at this extension.
> Thanks for the info! :)
>
> Hi Sergio Lopez,
> I saw your [virtio-mmio: modern (v2)] patch series in Qemu mailing
> list, thanks for moving this on.
> And long Story Short, these two kernel patches is to add the multi-irq
> support for virtio-mmio driver.
> As this involves the spec change and you are now implementing
> virtio-mmio v2, could you help to
> give some suggestions on this extension?
> I will cc you the original patch soon, thanks.

I like having the possibility of using multiple irq lines for a single
virtio-mmio, but I think having to specify an irq range for each device
is a bit inconvenient.

Usually, you want an irq line per each virtqueue. So, ideally, irq
assignment should be somehow linked to the virtqueue initialization. But
this isn't PCI, so the Guest can't simply request some MSI/MSI-X
vectors and tell the device about them, as virtio-pci does.

I think an option could be extending the specification with a new
QueueVector read-only register, which would return either the irq line
to be used for the virtqueue selected by QueueSel, or a value indicating
there isn't a dedicated line for this particular virtqueue.

This way, hypervisors could lazily allocate irq lines on demand when
the QueueVector is read for the first time (or after a reset), and
users (and fdt's) would still only need to specify a single interrupt
for each virtio-mmio definition.

>> Not asking you to work on qemu, but it makes sense
>> to get an ack for guest bits from another popular hypervisor.
> I agree, absolutely right. And I once work on Qemu development, hope
> the combined
> background could help to move this multi-irq feature forward. :)
>
>
> Have a nice day, many thanks
> Fei
>>
>>
>> > >
>> > >
>> > > > > If true pls cc virtio-dev.
>> > > > Sure.
>> > > > >
>> > > > > Also, do we need to update dt bindings documentation?
>> > > > You mean the following doc? Sure. :)
>> > > > https://github.com/torvalds/linux/blob/master/Documentation/device=
tree/bindings/virtio/mmio.txt
>> > > >
>> > > > Thanks for the review!
>> > > >
>> > > > Have a nice day
>> > > > Fei
>> > > >
>> > > >
>> > > > >
>> > > > > >
>> > > > > > Fam Zheng (1):
>> > > > > >   virtio-mmio: Process vrings more proactively
>> > > > > >
>> > > > > > Fei Li (1):
>> > > > > >   virtio-mmio: support multiple interrupt vectors
>> > > > > >
>> > > > > >  drivers/virtio/virtio_mmio.c | 238 ++++++++++++++++++++++++++=
+++++++++--------
>> > > > > >  1 file changed, 196 insertions(+), 42 deletions(-)
>> > > > > >
>> > > > > > --
>> > > > > > 2.11.0


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl1EF+wACgkQ9GknjS8M
AjVGYw/8C7rP00l7sGK7IiCnxYa2WyKvoGxJmZ3TRPU4cKzwsIvYRwkRuKkbSVu1
Dp+VyQ3CANXLVGRlmfy7BwC4S79He3Ib3SL/+Ia8fQHa8XcjpyMgd4U/f9KIPvb9
gZjcBEbwQCPUvNciaoWj3IqD0c+IG15OTpf9WfL+zMFUGyoZRvTkUyxnI9tlMHW9
ErevPUxs3UvMNlEMg2FqCDtsKpxeM1navNH/WRzJ/J3+lazyaiNrU3g78V4ON5xl
HyoU+1Tkwka2INBCC8sU8ejsmn+XFB13ZaM88/O52bzqj9OtA6AyBp9zGmdFI9iX
85JDsUG6SaR+tjN4tGXl2ssrt20Cs10M3YsgBCvuoPIFh4cRvf+ea44VCmXeJ8Aq
IG8hamTjJKjjtMx/YgwpsOM7+mg95P79EI1E7KPQ3agedZ4nIDXCqHrxuApkmRE7
lQWRJo7BnWvtahcWK0NMu1x3oOvBiS2EAuXOHWFYMLM6STyIJK11Zje1ozdXp6Vg
VMxeUWu6H+ffBnUoM13vVSHmY4vogsVM0a/lxAjBc02n84yp7Bh3vY4B/JR8ePWP
SYdDsjXmXaA3ut8IrQynhYACPc1QDtLUEKAkIzuJPx88iOXzDm/iqbbYz3i5QZjF
AZXnUrT5fReqDoAPFQkBxaQyWGlzVpw7yK0E5qBd0Sq9cEVfYV8=
=2R22
-----END PGP SIGNATURE-----
--=-=-=--
