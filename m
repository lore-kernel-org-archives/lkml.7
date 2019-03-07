Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 724A7C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 03:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EA0120663
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 03:00:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbfCGDAb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 22:00:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36356 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726716AbfCGDAb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 22:00:31 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0E3DE30821B4;
        Thu,  7 Mar 2019 03:00:31 +0000 (UTC)
Received: from [10.72.12.83] (ovpn-12-83.pek2.redhat.com [10.72.12.83])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 791DA1001DD9;
        Thu,  7 Mar 2019 03:00:21 +0000 (UTC)
Subject: Re: [PATCH] vhost: silence an unused-variable warning
To:     Arnd Bergmann <arnd@arndb.de>,
        "Michael S. Tsirkin" <mst@redhat.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Stefan Hajnoczi <stefanha@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190306110602.2529137-1-arnd@arndb.de>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <6b55ea04-72d7-6130-e29e-977c4afad0b5@redhat.com>
Date:   Thu, 7 Mar 2019 11:00:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190306110602.2529137-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Thu, 07 Mar 2019 03:00:31 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/3/6 下午7:05, Arnd Bergmann wrote:
> On some architectures, the MMU can be disabled, leading to access_ok()
> becoming an empty macro that does not evaluate its size argument,
> which in turn produces an unused-variable warning:
>
> drivers/vhost/vhost.c:1191:9: error: unused variable 's' [-Werror,-Wunused-variable]
>          size_t s = vhost_has_feature(vq, VIRTIO_RING_F_EVENT_IDX) ? 2 : 0;
>
> Mark the variable as __maybe_unused to shut up that warning.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   drivers/vhost/vhost.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index a2e5dc7716e2..5ace833de746 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -1188,7 +1188,7 @@ static bool vq_access_ok(struct vhost_virtqueue *vq, unsigned int num,
>   			 struct vring_used __user *used)
>   
>   {
> -	size_t s = vhost_has_feature(vq, VIRTIO_RING_F_EVENT_IDX) ? 2 : 0;
> +	size_t s __maybe_unused = vhost_has_feature(vq, VIRTIO_RING_F_EVENT_IDX) ? 2 : 0;
>   
>   	return access_ok(desc, num * sizeof *desc) &&
>   	       access_ok(avail,


Acked-by: Jason Wang <jasowang@redhat.com>


