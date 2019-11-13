Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A1EC43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 15:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF907222C9
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 15:22:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S50XIFPJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727892AbfKMPWr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 10:22:47 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22208 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726251AbfKMPWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 10:22:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573658565;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+KjRbhhvO4WTOEFUUtwtXRdJpE9UQrQjjvF4ERtS2uw=;
        b=S50XIFPJwgGizpaRF3E4yJ94xU6u+kSW/Q7YdUZcVs+5j5WESFO1jNvGEYSLOTaYJT5VmK
        FBg0/5hNUXpsm3mwfXq96NRXZokEmy2/J58WQDhFHTs0YHxIPGy3YfxR+wa0eq97nLNOzd
        JXb9J3SW9PG6jJsTna68mRdTccDbGAI=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-373-zjvgiJgZMhecX2Vi2XXqRA-1; Wed, 13 Nov 2019 10:22:44 -0500
Received: by mail-qt1-f200.google.com with SMTP id h39so1574728qth.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 07:22:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TNn6X1eMJfWx1OiYq82nWJkqpXSkmJOrNr++Bx8M3rs=;
        b=kcilM87FSJfF52estMZHATFA2ew3XupM1ssl92WfWa3JR8G3ZyUJ+j0xvm0qZsNVB+
         goEAa2Dj6CRdzvEJcABBnovVIhNWj9i/5AKTvnFP5tRlCXbpg+PCfUCYwsM/16YsLNzW
         lQwypzHp79q67+E2XVbSZSxcwrVUEbZlttk5YOIkH5N1VjGyXaduDClpSzW7aHzqDFM6
         MuzRjCdGRjHQ4Jz5ai9OiKox4PdVbM6FNPOSts+GJRbLzKgOGNygR2vvGtB6hdObdyc9
         nyWNuUWx9/bHGfO7Hw44ULk9qtx19XELrwWXT7FL/1PexhDYFLoqt+qub81RqO8kvUPn
         F/sw==
X-Gm-Message-State: APjAAAUeN8IJFeKQvY+myaDCuoK6I+Ixk1TOalxvOF0cDTsVIycyu4dg
        Az6P25OOcfx1ijd/LGNj2w608F2JeuenEHcH0niJmKfLddjqbysOtybaVKBxC0ZW0SD20NUZHe5
        evy+vvHHLA2HRTNjtI2q2sm/c
X-Received: by 2002:ac8:30cd:: with SMTP id w13mr3108607qta.201.1573658563592;
        Wed, 13 Nov 2019 07:22:43 -0800 (PST)
X-Google-Smtp-Source: APXvYqyJYlUkuzt9TKxbm/vUL5Cx0VmcBgc+mJVbsJqr9tWWJslBsLr3PHUo5IeNhBnqNA5u6IsuWA==
X-Received: by 2002:ac8:30cd:: with SMTP id w13mr3108569qta.201.1573658563335;
        Wed, 13 Nov 2019 07:22:43 -0800 (PST)
Received: from redhat.com (bzq-79-176-6-42.red.bezeqint.net. [79.176.6.42])
        by smtp.gmail.com with ESMTPSA id j7sm1100327qkd.46.2019.11.13.07.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 07:22:42 -0800 (PST)
Date:   Wed, 13 Nov 2019 10:22:37 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Laurent Vivier <lvivier@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Amit Shah <amit@kernel.org>,
        virtualization@lists.linux-foundation.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] virtio_console: allocate inbufs in add_port() only if
 it is needed
Message-ID: <20191113102126-mutt-send-email-mst@kernel.org>
References: <20191113150056.9990-1-lvivier@redhat.com>
 <20191113101929-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20191113101929-mutt-send-email-mst@kernel.org>
X-MC-Unique: zjvgiJgZMhecX2Vi2XXqRA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2019 at 10:21:11AM -0500, Michael S. Tsirkin wrote:
> On Wed, Nov 13, 2019 at 04:00:56PM +0100, Laurent Vivier wrote:
> > When we hot unplug a virtserialport and then try to hot plug again,
> > it fails:
> >=20
> > (qemu) chardev-add socket,id=3Dserial0,path=3D/tmp/serial0,server,nowai=
t
> > (qemu) device_add virtserialport,bus=3Dvirtio-serial0.0,nr=3D2,\
> >                   chardev=3Dserial0,id=3Dserial0,name=3Dserial0
> > (qemu) device_del serial0
> > (qemu) device_add virtserialport,bus=3Dvirtio-serial0.0,nr=3D2,\
> >                   chardev=3Dserial0,id=3Dserial0,name=3Dserial0
> > kernel error:
> >   virtio-ports vport2p2: Error allocating inbufs
> > qemu error:
> >   virtio-serial-bus: Guest failure in adding port 2 for device \
> >                      virtio-serial0.0
> >=20
> > This happens because buffers for the in_vq are allocated when the port =
is
> > added but are not released when the port is unplugged.
> >=20
> > They are only released when virtconsole is removed (see a7a69ec0d8e4)
> >=20
> > To avoid the problem and to be symmetric, we could allocate all the buf=
fers
> > in init_vqs() as they are released in remove_vqs(), but it sounds like
> > a waste of memory.
> >=20
> > Rather than that, this patch changes add_port() logic to ignore ENOSPC
> > error in fill_queue(), which means queue has already been filled.
> >=20
> > Fixes: a7a69ec0d8e4 ("virtio_console: free buffers after reset")
> > Cc: mst@redhat.com
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> > ---
> >=20
> > Notes:
> >     v2: making fill_queue return int and testing return code for -ENOSP=
C
> >=20
> >  drivers/char/virtio_console.c | 24 +++++++++---------------
> >  1 file changed, 9 insertions(+), 15 deletions(-)
> >=20
> > diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_consol=
e.c
> > index 7270e7b69262..9e6534fd1aa4 100644
> > --- a/drivers/char/virtio_console.c
> > +++ b/drivers/char/virtio_console.c
> > @@ -1325,24 +1325,24 @@ static void set_console_size(struct port *port,=
 u16 rows, u16 cols)
