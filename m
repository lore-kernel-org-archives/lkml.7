Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA5C6C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 11:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C26F2067D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 11:37:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I08wSkKe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbfKSLhc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 06:37:32 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:53607 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727557AbfKSLhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 06:37:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574163451;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AqfOLq+nyNFVNclQoFJfwo/6ikJjrtcK+qfEl5kbGec=;
        b=I08wSkKeGi8rNFLIzaQ/xWejD6Vlzlf9Q4wWeOCV2e1A13TirwfNHPX0YF36zNgssGexZT
        OSjGKFUoDWUGYF8eIOK+hNPHc1WIAKk53ypgiwY/h1qdH5Kh21QECHVYIC7YIzyb9cF9tV
        bdb6SArx3Mw64RiS0AvERHYZvqXxb+c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389-Q9KAV2JMMI6J1UrvZRFU9A-1; Tue, 19 Nov 2019 06:37:27 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CCB74107ACCC;
        Tue, 19 Nov 2019 11:37:25 +0000 (UTC)
Received: from [10.36.117.126] (ovpn-117-126.ams2.redhat.com [10.36.117.126])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4C99B6056B;
        Tue, 19 Nov 2019 11:37:21 +0000 (UTC)
Subject: Re: [PATCH 1/2] virtio_balloon: name cleanups
To:     "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Wei Wang <wei.w.wang@intel.com>,
        Khazhismel Kumykov <khazhy@google.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
