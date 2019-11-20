Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DC8FC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 07:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61340223CA
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 07:18:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tq3JfRQN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbfKTHSh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 02:18:37 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41660 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725854AbfKTHSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 02:18:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574234315;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=W5V+O9gmZmZfkPIRNHngKJxE0tcWdwxG9VlDuUjkvQQ=;
        b=Tq3JfRQN9LDB/dAmeNzFzoP0YYixY6SJt5e2fEvQn5abGakNQ9rXedfARKyMxLJlNyWlPM
        +fYoMNQAHGIXAO2Tpu4Ae0CV/w+mHxXcihUmzcgDNixPu+/NPGQKe/7jsz/71geOrsu0py
        Vriser7RwcjTHiCnKGtcQW+etKwTIOA=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-430-nDqtpWFnN6yA-8WlhVfjMQ-1; Wed, 20 Nov 2019 02:18:34 -0500
Received: by mail-qt1-f199.google.com with SMTP id l8so16497938qtq.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 23:18:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=/7TSABzoNp6eHddBC5uN4DXm13UYCB+ljXB7Oz+XClw=;
        b=SPAHiNHQLTzX1XB5sNTEBig/JPWRFzlqBngMlkGJn3L2haV0iyUFpvsOQSrSffl5Rw
         ww55yI0ND2BrBU2hwgDr6dfvOg/+3o0vOfQOULGY3YJtrUEq69B9JDB9ltwGfWsRNl51
         UFrYDEXe642MEtTf56Npzjzj4XaoOkn2ngj5sixika1/tnQQ6qh8jL8PeKHdo1UCSX9g
         12itiVUupWPYfsGGAnqVt9nVw8ypyztYDanzBY4ca+Cv+P2eRpsB8vMTY8Mg8g6xj3N8
         LlsdHVEQ/RTIXT1l7kQEOaF5sh9JsKr1AgqoAYCEM6avOz5sJSrvOALjdWZoz4Pk+3og
         r7Cw==
X-Gm-Message-State: APjAAAXw/J0a9wNu7TQfMq21nhFkcTz99/7GbDlM+6rVM0gghDG3jUWU
        W5xMKPOnovtF73aOzVQUI9eRDoAbKTPAyOUyN0D08sT6p0VVUXm2cVQ0h/jYqzsww9o2so4zih1
        jgc31p9zpVTWe628kObnyENeQ
X-Received: by 2002:ac8:3f5d:: with SMTP id w29mr1248683qtk.3.1574234313548;
        Tue, 19 Nov 2019 23:18:33 -0800 (PST)
X-Google-Smtp-Source: APXvYqz5jMiMHCjuuPZL6hA/Fs7MRPu+sohiiFkku83TRq+yvrIOdEZoZfPYOEXEEz2NXkPaVupvRA==
X-Received: by 2002:ac8:3f5d:: with SMTP id w29mr1248663qtk.3.1574234313192;
        Tue, 19 Nov 2019 23:18:33 -0800 (PST)
Received: from redhat.com (bzq-79-176-6-42.red.bezeqint.net. [79.176.6.42])
        by smtp.gmail.com with ESMTPSA id u7sm11450091qkm.127.2019.11.19.23.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 23:18:32 -0800 (PST)
Date:   Wed, 20 Nov 2019 02:18:27 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Khazhismel Kumykov <khazhy@google.com>,
        Wei Wang <wei.w.wang@intel.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v2] virtio_balloon: fix shrinker scan number of pages
Message-ID: <20191120071733.4035-1-mst@redhat.com>
MIME-Version: 1.0
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
X-MC-Unique: nDqtpWFnN6yA-8WlhVfjMQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

virtio_balloon_shrinker_scan should return number of system pages freed,
but because it's calling functions that deal with balloon pages, it gets
confused and sometimes returns the number of balloon pages.

It does not matter practically as the exact number isn't
used, but it seems better to be consistent in case someone
starts using this API.

Further, if we ever tried to iteratively leak pages as
virtio_balloon_shrinker_scan tries to do, we'd run into issues - this is
because freed_pages was accumulating total freed pages, but was also
subtracted on each iteration from pages_to_free, which can result in
either leaking less memory than we were supposed to free, or more if
pages_to_free underruns.

On a system with 4K pages we are lucky that we are never asked to leak
more than 128 pages while we can leak up to 256 at a time,
but it looks like a real issue for systems with page size !=3D 4K.

Fixes: 71994620bb25 ("virtio_balloon: replace oom notifier with shrinker")
Reported-by: Khazhismel Kumykov <khazhy@google.com>
Reviewed-by: Wei Wang <wei.w.wang@intel.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

Changes from v1:
=09address comment by Khazhismel Kumykov : don't leak more pages than neede=
d

 drivers/virtio/virtio_balloon.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloo=
n.c
index 226fbb995fb0..51134f9a3ee7 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -772,6 +772,13 @@ static unsigned long shrink_free_pages(struct virtio_b=
alloon *vb,
 =09return blocks_freed << VIRTIO_BALLOON_FREE_PAGE_ORDER;
 }
=20
+static unsigned long leak_balloon_pages(struct virtio_balloon *vb,
+                                          unsigned long pages_to_free)
+{
+=09return leak_balloon(vb, pages_to_free * VIRTIO_BALLOON_PAGES_PER_PAGE) =
/
+=09=09VIRTIO_BALLOON_PAGES_PER_PAGE;
+}
+
 static unsigned long shrink_balloon_pages(struct virtio_balloon *vb,
 =09=09=09=09=09  unsigned long pages_to_free)
 {
@@ -782,11 +789,10 @@ static unsigned long shrink_balloon_pages(struct virt=
io_balloon *vb,
 =09 * VIRTIO_BALLOON_ARRAY_PFNS_MAX balloon pages, so we call it
 =09 * multiple times to deflate pages till reaching pages_to_free.
 =09 */
-=09while (vb->num_pages && pages_to_free) {
-=09=09pages_freed +=3D leak_balloon(vb, pages_to_free) /
-=09=09=09=09=09VIRTIO_BALLOON_PAGES_PER_PAGE;
-=09=09pages_to_free -=3D pages_freed;
-=09}
+=09while (vb->num_pages && pages_freed < pages_to_free)
+=09=09pages_freed +=3D leak_balloon_pages(vb,
+=09=09=09=09=09=09  pages_to_free - pages_freed);
+
 =09update_balloon_size(vb);
=20
 =09return pages_freed;
@@ -799,7 +805,7 @@ static unsigned long virtio_balloon_shrinker_scan(struc=
t shrinker *shrinker,
 =09struct virtio_balloon *vb =3D container_of(shrinker,
 =09=09=09=09=09struct virtio_balloon, shrinker);
=20
-=09pages_to_free =3D sc->nr_to_scan * VIRTIO_BALLOON_PAGES_PER_PAGE;
+=09pages_to_free =3D sc->nr_to_scan;
=20
 =09if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT))
 =09=09pages_freed =3D shrink_free_pages(vb, pages_to_free);
--=20
MST

