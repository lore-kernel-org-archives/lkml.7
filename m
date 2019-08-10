Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F99C433FF
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 18:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D6AD2086A
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 18:18:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbfHJSSz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 14:18:55 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:38706 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbfHJSSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 14:18:55 -0400
Received: by mail-qk1-f195.google.com with SMTP id u190so10533114qkh.5
        for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2019 11:18:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zrZ1MFWBUD8XpJlN1HdMmxALzKrZiqQ/CZQqHhvjihk=;
        b=HhafgA1EfIzS4Ky8cRGe3B89Xr40uZJFhu1PrBNoBJagG82/2bSCslMGRiJaGVQRai
         Dj8JmYyHHDL3zxxEWs3QxnXjzuM6ch3H/Em5iJZvBPqJjD6xy6c1pEhvRE9T1M9LxOe3
         X7dU1pJfWu6V7sm49PIxw2TEYs1pH925JG3g/EQcLodPE0EQ0lDwl+bcBOTTLmiZBiZA
         lI/JGGXKhjCvNI//fQLoZwzEkaChonG4ByvBJ5jchGnRpE0O3/j1wWORtnMs5EHNpo86
         eJwuUaz7gMRjl5Du1i2lLv3EPgEro8IU60HKLMhhJo0eKj0RHA4QpU9I/hp9o4mF2Uv1
         sVRQ==
X-Gm-Message-State: APjAAAXjnvipz4AxU+z3iq89m4QSe212t3DgcQ4SFWYXl/zg5H9N5BZd
        rm/kOfLQ9N5+xW+vFxnz3sNrrQ==
X-Google-Smtp-Source: APXvYqxQg0u/NQTm7d1bARb/j41E1mdpTfaO2VyPaTxGh/hPAt/cL+vAJQTT2RzTO83w5xAmYimPfA==
X-Received: by 2002:a37:5f82:: with SMTP id t124mr22052496qkb.180.1565461134184;
        Sat, 10 Aug 2019 11:18:54 -0700 (PDT)
Received: from redhat.com (bzq-79-181-91-42.red.bezeqint.net. [79.181.91.42])
        by smtp.gmail.com with ESMTPSA id b18sm40602281qkc.112.2019.08.10.11.18.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 10 Aug 2019 11:18:53 -0700 (PDT)
Date:   Sat, 10 Aug 2019 14:18:48 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Pankaj Gupta <pagupta@redhat.com>
Cc:     amit@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
        virtualization@lists.linux-foundation.org, jasowang@redhat.com,
        linux-kernel@vger.kernel.org, xiaohli@redhat.com
Subject: Re: [PATCH v3 1/2] virtio_console: free unused buffers with port
 delete
Message-ID: <20190810141019-mutt-send-email-mst@kernel.org>
References: <20190809064847.28918-1-pagupta@redhat.com>
 <20190809064847.28918-2-pagupta@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190809064847.28918-2-pagupta@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 09, 2019 at 12:18:46PM +0530, Pankaj Gupta wrote:
> The commit a7a69ec0d8e4 ("virtio_console: free buffers after reset")
> deferred detaching of unused buffer to virtio device unplug time.
> This causes unplug/replug of single port in virtio device with an
> error "Error allocating inbufs\n". As we don't free the unused buffers
> attached with the port. Re-plug the same port tries to allocate new
> buffers in virtqueue and results in this error if queue is full.

So why not reuse the buffers that are already there in this case?
Seems quite possible.

> This patch removes the unused buffers in vq's when we unplug the port.
> This is the best we can do as we cannot call device_reset because virtio
> device is still active.
> 
> Reported-by: Xiaohui Li <xiaohli@redhat.com>
> Fixes: a7a69ec0d8e4 ("virtio_console: free buffers after reset")
> Cc: stable@vger.kernel.org
> Signed-off-by: Pankaj Gupta <pagupta@redhat.com>

This is really a revert of a7a69ec0d8e4, just tagged confusingly.

And the original is also supposed to be a bugfix.
So how will the original bug be fixed?

"this is the best we can do" is rarely the case.

I am not necessarily against the revert. But if we go that way then what
we need to do is specify the behaviour in the spec, since strict spec
compliance is exactly what the original patch was addressing.

In particular, we'd document that console has a special property that
when port is detached virtqueue is considered stopped, device must not
use any buffers, and it is legal to take buffers out of the device.



> ---
>  drivers/char/virtio_console.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
> index 7270e7b69262..e8be82f1bae9 100644
> --- a/drivers/char/virtio_console.c
> +++ b/drivers/char/virtio_console.c
> @@ -1494,15 +1494,25 @@ static void remove_port(struct kref *kref)
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
> @@ -1938,11 +1948,9 @@ static void remove_vqs(struct ports_device *portdev)
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
> 2.21.0
