Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2002EC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 11:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E90B92067D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 11:40:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iQ+kY4mP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbfKSLkC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 06:40:02 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:59145 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727925AbfKSLkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 06:40:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574163600;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cmFNb88bWdFl//iagjMME98iS26Hg+AUEoMnldZ9zfk=;
        b=iQ+kY4mPgE/BEB1vdvimGWJgOFMSIJtKcWiUG3VqD3rxb1MRQmuKxurUlO8ODMTccXfwPr
        S2iQ18nnP5pnm3UB4gTJo9n19D7sF9V28VL+PnJBcGlkUCEcBp2ngnAkdg1Qyceos7E/EL
        9y2mNDgltJsI5un0e2FShP+fq6SyGMU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-353-4ztYGj9APj6jDga9DzkeDA-1; Tue, 19 Nov 2019 06:39:57 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C54E11883522;
        Tue, 19 Nov 2019 11:39:55 +0000 (UTC)
Received: from [10.36.117.126] (ovpn-117-126.ams2.redhat.com [10.36.117.126])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0BA8D4D9E1;
        Tue, 19 Nov 2019 11:39:51 +0000 (UTC)
Subject: Re: [PATCH] virtio_balloon: fix shrinker scan number of pages
To:     "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, Khazhismel Kumykov <khazhy@google.com>,
        Wei Wang <wei.w.wang@intel.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
References: <20191119101718.38976-1-mst@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <34c84d6a-d200-c296-39bb-4770bf4517e9@redhat.com>
Date:   Tue, 19 Nov 2019 12:39:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191119101718.38976-1-mst@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: 4ztYGj9APj6jDga9DzkeDA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.11.19 11:17, Michael S. Tsirkin wrote:
> virtio_balloon_shrinker_scan should return number of system pages freed,
> but because it's calling functions that deal with balloon pages, it gets
> confused and sometimes returns the number of balloon pages.
>=20
> It does not matter practically as the exact number isn't
> used, but it seems better to be consistent in case someone
> starts using this API.

If it doesn't matter, why cc: stable?

>=20
> Further, if we ever tried to iteratively leak pages as
> virtio_balloon_shrinker_scan tries to do, we'd run into issues - this is
> because freed_pages was accumulating total freed pages, but was also
> subtracted on each iteration from pages_to_free, which can result in
> either leaking less memory than we were supposed to free, or or more if
> pages_to_free underruns.
>=20
> On a system with 4K pages we are lucky that we are never asked to leak
> more than 128 pages while we can leak up to 256 at a time,
> but it looks like a real issue for systems with page size !=3D 4K.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 71994620bb25 ("virtio_balloon: replace oom notifier with shrinker"=
)
> Reported-by: Khazhismel Kumykov <khazhy@google.com>
> Reviewed-by: Wei Wang <wei.w.wang@intel.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>   drivers/virtio/virtio_balloon.c | 17 +++++++++++------
>   1 file changed, 11 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_ball=
oon.c
> index 226fbb995fb0..7cee05cdf3fb 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -772,6 +772,13 @@ static unsigned long shrink_free_pages(struct virtio=
_balloon *vb,
>   =09return blocks_freed << VIRTIO_BALLOON_FREE_PAGE_ORDER;
>   }
>  =20
> +static unsigned long leak_balloon_pages(struct virtio_balloon *vb,
> +                                          unsigned long pages_to_free)
> +{
> +=09return leak_balloon(vb, pages_to_free * VIRTIO_BALLOON_PAGES_PER_PAGE=
) /
> +=09=09VIRTIO_BALLOON_PAGES_PER_PAGE;
> +}
> +
>   static unsigned long shrink_balloon_pages(struct virtio_balloon *vb,
>   =09=09=09=09=09  unsigned long pages_to_free)
>   {
> @@ -782,11 +789,9 @@ static unsigned long shrink_balloon_pages(struct vir=
tio_balloon *vb,
>   =09 * VIRTIO_BALLOON_ARRAY_PFNS_MAX balloon pages, so we call it
>   =09 * multiple times to deflate pages till reaching pages_to_free.
>   =09 */
> -=09while (vb->num_pages && pages_to_free) {
> -=09=09pages_freed +=3D leak_balloon(vb, pages_to_free) /
> -=09=09=09=09=09VIRTIO_BALLOON_PAGES_PER_PAGE;
> -=09=09pages_to_free -=3D pages_freed;
> -=09}
> +=09while (vb->num_pages && pages_freed < pages_to_free)
> +=09=09pages_freed +=3D leak_balloon_pages(vb, pages_to_free);
> +
>   =09update_balloon_size(vb);
>  =20
>   =09return pages_freed;
> @@ -799,7 +804,7 @@ static unsigned long virtio_balloon_shrinker_scan(str=
uct shrinker *shrinker,
>   =09struct virtio_balloon *vb =3D container_of(shrinker,
>   =09=09=09=09=09struct virtio_balloon, shrinker);
>  =20
> -=09pages_to_free =3D sc->nr_to_scan * VIRTIO_BALLOON_PAGES_PER_PAGE;
> +=09pages_to_free =3D sc->nr_to_scan;
>  =20
>   =09if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT))
>   =09=09pages_freed =3D shrink_free_pages(vb, pages_to_free);
>=20


--=20

Thanks,

David / dhildenb

