Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7949C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 05:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8147220820
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 05:37:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbfHLFgu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 01:36:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45502 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725822AbfHLFgt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 01:36:49 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 001608E582;
        Mon, 12 Aug 2019 05:36:48 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E43886092D;
        Mon, 12 Aug 2019 05:36:48 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id CD3732551B;
        Mon, 12 Aug 2019 05:36:48 +0000 (UTC)
Date:   Mon, 12 Aug 2019 01:36:48 -0400 (EDT)
From:   Pankaj Gupta <pagupta@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     amit@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
        virtualization@lists.linux-foundation.org, jasowang@redhat.com,
        linux-kernel@vger.kernel.org, xiaohli@redhat.com
Message-ID: <361928616.7829318.1565588208467.JavaMail.zimbra@redhat.com>
In-Reply-To: <20190810141019-mutt-send-email-mst@kernel.org>
References: <20190809064847.28918-1-pagupta@redhat.com> <20190809064847.28918-2-pagupta@redhat.com> <20190810141019-mutt-send-email-mst@kernel.org>
Subject: Re: [PATCH v3 1/2] virtio_console: free unused buffers with port
 delete
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.116.104, 10.4.195.23]
Thread-Topic: virtio_console: free unused buffers with port delete
Thread-Index: xwxGlAEv6xkpmfow2TwRUq1nvFYnwA==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Mon, 12 Aug 2019 05:36:49 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> On Fri, Aug 09, 2019 at 12:18:46PM +0530, Pankaj Gupta wrote:
> > The commit a7a69ec0d8e4 ("virtio_console: free buffers after reset")
> > deferred detaching of unused buffer to virtio device unplug time.
> > This causes unplug/replug of single port in virtio device with an
> > error "Error allocating inbufs\n". As we don't free the unused buffers
> > attached with the port. Re-plug the same port tries to allocate new
> > buffers in virtqueue and results in this error if queue is full.
> 
> So why not reuse the buffers that are already there in this case?
> Seems quite possible.

I took this approach because reusing the buffers will involve tweaking
the existing core functionality like managing the the virt queue indexes.
Compared to that deleting the buffers while hot-unplugging port is simple
and was working fine before. It seems logically correct as well.   

I agree we need a spec change for this.

> 
> > This patch removes the unused buffers in vq's when we unplug the port.
> > This is the best we can do as we cannot call device_reset because virtio
> > device is still active.
> > 
> > Reported-by: Xiaohui Li <xiaohli@redhat.com>
> > Fixes: a7a69ec0d8e4 ("virtio_console: free buffers after reset")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> 
> This is really a revert of a7a69ec0d8e4, just tagged confusingly.
> 
> And the original is also supposed to be a bugfix.
> So how will the original bug be fixed?

Yes, Even I was confused while adding this tag.
I will remove remove 'fixes' tag completely for this patch?
because its a revert to original behavior which also is a bugfix.

> 
> "this is the best we can do" is rarely the case.
> 
> I am not necessarily against the revert. But if we go that way then what
> we need to do is specify the behaviour in the spec, since strict spec
> compliance is exactly what the original patch was addressing.

Agree.

> 
> In particular, we'd document that console has a special property that
> when port is detached virtqueue is considered stopped, device must not
> use any buffers, and it is legal to take buffers out of the device.

Yes. This documents the exact scenario. Thanks.
You want me to send a patch for the spec change?

Best regards,
Pankaj
 
> 
> 
> 
> > ---
> >  drivers/char/virtio_console.c | 14 +++++++++++---
> >  1 file changed, 11 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
> > index 7270e7b69262..e8be82f1bae9 100644
> > --- a/drivers/char/virtio_console.c
> > +++ b/drivers/char/virtio_console.c
> > @@ -1494,15 +1494,25 @@ static void remove_port(struct kref *kref)
> >          kfree(port);
> >  }
> >  
> > +static void remove_unused_bufs(struct virtqueue *vq)
> > +{
> > +        struct port_buffer *buf;
> > +
> > +        while ((buf = virtqueue_detach_unused_buf(vq)))
> > +                free_buf(buf, true);
> > +}
> > +
> >  static void remove_port_data(struct port *port)
> >  {
> >          spin_lock_irq(&port->inbuf_lock);
> >          /* Remove unused data this port might have received. */
> >          discard_port_data(port);
> > +        remove_unused_bufs(port->in_vq);
> >          spin_unlock_irq(&port->inbuf_lock);
> >  
> >          spin_lock_irq(&port->outvq_lock);
> >          reclaim_consumed_buffers(port);
> > +        remove_unused_bufs(port->out_vq);
> >          spin_unlock_irq(&port->outvq_lock);
> >  }
> >  
> > @@ -1938,11 +1948,9 @@ static void remove_vqs(struct ports_device *portdev)
> >          struct virtqueue *vq;
> >  
> >          virtio_device_for_each_vq(portdev->vdev, vq) {
> > -                struct port_buffer *buf;
> >  
> >                  flush_bufs(vq, true);
> > -                while ((buf = virtqueue_detach_unused_buf(vq)))
> > -                        free_buf(buf, true);
> > +                remove_unused_bufs(vq);
> >          }
> >          portdev->vdev->config->del_vqs(portdev->vdev);
> >          kfree(portdev->in_vqs);
> > --
> > 2.21.0
> 
