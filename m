Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94077C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 19:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFD96206D5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 19:28:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MLxerkn8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbfKMT2x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 14:28:53 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30463 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726074AbfKMT2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 14:28:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573673330;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8DO2hwiHu3pgkopyWQopR93a48RM5O8XuzUQ/v4W2kE=;
        b=MLxerkn8GU8AlysHMqxyN6aw/q0n3neEV61SDpyPcKedpZzXgg0bB+OlZIHqMNPHhsgRQu
        tzfce6LRi1QehMiUlSEG/ajplLhuaqLClo11PWoLEesVO3DryE0EYhxVnuFIRexUosc645
        FWTv5ugnbzj0/1VkipkfiWrrdNNIZvA=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-auuCm0wRMgaIuY2OLixYcQ-1; Wed, 13 Nov 2019 14:28:49 -0500
Received: by mail-qt1-f197.google.com with SMTP id g5so2171838qtc.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 11:28:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CoUlcMFhYrKHjvPh5qnAfb7ZB6jVrV1NCGIqlkgFJ7Q=;
        b=HdUQq4j2Tbjona+FYE1/Opn7IwlHQtYFEaFKWtIoeQLrmzDiP6gSKzJtJ2QfdlxtWu
         JYdEqTcIc91MrhwDbkqwR9aEFtvu3yqULB4pSLghTlYTTbME4MX6DIl8iRijvsWMYmW2
         iXPuSveO93v7dcMsCbrLVBykrpqNTrB7BR4Px7LOjG3gB4qCQzlBdMTuxnWwfL+/REJX
         sEhkl1DJ1fOZp1v7BsMksgXk/eppNq7qDrnsQD3x6DJlCV7JA3I37i/oGTO6hHl3FnEX
         wNmySdDNg+ypmnttWjRRDsbFVfTJ2PJkpRBi+WqsWTGo+aPPOsn/Nnrf8AbIR+96SiBY
         V5OA==
X-Gm-Message-State: APjAAAWWseQ5zpKTikC3FLeQX3eFKbQpSfRys+Xr9JbR2LqKf+//CS1F
        S+TGOMLNUjJHdAunXw6UItdY82xJLgP6N1cbyr5NHLJmUuWtJKaraIIuC+Pxl9lU/K7I0q5+m0k
        2fhMy/Nm9rTzmihgINUb9ppOk
X-Received: by 2002:ac8:7085:: with SMTP id y5mr4307326qto.76.1573673329305;
        Wed, 13 Nov 2019 11:28:49 -0800 (PST)
X-Google-Smtp-Source: APXvYqx0ClAjjDvl9GSwMYMpNSj/1YP4wP59jyAYjjbPHC57IJ0tL8dPnQYy8A4DXBH9pQa2yR53Lw==
X-Received: by 2002:ac8:7085:: with SMTP id y5mr4307296qto.76.1573673329049;
        Wed, 13 Nov 2019 11:28:49 -0800 (PST)
Received: from redhat.com (bzq-79-176-6-42.red.bezeqint.net. [79.176.6.42])
        by smtp.gmail.com with ESMTPSA id i4sm1621727qtp.57.2019.11.13.11.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 11:28:47 -0800 (PST)
Date:   Wed, 13 Nov 2019 14:28:42 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Laurent Vivier <lvivier@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Amit Shah <amit@kernel.org>,
        virtualization@lists.linux-foundation.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] virtio_console: allocate inbufs in add_port() only if
 it is needed
Message-ID: <20191113142757-mutt-send-email-mst@kernel.org>
References: <20191113150056.9990-1-lvivier@redhat.com>
 <20191113101929-mutt-send-email-mst@kernel.org>
 <20191113102126-mutt-send-email-mst@kernel.org>
 <7bd34d61-146f-8edb-d82d-7285a83437b4@redhat.com>
