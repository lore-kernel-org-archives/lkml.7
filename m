Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1432C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 15:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF010218A3
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 15:28:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727204AbfDLP2j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 11:28:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34446 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727170AbfDLP2j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 11:28:39 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E5026308CFBF;
        Fri, 12 Apr 2019 15:28:38 +0000 (UTC)
Received: from dhcp16-201-219.khw1.lab.eng.bos.redhat.com (dhcp16-201-219.khw1.lab.eng.bos.redhat.com [10.16.201.219])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B252560BEC;
        Fri, 12 Apr 2019 15:28:31 +0000 (UTC)
From:   Huaisheng Ye <huye@redhat.com>
To:     mpatocka@redhat.com, snitzer@redhat.com, agk@redhat.com
Cc:     prarit@redhat.com, chengnt@lenovo.com, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, Huaisheng Ye <yehs1@lenovo.com>
Subject: [PATCH] dm-writecache: add unlikely for returned value of rb_next/prev
Date:   Fri, 12 Apr 2019 11:28:14 -0400
Message-Id: <20190412152814.27158-1-huye@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Fri, 12 Apr 2019 15:28:38 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huaisheng Ye <yehs1@lenovo.com>

In functions writecache_discard and writecache_find_entry, there is
high probablity that the pointer of structure rb_node doesn't equal
to NULL. Add unlikly for the pointer node.

Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>
---
 drivers/md/dm-writecache.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/md/dm-writecache.c b/drivers/md/dm-writecache.c
index 5b4d1c1..cfbbfbc 100644
--- a/drivers/md/dm-writecache.c
+++ b/drivers/md/dm-writecache.c
@@ -571,7 +571,7 @@ static struct wc_entry *writecache_find_entry(struct dm_writecache *wc,
 			node = rb_prev(&e->rb_node);
 		else
 			node = rb_next(&e->rb_node);
-		if (!node)
+		if (unlikely(!node))
 			return e;
 		e2 = container_of(node, struct wc_entry, rb_node);
 		if (read_original_sector(wc, e2) != block)
@@ -804,7 +804,7 @@ static void writecache_discard(struct dm_writecache *wc, sector_t start, sector_
 			writecache_free_entry(wc, e);
 		}
 
-		if (!node)
+		if (unlikely(!node))
 			break;
 
 		e = container_of(node, struct wc_entry, rb_node);
-- 
1.8.3.1

