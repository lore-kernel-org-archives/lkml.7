Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26760C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 05:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0E3F2089E
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 05:49:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405772AbfHIFtf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 01:49:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54202 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405755AbfHIFtc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 01:49:32 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 93EEE300BEAC;
        Fri,  9 Aug 2019 05:49:32 +0000 (UTC)
Received: from hp-dl380pg8-01.lab.eng.pek2.redhat.com (hp-dl380pg8-01.lab.eng.pek2.redhat.com [10.73.8.10])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 70C8F5D9CC;
        Fri,  9 Aug 2019 05:49:28 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, jgg@ziepe.ca, Jason Wang <jasowang@redhat.com>
Subject: [PATCH V5 8/9] vhost: correctly set dirty pages in MMU notifiers callback
Date:   Fri,  9 Aug 2019 01:48:50 -0400
Message-Id: <20190809054851.20118-9-jasowang@redhat.com>
In-Reply-To: <20190809054851.20118-1-jasowang@redhat.com>
References: <20190809054851.20118-1-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Fri, 09 Aug 2019 05:49:32 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need make sure there's no reference on the map before trying to
mark set dirty pages.

Reported-by: Michael S. Tsirkin <mst@redhat.com>
Fixes: 7f466032dc9e ("vhost: access vq metadata through kernel virtual address")
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/vhost.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 29e8abe694f7..d8863aaaf0f6 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -386,13 +386,12 @@ static void vhost_invalidate_vq_start(struct vhost_virtqueue *vq,
 	++vq->invalidate_count;
 
 	map = vq->maps[index];
-	if (map) {
+	if (map)
 		vq->maps[index] = NULL;
-		vhost_set_map_dirty(vq, map, index);
-	}
 	spin_unlock(&vq->mmu_lock);
 
 	if (map) {
+		vhost_set_map_dirty(vq, map, index);
 		vhost_map_unprefetch(map);
 	}
 }
-- 
2.18.1

