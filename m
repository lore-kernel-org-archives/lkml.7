Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0715BC282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 14:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCF09217F4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 14:55:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbfDHOzh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 10:55:37 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38343 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbfDHOzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 10:55:36 -0400
Received: by mail-wm1-f65.google.com with SMTP id w15so15076207wmc.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 07:55:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=d+VXGRvLJl/73j3SUvoZqzzhsYpvSaoUrtP7cc7XveQ=;
        b=OVuqabJ0jrQ23lhnokdGuyobcd0Nc0n9ex74NVMGL3Z8hJ4OThQlA8FZBEChTSdWOQ
         q3yHHwN2z1MHnhQzEvri0WSXE1cut4ln3WB65mgG08b9f+bWbrAEU7vGtGS59k+pQEca
         v5Vf6i1SkxzyNh+oUtFb5Fs5QJg2MaODQBCGwzJPA1Teu2cS9FqLYHMQVcGmmrgpMEg7
         +m5Ig+GjqfOkbRDEQXf/z0FJLSJ+iHgHutGUuSwD2g1tRX6ZHhhzCESMMLDr0G6KzteS
         cikgOcyWHhLYjwdnBGepXeCyjZCsN7ZUm7UroNlH1eUhBfy6NUn8el1wqS+kpUKM8fvA
         Eo1w==
X-Gm-Message-State: APjAAAWninDwsWIPrXfzVpYFFxQtQB92zhHUkaaym366xELbLZamPToW
        vry0/4aPXnxNk601YZxW65+s5g==
X-Google-Smtp-Source: APXvYqwF66ndE12RskCSuH3hhho6ZGzmohFKXkWV1NNxQNDtBZyZcKYSyxFotJYhRg8eg4klTr6iWA==
X-Received: by 2002:a1c:5543:: with SMTP id j64mr9267773wmb.37.1554735335117;
        Mon, 08 Apr 2019 07:55:35 -0700 (PDT)
Received: from steredhat (host35-203-static.12-87-b.business.telecomitalia.it. [87.12.203.35])
        by smtp.gmail.com with ESMTPSA id z7sm9809225wml.40.2019.04.08.07.55.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Apr 2019 07:55:34 -0700 (PDT)
Date:   Mon, 8 Apr 2019 16:55:31 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     Stefan Hajnoczi <stefanha@gmail.com>, netdev@vger.kernel.org,
        Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH RFC 3/4] vsock/virtio: change the maximum packet size
 allowed
Message-ID: <20190408145531.yreyawkn5vjqj7sl@steredhat>
References: <20190404105838.101559-1-sgarzare@redhat.com>
 <20190404105838.101559-4-sgarzare@redhat.com>
 <20190405082447.GD25152@stefanha-x1.localdomain>
 <20190405100747.dbwi3sjaudp3d2wa@steredhat>
 <20190408093723.GP15001@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190408093723.GP15001@stefanha-x1.localdomain>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 08, 2019 at 10:37:23AM +0100, Stefan Hajnoczi wrote:
> On Fri, Apr 05, 2019 at 12:07:47PM +0200, Stefano Garzarella wrote:
> > On Fri, Apr 05, 2019 at 09:24:47AM +0100, Stefan Hajnoczi wrote:
> > > On Thu, Apr 04, 2019 at 12:58:37PM +0200, Stefano Garzarella wrote:
> > > > Since now we are able to split packets, we can avoid limiting
> > > > their sizes to VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE.
> > > > Instead, we can use VIRTIO_VSOCK_MAX_PKT_BUF_SIZE as the max
> > > > packet size.
> > > > 
> > > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > > > ---
> > > >  net/vmw_vsock/virtio_transport_common.c | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> > > > index f32301d823f5..822e5d07a4ec 100644
> > > > --- a/net/vmw_vsock/virtio_transport_common.c
> > > > +++ b/net/vmw_vsock/virtio_transport_common.c
> > > > @@ -167,8 +167,8 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
> > > >  	vvs = vsk->trans;
> > > >  
> > > >  	/* we can send less than pkt_len bytes */
> > > > -	if (pkt_len > VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE)
> > > > -		pkt_len = VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE;
> > > > +	if (pkt_len > VIRTIO_VSOCK_MAX_PKT_BUF_SIZE)
> > > > +		pkt_len = VIRTIO_VSOCK_MAX_PKT_BUF_SIZE;
> > > 
> > > The next line limits pkt_len based on available credits:
> > > 
> > >   /* virtio_transport_get_credit might return less than pkt_len credit */
> > >   pkt_len = virtio_transport_get_credit(vvs, pkt_len);
> > > 
> > > I think drivers/vhost/vsock.c:vhost_transport_do_send_pkt() now works
> > > correctly even with pkt_len > VIRTIO_VSOCK_MAX_PKT_BUF_SIZE.
> > 
> > Correct.
> > 
> > > 
> > > The other ->send_pkt() callback is
> > > net/vmw_vsock/virtio_transport.c:virtio_transport_send_pkt_work() and it
> > > can already send any size packet.
> > > 
> > > Do you remember why VIRTIO_VSOCK_MAX_PKT_BUF_SIZE still needs to be the
> > > limit?  I'm wondering if we can get rid of it now and just limit packets
> > > to the available credits.
> > 
> > There are 2 reasons why I left this limit:
> > 1. When the host receives a packets, it must be <=
> >    VIRTIO_VSOCK_MAX_PKT_BUF_SIZE [drivers/vhost/vsock.c:vhost_vsock_alloc_pkt()]
> >    So in this way we can limit the packets sent from the guest.
> 
> The general intent is to prevent the guest from sending huge buffers.
> This is good.
> 
> However, the guest must already obey the credit limit advertized by the
> host.  Therefore I think we should be checking against that instead of
> an arbitrary constant limit.
> 
> So I think the limit should be the receive buffer size, not
> VIRTIO_VSOCK_MAX_PKT_BUF_SIZE.  But at this point the code doesn't know
> which connection the packet is associated with and cannot check the
> receive buffer size. :(
> 
> Anyway, any change to this behavior requires compatibility so new guest
> drivers work with old vhost_vsock.ko.  Therefore we should probably just
> leave the limit for now.

I understood your point of view and I completely agree with you.
But, until we don't have a way to expose features/versions between guest
and host, maybe is better to leave the limit in order to be compatible
with old vhost_vsock.

> 
> > 2. When the host send packets, it help us to increase the parallelism
> >    (especially if the guest has 64 KB RX buffers) because the user thread
> >    will split packets, calling multiple times transport->stream_enqueue()
> >    in net/vmw_vsock/af_vsock.c:vsock_stream_sendmsg() while the
> >    vhost_transport_send_pkt_work() send them to the guest.
> 
> Sorry, I don't understand the reasoning.  Overall this creates more
> work.  Are you saying the benefit is that
> vhost_transport_send_pkt_work() can run "early" and notify the guest of
> partial rx data before all of it has been enqueued?

Something like that. Your reasoning is more accurate.
Anyway, I'll do some tests in order to understand better the behaviour!

Thanks,
Stefano
