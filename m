Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC8AFC32755
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 13:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C362120856
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 13:59:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729724AbfIWN7x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 09:59:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49152 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407169AbfIWN7x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 09:59:53 -0400
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 71B3E61D25
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 13:59:52 +0000 (UTC)
Received: by mail-qt1-f199.google.com with SMTP id g16so17391495qtq.15
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 06:59:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FtApu15nyFEPJdV270MkGcXi5No4IIGcISN59p+vUsI=;
        b=lI3HamhaDFab46yky1a+hvsUyYJMRTcleuJC7lDSXsj8sVtVtndgcbMKfkAA3o2Mft
         9QgFSiNL4LvwDfQi+c8CJimpnYx4frQylKCY+xt0l++WS13WQuS90kcewaj7opTgvcRV
         jiev0K5je98C0BR0a39rHY2LpSjmcd6+feua2uzFLU9mFEmLmbEseEaPsdRYX2vV0j1B
         WAw+t4LHuC0RUUIXsdDezKLRWRwWk+58/0PrqCTgs/oj3bUV9ZizhuJz6cmtJHLHaSZN
         AzBlRHeslLb1l0juF5weTVJFrRWqqaDpQx5HEzLLE5G2uPSH8rnNeFOOHPVaVkJoSpp0
         KQ9g==
X-Gm-Message-State: APjAAAVionv4HdjcuoINydlca4JFVW8BYwXEdZ3lzBNo0PcinJdR9+JD
        YzmB1v6jVYs0kJcnAya71gKE73HE1ldryqem755tdV9lE6Lm3OZf1/EmKAdoRl9Mi5wCi7FbDKg
        7Cgu9S1PDWSeEEo/9cC8YdWe+
X-Received: by 2002:a37:a8ce:: with SMTP id r197mr17291118qke.374.1569247191428;
        Mon, 23 Sep 2019 06:59:51 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyzyB1a60cl+6jXMDuajGY7ZKBy6qBhwd1rCHqj2guL5sYzzKUt4czPqrsZBqxQFgz2+CkCug==
X-Received: by 2002:a37:a8ce:: with SMTP id r197mr17291071qke.374.1569247191247;
        Mon, 23 Sep 2019 06:59:51 -0700 (PDT)
Received: from redhat.com (bzq-79-176-40-226.red.bezeqint.net. [79.176.40.226])
        by smtp.gmail.com with ESMTPSA id j2sm4848892qki.15.2019.09.23.06.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2019 06:59:50 -0700 (PDT)
Date:   Mon, 23 Sep 2019 09:59:38 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org, kwankhede@nvidia.com,
        alex.williamson@redhat.com, tiwei.bie@intel.com,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        cohuck@redhat.com, maxime.coquelin@redhat.com,
        cunming.liang@intel.com, zhihong.wang@intel.com,
        rob.miller@broadcom.com, xiao.w.wang@intel.com,
        haotian.wang@sifive.com, zhenyuw@linux.intel.com,
        zhi.a.wang@intel.com, jani.nikula@linux.intel.com,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        airlied@linux.ie, daniel@ffwll.ch, farman@linux.ibm.com,
        pasic@linux.ibm.com, sebott@linux.ibm.com, oberpar@linux.ibm.com,
        heiko.carstens@de.ibm.com, gor@linux.ibm.com,
        borntraeger@de.ibm.com, akrowiak@linux.ibm.com,
        freude@linux.ibm.com, lingshan.zhu@intel.com, idos@mellanox.com,
        eperezma@redhat.com, lulu@redhat.com, parav@mellanox.com
