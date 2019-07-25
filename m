Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B88B9C76194
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 18:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D1FF22BEF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 18:44:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vUtykOa0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbfGYSoW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 14:44:22 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45187 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbfGYSoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 14:44:21 -0400
Received: by mail-pg1-f195.google.com with SMTP id o13so23453561pgp.12
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 11:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=abO8zis5qyQ9jMy/dQEIxCIeoB176hkWi+GQror9w/4=;
        b=vUtykOa02Pa10uCbtLnoIvcUdFu3JThtZDgo7uW93gVBQuQ6Dc6mKJH4uPVqsVU8sm
         i3zJWEzbfjRWgBmpct25rX/J1WFFmQve2ve4ubTiw18sLQ4FYkdeyrDOw+4/zgtp8BH5
         9jCeL2BIcDFv+r5lDJ3aWMEFu1UqN2LoN7OvZ9e+t0kt5VAG7L4hRS2R22GRIai/hOwX
         pezFLT9P8x3g0sId1DVpAF21XwTxPKS15UmJxeL38Jn92SA8bD7OsQy0F/vXKuA4OIQ3
         IZ/5y9xvKWRRRKi9FOiV7vi5XrTFGoMZHdYAwycNVE6aGnoWCpR2Et1Uy8LS72Xkrzup
         tjEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=abO8zis5qyQ9jMy/dQEIxCIeoB176hkWi+GQror9w/4=;
        b=HZsIfLl3eHuV3fS9p4UvwnUjEOBO/k2JIni0bGG9Cj8JqDv73ZvtyWYJ/6xQ+cnFaO
         DzZOLrEq2kyscjXTljBL0FvEkkcjnJaFhqRUVGu2Ca5uSHK0JhltjGDp4LTxwkGFBH4c
         mCp9gcih07DtR94GahuGI5HbZJh27A+MEeFsPWG1VZ3NtOECN+f94FNwD+cifVxQF9ha
         PuHyzFASE/2wVhjcZLYWctd2kHydOaF1JTCzsi9AHhNbrO2OB1/Tq7aeSbOeQq/MZQrU
         JxApGe0ChX+uaDhDTmX6CgK9mv/xLqJMsPH7jafQhJ2TnvU9drYqMypsKFvNML9wGaal
         T8Ww==
X-Gm-Message-State: APjAAAVSIXHLDQbbHAr14wXGVPjWMqc17zZubjl/PG9RCDkN1VRGQMHL
        E4xhilvnHm53fnzzivlYSOI=
X-Google-Smtp-Source: APXvYqwJOb28TKf+TbxnRmxPgCBkeIkNDYkj3cI7IIoSwn/D3InHcQUxaF6kTZhxG3DdTaQjTi0y/A==
X-Received: by 2002:a63:f13:: with SMTP id e19mr87244311pgl.132.1564080260681;
        Thu, 25 Jul 2019 11:44:20 -0700 (PDT)
Received: from localhost.localdomain.localdomain ([2408:823c:c11:624:b8c3:8577:bf2f:3])
        by smtp.gmail.com with ESMTPSA id w3sm43818257pgl.31.2019.07.25.11.44.12
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 11:44:20 -0700 (PDT)
From:   Pengfei Li <lpf.vector@gmail.com>
To:     akpm@linux-foundation.org
Cc:     mgorman@techsingularity.net, mhocko@suse.com, vbabka@suse.cz,
        cai@lca.pw, aryabinin@virtuozzo.com, osalvador@suse.de,
        rostedt@goodmis.org, mingo@redhat.com,
        pavel.tatashin@microsoft.com, rppt@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Pengfei Li <lpf.vector@gmail.com>
Subject: [PATCH 06/10] mm/compaction: make "order" unsigned int in compaction.c
Date:   Fri, 26 Jul 2019 02:42:49 +0800
Message-Id: <20190725184253.21160-7-lpf.vector@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190725184253.21160-1-lpf.vector@gmail.com>
References: <20190725184253.21160-1-lpf.vector@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since compact_control->order and compact_control->search_order
have been modified to unsigned int in the previous commit, then
some of the functions in compaction.c are modified accordingly.

Signed-off-by: Pengfei Li <lpf.vector@gmail.com>
---
 include/linux/compaction.h | 12 ++++++------
 mm/compaction.c            | 21 ++++++++++-----------
 2 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/include/linux/compaction.h b/include/linux/compaction.h
