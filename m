Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28777C76191
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 03:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 030CB21953
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 03:22:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="cDdCMvSv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbfGVDWP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 23:22:15 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37299 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726749AbfGVDWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 23:22:15 -0400
Received: by mail-lf1-f67.google.com with SMTP id c9so25461677lfh.4
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2019 20:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aAm6iRQPlrqd77BVpOEOx8I7+PSe0NwGfNRgqs6nZII=;
        b=cDdCMvSvKcnIW2NfjF1EyVuXtQjnzbihephboKIpmrwDerjhDGgQKdb/SnbaEVfSee
         4ukWvo0ljAj17DWU4/xeE1Z3yHnsUu93h7dVOcq+3QLg7tNXviQxtnwI9fT9mDmPSo68
         Xo1e8bSuPtgjuLwBJxduxee6B0j21J4FQ2EBWYF6dFYIihonnxuWrYEGMtm39LnmeX+C
         5UfrJiUfVYOqwWUnpnuxClsg8vmQx4roUu/yl4FQmsQORNKs+b05js9CpsV7JdaZ1Ecw
         kvEN1ynEMW7C+iX11ZeF1VC3ez/JQTlYhAQHK4gHyczkHflRb+Bgn7NcXb8dCA8hshDn
         kKgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aAm6iRQPlrqd77BVpOEOx8I7+PSe0NwGfNRgqs6nZII=;
        b=MkCf8Lw3e/RpGxWcN6W+6vyKD6XwuLHjdAB3F6ZoB7Z7Q5ALL8v46UxJ5Ew7qHxlWD
         On7FB7QADFmo9sCaSjIqXgvfX+2aNXm8xGCvE/9nfXsVzRV6F5mZOdKtUUw9QIkOjSK4
         OHToaGmbkYjZZWGzBtWR0u0kmNwGDQRDTqHfLbEHir5H9MYxF5vmkUDgq9YPWY/vIZ/+
         /fardJb63ASbmaemdZ/XnLQs60aKb3cjDHyBvek7j1eoYGXjC04WcseNnwLdL6IZVw3r
         X/JP4XIR9Xqgmx9LPy6AKC3HNf4VkGzeRpAKowkVUBj86HR+B4CFkU/MgpzdDNPYUhiW
         5L5A==
X-Gm-Message-State: APjAAAWCAH77aDzADZZfysJVDIBKYV0Mf4x11zso8+8LIkzmxLczpeRL
        r0U+4PF6I5XEElkKdYsreVtEhJI4F1f54rn21t2CWQ==
X-Google-Smtp-Source: APXvYqyNQFGODO1SuMBqEAOd91JrLxVN2pAN3l5K5e8lAiCRTWWBg8b2Me7gxUe9Dn1e/ZSWpTXjRWWu7Q9OKThwmzc=
X-Received: by 2002:a19:ca4b:: with SMTP id h11mr29019214lfj.162.1563765733032;
 Sun, 21 Jul 2019 20:22:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190719133135.32418-1-lifei.shirley@bytedance.com> <20190719110852-mutt-send-email-mst@kernel.org>
In-Reply-To: <20190719110852-mutt-send-email-mst@kernel.org>
From:   =?UTF-8?B?5p2O6I+y?= <lifei.shirley@bytedance.com>
Date:   Mon, 22 Jul 2019 11:22:02 +0800
Message-ID: <CA+=e4K5rn7-avNT3e07dfXkh=ZO2+RvthjqW15gZv-uFYrCs3A@mail.gmail.com>
Subject: Re: [External Email] Re: [PATCH v1 0/2] virtio-mmio: support multiple
 interrupt vectors
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        virtio-dev@lists.oasis-open.org
Cc:     linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        Pawel Moll <pawel.moll@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Fam Zheng <zhengfeiran@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2019 at 11:14 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Fri, Jul 19, 2019 at 09:31:33PM +0800, Fei Li wrote:
> > Hi,
> >
> > This patch series implements multiple interrupt vectors support for
> > virtio-mmio device. This is especially useful for multiqueue vhost-net
> > device when using firecracker micro-vms as the guest.
> >
> > Test result:
> > With 8 vcpus & 8 net queues set, one vhost-net device with 8 irqs can
> > receive 9 times more pps comparing with only one irq:
> > - 564830.38 rxpck/s for 8 irqs on
> > - 67665.06 rxpck/s for 1 irq on
> >
> > Please help to review, thanks!
> >
> > Have a nice day
> > Fei
>
>
> Interesting. The spec says though:
>
>         4.2.3.4
>         Notifications From The Device
>         The memory mapped virtio device is using a single, dedicated interrupt signal, which is asserted when at
>         least one of the bits described in the description of InterruptStatus is set. This is how the device sends a
>         used buffer notification or a configuration change notification to the device.
>
Yes, the spec needs to be updated if we want to use mult-irqs.
>
> So I'm guessing we need to change the host/guest interface?
Just to confirm, does the "the host/guest interface" you mentioned mean how to
pass the irq information from the user space tool to guest kernel?
In this patch, we do this by passing the [irq_start, irq_end]
interface via setting guest
kernel command line, that is done in vm_cmdline_set().
Also there is another way to do this: add two new registers describing irq info
(irq_start & irq_end OR irq_start & irq_numbers) to the virtio config space.

Which one do you prefer?

> If true pls cc virtio-dev.
Sure.
>
> Also, do we need to update dt bindings documentation?
You mean the following doc? Sure. :)
https://github.com/torvalds/linux/blob/master/Documentation/devicetree/bindings/virtio/mmio.txt

Thanks for the review!

Have a nice day
Fei


>
> >
> > Fam Zheng (1):
> >   virtio-mmio: Process vrings more proactively
> >
> > Fei Li (1):
> >   virtio-mmio: support multiple interrupt vectors
> >
> >  drivers/virtio/virtio_mmio.c | 238 +++++++++++++++++++++++++++++++++++--------
> >  1 file changed, 196 insertions(+), 42 deletions(-)
> >
> > --
> > 2.11.0
