Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59C89C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 10:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B52722304
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 10:29:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pqqwx2ql"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbfKSK3f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 05:29:35 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45626 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725798AbfKSK3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 05:29:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574159373;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=jW5Dz+o+xuIGq2ArbyLkHFv3uRr0wg1+We7kw+1rV8M=;
        b=Pqqwx2qlnRQnb4swnvk+KNXSlHm7Hq/zo96+UqaxnNdrPwpJTqNtyEBaT5pLuenCTsgUW5
        qZxZvETtZ9xp3SG7iJwEERU4kSHvR3Iw2VmKUbJhztII7D+7cIqDCx6KeQLu9cGeNM1/K9
        TIYNLDX2PcyMf3JJYt1pTQo3jKM0HwU=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-115-ruevCaujNlet65Tqk40HSw-1; Tue, 19 Nov 2019 05:29:32 -0500
Received: by mail-qt1-f198.google.com with SMTP id g5so14333751qtc.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 02:29:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=UaDRJaYlebRLtutZ30jQ1UpCX9ctfAcr8PbCPatRjtU=;
        b=sRnJ3JN256fLXhZVZiuAeJSWHeREbNh+D2WbRPN3BPzTQukidmI096D6Pos7TDCOdZ
         WdF0F4ndIjattH8EZgdrqq6x5CHX2Yl06eeind/SzYXeQHY21QaFO08esUmpSOvgO+xk
         QeugWFWCQ0Ilr/UqgFls4C6F3NV8R0N2bSJ+9kQfDMsy+bJWKW1ueGuhaRCk7ebuSR/R
         lIsWfdZQQFoMg5oCJc1WnWZZVatBc8nPQ+oGViQjZI0BsBrC+0rKuT3zKeAeIc6d05dq
         QkDfTHC15Hz3VBgmtAROep4T/FzyNMYbQcgNgYTsQzfMuohcf9aHsHXjhUZlsj7wVaqc
         eD/A==
X-Gm-Message-State: APjAAAWyzWOD7CZJb6tii0vu+zApg5HslynpRoW3kBWxvOPAxM5NLjqE
        99kiZiDdW3kp0yZCx/jE4O7QStuWiHzQvKApz9KxGjII2IhrbnlZo8BWVGNt22Vn9cfLiHBvVZC
        xAKAG7LEBkeobbtUihyjEVprx
X-Received: by 2002:ac8:1403:: with SMTP id k3mr31582626qtj.58.1574159371681;
        Tue, 19 Nov 2019 02:29:31 -0800 (PST)
X-Google-Smtp-Source: APXvYqzlLIzVfNNbEH1KNkfmNs0x2CUd+bQprenjynz/FEnQ+53cqpD5Sgh5sZ6QQ4lDs8ylNaPJjw==
X-Received: by 2002:ac8:1403:: with SMTP id k3mr31582607qtj.58.1574159371423;
        Tue, 19 Nov 2019 02:29:31 -0800 (PST)
Received: from redhat.com (bzq-79-176-6-42.red.bezeqint.net. [79.176.6.42])
        by smtp.gmail.com with ESMTPSA id w2sm9885311qkw.31.2019.11.19.02.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 02:29:30 -0800 (PST)
Date:   Tue, 19 Nov 2019 05:29:26 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Wei Wang <wei.w.wang@intel.com>,
        Khazhismel Kumykov <khazhy@google.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH 1/2] virtio_balloon: name cleanups
Message-ID: <20191119102838.39380-1-mst@redhat.com>
MIME-Version: 1.0
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
X-MC-Unique: ruevCaujNlet65Tqk40HSw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

free_page_order is a confusing name. It's not a page order
actually, it's the order of the block of memory we are hinting.
Rename to hint_block_order. Also, rename SIZE to BYTES
to make it clear it's the block size in bytes.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_balloon.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloo=
n.c
index 65df40f261ab..b6a95cd28d9f 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -32,10 +32,10 @@
 #define VIRTIO_BALLOON_FREE_PAGE_ALLOC_FLAG (__GFP_NORETRY | __GFP_NOWARN =
| \
 =09=09=09=09=09     __GFP_NOMEMALLOC)
 /* The order of free page blocks to report to host */
-#define VIRTIO_BALLOON_FREE_PAGE_ORDER (MAX_ORDER - 1)
+#define VIRTIO_BALLOON_HINT_BLOCK_ORDER (MAX_ORDER - 1)
 /* The size of a free page block in bytes */
