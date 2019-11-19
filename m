Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF36C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 10:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B67C22303
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 10:18:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FYwluY+b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727539AbfKSKSV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 05:18:21 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43956 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726351AbfKSKSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 05:18:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574158699;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Acfch5/VhpABhLUFIhseap39qLoWtZkvUtr0T0hX2Tk=;
        b=FYwluY+bZ1SwfeNPyHwGB0pxbrhT3Q+Rk3i97AgU1XqAaJRmIeVyCZycDpzqlrZdroNt6d
        Dq47RbEpKxCccrfk6aTwONVaYq8UabSCcApCSUsQB5g4H1y1KVmoX5MAr6Xrs8qpL3uE+v
        J0S934BEK0E9XwjplhBKTI9shRfKRM8=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-254-zfc-vyIZPvOx6m4ONHTcYg-1; Tue, 19 Nov 2019 05:18:17 -0500
Received: by mail-qv1-f70.google.com with SMTP id w7so14425763qvs.15
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 02:18:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=lnS0JzaPkUj+IPb87pokVT4FioI7ddK6q2VS+pup+Kg=;
        b=K/VI9qrVC5MbWR/ERuQglk6g1vDxyph+uNlq+W3OYlMP19oCI/72wMdHOv55H4gx/v
         wNIVsuMPlXpmx1OdtlE7IMK4SwyNu2SRA9Tax5WvcR7gRXOTfhpwjqI66rlgfm2DyGTD
         no5B+cyuaNnydqLIgauF2pYZz80AzaHuuojQOq/47Z6tGwY1f5L1Q3ako2UWGzz0k0zT
         sPNKg+Al1jynAyj4gE94YEGqBlPxpK0RpUpCxmPORSnFqlG7eaGyaB4tdt3EZhU958a+
         L7822WxGVhUWUWkU46bVy44Kn9SDHgSTQTA4w5wPRjC4JAbU6nZthE4CjiezO+MDKY6U
         bYig==
X-Gm-Message-State: APjAAAUGXkJftVOREuPmyKJxHnniR3u9OSGetdqUgDU8d9LphPnBjkmQ
        tM0qP+T9Masr58nqf7NQ/mdgNiEjB0QNs9PtENeDjd5bVrX9IQvuHirLBJQWqHTfHvVTw7Dz1Ve
        9pIzn29Pe/AgbRF1HmKQDXBD0
X-Received: by 2002:ac8:1858:: with SMTP id n24mr30075099qtk.334.1574158696937;
        Tue, 19 Nov 2019 02:18:16 -0800 (PST)
X-Google-Smtp-Source: APXvYqx+dUL5IV3PXYYvDTgXAOYgSLkn41lPvbWu5SefSFOoDcbaD+Kokj9abjYPen65I3ZyFIPGuQ==
X-Received: by 2002:ac8:1858:: with SMTP id n24mr30075089qtk.334.1574158696782;
        Tue, 19 Nov 2019 02:18:16 -0800 (PST)
Received: from redhat.com (bzq-79-176-6-42.red.bezeqint.net. [79.176.6.42])
        by smtp.gmail.com with ESMTPSA id b54sm12516736qta.38.2019.11.19.02.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 02:18:16 -0800 (PST)
Date:   Tue, 19 Nov 2019 05:18:12 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Wei Wang <wei.w.wang@intel.com>, stable@vger.kernel.org,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH] virtio_balloon: fix shrinker count
Message-ID: <20191119101745.39038-1-mst@redhat.com>
MIME-Version: 1.0
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
X-MC-Unique: zfc-vyIZPvOx6m4ONHTcYg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Wang <wei.w.wang@intel.com>

Instead of multiplying by page order, virtio balloon divided by page
order. The result is that it can often return 0 if there are a bit less
than MAX_ORDER - 1 pages in use, and then shrinker scan won't be called.

Cc: stable@vger.kernel.org
Fixes: 71994620bb25 ("virtio_balloon: replace oom notifier with shrinker")
Signed-off-by: Wei Wang <wei.w.wang@intel.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_balloon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloo=
n.c
index 7cee05cdf3fb..65df40f261ab 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -825,7 +825,7 @@ static unsigned long virtio_balloon_shrinker_count(stru=
ct shrinker *shrinker,
 =09unsigned long count;
=20
 =09count =3D vb->num_pages / VIRTIO_BALLOON_PAGES_PER_PAGE;
-=09count +=3D vb->num_free_page_blocks >> VIRTIO_BALLOON_FREE_PAGE_ORDER;
+=09count +=3D vb->num_free_page_blocks << VIRTIO_BALLOON_FREE_PAGE_ORDER;
=20
 =09return count;
 }
--=20
MST

