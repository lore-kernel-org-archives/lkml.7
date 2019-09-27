Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 945B1C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 09:38:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67484207E0
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 09:38:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727238AbfI0Jiw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 05:38:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49460 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726116AbfI0Jiw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 05:38:52 -0400
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6DB0AC059B6F
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 09:38:51 +0000 (UTC)
Received: by mail-qk1-f199.google.com with SMTP id b67so2063667qkc.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 02:38:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=rOyYIzrWrloVuAx5hnkD3TMrF9pqyzmvSZFIAM/YQU8=;
        b=I5ePLXY9Ll5ZsGytPsvaEvfOixsrCdTs6kjiaEjQgciQKSQ/2rTa82clTK62FSX34f
         570kfzYYmgplVSP+nzQlA1r4vO91rdHk7ZT/rrYi5GEJBxuEvRKl8PO+5fwnoNIlmhk3
         vz31VKuF2XVW/DlbLc6tzSZf5+HWAOgjOL5Mo0XAAOIkfoOmjYXzU3Sj89StJPpH6qca
         ScqLf/2A6zynKDX2AgjCw8/GbmGWmgw3iiUWPVvTrcJHNfQQ16fv6xd/KF5DxSSPDltB
         mu/jZk1MDpahbUhsaUjhOab2OoGI9ndPSGTCNZEtxGL0GtwBmMCq7ijGt8XmvRsSvz1X
         XtYA==
X-Gm-Message-State: APjAAAUwi3UTvLBcwwkR1/jo64qLY4MeQCQKQ+q2valygOMaPgTP5cRP
        e6vZbSYRxksWw0/mYBdLXlPpggAONwNyqd2yuM3B6ihQ4pGn3BCQnluOWaM6GzpzAt7ojOWSzdW
        UfVOqNBLIixZtVj4+cA6XS3Xe
X-Received: by 2002:aed:3103:: with SMTP id 3mr8714982qtg.76.1569577130712;
        Fri, 27 Sep 2019 02:38:50 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwDAuQ+kbM+rJGoW2H1RVZjcIQD6eUhHWI3ZWKcC6lLqGWDoGXC17Lib69zzC7/v1aBiaTSYg==
X-Received: by 2002:aed:3103:: with SMTP id 3mr8714962qtg.76.1569577130523;
        Fri, 27 Sep 2019 02:38:50 -0700 (PDT)
Received: from redhat.com (bzq-79-176-40-226.red.bezeqint.net. [79.176.40.226])
        by smtp.gmail.com with ESMTPSA id u39sm2417906qtj.34.2019.09.27.02.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2019 02:38:49 -0700 (PDT)
Date:   Fri, 27 Sep 2019 05:38:43 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Tiwei Bie <tiwei.bie@intel.com>, alex.williamson@redhat.com,
        maxime.coquelin@redhat.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, dan.daly@intel.com,
        cunming.liang@intel.com, zhihong.wang@intel.com,
        lingshan.zhu@intel.com
Subject: Re: [PATCH] vhost: introduce mdev based hardware backend
Message-ID: <20190927053829-mutt-send-email-mst@kernel.org>
References: <20190926045427.4973-1-tiwei.bie@intel.com>
 <1b4b8891-8c14-1c85-1d6a-2eed1c90bcde@redhat.com>
 <20190927045438.GA17152@___>
 <05ab395e-6677-e8c3-becf-57bc1529921f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <05ab395e-6677-e8c3-becf-57bc1529921f@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 27, 2019 at 04:47:43PM +0800, Jason Wang wrote:
