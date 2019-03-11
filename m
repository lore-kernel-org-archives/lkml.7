Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F3F8C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 06:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B4BE20657
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 06:53:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbfCKGxb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 02:53:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52584 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725869AbfCKGxb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 02:53:31 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7BE0488306;
        Mon, 11 Mar 2019 06:53:30 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 685FA600CD;
        Mon, 11 Mar 2019 06:53:30 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 2610F181A006;
        Mon, 11 Mar 2019 06:53:30 +0000 (UTC)
Date:   Mon, 11 Mar 2019 02:53:29 -0400 (EDT)
From:   Pankaj Gupta <pagupta@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, amit@kernel.org,
        arnd@arndb.de, gregkh@linuxfoundation.org, xiaohli@redhat.com,
        Gal Hammer <ghammer@redhat.com>
Message-ID: <901790411.11174738.1552287209805.JavaMail.zimbra@redhat.com>
In-Reply-To: <20190311023154-mutt-send-email-mst@kernel.org>
References: <20190304130511.14450-1-pagupta@redhat.com> <20190304142506-mutt-send-email-mst@kernel.org> <444210313.9669582.1551769746169.JavaMail.zimbra@redhat.com> <20190311023154-mutt-send-email-mst@kernel.org>
Subject: Re: [PATCH] virtio_console: free unused buffers with virtio port
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.65.161.16, 10.4.195.25]
Thread-Topic: virtio_console: free unused buffers with virtio port
Thread-Index: a1i/S6Lxw0xsmqXn4JX71Oh13B8niQ==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Mon, 11 Mar 2019 06:53:30 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> > 
> > Hello Michael,
> > 
> > Thanks for your reply.
> > 
> > > 
> > > On Mon, Mar 04, 2019 at 06:35:11PM +0530, Pankaj Gupta wrote:
> > > >   The commit a7a69ec0d8e4 ("virtio_console: free buffers after reset")
> > > >   deffered detaching of unused buffer to virtio device unplug time.
> > > > 
> > > >   This causes unplug/replug of single port in virtio device with an
> > > >   error "Error allocating inbufs\n". As we don't free the unused
> > > >   buffers
> > > >   attached with the port. Re-plug the same port tries to allocate new
> > > >   buffers in virtqueue and results in this error if queue is full.
> 
> That's the basic issue, isn't it? Why aren't we
> reusing buffers that are already there?

I think that that's how initial design has been. Will see if I can fix this.

> 
> 
> > > > 
> > > >   This patch removes the unused buffers in vq's when we unplug the
> > > >   port.
> > > >   This is the best we can do as we cannot call device_reset because
> > > >   virtio
> > > >   device is still active. This was the working behaviour before the
> > > >   change
> > > >   introduced in commit b3258ff1d6.
> > > > 
> > > >   Reported-by: Xiaohui Li <xiaohli@redhat.com>
> > > >   Fixes: b3258ff1d6 ("virtio_console: free buffers after reset")
> > > >   Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> > > 
> > > I think if you do this you need to add support
> > > in the packed ring.
> > 
> > o.k. I will look at the implementation details for "support
> > of packed ring" for virtio_console. This will take some time.
> > 
> > Meanwhile "virtio_console" port hotplug/unplug is broken in upstream.
> > Can we accept this patch as it fixes the upstream and together
> > with parent patch(b3258ff1d6) does nice cleanups as well.
> > 
> > Thanks,
> > Pankaj
> 
> Sorry, no - I don't think we should fix one configuration by breaking the
> other.
> If you want to go back, then that's a spec violation, but I guess we can
> fix the spec to match.  OK, but code-wise if you call
> virtqueue_detach_unused_buf without device reset then you need to teach
> packed ring code to support that.

o.k. Will look at this.

Thanks for the pointers.

Thanks,
Pankaj

> 
> 
> 
> > > 
> > > > ---
> > > >  drivers/char/virtio_console.c | 14 +++++++++++---
> > > >  1 file changed, 11 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/drivers/char/virtio_console.c
> > > > b/drivers/char/virtio_console.c
> > > > index fbeb71953526..5fbf2ac73111 100644
> > > > --- a/drivers/char/virtio_console.c
> > > > +++ b/drivers/char/virtio_console.c
> > > > @@ -1506,15 +1506,25 @@ static void remove_port(struct kref *kref)
> > > >          kfree(port);
> > > >  }
> > > >  
> > > > +static void remove_unused_bufs(struct virtqueue *vq)
> > > > +{
> > > > +        struct port_buffer *buf;
> > > > +
> > > > +        while ((buf = virtqueue_detach_unused_buf(vq)))
> > > > +                free_buf(buf, true);
> > > > +}
> > > > +
> > > >  static void remove_port_data(struct port *port)
> > > >  {
> > > >          spin_lock_irq(&port->inbuf_lock);
> > > >          /* Remove unused data this port might have received. */
> > > >          discard_port_data(port);
> > > > +        remove_unused_bufs(port->in_vq);
> > > >          spin_unlock_irq(&port->inbuf_lock);
> > > >  
> > > >          spin_lock_irq(&port->outvq_lock);
> > > >          reclaim_consumed_buffers(port);
> > > > +        remove_unused_bufs(port->out_vq);
> > > >          spin_unlock_irq(&port->outvq_lock);
> > > >  }
> > > >  
> > > > @@ -1950,11 +1960,9 @@ static void remove_vqs(struct ports_device
> > > > *portdev)
> > > >          struct virtqueue *vq;
> > > >  
> > > >          virtio_device_for_each_vq(portdev->vdev, vq) {
> > > > -                struct port_buffer *buf;
> > > >  
> > > >                  flush_bufs(vq, true);
> > > > -                while ((buf = virtqueue_detach_unused_buf(vq)))
> > > > -                        free_buf(buf, true);
> > > > +                remove_unused_bufs(vq);
> > > >          }
> > > >          portdev->vdev->config->del_vqs(portdev->vdev);
> > > >          kfree(portdev->in_vqs);
> > > > --
> > > > 2.20.1
> > > 
> 
