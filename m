Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44C7EC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 18:08:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14311204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 18:08:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbfHSSIa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 14:08:30 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:41983 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbfHSSI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 14:08:29 -0400
Received: by mail-yw1-f68.google.com with SMTP id i138so1145445ywg.8
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 11:08:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=O68GQIaSihY3YZYxTJAdOGhdzGVw7YfAHehKqg8Jqgw=;
        b=dJblfSXKUyDGl/pPZLaAHEw99Ya5YTTp2i3+U9XXikhuZtZnyCdnH6bkx2h+DCPqFW
         Vc9hO7z0YHpdBi8rFu9w+F6GMr8n+mjUkOjei4kS1Lah54BO/J5Dlbw5t7YQJw06zr1W
         MkuOINdqMM4TpfIve1qzgLgLwDrt3zZRrLis1j48PcnWaylXVGqw+LRXk+QoaHLr/FPs
         lgHVWtO7aNlLMgPaAd6WPfpX4yD66wGZA3HeG0faqvEG0OTdFX1/z84to1gJ4KXuUllU
         IHJmZN1b6MO8rk6g76lDiVd8b6HB3rlQlReI4IPhQ/hg/OVkfO+LOl9GLirs1J+R0xU2
         fq+A==
X-Gm-Message-State: APjAAAXSeKTRIlrsGn69j6IGcNkxSz5YPSNkN9uSZnAJ9YQBMmqbh7RQ
        nQ3T2DDcsvhDaOE5EpFNVvydkT2xk82IbQ==
X-Google-Smtp-Source: APXvYqybj/DJDeHeLsQLJ5Fb5uIIjCBh0hJXGKTuenKwUv5ag3p9fU5A9ZNRwQuDwT94bFwZdoLf0Q==
X-Received: by 2002:a81:ad10:: with SMTP id l16mr15762054ywh.217.1566238108803;
        Mon, 19 Aug 2019 11:08:28 -0700 (PDT)
Received: from localhost.localdomain (24-158-240-219.dhcp.smyr.ga.charter.com. [24.158.240.219])
        by smtp.gmail.com with ESMTPSA id l15sm864334ywk.72.2019.08.19.11.08.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 19 Aug 2019 11:08:27 -0700 (PDT)
From:   Wenwen Wang <wenwen@cs.uga.edu>
To:     Wenwen Wang <wenwen@cs.uga.edu>
Cc:     Dave Airlie <airlied@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org (open list:DRM DRIVER FOR QXL
        VIRTUAL GPU),
        spice-devel@lists.freedesktop.org (open list:DRM DRIVER FOR QXL VIRTUAL
        GPU), dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/qxl: fix a memory leak bug
Date:   Mon, 19 Aug 2019 13:08:18 -0500
Message-Id: <1566238098-3962-1-git-send-email-wenwen@cs.uga.edu>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In qxl_bo_create(), the temporary 'bo' is allocated through kzalloc().
However, it is not deallocated in the following execution if ttm_bo_init()
fails, leading to a memory leak bug. To fix this issue, free 'bo' before
returning the error.

Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
---
 drivers/gpu/drm/qxl/qxl_object.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/qxl/qxl_object.c b/drivers/gpu/drm/qxl/qxl_object.c
index 4928fa6..3b217fa 100644
--- a/drivers/gpu/drm/qxl/qxl_object.c
+++ b/drivers/gpu/drm/qxl/qxl_object.c
@@ -118,6 +118,7 @@ int qxl_bo_create(struct qxl_device *qdev,
 			dev_err(qdev->ddev.dev,
 				"object_init failed for (%lu, 0x%08X)\n",
 				size, domain);
+		kfree(bo);
 		return r;
 	}
 	*bo_ptr = bo;
-- 
2.7.4

