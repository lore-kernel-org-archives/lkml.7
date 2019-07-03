Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCE2CC0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 10:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B5E1218A3
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 10:07:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfGCKHd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 06:07:33 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34891 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbfGCKHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 06:07:33 -0400
Received: by mail-wr1-f65.google.com with SMTP id c27so2106241wrb.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 03:07:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VNvFKH5K+pDMmuMUJ4DZzYn2K79WWFEugthw2tWzrCE=;
        b=L5bSJ23nDj0fE71yEvu5iWM3J99PcKGk5vVt9hfZSoLVC4vBxHNzXRu1aFMgA9zVOc
         o7SxFO3LWmFaSfblyzl2ERJzBxlwIv70ZvnDpXiDtZ+tlUr7Tdzkda1mE5XplWTccCar
         qxYlXKh3DhX02EtD+5yijdeMmTCgo0XMQwbUkPBAz7fYFyHU20vPRqRHj/O3xELtNFTr
         LXk74n5fpvUkib2ejjUHeLgnlOHH/SY79K6i/OkuJx7MHD0ftRrYz69xLcb2Nd4+F4AF
         BdGOfrQLFSfY6fJ7irQ9WNjvwgE5kATWzG7FuhXV7T+nbD5JL0JWYav5Aq2Z8NctAxMV
         LgJw==
X-Gm-Message-State: APjAAAWLbvawjiNDCAEx/Vx/SVH0TmuED2xwXFgLuRd+hiwLkQVyheFK
        GfrQ0X3/e4cdgqdadq7LdBC08A==
X-Google-Smtp-Source: APXvYqzGzHZlSIMty2RhAvvB1Uo0isxGnCtD5XKYMHI9/IRY2pIO6xkm3T2evQoOaleJYQ+jY3ZeIw==
X-Received: by 2002:adf:dfc4:: with SMTP id q4mr27669596wrn.54.1562148450882;
        Wed, 03 Jul 2019 03:07:30 -0700 (PDT)
Received: from steredhat (host21-207-dynamic.52-79-r.retail.telecomitalia.it. [79.52.207.21])
        by smtp.gmail.com with ESMTPSA id z5sm1183115wmf.48.2019.07.03.03.07.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 03 Jul 2019 03:07:30 -0700 (PDT)
Date:   Wed, 3 Jul 2019 12:07:27 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Stefan Hajnoczi <stefanha@gmail.com>
Cc:     netdev@vger.kernel.org, kvm@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH v2 0/3] vsock/virtio: several fixes in the .probe() and
 .remove()
Message-ID: <20190703100727.kuwpyc5sksrgmoxb@steredhat>
References: <20190628123659.139576-1-sgarzare@redhat.com>
 <20190701151113.GE11900@stefanha-x1.localdomain>
 <20190701170357.jtuhy3ank7mv6izb@steredhat>
 <20190703091453.GA11844@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190703091453.GA11844@stefanha-x1.localdomain>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 03, 2019 at 10:14:53AM +0100, Stefan Hajnoczi wrote:
> On Mon, Jul 01, 2019 at 07:03:57PM +0200, Stefano Garzarella wrote:
> > On Mon, Jul 01, 2019 at 04:11:13PM +0100, Stefan Hajnoczi wrote:
> > > On Fri, Jun 28, 2019 at 02:36:56PM +0200, Stefano Garzarella wrote:
> > > > During the review of "[PATCH] vsock/virtio: Initialize core virtio vsock
> > > > before registering the driver", Stefan pointed out some possible issues
> > > > in the .probe() and .remove() callbacks of the virtio-vsock driver.
> > > > 
> > > > This series tries to solve these issues:
> > > > - Patch 1 adds RCU critical sections to avoid use-after-free of
> > > >   'the_virtio_vsock' pointer.
> > > > - Patch 2 stops workers before to call vdev->config->reset(vdev) to
> > > >   be sure that no one is accessing the device.
> > > > - Patch 3 moves the works flush at the end of the .remove() to avoid
> > > >   use-after-free of 'vsock' object.
> > > > 
> > > > v2:
> > > > - Patch 1: use RCU to protect 'the_virtio_vsock' pointer
> > > > - Patch 2: no changes
> > > > - Patch 3: flush works only at the end of .remove()
> > > > - Removed patch 4 because virtqueue_detach_unused_buf() returns all the buffers
> > > >   allocated.
> > > > 
> > > > v1: https://patchwork.kernel.org/cover/10964733/
> > > 
> > > This looks good to me.
> > 
> > Thanks for the review!
> > 
> > > 
> > > Did you run any stress tests?  For example an SMP guest constantly
> > > connecting and sending packets together with a script that
> > > hotplug/unplugs vhost-vsock-pci from the host side.
> > 
> > Yes, I started an SMP guest (-smp 4 -monitor tcp:127.0.0.1:1234,server,nowait)
> > and I run these scripts to stress the .probe()/.remove() path:
> > 
> > - guest
> >   while true; do
> >       cat /dev/urandom | nc-vsock -l 4321 > /dev/null &
> >       cat /dev/urandom | nc-vsock -l 5321 > /dev/null &
> >       cat /dev/urandom | nc-vsock -l 6321 > /dev/null &
> >       cat /dev/urandom | nc-vsock -l 7321 > /dev/null &
> >       wait
> >   done
> > 
> > - host
> >   while true; do
> >       cat /dev/urandom | nc-vsock 3 4321 > /dev/null &
> >       cat /dev/urandom | nc-vsock 3 5321 > /dev/null &
> >       cat /dev/urandom | nc-vsock 3 6321 > /dev/null &
> >       cat /dev/urandom | nc-vsock 3 7321 > /dev/null &
> >       sleep 2
> >       echo "device_del v1" | nc 127.0.0.1 1234
> >       sleep 1
> >       echo "device_add vhost-vsock-pci,id=v1,guest-cid=3" | nc 127.0.0.1 1234
> >       sleep 1
> >   done
> > 
> > Do you think is enough or is better to have a test more accurate?
> 
> That's good when left running overnight so that thousands of hotplug
> events are tested.

Honestly I run the test for ~30 mins (because without the patch the
crash happens in a few seconds), but of course, I'll run it this night :)

Thanks,
Stefano
