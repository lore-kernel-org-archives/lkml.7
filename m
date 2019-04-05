Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68F6FC10F0F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 09:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B9B1217D4
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 09:36:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730715AbfDEJgO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 05:36:14 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51555 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730292AbfDEJgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 05:36:13 -0400
Received: by mail-wm1-f65.google.com with SMTP id 4so5947304wmf.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 02:36:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7t2YhM9bMG5fr2PiPX7uI0h0i6e4KRRmywuGCr6x+QI=;
        b=eXE/lYth804hvzoYavBL4/qDEyT9Mxnm7Tq7OE3JzITWWrRN236ybvUypBOeOlDT2b
         hu2R+PggqdEMnc+O+oI/+797iO0SWXz/dxView/KiNE+BFs6z1uVCvhJZtQreD1w0bFu
         9dxRNRAlUXQEL/CRqneD+cuDOEcFVNBra45DsGwzdfQ95nIpejFeAle+jAxwB74GbRdF
         snsu8XqZsbQQdlS6V3WcT1ryt7Z6C/fR79iWyv8XKDPh7VOzhT2l5yhJKlgm6v/7ovQ3
         Mw7gCN5x7lQiWhMvOoqWwlB0Aa0HLpQ/V6Ucmv63C2dlt2DHaPZMjd87nFFt3jXkjvf6
         ZGMQ==
X-Gm-Message-State: APjAAAWg9sfB87xTZjDdTGq/IDR98RbKwvDigwi7PVTCN/gy8GssLVjp
        cNnnGS1eCp92eXJ9DQ8WpTURXw==
X-Google-Smtp-Source: APXvYqwh+2QqFA7z64dOBNXE1UGtVFDfKGtOy80qeYKLGZCUWnZ/Du3x96DOwkHUg5GC283xpg7qlA==
X-Received: by 2002:a7b:c446:: with SMTP id l6mr3818705wmi.80.1554456971831;
        Fri, 05 Apr 2019 02:36:11 -0700 (PDT)
Received: from steredhat (host35-203-static.12-87-b.business.telecomitalia.it. [87.12.203.35])
        by smtp.gmail.com with ESMTPSA id y133sm3029692wmd.2.2019.04.05.02.36.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Apr 2019 02:36:10 -0700 (PDT)
Date:   Fri, 5 Apr 2019 11:36:08 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Stefan Hajnoczi <stefanha@gmail.com>
Cc:     netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH RFC 2/4] vhost/vsock: split packets to send using
 multiple buffers
Message-ID: <20190405093608.f2zsyxnjxcba5v6r@steredhat>
References: <20190404105838.101559-1-sgarzare@redhat.com>
 <20190404105838.101559-3-sgarzare@redhat.com>
 <20190405081356.GC25152@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190405081356.GC25152@stefanha-x1.localdomain>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 05, 2019 at 09:13:56AM +0100, Stefan Hajnoczi wrote:
> On Thu, Apr 04, 2019 at 12:58:36PM +0200, Stefano Garzarella wrote:
> > @@ -139,8 +139,18 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
> >  			break;
> >  		}
> >  
> > -		len = iov_length(&vq->iov[out], in);
> > -		iov_iter_init(&iov_iter, READ, &vq->iov[out], in, len);
> > +		payload_len = pkt->len - pkt->off;
> > +		iov_len = iov_length(&vq->iov[out], in);
> > +		iov_iter_init(&iov_iter, READ, &vq->iov[out], in, iov_len);
> > +
> > +		/* If the packet is greater than the space available in the
> > +		 * buffer, we split it using multiple buffers.
> > +		 */
> > +		if (payload_len > iov_len - sizeof(pkt->hdr))
> 
> Integer underflow.  iov_len is controlled by the guest and therefore
> untrusted.  Please validate iov_len before assuming it's larger than
> sizeof(pkt->hdr).
> 

Okay, I'll do it!

> > -		vhost_add_used(vq, head, sizeof(pkt->hdr) + pkt->len);
> > +		vhost_add_used(vq, head, sizeof(pkt->hdr) + payload_len);
> >  		added = true;
> >  
> > +		pkt->off += payload_len;
> > +
> > +		/* If we didn't send all the payload we can requeue the packet
> > +		 * to send it with the next available buffer.
> > +		 */
> > +		if (pkt->off < pkt->len) {
> > +			spin_lock_bh(&vsock->send_pkt_list_lock);
> > +			list_add(&pkt->list, &vsock->send_pkt_list);
> > +			spin_unlock_bh(&vsock->send_pkt_list_lock);
> > +			continue;
> 
> The virtio_transport_deliver_tap_pkt() call is skipped.  Packet capture
> should see the exact packets that are delivered.  I think this patch
> will present one large packet instead of several smaller packets that
> were actually delivered.

I'll modify virtio_transport_build_skb() to take care of pkt->off
and reading the payload size from the virtio_vsock_hdr.
Otherwise, should I introduce another field in virtio_vsock_pkt to store
the payload size?

Thanks,
Stefano
