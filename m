Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AEFFC388F3
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 12:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B83B2146E
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 12:46:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbfI0Mqj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 08:46:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59550 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725992AbfI0Mqj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 08:46:39 -0400
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DE4C0806CD
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 12:46:38 +0000 (UTC)
Received: by mail-qk1-f200.google.com with SMTP id s3so2481978qkd.6
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 05:46:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=F0AJjiYSseSar3j8FYQBkm/uGwjn3oyXe7/oWdhrCrA=;
        b=s1TPxVod3PbZ9OT8uRTBzZTqa82Am+P5rH2lHpc5w5rCGQ0/nOtcBTRbOXea5NrByv
         fg5aQOcxwBwrt6mp/TguzQDVxzakLBVkTHaRDp0K+ngOF1JdjpJ2UBB5ik38TScIrOnU
         E214OSXoOjw8lWrcyjdYLXZrCSsVYOgw4qWugo9IGowekQ0CW/ogLq9fYFsDL/VzjvLC
         wEQEkbeiYr6GYnesUiExYBIIv5DW3nZKyAC8D6D3lpDas9+VgjqG4TeYVBO69D8eTcjK
         UqDCG2xeGAiqsvVD4azDoGCknIOWk8/hb3Iqaz739U4yGJv21g/Eq43WKo2f3x0MrnkP
         HDpg==
X-Gm-Message-State: APjAAAW4YiCUDzoVwF+/J503BZgTnliUYRF/0lVWqf3Kh5y6co78gpXN
        eUoompnjf0VDxiJYwpOSlLzrj9VKEv9oG2q1TiI9+ar9eiCT4jya+dxzTDLMMquP4DMwcuEOnOL
        MH/UrCan6K2mmux7c3/PXHivw
X-Received: by 2002:ac8:4799:: with SMTP id k25mr7997669qtq.367.1569588398246;
        Fri, 27 Sep 2019 05:46:38 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyAFgv2zv7Du3HbBGPrbXCj+OH0ccwA9kLx7oS6JvyRcdhReSO32VIYn0OwwDZ4C1U+jtQ3wA==
X-Received: by 2002:ac8:4799:: with SMTP id k25mr7997659qtq.367.1569588398060;
        Fri, 27 Sep 2019 05:46:38 -0700 (PDT)
Received: from redhat.com (bzq-79-176-40-226.red.bezeqint.net. [79.176.40.226])
        by smtp.gmail.com with ESMTPSA id q2sm1095503qkc.68.2019.09.27.05.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2019 05:46:37 -0700 (PDT)
Date:   Fri, 27 Sep 2019 08:46:31 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Tiwei Bie <tiwei.bie@intel.com>, alex.williamson@redhat.com,
        maxime.coquelin@redhat.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, dan.daly@intel.com,
        cunming.liang@intel.com, zhihong.wang@intel.com,
        lingshan.zhu@intel.com
Subject: Re: [PATCH] vhost: introduce mdev based hardware backend
Message-ID: <20190927084408-mutt-send-email-mst@kernel.org>
References: <20190926045427.4973-1-tiwei.bie@intel.com>
 <20190926042156-mutt-send-email-mst@kernel.org>
 <20190926131439.GA11652@___>
 <8ab5a8d9-284d-bba5-803d-08523c0814e1@redhat.com>
 <20190927053935-mutt-send-email-mst@kernel.org>
 <a959fe1e-3095-e0f0-0c9b-57f6eaa9c8b7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a959fe1e-3095-e0f0-0c9b-57f6eaa9c8b7@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 27, 2019 at 08:17:47PM +0800, Jason Wang wrote:
> 
> On 2019/9/27 下午5:41, Michael S. Tsirkin wrote:
> > On Fri, Sep 27, 2019 at 11:27:12AM +0800, Jason Wang wrote:
> > > On 2019/9/26 下午9:14, Tiwei Bie wrote:
> > > > On Thu, Sep 26, 2019 at 04:35:18AM -0400, Michael S. Tsirkin wrote:
> > > > > On Thu, Sep 26, 2019 at 12:54:27PM +0800, Tiwei Bie wrote:
> > > > [...]
> > > > > > diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
> > > > > > index 40d028eed645..5afbc2f08fa3 100644
> > > > > > --- a/include/uapi/linux/vhost.h
> > > > > > +++ b/include/uapi/linux/vhost.h
> > > > > > @@ -116,4 +116,12 @@
> > > > > >    #define VHOST_VSOCK_SET_GUEST_CID	_IOW(VHOST_VIRTIO, 0x60, __u64)
> > > > > >    #define VHOST_VSOCK_SET_RUNNING		_IOW(VHOST_VIRTIO, 0x61, int)
> > > > > > +/* VHOST_MDEV specific defines */
> > > > > > +
> > > > > > +#define VHOST_MDEV_SET_STATE	_IOW(VHOST_VIRTIO, 0x70, __u64)
> > > > > > +
> > > > > > +#define VHOST_MDEV_S_STOPPED	0
> > > > > > +#define VHOST_MDEV_S_RUNNING	1
> > > > > > +#define VHOST_MDEV_S_MAX	2
> > > > > > +
> > > > > >    #endif
> > > > > So assuming we have an underlying device that behaves like virtio:
> > > > I think they are really good questions/suggestions. Thanks!
> > > > 
> > > > > 1. Should we use SET_STATUS maybe?
> > > > I like this idea. I will give it a try.
> > > > 
> > > > > 2. Do we want a reset ioctl?
> > > > I think it is helpful. If we use SET_STATUS, maybe we
> > > > can use it to support the reset.
> > > > 
> > > > > 3. Do we want ability to enable rings individually?
> > > > I will make it possible at least in the vhost layer.
> > > 
> > > Note the API support e.g set_vq_ready().
> > virtio spec calls this "enabled" so let's stick to that.
> 
> 
> Ok.
> 
> 
> > 
> > > > > 4. Does device need to limit max ring size?
> > > > > 5. Does device need to limit max number of queues?
> > > > I think so. It's helpful to have ioctls to report the max
> > > > ring size and max number of queues.
> > > 
> > > An issue is the max number of queues is done through a device specific way,
> > > usually device configuration space. This is supported by the transport API,
> > > but how to expose it to userspace may need more thought.
> > > 
> > > Thanks
> > an ioctl for device config?  But for v1 I'd be quite happy to just have
> > a minimal working device with 2 queues.
> 
> 
> I'm fully agree, and it will work as long as VIRTIO_NET_F_MQ and
> VIRTIO_NET_F_CTRL_VQ is not advertised by the mdev device.
> 
> Thanks

Hmm this means we need to validate the features bits,
not just pass them through to the hardware.
Problem is, how do we add more feature bits later,
without testing all hardware?
I guess this means the device specific driver must do it.


> 
> > 
> > > > Thanks!
