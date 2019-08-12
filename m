Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A502C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 09:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7614208C2
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 09:18:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727342AbfHLJSu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 05:18:50 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44837 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727154AbfHLJSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 05:18:50 -0400
Received: by mail-qt1-f196.google.com with SMTP id 44so71053186qtg.11
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 02:18:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eQ6iC6FPotbDLw/yqSrmxneRMN32NSA1RVINhFfjlLs=;
        b=m4rAfSqawLwrTOH2PRhvlnWaHBdcRcEmd4LsTTKPrq0O/1SHJa6j2BmY7FBHhOBqb2
         ameabMrG5YCUpylJpu85gnqUNa+x89gUPOs+tnkKiTOaj91h9iD6fWFVEDsLjV4G50Lc
         Ih7U6DXQ5dK5nuuanO43MNFwOwRng2wibGUnVbMogUuoHv3hj0u+y5LSbxHu+eZ1KnRf
         BMF1kkO9Sht7sd/uUjtMt5a7V+xH6h2oaUhAohbcWLSxJw+RtlWsi/BqeCFPbpgX9zHE
         ctzSvZkHx7njR7e73Z3bND6A7vcDeosOTu7KWxxpop+Gai2p0TSupj2x5SAOrJnlR6ZD
         eJMQ==
X-Gm-Message-State: APjAAAV8aF4lnV+aH/I8rcpz5MplX6HGTsNfRsEOJG8yLJ42brqAA6iz
        Tz/H0p17sTjD0Qm8HdWfsNRorA==
X-Google-Smtp-Source: APXvYqzgOdql+JK/PJhPFMelOxcGaMkTyi0NmRPnztTdE++1Jkqyr19sSEGOPDgOeu1nQnMgqKnsSQ==
X-Received: by 2002:a0c:b036:: with SMTP id k51mr30009599qvc.103.1565601528843;
        Mon, 12 Aug 2019 02:18:48 -0700 (PDT)
Received: from redhat.com ([147.234.38.29])
        by smtp.gmail.com with ESMTPSA id h26sm60625829qta.58.2019.08.12.02.18.44
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 02:18:47 -0700 (PDT)
Date:   Mon, 12 Aug 2019 05:18:41 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Pankaj Gupta <pagupta@redhat.com>
Cc:     amit@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
        virtualization@lists.linux-foundation.org, jasowang@redhat.com,
        linux-kernel@vger.kernel.org, xiaohli@redhat.com
Subject: Re: [PATCH v3 1/2] virtio_console: free unused buffers with port
 delete
Message-ID: <20190812051642-mutt-send-email-mst@kernel.org>
References: <20190809064847.28918-1-pagupta@redhat.com>
 <20190809064847.28918-2-pagupta@redhat.com>
 <20190810141019-mutt-send-email-mst@kernel.org>
 <361928616.7829318.1565588208467.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <361928616.7829318.1565588208467.JavaMail.zimbra@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2019 at 01:36:48AM -0400, Pankaj Gupta wrote:
> 
> > 
> > On Fri, Aug 09, 2019 at 12:18:46PM +0530, Pankaj Gupta wrote:
> > > The commit a7a69ec0d8e4 ("virtio_console: free buffers after reset")
> > > deferred detaching of unused buffer to virtio device unplug time.
> > > This causes unplug/replug of single port in virtio device with an
> > > error "Error allocating inbufs\n". As we don't free the unused buffers
> > > attached with the port. Re-plug the same port tries to allocate new
> > > buffers in virtqueue and results in this error if queue is full.
> > 
> > So why not reuse the buffers that are already there in this case?
> > Seems quite possible.
> 
> I took this approach because reusing the buffers will involve tweaking
> the existing core functionality like managing the the virt queue indexes.

I don't see why frankly, if you keep a list of outstanding
buffers on plug you can assume they have been added.

> Compared to that deleting the buffers while hot-unplugging port is simple
> and was working fine before. It seems logically correct as well.   
> 
> I agree we need a spec change for this.
> 
> > 
> > > This patch removes the unused buffers in vq's when we unplug the port.
> > > This is the best we can do as we cannot call device_reset because virtio
> > > device is still active.
> > > 
> > > Reported-by: Xiaohui Li <xiaohli@redhat.com>
> > > Fixes: a7a69ec0d8e4 ("virtio_console: free buffers after reset")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> > 
> > This is really a revert of a7a69ec0d8e4, just tagged confusingly.
> > 
> > And the original is also supposed to be a bugfix.
> > So how will the original bug be fixed?
> 
> Yes, Even I was confused while adding this tag.
> I will remove remove 'fixes' tag completely for this patch?
> because its a revert to original behavior which also is a bugfix.
> 
> > 
> > "this is the best we can do" is rarely the case.
> > 
> > I am not necessarily against the revert. But if we go that way then what
> > we need to do is specify the behaviour in the spec, since strict spec
> > compliance is exactly what the original patch was addressing.
> 
> Agree.
> 
> > 
> > In particular, we'd document that console has a special property that
> > when port is detached virtqueue is considered stopped, device must not
> > use any buffers, and it is legal to take buffers out of the device.
> 
> Yes. This documents the exact scenario. Thanks.
> You want me to send a patch for the spec change?
> 
> Best regards,
> Pankaj

Go ahead.

> > 
> > 
> > 
> > > ---
> > >  drivers/char/virtio_console.c | 14 +++++++++++---
> > >  1 file changed, 11 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
> > > index 7270e7b69262..e8be82f1bae9 100644
> > > --- a/drivers/char/virtio_console.c
> > > +++ b/drivers/char/virtio_console.c
> > > @@ -1494,15 +1494,25 @@ static void remove_port(struct kref *kref)
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
> > > @@ -1938,11 +1948,9 @@ static void remove_vqs(struct ports_device *portdev)
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
> > > 2.21.0
> > 
