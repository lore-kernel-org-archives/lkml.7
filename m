Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C06AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 06:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D11A2075C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 06:36:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbfCKGgV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 02:36:21 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37689 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbfCKGgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 02:36:21 -0400
Received: by mail-qt1-f195.google.com with SMTP id z17so3865526qtn.4
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2019 23:36:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9RU6ZZ5kyfV6EYVQN2R4f4YV6jUVL/0X+yaV0FhICBQ=;
        b=kHiQeQhcyPRa7MMmB6K2mx4bI1GWMiLx3SJUgTZgn70I/2+jLK6uRKBZcDjepW7NRN
         H8vqTWwcBJCDWcu4FUkiEHi0YBH4tg/CuPf/pCe+pWVRcY7aZOcIb2UoWJjgKbAYp+3Z
         EktzCcEfon5zypYrssQvVldADlH5cgndUVcxW9FJjJJuIaQhbwQCkf5t2GceYlJCvpXT
         gHC/ROKLNPOvAqJOn41RIzyVHiHqG/EzZLZAWHcdLfapokzISAv4e9ey90OzL39829bJ
         +yFfTZH59TKWTUNgVjeI91HXh2y+cVWwu5X94WuJhnUzX1VksXtnbeQFv0APRMejHNmQ
         4S7g==
X-Gm-Message-State: APjAAAVetVHj5yH14FYbkQ6q+g2xTo1VFal9Vnzso7kbgGdfrWr8PXnY
        ETJvMxehwmzgn/WDazv4GQ89+A==
X-Google-Smtp-Source: APXvYqzRaOyiAi37EekRqeioEk7zk1rkr7rx1VTC/G2sohFXVG+/NILIX6fE3MP3KcWwRhQwoCtYGA==
X-Received: by 2002:a0c:9e65:: with SMTP id z37mr24203604qve.152.1552286180409;
        Sun, 10 Mar 2019 23:36:20 -0700 (PDT)
Received: from redhat.com (pool-173-76-246-42.bstnma.fios.verizon.net. [173.76.246.42])
        by smtp.gmail.com with ESMTPSA id 46sm3294124qto.87.2019.03.10.23.36.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 10 Mar 2019 23:36:19 -0700 (PDT)
Date:   Mon, 11 Mar 2019 02:36:17 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Pankaj Gupta <pagupta@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, amit@kernel.org,
        arnd@arndb.de, gregkh@linuxfoundation.org, xiaohli@redhat.com,
        Gal Hammer <ghammer@redhat.com>
Subject: Re: [PATCH] virtio_console: free unused buffers with virtio port
Message-ID: <20190311023544-mutt-send-email-mst@kernel.org>
References: <20190304130511.14450-1-pagupta@redhat.com>
 <1061079510.11168464.1552283891949.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1061079510.11168464.1552283891949.JavaMail.zimbra@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 01:58:11AM -0400, Pankaj Gupta wrote:
> 
> > 
> > The commit a7a69ec0d8e4 ("virtio_console: free buffers after reset")
> >   deffered detaching of unused buffer to virtio device unplug time.
> > 
> >   This causes unplug/replug of single port in virtio device with an
> >   error "Error allocating inbufs\n". As we don't free the unused buffers
> >   attached with the port. Re-plug the same port tries to allocate new
> >   buffers in virtqueue and results in this error if queue is full.
> > 
> >   This patch removes the unused buffers in vq's when we unplug the port.
> >   This is the best we can do as we cannot call device_reset because virtio
> >   device is still active. This was the working behaviour before the change
> >   introduced in commit b3258ff1d6.
> 
> ping.
> 
> This patch fixes a regression in upstream kernel, virtio_console driver.
> Can we please have this merged.
> 
> Thanks,
> Pankaj

Sorry, no, I don't think that's a full fix.

> > 
> >   Reported-by: Xiaohui Li <xiaohli@redhat.com>
> >   Fixes: b3258ff1d6 ("virtio_console: free buffers after reset")
> >   Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> > ---
> >  drivers/char/virtio_console.c | 14 +++++++++++---
> >  1 file changed, 11 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
> > index fbeb71953526..5fbf2ac73111 100644
> > --- a/drivers/char/virtio_console.c
> > +++ b/drivers/char/virtio_console.c
> > @@ -1506,15 +1506,25 @@ static void remove_port(struct kref *kref)
> >  	kfree(port);
> >  }
> >  
> > +static void remove_unused_bufs(struct virtqueue *vq)
> > +{
> > +	struct port_buffer *buf;
> > +
> > +	while ((buf = virtqueue_detach_unused_buf(vq)))
> > +		free_buf(buf, true);
> > +}
> > +
> >  static void remove_port_data(struct port *port)
> >  {
> >  	spin_lock_irq(&port->inbuf_lock);
> >  	/* Remove unused data this port might have received. */
> >  	discard_port_data(port);
> > +	remove_unused_bufs(port->in_vq);
> >  	spin_unlock_irq(&port->inbuf_lock);
> >  
> >  	spin_lock_irq(&port->outvq_lock);
> >  	reclaim_consumed_buffers(port);
> > +	remove_unused_bufs(port->out_vq);
> >  	spin_unlock_irq(&port->outvq_lock);
> >  }
> >  
> > @@ -1950,11 +1960,9 @@ static void remove_vqs(struct ports_device *portdev)
> >  	struct virtqueue *vq;
> >  
> >  	virtio_device_for_each_vq(portdev->vdev, vq) {
> > -		struct port_buffer *buf;
> >  
> >  		flush_bufs(vq, true);
> > -		while ((buf = virtqueue_detach_unused_buf(vq)))
> > -			free_buf(buf, true);
> > +		remove_unused_bufs(vq);
> >  	}
> >  	portdev->vdev->config->del_vqs(portdev->vdev);
> >  	kfree(portdev->in_vqs);
> > --
> > 2.20.1
> > 
> > 
