Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68FC2C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4726F21901
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:33:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728715AbfGYOdc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 10:33:32 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:46382 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728420AbfGYOdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 10:33:32 -0400
Received: by mail-qk1-f195.google.com with SMTP id r4so36493599qkm.13
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 07:33:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eKIsWU0npz6No63lujiEyyyNu0/XoWzsuOpOvxmHals=;
        b=oHNZExrsfy++Oe6sHb9J8h3fI8605XTvBLn9PEPqYT+HSOR3yzVaP9SL/3YRHkku3A
         9lSs6qTJqc++k7f7Cu28vTpdS6jffiGJ7xtyMJ8/EYnZFMebF45GR7wJ/eT50+nfv3n/
         Tc3ENf6XmTFsX7vv8Q8PIekm+3F3ixW1BBDEcHYPjh/6hpsrSdWFJcJpiChv+RN3M1Ed
         Z0edKyg3e/m+hMNe224cmn1f/9dsMRQQaUwlmm6liaFsEFKgc/KeMqIu2lq9aOBcn5wA
         PFfW8L4pSlV0gyZHNrEe7NmtvltSdOKZKogS7CJ/1AGTxOAZfTAOS6pd9rpNJP3rDK3o
         uxmQ==
X-Gm-Message-State: APjAAAWDtPVMLtNGdv1uxcYuxYkPHcOVh39TmGoPiI97XKWW3oAoeZiY
        uC+YZHdLbWTROM7BV8ZoLNVVmw==
X-Google-Smtp-Source: APXvYqxuymRMR9PwjI/MnexZedK5auF5DqZvwLEybKqYcN9R+eg3mxGigkrHVwcv5rKEoznlC3TDrw==
X-Received: by 2002:a37:a40f:: with SMTP id n15mr55380902qke.19.1564065211618;
        Thu, 25 Jul 2019 07:33:31 -0700 (PDT)
Received: from redhat.com (bzq-79-181-91-42.red.bezeqint.net. [79.181.91.42])
        by smtp.gmail.com with ESMTPSA id j8sm21970801qki.85.2019.07.25.07.33.28
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 07:33:30 -0700 (PDT)
Date:   Thu, 25 Jul 2019 10:33:25 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Fam Zheng <zhengfeiran@bytedance.com>
Cc:     Fei Li <lifei.shirley@bytedance.com>, linux-kernel@vger.kernel.org,
        Jason Wang <jasowang@redhat.com>,
        Pawel Moll <pawel.moll@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: Re: [External Email] Re: [PATCH 1/2] virtio-mmio: Process vrings
 more proactively
Message-ID: <20190725103238-mutt-send-email-mst@kernel.org>
References: <20190719133135.32418-1-lifei.shirley@bytedance.com>
 <20190719133135.32418-2-lifei.shirley@bytedance.com>
 <20190719111440-mutt-send-email-mst@kernel.org>
 <5b29804b-528b-61bd-1ab6-4e442d360cf9@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b29804b-528b-61bd-1ab6-4e442d360cf9@bytedance.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 10:28:30AM +0800, Fam Zheng wrote:
> 
> On 7/19/19 11:17 PM, Michael S. Tsirkin wrote:
> > On Fri, Jul 19, 2019 at 09:31:34PM +0800, Fei Li wrote:
> > > From: Fam Zheng <zhengfeiran@bytedance.com>
> > > 
> > > This allows the backend to _not_ trap mmio read of the status register
> > > after injecting IRQ in the data path, which can improve the performance
> > > significantly by avoiding a vmexit for each interrupt.
> > > 
> > > More importantly it also makes it possible for Firecracker to hook up
> > > virtio-mmio with vhost-net, in which case there isn't a way to implement
> > > proper status register handling.
> > > 
> > > For a complete backend that does set either INT_CONFIG bit or INT_VRING
> > > bit upon generating irq, what happens hasn't changed.
> > > 
> > > Signed-off-by: Fam Zheng <zhengfeiran@bytedance.com>
> > This has a side effect of skipping vring callbacks
> > if they trigger at the same time with a config
> > interrupt.
> > I don't see why this is safe.
> 
> Good point! I think the block can be moved out from the else block and run
> unconditionally then.
> 
> Fam


Won't same callback run from multiple irq handlers then?
Running multiple vring callbacks at the same time isn't
a good idea either.

> 
> > 
> > 
> > > ---
> > >   drivers/virtio/virtio_mmio.c | 4 +---
> > >   1 file changed, 1 insertion(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> > > index e09edb5c5e06..9b42502b2204 100644
> > > --- a/drivers/virtio/virtio_mmio.c
> > > +++ b/drivers/virtio/virtio_mmio.c
> > > @@ -295,9 +295,7 @@ static irqreturn_t vm_interrupt(int irq, void *opaque)
> > >   	if (unlikely(status & VIRTIO_MMIO_INT_CONFIG)) {
> > >   		virtio_config_changed(&vm_dev->vdev);
> > >   		ret = IRQ_HANDLED;
> > > -	}
> > > -
> > > -	if (likely(status & VIRTIO_MMIO_INT_VRING)) {
> > > +	} else {
> > >   		spin_lock_irqsave(&vm_dev->lock, flags);
> > >   		list_for_each_entry(info, &vm_dev->virtqueues, node)
> > >   			ret |= vring_interrupt(irq, info->vq);
> > > -- 
> > > 2.11.0