-#define VIRTIO_BALLOON_FREE_PAGE_SIZE \
-=09(1 << (VIRTIO_BALLOON_FREE_PAGE_ORDER + PAGE_SHIFT))
+#define VIRTIO_BALLOON_HINT_BLOCK_BYTES \
+=09(1 << (VIRTIO_BALLOON_HINT_BLOCK_ORDER + PAGE_SHIFT))
=20
 #ifdef CONFIG_BALLOON_COMPACTION
 static struct vfsmount *balloon_mnt;
@@ -380,7 +380,7 @@ static unsigned long return_free_pages_to_mm(struct vir=
tio_balloon *vb,
 =09=09if (!page)
 =09=09=09break;
 =09=09free_pages((unsigned long)page_address(page),
-=09=09=09   VIRTIO_BALLOON_FREE_PAGE_ORDER);
+=09=09=09   VIRTIO_BALLOON_HINT_BLOCK_ORDER);
 =09}
 =09vb->num_free_page_blocks -=3D num_returned;
 =09spin_unlock_irq(&vb->free_page_list_lock);
@@ -582,7 +582,7 @@ static int get_free_page_and_send(struct virtio_balloon=
 *vb)
 =09=09;
=20
 =09page =3D alloc_pages(VIRTIO_BALLOON_FREE_PAGE_ALLOC_FLAG,
-=09=09=09   VIRTIO_BALLOON_FREE_PAGE_ORDER);
+=09=09=09   VIRTIO_BALLOON_HINT_BLOCK_ORDER);
 =09/*
 =09 * When the allocation returns NULL, it indicates that we have got all
 =09 * the possible free pages, so return -EINTR to stop.
@@ -591,13 +591,13 @@ static int get_free_page_and_send(struct virtio_ballo=
on *vb)
 =09=09return -EINTR;
=20
 =09p =3D page_address(page);
-=09sg_init_one(&sg, p, VIRTIO_BALLOON_FREE_PAGE_SIZE);
+=09sg_init_one(&sg, p, VIRTIO_BALLOON_HINT_BLOCK_BYTES);
 =09/* There is always 1 entry reserved for the cmd id to use. */
 =09if (vq->num_free > 1) {
 =09=09err =3D virtqueue_add_inbuf(vq, &sg, 1, p, GFP_KERNEL);
 =09=09if (unlikely(err)) {
 =09=09=09free_pages((unsigned long)p,
-=09=09=09=09   VIRTIO_BALLOON_FREE_PAGE_ORDER);
+=09=09=09=09   VIRTIO_BALLOON_HINT_BLOCK_ORDER);
 =09=09=09return err;
 =09=09}
 =09=09virtqueue_kick(vq);
@@ -610,7 +610,7 @@ static int get_free_page_and_send(struct virtio_balloon=
 *vb)
 =09=09 * The vq has no available entry to add this page block, so
 =09=09 * just free it.
 =09=09 */
-=09=09free_pages((unsigned long)p, VIRTIO_BALLOON_FREE_PAGE_ORDER);
+=09=09free_pages((unsigned long)p, VIRTIO_BALLOON_HINT_BLOCK_ORDER);
 =09}
=20
 =09return 0;
@@ -765,11 +765,11 @@ static unsigned long shrink_free_pages(struct virtio_=
balloon *vb,
 =09unsigned long blocks_to_free, blocks_freed;
=20
 =09pages_to_free =3D round_up(pages_to_free,
-=09=09=09=09 1 << VIRTIO_BALLOON_FREE_PAGE_ORDER);
-=09blocks_to_free =3D pages_to_free >> VIRTIO_BALLOON_FREE_PAGE_ORDER;
+=09=09=09=09 1 << VIRTIO_BALLOON_HINT_BLOCK_ORDER);
+=09blocks_to_free =3D pages_to_free >> VIRTIO_BALLOON_HINT_BLOCK_ORDER;
 =09blocks_freed =3D return_free_pages_to_mm(vb, blocks_to_free);
=20
-=09return blocks_freed << VIRTIO_BALLOON_FREE_PAGE_ORDER;
+=09return blocks_freed << VIRTIO_BALLOON_HINT_BLOCK_ORDER;
 }
=20
 static unsigned long leak_balloon_pages(struct virtio_balloon *vb,
@@ -825,7 +825,7 @@ static unsigned long virtio_balloon_shrinker_count(stru=
ct shrinker *shrinker,
 =09unsigned long count;
=20
 =09count =3D vb->num_pages / VIRTIO_BALLOON_PAGES_PER_PAGE;
-=09count +=3D vb->num_free_page_blocks << VIRTIO_BALLOON_FREE_PAGE_ORDER;
+=09count +=3D vb->num_free_page_blocks << VIRTIO_BALLOON_HINT_BLOCK_ORDER;
=20
 =09return count;
 }
--=20
MST

