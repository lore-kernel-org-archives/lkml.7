Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14BB5C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 08:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB38521738
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 08:16:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730325AbfDEIQx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 04:16:53 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45586 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbfDEIQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 04:16:53 -0400
Received: by mail-wr1-f68.google.com with SMTP id s15so6822188wra.12
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 01:16:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Uww6dZz3lxCpRpT/ma2nFyPidH/CJqrtzpNQ35KEFAI=;
        b=CydBjWdALs4C6pp2DFYbCWTYTBBGoOr175yzVAP+ATNCZr8y/zLZaWpcamfpDsdY/q
         J/zXGFF+nooAHuaMSf6/8q1mc2QxOaRijHa772zrHnUs1Nw8OFkKzvcuuMjomPPFZCHl
         bmKZab+6m5hEmwnss6valQRfPsjfnnjiREdl+CEp9nK5tnYIRn1eqd52NYdSt+KElN9w
         8CH9OfELI0nyvMj2tTlaGBnDVyCj4GVeZlns5dtnDRg9S/C47JnjzXymRY7qIaEAxj70
         dLqfZYPar+HPjNss8lrx7BILmVLFoxXdy83O+eE9fLNqNpO9LB/Csef9aKC9LJ7kGuBH
         Z2VA==
X-Gm-Message-State: APjAAAUvQVkUXfm5ygiW92t/VcMe5PVgz/Xf742QtiOQhc2vyFSLHA5S
        tcOUBdmQ7ZUPQ6g2aC5FvkIYJw==
X-Google-Smtp-Source: APXvYqyuZBKB/PW1tVCBvjF2nKCoZ5C0nZIjguoLcgoed+Cl7o9B1C0DZOJcTj5mJ5ILobNYGBpUnA==
X-Received: by 2002:adf:ed90:: with SMTP id c16mr7805750wro.74.1554452211647;
        Fri, 05 Apr 2019 01:16:51 -0700 (PDT)
Received: from steredhat (host35-203-static.12-87-b.business.telecomitalia.it. [87.12.203.35])
        by smtp.gmail.com with ESMTPSA id j11sm27420999wrw.85.2019.04.05.01.16.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Apr 2019 01:16:51 -0700 (PDT)
Date:   Fri, 5 Apr 2019 10:16:48 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Stefan Hajnoczi <stefanha@gmail.com>
Cc:     netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH RFC 1/4] vsock/virtio: reduce credit update messages
Message-ID: <20190405081648.2zflr7gxknk4q3a2@steredhat>
References: <20190404105838.101559-1-sgarzare@redhat.com>
 <20190404105838.101559-2-sgarzare@redhat.com>
 <20190404191539.GB25152@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190404191539.GB25152@stefanha-x1.localdomain>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2019 at 08:15:39PM +0100, Stefan Hajnoczi wrote:
> On Thu, Apr 04, 2019 at 12:58:35PM +0200, Stefano Garzarella wrote:
> > @@ -256,6 +257,7 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
> >  	struct virtio_vsock_sock *vvs = vsk->trans;
> >  	struct virtio_vsock_pkt *pkt;
> >  	size_t bytes, total = 0;
> > +	s64 free_space;
> 
> Why s64?  buf_alloc, fwd_cnt, and last_fwd_cnt are all u32.  fwd_cnt -
> last_fwd_cnt <= buf_alloc is always true.
> 

Right, I'll use a u32 for free_space!
Is is a leftover because initially I implemented something like
virtio_transport_has_space().

> >  	int err = -EFAULT;
> >  
> >  	spin_lock_bh(&vvs->rx_lock);
> > @@ -288,9 +290,15 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
> >  	}
> >  	spin_unlock_bh(&vvs->rx_lock);
> >  
> > -	/* Send a credit pkt to peer */
> > -	virtio_transport_send_credit_update(vsk, VIRTIO_VSOCK_TYPE_STREAM,
> > -					    NULL);
> > +	/* We send a credit update only when the space available seen
> > +	 * by the transmitter is less than VIRTIO_VSOCK_MAX_PKT_BUF_SIZE
> > +	 */
> > +	free_space = vvs->buf_alloc - (vvs->fwd_cnt - vvs->last_fwd_cnt);
> 
> Locking?  These fields should be accessed under tx_lock.
> 

Yes, we need a lock, but looking in the code, vvs->fwd_cnd is written
taking rx_lock (virtio_transport_dec_rx_pkt) and it is read with the
tx_lock (virtio_transport_inc_tx_pkt).

Maybe we should use another spin_lock shared between RX and TX for those
fields or use atomic variables.

What do you suggest?

Thanks,
Stefano

