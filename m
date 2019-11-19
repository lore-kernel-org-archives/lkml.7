Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D93CC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 13:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15F3D21783
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 13:03:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gyMooxpP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbfKSNDa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 08:03:30 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51375 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725798AbfKSND3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 08:03:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574168607;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VVKdPHyNInKr1jXwID8mLSj5pIoLgSLr+NLS/+lX59s=;
        b=gyMooxpPqqtE0lwRVVcMo99wrL0CrX79iAZ8Y4vD4dV123sBG7m1c+CLizf/WE2sj5o2m/
        KCr9+bQyr2+ENG+uBPpwbOlGbnD02JTmyl4v0TRoJN++szUzB734PMDS/GahpNj6eOvWVU
        +RPBUbq4ujsvE6v6LqarTRglOPCw7Sw=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-Vy0N39GpOD-O8Hfpc0gfmA-1; Tue, 19 Nov 2019 08:03:26 -0500
Received: by mail-qt1-f198.google.com with SMTP id f14so9397573qto.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 05:03:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=U7VXEEogLZ2y/UYgVzgWhynH6YujLFzwyuHzw1/YNWU=;
        b=eCV3sAQDofYH2Amj39qGlXKj/dAanEbNvth/XriLGisecLkBwAlVLy/4mmpLQj0Avs
         SbRHbgZQ4TXwZOBzONVyu85bop9cN+S/qybVVbwhZYT4ZP+qOUe4CWV6Y5WZQjp10GyY
         yGCnoBoBo5UxGDW8bUgmjNc70DOzbNz9wTuhJ3degAdp+abBTKi97UsUDeuDgpVi8weF
         SNy7cMDByroUy7DxT0yRDbdkVgb4+Se0xPY/ZeV5iF880QmAvmfuqspSLV4pKrJOV9MS
         xYiJ/2IzzaI0lu3RhHNqEdMBtZ3v1RD7LnBXj4BsE+GMP5GRa3sEuy8UcThvqmfjE590
         gwSQ==
X-Gm-Message-State: APjAAAVv7Ly7VwFgAF7Py09iQ9zACkuqq9Ukqmo/1TTptTi4YbYX2v/n
        JobtnaVLuzyUwCZTlf0Gfh6n32+KD5M9p6G7OJOQHl/1umByzbkHp2ND/AdojL2fmOfngYKgfXG
        RjFu1mUsQphBxq3BvrCpukUhR
X-Received: by 2002:ae9:edc6:: with SMTP id c189mr29290246qkg.351.1574168606026;
        Tue, 19 Nov 2019 05:03:26 -0800 (PST)
X-Google-Smtp-Source: APXvYqyiIfkMbDD3N5CTsf6CCSVQpQTOzwgDzZyzojxHwiP+jBWlIneB91vqUjmHw3eYsoLuHqhzZw==
X-Received: by 2002:ae9:edc6:: with SMTP id c189mr29290210qkg.351.1574168605618;
        Tue, 19 Nov 2019 05:03:25 -0800 (PST)
Received: from redhat.com (bzq-79-176-6-42.red.bezeqint.net. [79.176.6.42])
        by smtp.gmail.com with ESMTPSA id 187sm10260541qkk.103.2019.11.19.05.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 05:03:24 -0800 (PST)
Date:   Tue, 19 Nov 2019 08:03:19 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Khazhismel Kumykov <khazhy@google.com>,
        Wei Wang <wei.w.wang@intel.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH] virtio_balloon: fix shrinker scan number of pages
Message-ID: <20191119080254-mutt-send-email-mst@kernel.org>
References: <20191119101718.38976-1-mst@redhat.com>
 <34c84d6a-d200-c296-39bb-4770bf4517e9@redhat.com>
