Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0147AC10F00
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 10:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA048217D4
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 10:07:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730778AbfDEKHz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 06:07:55 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54828 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730565AbfDEKHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 06:07:52 -0400
Received: by mail-wm1-f66.google.com with SMTP id c1so6024235wml.4
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 03:07:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+/aW/JnHthgCgmq08tiXc9L78L5w7omyhaWJ3j/podY=;
        b=Qzzr3WhrdhnWHroDOXt0Adk7EmVS/YzZH+cTvj2+GwBnKg1sKYgaUOzPxZV739V3F3
         aoTwL/PSy9se9aO8Z1QAki1pPX9y0DZC7lnMb77OuHJr8wN1MGRsF6YCrx9A6yC1oYPp
         L+KpaCPngNxATHK0oZlkA5Bnl/mvfQFQO2/3z363uMvOo3YBvM4LzlxqVk1MoFM1nc37
         eVmJFRQlaz54pY1fUrdhBd1Jh3N9eI4fw5tAk6EDTFAxW1klk3bYDDfDylrdVBlUc6Xb
         0G7+T+dm+47+CmChoVmoqHSkD4R6jrY1jK76jbw5oBzhykkV4fo0j3A8HvI8DqU45jkC
         kQiA==
X-Gm-Message-State: APjAAAWL3CBK+UI3sHyGy9F1PDCr8gqUWHEX/v7+N7M92zykNbnjxldn
        hhO6UMSpOAS+BAcLqkjhOowL5lTmNc8=
X-Google-Smtp-Source: APXvYqzn6zuSHoGvZpYGa7hqC0hAik4W4vpY9vA8KctZspR1pc0UMWjB6L1RxysITXpB+qIoPK8kbw==
X-Received: by 2002:a1c:39d7:: with SMTP id g206mr6721658wma.99.1554458870928;
        Fri, 05 Apr 2019 03:07:50 -0700 (PDT)
Received: from steredhat (host35-203-static.12-87-b.business.telecomitalia.it. [87.12.203.35])
        by smtp.gmail.com with ESMTPSA id n11sm32222748wrt.63.2019.04.05.03.07.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Apr 2019 03:07:50 -0700 (PDT)
Date:   Fri, 5 Apr 2019 12:07:47 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Stefan Hajnoczi <stefanha@gmail.com>
Cc:     netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH RFC 3/4] vsock/virtio: change the maximum packet size
 allowed
Message-ID: <20190405100747.dbwi3sjaudp3d2wa@steredhat>
References: <20190404105838.101559-1-sgarzare@redhat.com>
 <20190404105838.101559-4-sgarzare@redhat.com>
 <20190405082447.GD25152@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190405082447.GD25152@stefanha-x1.localdomain>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 05, 2019 at 09:24:47AM +0100, Stefan Hajnoczi wrote:
> On Thu, Apr 04, 2019 at 12:58:37PM +0200, Stefano Garzarella wrote:
> > Since now we are able to split packets, we can avoid limiting
> > their sizes to VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE.
> > Instead, we can use VIRTIO_VSOCK_MAX_PKT_BUF_SIZE as the max
> > packet size.
> > 
> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > ---
> >  net/vmw_vsock/virtio_transport_common.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> > index f32301d823f5..822e5d07a4ec 100644
> > --- a/net/vmw_vsock/virtio_transport_common.c
> > +++ b/net/vmw_vsock/virtio_transport_common.c
> > @@ -167,8 +167,8 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
> >  	vvs = vsk->trans;
> >  
> >  	/* we can send less than pkt_len bytes */
> > -	if (pkt_len > VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE)
> > -		pkt_len = VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE;
> > +	if (pkt_len > VIRTIO_VSOCK_MAX_PKT_BUF_SIZE)
> > +		pkt_len = VIRTIO_VSOCK_MAX_PKT_BUF_SIZE;
> 
> The next line limits pkt_len based on available credits:
> 
>   /* virtio_transport_get_credit might return less than pkt_len credit */
>   pkt_len = virtio_transport_get_credit(vvs, pkt_len);
> 
> I think drivers/vhost/vsock.c:vhost_transport_do_send_pkt() now works
> correctly even with pkt_len > VIRTIO_VSOCK_MAX_PKT_BUF_SIZE.

Correct.

> 
> The other ->send_pkt() callback is
> net/vmw_vsock/virtio_transport.c:virtio_transport_send_pkt_work() and it
> can already send any size packet.
> 
> Do you remember why VIRTIO_VSOCK_MAX_PKT_BUF_SIZE still needs to be the
> limit?  I'm wondering if we can get rid of it now and just limit packets
> to the available credits.

There are 2 reasons why I left this limit:
1. When the host receives a packets, it must be <=
   VIRTIO_VSOCK_MAX_PKT_BUF_SIZE [drivers/vhost/vsock.c:vhost_vsock_alloc_pkt()]
   So in this way we can limit the packets sent from the guest.

2. When the host send packets, it help us to increase the parallelism
   (especially if the guest has 64 KB RX buffers) because the user thread
   will split packets, calling multiple times transport->stream_enqueue()
   in net/vmw_vsock/af_vsock.c:vsock_stream_sendmsg() while the
   vhost_transport_send_pkt_work() send them to the guest.


Do you think make sense?

Thanks,
Stefano
