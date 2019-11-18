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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B900BC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 21:38:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8691C222EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 21:38:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mHQbdyUx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbfKRVi4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 16:38:56 -0500
Received: from mail-pf1-f201.google.com ([209.85.210.201]:53460 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbfKRVi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 16:38:56 -0500
Received: by mail-pf1-f201.google.com with SMTP id h2so15058028pfr.20
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 13:38:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=R6Acg+jdFVk2p6ATpns4CDctE+Vl9KUjiRKuJA0ei70=;
        b=mHQbdyUxygyJYLA0wlaa+9zB0wgMSfjizYY7Yt/bxOii/URTraMMYKMOi84x8Dc7Ax
         jUWvHgud5iiCZ5eDTOZy3J5xy41uNE7QcX9NPBvr8bxtnrBN07DRP+Ec8bBLHn6TSfNr
         0xLSAhr2CEd4V0w4ikqMLjmzslN3UMX7mPOf+QOjTX0s214bpeCRmkF6eM94rb2fqxPu
         uVdOSYCCLZh09m8phPF5WuKhhq0m4J0HXEkOdakp9HyZ9x3h1tD4/gXi7s3SDoUGgQPe
         bNQA/3Ln21k+ETpuaGRCro++utWdBc9hnJmXPsCO0HRzLGjz+ZIiFRtpZqRRTXTvN9wN
         DkJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=R6Acg+jdFVk2p6ATpns4CDctE+Vl9KUjiRKuJA0ei70=;
        b=hMbID6TwyZOMfI5zvJdYrYMi/XMPMknXhLiLG1kXTcBrP1lMEHX8L4WftC+li4Ppu2
         dvB7UU7vFyV01lhms5gvylDhwpWfXcx05HS1Oe1goE7YPrqenHRbopUYcndu6RMTjqpt
         fVn3rbmbW5VAUb1CNnoHTbOhSS0Ahm+lYA3H3j31owMiaANp1APYNFgipqmAb8JMogGG
         dVChk8VAG/MDjGS66kRceoMAwmQVIeosF1flteKupvPIlcCTz4r9/mJ+Hs7y2hhwGXHi
         KwFiDcTbV4Z4JhTxKFhg/2u4inSthbyiUjtlAH6WHJyY6owkhxz7X01DHKBtJkjsZGfm
         Is/Q==
X-Gm-Message-State: APjAAAUm4mZLkUYqR0AASt6yi1+vE83Xr+jpa7br5pHr9UXygCroJTwf
        HfaV+OEswBw6Excy88g/wHASTsAo1LA=
X-Google-Smtp-Source: APXvYqxUcGmgVhykPBenM2QJJr/rNw+e131RezTCgbiRPmAmeffneTHCVvKRuXJSfSlZFFwvGzyVXHYxDro=
X-Received: by 2002:a65:5683:: with SMTP id v3mr1617900pgs.190.1574113133981;
 Mon, 18 Nov 2019 13:38:53 -0800 (PST)
Date:   Mon, 18 Nov 2019 13:38:10 -0800
In-Reply-To: <CACGdZYJoHSN3vkj_QBz6Txmec9mJMmkH66j2XtqzpUWpfpw4Tg@mail.gmail.com>
Message-Id: <20191118213811.22017-1-khazhy@google.com>
Mime-Version: 1.0
References: <CACGdZYJoHSN3vkj_QBz6Txmec9mJMmkH66j2XtqzpUWpfpw4Tg@mail.gmail.com>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: [PATCH 1/2] virtio_balloon: fix pages_to_free calculation
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

freed_pages was accumulating total freed pages, but was also subtracted
on each iteration from pages_to_free, which could potentially result in
attempting to free fewer pages than asked for. This change also makes
both freed_pages and pages_to_free in terms of "balloon pages", where
they were mismatched before.

Fixes: 71994620bb25 ("virtio_balloon: replace oom notifier with shrinker")
Cc: Wei Wang <wei.w.wang@intel.com>
Signed-off-by: Khazhismel Kumykov <khazhy@google.com>
---
 drivers/virtio/virtio_balloon.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 226fbb995fb0..7cf9540a40b8 100644
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
-- 
2.24.0.432.g9d3f5f5b63-goog

