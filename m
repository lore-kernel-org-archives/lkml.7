Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD68C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 11:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 934D922CF7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 11:26:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728915AbfICL0N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 07:26:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58660 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728843AbfICL0M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 07:26:12 -0400
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BFE204ACA5
        for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2019 11:26:11 +0000 (UTC)
Received: by mail-qt1-f197.google.com with SMTP id l22so18607724qtq.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 04:26:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IOX0AtYnR2nI5t+WDQ2xYckZJDNwaXlWmR5KjyvT8Nw=;
        b=nWgsVb+vaRGqL9crQXIQX20QsBlgNpkulZEbjtA8KfGBKpWJOiA9HIe1uaEzBa/chR
         LxSEQuL1y5Dn8S1cUQy7QhrmguN3Bu5y/uJzDRCCZKYiJlMb5K2jGe48hC+0SbeoaGMa
         PSlXm23TQtS7PpL2ctCuaOiNDBhKXD8zsNlFwYjQxf7fLJZpAmGlGCU6QdUC+ejy9uDr
         NQZxPMblYAYOjJFSjzaK5Yxla1A+x/dMFhqQ0vYG+5sUEh5N+On+tYhtxC8XQbluG67f
         MJxI24ChkT5Tq9VqXS8PNN+BtDEbnWXE3VZNWz+vqVUkF4GzO2zoQPxObl2v4itZ2oDi
         lJWQ==
X-Gm-Message-State: APjAAAWm4lU9QyvbbsKvYZc0ks096lavr70aZrkY+CNRbbq8M/zwVZKy
        hbTI0KmiNSIqY0fciwDo4owH6VZlY01pS64htwFbwOI5bq1t8TXPDUZ+4q1Sk4SC8QxSiVyc4/U
        Gvc0dxWO6LgyFr2tIowfPPR2o
X-Received: by 2002:a37:8c07:: with SMTP id o7mr33341284qkd.491.1567509970903;
        Tue, 03 Sep 2019 04:26:10 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzxU+NQIhv1VCV7+v5/KcDRMJCp+h+HcWM24+Z7x7iUSGTu/fMAcyf8D/Ce7voo2gzYWGkeTg==
X-Received: by 2002:a37:8c07:: with SMTP id o7mr33341256qkd.491.1567509970597;
        Tue, 03 Sep 2019 04:26:10 -0700 (PDT)
Received: from redhat.com (bzq-79-180-62-110.red.bezeqint.net. [79.180.62.110])
        by smtp.gmail.com with ESMTPSA id b192sm7710282qkg.39.2019.09.03.04.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 04:26:09 -0700 (PDT)
Date:   Tue, 3 Sep 2019 07:26:03 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Tiwei Bie <tiwei.bie@intel.com>
Cc:     jasowang@redhat.com, alex.williamson@redhat.com,
        maxime.coquelin@redhat.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, dan.daly@intel.com,
        cunming.liang@intel.com, zhihong.wang@intel.com,
        lingshan.zhu@intel.com
