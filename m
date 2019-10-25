Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02111CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 12:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D13602070B
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 12:16:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504424AbfJYMQf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 08:16:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51364 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2504329AbfJYMQf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 08:16:35 -0400
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AAA67C049E12
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 12:16:34 +0000 (UTC)
Received: by mail-qk1-f198.google.com with SMTP id s3so1945314qkd.6
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 05:16:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=lDtOQyoiNI8iBD+BJV41nuz3/0N81N8+l8LN/u4t5zU=;
        b=kAvmEpb5uELYnqamHHxQbGMWYw4BxswXrAxl0qWuuebCTH8DevFAEcxMvvWBVuZ40C
         3rIwLoEmP5LxpF7mEpLWRu9jcd68/4vPpHQoM3fuftfJiA28mgYPal2z7MUfE6KJU1aj
         7Myd6mII+lSONEpMHJCp2zYwcTSJ6cOG9O+2gzJjyeJO0xgUFfZDqOTLEuX/jfGF6OSN
         eHOljOkLF/eM7J7dsmQDLd0sm1eMtBNjSD26EwcJZCe6a+Pk+dCFyIOAvGZcfJCW9nrT
         yEDZBy5ZNCFUvVTyrEn/Nnr4st7z3NqUkPEi2ArxVJYU/+nR+0ER0t0o1mIb0xtLcJqE
         u3oQ==
X-Gm-Message-State: APjAAAWmlJTrZFCoREUTDKof0iFkrYp+BQiO0pI5/PiJQdF8FSSWSwmy
        6s/jtKjJpVG6h4T34IwWsGFIexregKQkWoz+QWQFM5wPSUrWJ6HYEH+F+qWT9vc6dZRIFYcAkOy
        st1eBW30I028+9yG2tgc7tBLN
X-Received: by 2002:ac8:1109:: with SMTP id c9mr2661806qtj.10.1572005793998;
        Fri, 25 Oct 2019 05:16:33 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwK3+y0bW2iZzlHnWckL9qOZZ46Wovnc/341JCURY96Ut9tQ0zB6Sv5xfgv85VGvBF7MyqL9g==
X-Received: by 2002:ac8:1109:: with SMTP id c9mr2661774qtj.10.1572005793671;
        Fri, 25 Oct 2019 05:16:33 -0700 (PDT)
Received: from redhat.com (bzq-79-176-10-77.red.bezeqint.net. [79.176.10.77])
        by smtp.gmail.com with ESMTPSA id s21sm1555600qtc.12.2019.10.25.05.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 05:16:32 -0700 (PDT)
Date:   Fri, 25 Oct 2019 08:16:26 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Tiwei Bie <tiwei.bie@intel.com>, alex.williamson@redhat.com,
        maxime.coquelin@redhat.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, dan.daly@intel.com,
        cunming.liang@intel.com, zhihong.wang@intel.com,
        lingshan.zhu@intel.com
Subject: Re: [PATCH v2] vhost: introduce mdev based hardware backend
Message-ID: <20191025080143-mutt-send-email-mst@kernel.org>
References: <20191023070747.GA30533@___>
 <106834b5-dae5-82b2-0f97-16951709d075@redhat.com>
 <20191023101135.GA6367@___>
 <5a7bc5da-d501-2750-90bf-545dd55f85fa@redhat.com>
 <20191024042155.GA21090@___>
 <d37529e1-5147-bbe5-cb9d-299bd6d4aa1a@redhat.com>
 <d4cc4f4e-2635-4041-2f68-cd043a97f25a@redhat.com>
 <20191024091839.GA17463@___>
 <fefc82a3-a137-bc03-e1c3-8de79b238080@redhat.com>
 <e7e239ba-2461-4f8d-7dd7-0f557ac7f4bf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e7e239ba-2461-4f8d-7dd7-0f557ac7f4bf@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2019 at 05:54:55PM +0800, Jason Wang wrote:
> 
> On 2019/10/24 下午6:42, Jason Wang wrote:
> > 
> > Yes.
> > 
> > 
> > >   And we should try to avoid
> > > putting ctrl vq and Rx/Tx vqs in the same DMA space to prevent
> > > guests having the chance to bypass the host (e.g. QEMU) to
> > > setup the backend accelerator directly.
> > 
> > 
> > That's really good point.  So when "vhost" type is created, parent
> > should assume addr of ctrl_vq is hva.
> > 
> > Thanks
> 
> 
> This works for vhost but not virtio since there's no way for virtio kernel
> driver to differ ctrl_vq with the rest when doing DMA map. One possible
> solution is to provide DMA domain isolation between virtqueues. Then ctrl vq
> can use its dedicated DMA domain for the work.
> 
> Anyway, this could be done in the future. We can have a version first that
> doesn't support ctrl_vq.
> 
> Thanks

Well no ctrl_vq implies either no offloads, or no XDP (since XDP needs
to disable offloads dynamically).

        if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS)
            && (virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_TSO4) ||
                virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_TSO6) ||
                virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_ECN) ||
                virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_UFO) ||
                virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_CSUM))) {
                NL_SET_ERR_MSG_MOD(extack, "Can't set XDP while host is implementing LRO/CSUM, disable LRO/CSUM first");
                return -EOPNOTSUPP;
        }

neither is very attractive.

So yes ok just for development but we do need to figure out how it will
work down the road in production.

So really this specific virtio net device does not support control vq,
instead it supports a different transport specific way to send commands
to device.

Some kind of extension to the transport? Ideas?


-- 
MST
