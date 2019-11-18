Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C32C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 21:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 997692230C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 21:39:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qN+9Nrnh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbfKRVi7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 16:38:59 -0500
Received: from mail-pf1-f201.google.com ([209.85.210.201]:43134 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbfKRVi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 16:38:58 -0500
Received: by mail-pf1-f201.google.com with SMTP id w201so15075662pfc.10
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 13:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=x6bZFaFYssXZ/d1+9Q6PPDYnTw9J/o5Qs2u5F4Xotx0=;
        b=qN+9NrnhgIz/iifUS0sOOL4wusaCPVU2q81o2xyQZl6eNf9oELhehZ/ODVHR5vrdze
         ZLIcWnP9yVbdBrVibdW8rKntRS9cC4psaerjNUR+EFVKk8/ImiZKQZQuZCeG7XT2m4d5
         2oCps7tfnK4UuQNaHHKmH4qyEAxLdnt+LkUwDNjHUSfC+jHKmMGRxiAFQnjnKV/JNt2I
         9yODaz9BwXrNWVXesioQULUa9TBeMmzxp31HbD3MJfBAXUAvPH+4g0TKGw3bDhvGhPVq
         hRucm1weNL/8t89a2xa10l9QLbUAxZq4/PcrZRV/nGebfj/lUBu1hcEsb3tAdK5hF3S3
         IFtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=x6bZFaFYssXZ/d1+9Q6PPDYnTw9J/o5Qs2u5F4Xotx0=;
        b=UDE+6/BO8ON4+Nna8wNwDeYuaGJzI0ZhTgiyZki2zw2JvgDm+x+YQcdyKDRs4MSwOV
         qoGyyngqnXImySRAs69GsmY5Jq/8oiGT8nEIAj3HQASf3/R05X6B6Z77M5Au+Anjhni1
         iuAJ/H/nSiCMheF+eV4NHaLcVUksbnvMOnpIs3f966z8ta5J83aDU2/FXREkUdXfkf8L
         H0Sy+luozZQXMixQBAoeM6KdEhIM3jnL7JJI63kDOfHBiQ3sEsMMYv4ukQWVZuDGDdgo
         4Bi16Omnb21SuWQkPdAYF4E1FEDoFsG1n9ro6SRlbVrfQUtThw0vtp7q2GnfBnFxJ8gT
         BmBw==
X-Gm-Message-State: APjAAAXQmQagxLE1jI7B6ApylqP9l7u6BLs8mnIqIHzDhDuQ9mfBUoJQ
        3u2pRy/HtQAA6W8vI5qIiqRYuvydV0k=
X-Google-Smtp-Source: APXvYqz/U2vL0jaD/Orv1XLZ80shtVXueN9KV80NRY8jHCpvFtGCHQZwNFHIo/nKOlpwze+bHKAoLTXHQZ0=
X-Received: by 2002:a63:f30c:: with SMTP id l12mr1608293pgh.354.1574113136229;
 Mon, 18 Nov 2019 13:38:56 -0800 (PST)
Date:   Mon, 18 Nov 2019 13:38:11 -0800
In-Reply-To: <20191118213811.22017-1-khazhy@google.com>
Message-Id: <20191118213811.22017-2-khazhy@google.com>
Mime-Version: 1.0
References: <CACGdZYJoHSN3vkj_QBz6Txmec9mJMmkH66j2XtqzpUWpfpw4Tg@mail.gmail.com>
 <20191118213811.22017-1-khazhy@google.com>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: [PATCH 2/2] virtio_balloon: fix shrinker_scan return units
From:   Khazhismel Kumykov <khazhy@google.com>
To:     mst@redhat.com, jasowang@redhat.com, wei.w.wang@intel.com
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Khazhismel Kumykov <khazhy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We were returning number of virtio balloon pages, which may not be the
same as number of system pages

Fixes: 86a559787e6f ("virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT")
Cc: Wei Wang <wei.w.wang@intel.com>
Signed-off-by: Khazhismel Kumykov <khazhy@google.com>
---
 drivers/virtio/virtio_balloon.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 7cf9540a40b8..7951ece3fe24 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -802,11 +802,11 @@ static unsigned long virtio_balloon_shrinker_scan(struct shrinker *shrinker,
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

