Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D8D7C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 15:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14FD02070E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 15:22:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbfKUPWH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 10:22:07 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:36393 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbfKUPWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 10:22:06 -0500
X-Originating-IP: 153.3.140.100
Received: from localhost.localdomain.localdomain (unknown [153.3.140.100])
        (Authenticated sender: fly@kernel.page)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id E9F8B1C000A;
        Thu, 21 Nov 2019 15:21:47 +0000 (UTC)
From:   Pengfei Li <fly@kernel.page>
To:     akpm@linux-foundation.org
Cc:     mgorman@techsingularity.net, mhocko@kernel.org, vbabka@suse.cz,
        cl@linux.com, iamjoonsoo.kim@lge.com, guro@fb.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Pengfei Li <fly@kernel.page>
Subject: [RFC v1 14/19] mm, compaction: rename compaction_zonelist_suitable
Date:   Thu, 21 Nov 2019 23:18:06 +0800
Message-Id: <20191121151811.49742-15-fly@kernel.page>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191121151811.49742-1-fly@kernel.page>
References: <20191121151811.49742-1-fly@kernel.page>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cleanup patch. Rename compaction_zonelist_suitable
to compaction_nodelist_suitable.

Signed-off-by: Pengfei Li <fly@kernel.page>
---
 include/linux/compaction.h | 2 +-
 mm/compaction.c            | 2 +-
 mm/page_alloc.c            | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/compaction.h b/include/linux/compaction.h
index 4b898cdbdf05..3ba55eb7c353 100644
--- a/include/linux/compaction.h
+++ b/include/linux/compaction.h
@@ -177,7 +177,7 @@ static inline bool compaction_withdrawn(enum compact_result result)
 }
 
 
-bool compaction_zonelist_suitable(struct alloc_context *ac, int order,
+bool compaction_nodelist_suitable(struct alloc_context *ac, int order,
 					int alloc_flags);
 
 extern int kcompactd_run(int nid);
diff --git a/mm/compaction.c b/mm/compaction.c
index d9f42e18991c..91581ab1d593 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2036,7 +2036,7 @@ enum compact_result compaction_suitable(struct zone *zone, int order,
 	return ret;
 }
 
-bool compaction_zonelist_suitable(struct alloc_context *ac, int order,
+bool compaction_nodelist_suitable(struct alloc_context *ac, int order,
 		int alloc_flags)
 {
 	struct nlist_traverser t;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 5c96d1ecd643..3987b8e97158 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3967,7 +3967,7 @@ should_compact_retry(struct alloc_context *ac, int order, int alloc_flags,
 	 * to work with, so we retry only if it looks like reclaim can help.
 	 */
 	if (compaction_needs_reclaim(compact_result)) {
-		ret = compaction_zonelist_suitable(ac, order, alloc_flags);
+		ret = compaction_nodelist_suitable(ac, order, alloc_flags);
 		goto out;
 	}
 
-- 
2.23.0

