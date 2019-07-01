Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3992C0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 17:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85AAB21473
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 17:04:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729874AbfGAREF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 13:04:05 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38692 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727302AbfGARED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 13:04:03 -0400
Received: by mail-wm1-f66.google.com with SMTP id s15so282492wmj.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 10:04:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ld/S+VVZs8pmZedqdnP/S9bHBpKYWy8WRk/m3Q5+2LI=;
        b=nOSxcIWZKYaa0Txvh0YUqnaNH8uZ3ZFnXOwCN1KpT90CyIV1nrYYmpSdALVXoZMW+V
         0g6ND8+yNMhNhhPvCzAKmCqq8y3OLii9L8hdFpKOL5fLJYoiU8HldbYWQKPBPeWnHYoA
         iWv6SmBNhY1KtN+tBwsYxgR7sA+6jkTrZ19xtHgOLPtpExzb1BN+xkONdazk8TUbg9QT
         WwencRWDOHGhsUZ07nQD063Yn/kt8rD7gNXVWLNbAz7gvbGf0eZUpJPeRZawVKhpEMA0
         pvriy6qdJ1KFv2wlG8WwXK8i7R+NMwoDUJfERkXJYP2626vZtico9ZkAakviyj4eZqbL
         l9dQ==
X-Gm-Message-State: APjAAAVhcjw//XKwmMFnUZv9Dt8UgI5K/80OJ3hw94IM4fKJRMb5E04W
        PapRJcIYQmF/bH0x1jjFVdRePw==
X-Google-Smtp-Source: APXvYqwBOYSxwelsum2oddoo+4pw1dZnLt7m1hYtVtolWxEgwL2beWLJsaejVTIBg02GC95ss28lWA==
X-Received: by 2002:a1c:7503:: with SMTP id o3mr183987wmc.170.1562000640687;
        Mon, 01 Jul 2019 10:04:00 -0700 (PDT)
Received: from steredhat (host21-207-dynamic.52-79-r.retail.telecomitalia.it. [79.52.207.21])
        by smtp.gmail.com with ESMTPSA id q18sm9950224wrj.65.2019.07.01.10.03.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 01 Jul 2019 10:04:00 -0700 (PDT)
Date:   Mon, 1 Jul 2019 19:03:57 +0200
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
Message-ID: <20190701170357.jtuhy3ank7mv6izb@steredhat>
References: <20190628123659.139576-1-sgarzare@redhat.com>
 <20190701151113.GE11900@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190701151113.GE11900@stefanha-x1.localdomain>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 01, 2019 at 04:11:13PM +0100, Stefan Hajnoczi wrote:
> On Fri, Jun 28, 2019 at 02:36:56PM +0200, Stefano Garzarella wrote:
> > During the review of "[PATCH] vsock/virtio: Initialize core virtio vsock
> > before registering the driver", Stefan pointed out some possible issues
> > in the .probe() and .remove() callbacks of the virtio-vsock driver.
> > 
> > This series tries to solve these issues:
> > - Patch 1 adds RCU critical sections to avoid use-after-free of
> >   'the_virtio_vsock' pointer.
> > - Patch 2 stops workers before to call vdev->config->reset(vdev) to
> >   be sure that no one is accessing the device.
> > - Patch 3 moves the works flush at the end of the .remove() to avoid
> >   use-after-free of 'vsock' object.
> > 
> > v2:
> > - Patch 1: use RCU to protect 'the_virtio_vsock' pointer
> > - Patch 2: no changes
> > - Patch 3: flush works only at the end of .remove()
> > - Removed patch 4 because virtqueue_detach_unused_buf() returns all the buffers
> >   allocated.
> > 
> > v1: https://patchwork.kernel.org/cover/10964733/
> 
> This looks good to me.

Thanks for the review!

> 
> Did you run any stress tests?  For example an SMP guest constantly
> connecting and sending packets together with a script that
> hotplug/unplugs vhost-vsock-pci from the host side.

Yes, I started an SMP guest (-smp 4 -monitor tcp:127.0.0.1:1234,server,nowait)
and I run these scripts to stress the .probe()/.remove() path:

- guest
  while true; do
      cat /dev/urandom | nc-vsock -l 4321 > /dev/null &
      cat /dev/urandom | nc-vsock -l 5321 > /dev/null &
      cat /dev/urandom | nc-vsock -l 6321 > /dev/null &
      cat /dev/urandom | nc-vsock -l 7321 > /dev/null &
      wait
  done

- host
  while true; do
      cat /dev/urandom | nc-vsock 3 4321 > /dev/null &
      cat /dev/urandom | nc-vsock 3 5321 > /dev/null &
      cat /dev/urandom | nc-vsock 3 6321 > /dev/null &
      cat /dev/urandom | nc-vsock 3 7321 > /dev/null &
      sleep 2
      echo "device_del v1" | nc 127.0.0.1 1234
      sleep 1
      echo "device_add vhost-vsock-pci,id=v1,guest-cid=3" | nc 127.0.0.1 1234
      sleep 1
  done

Do you think is enough or is better to have a test more accurate?

Thanks,
Stefano
