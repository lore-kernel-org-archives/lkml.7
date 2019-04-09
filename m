Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABFACC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 09:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8060A20883
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 09:01:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbfDIJBH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 05:01:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41602 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726035AbfDIJBH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 05:01:07 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B564E2D7F3;
        Tue,  9 Apr 2019 09:01:06 +0000 (UTC)
Received: from [10.72.12.67] (ovpn-12-67.pek2.redhat.com [10.72.12.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E65FA272C0;
        Tue,  9 Apr 2019 09:01:01 +0000 (UTC)
Subject: Re: [PATCH] virtio: Honour 'may_reduce_num' in vring_create_virtqueue
To:     Cornelia Huck <cohuck@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>
Cc:     Halil Pasic <pasic@linux.ibm.com>,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20190408123322.24086-1-cohuck@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <9b3d1789-33e1-3ad5-18cd-cacefec8bbb2@redhat.com>
Date:   Tue, 9 Apr 2019 17:00:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190408123322.24086-1-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Tue, 09 Apr 2019 09:01:06 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/4/8 下午8:33, Cornelia Huck wrote:
> vring_create_virtqueue() allows the caller to specify via the
> may_reduce_num parameter whether the vring code is allowed to
> allocate a smaller ring than specified.
>
> However, the split ring allocation code tries to allocate a
> smaller ring on allocation failure regardless of what the
> caller specified. This may cause trouble for e.g. virtio-pci
> in legacy mode, which does not support ring resizing. (The
> packed ring code does not resize in any case.)
>
> Let's fix this by bailing out immediately in the split ring code
> if the requested size cannot be allocated and may_reduce_num has
> not been specified.
>
> While at it, fix a typo in the usage instructions.
>
> Fixes: 2a2d1382fe9d ("virtio: Add improved queue allocation API")
> Cc: stable@vger.kernel.org # v4.6+
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>   drivers/virtio/virtio_ring.c | 2 ++
>   include/linux/virtio_ring.h  | 2 +-
>   2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 18846afb39da..5df92c308286 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -882,6 +882,8 @@ static struct virtqueue *vring_create_virtqueue_split(
>   					  GFP_KERNEL|__GFP_NOWARN|__GFP_ZERO);
>   		if (queue)
>   			break;
> +		if (!may_reduce_num)
> +			return NULL;
>   	}
>   
>   	if (!num)
> diff --git a/include/linux/virtio_ring.h b/include/linux/virtio_ring.h
> index fab02133a919..3dc70adfe5f5 100644
> --- a/include/linux/virtio_ring.h
> +++ b/include/linux/virtio_ring.h
> @@ -63,7 +63,7 @@ struct virtqueue;
>   /*
>    * Creates a virtqueue and allocates the descriptor ring.  If
>    * may_reduce_num is set, then this may allocate a smaller ring than
> - * expected.  The caller should query virtqueue_get_ring_size to learn
> + * expected.  The caller should query virtqueue_get_vring_size to learn
>    * the actual size of the ring.
>    */
>   struct virtqueue *vring_create_virtqueue(unsigned int index,


Acked-by: Jason Wang <jasowang@redhat.com>


