Return-Path: <SRS0=TpO6=UA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C2BC28CC4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 13:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D3CE275B4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 13:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559396213;
	bh=3/W9B79kcjbgSKblNyV8ZM25Nliu0LB0SKO6QQp74H8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=erS/bBJJTyf0QmIepMtI3m2tSQxpcx4P4Pf0/QvdzTOFh0Wccjf+LwUQKOCz6M5k3
	 Qynu/+5/h0yE1mhw/2CliaiH/UJAKIzanvdXns+IKEpoHLoNTkuEZfb0F2qyStMsrH
	 6HIzdifzJ4rPM645bzyZ0PCyYVsBWaLKXRIITlg0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728739AbfFANW3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Jun 2019 09:22:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:50014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728723AbfFANWX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jun 2019 09:22:23 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D7EB27332;
        Sat,  1 Jun 2019 13:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559395342;
        bh=3/W9B79kcjbgSKblNyV8ZM25Nliu0LB0SKO6QQp74H8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0I7yIx6mvBzgvnm3Msz5ubxvDVmUr7vIS3yIT49oZFM9o+fmGA/TcafC6XWxBQxVy
         7CSgukNjBbhItGjy7KMs8WKSxWqBWQiFkQntGXKOih/KpAP6R0djVc8EJzFSEvQnjw
         qyFUFlX4wsPwOUg8M5UIhc24aXJkARy1l/Q5F0pw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Linxu Fang <fanglinxu@huawei.com>,
        Taku Izumi <izumi.taku@jp.fujitsu.com>,
        Xishi Qiu <qiuxishi@huawei.com>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-mm@kvack.org
Subject: [PATCH AUTOSEL 4.19 009/141] mem-hotplug: fix node spanned pages when we have a node with only ZONE_MOVABLE
Date:   Sat,  1 Jun 2019 09:19:45 -0400
Message-Id: <20190601132158.25821-9-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190601132158.25821-1-sashal@kernel.org>
References: <20190601132158.25821-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linxu Fang <fanglinxu@huawei.com>

[ Upstream commit 299c83dce9ea3a79bb4b5511d2cb996b6b8e5111 ]

342332e6a925 ("mm/page_alloc.c: introduce kernelcore=mirror option") and
later patches rewrote the calculation of node spanned pages.

e506b99696a2 ("mem-hotplug: fix node spanned pages when we have a movable
node"), but the current code still has problems,

When we have a node with only zone_movable and the node id is not zero,
the size of node spanned pages is double added.

That's because we have an empty normal zone, and zone_start_pfn or
zone_end_pfn is not between arch_zone_lowest_possible_pfn and
arch_zone_highest_possible_pfn, so we need to use clamp to constrain the
range just like the commit <96e907d13602> (bootmem: Reimplement
__absent_pages_in_range() using for_each_mem_pfn_range()).

e.g.
Zone ranges:
  DMA      [mem 0x0000000000001000-0x0000000000ffffff]
  DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
  Normal   [mem 0x0000000100000000-0x000000023fffffff]
Movable zone start for each node
  Node 0: 0x0000000100000000
  Node 1: 0x0000000140000000
Early memory node ranges
  node   0: [mem 0x0000000000001000-0x000000000009efff]
  node   0: [mem 0x0000000000100000-0x00000000bffdffff]
  node   0: [mem 0x0000000100000000-0x000000013fffffff]
  node   1: [mem 0x0000000140000000-0x000000023fffffff]

node 0 DMA	spanned:0xfff   present:0xf9e   absent:0x61
node 0 DMA32	spanned:0xff000 present:0xbefe0	absent:0x40020
node 0 Normal	spanned:0	present:0	absent:0
node 0 Movable	spanned:0x40000 present:0x40000 absent:0
On node 0 totalpages(node_present_pages): 1048446
node_spanned_pages:1310719
node 1 DMA	spanned:0	    present:0		absent:0
node 1 DMA32	spanned:0	    present:0		absent:0
node 1 Normal	spanned:0x100000    present:0x100000	absent:0
node 1 Movable	spanned:0x100000    present:0x100000	absent:0
On node 1 totalpages(node_present_pages): 2097152
node_spanned_pages:2097152
Memory: 6967796K/12582392K available (16388K kernel code, 3686K rwdata,
4468K rodata, 2160K init, 10444K bss, 5614596K reserved, 0K
cma-reserved)

It shows that the current memory of node 1 is double added.
After this patch, the problem is fixed.

node 0 DMA	spanned:0xfff   present:0xf9e   absent:0x61
node 0 DMA32	spanned:0xff000 present:0xbefe0	absent:0x40020
node 0 Normal	spanned:0	present:0	absent:0
node 0 Movable	spanned:0x40000 present:0x40000 absent:0
On node 0 totalpages(node_present_pages): 1048446
node_spanned_pages:1310719
node 1 DMA	spanned:0	    present:0		absent:0
node 1 DMA32	spanned:0	    present:0		absent:0
node 1 Normal	spanned:0	    present:0		absent:0
node 1 Movable	spanned:0x100000    present:0x100000	absent:0
On node 1 totalpages(node_present_pages): 1048576
node_spanned_pages:1048576
memory: 6967796K/8388088K available (16388K kernel code, 3686K rwdata,
4468K rodata, 2160K init, 10444K bss, 1420292K reserved, 0K
cma-reserved)

Link: http://lkml.kernel.org/r/1554178276-10372-1-git-send-email-fanglinxu@huawei.com
Signed-off-by: Linxu Fang <fanglinxu@huawei.com>
Cc: Taku Izumi <izumi.taku@jp.fujitsu.com>
Cc: Xishi Qiu <qiuxishi@huawei.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Pavel Tatashin <pavel.tatashin@microsoft.com>
Cc: Oscar Salvador <osalvador@suse.de>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/page_alloc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 8e6932a140b82..2d04bd2e1ced7 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5937,13 +5937,15 @@ static unsigned long __meminit zone_spanned_pages_in_node(int nid,
 					unsigned long *zone_end_pfn,
 					unsigned long *ignored)
 {
+	unsigned long zone_low = arch_zone_lowest_possible_pfn[zone_type];
+	unsigned long zone_high = arch_zone_highest_possible_pfn[zone_type];
 	/* When hotadd a new node from cpu_up(), the node should be empty */
 	if (!node_start_pfn && !node_end_pfn)
 		return 0;
 
 	/* Get the start and end of the zone */
-	*zone_start_pfn = arch_zone_lowest_possible_pfn[zone_type];
-	*zone_end_pfn = arch_zone_highest_possible_pfn[zone_type];
+	*zone_start_pfn = clamp(node_start_pfn, zone_low, zone_high);
+	*zone_end_pfn = clamp(node_end_pfn, zone_low, zone_high);
 	adjust_zone_range_for_zone_movable(nid, zone_type,
 				node_start_pfn, node_end_pfn,
 				zone_start_pfn, zone_end_pfn);
-- 
2.20.1

