Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60877C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 22:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35A2320733
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 22:57:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OgszDbwy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbfKOW5U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 17:57:20 -0500
Received: from mail-vs1-f74.google.com ([209.85.217.74]:38549 "EHLO
        mail-vs1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbfKOW5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 17:57:19 -0500
Received: by mail-vs1-f74.google.com with SMTP id b63so1724373vsb.5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 14:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=053BG20b593X/SMWxmhUI3JuwfglYUEj/JJwvN0h+wU=;
        b=OgszDbwyMvl11IRddPSG1mPf/uKCmY4IqAIBsD9+gVpRRzbJNw/mGNYvXxiVPrFVlW
         Aan5NICVu021n+/8xCWhTuE9mSOagqWWylR2U1uKY8N0c85LOHRC1nUM/upCmSciUrMm
         L3fXvrx1Uk2QZW3t0IA3VZMFUloVadHsmDDW+KPK4k4GT7VKWyNZdrh8ttIgPHliRJeX
         oQcAUGnn+otpz+RosyXPRGtGt4m+DI5iIbRw8uYGN1wbpdHiKugQcL14vgh+MrAYrh+Q
         O5rLxF4hJC6r+aDPdWf2qGbrnRjt4jg41pNONTu21HGtbs4rq2MKcszV50lWWRTdmALY
         fagw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=053BG20b593X/SMWxmhUI3JuwfglYUEj/JJwvN0h+wU=;
        b=rJpEC/OSMnCFf8f2hoI71lGouirp7OUQ4uO6yZQPBfuXCwItChX/svbD9b2UJ2r8w5
         2D8HrtbTvujVYIfKzkjwfMaCg597BLirYpkEev5uQ2IwP5tYp2f9HyyD6xQmuWCb+E9M
         lNzlLLsPOYCOqIqfTyTU7V3vG/6zqum5rZEQGLTqgAszyEPvQkKkYxuE/v82nn6HwniS
         +hCGjLDxuLmckBe6XD+NP9Ol/USM6CadKJmqnT2f9o4ZmOXRGrBb0wYH8FswKmic7Z7v
         xAAluXh0kThGUHiEYJ8jl48N9HTWHAEuJakP2io70DClLz2jxqYBdi63226G6J9xUXxK
         4T8g==
X-Gm-Message-State: APjAAAV74+Bo++LAsmzzztFpKeMxIrar/MxGYJ3ElIPQcAVpfCFConil
        kzYI76iNlANHOflnd1WtaVkmpqr+us8=
X-Google-Smtp-Source: APXvYqx3wRvRkGdHuMten4uCTPE1JRvBvAHB9IpdCd+K6gFc9krOXqH3S+Xlx6k/0TTMaKJM1vLZB3+1a2w=
X-Received: by 2002:a67:c995:: with SMTP id y21mr2878122vsk.158.1573858638823;
 Fri, 15 Nov 2019 14:57:18 -0800 (PST)
Date:   Fri, 15 Nov 2019 14:55:57 -0800
Message-Id: <20191115225557.61847-1-khazhy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: [PATCH] virtio_balloon: fix shrinker pages_to_free calculation
From:   Khazhismel Kumykov <khazhy@google.com>
To:     mst@redhat.com, jasowang@redhat.com, wei.w.wang@intel.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Khazhismel Kumykov <khazhy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To my reading, we're accumulating total freed pages in pages_freed, but
subtracting it every iteration from pages_to_free, meaning we'll count
earlier iterations multiple times, freeing fewer pages than expected.
Just accumulate in pages_freed, and compare to pages_to_free.

There's also a unit mismatch, where pages_to_free seems to be virtio
balloon pages, and pages_freed is system pages (We divide by
VIRTIO_BALLOON_PAGES_PER_PAGE), so sutracting pages_freed from
pages_to_free may result in freeing too much.

There also seems to be a mismatch between shrink_free_pages() and
shrink_balloon_pages(), where in both pages_to_free is given as # of
virtio pages to free, but free_pages() returns virtio pages, and
balloon_pages returns system pages.

(For 4K PAGE_SIZE, this mismatch wouldn't be noticed since
VIRTIO_BALLOON_PAGES_PER_PAGE would be 1)

Have both return virtio pages, and divide into system pages when
returning from shrinker_scan()

Fixes: 71994620bb25 ("virtio_balloon: replace oom notifier with shrinker")
Cc: Wei Wang <wei.w.wang@intel.com>
Signed-off-by: Khazhismel Kumykov <khazhy@google.com>
---

Tested this under memory pressure conditions and the shrinker seemed to
shrink.

 drivers/virtio/virtio_balloon.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 226fbb995fb0..7951ece3fe24 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -782,11 +782,8 @@ static unsigned long shrink_balloon_pages(struct virtio_balloon *vb,
 	 * VIRTIO_BALLOON_ARRAY_PFNS_MAX balloon pages, so we call it
 	 * multiple times to deflate pages till reaching pages_to_free.
 	 */
-	while (vb->num_pages && pages_to_free) {
-		pages_freed += leak_balloon(vb, pages_to_free) /
-					VIRTIO_BALLOON_PAGES_PER_PAGE;
-		pages_to_free -= pages_freed;
-	}
+	while (vb->num_pages && pages_to_free > pages_freed)
+		pages_freed += leak_balloon(vb, pages_to_free - pages_freed);
 	update_balloon_size(vb);
 
 	return pages_freed;
@@ -805,11 +802,11 @@ static unsigned long virtio_balloon_shrinker_scan(struct shrinker *shrinker,
 		pages_freed = shrink_free_pages(vb, pages_to_free);
 
 	if (pages_freed >= pages_to_free)
-		return pages_freed;
+		return pages_freed / VIRTIO_BALLOON_PAGES_PER_PAGE;
 
 	pages_freed += shrink_balloon_pages(vb, pages_to_free - pages_freed);
 
-	return pages_freed;
+	return pages_freed / VIRTIO_BALLOON_PAGES_PER_PAGE;
 }
 
 static unsigned long virtio_balloon_shrinker_count(struct shrinker *shrinker,
-- 
2.24.0.432.g9d3f5f5b63-goog

