Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4002C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 17:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46F20206A3
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 17:53:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbfDYRxD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 13:53:03 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:41502 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727000AbfDYRxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 13:53:00 -0400
Received: by mail-qk1-f194.google.com with SMTP id l199so268777qke.8
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 10:52:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=POtHiuM4mZBFCrB575b8Lp2QRkzNiP8wgMfXCncJhl8=;
        b=NiKu4vdxhZp9cf57eF+Ffi4sBaEmTJ6zyQIVuLv5ubKO92sJ1qEB/2Z1dCQKywccyX
         xtWrKpT/nIgMLXCtr8fo5PO1TLdlHuPnUnC+InIk4Zffd6b+zmHlZG4iU4iR4PzpGjeX
         lOW6tkbzDxGr99yaOm3z6x7vujhcDjbfe2WDH077ARRPEyqQVjeq8rBgeMFk4hmzjPzO
         h9PC71sU2MOpWz+NFf+8DWRpDdd2gM139Bp/etaDlwtlFcULz0K1u42lXW1bgVY61N1f
         zk3LKLMdC4/DJwoVLdr2Mc6sscdVF25yavpl1nY+0cMT//gFryNwwuy8AGbcXdveLUIk
         7utg==
X-Gm-Message-State: APjAAAW3n/FBB4lsukImGek3C9kinBmGoCW3Mx7jk22US4S0qk5cfGvU
        8iFSmSYZIYQAmvDAVx0/gV0/NA==
X-Google-Smtp-Source: APXvYqyjiFjDfkCTlyc80ybTyfqcSitnv+9pe0K9xO9FrrYZm5ihC07jRJU7sabfudYNZU4H6WsdQA==
X-Received: by 2002:a37:478a:: with SMTP id u132mr31794771qka.0.1556214778967;
        Thu, 25 Apr 2019 10:52:58 -0700 (PDT)
Received: from redhat.com (pool-173-76-105-71.bstnma.fios.verizon.net. [173.76.105.71])
        by smtp.gmail.com with ESMTPSA id e4sm11396339qkg.6.2019.04.25.10.52.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Apr 2019 10:52:57 -0700 (PDT)
Date:   Thu, 25 Apr 2019 13:52:55 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        ppandit@redhat.com
Subject: Re: [PATCH net] vhost_net: fix possible infinite loop
Message-ID: <20190425131021-mutt-send-email-mst@kernel.org>
References: <1556177599-56248-1-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556177599-56248-1-git-send-email-jasowang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 03:33:19AM -0400, Jason Wang wrote:
> When the rx buffer is too small for a packet, we will discard the vq
> descriptor and retry it for the next packet:
> 
> while ((sock_len = vhost_net_rx_peek_head_len(net, sock->sk,
> 					      &busyloop_intr))) {
> ...
> 	/* On overrun, truncate and discard */
> 	if (unlikely(headcount > UIO_MAXIOV)) {
> 		iov_iter_init(&msg.msg_iter, READ, vq->iov, 1, 1);
> 		err = sock->ops->recvmsg(sock, &msg,
> 					 1, MSG_DONTWAIT | MSG_TRUNC);
> 		pr_debug("Discarded rx packet: len %zd\n", sock_len);
> 		continue;
> 	}
> ...
> }
> 
> This makes it possible to trigger a infinite while..continue loop
> through the co-opreation of two VMs like:
> 
> 1) Malicious VM1 allocate 1 byte rx buffer and try to slow down the
>    vhost process as much as possible e.g using indirect descriptors or
>    other.
> 2) Malicious VM2 generate packets to VM1 as fast as possible
> 
> Fixing this by checking against weight at the end of RX and TX
> loop. This also eliminate other similar cases when:
> 
> - userspace is consuming the packets in the meanwhile
> - theoretical TOCTOU attack if guest moving avail index back and forth
>   to hit the continue after vhost find guest just add new buffers
> 
> This addresses CVE-2019-3900.
> 
> Fixes: d8316f3991d20 ("vhost: fix total length when packets are too short")

I agree this is the real issue.

