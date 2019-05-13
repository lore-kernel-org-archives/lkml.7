Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B191C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 17:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1928D20879
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 17:51:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731897AbfEMRvs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 13:51:48 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54250 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731830AbfEMRvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 13:51:44 -0400
Received: by mail-wm1-f65.google.com with SMTP id 198so233759wme.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 10:51:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=YywBhd718B/DKtpyrTe7ekQZi7NNkVMxHXFs5r/UkzU=;
        b=jKTH0L/1Bt11Ru7OZKPQ4CRkUAYPBhzjVkkbX2aDstA4le0QfeUCSLq6Q2gDS8GYIf
         sMDseMnV0hSIHkfiy5/hIiVByjKYc2rTZRVTsg08wPNnqzbQMiUIqypAE59eykJGXjoh
         GheLMjNDqjsmr4zrPcank2mMmYvOJCaVoqIDsVv/rszuch64rm2xz+o1ov8jiXMpFgrO
         zlGQv7CABes2Is4M4mI1xWRG2IIkufhtvO2iBT/8IQFlFhrHhP5Z8QNOdnQasGhLgTob
         ANZazLw6w4l/qlLhtUOdM65t7n1dgTV2iLQN0cEEl8ywiyhS25awVyIZZxqbXzaq8tJd
         GXNQ==
X-Gm-Message-State: APjAAAXVd1RwiUtdPT0e3XrAQk6Ae+Jk/RqtaoE90Wqu4JuO5wCfylBr
        kgMpMU0LB4EKpdezzlknSXb2OQ==
X-Google-Smtp-Source: APXvYqwIUwuqMl8h+g4rfizOwGvKS5bfbCa0CnOcHXmQACgAyWBKmcpVwSB4wHSIlaL+ZzJ2dbSatQ==
X-Received: by 2002:a1c:f910:: with SMTP id x16mr16414740wmh.114.1557769902025;
        Mon, 13 May 2019 10:51:42 -0700 (PDT)
Received: from steredhat (host151-251-static.12-87-b.business.telecomitalia.it. [87.12.251.151])
        by smtp.gmail.com with ESMTPSA id y40sm14326745wrd.96.2019.05.13.10.51.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 May 2019 10:51:41 -0700 (PDT)
Date:   Mon, 13 May 2019 19:51:38 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v2 7/8] vsock/virtio: increase RX buffer size to 64 KiB
Message-ID: <20190513175138.4yycad2xi65komw6@steredhat>
References: <20190510125843.95587-1-sgarzare@redhat.com>
 <20190510125843.95587-8-sgarzare@redhat.com>
 <bf0416f1-0e69-722d-75ce-3d101e6d7d71@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bf0416f1-0e69-722d-75ce-3d101e6d7d71@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13, 2019 at 06:01:52PM +0800, Jason Wang wrote:
> 
> On 2019/5/10 下午8:58, Stefano Garzarella wrote:
> > In order to increase host -> guest throughput with large packets,
> > we can use 64 KiB RX buffers.
> > 
> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > ---
> >   include/linux/virtio_vsock.h | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
> > index 84b72026d327..5a9d25be72df 100644
> > --- a/include/linux/virtio_vsock.h
> > +++ b/include/linux/virtio_vsock.h
> > @@ -10,7 +10,7 @@
> >   #define VIRTIO_VSOCK_DEFAULT_MIN_BUF_SIZE	128
> >   #define VIRTIO_VSOCK_DEFAULT_BUF_SIZE		(1024 * 256)
> >   #define VIRTIO_VSOCK_DEFAULT_MAX_BUF_SIZE	(1024 * 256)
> > -#define VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE	(1024 * 4)
> > +#define VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE	(1024 * 64)
> >   #define VIRTIO_VSOCK_MAX_BUF_SIZE		0xFFFFFFFFUL
> >   #define VIRTIO_VSOCK_MAX_PKT_BUF_SIZE		(1024 * 64)
> 
> 
> We probably don't want such high order allocation. It's better to switch to
> use order 0 pages in this case. See add_recvbuf_big() for virtio-net. If we
> get datapath unified, we will get more stuffs set.

IIUC, you are suggesting to allocate only pages and put them in a
scatterlist, then add them to the virtqueue.

Is it correct?

The issue that I have here, is that the virtio-vsock guest driver, see
virtio_vsock_rx_fill(), allocates a struct virtio_vsock_pkt that
contains the room for the header, then allocates the buffer for the payload.
At this point it fills the scatterlist with the &virtio_vsock_pkt.hdr and the
buffer for the payload.

Changing this will require several modifications, and if we get datapath
unified, I'm not sure it's worth it.
Of course, if we leave the datapaths separated, I'd like to do that later.

What do you think?

Thanks,
Stefano