Subject: Re: [RFC v3] vhost: introduce mdev based hardware vhost backend
Message-ID: <20190903043704-mutt-send-email-mst@kernel.org>
References: <20190828053712.26106-1-tiwei.bie@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828053712.26106-1-tiwei.bie@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 01:37:12PM +0800, Tiwei Bie wrote:
> Details about this can be found here:
> 
> https://lwn.net/Articles/750770/
> 
> What's new in this version
> ==========================
> 
> There are three choices based on the discussion [1] in RFC v2:
> 
> > #1. We expose a VFIO device, so we can reuse the VFIO container/group
> >     based DMA API and potentially reuse a lot of VFIO code in QEMU.
> >
> >     But in this case, we have two choices for the VFIO device interface
> >     (i.e. the interface on top of VFIO device fd):
> >
> >     A) we may invent a new vhost protocol (as demonstrated by the code
> >        in this RFC) on VFIO device fd to make it work in VFIO's way,
> >        i.e. regions and irqs.
> >
> >     B) Or as you proposed, instead of inventing a new vhost protocol,
> >        we can reuse most existing vhost ioctls on the VFIO device fd
> >        directly. There should be no conflicts between the VFIO ioctls
> >        (type is 0x3B) and VHOST ioctls (type is 0xAF) currently.
> >
> > #2. Instead of exposing a VFIO device, we may expose a VHOST device.
> >     And we will introduce a new mdev driver vhost-mdev to do this.
> >     It would be natural to reuse the existing kernel vhost interface
> >     (ioctls) on it as much as possible. But we will need to invent
> >     some APIs for DMA programming (reusing VHOST_SET_MEM_TABLE is a
> >     choice, but it's too heavy and doesn't support vIOMMU by itself).
> 
> This version is more like a quick PoC to try Jason's proposal on
> reusing vhost ioctls. And the second way (#1/B) in above three
> choices was chosen in this version to demonstrate the idea quickly.
> 
> Now the userspace API looks like this:
> 
> - VFIO's container/group based IOMMU API is used to do the
>   DMA programming.
> 
> - Vhost's existing ioctls are used to setup the device.
> 
> And the device will report device_api as "vfio-vhost".
> 
> Note that, there are dirty hacks in this version. If we decide to
> go this way, some refactoring in vhost.c/vhost.h may be needed.
> 
> PS. The direct mapping of the notify registers isn't implemented
>     in this version.
> 
> [1] https://lkml.org/lkml/2019/7/9/101
> 
> Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>

....

> +long vhost_mdev_ioctl(struct mdev_device *mdev, unsigned int cmd,
> +		      unsigned long arg)
> +{
> +	void __user *argp = (void __user *)arg;
> +	struct vhost_mdev *vdpa;
> +	unsigned long minsz;
> +	int ret = 0;
> +
> +	if (!mdev)
> +		return -EINVAL;
> +
> +	vdpa = mdev_get_drvdata(mdev);
> +	if (!vdpa)
> +		return -ENODEV;
> +
> +	switch (cmd) {
> +	case VFIO_DEVICE_GET_INFO:
> +	{
> +		struct vfio_device_info info;
> +
> +		minsz = offsetofend(struct vfio_device_info, num_irqs);
> +
> +		if (copy_from_user(&info, (void __user *)arg, minsz)) {
> +			ret = -EFAULT;
> +			break;
> +		}
> +
> +		if (info.argsz < minsz) {
> +			ret = -EINVAL;
> +			break;
> +		}
> +
> +		info.flags = VFIO_DEVICE_FLAGS_VHOST;
> +		info.num_regions = 0;
> +		info.num_irqs = 0;
> +
> +		if (copy_to_user((void __user *)arg, &info, minsz)) {
> +			ret = -EFAULT;
> +			break;
> +		}
> +
> +		break;
> +	}
> +	case VFIO_DEVICE_GET_REGION_INFO:
> +	case VFIO_DEVICE_GET_IRQ_INFO:
> +	case VFIO_DEVICE_SET_IRQS:
> +	case VFIO_DEVICE_RESET:
> +		ret = -EINVAL;
> +		break;
> +
> +	case VHOST_MDEV_SET_STATE:
> +		ret = vhost_set_state(vdpa, argp);
> +		break;
> +	case VHOST_GET_FEATURES:
> +		ret = vhost_get_features(vdpa, argp);
> +		break;
> +	case VHOST_SET_FEATURES:
> +		ret = vhost_set_features(vdpa, argp);
> +		break;
> +	case VHOST_GET_VRING_BASE:
> +		ret = vhost_get_vring_base(vdpa, argp);
> +		break;
> +	default:
> +		ret = vhost_dev_ioctl(&vdpa->dev, cmd, argp);
> +		if (ret == -ENOIOCTLCMD)
> +			ret = vhost_vring_ioctl(&vdpa->dev, cmd, argp);
> +	}
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(vhost_mdev_ioctl);


I don't have a problem with this approach. A small question:
would it make sense to have two fds: send vhost ioctls
on one and vfio ioctls on another?
We can then pass vfio fd to the vhost fd with a
SET_BACKEND ioctl.

What do you think?

-- 
MST