MIME-Version: 1.0
In-Reply-To: <34c84d6a-d200-c296-39bb-4770bf4517e9@redhat.com>
X-MC-Unique: Vy0N39GpOD-O8Hfpc0gfmA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19, 2019 at 12:39:51PM +0100, David Hildenbrand wrote:
> On 19.11.19 11:17, Michael S. Tsirkin wrote:
> > virtio_balloon_shrinker_scan should return number of system pages freed=
,
> > but because it's calling functions that deal with balloon pages, it get=
s
> > confused and sometimes returns the number of balloon pages.
> >=20
> > It does not matter practically as the exact number isn't
> > used, but it seems better to be consistent in case someone
> > starts using this API.
>=20
> If it doesn't matter, why cc: stable?

Oh right. Sorry.

> >=20
> > Further, if we ever tried to iteratively leak pages as
> > virtio_balloon_shrinker_scan tries to do, we'd run into issues - this i=
s
> > because freed_pages was accumulating total freed pages, but was also
> > subtracted on each iteration from pages_to_free, which can result in
> > either leaking less memory than we were supposed to free, or or more if
> > pages_to_free underruns.
> >=20
> > On a system with 4K pages we are lucky that we are never asked to leak
> > more than 128 pages while we can leak up to 256 at a time,
> > but it looks like a real issue for systems with page size !=3D 4K.
> >=20
> > Cc: stable@vger.kernel.org
> > Fixes: 71994620bb25 ("virtio_balloon: replace oom notifier with shrinke=
r")
> > Reported-by: Khazhismel Kumykov <khazhy@google.com>
> > Reviewed-by: Wei Wang <wei.w.wang@intel.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >   drivers/virtio/virtio_balloon.c | 17 +++++++++++------
> >   1 file changed, 11 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_ba=
lloon.c
> > index 226fbb995fb0..7cee05cdf3fb 100644
> > --- a/drivers/virtio/virtio_balloon.c
> > +++ b/drivers/virtio/virtio_balloon.c
> > @@ -772,6 +772,13 @@ static unsigned long shrink_free_pages(struct virt=
io_balloon *vb,
> >   =09return blocks_freed << VIRTIO_BALLOON_FREE_PAGE_ORDER;
> >   }
> > +static unsigned long leak_balloon_pages(struct virtio_balloon *vb,
> > +                                          unsigned long pages_to_free)
> > +{
> > +=09return leak_balloon(vb, pages_to_free * VIRTIO_BALLOON_PAGES_PER_PA=
GE) /
> > +=09=09VIRTIO_BALLOON_PAGES_PER_PAGE;
> > +}
> > +
> >   static unsigned long shrink_balloon_pages(struct virtio_balloon *vb,
> >   =09=09=09=09=09  unsigned long pages_to_free)
> >   {
> > @@ -782,11 +789,9 @@ static unsigned long shrink_balloon_pages(struct v=
irtio_balloon *vb,
> >   =09 * VIRTIO_BALLOON_ARRAY_PFNS_MAX balloon pages, so we call it
> >   =09 * multiple times to deflate pages till reaching pages_to_free.
> >   =09 */
> > -=09while (vb->num_pages && pages_to_free) {
> > -=09=09pages_freed +=3D leak_balloon(vb, pages_to_free) /
> > -=09=09=09=09=09VIRTIO_BALLOON_PAGES_PER_PAGE;
> > -=09=09pages_to_free -=3D pages_freed;
> > -=09}
> > +=09while (vb->num_pages && pages_freed < pages_to_free)
> > +=09=09pages_freed +=3D leak_balloon_pages(vb, pages_to_free);
> > +
> >   =09update_balloon_size(vb);
> >   =09return pages_freed;
> > @@ -799,7 +804,7 @@ static unsigned long virtio_balloon_shrinker_scan(s=
truct shrinker *shrinker,
> >   =09struct virtio_balloon *vb =3D container_of(shrinker,
> >   =09=09=09=09=09struct virtio_balloon, shrinker);
> > -=09pages_to_free =3D sc->nr_to_scan * VIRTIO_BALLOON_PAGES_PER_PAGE;
> > +=09pages_to_free =3D sc->nr_to_scan;
> >   =09if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT))
> >   =09=09pages_freed =3D shrink_free_pages(vb, pages_to_free);
> >=20
>=20
>=20
> --=20
>=20
> Thanks,
>=20
> David / dhildenb

