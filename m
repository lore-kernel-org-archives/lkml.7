Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B940C5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 13:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E0B3214D8
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 13:56:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731568AbfKFN4j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 08:56:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58438 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726926AbfKFN4j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 08:56:39 -0500
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A1D3A37F41
        for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2019 13:56:38 +0000 (UTC)
Received: by mail-qt1-f199.google.com with SMTP id h39so26202293qth.13
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 05:56:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SCXJzDQ3S1J55XHzsdL+WUuToZbSMLgz9CT94p+WM4w=;
        b=UepZW4HPt7g4t9n24uZvQ0k11RQog+DHVfw9XaCpAy1RrrWXfBsfTP4PNQEXFVH8Xd
         nUgOK45e6o0llKR2xzVkCKwDfn9nOMb6XypmPlF3YDfTcdOcgjoWnavZlEE5xsP/8V4r
         L/nDFT9P9eSzfViDYCnsQYRjs/IwW1pzzn/Qp0OdNQKva65z6+88jCxFLjJ8grXLxHpo
         RFKaYZUVfn8XFiomCbe9jkUPNJeeiSvoJngwkUcvulc2CTijjG/CKiHmqfFHPkmNzl9M
         /h4cnaVrUYkP0wamSMH/tg/OJKrD0Vru/fJippkc0N2gQn8tF3JcSvYk/PtzqkD3Wq6A
         MnFg==
X-Gm-Message-State: APjAAAXfCXDRq8Ozpz0q+3z8JaYCNyO4v33Dym6KeCHywMDbnbGvNd63
        tz34XuPCW0ZBa81qkdTLPvRnqaroVdJQIgjiug2i5GmzqeuyE2LDDZCM9TWnu8/wjIxV7y+D7Fe
        IapCpgi2qX22m0e/Y62qr+1fF
X-Received: by 2002:a0c:804c:: with SMTP id 70mr2339446qva.81.1573048597867;
        Wed, 06 Nov 2019 05:56:37 -0800 (PST)
X-Google-Smtp-Source: APXvYqwmsdeYDDJG6NETb2Q5jlxvfBzx4zCSOo1XZ7jQ39L1/ECKWtQ9HTRT3m5f069tRgGpgyf7xA==
X-Received: by 2002:a0c:804c:: with SMTP id 70mr2339424qva.81.1573048597552;
        Wed, 06 Nov 2019 05:56:37 -0800 (PST)
Received: from redhat.com (bzq-79-178-12-128.red.bezeqint.net. [79.178.12.128])
        by smtp.gmail.com with ESMTPSA id h44sm11726023qtc.1.2019.11.06.05.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 05:56:36 -0800 (PST)
Date:   Wed, 6 Nov 2019 08:56:31 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Laurent Vivier <lvivier@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Amit Shah <amit@kernel.org>,
        virtualization@lists.linux-foundation.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] virtio_console: allocate inbufs in add_port() only if it
 is needed
Message-ID: <20191106085548-mutt-send-email-mst@kernel.org>
References: <20191018164718.15999-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018164718.15999-1-lvivier@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 06:47:18PM +0200, Laurent Vivier wrote:
> When we hot unplug a virtserialport and then try to hot plug again,
> it fails:
> 
> (qemu) chardev-add socket,id=serial0,path=/tmp/serial0,server,nowait
> (qemu) device_add virtserialport,bus=virtio-serial0.0,nr=2,\
>                   chardev=serial0,id=serial0,name=serial0
> (qemu) device_del serial0
> (qemu) device_add virtserialport,bus=virtio-serial0.0,nr=2,\
>                   chardev=serial0,id=serial0,name=serial0
> kernel error:
>   virtio-ports vport2p2: Error allocating inbufs
> qemu error:
>   virtio-serial-bus: Guest failure in adding port 2 for device \
>                      virtio-serial0.0
> 
> This happens because buffers for the in_vq are allocated when the port is
> added but are not released when the port is unplugged.
> 
> They are only released when virtconsole is removed (see a7a69ec0d8e4)
> 
> To avoid the problem and to be symmetric, we could allocate all the buffers
> in init_vqs() as they are released in remove_vqs(), but it sounds like
> a waste of memory.
> 
> Rather than that, this patch changes add_port() logic to only allocate the
> buffers if the in_vq has available free slots.
> 
> Fixes: a7a69ec0d8e4 ("virtio_console: free buffers after reset")
> Cc: mst@redhat.com
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>  drivers/char/virtio_console.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
> index 7270e7b69262..77105166fe01 100644
> --- a/drivers/char/virtio_console.c
> +++ b/drivers/char/virtio_console.c
> @@ -1421,12 +1421,17 @@ static int add_port(struct ports_device *portdev, u32 id)
>  	spin_lock_init(&port->outvq_lock);
>  	init_waitqueue_head(&port->waitqueue);
>  
> -	/* Fill the in_vq with buffers so the host can send us data. */
> -	nr_added_bufs = fill_queue(port->in_vq, &port->inbuf_lock);
> -	if (!nr_added_bufs) {
> -		dev_err(port->dev, "Error allocating inbufs\n");
> -		err = -ENOMEM;
> -		goto free_device;
> +	/* if the in_vq has not already been filled (the port has already been
> +	 * used and unplugged), fill the in_vq with buffers so the host can
> +	 * send us data.
> +	 */
> +	if (port->in_vq->num_free != 0) {
> +		nr_added_bufs = fill_queue(port->in_vq, &port->inbuf_lock);
> +		if (!nr_added_bufs) {
> +			dev_err(port->dev, "Error allocating inbufs\n");
> +			err = -ENOMEM;
> +			goto free_device;
> +		}
>  	}
>  
>  	if (is_rproc_serial(port->portdev->vdev))

Well fill_queue will just add slots as long as it can.
So on a full queue it does nothing. How does this patch help?

> -- 
> 2.21.0
