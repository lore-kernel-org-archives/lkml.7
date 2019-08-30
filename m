Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42EA7C3A5A3
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 03:48:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16E352186A
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 03:48:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727967AbfH3Dsk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 23:48:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56948 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727410AbfH3Dsj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 23:48:39 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9AA7A3082A6C;
        Fri, 30 Aug 2019 03:48:39 +0000 (UTC)
Received: from [10.72.12.92] (ovpn-12-92.pek2.redhat.com [10.72.12.92])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AA6315C1D6;
        Fri, 30 Aug 2019 03:48:35 +0000 (UTC)
Subject: Re: [PATCH] virtio: Change typecasts in vring_init()
To:     Matej Genci <matej.genci@nutanix.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "mst@redhat.com" <mst@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190827152000.53920-1-matej.genci@nutanix.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <e6aa7fa1-8f41-fc55-51b2-5f0052cfb2d0@redhat.com>
Date:   Fri, 30 Aug 2019 11:48:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190827152000.53920-1-matej.genci@nutanix.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Fri, 30 Aug 2019 03:48:39 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/8/27 下午11:20, Matej Genci wrote:
> Compilers such as g++ 7.3 complain about assigning void* variable to
> a non-void* variable (like struct pointers) and pointer arithmetics
> on void*.
>
> Signed-off-by: Matej Genci <matej.genci@nutanix.com>
> ---
>  include/uapi/linux/virtio_ring.h | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/include/uapi/linux/virtio_ring.h b/include/uapi/linux/virtio_ring.h
> index 4c4e24c291a5..2c339b9e2923 100644
> --- a/include/uapi/linux/virtio_ring.h
> +++ b/include/uapi/linux/virtio_ring.h
> @@ -168,10 +168,11 @@ static inline void vring_init(struct vring *vr, unsigned int num, void *p,
>  			      unsigned long align)
>  {
>  	vr->num = num;
> -	vr->desc = p;
> -	vr->avail = p + num*sizeof(struct vring_desc);
> -	vr->used = (void *)(((uintptr_t)&vr->avail->ring[num] + sizeof(__virtio16)
> -		+ align-1) & ~(align - 1));
> +	vr->desc = (struct vring_desc *)p;
> +	vr->avail = (struct vring_avail *)((uintptr_t)p
> +		+ num*sizeof(struct vring_desc));


It's better to let the code pass checkpath.pl here.

Other looks good.

Thanks


> +	vr->used = (struct vring_used *)(((uintptr_t)&vr->avail->ring[num]
> +		+ sizeof(__virtio16) + align-1) & ~(align - 1));
>  }
>  
>  static inline unsigned vring_size(unsigned int num, unsigned long align)
