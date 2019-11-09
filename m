Return-Path: <SRS0=HJxx=ZB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49313C43331
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 05:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19908215EA
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 05:51:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GSiXKZ4u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbfKIFtR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 00:49:17 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37382 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbfKIFtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 00:49:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Mime-Version:Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2daBl1XqJHk3doN2SvcFAh4NuQLq3rWMCItDmKsEpzQ=; b=GSiXKZ4u85elUSwsSft5FIB1p
        q9yCf7onnjBGMgM7WYIrqGrdrwzWSxmg3IIl8nptckvkl0R7Qt522bYRbtJEm+SHghqLgs+1CP67/
        LmowD8XwIY6ZpDsa7j7UUZmPF8EdXJGeK60ZgJ2bLybbkXE38lFhea9GBvfJacV8yahAQCesjWcGK
        vOy50BYEvutu86hMJfPnrhSseYanJlMaOg1Tv7P4LqOFjM5TUfyoARmhRRh5dOqyO/jDGoxY3Tl//
        XqCryecRHT8N1PBPrzj9+o4iOufriu5iYnbbwM69ZtVqlw8MLZL5ue+86f4moULSYE7eTgZ88khC2
        urB5dwqYA==;
Received: from [95.90.212.9] (helo=u601e653ff81a58.ant.amazon.com)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iTJcZ-0000Xq-Gl; Sat, 09 Nov 2019 05:49:15 +0000
Message-ID: <46cc3d4a8d4b2279ce8b3cba5e061ac14b2a0c84.camel@infradead.org>
Subject: Re: [PATCH] virtio_console: allocate inbufs in add_port() only if
 it is needed
From:   Amit Shah <amit@infradead.org>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Laurent Vivier <lvivier@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Amit Shah <amit@kernel.org>,
        virtualization@lists.linux-foundation.org,
        Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 09 Nov 2019 06:49:12 +0100
In-Reply-To: <20191106095707-mutt-send-email-mst@kernel.org>
References: <20191018164718.15999-1-lvivier@redhat.com>
         <20191106085548-mutt-send-email-mst@kernel.org>
         <83d88904-1626-8dd6-9e5c-7abcee27bcd0@redhat.com>
         <20191106095707-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-11-06 at 10:03 -0500, Michael S. Tsirkin wrote:
> On Wed, Nov 06, 2019 at 03:02:25PM +0100, Laurent Vivier wrote:
> > On 06/11/2019 14:56, Michael S. Tsirkin wrote:
> > > On Fri, Oct 18, 2019 at 06:47:18PM +0200, Laurent Vivier wrote:
> > > > When we hot unplug a virtserialport and then try to hot plug
> > > > again,
> > > > it fails:
> > > > 
> > > > (qemu) chardev-add
> > > > socket,id=serial0,path=/tmp/serial0,server,nowait
> > > > (qemu) device_add virtserialport,bus=virtio-serial0.0,nr=2,\
> > > >                   chardev=serial0,id=serial0,name=serial0
> > > > (qemu) device_del serial0
> > > > (qemu) device_add virtserialport,bus=virtio-serial0.0,nr=2,\
> > > >                   chardev=serial0,id=serial0,name=serial0
> > > > kernel error:
> > > >   virtio-ports vport2p2: Error allocating inbufs
> > > > qemu error:
> > > >   virtio-serial-bus: Guest failure in adding port 2 for device
> > > > \
> > > >                      virtio-serial0.0
> > > > 
> > > > This happens because buffers for the in_vq are allocated when
> > > > the port is
> > > > added but are not released when the port is unplugged.
> > > > 
> > > > They are only released when virtconsole is removed (see
> > > > a7a69ec0d8e4)
> > > > 
> > > > To avoid the problem and to be symmetric, we could allocate all
> > > > the buffers
> > > > in init_vqs() as they are released in remove_vqs(), but it
> > > > sounds like
> > > > a waste of memory.
> > > > 
> > > > Rather than that, this patch changes add_port() logic to only
> > > > allocate the
> > > > buffers if the in_vq has available free slots.
> > > > 
> > > > Fixes: a7a69ec0d8e4 ("virtio_console: free buffers after
> > > > reset")
> > > > Cc: mst@redhat.com
> > > > Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> > > > ---
> > > >  drivers/char/virtio_console.c | 17 +++++++++++------
> > > >  1 file changed, 11 insertions(+), 6 deletions(-)
> > > > 
> > > > diff --git a/drivers/char/virtio_console.c
> > > > b/drivers/char/virtio_console.c
> > > > index 7270e7b69262..77105166fe01 100644
> > > > --- a/drivers/char/virtio_console.c
> > > > +++ b/drivers/char/virtio_console.c
> > > > @@ -1421,12 +1421,17 @@ static int add_port(struct ports_device
> > > > *portdev, u32 id)
> > > >  	spin_lock_init(&port->outvq_lock);
> > > >  	init_waitqueue_head(&port->waitqueue);
> > > >  
> > > > -	/* Fill the in_vq with buffers so the host can send us
> > > > data. */
> > > > -	nr_added_bufs = fill_queue(port->in_vq, &port-
> > > > >inbuf_lock);
> > > > -	if (!nr_added_bufs) {
> > > > -		dev_err(port->dev, "Error allocating
> > > > inbufs\n");
> > > > -		err = -ENOMEM;
> > > > -		goto free_device;
> > > > +	/* if the in_vq has not already been filled (the port
> > > > has already been
> > > > +	 * used and unplugged), fill the in_vq with buffers so
> > > > the host can
> > > > +	 * send us data.
> > > > +	 */
> > > > +	if (port->in_vq->num_free != 0) {
> > > > +		nr_added_bufs = fill_queue(port->in_vq, &port-
> > > > >inbuf_lock);
> > > > +		if (!nr_added_bufs) {
> > > > +			dev_err(port->dev, "Error allocating
> > > > inbufs\n");
> > > > +			err = -ENOMEM;
> > > > +			goto free_device;
> > > > +		}
> > > >  	}
> > > >  
> > > >  	if (is_rproc_serial(port->portdev->vdev))
> > > 
> > > Well fill_queue will just add slots as long as it can.
> > > So on a full queue it does nothing. How does this patch help?
> > 
> > Yes, but in this case it returns 0 and so add_port() fails and
> > exits
> > with -ENOMEM and the device is freed. It's what this patch tries to
> > avoid.
> > 
> > Thanks,
> > Laurent
> 
> Oh I see. However it's a bit asymmetrical to special case ring full.
> How about making fill_queue return int and testing return code for
> -ENOSPC instead? Will also help propagate errors correctly.

Yes, I like this better too.

Can you call out which commit introduced this behaviour / regression?

> 
> And I guess CC stable?
> 

