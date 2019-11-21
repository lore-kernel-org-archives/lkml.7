Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45B60C43215
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 15:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24E0B2070B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 15:22:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbfKUPWd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 10:22:33 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:37755 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726881AbfKUPWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 10:22:32 -0500
X-Originating-IP: 153.3.140.100
Received: from localhost.localdomain.localdomain (unknown [153.3.140.100])
        (Authenticated sender: fly@kernel.page)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 2425C1C001C;
        Thu, 21 Nov 2019 15:22:24 +0000 (UTC)
From:   Pengfei Li <fly@kernel.page>
To:     akpm@linux-foundation.org
Cc:     mgorman@techsingularity.net, mhocko@kernel.org, vbabka@suse.cz,
        cl@linux.com, iamjoonsoo.kim@lge.com, guro@fb.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Pengfei Li <fly@kernel.page>
Subject: [RFC v1 17/19] mm, memory_hotplug: cleanup online_pages()
Date:   Thu, 21 Nov 2019 23:18:09 +0800
Message-Id: <20191121151811.49742-18-fly@kernel.page>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191121151811.49742-1-fly@kernel.page>
References: <20191121151811.49742-1-fly@kernel.page>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cleanup patch.

In online_pages(), rename the local variable need_zonelists_rebuild
to need_nodelists_rebuild.

Signed-off-by: Pengfei Li <fly@kernel.page>
---
 mm/memory_hotplug.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 3c63529df112..3ff55da7b225 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -760,10 +760,10 @@ struct zone * zone_for_pfn_range(int online_type, int nid, unsigned start_pfn,
 
 int __ref online_pages(unsigned long pfn, unsigned long nr_pages, int online_type)
 {
-	unsigned long flags;
+	bool need_nodelists_rebuild = false;
 	unsigned long onlined_pages = 0;
+	unsigned long flags;
 	struct zone *zone;
-	int need_zonelists_rebuild = 0;
 	int nid;
 	int ret;
 	struct memory_notify arg;
@@ -798,7 +798,7 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages, int online_typ
 	 * So, zonelist must be updated after online.
 	 */
 	if (!populated_zone(zone)) {
-		need_zonelists_rebuild = 1;
+		need_nodelists_rebuild = true;
 		setup_zone_pageset(zone);
 	}
 
@@ -806,7 +806,7 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages, int online_typ
 		online_pages_range);
 	if (ret) {
 		/* not a single memory resource was applicable */
-		if (need_zonelists_rebuild)
+		if (need_nodelists_rebuild)
 			zone_pcp_reset(zone);
 		goto failed_addition;
 	}
@@ -820,7 +820,7 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages, int online_typ
 	shuffle_zone(zone);
 
 	node_states_set_node(nid, &arg);
-	if (need_zonelists_rebuild)
+	if (need_nodelists_rebuild)
 		build_all_nodelists(NULL);
 	else
 		zone_pcp_update(zone);
-- 
2.23.0

