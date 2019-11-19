Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92EFFC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 11:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67CBC20679
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 11:38:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ORBe/pc8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbfKSLiQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 06:38:16 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:51071 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727638AbfKSLiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 06:38:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574163494;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XtH9WCU+QMMrjUxeLM+n4es1zZ2p4ixU1bds8G44OHQ=;
        b=ORBe/pc8j49nWcZ1btMNJxXzTrGrJvkSEEjJaMcCeaOE9/7KzZZ1J3+AMVYO7PLDeqsMNo
        pcH2IrnMbS3RWdABU+IuxGBh11Xhs26194MyMHFgD6VKf+jVwbFSvJwBhTHblB/gjS3Y1B
        PfCo/m4DjMfrsIRy5kXoj7saQi99ezE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-10-NNck5YUJN6CeOWTDy4tA8g-1; Tue, 19 Nov 2019 06:38:11 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 35DEB1883523;
        Tue, 19 Nov 2019 11:38:10 +0000 (UTC)
Received: from [10.36.117.126] (ovpn-117-126.ams2.redhat.com [10.36.117.126])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2755060251;
        Tue, 19 Nov 2019 11:38:05 +0000 (UTC)
Subject: Re: [PATCH 2/2] virtio_balloon: divide/multiply instead of shifts
To:     "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Wei Wang <wei.w.wang@intel.com>,
        Khazhismel Kumykov <khazhy@google.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
References: <20191119102838.39380-1-mst@redhat.com>
 <20191119102838.39380-2-mst@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <328b00e2-d2ac-7efb-a3d9-a6e9933d85a8@redhat.com>
Date:   Tue, 19 Nov 2019 12:38:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191119102838.39380-2-mst@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: NNck5YUJN6CeOWTDy4tA8g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.11.19 11:29, Michael S. Tsirkin wrote:
> We managed to get confused about the shift direction at least once.
> Let's switch to division/multiplcation instead. Add a number of pages
> macro for this purpose.  We still keep the order macro around too since
> this is what alloc/free pages want.
>=20
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>   drivers/virtio/virtio_balloon.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_ball=
oon.c
> index b6a95cd28d9f..dc1ebd638e9b 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -36,6 +36,7 @@
>   /* The size of a free page block in bytes */
>   #define VIRTIO_BALLOON_HINT_BLOCK_BYTES \
>   =09(1 << (VIRTIO_BALLOON_HINT_BLOCK_ORDER + PAGE_SHIFT))
> +#define VIRTIO_BALLOON_HINT_BLOCK_PAGES (1 << VIRTIO_BALLOON_HINT_BLOCK_=
ORDER)
>  =20
>   #ifdef CONFIG_BALLOON_COMPACTION
>   static struct vfsmount *balloon_mnt;
> @@ -765,11 +766,11 @@ static unsigned long shrink_free_pages(struct virti=
o_balloon *vb,
>   =09unsigned long blocks_to_free, blocks_freed;
>  =20
>   =09pages_to_free =3D round_up(pages_to_free,
> -=09=09=09=09 1 << VIRTIO_BALLOON_HINT_BLOCK_ORDER);
> -=09blocks_to_free =3D pages_to_free >> VIRTIO_BALLOON_HINT_BLOCK_ORDER;
> +=09=09=09=09 VIRTIO_BALLOON_HINT_BLOCK_PAGES);
> +=09blocks_to_free =3D pages_to_free / VIRTIO_BALLOON_HINT_BLOCK_PAGES;
>   =09blocks_freed =3D return_free_pages_to_mm(vb, blocks_to_free);
>  =20
> -=09return blocks_freed << VIRTIO_BALLOON_HINT_BLOCK_ORDER;
> +=09return blocks_freed * VIRTIO_BALLOON_HINT_BLOCK_PAGES;
>   }
>  =20
>   static unsigned long leak_balloon_pages(struct virtio_balloon *vb,
> @@ -825,7 +826,7 @@ static unsigned long virtio_balloon_shrinker_count(st=
ruct shrinker *shrinker,
>   =09unsigned long count;
>  =20
>   =09count =3D vb->num_pages / VIRTIO_BALLOON_PAGES_PER_PAGE;
> -=09count +=3D vb->num_free_page_blocks << VIRTIO_BALLOON_HINT_BLOCK_ORDE=
R;
> +=09count +=3D vb->num_free_page_blocks * VIRTIO_BALLOON_HINT_BLOCK_PAGES=
;
>  =20
>   =09return count;
>   }
>=20

Reviewed-by: David Hildenbrand <david@redhat.com>

--=20

Thanks,

David / dhildenb

