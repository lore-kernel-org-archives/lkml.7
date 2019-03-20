Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84DEBC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 08:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D10C21841
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 08:07:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbfCTIHp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 04:07:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34322 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727304AbfCTIHp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 04:07:45 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 265C130B9328;
        Wed, 20 Mar 2019 08:07:45 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-38.pek2.redhat.com [10.72.12.38])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1C912605CA;
        Wed, 20 Mar 2019 08:07:39 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, osalvador@suse.de, mhocko@suse.com,
        david@redhat.com, richard.weiyang@gmail.com, rppt@linux.ibm.com,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH] mm, memory_hotplug: Fix the wrong usage of N_HIGH_MEMORY
Date:   Wed, 20 Mar 2019 16:07:32 +0800
Message-Id: <20190320080732.14933-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Wed, 20 Mar 2019 08:07:45 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function node_states_check_changes_online(), N_HIGH_MEMORY is used
to substitute ZONE_HIGHMEM directly. This is not right. N_HIGH_MEMORY
always has value '3' if CONFIG_HIGHMEM=y, while ZONE_HIGHMEM's value
is not. It depends on whether CONFIG_ZONE_DMA/CONFIG_ZONE_DMA32 are
enabled. Obviously it's not true for CONFIG_ZONE_DMA32 on 32bit system,
and CONFIG_ZONE_DMA is also optional.

Replace it with ZONE_HIGHMEM.

Fixes: 8efe33f40f3e ("mm/memory_hotplug.c: simplify node_states_check_changes_online")
Signed-off-by: Baoquan He <bhe@redhat.com>
---
 mm/memory_hotplug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 6b05576fb4ec..09911d34a3be 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -712,7 +712,7 @@ static void node_states_check_changes_online(unsigned long nr_pages,
 	if (zone_idx(zone) <= ZONE_NORMAL && !node_state(nid, N_NORMAL_MEMORY))
 		arg->status_change_nid_normal = nid;
 #ifdef CONFIG_HIGHMEM
-	if (zone_idx(zone) <= N_HIGH_MEMORY && !node_state(nid, N_HIGH_MEMORY))
+	if (zone_idx(zone) <= ZONE_HIGHMEM && !node_state(nid, N_HIGH_MEMORY))
 		arg->status_change_nid_high = nid;
 #endif
 }
-- 
2.17.2

