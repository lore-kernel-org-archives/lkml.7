Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D14C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 13:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95F0A20409
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 13:04:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b66DK+eq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbfKSNEl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 08:04:41 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:29240 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727638AbfKSNEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 08:04:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574168679;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1u2WSPm0ixutLDhHPQFbAB3e6YssvhaqnOP7EqAOnTM=;
        b=b66DK+eq2+StNfml/T+qhpItbk3H8heiQd72aVVVBrLMA/ACwbHvhUqUMSh6VEwXn//wiv
        ZjWzBUTD7Gc4ZP192g1mQuKqZjoIU8UBvejrZ0EJRYJeB9XtchGOAYvsxRbxYpKMzEN+/o
        GfxCpXNaqz+8HDqrF3AaHG4MmoKAzqU=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-21-5s073ncJMM-AfqiUC9Kk2g-1; Tue, 19 Nov 2019 08:04:38 -0500
Received: by mail-qt1-f197.google.com with SMTP id v92so14530268qtd.18
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 05:04:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wVazQdPSJMsHL4OK3xhjgyvdKos3XKZz6J3/eg1KCyU=;
        b=DFkoeiKbmWOtH/QoAkYKkaqYOuqJdI3+5UoySB6GvFHwHBKZDzMuv1eeqfDPn6nuG3
         gtg7q49lB6WYQ53enKjTFdIV+7PpjS0jOLEnPjmRZnCVp+vx5JQrqTizRAkHefxasv+/
         l5d3fxhZzZ8ypUk5svZKuEmgB1Kk66MWrYm9owy/g/2480ENWhcjUakQ4V6lgcG2aARb
         hwkjfKp/TJjTiZnXfmVfk9OYROPVgQ8uBOc7/ewuxUjufec3PNogG6kuDZhbHC75XMt/
         JsG22ypS7a4mCKCCaQkveykYl3tdKdsE3AeGNSaZ1nj85KQD/rYdwQPrB4BQ04cJUWKg
         y/9w==
X-Gm-Message-State: APjAAAW33N7szQdetFGPINCo2wKsl3wi2D5vlJMku47cvlynPOp/GEFg
        GzlFrGw+CT09bboNM0IU5aGV8WTcRs7EPk072Q/HsMKob+oych62+HAl8/BZWmIu32KXT08R+eb
        ZFVn1UMFBkaUtlXGPGsgUfrMS
X-Received: by 2002:a37:9bc2:: with SMTP id d185mr28179241qke.299.1574168677411;
        Tue, 19 Nov 2019 05:04:37 -0800 (PST)
X-Google-Smtp-Source: APXvYqzFd/pD/dAXOX6+NHhk5vVmoZGCOTtkClfM8PPmjU9d3WO6EyImxneoYY7/W44Z8WPeVOogig==
X-Received: by 2002:a37:9bc2:: with SMTP id d185mr28179213qke.299.1574168677150;
        Tue, 19 Nov 2019 05:04:37 -0800 (PST)
Received: from redhat.com (bzq-79-176-6-42.red.bezeqint.net. [79.176.6.42])
        by smtp.gmail.com with ESMTPSA id w30sm12605312qtc.47.2019.11.19.05.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 05:04:36 -0800 (PST)
Date:   Tue, 19 Nov 2019 08:04:29 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Halil Pasic <pasic@linux.ibm.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>,
        linux-s390@vger.kernel.org, Michael Mueller <mimu@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Christoph Hellwig <hch@lst.de>, Ram Pai <linuxram@us.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 1/1] virtio_ring: fix return code on DMA mapping fails
Message-ID: <20191119080420-mutt-send-email-mst@kernel.org>
References: <20191114124646.74790-1-pasic@linux.ibm.com>
 <20191119121022.03aed69a.pasic@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20191119121022.03aed69a.pasic@linux.ibm.com>
X-MC-Unique: 5s073ncJMM-AfqiUC9Kk2g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Will be in the next pull request.

On Tue, Nov 19, 2019 at 12:10:22PM +0100, Halil Pasic wrote:
> ping
>=20
> On Thu, 14 Nov 2019 13:46:46 +0100
> Halil Pasic <pasic@linux.ibm.com> wrote:
>=20
> > Commit 780bc7903a32 ("virtio_ring: Support DMA APIs")  makes
> > virtqueue_add() return -EIO when we fail to map our I/O buffers. This i=
s
> > a very realistic scenario for guests with encrypted memory, as swiotlb
> > may run out of space, depending on it's size and the I/O load.
> >=20
> > The virtio-blk driver interprets -EIO form virtqueue_add() as an IO
> > error, despite the fact that swiotlb full is in absence of bugs a
> > recoverable condition.
> >=20
> > Let us change the return code to -ENOMEM, and make the block layer
> > recover form these failures when virtio-blk encounters the condition
> > described above.
> >=20
> > Fixes: 780bc7903a32 ("virtio_ring: Support DMA APIs")
> > Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> > Tested-by: Michael Mueller <mimu@linux.ibm.com>
> > ---
> >=20
> > Notes
> > =3D=3D=3D=3D=3D
> >=20
> > * When out of descriptors (which might regarded as a similar out of
> > resources condition) virtio uses -ENOSPC, this however seems wrong,
> > as ENOSPC is defined as -ENOSPC. Thus I choose -ENOMEM over -ENOSPC.
> >=20
> > * In virtio_queue_rq() in virtio_blk.c both -ENOMEM and -ENOSPC are
> > handled as BLK_STS_DEV_RESOURCE. Returning BLK_STS_RESOURCE however
> > seems more appropriate for dma mapping failed as we are talking about
> > a global, and not a device local resource. Both seem to do the trick.
> >=20
> > * Mimu tested the patch with virtio-blk and virtio-net (thanks!). We
> > should look into how other virtio devices behave when DMA mapping fails=
.
> > ---
> >  drivers/virtio/virtio_ring.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.=
c
> > index a8041e451e9e..867c7ebd3f10 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -583,7 +583,7 @@ static inline int virtqueue_add_split(struct virtqu=
eue *_vq,
> >  =09=09kfree(desc);
> > =20
> >  =09END_USE(vq);
> > -=09return -EIO;
> > +=09return -ENOMEM;
> >  }
> > =20
> >  static bool virtqueue_kick_prepare_split(struct virtqueue *_vq)
> > @@ -1085,7 +1085,7 @@ static int virtqueue_add_indirect_packed(struct v=
ring_virtqueue *vq,
> >  =09kfree(desc);
> > =20
> >  =09END_USE(vq);
> > -=09return -EIO;
> > +=09return -ENOMEM;
> >  }
> > =20
> >  static inline int virtqueue_add_packed(struct virtqueue *_vq,