> Fixes: 3a4d5c94e9593 ("vhost_net: a kernel-level virtio server")

This is just a red herring imho. We can stick this on any vhost patch :)

> Signed-off-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/vhost/net.c | 41 +++++++++++++++++++++--------------------
>  1 file changed, 21 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index df51a35..fb46e6b 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -778,8 +778,9 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
>  	int err;
>  	int sent_pkts = 0;
>  	bool sock_can_batch = (sock->sk->sk_sndbuf == INT_MAX);
> +	bool next_round = false;
>  
> -	for (;;) {
> +	do {
>  		bool busyloop_intr = false;
>  
>  		if (nvq->done_idx == VHOST_NET_BATCH)
> @@ -845,11 +846,10 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
>  		vq->heads[nvq->done_idx].id = cpu_to_vhost32(vq, head);
>  		vq->heads[nvq->done_idx].len = 0;
>  		++nvq->done_idx;
> -		if (vhost_exceeds_weight(++sent_pkts, total_len)) {
> -			vhost_poll_queue(&vq->poll);
> -			break;
> -		}
> -	}
> +	} while (!(next_round = vhost_exceeds_weight(++sent_pkts, total_len)));
> +
> +	if (next_round)
> +		vhost_poll_queue(&vq->poll);
>  
>  	vhost_tx_batch(net, nvq, sock, &msg);
>  }
> @@ -873,8 +873,9 @@ static void handle_tx_zerocopy(struct vhost_net *net, struct socket *sock)
>  	struct vhost_net_ubuf_ref *uninitialized_var(ubufs);
>  	bool zcopy_used;
>  	int sent_pkts = 0;
> +	bool next_round = false;
>  
> -	for (;;) {
> +	do {
>  		bool busyloop_intr;
>  
>  		/* Release DMAs done buffers first */
> @@ -951,11 +952,10 @@ static void handle_tx_zerocopy(struct vhost_net *net, struct socket *sock)
>  		else
>  			vhost_zerocopy_signal_used(net, vq);
>  		vhost_net_tx_packet(net);
> -		if (unlikely(vhost_exceeds_weight(++sent_pkts, total_len))) {
> -			vhost_poll_queue(&vq->poll);
> -			break;
> -		}
> -	}
> +	} while (!(next_round = vhost_exceeds_weight(++sent_pkts, total_len)));
> +
> +	if (next_round)
> +		vhost_poll_queue(&vq->poll);
>  }
>  
>  /* Expects to be always run from workqueue - which acts as
> @@ -1134,6 +1134,7 @@ static void handle_rx(struct vhost_net *net)
>  	struct iov_iter fixup;
>  	__virtio16 num_buffers;
>  	int recv_pkts = 0;
> +	bool next_round = false;
>  
>  	mutex_lock_nested(&vq->mutex, VHOST_NET_VQ_RX);
>  	sock = vq->private_data;
> @@ -1153,8 +1154,11 @@ static void handle_rx(struct vhost_net *net)
>  		vq->log : NULL;
>  	mergeable = vhost_has_feature(vq, VIRTIO_NET_F_MRG_RXBUF);
>  
> -	while ((sock_len = vhost_net_rx_peek_head_len(net, sock->sk,
> -						      &busyloop_intr))) {
> +	do {
> +		sock_len = vhost_net_rx_peek_head_len(net, sock->sk,
> +						      &busyloop_intr);
> +		if (!sock_len)
> +			break;
>  		sock_len += sock_hlen;
>  		vhost_len = sock_len + vhost_hlen;
>  		headcount = get_rx_bufs(vq, vq->heads + nvq->done_idx,
> @@ -1239,12 +1243,9 @@ static void handle_rx(struct vhost_net *net)
>  			vhost_log_write(vq, vq_log, log, vhost_len,
>  					vq->iov, in);
>  		total_len += vhost_len;
> -		if (unlikely(vhost_exceeds_weight(++recv_pkts, total_len))) {
> -			vhost_poll_queue(&vq->poll);
> -			goto out;
> -		}
> -	}
> -	if (unlikely(busyloop_intr))
> +	} while (!(next_round = vhost_exceeds_weight(++recv_pkts, total_len)));
> +
> +	if (unlikely(busyloop_intr || next_round))
>  		vhost_poll_queue(&vq->poll);
>  	else
>  		vhost_net_enable_vq(net, vq);


I'm afraid with this addition the code is too much like spagetty. What
does next_round mean?  Just that we are breaking out of loop?  That is
what goto is for...  Either let's have for(;;) with goto/break to get
outside or a while loop with a condition.  Both is just unreadable.

All these checks in 3 places are exactly the same on all paths and they
are slow path. Why don't we put this in a function? E.g. like the below.
Warning: completely untested.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

---

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index df51a35cf537..a0f89a504cd9 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -761,6 +761,23 @@ static int vhost_net_build_xdp(struct vhost_net_virtqueue *nvq,
 	return 0;
 }
 
+/* Returns true if caller needs to go back and re-read the ring. */
+static bool empty_ring(struct vhost_net *net, struct vhost_virtqueue *vq,
+		       int pkts, size_t total_len, bool busyloop_intr)
+{
+	if (unlikely(busyloop_intr)) {
+		vhost_poll_queue(&vq->poll);
+	} else if (unlikely(vhost_enable_notify(&net->dev, vq))) {
+		/* They have slipped one in meanwhile: check again. */
+		vhost_disable_notify(&net->dev, vq);
+		if (!vhost_exceeds_weight(pkts, total_len))
+			return true;
+		vhost_poll_queue(&vq->poll);
+	}
+	/* Nothing new?  Wait for eventfd to tell us they refilled. */
+	return false;
+}
+
 static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
 {
 	struct vhost_net_virtqueue *nvq = &net->vqs[VHOST_NET_VQ_TX];
@@ -790,15 +807,10 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
 		/* On error, stop handling until the next kick. */
 		if (unlikely(head < 0))
 			break;
-		/* Nothing new?  Wait for eventfd to tell us they refilled. */
 		if (head == vq->num) {
-			if (unlikely(busyloop_intr)) {
-				vhost_poll_queue(&vq->poll);
-			} else if (unlikely(vhost_enable_notify(&net->dev,
-								vq))) {
-				vhost_disable_notify(&net->dev, vq);
+			if (unlikely(empty_ring(net, vq, ++sent_pkts,
+						total_len, busyloop_intr)))
 				continue;
-			}
 			break;
 		}
 
@@ -886,14 +898,10 @@ static void handle_tx_zerocopy(struct vhost_net *net, struct socket *sock)
 		/* On error, stop handling until the next kick. */
 		if (unlikely(head < 0))
 			break;
-		/* Nothing new?  Wait for eventfd to tell us they refilled. */
 		if (head == vq->num) {
-			if (unlikely(busyloop_intr)) {
-				vhost_poll_queue(&vq->poll);
-			} else if (unlikely(vhost_enable_notify(&net->dev, vq))) {
-				vhost_disable_notify(&net->dev, vq);
+			if (unlikely(empty_ring(net, vq, ++sent_pkts,
+						total_len, busyloop_intr)))
 				continue;
-			}
 			break;
 		}
 
@@ -1163,18 +1171,10 @@ static void handle_rx(struct vhost_net *net)
 		/* On error, stop handling until the next kick. */
 		if (unlikely(headcount < 0))
 			goto out;
-		/* OK, now we need to know about added descriptors. */
 		if (!headcount) {
-			if (unlikely(busyloop_intr)) {
-				vhost_poll_queue(&vq->poll);
-			} else if (unlikely(vhost_enable_notify(&net->dev, vq))) {
-				/* They have slipped one in as we were
-				 * doing that: check again. */
-				vhost_disable_notify(&net->dev, vq);
-				continue;
-			}
-			/* Nothing new?  Wait for eventfd to tell us
-			 * they refilled. */
+			if (unlikely(empty_ring(net, vq, ++recv_pkts,
+						total_len, busyloop_intr)))
+					continue;
 			goto out;
 		}
 		busyloop_intr = false;

> -- 
> 1.8.3.1
