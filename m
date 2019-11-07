Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5821BFA372C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 11:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C34F2187F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 11:21:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388332AbfKGLVl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 06:21:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56888 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388246AbfKGLVk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 06:21:40 -0500
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1207A4DB1F
        for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2019 11:21:40 +0000 (UTC)
Received: by mail-qv1-f72.google.com with SMTP id z12so178989qvi.9
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 03:21:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=wnfHxd+h5ByIy6pNIpYUPsi2zmTYpBRj65XvOkNtL/w=;
        b=cfCHzAKq0GALuY4XxpeS64JhplA7QdufmkFlz9Y/7j10+NHv24zZWsvPvgzJnsMSmf
         t0CGSV9tdyD1a74u8OxASuCti3XxRfhVRhdXwGdpOqD16bFP8OG+r1D31f2LUJCDG3Nm
         HUfP7IrLc3U5fVS7pVf0MvEARtC8hlG6jk1FfwPL4kTdVKe8+RnEJcw/t8ZWeFxH5+hO
         RqOXgwKlkdZjRU68cBohjEjeZY6IQe3EOX2EwRYaCiNHqNIE/AMjl27VlSK/9YOKsI+5
         KcA1lDeMvwS9MyrrYWnJ39nlHD7O6R2JIB0Xa5lOw16WtCySOOhqpp6QwU+T0VGN5WGu
         J6Ag==
X-Gm-Message-State: APjAAAXGVKTn2HEFHuvZYX4008kml038/yeLD1Fb+iOJryeCZEVzrgRN
        Y197uwQDAlR9b3hvrnQdMrGQDX6VPz4ieuLELwGUe5c0+XH+ov44T+a8tV0TbA5JbiBdesN6wZl
        kWIwJIt4KEIw/6in/+zNheSib
X-Received: by 2002:ac8:289d:: with SMTP id i29mr3319312qti.24.1573125698908;
        Thu, 07 Nov 2019 03:21:38 -0800 (PST)
X-Google-Smtp-Source: APXvYqwLKHqje2IEEYthZFjXYN+ipb1SMK7JO7Dpv9RPMHrWqUxiMCMx6JeRQige0AiW+TwcjzGM5w==
X-Received: by 2002:ac8:289d:: with SMTP id i29mr3319270qti.24.1573125698659;
        Thu, 07 Nov 2019 03:21:38 -0800 (PST)
Received: from redhat.com (bzq-79-178-12-128.red.bezeqint.net. [79.178.12.128])
        by smtp.gmail.com with ESMTPSA id u27sm1182961qtj.5.2019.11.07.03.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 03:21:37 -0800 (PST)
Date:   Thu, 7 Nov 2019 06:21:26 -0500
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
        eperezma@redhat.com, lulu@redhat.com, parav@mellanox.com,
        christophe.de.dinechin@gmail.com, kevin.tian@intel.com,
        stefanha@redhat.com
Subject: Re: [PATCH V10 6/6] docs: sample driver to demonstrate how to
 implement virtio-mdev framework
Message-ID: <20191107061942-mutt-send-email-mst@kernel.org>
References: <20191106133531.693-1-jasowang@redhat.com>
 <20191106133531.693-7-jasowang@redhat.com>
 <20191107040700-mutt-send-email-mst@kernel.org>
 <bd2f7796-8d88-0eb3-b55b-3ec062b186b7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bd2f7796-8d88-0eb3-b55b-3ec062b186b7@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2019 at 06:18:45PM +0800, Jason Wang wrote:
> 
> On 2019/11/7 下午5:08, Michael S. Tsirkin wrote:
> > On Wed, Nov 06, 2019 at 09:35:31PM +0800, Jason Wang wrote:
> > > This sample driver creates mdev device that simulate virtio net device
> > > over virtio mdev transport. The device is implemented through vringh
> > > and workqueue. A device specific dma ops is to make sure HVA is used
> > > directly as the IOVA. This should be sufficient for kernel virtio
> > > driver to work.
> > > 
> > > Only 'virtio' type is supported right now. I plan to add 'vhost' type
> > > on top which requires some virtual IOMMU implemented in this sample
> > > driver.
> > > 
> > > Acked-by: Cornelia Huck<cohuck@redhat.com>
> > > Signed-off-by: Jason Wang<jasowang@redhat.com>
> > I'd prefer it that we call this something else, e.g.
> > mvnet-loopback. Just so people don't expect a fully
> > functional device somehow. Can be renamed when applying?
> 
> 
> Actually, I plan to extend it as another standard network interface for
> kernel. It could be either a standalone pseudo device or a stack device.
> Does this sounds good to you?
> 
> Thanks

That's a big change in an interface so it's a good reason
to rename the driver at that point right?
Oherwise users of an old kernel would expect a stacked driver
and get a loopback instead.

Or did I miss something?

> 
> > 
> > 