index 9569e7c786d3..0201dfa57d44 100644
--- a/include/linux/compaction.h
+++ b/include/linux/compaction.h
@@ -96,8 +96,8 @@ extern enum compact_result try_to_compact_pages(gfp_t gfp_mask,
 		const struct alloc_context *ac, enum compact_priority prio,
 		struct page **page);
 extern void reset_isolation_suitable(pg_data_t *pgdat);
-extern enum compact_result compaction_suitable(struct zone *zone, int order,
-		unsigned int alloc_flags, int classzone_idx);
+extern enum compact_result compaction_suitable(struct zone *zone,
+	unsigned int order, unsigned int alloc_flags, int classzone_idx);
 
 extern void defer_compaction(struct zone *zone, int order);
 extern bool compaction_deferred(struct zone *zone, int order);
@@ -170,8 +170,8 @@ static inline bool compaction_withdrawn(enum compact_result result)
 }
 
 
-bool compaction_zonelist_suitable(struct alloc_context *ac, int order,
-					int alloc_flags);
+bool compaction_zonelist_suitable(struct alloc_context *ac,
+				unsigned int order, int alloc_flags);
 
 extern int kcompactd_run(int nid);
 extern void kcompactd_stop(int nid);
@@ -182,8 +182,8 @@ static inline void reset_isolation_suitable(pg_data_t *pgdat)
 {
 }
 
-static inline enum compact_result compaction_suitable(struct zone *zone, int order,
-					int alloc_flags, int classzone_idx)
+static inline enum compact_result compaction_suitable(struct zone *zone,
+		unsigned int order, int alloc_flags, int classzone_idx)
 {
 	return COMPACT_SKIPPED;
 }
diff --git a/mm/compaction.c b/mm/compaction.c
index e47d8fa943a6..ac5df82d46e0 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1639,7 +1639,7 @@ static unsigned long fast_find_migrateblock(struct compact_control *cc)
 	unsigned long distance;
 	unsigned long pfn = cc->migrate_pfn;
 	unsigned long high_pfn;
-	int order;
+	unsigned int order;
 
 	/* Skip hints are relied on to avoid repeats on the fast search */
 	if (cc->ignore_skip_hint)
@@ -1958,10 +1958,9 @@ static enum compact_result compact_finished(struct compact_control *cc)
  *   COMPACT_SUCCESS  - If the allocation would succeed without compaction
  *   COMPACT_CONTINUE - If compaction should run now
  */
-static enum compact_result __compaction_suitable(struct zone *zone, int order,
-					unsigned int alloc_flags,
-					int classzone_idx,
-					unsigned long wmark_target)
+static enum compact_result __compaction_suitable(struct zone *zone,
+		unsigned int order, unsigned int alloc_flags,
+		int classzone_idx, unsigned long wmark_target)
 {
 	unsigned long watermark;
 
@@ -1998,7 +1997,7 @@ static enum compact_result __compaction_suitable(struct zone *zone, int order,
 	return COMPACT_CONTINUE;
 }
 
-enum compact_result compaction_suitable(struct zone *zone, int order,
+enum compact_result compaction_suitable(struct zone *zone, unsigned int order,
 					unsigned int alloc_flags,
 					int classzone_idx)
 {
@@ -2036,7 +2035,7 @@ enum compact_result compaction_suitable(struct zone *zone, int order,
 	return ret;
 }
 
-bool compaction_zonelist_suitable(struct alloc_context *ac, int order,
+bool compaction_zonelist_suitable(struct alloc_context *ac, unsigned int order,
 		int alloc_flags)
 {
 	struct zone *zone;
@@ -2278,10 +2277,10 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
 	return ret;
 }
 
-static enum compact_result compact_zone_order(struct zone *zone, int order,
-		gfp_t gfp_mask, enum compact_priority prio,
-		unsigned int alloc_flags, int classzone_idx,
-		struct page **capture)
+static enum compact_result compact_zone_order(struct zone *zone,
+		unsigned int order, gfp_t gfp_mask,
+		enum compact_priority prio, unsigned int alloc_flags,
+		int classzone_idx, struct page **capture)
 {
 	enum compact_result ret;
 	struct compact_control cc = {
-- 
2.21.0

