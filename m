Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7837CC432C1
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 03:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53C1420665
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 03:49:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633833AbfIYDta (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 23:49:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49084 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2633617AbfIYDt3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 23:49:29 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9C3E718C891A;
        Wed, 25 Sep 2019 03:49:25 +0000 (UTC)
Received: from [10.72.12.148] (ovpn-12-148.pek2.redhat.com [10.72.12.148])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 559C2600C8;
        Wed, 25 Sep 2019 03:49:19 +0000 (UTC)
Subject: Re: [PATCH] virtio_mmio: remove redundant dev_err message
To:     Ding Xiang <dingxiang@cmss.chinamobile.com>, mst@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <1569309666-1437-1-git-send-email-dingxiang@cmss.chinamobile.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <ccce7b48-d8a8-bbf8-7192-cefa77f51993@redhat.com>
Date:   Wed, 25 Sep 2019 11:49:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1569309666-1437-1-git-send-email-dingxiang@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.70]); Wed, 25 Sep 2019 03:49:29 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/9/24 下午3:21, Ding Xiang wrote:
> platform_get_irq already contains error message,


Is this message contained in all possible error path? If not, it's 
probably better to keep it as is.

Thanks


> so remove
> the redundant dev_err message
>
> Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
> ---
>   drivers/virtio/virtio_mmio.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> index e09edb5..c4b9f25 100644
> --- a/drivers/virtio/virtio_mmio.c
> +++ b/drivers/virtio/virtio_mmio.c
> @@ -466,10 +466,8 @@ static int vm_find_vqs(struct virtio_device *vdev, unsigned nvqs,
>   	int irq = platform_get_irq(vm_dev->pdev, 0);
>   	int i, err, queue_idx = 0;
>   
> -	if (irq < 0) {
> -		dev_err(&vdev->dev, "Cannot get IRQ resource\n");
> +	if (irq < 0)
>   		return irq;
> -	}
>   
>   	err = request_irq(irq, vm_interrupt, IRQF_SHARED,
>   			dev_name(&vdev->dev), vm_dev);
