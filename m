Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84FE5C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 05:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45B4A2071E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 05:30:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LBeV8noD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbfKRFaa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 00:30:30 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:35960 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725208AbfKRFa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 00:30:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574055028;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cM+ZY0kiEN3ShFD9N2PS2oAJIZM6V3iyQ3TkZ3AlUbY=;
        b=LBeV8noDWxuhirUpcFrJPYrpoTGeNzhZEYCJk/T7zL5lrJqnsFZxXioMS1h8bgZfIGCZwH
        Khe88jt0YZRlIK0kHBlD/3LuYhAWTatAmxZyFSQyNE7TqmYJs97QtIH715+jx6oOiFmPKS
        C1xLXdVLCVqhAccQgfRiHBbuoaDzJbw=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-171-L3kf4AFEN_yDsXBWCZq3mw-1; Mon, 18 Nov 2019 00:30:27 -0500
Received: by mail-qv1-f72.google.com with SMTP id w5so11784958qvp.13
        for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2019 21:30:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5WVKfymr1YEchUwz2Wftxp/wUTNabqDDc/q/WfqIOeU=;
        b=FQ7TqzamOikBV8geOFRZuoFPqUt7UTAy3kCNtSj7HGNpVrFxrxWUydlLiBjWBJgdFz
         N+jMnBNcX4g+k63xfbavNE9ynNMbCkdxHFhvcIuQvaG6b3hMYB4JeoZt87dxaAKANvcG
         f0DSlYxP7egW9YRh3sfvI+Ogn3eKS4ESsIbUOTsVqH05bjfFjFyJeO+BhOHKt97I3EXO
         D41m3/zNgmLmsAC2yzMpyQd8ppqNGPNlRerBkn+2Yim7ufmnkj6SyReSgrvAV5G2MTuy
         1Oy2Jn6BKPpIAiQs1NPyn+4e6CIrMQeX6Dh3wKOzr/CA32tsq5fnB8whtCigLSE91OYm
         reSw==
X-Gm-Message-State: APjAAAUMR3c165BULok7sP0XBPzZya5trXdkFVTuNJwBFRAbbumXr5sH
        hyHdOs285ZKmyTHTZzv31Lg4YG7wVuVvipmRnl7HJweY4vLg+9Js5vs6hmJ8F8iGfafutoQcQVE
        6HXqlOzL9ZZDNRG5wBX1m55HP
X-Received: by 2002:a37:4ad3:: with SMTP id x202mr16489671qka.362.1574055027371;
        Sun, 17 Nov 2019 21:30:27 -0800 (PST)
X-Google-Smtp-Source: APXvYqx1wvmuwW9WouVV8GtlpPlimHAslmHqqCLkPDLwp3P7+XCE/9qp5h3ynPMrM/B031xyzcnyhw==
X-Received: by 2002:a37:4ad3:: with SMTP id x202mr16489643qka.362.1574055026885;
        Sun, 17 Nov 2019 21:30:26 -0800 (PST)
Received: from redhat.com (bzq-79-176-6-42.red.bezeqint.net. [79.176.6.42])
        by smtp.gmail.com with ESMTPSA id w5sm7935124qkf.43.2019.11.17.21.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2019 21:30:26 -0800 (PST)
Date:   Mon, 18 Nov 2019 00:30:21 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Wei Wang <wei.w.wang@intel.com>
Cc:     Khazhismel Kumykov <khazhy@google.com>, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio_balloon: fix shrinker pages_to_free calculation
Message-ID: <20191118002652-mutt-send-email-mst@kernel.org>
References: <20191115225557.61847-1-khazhy@google.com>
 <5DD21784.8020506@intel.com>