Subject: Re: [PATCH 0/6] mdev based hardware virtio offloading support
Message-ID: <20190923095820-mutt-send-email-mst@kernel.org>
References: <20190923130331.29324-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190923130331.29324-1-jasowang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 09:03:25PM +0800, Jason Wang wrote:
> Hi all:
> 
> There are hardware that can do virtio datapath offloading while having
> its own control path. This path tries to implement a mdev based
> unified API to support using kernel virtio driver to drive those
> devices. This is done by introducing a new mdev transport for virtio
> (virtio_mdev) and register itself as a new kind of mdev driver. Then
> it provides a unified way for kernel virtio driver to talk with mdev
> device implementation.
> 
> Though the series only contains kernel driver support, the goal is to
> make the transport generic enough to support userspace drivers. This
> means vhost-mdev[1] could be built on top as well by resuing the
> transport.
> 
> A sample driver is also implemented which simulate a virito-net
> loopback ethernet device on top of vringh + workqueue. This could be
> used as a reference implementation for real hardware driver.
> 
> Consider mdev framework only support VFIO device and driver right now,
> this series also extend it to support other types. This is done
> through introducing class id to the device and pairing it with
> id_talbe claimed by the driver. On top, this seris also decouple
> device specific parents ops out of the common ones.
> 
> Pktgen test was done with virito-net + mvnet loop back device.
> 
> Please review.
> 
> [1] https://lkml.org/lkml/2019/9/16/869
> 
> Changes from RFC-V2:
> - silent compile warnings on some specific configuration
> - use u16 instead u8 for class id
> - reseve MDEV_ID_VHOST for future vhost-mdev work
> - introduce "virtio" type for mvnet and make "vhost" type for future
>   work
> - add entries in MAINTAINER
> - tweak and typos fixes in commit log
> 
> Changes from RFC-V1:
> 
> - rename device id to class id
> - add docs for class id and device specific ops (device_ops)
> - split device_ops into seperate headers
> - drop the mdev_set_dma_ops()
> - use device_ops to implement the transport API, then it's not a part
>   of UAPI any more
> - use GFP_ATOMIC in mvnet sample device and other tweaks
> - set_vring_base/get_vring_base support for mvnet device
> 
> Jason Wang (6):
>   mdev: class id support
>   mdev: introduce device specific ops
>   mdev: introduce virtio device and its device ops
>   virtio: introduce a mdev based transport
>   vringh: fix copy direction of vringh_iov_push_kern()
>   docs: sample driver to demonstrate how to implement virtio-mdev
>     framework


That's pretty clean, so how about we start by just merging this?
Alex are you going to handle this through your next tree?
If yes, pls include:

Acked-by: Michael S. Tsirkin <mst@redhat.com>



>  .../driver-api/vfio-mediated-device.rst       |  11 +-
>  MAINTAINERS                                   |   3 +
>  drivers/gpu/drm/i915/gvt/kvmgt.c              |  17 +-
>  drivers/s390/cio/vfio_ccw_ops.c               |  17 +-
>  drivers/s390/crypto/vfio_ap_ops.c             |  14 +-
>  drivers/vfio/mdev/Kconfig                     |   7 +
>  drivers/vfio/mdev/Makefile                    |   1 +
>  drivers/vfio/mdev/mdev_core.c                 |  21 +-
>  drivers/vfio/mdev/mdev_driver.c               |  14 +
>  drivers/vfio/mdev/mdev_private.h              |   1 +
>  drivers/vfio/mdev/vfio_mdev.c                 |  37 +-
>  drivers/vfio/mdev/virtio_mdev.c               | 416 +++++++++++
>  drivers/vhost/vringh.c                        |   8 +-
>  include/linux/mdev.h                          |  47 +-
>  include/linux/mod_devicetable.h               |   8 +
>  include/linux/vfio_mdev.h                     |  53 ++
>  include/linux/virtio_mdev.h                   | 144 ++++
>  samples/Kconfig                               |   7 +
>  samples/vfio-mdev/Makefile                    |   1 +
>  samples/vfio-mdev/mbochs.c                    |  19 +-
>  samples/vfio-mdev/mdpy.c                      |  19 +-
>  samples/vfio-mdev/mtty.c                      |  17 +-
>  samples/vfio-mdev/mvnet.c                     | 688 ++++++++++++++++++
>  23 files changed, 1481 insertions(+), 89 deletions(-)
>  create mode 100644 drivers/vfio/mdev/virtio_mdev.c
>  create mode 100644 include/linux/vfio_mdev.h
>  create mode 100644 include/linux/virtio_mdev.h
>  create mode 100644 samples/vfio-mdev/mvnet.c
> 
> -- 
> 2.19.1
