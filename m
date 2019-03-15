Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC3B7C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 10:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1F9821872
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 10:33:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728871AbfCOKdl convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 06:33:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55488 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727201AbfCOKdk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 06:33:40 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 69CE440F4F;
        Fri, 15 Mar 2019 10:33:40 +0000 (UTC)
Received: from gondolin (dhcp-192-222.str.redhat.com [10.33.192.222])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 723215D6A6;
        Fri, 15 Mar 2019 10:33:32 +0000 (UTC)
Date:   Fri, 15 Mar 2019 11:33:30 +0100
From:   Cornelia Huck <cohuck@redhat.com>
To:     Pierre Morel <pmorel@linux.ibm.com>
Cc:     borntraeger@de.ibm.com, alex.williamson@redhat.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com,
        pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
Subject: Re: [PATCH v5 2/7] s390: ap: new vfio_ap_queue structure
Message-ID: <20190315113330.5ef0eeef.cohuck@redhat.com>
In-Reply-To: <1552493104-30510-3-git-send-email-pmorel@linux.ibm.com>
References: <1552493104-30510-1-git-send-email-pmorel@linux.ibm.com>
        <1552493104-30510-3-git-send-email-pmorel@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Fri, 15 Mar 2019 10:33:40 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Mar 2019 17:04:59 +0100
Pierre Morel <pmorel@linux.ibm.com> wrote:

> diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
> index e9824c3..df6f21a 100644
> --- a/drivers/s390/crypto/vfio_ap_drv.c
> +++ b/drivers/s390/crypto/vfio_ap_drv.c
> @@ -40,14 +40,42 @@ static struct ap_device_id ap_queue_ids[] = {
>  
>  MODULE_DEVICE_TABLE(vfio_ap, ap_queue_ids);
>  
> +/**
> + * vfio_ap_queue_dev_probe:
> + *
> + * Allocate a vfio_ap_queue structure and associate it
> + * with the device as driver_data.
> + */
>  static int vfio_ap_queue_dev_probe(struct ap_device *apdev)
>  {
> +	struct vfio_ap_queue *q;
> +
> +	q = kzalloc(sizeof(*q), GFP_KERNEL);
> +	if (!q)
> +		return -ENOMEM;
> +	dev_set_drvdata(&apdev->device, q);
> +	q->apqn = to_ap_queue(&apdev->device)->qid;
> +	INIT_LIST_HEAD(&q->list);
> +	mutex_lock(&matrix_dev->lock);
> +	list_add(&q->list, &matrix_dev->free_list);
> +	mutex_unlock(&matrix_dev->lock);

From what I can see, dealing with the free_list is supposed to be
protected by the matrix_dev mutex, and at a glance, it indeed seems to
be held every time you interact with the list. I think it would be good
to document that with a comment.

(I have not reviewed this deeply, and I won't be able to look at this
more until April, sorry.)


>  	return 0;
>  }
