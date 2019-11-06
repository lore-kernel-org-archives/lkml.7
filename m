Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C3BEC5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 15:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EE142178F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 15:03:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731842AbfKFPDL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 10:03:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49686 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727275AbfKFPDK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 10:03:10 -0500
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 395CFC04BD40
        for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2019 15:03:10 +0000 (UTC)
Received: by mail-qk1-f197.google.com with SMTP id 64so25063715qkm.5
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 07:03:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F6ynqqIbM2TOAD7hLFicRunvQIveutT6wIB583FFBto=;
        b=RasCenhX5fSHvYuLUpO2n6mEmnK/vKU+QhFdt7FdX/qBsRAvhw5c/cEvxesPYaT3SK
         rF54MLN2njQzyVIHWwHZUeMrw6LVusRQHuptnjmbW/gwmNFdXFEubvJi3ScPCbLvGOB6
         FQmVc78ix/UxhdTcD5cbKNG6JwJMbkLzm+IqbKAGGYG5FxMh9ZrLuBTPgROYL3PcGBbL
         KK50ohWh7Fc0TiBoMV7euqjumPPGbbF8XCWNP+MKximGlkqdizyfdGjGLmrISNtUQbbO
         0OWIihdXBVgof4fBAQJJMDKhu86vQt3tjm9qda2nTI6kMZEoqERB0SGnqDmEVeQZtirT
         jxkg==
X-Gm-Message-State: APjAAAXFs12i4vJ/5zQnjy5/i9ZZd6xHbzsPks6KqABlMZVF8kYg0N4q
        tEJ+8sudHPx39OrZXKlhW5I+B0gHU/T+t64qqKuv1W6Fe5LReaVGZALlQ9KRYCALkTOkZTT6PLZ
        z60yo+Md9VTlvbRNOcfgLH33q
X-Received: by 2002:a05:6214:6f2:: with SMTP id bk18mr2645488qvb.10.1573052589483;
        Wed, 06 Nov 2019 07:03:09 -0800 (PST)
X-Google-Smtp-Source: APXvYqzB6sR4iapHLMS9Rizs1m4GAhzYFfaFlAKVqoBEWSYBG3RuIIJ8NVNFKQELCmo/CWRJnkNJUQ==
X-Received: by 2002:a05:6214:6f2:: with SMTP id bk18mr2645450qvb.10.1573052589102;
        Wed, 06 Nov 2019 07:03:09 -0800 (PST)
Received: from redhat.com (bzq-79-178-12-128.red.bezeqint.net. [79.178.12.128])
        by smtp.gmail.com with ESMTPSA id o195sm12264065qke.35.2019.11.06.07.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 07:03:08 -0800 (PST)
Date:   Wed, 6 Nov 2019 10:03:02 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Laurent Vivier <lvivier@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Amit Shah <amit@kernel.org>,
        virtualization@lists.linux-foundation.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] virtio_console: allocate inbufs in add_port() only if it
 is needed
Message-ID: <20191106095707-mutt-send-email-mst@kernel.org>
References: <20191018164718.15999-1-lvivier@redhat.com>
 <20191106085548-mutt-send-email-mst@kernel.org>
 <83d88904-1626-8dd6-9e5c-7abcee27bcd0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83d88904-1626-8dd6-9e5c-7abcee27bcd0@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2019 at 03:02:25PM +0100, Laurent Vivier wrote:
> On 06/11/2019 14:56, Michael S. Tsirkin wrote:
> > On Fri, Oct 18, 2019 at 06:47:18PM +0200, Laurent Vivier wrote:
> >> When we hot unplug a virtserialport and then try to hot plug again,
> >> it fails:
> >>
> >> (qemu) chardev-add socket,id=serial0,path=/tmp/serial0,server,nowait
> >> (qemu) device_add virtserialport,bus=virtio-serial0.0,nr=2,\
> >>                   chardev=serial0,id=serial0,name=serial0
> >> (qemu) device_del serial0
> >> (qemu) device_add virtserialport,bus=virtio-serial0.0,nr=2,\
> >>                   chardev=serial0,id=serial0,name=serial0
> >> kernel error:
> >>   virtio-ports vport2p2: Error allocating inbufs
> >> qemu error:
> >>   virtio-serial-bus: Guest failure in adding port 2 for device \
> >>                      virtio-serial0.0
> >>
> >> This happens because buffers for the in_vq are allocated when the port is
> >> added but are not released when the port is unplugged.
> >>
> >> They are only released when virtconsole is removed (see a7a69ec0d8e4)
> >>
> >> To avoid the problem and to be symmetric, we could allocate all the buffers
> >> in init_vqs() as they are released in remove_vqs(), but it sounds like
> >> a waste of memory.
> >>
> >> Rather than that, this patch changes add_port() logic to only allocate the
> >> buffers if the in_vq has available free slots.
> >>
> >> Fixes: a7a69ec0d8e4 ("virtio_console: free buffers after reset")
> >> Cc: mst@redhat.com
> >> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> >> ---
> >>  drivers/char/virtio_console.c | 17 +++++++++++------
> >>  1 file changed, 11 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
> >> index 7270e7b69262..77105166fe01 100644
> >> --- a/drivers/char/virtio_console.c
> >> +++ b/drivers/char/virtio_console.c
> >> @@ -1421,12 +1421,17 @@ static int add_port(struct ports_device *portdev, u32 id)
> >>  	spin_lock_init(&port->outvq_lock);
> >>  	init_waitqueue_head(&port->waitqueue);
> >>  
> >> -	/* Fill the in_vq with buffers so the host can send us data. */
> >> -	nr_added_bufs = fill_queue(port->in_vq, &port->inbuf_lock);
> >> -	if (!nr_added_bufs) {
> >> -		dev_err(port->dev, "Error allocating inbufs\n");
> >> -		err = -ENOMEM;
> >> -		goto free_device;
> >> +	/* if the in_vq has not already been filled (the port has already been
> >> +	 * used and unplugged), fill the in_vq with buffers so the host can
> >> +	 * send us data.
> >> +	 */
> >> +	if (port->in_vq->num_free != 0) {
> >> +		nr_added_bufs = fill_queue(port->in_vq, &port->inbuf_lock);
> >> +		if (!nr_added_bufs) {
> >> +			dev_err(port->dev, "Error allocating inbufs\n");
> >> +			err = -ENOMEM;
> >> +			goto free_device;
> >> +		}
> >>  	}
> >>  
> >>  	if (is_rproc_serial(port->portdev->vdev))
> > 
> > Well fill_queue will just add slots as long as it can.
> > So on a full queue it does nothing. How does this patch help?
> 
> Yes, but in this case it returns 0 and so add_port() fails and exits
> with -ENOMEM and the device is freed. It's what this patch tries to avoid.
> 
> Thanks,
> Laurent

Oh I see. However it's a bit asymmetrical to special case ring full.
How about making fill_queue return int and testing return code for
-ENOSPC instead? Will also help propagate errors correctly.

And I guess CC stable?

-- 
MST

