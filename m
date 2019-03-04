Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB1AC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 19:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77F1920823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 19:25:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbfCDTZg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 14:25:36 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34949 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbfCDTZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 14:25:36 -0500
Received: by mail-qt1-f196.google.com with SMTP id p48so6399863qtk.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 11:25:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/BHG/l02NOp5gRH3E901PBzc7ejBSPCwjTpMFSK5pw8=;
        b=ucmo+aH6Pemh8Tt68fJxS974JyCwjZq48qjkNl+PUnP5rc7yowhHEwoTZhrYqjoiIz
         oKZk2kdQcTHeEnxr8cohtDmi3CZY/Uhju6Gvch1xCEUkD9zqFyL+uz0VhtkWRDVlSjEr
         svRNCvCN0Mza9YMVmoEu3X9En+Syk++zMP1IOTNR0JuhyjPy6ljVNtlCudJEZ5vP0Bg4
         Tp1SantrG8uKZ/KWq8aCVH5I8Ml83k7I6sQGnqe2FoTdgAWp1JKUlMVZDeeM1AkduIQC
         z22pXAAqwQ1Uu+68oYgRKvPU0w1e4ZwMvl3p/IxRGb1N1mfEb5/e+Rthb7610MmvKOMk
         QXeA==
X-Gm-Message-State: APjAAAVOFsRUbebFp+L7MtwTMicf72T2/8LyyYEwcqJk9IkvCh1iMXRf
        LDppNwC2lbbc/uXgaWOjTdlx53ESH2Aavw==
X-Google-Smtp-Source: APXvYqyeRgTTLAZL2qqMl9aCUy46+9xmwkOCW72gbUcSlkrQRP+oC3uXyV4A7WWKRJdc2fh3vdA3ng==
X-Received: by 2002:ac8:21c9:: with SMTP id 9mr15919570qtz.78.1551727534943;
        Mon, 04 Mar 2019 11:25:34 -0800 (PST)
Received: from redhat.com (c-73-238-82-198.hsd1.ma.comcast.net. [73.238.82.198])
        by smtp.gmail.com with ESMTPSA id p15sm4676553qta.81.2019.03.04.11.25.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Mar 2019 11:25:34 -0800 (PST)
Date:   Mon, 4 Mar 2019 14:25:31 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Pankaj Gupta <pagupta@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, amit@kernel.org,
        arnd@arndb.de, gregkh@linuxfoundation.org, xiaohli@redhat.com
Subject: Re: [PATCH] virtio_console: free unused buffers with virtio port
Message-ID: <20190304142506-mutt-send-email-mst@kernel.org>
References: <20190304130511.14450-1-pagupta@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190304130511.14450-1-pagupta@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2019 at 06:35:11PM +0530, Pankaj Gupta wrote:
>   The commit a7a69ec0d8e4 ("virtio_console: free buffers after reset")
>   deffered detaching of unused buffer to virtio device unplug time. 
> 
>   This causes unplug/replug of single port in virtio device with an 
>   error "Error allocating inbufs\n". As we don't free the unused buffers 
>   attached with the port. Re-plug the same port tries to allocate new
>   buffers in virtqueue and results in this error if queue is full. 
> 
>   This patch removes the unused buffers in vq's when we unplug the port.
>   This is the best we can do as we cannot call device_reset because virtio 
>   device is still active. This was the working behaviour before the change 
>   introduced in commit b3258ff1d6.
> 
>   Reported-by: Xiaohui Li <xiaohli@redhat.com>
>   Fixes: b3258ff1d6 ("virtio_console: free buffers after reset")
>   Signed-off-by: Pankaj Gupta <pagupta@redhat.com>

I think if you do this you need to add support
in the packed ring.

> ---
>  drivers/char/virtio_console.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
> index fbeb71953526..5fbf2ac73111 100644
> --- a/drivers/char/virtio_console.c
> +++ b/drivers/char/virtio_console.c
> @@ -1506,15 +1506,25 @@ static void remove_port(struct kref *kref)
>  	kfree(port);
>  }
>  
> +static void remove_unused_bufs(struct virtqueue *vq)
> +{
> +	struct port_buffer *buf;
> +
> +	while ((buf = virtqueue_detach_unused_buf(vq)))
> +		free_buf(buf, true);
> +}
> +
>  static void remove_port_data(struct port *port)
>  {
>  	spin_lock_irq(&port->inbuf_lock);
>  	/* Remove unused data this port might have received. */
>  	discard_port_data(port);
> +	remove_unused_bufs(port->in_vq);
>  	spin_unlock_irq(&port->inbuf_lock);
>  
>  	spin_lock_irq(&port->outvq_lock);
>  	reclaim_consumed_buffers(port);
> +	remove_unused_bufs(port->out_vq);
>  	spin_unlock_irq(&port->outvq_lock);
>  }
>  
> @@ -1950,11 +1960,9 @@ static void remove_vqs(struct ports_device *portdev)
>  	struct virtqueue *vq;
>  
>  	virtio_device_for_each_vq(portdev->vdev, vq) {
> -		struct port_buffer *buf;
>  
>  		flush_bufs(vq, true);
> -		while ((buf = virtqueue_detach_unused_buf(vq)))
> -			free_buf(buf, true);
> +		remove_unused_bufs(vq);
>  	}
>  	portdev->vdev->config->del_vqs(portdev->vdev);
>  	kfree(portdev->in_vqs);
> -- 
> 2.20.1
