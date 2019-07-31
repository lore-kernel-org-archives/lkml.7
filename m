Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42573C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 04:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C718F206A2
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 04:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="W7FDhyZk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbfGaEE7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 00:04:59 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45485 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbfGaEE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 00:04:59 -0400
Received: by mail-lj1-f194.google.com with SMTP id m23so64108406lje.12
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 21:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=B43FLrEVogj/kc4jOi+o2UmeNa0dyjJfYgWWXRm95cM=;
        b=W7FDhyZkAOOFAaEizlcXpuDUQhD02SbIndufT4uif6J8qZ2XLhurGCwQJinCZLxvwV
         BcmU0MF9pjz5JMvelyQv9ywe4dpQFiz73lMVP/thvergFZYLKTqmdJxWV2WqkADZ6ZEo
         kbxkEzqsJNTJjUXTf/jPU9KCTZZmgYAMTxc4XS8GtldWhHRXwm9KFOvUfOTapuwmRiBt
         qpEvvC41R5qOmMYUiI/+wYkNqDsF9YxXzZ18uKabDZKKWXoUIG8uhiS0xZP+FClH2d/v
         BD7U+hhfBXdzbOaJFiTnzNDTrUWwYI64kSU0y8gamlKm/fqgCQ+K2Tb/LhCYE4+Bqd/M
         DQtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=B43FLrEVogj/kc4jOi+o2UmeNa0dyjJfYgWWXRm95cM=;
        b=B4CqEt4Yu34WvMlFz2meEV8JiaSSYR1Uxq9lUFbcT8rVpuIG5xA/CDxhxFsAnu1JAr
         c7EH3YYp+I0mggKUPs2yq2O94ViKAg3p+ExZoMAOxDbdFXu/mFP+rbqkrFvXAN0x6jxA
         zgHNRaKugEUd6PWPRGMUJ3wmcFt2qOOxHl7zYyHwo7QLV2js1TOUbddZ4VQ2U7sjHLiD
         wyChBYmOH3+yrNRrdTuP/6j/M4F/R1A53o8OAQZw9yD07smorI3WRGf44Pf3RBvsFwIc
         1IONjIy7oR7RFCcQIAx/Wf9mASI8IFzRyM4gCHdPVjVfo7xvnPz6I2ZyJXfUKT/sjO66
         cUog==
X-Gm-Message-State: APjAAAUWPglM91m7/5e952UiiDmkODVRUcOIEpWnkn05PBwhkqNccuz/
        MqvdCD/r0gQ562LLvm6alq1ZsMMSO6tNnkTtcWHWQg==
X-Google-Smtp-Source: APXvYqzmqCb7ZL+ky+7JycKz/nVUTr0DwuHHkAP/d/+1cbFnXt6JCcxkYHIuxbRuCSpiuGOq1MU2jYSQ1lVlaQlZrwY=
X-Received: by 2002:a05:651c:1105:: with SMTP id d5mr19034283ljo.161.1564545896415;
 Tue, 30 Jul 2019 21:04:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190719133135.32418-1-lifei.shirley@bytedance.com>
 <20190719110852-mutt-send-email-mst@kernel.org> <CA+=e4K5rn7-avNT3e07dfXkh=ZO2+RvthjqW15gZv-uFYrCs3A@mail.gmail.com>
 <20190722043707-mutt-send-email-mst@kernel.org> <CA+=e4K7ViADDq84i6ve1+F1=CrgfQJrY-O8LeBVV7eP4gUg21Q@mail.gmail.com>
 <20190730162337-mutt-send-email-mst@kernel.org>
In-Reply-To: <20190730162337-mutt-send-email-mst@kernel.org>
From:   =?UTF-8?B?5p2O6I+y?= <lifei.shirley@bytedance.com>
Date:   Wed, 31 Jul 2019 12:04:45 +0800
Message-ID: <CA+=e4K6P++n_mHEbsR_a3Er214DEq=RXBuX2_BuQfQ_B15OdAA@mail.gmail.com>
Subject: Re: [External Email] Re: [PATCH v1 0/2] virtio-mmio: support multiple
 interrupt vectors
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Sergio Lopez <slp@redhat.com>
Cc:     virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org,
        Jason Wang <jasowang@redhat.com>,
        Pawel Moll <pawel.moll@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Fam Zheng <zhengfeiran@bytedance.com>,
        Xiongchun Duan <duanxiongchun@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2019 at 4:26 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Jul 22, 2019 at 09:43:18PM +0800, =E6=9D=8E=E8=8F=B2 wrote:
> > On Mon, Jul 22, 2019 at 4:39 PM Michael S. Tsirkin <mst@redhat.com> wro=
te:
> > >
> > > On Mon, Jul 22, 2019 at 11:22:02AM +0800, =E6=9D=8E=E8=8F=B2 wrote:
> > > > On Fri, Jul 19, 2019 at 11:14 PM Michael S. Tsirkin <mst@redhat.com=
> wrote:
> > > > >
> > > > > On Fri, Jul 19, 2019 at 09:31:33PM +0800, Fei Li wrote:
> > > > > > Hi,
> > > > > >
> > > > > > This patch series implements multiple interrupt vectors support=
 for
> > > > > > virtio-mmio device. This is especially useful for multiqueue vh=
ost-net
> > > > > > device when using firecracker micro-vms as the guest.
> > > > > >
> > > > > > Test result:
> > > > > > With 8 vcpus & 8 net queues set, one vhost-net device with 8 ir=
qs can
> > > > > > receive 9 times more pps comparing with only one irq:
> > > > > > - 564830.38 rxpck/s for 8 irqs on
> > > > > > - 67665.06 rxpck/s for 1 irq on
> > > > > >
> > > > > > Please help to review, thanks!
> > > > > >
> > > > > > Have a nice day
> > > > > > Fei
> > > > >
> > > > >
> > > > > Interesting. The spec says though:
> > > > >
> > > > >         4.2.3.4
> > > > >         Notifications From The Device
> > > > >         The memory mapped virtio device is using a single, dedica=
ted interrupt signal, which is asserted when at
> > > > >         least one of the bits described in the description of Int=
erruptStatus is set. This is how the device sends a
> > > > >         used buffer notification or a configuration change notifi=
cation to the device.
> > > > >
> > > > Yes, the spec needs to be updated if we want to use mult-irqs.
> > > > >
> > > > > So I'm guessing we need to change the host/guest interface?
> > > > Just to confirm, does the "the host/guest interface" you mentioned =
mean how to
> > > > pass the irq information from the user space tool to guest kernel?
> > > > In this patch, we do this by passing the [irq_start, irq_end]
> > > > interface via setting guest
> > > > kernel command line, that is done in vm_cmdline_set().
> > > > Also there is another way to do this: add two new registers describ=
ing irq info
> > > > (irq_start & irq_end OR irq_start & irq_numbers) to the virtio conf=
ig space.
> > > >
> > > > Which one do you prefer?
> > >
> > > I'm not sure - so far irq was passed on the command line, right?
> > Yes.
> > >
> > > The first step in implementing any spec change would be to update qem=
u
> > > code to virtio 1. Which is not a huge project but so far no one
> > > bothered.
> > Emm, actually I only did the test with using firecracker to start a
> > micro-vm, but without qemu.
> > To be honest, the reason why implementing multi-irq on virtio-mmio is
> > mainly because the
> > current firecracker using virtio-mmio device and it has no pci thing,
> > thus no msi/msix to
> > handle the interruptions.
> > On the other hand, considering pci is well supported in qemu, I am
> > wondering whether we
> > still need this. If needed, we would like to do this. :)
> >
> > Have a nice day, thanks
> > Fei
>
>
> Sergio Lopez is now working on updating mmio to v1 support in qemu.
> Maybe get in touch with him on how he looks at this extension.
Thanks for the info! :)

Hi Sergio Lopez,
I saw your [virtio-mmio: modern (v2)] patch series in Qemu mailing
list, thanks for moving this on.
And long Story Short, these two kernel patches is to add the multi-irq
support for virtio-mmio driver.
As this involves the spec change and you are now implementing
virtio-mmio v2, could you help to
give some suggestions on this extension?
I will cc you the original patch soon, thanks.

> Not asking you to work on qemu, but it makes sense
> to get an ack for guest bits from another popular hypervisor.
I agree, absolutely right. And I once work on Qemu development, hope
the combined
background could help to move this multi-irq feature forward. :)


Have a nice day, many thanks
Fei
>
>
> > >
> > >
> > > > > If true pls cc virtio-dev.
> > > > Sure.
> > > > >
> > > > > Also, do we need to update dt bindings documentation?
> > > > You mean the following doc? Sure. :)
> > > > https://github.com/torvalds/linux/blob/master/Documentation/devicet=
ree/bindings/virtio/mmio.txt
> > > >
> > > > Thanks for the review!
> > > >
> > > > Have a nice day
> > > > Fei
> > > >
> > > >
> > > > >
> > > > > >
> > > > > > Fam Zheng (1):
> > > > > >   virtio-mmio: Process vrings more proactively
> > > > > >
> > > > > > Fei Li (1):
> > > > > >   virtio-mmio: support multiple interrupt vectors
> > > > > >
> > > > > >  drivers/virtio/virtio_mmio.c | 238 +++++++++++++++++++++++++++=
++++++++--------
> > > > > >  1 file changed, 196 insertions(+), 42 deletions(-)
> > > > > >
> > > > > > --
> > > > > > 2.11.0