MIME-Version: 1.0
In-Reply-To: <5DD21784.8020506@intel.com>
X-MC-Unique: L3kf4AFEN_yDsXBWCZq3mw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2019 at 12:01:08PM +0800, Wei Wang wrote:
> On 11/16/2019 06:55 AM, Khazhismel Kumykov wrote:
> > To my reading, we're accumulating total freed pages in pages_freed, but
> > subtracting it every iteration from pages_to_free, meaning we'll count
> > earlier iterations multiple times, freeing fewer pages than expected.
> > Just accumulate in pages_freed, and compare to pages_to_free.
>=20
> Not sure about the above. But the following unit mismatch is a good captu=
re,
> thanks!
>=20
> >=20
> > There's also a unit mismatch, where pages_to_free seems to be virtio
> > balloon pages, and pages_freed is system pages (We divide by
> > VIRTIO_BALLOON_PAGES_PER_PAGE), so sutracting pages_freed from
> > pages_to_free may result in freeing too much.
> >=20
> > There also seems to be a mismatch between shrink_free_pages() and
> > shrink_balloon_pages(), where in both pages_to_free is given as # of
> > virtio pages to free, but free_pages() returns virtio pages, and
> > balloon_pages returns system pages.
> >=20
> > (For 4K PAGE_SIZE, this mismatch wouldn't be noticed since
> > VIRTIO_BALLOON_PAGES_PER_PAGE would be 1)
> >=20
> > Have both return virtio pages, and divide into system pages when
> > returning from shrinker_scan()
>=20
> Sounds good.
>=20
> >=20
> > Fixes: 71994620bb25 ("virtio_balloon: replace oom notifier with shrinke=
r")
> > Cc: Wei Wang <wei.w.wang@intel.com>
> > Signed-off-by: Khazhismel Kumykov <khazhy@google.com>
> > ---
> >=20
> > Tested this under memory pressure conditions and the shrinker seemed to
> > shrink.
> >=20
> >   drivers/virtio/virtio_balloon.c | 11 ++++-------
> >   1 file changed, 4 insertions(+), 7 deletions(-)
> >=20
> > diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_ba=
lloon.c
> > index 226fbb995fb0..7951ece3fe24 100644
> > --- a/drivers/virtio/virtio_balloon.c
> > +++ b/drivers/virtio/virtio_balloon.c
> > @@ -782,11 +782,8 @@ static unsigned long shrink_balloon_pages(struct v=
irtio_balloon *vb,
> >   =09 * VIRTIO_BALLOON_ARRAY_PFNS_MAX balloon pages, so we call it
> >   =09 * multiple times to deflate pages till reaching pages_to_free.
> >   =09 */
> > -=09while (vb->num_pages && pages_to_free) {
> > -=09=09pages_freed +=3D leak_balloon(vb, pages_to_free) /
> > -=09=09=09=09=09VIRTIO_BALLOON_PAGES_PER_PAGE;
> > -=09=09pages_to_free -=3D pages_freed;
> > -=09}
> > +=09while (vb->num_pages && pages_to_free > pages_freed)
> > +=09=09pages_freed +=3D leak_balloon(vb, pages_to_free - pages_freed);
> >   =09update_balloon_size(vb);
> >   =09return pages_freed;
> > @@ -805,11 +802,11 @@ static unsigned long virtio_balloon_shrinker_scan=
(struct shrinker *shrinker,
> >   =09=09pages_freed =3D shrink_free_pages(vb, pages_to_free);
>=20
> We also need a fix here then:
>=20
> pages_freed =3D shrink_free_pages(vb, sc->nr_to_scan) *
> VIRTIO_BALLOON_PAGES_PER_PAGE;

No let's do accounting in pages please. virtio page is a legacy
thing we just did not fix it in time to get rid of it by now.

>=20
> Btw, there is another mistake, in virtio_balloon_shrinker_count:
>=20
> -       count +=3D vb->num_free_page_blocks >> VIRTIO_BALLOON_FREE_PAGE_O=
RDER;
> +      count +=3D vb->num_free_page_blocks << VIRTIO_BALLOON_FREE_PAGE_OR=
DER;
>=20
> You may want to include it in this fix patch as well.

OMG. should be a separate patch.
But really this just shows why shifts are such a bad idea.

Let's define
VIRTIO_BALLOON_PAGES_PER_FREE_PAGE

and use it with * and / consistently instead of shifts.


> Best,
> Wei
>=20