> >  =09port->cons.ws.ws_col =3D cols;
> >  }
> > =20
> > -static unsigned int fill_queue(struct virtqueue *vq, spinlock_t *lock)
> > +static int fill_queue(struct virtqueue *vq, spinlock_t *lock)
> >  {
> >  =09struct port_buffer *buf;
> > -=09unsigned int nr_added_bufs;
> > +=09int nr_added_bufs;
> >  =09int ret;
> > =20
> >  =09nr_added_bufs =3D 0;
> >  =09do {
> >  =09=09buf =3D alloc_buf(vq->vdev, PAGE_SIZE, 0);
> >  =09=09if (!buf)
> > -=09=09=09break;
> > +=09=09=09return -ENOMEM;
> > =20
> >  =09=09spin_lock_irq(lock);
> >  =09=09ret =3D add_inbuf(vq, buf);
> >  =09=09if (ret < 0) {
> >  =09=09=09spin_unlock_irq(lock);
> >  =09=09=09free_buf(buf, true);
> > -=09=09=09break;
> > +=09=09=09return ret;
> >  =09=09}
> >  =09=09nr_added_bufs++;
> >  =09=09spin_unlock_irq(lock);

So actually, how about handling ENOSPC specially here, and
returning success? After all queue is full as requested ...


> > @@ -1362,7 +1362,6 @@ static int add_port(struct ports_device *portdev,=
 u32 id)
> >  =09char debugfs_name[16];
> >  =09struct port *port;
> >  =09dev_t devt;
> > -=09unsigned int nr_added_bufs;
> >  =09int err;
> > =20
> >  =09port =3D kmalloc(sizeof(*port), GFP_KERNEL);
> > @@ -1421,11 +1420,9 @@ static int add_port(struct ports_device *portdev=
, u32 id)
> >  =09spin_lock_init(&port->outvq_lock);
> >  =09init_waitqueue_head(&port->waitqueue);
> > =20
> > -=09/* Fill the in_vq with buffers so the host can send us data. */
> > -=09nr_added_bufs =3D fill_queue(port->in_vq, &port->inbuf_lock);
> > -=09if (!nr_added_bufs) {
> > +=09err =3D fill_queue(port->in_vq, &port->inbuf_lock);
> > +=09if (err < 0 && err !=3D -ENOSPC) {
> >  =09=09dev_err(port->dev, "Error allocating inbufs\n");
> > -=09=09err =3D -ENOMEM;
> >  =09=09goto free_device;
> >  =09}
> > =20
>=20
> Pls add a comment explaining that -ENOSPC happens when
> queue already has buffers (e.g. from previous detach).
>=20
>=20
> > @@ -2059,14 +2056,11 @@ static int virtcons_probe(struct virtio_device =
*vdev)
> >  =09INIT_WORK(&portdev->control_work, &control_work_handler);
> > =20
> >  =09if (multiport) {
> > -=09=09unsigned int nr_added_bufs;
> > -
> >  =09=09spin_lock_init(&portdev->c_ivq_lock);
> >  =09=09spin_lock_init(&portdev->c_ovq_lock);
> > =20
> > -=09=09nr_added_bufs =3D fill_queue(portdev->c_ivq,
> > -=09=09=09=09=09   &portdev->c_ivq_lock);
> > -=09=09if (!nr_added_bufs) {
> > +=09=09err =3D fill_queue(portdev->c_ivq, &portdev->c_ivq_lock);
> > +=09=09if (err < 0) {
> >  =09=09=09dev_err(&vdev->dev,
> >  =09=09=09=09"Error allocating buffers for control queue\n");
> >  =09=09=09/*
> > @@ -2077,7 +2071,7 @@ static int virtcons_probe(struct virtio_device *v=
dev)
> >  =09=09=09=09=09   VIRTIO_CONSOLE_DEVICE_READY, 0);
> >  =09=09=09/* Device was functional: we need full cleanup. */
> >  =09=09=09virtcons_remove(vdev);
> > -=09=09=09return -ENOMEM;
> > +=09=09=09return err;
> >  =09=09}
> >  =09} else {
> >  =09=09/*
> > --=20
> > 2.23.0