> 
> On 2019/9/27 下午12:54, Tiwei Bie wrote:
> > On Fri, Sep 27, 2019 at 11:46:06AM +0800, Jason Wang wrote:
> > > On 2019/9/26 下午12:54, Tiwei Bie wrote:
> > > > +
> > > > +static long vhost_mdev_start(struct vhost_mdev *m)
> > > > +{
> > > > +	struct mdev_device *mdev = m->mdev;
> > > > +	const struct virtio_mdev_device_ops *ops = mdev_get_dev_ops(mdev);
> > > > +	struct virtio_mdev_callback cb;
> > > > +	struct vhost_virtqueue *vq;
> > > > +	int idx;
> > > > +
> > > > +	ops->set_features(mdev, m->acked_features);
> > > > +
> > > > +	mdev_add_status(mdev, VIRTIO_CONFIG_S_FEATURES_OK);
> > > > +	if (!(mdev_get_status(mdev) & VIRTIO_CONFIG_S_FEATURES_OK))
> > > > +		goto reset;
> > > > +
> > > > +	for (idx = 0; idx < m->nvqs; idx++) {
> > > > +		vq = &m->vqs[idx];
> > > > +
> > > > +		if (!vq->desc || !vq->avail || !vq->used)
> > > > +			break;
> > > > +
> > > > +		if (ops->set_vq_state(mdev, idx, vq->last_avail_idx))
> > > > +			goto reset;
> > > If we do set_vq_state() in SET_VRING_BASE, we won't need this step here.
> > Yeah, I plan to do it in the next version.
> > 
> > > > +
> > > > +		/*
> > > > +		 * In vhost-mdev, userspace should pass ring addresses
> > > > +		 * in guest physical addresses when IOMMU is disabled or
> > > > +		 * IOVAs when IOMMU is enabled.
> > > > +		 */
> > > A question here, consider we're using noiommu mode. If guest physical
> > > address is passed here, how can a device use that?
> > > 
> > > I believe you meant "host physical address" here? And it also have the
> > > implication that the HPA should be continuous (e.g using hugetlbfs).
> > The comment is talking about the virtual IOMMU (i.e. iotlb in vhost).
> > It should be rephrased to cover the noiommu case as well. Thanks for
> > spotting this.
> > 
> > 
> > > > +
> > > > +	switch (cmd) {
> > > > +	case VHOST_MDEV_SET_STATE:
> > > > +		r = vhost_set_state(m, argp);
> > > > +		break;
> > > > +	case VHOST_GET_FEATURES:
> > > > +		r = vhost_get_features(m, argp);
> > > > +		break;
> > > > +	case VHOST_SET_FEATURES:
> > > > +		r = vhost_set_features(m, argp);
> > > > +		break;
> > > > +	case VHOST_GET_VRING_BASE:
> > > > +		r = vhost_get_vring_base(m, argp);
> > > > +		break;
> > > Does it mean the SET_VRING_BASE may only take affect after
> > > VHOST_MEV_SET_STATE?
> > Yeah, in this version, SET_VRING_BASE won't set the base to the
> > device directly. But I plan to not delay this anymore in the next
> > version to support the SET_STATUS.
> > 
> > > > +	default:
> > > > +		r = vhost_dev_ioctl(&m->dev, cmd, argp);
> > > > +		if (r == -ENOIOCTLCMD)
> > > > +			r = vhost_vring_ioctl(&m->dev, cmd, argp);
> > > > +	}
> > > > +
> > > > +	mutex_unlock(&m->mutex);
> > > > +	return r;
> > > > +}
> > > > +
> > > > +static const struct vfio_device_ops vfio_vhost_mdev_dev_ops = {
> > > > +	.name		= "vfio-vhost-mdev",
> > > > +	.open		= vhost_mdev_open,
> > > > +	.release	= vhost_mdev_release,
> > > > +	.ioctl		= vhost_mdev_unlocked_ioctl,
> > > > +};
> > > > +
> > > > +static int vhost_mdev_probe(struct device *dev)
> > > > +{
> > > > +	struct mdev_device *mdev = mdev_from_dev(dev);
> > > > +	const struct virtio_mdev_device_ops *ops = mdev_get_dev_ops(mdev);
> > > > +	struct vhost_mdev *m;
> > > > +	int nvqs, r;
> > > > +
> > > > +	m = kzalloc(sizeof(*m), GFP_KERNEL | __GFP_RETRY_MAYFAIL);
> > > > +	if (!m)
> > > > +		return -ENOMEM;
> > > > +
> > > > +	mutex_init(&m->mutex);
> > > > +
> > > > +	nvqs = ops->get_queue_max(mdev);
> > > > +	m->nvqs = nvqs;
> > > The name could be confusing, get_queue_max() is to get the maximum number of
> > > entries for a virtqueue supported by this device.
> > OK. It might be better to rename it to something like:
> > 
> > 	get_vq_num_max()
> > 
> > which is more consistent with the set_vq_num().
> > 
> > > It looks to me that we need another API to query the maximum number of
> > > virtqueues supported by the device.
> > Yeah.
> > 
> > Thanks,
> > Tiwei
> 
> 
> One problem here:
> 
> Consider if we want to support multiqueue, how did userspace know about
> this?

There's a feature bit for this, isn't there?

> Note this information could be fetched from get_config() via a device
> specific way, do we want ioctl for accessing that area?
> 
> Thanks
