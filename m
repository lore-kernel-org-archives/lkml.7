Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D30C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 13:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F391921848
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 13:54:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393535AbfHWNyT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 09:54:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44698 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390206AbfHWNyT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 09:54:19 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C0FE130832DC;
        Fri, 23 Aug 2019 13:54:18 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AD5345D9E5;
        Fri, 23 Aug 2019 13:54:09 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id x7NDs9uc002084;
        Fri, 23 Aug 2019 09:54:09 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id x7NDs9i4002081;
        Fri, 23 Aug 2019 09:54:09 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Fri, 23 Aug 2019 09:54:09 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Zhang Tao <kontais@zoho.com>
cc:     agk@redhat.com, snitzer@redhat.com,
        Zhang Tao <zhangtao27@lenovo.com>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dm table: fix invalid memory accesses with too high
 sector number
In-Reply-To: <alpine.LRH.2.02.1908230705510.5296@file01.intranet.prod.int.rdu2.redhat.com>
Message-ID: <alpine.LRH.2.02.1908230952160.22174@file01.intranet.prod.int.rdu2.redhat.com>
References: <1566351211-13280-1-git-send-email-kontais@zoho.com> <alpine.LRH.2.02.1908230705510.5296@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Fri, 23 Aug 2019 13:54:18 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the sector number is too high, dm_table_find_target should return a
pointer to a zeroed dm_target structure (the caller should test it with
dm_target_is_valid).

However, for some table sizes, the code in dm_table_find_target that
performs btree lookup will access out of bound memory structures.

This patch fixes the bug by testing the sector number at the beginning of
dm_table_find_target. We add an "inline" keyword to the function
dm_table_get_size because this is hot path.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Reported-by: Zhang Tao <kontais@zoho.com>
Fixes: 512875bd9661 ("dm: table detect io beyond device")
Cc: stable@vger.kernel.org

---
 drivers/md/dm-table.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

Index: linux-2.6/drivers/md/dm-table.c
===================================================================
--- linux-2.6.orig/drivers/md/dm-table.c	2019-08-23 13:40:51.000000000 +0200
+++ linux-2.6/drivers/md/dm-table.c	2019-08-23 15:43:19.000000000 +0200
@@ -1342,7 +1342,7 @@ void dm_table_event(struct dm_table *t)
 }
 EXPORT_SYMBOL(dm_table_event);
 
-sector_t dm_table_get_size(struct dm_table *t)
+inline sector_t dm_table_get_size(struct dm_table *t)
 {
 	return t->num_targets ? (t->highs[t->num_targets - 1] + 1) : 0;
 }
@@ -1367,6 +1367,9 @@ struct dm_target *dm_table_find_target(s
 	unsigned int l, n = 0, k = 0;
 	sector_t *node;
 
+	if (unlikely(sector >= dm_table_get_size(t)))
+		return &t->targets[t->num_targets];
+
 	for (l = 0; l < t->depth; l++) {
 		n = get_child(n, k);
 		node = get_node(t, l, n);

