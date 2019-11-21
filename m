Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 769EDC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 15:20:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 565F120674
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 15:20:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbfKUPUJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 10:20:09 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:56381 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbfKUPUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 10:20:09 -0500
X-Originating-IP: 153.3.140.100
Received: from localhost.localdomain.localdomain (unknown [153.3.140.100])
        (Authenticated sender: fly@kernel.page)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 736C51C001F;
        Thu, 21 Nov 2019 15:19:59 +0000 (UTC)
From:   Pengfei Li <fly@kernel.page>
To:     akpm@linux-foundation.org
Cc:     mgorman@techsingularity.net, mhocko@kernel.org, vbabka@suse.cz,
        cl@linux.com, iamjoonsoo.kim@lge.com, guro@fb.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Pengfei Li <fly@kernel.page>
Subject: [RFC v1 03/19] mm, oom_kill: use for_each_node in constrained_alloc()
Date:   Thu, 21 Nov 2019 23:17:55 +0800
Message-Id: <20191121151811.49742-4-fly@kernel.page>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191121151811.49742-1-fly@kernel.page>
References: <20191121151811.49742-1-fly@kernel.page>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In constrained_alloc(), we want to traverse node instead of zone, so
use for_each_node instead of for_each_zone.

Signed-off-by: Pengfei Li <fly@kernel.page>
---
 mm/oom_kill.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index f44c79db0cd6..db509d5e4db3 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -254,7 +254,6 @@ static enum oom_constraint constrained_alloc(struct oom_control *oc)
 	enum zone_type high_zoneidx = gfp_zone(oc->gfp_mask);
 	bool cpuset_limited = false;
 	struct nlist_traverser t;
-	struct zone *zone;
 	int nid;
 
 	if (is_memcg_oom(oc)) {
@@ -292,10 +291,13 @@ static enum oom_constraint constrained_alloc(struct oom_control *oc)
 	}
 
 	/* Check this allocation failure is caused by cpuset's wall function */
-	for_each_zone_nlist_nodemask(zone, &t, oc->nodelist,
-			high_zoneidx, oc->nodemask)
-		if (!cpuset_zone_allowed(zone, oc->gfp_mask))
+	for_each_node_nlist_nodemask(nid, &t, oc->nodelist,
+					high_zoneidx, oc->nodemask) {
+		if (!cpuset_node_allowed(nid, oc->gfp_mask)) {
 			cpuset_limited = true;
+			break;
+		}
+	}
 
 	if (cpuset_limited) {
 		oc->totalpages = total_swap_pages;
-- 
2.23.0

