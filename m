Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E9EDC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 06:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BE30206DF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 06:35:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbfCKGfp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 02:35:45 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34163 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726843AbfCKGfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 02:35:41 -0400
Received: by mail-qk1-f193.google.com with SMTP id n6so2071950qkf.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2019 23:35:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ppnUNtoVofXw8guLPBJl52X8/zGgDfLf4oBnOEjgSdk=;
        b=snELPTce/fE9UkyUoq+BAFgrzpYQU9xVgChb/rGoluXm0S1WsH8OaFZ6bVXtRltlYO
         2s3sICtLnUkaI8KBUyNxnnXGH3D5yJYjUkFBNOZ+8nEsEbaUJyN+at2XM5YtuELDAyfs
         VkJvgIvAjqLbJakuNU2FQodCoe8sIUnekWn0OaPcGz7bcXC18tNHy4jX9iKRpNLuN69K
         fvihoL4HUpMNd1QmHJP6SE6niLRkSqZxmhyRvpoUUsZoIJ+eOeNDRQq0SnNKNdaZyeRj
         UOY5tpfYoagpexA8lQdRnrwmo1YVYRK2hNUUzNboAtgCdyx84oLgN5nvHPjJU+NKbeoc
         9Y6g==
X-Gm-Message-State: APjAAAX1GYk9qdxsE46Oq2wWYwN6s/Lqvr9f07lsfwDqm4a1bzK0Jkwu
        TDPkfUTqP6LxmgPnuoZPZNkX1g==
X-Google-Smtp-Source: APXvYqws2evYDM+2DD8ln9oUz3Si8+UCQJ6+63Wqy681IOzUtOOPh0cqpDNWOg9mpUik66zRa4HVNg==
X-Received: by 2002:a37:5ac1:: with SMTP id o184mr22884801qkb.216.1552286140526;
        Sun, 10 Mar 2019 23:35:40 -0700 (PDT)
Received: from redhat.com (pool-173-76-246-42.bstnma.fios.verizon.net. [173.76.246.42])
        by smtp.gmail.com with ESMTPSA id 14sm2832025qkf.23.2019.03.10.23.35.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 10 Mar 2019 23:35:39 -0700 (PDT)
Date:   Mon, 11 Mar 2019 02:35:37 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Pankaj Gupta <pagupta@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, amit@kernel.org,
        arnd@arndb.de, gregkh@linuxfoundation.org, xiaohli@redhat.com,
        Gal Hammer <ghammer@redhat.com>
Subject: Re: [PATCH] virtio_console: free unused buffers with virtio port
Message-ID: <20190311023154-mutt-send-email-mst@kernel.org>
References: <20190304130511.14450-1-pagupta@redhat.com>
 <20190304142506-mutt-send-email-mst@kernel.org>
 <444210313.9669582.1551769746169.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <444210313.9669582.1551769746169.JavaMail.zimbra@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 05, 2019 at 02:09:06AM -0500, Pankaj Gupta wrote:
> 
> Hello Michael,
> 
> Thanks for your reply.
> 
> > 
> > On Mon, Mar 04, 2019 at 06:35:11PM +0530, Pankaj Gupta wrote:
> > >   The commit a7a69ec0d8e4 ("virtio_console: free buffers after reset")
> > >   deffered detaching of unused buffer to virtio device unplug time.
> > > 
> > >   This causes unplug/replug of single port in virtio device with an
> > >   error "Error allocating inbufs\n". As we don't free the unused buffers
> > >   attached with the port. Re-plug the same port tries to allocate new
> > >   buffers in virtqueue and results in this error if queue is full.

That's the basic issue, isn't it? Why aren't we
reusing buffers that are already there?


> > > 
> > >   This patch removes the unused buffers in vq's when we unplug the port.
> > >   This is the best we can do as we cannot call device_reset because virtio
> > >   device is still active. This was the working behaviour before the change
> > >   introduced in commit b3258ff1d6.
> > > 
> > >   Reported-by: Xiaohui Li <xiaohli@redhat.com>
> > >   Fixes: b3258ff1d6 ("virtio_console: free buffers after reset")
> > >   Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> > 
> > I think if you do this you need to add support
> > in the packed ring.
> 
> o.k. I will look at the implementation details for "support
> of packed ring" for virtio_console. This will take some time.
> 
> Meanwhile "virtio_console" port hotplug/unplug is broken in upstream.
> Can we accept this patch as it fixes the upstream and together
> with parent patch(b3258ff1d6) does nice cleanups as well.
> 
> Thanks,
> Pankaj  

Sorry, no - I don't think we should fix one configuration by breaking the other.
If you want to go back, then that's a spec violation, but I guess we can
fix the spec to match.  OK, but code-wise if you call
virtqueue_detach_unused_buf without device reset then you need to teach
packed ring code to support that.



> > 
> > > ---
> > >  drivers/char/virtio_console.c | 14 +++++++++++---
> > >  1 file changed, 11 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
> > > index fbeb71953526..5fbf2ac73111 100644
> > > --- a/drivers/char/virtio_console.c
> > > +++ b/drivers/char/virtio_console.c
> > > @@ -1506,15 +1506,25 @@ static void remove_port(struct kref *kref)
> > >          kfree(port);
> > >  }
> > >  
> > > +static void remove_unused_bufs(struct virtqueue *vq)
> > > +{
> > > +        struct port_buffer *buf;
> > > +
> > > +        while ((buf = virtqueue_detach_unused_buf(vq)))
> > > +                free_buf(buf, true);
> > > +}
> > > +
> > >  static void remove_port_data(struct port *port)
> > >  {
> > >          spin_lock_irq(&port->inbuf_lock);
> > >          /* Remove unused data this port might have received. */
> > >          discard_port_data(port);
> > > +        remove_unused_bufs(port->in_vq);
> > >          spin_unlock_irq(&port->inbuf_lock);
> > >  
> > >          spin_lock_irq(&port->outvq_lock);
> > >          reclaim_consumed_buffers(port);
> > > +        remove_unused_bufs(port->out_vq);
> > >          spin_unlock_irq(&port->outvq_lock);
> > >  }
> > >  
> > > @@ -1950,11 +1960,9 @@ static void remove_vqs(struct ports_device *portdev)
> > >          struct virtqueue *vq;
> > >  
> > >          virtio_device_for_each_vq(portdev->vdev, vq) {
> > > -                struct port_buffer *buf;
> > >  
> > >                  flush_bufs(vq, true);
> > > -                while ((buf = virtqueue_detach_unused_buf(vq)))
> > > -                        free_buf(buf, true);
> > > +                remove_unused_bufs(vq);
> > >          }
> > >          portdev->vdev->config->del_vqs(portdev->vdev);
> > >          kfree(portdev->in_vqs);
> > > --
> > > 2.20.1
> > 