MIME-Version: 1.0
In-Reply-To: <7bd34d61-146f-8edb-d82d-7285a83437b4@redhat.com>
X-MC-Unique: auuCm0wRMgaIuY2OLixYcQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2019 at 05:37:34PM +0100, Laurent Vivier wrote:
> On 13/11/2019 16:22, Michael S. Tsirkin wrote:
> > On Wed, Nov 13, 2019 at 10:21:11AM -0500, Michael S. Tsirkin wrote:
> >> On Wed, Nov 13, 2019 at 04:00:56PM +0100, Laurent Vivier wrote:
> >>> When we hot unplug a virtserialport and then try to hot plug again,
> >>> it fails:
> >>>
> >>> (qemu) chardev-add socket,id=3Dserial0,path=3D/tmp/serial0,server,now=
ait
> >>> (qemu) device_add virtserialport,bus=3Dvirtio-serial0.0,nr=3D2,\
> >>>                   chardev=3Dserial0,id=3Dserial0,name=3Dserial0
> >>> (qemu) device_del serial0
> >>> (qemu) device_add virtserialport,bus=3Dvirtio-serial0.0,nr=3D2,\
> >>>                   chardev=3Dserial0,id=3Dserial0,name=3Dserial0
> >>> kernel error:
> >>>   virtio-ports vport2p2: Error allocating inbufs
> >>> qemu error:
> >>>   virtio-serial-bus: Guest failure in adding port 2 for device \
> >>>                      virtio-serial0.0
> >>>
> >>> This happens because buffers for the in_vq are allocated when the por=
t is
> >>> added but are not released when the port is unplugged.
> >>>
> >>> They are only released when virtconsole is removed (see a7a69ec0d8e4)
> >>>
> >>> To avoid the problem and to be symmetric, we could allocate all the b=
uffers
> >>> in init_vqs() as they are released in remove_vqs(), but it sounds lik=
e
> >>> a waste of memory.
> >>>
> >>> Rather than that, this patch changes add_port() logic to ignore ENOSP=
C
> >>> error in fill_queue(), which means queue has already been filled.
> >>>
> >>> Fixes: a7a69ec0d8e4 ("virtio_console: free buffers after reset")
> >>> Cc: mst@redhat.com
> >>> Cc: stable@vger.kernel.org
> >>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> >>> ---
> >>>
> >>> Notes:
> >>>     v2: making fill_queue return int and testing return code for -ENO=
SPC
> >>>
> >>>  drivers/char/virtio_console.c | 24 +++++++++---------------
> >>>  1 file changed, 9 insertions(+), 15 deletions(-)
> >>>
> >>> diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_cons=
ole.c
> >>> index 7270e7b69262..9e6534fd1aa4 100644
> >>> --- a/drivers/char/virtio_console.c
> >>> +++ b/drivers/char/virtio_console.c
> >>> @@ -1325,24 +1325,24 @@ static void set_console_size(struct port *por=
t, u16 rows, u16 cols)
> >>>  =09port->cons.ws.ws_col =3D cols;
> >>>  }
> >>> =20
> >>> -static unsigned int fill_queue(struct virtqueue *vq, spinlock_t *loc=
k)
> >>> +static int fill_queue(struct virtqueue *vq, spinlock_t *lock)
> >>>  {
> >>>  =09struct port_buffer *buf;
> >>> -=09unsigned int nr_added_bufs;
> >>> +=09int nr_added_bufs;
> >>>  =09int ret;
> >>> =20
> >>>  =09nr_added_bufs =3D 0;
> >>>  =09do {
> >>>  =09=09buf =3D alloc_buf(vq->vdev, PAGE_SIZE, 0);
> >>>  =09=09if (!buf)
> >>> -=09=09=09break;
> >>> +=09=09=09return -ENOMEM;
> >>> =20
> >>>  =09=09spin_lock_irq(lock);
> >>>  =09=09ret =3D add_inbuf(vq, buf);
> >>>  =09=09if (ret < 0) {
> >>>  =09=09=09spin_unlock_irq(lock);
> >>>  =09=09=09free_buf(buf, true);
> >>> -=09=09=09break;
> >>> +=09=09=09return ret;
> >>>  =09=09}
> >>>  =09=09nr_added_bufs++;
> >>>  =09=09spin_unlock_irq(lock);
> >=20
> > So actually, how about handling ENOSPC specially here, and
> > returning success? After all queue is full as requested ...
>=20
> I think it's interesting to return -ENOSPC to manage it as a real error
> in virtcons_probe() as in this function the queue should not be already
> full (is this right?) and to return the real error code.
>=20
> Thanks,
> Laurent

OK then. Pls add comments.

