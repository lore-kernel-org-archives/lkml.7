Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B0FC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 07:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C80F32053B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 07:38:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbfICHis (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 03:38:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36722 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727864AbfICHip (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 03:38:45 -0400
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2F7D080F98
        for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2019 07:38:44 +0000 (UTC)
Received: by mail-qt1-f200.google.com with SMTP id i9so17075118qtj.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 00:38:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dJ3ujh22A4KMEYrsGqSfrfiJ4zKfJp828Rn6w4xYjq8=;
        b=S9uM4rWrbDfCiIdxp/JRccf9+t3DFURSFg93QqV5Bfw/+Rer+RF0NFlgJl6nw+1eIC
         SjhDkh65YHrCeKCFg9xEBo79dNeGatLkyHWFk/xqO7UUNlfyjXfzZiN7y56ZmtY5m5Hs
         FUIBMzcps+ojE9rgAxaFkmAs8aPHN/aJyymhbhiLvCTSYT7DhUa91h002WI/4NsjMVa5
         KqeXNcE/OkhFKlcU6+ITA/nk389+wSe0EyYx+V6piItg4qlMg00khljXbAeVV7MfLsQA
         I7Sh/0aCgPHpGeTlN5yKOoYJaGXFqCPQ2F67cTdg5p0gcNkbZ3BCGde6rqoV8WbiV/IO
         lz4w==
X-Gm-Message-State: APjAAAXrvYhEH7jQvpboJ0B6deGUH9CN4OGTQOoNCMJGu+K/dW9sWEdx
        LUdkKktUNDeFz5i92NHr9A3JJDMa426KA6cEK2a9IVBJFxkXksbYkZ/Qx8rp4XKRCjxjd/jddZC
        rRtHdcy7Shv6glLw3bLa6mixN
X-Received: by 2002:ac8:7186:: with SMTP id w6mr19355759qto.371.1567496323076;
        Tue, 03 Sep 2019 00:38:43 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxXMPchjPlOKDNWkkZ17/EkNv3hNqMtNhBrOkfnvAF3RBYMzvVKwnBnpdltNIMKvZOntgUYhw==
X-Received: by 2002:ac8:7186:: with SMTP id w6mr19355740qto.371.1567496322915;
        Tue, 03 Sep 2019 00:38:42 -0700 (PDT)
Received: from redhat.com (bzq-79-180-62-110.red.bezeqint.net. [79.180.62.110])
        by smtp.gmail.com with ESMTPSA id m19sm8425732qke.22.2019.09.03.00.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 00:38:42 -0700 (PDT)
Date:   Tue, 3 Sep 2019 03:38:37 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        virtualization@lists.linux-foundation.org,
        Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org
Subject: Re: [PATCH v4 2/5] vsock/virtio: reduce credit update messages
Message-ID: <20190903033344-mutt-send-email-mst@kernel.org>
References: <20190717113030.163499-1-sgarzare@redhat.com>
 <20190717113030.163499-3-sgarzare@redhat.com>
 <20190903003050-mutt-send-email-mst@kernel.org>
 <20190903073120.kefllalytkvidcvh@steredhat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903073120.kefllalytkvidcvh@steredhat>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2019 at 09:31:20AM +0200, Stefano Garzarella wrote:
> On Tue, Sep 03, 2019 at 12:38:02AM -0400, Michael S. Tsirkin wrote:
> > On Wed, Jul 17, 2019 at 01:30:27PM +0200, Stefano Garzarella wrote:
> > > In order to reduce the number of credit update messages,
> > > we send them only when the space available seen by the
> > > transmitter is less than VIRTIO_VSOCK_MAX_PKT_BUF_SIZE.
> > > 
> > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > > ---
> > >  include/linux/virtio_vsock.h            |  1 +
> > >  net/vmw_vsock/virtio_transport_common.c | 16 +++++++++++++---
> > >  2 files changed, 14 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
> > > index 7d973903f52e..49fc9d20bc43 100644
> > > --- a/include/linux/virtio_vsock.h
> > > +++ b/include/linux/virtio_vsock.h
> > > @@ -41,6 +41,7 @@ struct virtio_vsock_sock {
> > >  
> > >  	/* Protected by rx_lock */
> > >  	u32 fwd_cnt;
> > > +	u32 last_fwd_cnt;
> > >  	u32 rx_bytes;
> > >  	struct list_head rx_queue;
> > >  };
> > > diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> > > index 095221f94786..a85559d4d974 100644
> > > --- a/net/vmw_vsock/virtio_transport_common.c
> > > +++ b/net/vmw_vsock/virtio_transport_common.c
> > > @@ -211,6 +211,7 @@ static void virtio_transport_dec_rx_pkt(struct virtio_vsock_sock *vvs,
> > >  void virtio_transport_inc_tx_pkt(struct virtio_vsock_sock *vvs, struct virtio_vsock_pkt *pkt)
> > >  {
> > >  	spin_lock_bh(&vvs->tx_lock);
> > > +	vvs->last_fwd_cnt = vvs->fwd_cnt;
> > >  	pkt->hdr.fwd_cnt = cpu_to_le32(vvs->fwd_cnt);
> > >  	pkt->hdr.buf_alloc = cpu_to_le32(vvs->buf_alloc);
> > >  	spin_unlock_bh(&vvs->tx_lock);
> > > @@ -261,6 +262,7 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
> > >  	struct virtio_vsock_sock *vvs = vsk->trans;
> > >  	struct virtio_vsock_pkt *pkt;
> > >  	size_t bytes, total = 0;
> > > +	u32 free_space;
> > >  	int err = -EFAULT;
> > >  
> > >  	spin_lock_bh(&vvs->rx_lock);
> > > @@ -291,11 +293,19 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
> > >  			virtio_transport_free_pkt(pkt);
> > >  		}
> > >  	}
> > > +
> > > +	free_space = vvs->buf_alloc - (vvs->fwd_cnt - vvs->last_fwd_cnt);
> > > +
> > >  	spin_unlock_bh(&vvs->rx_lock);
> > >  
> > > -	/* Send a credit pkt to peer */
> > > -	virtio_transport_send_credit_update(vsk, VIRTIO_VSOCK_TYPE_STREAM,
> > > -					    NULL);
> > > +	/* We send a credit update only when the space available seen
> > > +	 * by the transmitter is less than VIRTIO_VSOCK_MAX_PKT_BUF_SIZE
> > 
> > This is just repeating what code does though.
> > Please include the *reason* for the condition.
> > E.g. here's a better comment:
> > 
> > 	/* To reduce number of credit update messages,
> > 	 * don't update credits as long as lots of space is available.
> > 	 * Note: the limit chosen here is arbitrary. Setting the limit
> > 	 * too high causes extra messages. Too low causes transmitter
> > 	 * stalls. As stalls are in theory more expensive than extra
> > 	 * messages, we set the limit to a high value. TODO: experiment
> > 	 * with different values.
> > 	 */
> > 
> 
> Yes, it is better, sorry for that. I'll try to avoid unnecessary comments,
> explaining the reason for certain changes.
> 
> Since this patch is already queued in net-next, should I send another
> patch to fix the comment?
> 
> Thanks,
> Stefano

I just sent a patch like that, pls ack it.

-- 
MST
