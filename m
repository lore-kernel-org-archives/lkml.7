Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B4E7C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 04:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E843D2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 04:47:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbfHLEq7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 00:46:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50244 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725648AbfHLEq7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 00:46:59 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0188CC059B6F;
        Mon, 12 Aug 2019 04:46:59 +0000 (UTC)
Received: from [10.72.12.51] (ovpn-12-51.pek2.redhat.com [10.72.12.51])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 57E3F5D6D0;
        Mon, 12 Aug 2019 04:46:54 +0000 (UTC)
Subject: Re: [PATCH v3 2/2] virtio: decrement avail idx with buffer detach for
 packed ring
To:     Pankaj Gupta <pagupta@redhat.com>, amit@kernel.org, mst@redhat.com
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, xiaohli@redhat.com
References: <20190809064847.28918-1-pagupta@redhat.com>
 <20190809064847.28918-3-pagupta@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <b1ab613d-55a4-fdb4-96b1-03bedbcc740b@redhat.com>
Date:   Mon, 12 Aug 2019 12:46:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190809064847.28918-3-pagupta@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Mon, 12 Aug 2019 04:46:59 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/8/9 下午2:48, Pankaj Gupta wrote:
> This patch decrements 'next_avail_idx' count when detaching a buffer
> from vq for packed ring code. Split ring code already does this in
> virtqueue_detach_unused_buf_split function. This updates the
> 'next_avail_idx' to the previous correct index after an unused buffer
> is detatched from the vq.
>
> Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> ---
>   drivers/virtio/virtio_ring.c | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index c8be1c4f5b55..7c69181113e2 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -1537,6 +1537,12 @@ static void *virtqueue_detach_unused_buf_packed(struct virtqueue *_vq)
>   		/* detach_buf clears data, so grab it now. */
>   		buf = vq->packed.desc_state[i].data;
>   		detach_buf_packed(vq, i, NULL);
> +		vq->packed.next_avail_idx--;
> +		if (vq->packed.next_avail_idx < 0) {
> +			vq->packed.next_avail_idx = vq->packed.vring.num - 1;
> +			vq->packed.avail_wrap_counter ^= 1;
> +		}
> +
>   		END_USE(vq);
>   		return buf;
>   	}


Acked-by: Jason Wang <jasowang@redhat.com>


