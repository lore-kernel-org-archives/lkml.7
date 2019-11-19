Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C9DBC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 10:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5192B208D4
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 10:29:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CTaweVDN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbfKSK3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 05:29:40 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:55816 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725798AbfKSK3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 05:29:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574159378;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=77amoXDxo8ofz+4ayGx8uiP5lWMJfYYOQ/k+hO5dXpA=;
        b=CTaweVDNvdcygOtIZ6x90agqgt39ZvpLSByq9H9GIw78IWyEDhRnsM2R4+F8yRBEXbTMt1
        4HUtYjZ1Dx+4kfda1uTLk7Y42pwZ3jcJimLmyePI7z1Ll6VZtS9I4EhuwAaF0KPUHusNtD
        AanEDnHCpOgLXx0hZFKTB5sIzcfM4Hk=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-74-hhj45PCUOXyHnjMS93OjHA-1; Tue, 19 Nov 2019 05:29:37 -0500
Received: by mail-qt1-f197.google.com with SMTP id v92so14290020qtd.18
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 02:29:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7Tg+D+F/fAw3zm3TLDKDFrbW/cPHm7unwaXfVwzos8E=;
        b=Kp9Rpfksl9BX2k2LQ9F+3eoX1L5R6JTpUN8FyiBvDWI9pVuYlj9Aavd4pziso7U7gv
         5Z929ny8WyfaBwdizTPARtWW4yDapJ7d74bCQu6066/Q9qArWdNT7xbT3MkXtDFi8slX
         3XRELRh/eUARd1KVqsXehrLarQs6H9SX33nUO/++uhuTcARHhEV6FONXuo42K8lul43q
         hhfsGEPNPk3gk30kVJZr2hAFGkxLp7+6QyxqFunkaX7sJfiztGJBkuH/7PDS2q3JApme
         E/6YyKwVnx0APVikVuWy0EaJjIIO9nAON4D0cX8ojESWBckBu4mt1r1yP/v3ZhMSZ32l
         4zvA==
X-Gm-Message-State: APjAAAUFwfW/LlNm2mDb9rphcJHHtJasL95fGeKH1lm7eMJ4Kddw5cH2
        uKSfXaHDAih3TVSqqo288MdsDHxULD1jkI5QG8EybLwAR2QT2DTlSBQ5yNVWIuXl5gbDYBugNef
        S6SmiijabAmm9n1qOnPVJimuQ
X-Received: by 2002:ac8:6f7c:: with SMTP id u28mr31779263qtv.273.1574159376666;
        Tue, 19 Nov 2019 02:29:36 -0800 (PST)
X-Google-Smtp-Source: APXvYqzR+tUKw4NEYui52ImTAE6yNx3fvcJEyX8/qfJSbhyeXrlYvmekz12zTjwlQAzBWXgiolI3Lw==
X-Received: by 2002:ac8:6f7c:: with SMTP id u28mr31779255qtv.273.1574159376524;
        Tue, 19 Nov 2019 02:29:36 -0800 (PST)
Received: from redhat.com (bzq-79-176-6-42.red.bezeqint.net. [79.176.6.42])
        by smtp.gmail.com with ESMTPSA id m65sm11670564qte.54.2019.11.19.02.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 02:29:35 -0800 (PST)
Date:   Tue, 19 Nov 2019 05:29:31 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Wei Wang <wei.w.wang@intel.com>,
        Khazhismel Kumykov <khazhy@google.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH 2/2] virtio_balloon: divide/multiply instead of shifts
Message-ID: <20191119102838.39380-2-mst@redhat.com>
References: <20191119102838.39380-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191119102838.39380-1-mst@redhat.com>
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
X-MC-Unique: hhj45PCUOXyHnjMS93OjHA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We managed to get confused about the shift direction at least once.
Let's switch to division/multiplcation instead. Add a number of pages
macro for this purpose.  We still keep the order macro around too since
this is what alloc/free pages want.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_balloon.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloo=
n.c
index b6a95cd28d9f..dc1ebd638e9b 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -36,6 +36,7 @@
 /* The size of a free page block in bytes */
 #define VIRTIO_BALLOON_HINT_BLOCK_BYTES \
 =09(1 << (VIRTIO_BALLOON_HINT_BLOCK_ORDER + PAGE_SHIFT))
+#define VIRTIO_BALLOON_HINT_BLOCK_PAGES (1 << VIRTIO_BALLOON_HINT_BLOCK_OR=
DER)
=20
 #ifdef CONFIG_BALLOON_COMPACTION
 static struct vfsmount *balloon_mnt;
@@ -765,11 +766,11 @@ static unsigned long shrink_free_pages(struct virtio_=
balloon *vb,
 =09unsigned long blocks_to_free, blocks_freed;
=20
 =09pages_to_free =3D round_up(pages_to_free,
-=09=09=09=09 1 << VIRTIO_BALLOON_HINT_BLOCK_ORDER);
-=09blocks_to_free =3D pages_to_free >> VIRTIO_BALLOON_HINT_BLOCK_ORDER;
+=09=09=09=09 VIRTIO_BALLOON_HINT_BLOCK_PAGES);
+=09blocks_to_free =3D pages_to_free / VIRTIO_BALLOON_HINT_BLOCK_PAGES;
 =09blocks_freed =3D return_free_pages_to_mm(vb, blocks_to_free);
=20
-=09return blocks_freed << VIRTIO_BALLOON_HINT_BLOCK_ORDER;
+=09return blocks_freed * VIRTIO_BALLOON_HINT_BLOCK_PAGES;
 }
=20
 static unsigned long leak_balloon_pages(struct virtio_balloon *vb,
@@ -825,7 +826,7 @@ static unsigned long virtio_balloon_shrinker_count(stru=
ct shrinker *shrinker,
 =09unsigned long count;
=20
 =09count =3D vb->num_pages / VIRTIO_BALLOON_PAGES_PER_PAGE;
-=09count +=3D vb->num_free_page_blocks << VIRTIO_BALLOON_HINT_BLOCK_ORDER;
+=09count +=3D vb->num_free_page_blocks * VIRTIO_BALLOON_HINT_BLOCK_PAGES;
=20
 =09return count;
 }
--=20
MST

