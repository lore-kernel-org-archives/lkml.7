Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4AFFC7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 15:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A58942173E
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 15:00:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbfGQPAA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 11:00:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43926 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725936AbfGQPAA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 11:00:00 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D4111308FEC0;
        Wed, 17 Jul 2019 14:59:59 +0000 (UTC)
Received: from redhat.com (ovpn-125-71.rdu2.redhat.com [10.10.125.71])
        by smtp.corp.redhat.com (Postfix) with SMTP id 7012E608A6;
        Wed, 17 Jul 2019 14:59:53 +0000 (UTC)
Date:   Wed, 17 Jul 2019 10:59:52 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        virtualization@lists.linux-foundation.org,
        Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org
Subject: Re: [PATCH v4 5/5] vsock/virtio: change the maximum packet size
 allowed
Message-ID: <20190717105703-mutt-send-email-mst@kernel.org>
References: <20190717113030.163499-1-sgarzare@redhat.com>
 <20190717113030.163499-6-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190717113030.163499-6-sgarzare@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Wed, 17 Jul 2019 14:59:59 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2019 at 01:30:30PM +0200, Stefano Garzarella wrote:
> Since now we are able to split packets, we can avoid limiting
> their sizes to VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE.
> Instead, we can use VIRTIO_VSOCK_MAX_PKT_BUF_SIZE as the max
> packet size.
> 
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>


OK so this is kind of like GSO where we are passing
64K packets to the vsock and then split at the
low level.


> ---
>  net/vmw_vsock/virtio_transport_common.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index 56fab3f03d0e..94cc0fa3e848 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -181,8 +181,8 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
>  	vvs = vsk->trans;
>  
>  	/* we can send less than pkt_len bytes */
> -	if (pkt_len > VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE)
> -		pkt_len = VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE;
> +	if (pkt_len > VIRTIO_VSOCK_MAX_PKT_BUF_SIZE)
> +		pkt_len = VIRTIO_VSOCK_MAX_PKT_BUF_SIZE;
>  
>  	/* virtio_transport_get_credit might return less than pkt_len credit */
>  	pkt_len = virtio_transport_get_credit(vvs, pkt_len);
> -- 
> 2.20.1
