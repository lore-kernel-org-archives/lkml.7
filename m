Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A327BC04EBF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 12:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7744E20882
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 12:21:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732307AbfIWMVx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 08:21:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58616 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730399AbfIWMVw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 08:21:52 -0400
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1830989AC7
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 12:21:51 +0000 (UTC)
Received: by mail-qk1-f197.google.com with SMTP id o133so17371615qke.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 05:21:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=a9/IjKSOTtP+H0DwvJWJwjvwhzIswSQaCoNDgf8fYiY=;
        b=TUtoZqAby2gXnnNBLwFd+RGVvcYHS3kvQeU+PR4atoRz33xHasJa6ke/NEoLhd+sbX
         aWcKCKJ7hcRctL5YV1dyrqXDH6bu0zNGGm0HvI6bQPlMrDsx9Rkt8EVUGnVtdStQ6lRA
         4Ydy2rFvByDwVgNh3haBBQxnrrBtyl38likT/uGOkQQ1XTekl2Buf+TQNax0Z6FVKnl5
         bfOUk3mV94BNVMM8bw23hJEXzqxNxOfigdA4d8e2Uruu8tnwF+kb+AtUL1GhdDCuizVK
         1UVQG++EnIfQUavJnvvZ7EB90bHkuaJBBJEtPs71PJCu4U6hzESLDK7rAUI8oMu7uqBw
         MrFg==
X-Gm-Message-State: APjAAAXArJAoRTf4JcC+1EGQEmO65EkAB2WxHXEM6nyfcBPQKlDjXCxy
        sxLICp9oTB3Jw8QL5nbUnqD2i+o6tsJUN4LfcVvm9smfVbX94vEj+tBlhNQ3/3yWeUD5RPqw1EU
        wabm/w535ibLdvcyYa4jZNRMH
X-Received: by 2002:ac8:7117:: with SMTP id z23mr16276181qto.309.1569241310357;
        Mon, 23 Sep 2019 05:21:50 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy19kCOwHbgejDjIiixAFXfW0feeppk9Ux+t6GtFmBM+eqf5FZ/rCyZVT2dupdlVrgcrW4SDA==
X-Received: by 2002:ac8:7117:: with SMTP id z23mr16276147qto.309.1569241310042;
        Mon, 23 Sep 2019 05:21:50 -0700 (PDT)
Received: from redhat.com (bzq-79-176-40-226.red.bezeqint.net. [79.176.40.226])
        by smtp.gmail.com with ESMTPSA id o38sm6573805qtc.39.2019.09.23.05.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2019 05:21:48 -0700 (PDT)
Date:   Mon, 23 Sep 2019 08:21:34 -0400
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
        pmorel@linux.ibm.com, freude@linux.ibm.com, lingshan.zhu@intel.com,
        idos@mellanox.com, eperezma@redhat.com, lulu@redhat.com
Subject: Re: [RFC PATCH V2 0/6] mdev based hardware virtio offloading support
Message-ID: <20190923074913-mutt-send-email-mst@kernel.org>
References: <20190920082050.19352-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190920082050.19352-1-jasowang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2019 at 04:20:44PM +0800, Jason Wang wrote:
> Hi all:
> 
> There are hardware that can do virtio datapath offloading while having
> its own control path. This path tries to implement a mdev based
> unified API to support using kernel virtio driver to drive those
> devices. This is done by introducing a new mdev transport for virtio
> (virtio_mdev) and register itself as a new kind of mdev driver. Then
> it provides a unified way for kernel virtio driver to talk with mdev
> device implementation.

This is actually simple enough that I'm inclined to just
put this into linux-next.
This mixes virtio and vfio so the code can thinkably
be merged through either tree.
Alex, any strong opinions on any of this?

> Though the series only contain kernel driver support, the goal is to
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
> Changes from V1:
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
>   virtio: introudce a mdev based transport
>   vringh: fix copy direction of vringh_iov_push_kern()
>   docs: Sample driver to demonstrate how to implement virtio-mdev
>     framework
> 
>  .../driver-api/vfio-mediated-device.rst       |  11 +-
>  drivers/gpu/drm/i915/gvt/kvmgt.c              |  17 +-
>  drivers/s390/cio/vfio_ccw_ops.c               |  17 +-
>  drivers/s390/crypto/vfio_ap_ops.c             |  14 +-
>  drivers/vfio/mdev/Kconfig                     |   7 +
>  drivers/vfio/mdev/Makefile                    |   1 +
>  drivers/vfio/mdev/mdev_core.c                 |  21 +-
>  drivers/vfio/mdev/mdev_driver.c               |  14 +
>  drivers/vfio/mdev/mdev_private.h              |   1 +
>  drivers/vfio/mdev/vfio_mdev.c                 |  37 +-
>  drivers/vfio/mdev/virtio_mdev.c               | 418 +++++++++++
>  drivers/vhost/vringh.c                        |   8 +-
>  include/linux/mdev.h                          |  46 +-
>  include/linux/mod_devicetable.h               |   8 +
>  include/linux/vfio_mdev.h                     |  50 ++
>  include/linux/virtio_mdev.h                   | 141 ++++
>  samples/Kconfig                               |   7 +
>  samples/vfio-mdev/Makefile                    |   1 +
>  samples/vfio-mdev/mbochs.c                    |  19 +-
>  samples/vfio-mdev/mdpy.c                      |  19 +-
>  samples/vfio-mdev/mtty.c                      |  17 +-
>  samples/vfio-mdev/mvnet.c                     | 688 ++++++++++++++++++
>  22 files changed, 1473 insertions(+), 89 deletions(-)
>  create mode 100644 drivers/vfio/mdev/virtio_mdev.c
>  create mode 100644 include/linux/vfio_mdev.h
>  create mode 100644 include/linux/virtio_mdev.h
>  create mode 100644 samples/vfio-mdev/mvnet.c
> 
> -- 
> 2.19.1
