Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12607C3A5A7
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 09:41:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E575323427
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 09:41:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbfH3JlK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 05:41:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59792 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727814AbfH3JlG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 05:41:06 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AE6CE2A09B1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 09:41:05 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id t16so4017164wro.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 02:41:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kV8MoK4zo74Y5DGCQJLGcYeGhPzzvX5u0gV32d1E+3k=;
        b=B2/8ABjWndHdVmCKgevTwu5RdFmGW0dOe1YDL8Vwg2AXLNsvGnxeuk+Zv6BWxqS29h
         m5DIpkVeZeaUcnF6KLlcuy4E5TC+bc8e1ldQ8ptzAlMwJghR89ihV+I4g76Ou1L8evS/
         FvHqedCo2izMbxf03/T3dMO9ygUj7Fri0LRmfUzj1oq/xFdjdpo+ZKYSYRvj+J/ltBC7
         a/ioWR/rQvOWcRj/HtthAeSyHxDBoFGjvZATD3e4HbYOm5WbLIl5HZQ225AYX852wFaR
         Gi32MwbJ+fUTKsQy2av9Hlx2cUtNbzcMZZayGgpR2bSxnl2xQJYRxLeRQcKnF6fPnaSt
         EVLQ==
X-Gm-Message-State: APjAAAXLGRYDaG2XD3urtWXredpgCqpHC2IdUYO+Hhw3Ru/aoQBgqgpK
        XrbtQ1ACBGNs6Sh7pJnXz4CbPgAOyNUrEfWNgaPwOiy5hxIVxi7HSLj38G/xwnJu3kPAPvHYVvH
        XqeuAu2Z0/bXHFUZ0THd8JjxA
X-Received: by 2002:a05:6000:1002:: with SMTP id a2mr5516593wrx.28.1567158063834;
        Fri, 30 Aug 2019 02:41:03 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzM/jUL1y2rI43opYvOASgV8Zt/IRRsHiQXSp3BkM+SWkgtSeboge6QBt/hSUqVBlcs47bGGA==
X-Received: by 2002:a05:6000:1002:: with SMTP id a2mr5516548wrx.28.1567158063481;
        Fri, 30 Aug 2019 02:41:03 -0700 (PDT)
Received: from steredhat (host122-201-dynamic.13-79-r.retail.telecomitalia.it. [79.13.201.122])
        by smtp.gmail.com with ESMTPSA id w13sm12490070wre.44.2019.08.30.02.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2019 02:41:02 -0700 (PDT)
Date:   Fri, 30 Aug 2019 11:40:59 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        virtualization@lists.linux-foundation.org,
        Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org
Subject: Re: [PATCH v4 1/5] vsock/virtio: limit the memory used per-socket
Message-ID: <20190830094059.c7qo5cxrp2nkrncd@steredhat>
References: <20190717113030.163499-1-sgarzare@redhat.com>
 <20190717113030.163499-2-sgarzare@redhat.com>
 <20190729095956-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190729095956-mutt-send-email-mst@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 10:04:29AM -0400, Michael S. Tsirkin wrote:
> On Wed, Jul 17, 2019 at 01:30:26PM +0200, Stefano Garzarella wrote:
> > Since virtio-vsock was introduced, the buffers filled by the host
> > and pushed to the guest using the vring, are directly queued in
> > a per-socket list. These buffers are preallocated by the guest
> > with a fixed size (4 KB).
> > 
> > The maximum amount of memory used by each socket should be
> > controlled by the credit mechanism.
> > The default credit available per-socket is 256 KB, but if we use
> > only 1 byte per packet, the guest can queue up to 262144 of 4 KB
> > buffers, using up to 1 GB of memory per-socket. In addition, the
> > guest will continue to fill the vring with new 4 KB free buffers
> > to avoid starvation of other sockets.
> > 
> > This patch mitigates this issue copying the payload of small
> > packets (< 128 bytes) into the buffer of last packet queued, in
> > order to avoid wasting memory.
> > 
> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> 
> This is good enough for net-next, but for net I think we
> should figure out how to address the issue completely.
> Can we make the accounting precise? What happens to
> performance if we do?
> 

Since I'm back from holidays, I'm restarting this thread to figure out
how to address the issue completely.

I did a better analysis of the credit mechanism that we implemented in
virtio-vsock to get a clearer view and I'd share it with you:

    This issue affect only the "host->guest" path. In this case, when the
    host wants to send a packet to the guest, it uses a "free" buffer
    allocated by the guest (4KB).
    The "free" buffers available for the host are shared between all
    sockets, instead, the credit mechanism is per-socket, I think to
    avoid the starvation of others sockets.
    The guests re-fill the "free" queue when the available buffers are
    less than half.

    Each peer have these variables in the per-socket state:
       /* local vars */
       buf_alloc        /* max bytes usable by this socket
                           [exposed to the other peer] */
       fwd_cnt          /* increased when RX packet is consumed by the
                           user space [exposed to the other peer] */
       tx_cnt 	        /* increased when TX packet is sent to the other peer */

       /* remote vars  */
       peer_buf_alloc   /* peer's buf_alloc */
       peer_fwd_cnt     /* peer's fwd_cnt */

    When a peer sends a packet, it increases the 'tx_cnt'; when the
    receiver consumes the packet (copy it to the user-space buffer), it
    increases the 'fwd_cnt'.
    Note: increments are made considering the payload length and not the
    buffer length.

    The value of 'buf_alloc' and 'fwd_cnt' are sent to the other peer in
    all packet headers or with an explicit CREDIT_UPDATE packet.

    The local 'buf_alloc' value can be modified by the user space using
    setsockopt() with optname=SO_VM_SOCKETS_BUFFER_SIZE.

    Before to send a packet, the peer checks the space available:
    	credit_available = peer_buf_alloc - (tx_cnt - peer_fwd_cnt)
    and it will send up to credit_available bytes to the other peer.

Possible solutions considering Michael's advice:
1. Use the buffer length instead of the payload length when we increment
   the counters:
  - This approach will account precisely the memory used per socket.
  - This requires changes in both guest and host.
  - It is not compatible with old drivers, so a feature should be negotiated.

2. Decrease the advertised 'buf_alloc' taking count of bytes queued in
   the socket queue but not used. (e.g. 256 byte used on 4K available in
   the buffer)
  - pkt->hdr.buf_alloc = buf_alloc - bytes_not_used.
  - This should be compatible also with old drivers.

Maybe the second is less invasive, but will it be too tricky?
Any other advice or suggestions?

Thanks in advance,
Stefano
