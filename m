Return-Path: <SRS0=F9vw=WN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E555DC3A59B
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 10:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4C8621019
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 10:51:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L/TiJYWG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbfHQKv0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Aug 2019 06:51:26 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45042 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbfHQKv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Aug 2019 06:51:26 -0400
Received: by mail-pf1-f193.google.com with SMTP id c81so4431074pfc.11
        for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2019 03:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e73g784pEuvRaYkV1Qn8G55TjYtK3ARicu4v3k3AYK8=;
        b=L/TiJYWG28ghyEkJJ1i8Rr0nYi5kkM/z461r7S6FCzbiM7pHaDaBzgwwzbry0aiV3w
         oSVTjm9psNf7L6J9IIcLSeAKSoXVUC/3HGuk+i9ul7pxp4ZckhTMMfiGpRCHTTmhuSI4
         EsbN86FIPqbXsG0zpy35IsWfpnYh3V0cfiphaIHgODHB19qrSJeSZZpXVvb3StqvwFJh
         5hLn3wwiJxuCDGXIjcS6D5mkl8n9qNLnkjzwVlXAEMo0S4XRS1cv4gTazZqqK0P9JtO+
         MhGo9wF47uXF7qVpKMCdr4mcqgGqEXjwqD7k0oX0/YU1B7dxJuRFiO90BTPwZK/JNGLX
         kINA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e73g784pEuvRaYkV1Qn8G55TjYtK3ARicu4v3k3AYK8=;
        b=CMZdwBARnz+5O7gBYh0qyBqicLnQ1IQ0v45O74oG13c9JQa42i+HUGIkkwQsa9x/b7
         uL4hrGDqsWXcF7AAu/6SlKJsrCjqpbYMuz9cU3EfmF1MneFdFdXwvrNDRw8EB00GFnJs
         ARudppkXnNmBjCCCdkDYUu0pRMB/XQtsm1F3V4iXPI1V5n+PVfJUE39FWkU7FayCQyLg
         FzLA5T73Wm+zpPcOiVaEtm9pz/YlA2uJHHrTPR+IjBCef3//LhXyOqdHfYxXkzFJ3lc+
         L9UDYulO8YxpypY/+afqJ7dnqxkQjN8Xi4cWrkb29ulzgZRRYGiE5ikjxzr1nEB6d59w
         Rd+g==
X-Gm-Message-State: APjAAAWfNBcv78V7mD4HZBE5BkXGfIPYEMT35nrKRDkrCfLlUVMt5Wls
        wx4jDKrrrZ+FYPuWybZZi/4=
X-Google-Smtp-Source: APXvYqxy7g7+zbKxk+cAbT0qd+YvQjEWcC7SI9W4jBPUYcJHNSQ/ApGRe7qOaI4sww4O4RWdBWwFEg==
X-Received: by 2002:a17:90a:5887:: with SMTP id j7mr11346687pji.136.1566039085619;
        Sat, 17 Aug 2019 03:51:25 -0700 (PDT)
Received: from localhost.localdomain.localdomain ([2408:823c:c11:ac8:b8c3:8577:bf2f:3])
        by smtp.gmail.com with ESMTPSA id f26sm12910838pfq.38.2019.08.17.03.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Aug 2019 03:51:25 -0700 (PDT)
From:   Pengfei Li <lpf.vector@gmail.com>
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, vbabka@suse.cz, osalvador@suse.de,
        pavel.tatashin@microsoft.com, mgorman@techsingularity.net,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Pengfei Li <lpf.vector@gmail.com>
Subject: [PATCH] mm/page_alloc: cleanup __alloc_pages_direct_compact()
Date:   Sat, 17 Aug 2019 18:51:02 +0800
Message-Id: <20190817105102.11732-1-lpf.vector@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch cleans up the if(page).

No functional change.

Signed-off-by: Pengfei Li <lpf.vector@gmail.com>
---
 mm/page_alloc.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 272c6de1bf4e..51f056ac09f5 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3890,6 +3890,7 @@ __alloc_pages_direct_compact(gfp_t gfp_mask, unsigned int order,
 		enum compact_priority prio, enum compact_result *compact_result)
 {
 	struct page *page = NULL;
+	struct zone *zone;
 	unsigned long pflags;
 	unsigned int noreclaim_flag;
 
@@ -3911,23 +3912,26 @@ __alloc_pages_direct_compact(gfp_t gfp_mask, unsigned int order,
 	 */
 	count_vm_event(COMPACTSTALL);
 
-	/* Prep a captured page if available */
-	if (page)
+	if (page) {
+		/* Prep a captured page if available */
 		prep_new_page(page, order, gfp_mask, alloc_flags);
-
-	/* Try get a page from the freelist if available */
-	if (!page)
+	} else {
+		/* Try get a page from the freelist if available */
 		page = get_page_from_freelist(gfp_mask, order, alloc_flags, ac);
 
-	if (page) {
-		struct zone *zone = page_zone(page);
-
-		zone->compact_blockskip_flush = false;
-		compaction_defer_reset(zone, order, true);
-		count_vm_event(COMPACTSUCCESS);
-		return page;
+		if (!page)
+			goto failed;
 	}
 
+	zone = page_zone(page);
+	zone->compact_blockskip_flush = false;
+	compaction_defer_reset(zone, order, true);
+
+	count_vm_event(COMPACTSUCCESS);
+
+	return page;
+
+failed:
 	/*
 	 * It's bad if compaction run occurs and fails. The most likely reason
 	 * is that pages exist, but not enough to satisfy watermarks.
-- 
2.21.0

