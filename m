Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 405F6C432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 05:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 088712071E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 05:26:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hwvufP+E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbfKRF0y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 00:26:54 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48602 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725208AbfKRF0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 00:26:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574054812;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wT/tFiQiiY7X2t6DQv6QoaQE5V4zk2RaDzStSiYHaOI=;
        b=hwvufP+E/M/Y+++fUomg/O7Ymfk0a0RKDtpq80cSGZthT6Rswa8wImNoXQbqqkJhO/LnKq
        zGro3PMJbwt+SJZN2QjJFQUPccyTZWYbvliuufbuviQWyND5Ku80BEMCw4XBpgR21H5DwD
        agpx5WkLLnKq8mxVpmUmTdmDBS9oRWg=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-373-7Q8ndgnxOJixF57aS8lNBw-1; Mon, 18 Nov 2019 00:26:49 -0500
Received: by mail-qv1-f69.google.com with SMTP id w5so11779888qvp.13
        for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2019 21:26:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=o6UWmVuZQlRLatPss5FOBMMHREFIt3Z5O2uO/CkXcGw=;
        b=gKAMNhPcuqtUchsiF9jKF1SFYfMHZJhYAbRNz+Tv03JUyeNB7BGCDG502yHaTCr7fP
         l0Egq71+WfrMLx5WRcmERZEiP1nwCzHSl4a1hgZEh4wMBzVFFI43fjceQ/TDzWINl45b
         iKYZPtkqvgdiU2nKMnme9uZoP0SaS/5KF4WxMy+b6Oe3LEdO+h+Fmh24elMieT8G90fS
         ElPRNT8XrvuqVR4XXtjzt29d2ctmvxz1jq1n4Z+sxYPGc16CDX4Ix4irvbcxhyQpL661
         jUXVKZm0P4PiiCy971H8TLwr+wLoSF4asjoctZbRL8lZKnLQJg/TEyMwqiaZb3wmltIM
         vTvw==
X-Gm-Message-State: APjAAAWTVlKYuaLtM6vp95hH9zpX8C30ff9uPn4MSiuXRK0Ci9wR4IXB
        HkZpQggyb6EoR8xgceV/aLpnfqC1Za+RHBFj3yXixeebFJ4a+W4p1cv4BKVQh/wzFad6j6xYVp5
        rtvJw187tUN0HYd/hYszTp8cW
X-Received: by 2002:a37:4906:: with SMTP id w6mr11390550qka.82.1574054807984;
        Sun, 17 Nov 2019 21:26:47 -0800 (PST)
X-Google-Smtp-Source: APXvYqwHoBOUrkX/VFwIW8J+asV75LO9ssSNgTY5AObB4uMJhPJIdrtAgjqVdJcewnSoXhBQ1jg5pg==
X-Received: by 2002:a37:4906:: with SMTP id w6mr11390543qka.82.1574054807565;
        Sun, 17 Nov 2019 21:26:47 -0800 (PST)
Received: from redhat.com (bzq-79-176-6-42.red.bezeqint.net. [79.176.6.42])
        by smtp.gmail.com with ESMTPSA id n185sm7941982qkd.32.2019.11.17.21.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2019 21:26:46 -0800 (PST)
Date:   Mon, 18 Nov 2019 00:26:41 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Khazhismel Kumykov <khazhy@google.com>
Cc:     jasowang@redhat.com, wei.w.wang@intel.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio_balloon: fix shrinker pages_to_free calculation
Message-ID: <20191118000214-mutt-send-email-mst@kernel.org>
References: <20191115225557.61847-1-khazhy@google.com>
MIME-Version: 1.0
In-Reply-To: <20191115225557.61847-1-khazhy@google.com>
X-MC-Unique: 7Q8ndgnxOJixF57aS8lNBw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Question is, does all this cause any bugs?

I'm not against cleaning this up, not at all, but we need to know the
impact.

On Fri, Nov 15, 2019 at 02:55:57PM -0800, Khazhismel Kumykov wrote:
> To my reading, we're accumulating total freed pages in pages_freed, but
> subtracting it every iteration from pages_to_free, meaning we'll count
> earlier iterations multiple times, freeing fewer pages than expected.
> Just accumulate in pages_freed, and compare to pages_to_free.

For nr to scan: yes we scan less objects but that can only happen
if the first pass does not free enough. And 1st pass can pass
256 entries, and my reading of code in do_shrink_slab
is that it passes only as much as
#define SHRINK_BATCH 128

so it looks like this never triggers in practice - right?


>=20
> There's also a unit mismatch,

So two unrelated issues, I think we want two patches.


> where pages_to_free seems to be virtio
> balloon pages, and pages_freed is system pages (We divide by
> VIRTIO_BALLOON_PAGES_PER_PAGE), so sutracting pages_freed from
> pages_to_free may result in freeing too much.

I am inclining to say we should pass in page units.
Free page reporting is all done in units of MAX_ORDER - 1.
Let's not ptopagate the crazy virtio page thing - we hopefully
will add a saner interface to regular balloon too.

