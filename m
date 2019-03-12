Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34FD1C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 08:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08726214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 08:01:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbfCLIBL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 04:01:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47250 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726842AbfCLIBL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 04:01:11 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E6B9A3082A32;
        Tue, 12 Mar 2019 08:01:10 +0000 (UTC)
Received: from [10.72.12.17] (ovpn-12-17.pek2.redhat.com [10.72.12.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2715D66062;
        Tue, 12 Mar 2019 08:01:06 +0000 (UTC)
Subject: Re: [PATCH] virtio_ring: Fix potential mem leak in
 virtqueue_add_indirect_packed
To:     Yue Haibing <yuehaibing@huawei.com>, mst@redhat.com
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
References: <20190312070653.16392-1-yuehaibing@huawei.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <5b1d0fe0-974e-fdb1-7295-87a8b77d191f@redhat.com>
Date:   Tue, 12 Mar 2019 16:01:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190312070653.16392-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Tue, 12 Mar 2019 08:01:11 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/3/12 下午3:06, Yue Haibing wrote:
> From: YueHaibing <yuehaibing@huawei.com>
>
> 'desc' should be freed before leaving from err handing path.
>
> Fixes: 1ce9e6055fa0 ("virtio_ring: introduce packed ring support")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>   drivers/virtio/virtio_ring.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index a0b07c3..9d95d9c 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -991,6 +991,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
>   
>   	if (unlikely(vq->vq.num_free < 1)) {
>   		pr_debug("Can't add buf len 1 - avail = 0\n");
> +		kfree(desc);
>   		END_USE(vq);
>   		return -ENOSPC;
>   	}


Or you can move the check before the allocation.

Acked-by: Jason Wang <jasowang@redhat.com>

Please cc stable next time.

Thanks

