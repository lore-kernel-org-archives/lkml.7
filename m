Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D8E1C06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 18:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 868E22184B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 18:23:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfGBSXz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 14:23:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48182 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725851AbfGBSXz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 14:23:55 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7343058E5B;
        Tue,  2 Jul 2019 18:23:55 +0000 (UTC)
Received: from redhat.com (ovpn-124-209.rdu2.redhat.com [10.10.124.209])
        by smtp.corp.redhat.com (Postfix) with SMTP id C944F5D968;
        Tue,  2 Jul 2019 18:23:53 +0000 (UTC)
Date:   Tue, 2 Jul 2019 14:23:49 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Ihor Matushchak <ihor.matushchak@foobox.net>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, iivanov.xz@gmail.com
Subject: Re: [PATCH v2] virtio-mmio: add error check for platform_get_irq
Message-ID: <20190702142329-mutt-send-email-mst@kernel.org>
References: <156207429000.5051.5975712347598980745@silver>
 <20190702144818.32648-1-ihor.matushchak@foobox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190702144818.32648-1-ihor.matushchak@foobox.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Tue, 02 Jul 2019 18:23:55 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 02, 2019 at 05:48:18PM +0300, Ihor Matushchak wrote:
> in vm_find_vqs() irq has a wrong type
> so, in case of no IRQ resource defined,
> wrong parameter will be passed to request_irq()
> 
> Signed-off-by: Ihor Matushchak <ihor.matushchak@foobox.net>

Thanks!
pls don't make v2 a response to v1 in the future though.

> ---
> Changes in v2:
> Don't overwrite error code value.
> 
>  drivers/virtio/virtio_mmio.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> index f363fbeb5ab0..e09edb5c5e06 100644
> --- a/drivers/virtio/virtio_mmio.c
> +++ b/drivers/virtio/virtio_mmio.c
> @@ -463,9 +463,14 @@ static int vm_find_vqs(struct virtio_device *vdev, unsigned nvqs,
>  		       struct irq_affinity *desc)
>  {
>  	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
> -	unsigned int irq = platform_get_irq(vm_dev->pdev, 0);
> +	int irq = platform_get_irq(vm_dev->pdev, 0);
>  	int i, err, queue_idx = 0;
>  
> +	if (irq < 0) {
> +		dev_err(&vdev->dev, "Cannot get IRQ resource\n");
> +		return irq;
> +	}
> +
>  	err = request_irq(irq, vm_interrupt, IRQF_SHARED,
>  			dev_name(&vdev->dev), vm_dev);
>  	if (err)
> -- 
> 2.17.1