References: <20191119102838.39380-1-mst@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <adb64e36-777a-c63d-7de2-9b53dabc334c@redhat.com>
Date:   Tue, 19 Nov 2019 12:37:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191119102838.39380-1-mst@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: Q9KAV2JMMI6J1UrvZRFU9A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.11.19 11:29, Michael S. Tsirkin wrote:
> free_page_order is a confusing name. It's not a page order
> actually, it's the order of the block of memory we are hinting.
> Rename to hint_block_order. Also, rename SIZE to BYTES
> to make it clear it's the block size in bytes.
>=20
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>   drivers/virtio/virtio_balloon.c | 24 ++++++++++++------------
>   1 file changed, 12 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_ball=
oon.c
> index 65df40f261ab..b6a95cd28d9f 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -32,10 +32,10 @@
>   #define VIRTIO_BALLOON_FREE_PAGE_ALLOC_FLAG (__GFP_NORETRY | __GFP_NOWA=
RN | \
>   =09=09=09=09=09     __GFP_NOMEMALLOC)
>   /* The order of free page blocks to report to host */
> -#define VIRTIO_BALLOON_FREE_PAGE_ORDER (MAX_ORDER - 1)
> +#define VIRTIO_BALLOON_HINT_BLOCK_ORDER (MAX_ORDER - 1)
>   /* The size of a free page block in bytes */
> -#define VIRTIO_BALLOON_FREE_PAGE_SIZE \
> -=09(1 << (VIRTIO_BALLOON_FREE_PAGE_ORDER + PAGE_SHIFT))
> +#define VIRTIO_BALLOON_HINT_BLOCK_BYTES \
> +=09(1 << (VIRTIO_BALLOON_HINT_BLOCK_ORDER + PAGE_SHIFT))
>  =20
>   #ifdef CONFIG_BALLOON_COMPACTION
>   static struct vfsmount *balloon_mnt;
> @@ -380,7 +380,7 @@ static unsigned long return_free_pages_to_mm(struct v=
irtio_balloon *vb,
>   =09=09if (!page)
>   =09=09=09break;
>   =09=09free_pages((unsigned long)page_address(page),
> -=09=09=09   VIRTIO_BALLOON_FREE_PAGE_ORDER);
> +=09=09=09   VIRTIO_BALLOON_HINT_BLOCK_ORDER);
>   =09}
>   =09vb->num_free_page_blocks -=3D num_returned;
>   =09spin_unlock_irq(&vb->free_page_list_lock);
> @@ -582,7 +582,7 @@ static int get_free_page_and_send(struct virtio_ballo=
on *vb)
>   =09=09;
>  =20
>   =09page =3D alloc_pages(VIRTIO_BALLOON_FREE_PAGE_ALLOC_FLAG,
> -=09=09=09   VIRTIO_BALLOON_FREE_PAGE_ORDER);
> +=09=09=09   VIRTIO_BALLOON_HINT_BLOCK_ORDER);
>   =09/*
>   =09 * When the allocation returns NULL, it indicates that we have got a=
ll
>   =09 * the possible free pages, so return -EINTR to stop.
> @@ -591,13 +591,13 @@ static int get_free_page_and_send(struct virtio_bal=
loon *vb)
>   =09=09return -EINTR;
>  =20
>   =09p =3D page_address(page);
> -=09sg_init_one(&sg, p, VIRTIO_BALLOON_FREE_PAGE_SIZE);
> +=09sg_init_one(&sg, p, VIRTIO_BALLOON_HINT_BLOCK_BYTES);
>   =09/* There is always 1 entry reserved for the cmd id to use. */
>   =09if (vq->num_free > 1) {
>   =09=09err =3D virtqueue_add_inbuf(vq, &sg, 1, p, GFP_KERNEL);
>   =09=09if (unlikely(err)) {
>   =09=09=09free_pages((unsigned long)p,
> -=09=09=09=09   VIRTIO_BALLOON_FREE_PAGE_ORDER);
> +=09=09=09=09   VIRTIO_BALLOON_HINT_BLOCK_ORDER);
>   =09=09=09return err;
>   =09=09}
>   =09=09virtqueue_kick(vq);
> @@ -610,7 +610,7 @@ static int get_free_page_and_send(struct virtio_ballo=
on *vb)
>   =09=09 * The vq has no available entry to add this page block, so
>   =09=09 * just free it.
>   =09=09 */
> -=09=09free_pages((unsigned long)p, VIRTIO_BALLOON_FREE_PAGE_ORDER);
> +=09=09free_pages((unsigned long)p, VIRTIO_BALLOON_HINT_BLOCK_ORDER);
>   =09}
>  =20
>   =09return 0;
> @@ -765,11 +765,11 @@ static unsigned long shrink_free_pages(struct virti=
o_balloon *vb,
>   =09unsigned long blocks_to_free, blocks_freed;
>  =20
>   =09pages_to_free =3D round_up(pages_to_free,
> -=09=09=09=09 1 << VIRTIO_BALLOON_FREE_PAGE_ORDER);
> -=09blocks_to_free =3D pages_to_free >> VIRTIO_BALLOON_FREE_PAGE_ORDER;
> +=09=09=09=09 1 << VIRTIO_BALLOON_HINT_BLOCK_ORDER);
> +=09blocks_to_free =3D pages_to_free >> VIRTIO_BALLOON_HINT_BLOCK_ORDER;
>   =09blocks_freed =3D return_free_pages_to_mm(vb, blocks_to_free);
>  =20
> -=09return blocks_freed << VIRTIO_BALLOON_FREE_PAGE_ORDER;
> +=09return blocks_freed << VIRTIO_BALLOON_HINT_BLOCK_ORDER;
>   }
>  =20
>   static unsigned long leak_balloon_pages(struct virtio_balloon *vb,
> @@ -825,7 +825,7 @@ static unsigned long virtio_balloon_shrinker_count(st=
ruct shrinker *shrinker,
>   =09unsigned long count;
>  =20
>   =09count =3D vb->num_pages / VIRTIO_BALLOON_PAGES_PER_PAGE;
> -=09count +=3D vb->num_free_page_blocks << VIRTIO_BALLOON_FREE_PAGE_ORDER=
;
> +=09count +=3D vb->num_free_page_blocks << VIRTIO_BALLOON_HINT_BLOCK_ORDE=
R;
>  =20
>   =09return count;
>   }
>=20

Reviewed-by: David Hildenbrand <david@redhat.com>

--=20

Thanks,

David / dhildenb

