Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD05C43215
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 08:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB55A2073A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 08:26:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b5PGCd6p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfKRI04 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 03:26:56 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:55414 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726371AbfKRI04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 03:26:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574065615;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ByPLXU8BDPtbb3tbGDB/Jm4mHDg38iJDz9u+XiYNI5A=;
        b=b5PGCd6phMasL1GF54r1s9no5vuOWU2tx5Ewii0/gGsDAwylh6at+5Morh9DWLmpa8ybj3
        NQ7Hy9LufH5SyRWFVqeKdHMo6VBTsHicp35nRhcf0Jk6oqjSGsN89z6nOddwG/vKVhaehl
        2jWdiPmpoWAescgMPeJmBSvcuJPG65U=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-wlNdEEhHO2u7MvRsjvhViA-1; Mon, 18 Nov 2019 03:26:54 -0500
Received: by mail-qv1-f72.google.com with SMTP id i16so12020106qvm.14
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 00:26:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9IFqsCNjREhNSOIxGQiLDI4kH2Pz3dqU+cVY+w6Rri8=;
        b=LjEtUMcsudAbZkSQpfsRgwKI22HrtXe+QPhe6KJWKs4YvLfjvb+/imz9KqWAnvQI1B
         aNXbl819QrfbLScQlx3YkMy5krJDk9Hh9zwX7paBjuE7QTFxbr/GQRgcOhvfqza5I/s0
         /RkIrNCZ77Xajo48AhA4hfV3awTV6xJnRDzr4VH8tDSyARlP5b8YtRpdQ5w+CiW162F+
         dF5N3aJjugunwuGMgiAYPCfsr6k0b3c2Y6cEpKm5FNB7QJ7vaMpYYjuwefsmKlAvQR+i
         I9rKkK8R31dFV/jp+dB4mP/PRIOjTr+t3McqRXKBMeW1flcLZMcOyB9m8tT9embUB+21
         CTqw==
X-Gm-Message-State: APjAAAWmy/l8j6dcFXoM8n54GtHLzTF3y2IPW+uRXp1CcvXa+GE/DKdl
        QWcCjoqfgOUqXAXrkyfMPjhXplat5D61SWai6g6ZKHCKyD27F7ZJrNPkHFbhiDL/F4P9v1jah9C
        FPo8OnBGwSd6eClbYuQFWNdNK
X-Received: by 2002:a37:9d86:: with SMTP id g128mr10375886qke.191.1574065613488;
        Mon, 18 Nov 2019 00:26:53 -0800 (PST)
X-Google-Smtp-Source: APXvYqxGrF+fENadjFKVs85MXbTNN4TM6UePUH4vn3ogeGCdoe6BV/yASZxAa5c+37gDx2aVE7t9Qw==
X-Received: by 2002:a37:9d86:: with SMTP id g128mr10375872qke.191.1574065613158;
        Mon, 18 Nov 2019 00:26:53 -0800 (PST)
Received: from redhat.com (bzq-79-176-6-42.red.bezeqint.net. [79.176.6.42])
        by smtp.gmail.com with ESMTPSA id c6sm7957968qka.81.2019.11.18.00.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 00:26:52 -0800 (PST)
Date:   Mon, 18 Nov 2019 03:26:47 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Wei Wang <wei.w.wang@intel.com>
Cc:     Khazhismel Kumykov <khazhy@google.com>, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio_balloon: fix shrinker pages_to_free calculation
Message-ID: <20191118032416-mutt-send-email-mst@kernel.org>
References: <20191115225557.61847-1-khazhy@google.com>
 <5DD21784.8020506@intel.com>
 <20191118002652-mutt-send-email-mst@kernel.org>
 <5DD24B52.4090603@intel.com>
MIME-Version: 1.0
In-Reply-To: <5DD24B52.4090603@intel.com>
X-MC-Unique: wlNdEEhHO2u7MvRsjvhViA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2019 at 03:42:10PM +0800, Wei Wang wrote:
> On 11/18/2019 01:30 PM, Michael S. Tsirkin wrote:
> > On Mon, Nov 18, 2019 at 12:01:08PM +0800, Wei Wang wrote:
> > > On 11/16/2019 06:55 AM, Khazhismel Kumykov wrote:
> > > > To my reading, we're accumulating total freed pages in pages_freed,=
 but