something like the below?

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloo=
n.c
index 226fbb995fb0..128440826b55 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -783,8 +783,8 @@ static unsigned long shrink_balloon_pages(struct virtio=
_balloon *vb,
 =09 * multiple times to deflate pages till reaching pages_to_free.
 =09 */
 =09while (vb->num_pages && pages_to_free) {
-=09=09pages_freed +=3D leak_balloon(vb, pages_to_free) /
-=09=09=09=09=09VIRTIO_BALLOON_PAGES_PER_PAGE;
+=09=09pages_freed +=3D leak_balloon(vb, pages_to_free *
+=09=09=09=09=09    VIRTIO_BALLOON_PAGES_PER_PAGE);
 =09=09pages_to_free -=3D pages_freed;
 =09}
 =09update_balloon_size(vb);
@@ -799,7 +799,7 @@ static unsigned long virtio_balloon_shrinker_scan(struc=
t shrinker *shrinker,
 =09struct virtio_balloon *vb =3D container_of(shrinker,
 =09=09=09=09=09struct virtio_balloon, shrinker);
=20
-=09pages_to_free =3D sc->nr_to_scan * VIRTIO_BALLOON_PAGES_PER_PAGE;
+=09pages_to_free =3D sc->nr_to_scan;
=20
 =09if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT))
 =09=09pages_freed =3D shrink_free_pages(vb, pages_to_free);


> There also seems to be a mismatch between shrink_free_pages() and
> shrink_balloon_pages(), where in both pages_to_free is given as # of
> virtio pages to free, but free_pages() returns virtio pages, and
> balloon_pages returns system pages.
>=20
> (For 4K PAGE_SIZE, this mismatch wouldn't be noticed since
> VIRTIO_BALLOON_PAGES_PER_PAGE would be 1)

About return value:
The only
use for count_objects I see is:
      freeable =3D shrinker->count_objects(shrinker, shrinkctl);
      if (freeable =3D=3D 0 || freeable =3D=3D SHRINK_EMPTY)
                return freeable;

so units do not matter here.


For scan objects, IIUC they are eventually propagated to
shrink_slab. That in turn is called at two sites.
One ignores the returned value. The other does:


        do {
                struct mem_cgroup *memcg =3D NULL;

                freed =3D 0;
                memcg =3D mem_cgroup_iter(NULL, NULL, NULL);
                do {
                        freed +=3D shrink_slab(GFP_KERNEL, nid, memcg, 0);
                } while ((memcg =3D mem_cgroup_iter(NULL, memcg, NULL)) !=
=3D NULL);
        } while (freed > 10);

so returning a larger than real value because of
double accounting will just make more calls to the scan
function.




> Have both return virtio pages, and divide into system pages when
> returning from shrinker_scan()
>=20
> Fixes: 71994620bb25 ("virtio_balloon: replace oom notifier with shrinker"=
)
> Cc: Wei Wang <wei.w.wang@intel.com>
> Signed-off-by: Khazhismel Kumykov <khazhy@google.com>
> ---
>=20
> Tested this under memory pressure conditions and the shrinker seemed to
> shrink.

And to clarify, did you manage to detect it malfunctioning without the
patch?


>  drivers/virtio/virtio_balloon.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_ball=
oon.c
> index 226fbb995fb0..7951ece3fe24 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -782,11 +782,8 @@ static unsigned long shrink_balloon_pages(struct vir=
tio_balloon *vb,
>  =09 * VIRTIO_BALLOON_ARRAY_PFNS_MAX balloon pages, so we call it
>  =09 * multiple times to deflate pages till reaching pages_to_free.
>  =09 */
> -=09while (vb->num_pages && pages_to_free) {
> -=09=09pages_freed +=3D leak_balloon(vb, pages_to_free) /
> -=09=09=09=09=09VIRTIO_BALLOON_PAGES_PER_PAGE;
> -=09=09pages_to_free -=3D pages_freed;
> -=09}
> +=09while (vb->num_pages && pages_to_free > pages_freed)
> +=09=09pages_freed +=3D leak_balloon(vb, pages_to_free - pages_freed);
>  =09update_balloon_size(vb);
> =20
>  =09return pages_freed;
> @@ -805,11 +802,11 @@ static unsigned long virtio_balloon_shrinker_scan(s=
truct shrinker *shrinker,
>  =09=09pages_freed =3D shrink_free_pages(vb, pages_to_free);
> =20
>  =09if (pages_freed >=3D pages_to_free)
> -=09=09return pages_freed;
> +=09=09return pages_freed / VIRTIO_BALLOON_PAGES_PER_PAGE;
> =20
>  =09pages_freed +=3D shrink_balloon_pages(vb, pages_to_free - pages_freed=
);
> =20
> -=09return pages_freed;
> +=09return pages_freed / VIRTIO_BALLOON_PAGES_PER_PAGE;
>  }
> =20
>  static unsigned long virtio_balloon_shrinker_count(struct shrinker *shri=
nker,
> --=20
> 2.24.0.432.g9d3f5f5b63-goog