> > > > subtracting it every iteration from pages_to_free, meaning we'll co=
unt
> > > > earlier iterations multiple times, freeing fewer pages than expecte=
d.
> > > > Just accumulate in pages_freed, and compare to pages_to_free.
> > > Not sure about the above. But the following unit mismatch is a good c=
apture,
> > > thanks!
> > >=20
> > > > There's also a unit mismatch, where pages_to_free seems to be virti=
o
> > > > balloon pages, and pages_freed is system pages (We divide by
> > > > VIRTIO_BALLOON_PAGES_PER_PAGE), so sutracting pages_freed from
> > > > pages_to_free may result in freeing too much.
> > > >=20
> > > > There also seems to be a mismatch between shrink_free_pages() and
> > > > shrink_balloon_pages(), where in both pages_to_free is given as # o=
f
> > > > virtio pages to free, but free_pages() returns virtio pages, and
> > > > balloon_pages returns system pages.
> > > >=20
> > > > (For 4K PAGE_SIZE, this mismatch wouldn't be noticed since
> > > > VIRTIO_BALLOON_PAGES_PER_PAGE would be 1)
> > > >=20
> > > > Have both return virtio pages, and divide into system pages when
> > > > returning from shrinker_scan()
> > > Sounds good.
> > >=20
> > > > Fixes: 71994620bb25 ("virtio_balloon: replace oom notifier with shr=
inker")
> > > > Cc: Wei Wang <wei.w.wang@intel.com>
> > > > Signed-off-by: Khazhismel Kumykov <khazhy@google.com>
> > > > ---
> > > >=20
> > > > Tested this under memory pressure conditions and the shrinker seeme=
d to
> > > > shrink.
> > > >=20
> > > >    drivers/virtio/virtio_balloon.c | 11 ++++-------
> > > >    1 file changed, 4 insertions(+), 7 deletions(-)
> > > >=20
> > > > diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virti=
o_balloon.c
> > > > index 226fbb995fb0..7951ece3fe24 100644
> > > > --- a/drivers/virtio/virtio_balloon.c
> > > > +++ b/drivers/virtio/virtio_balloon.c
> > > > @@ -782,11 +782,8 @@ static unsigned long shrink_balloon_pages(stru=
ct virtio_balloon *vb,
> > > >    =09 * VIRTIO_BALLOON_ARRAY_PFNS_MAX balloon pages, so we call it
> > > >    =09 * multiple times to deflate pages till reaching pages_to_fre=
e.
> > > >    =09 */
> > > > -=09while (vb->num_pages && pages_to_free) {
> > > > -=09=09pages_freed +=3D leak_balloon(vb, pages_to_free) /
> > > > -=09=09=09=09=09VIRTIO_BALLOON_PAGES_PER_PAGE;
> > > > -=09=09pages_to_free -=3D pages_freed;
> > > > -=09}
> > > > +=09while (vb->num_pages && pages_to_free > pages_freed)
> > > > +=09=09pages_freed +=3D leak_balloon(vb, pages_to_free - pages_free=
d);
> > > >    =09update_balloon_size(vb);
> > > >    =09return pages_freed;
> > > > @@ -805,11 +802,11 @@ static unsigned long virtio_balloon_shrinker_=
scan(struct shrinker *shrinker,
> > > >    =09=09pages_freed =3D shrink_free_pages(vb, pages_to_free);
> > > We also need a fix here then:
> > >=20
> > > pages_freed =3D shrink_free_pages(vb, sc->nr_to_scan) *
> > > VIRTIO_BALLOON_PAGES_PER_PAGE;
> > No let's do accounting in pages please. virtio page is a legacy
> > thing we just did not fix it in time to get rid of it by now.
> >=20
> > > Btw, there is another mistake, in virtio_balloon_shrinker_count:
> > >=20
> > > -       count +=3D vb->num_free_page_blocks >> VIRTIO_BALLOON_FREE_PA=
GE_ORDER;
> > > +      count +=3D vb->num_free_page_blocks << VIRTIO_BALLOON_FREE_PAG=
E_ORDER;
> > >=20
> > > You may want to include it in this fix patch as well.
> > OMG. should be a separate patch.
> > But really this just shows why shifts are such a bad idea.
> >=20
> > Let's define
> > VIRTIO_BALLOON_PAGES_PER_FREE_PAGE
> >=20
> > and use it with * and / consistently instead of shifts.
> >=20
>=20
> OK, will do (maybe call it VIRTIO_BALLOON_FREE_PAGES_PER_BLOCK).
>=20
> Best,
> Wei


The order is called VIRTIO_BALLOON_FREE_PAGE_ORDER
making it sounds like there's a free page
and that's it order.

Let's rename that hont block?
So VIRTIO_BALLOON_HINT_BLOCK_ORDER ?

VIRTIO_BALLOON_PAGES_PER_HINT_BLOCK ?

