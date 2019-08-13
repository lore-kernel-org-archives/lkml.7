Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66066C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 03:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37B3F206C1
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 03:37:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fkKf6iOZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727200AbfHMDhO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 23:37:14 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46880 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbfHMDhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 23:37:14 -0400
Received: by mail-pf1-f195.google.com with SMTP id q139so2484068pfc.13
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 20:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=U2rgZkOq9HT91hzWNExU4fX+p045xHF1HOOjlqdf1zA=;
        b=fkKf6iOZrRUIos/4KB+ONcWJx727j5krY4+u0KUS0QOXRDwqv/rJDwABv3ZLzmVf5w
         8xmZ8/eRKR+I/ePFlrj6N9GazIvQDfzQDowOgRpbA+c8sH4xAXAZ1UhccfGFKYnWAsfA
         V278P84EVpEe3L4VZdjuKkc8amARtiZFMeQNq8BvEqf/r2/Bvgx0Hisce67iDqw1P48N
         x7UWk4KD/VDaY2cm3BBSBgY2o3TJJELz9s7OOJedw9hUAhL2FxAbTpa/MEoeVV6pYQSt
         0gxqT5RhXgQ5gZ1WJtWigGKiAnlAe7qOyU5Fo7yzq9aNvA9rWw6wNBWH+iaf5Oswwx6m
         JPUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=U2rgZkOq9HT91hzWNExU4fX+p045xHF1HOOjlqdf1zA=;
        b=dyJwAKDSQ6FFbQJGfSadjk++HO+BSjziJzzdqSsfa7bihoExDwCR9wMVRC849jsO06
         c2OgUAqw7/TkR7oJ9rugqKYZXj9AiTtJHQZ1vaCujKsy4ROVKBu9bD9p0dwPrkmxXoD6
         V4S8JaTS+UD5cO5U5dAuNkY+1GOui8nD/ktEDpnB4nEEJyxNIX71n8BiPcyCUwWM1KQN
         wGUdKsLBJBOxY8Ku0fDyzIYYywCcdqn/0TG529zEvS3/BUISJQ9Jm+GP67LsxTfcCxXA
         uO4m3+jMdNJlV3sXn8J4kLcIc8vqFc+8nWsLs4LbryTFd9VG71tAWT4mO/omwNYUgiRp
         FIzQ==
X-Gm-Message-State: APjAAAXLLFY8VeBt6oNMOxOobyW+gLyN8hQAcdVM4lT9cwHLp6c5Dmei
        5CqTyl3ZSi03AGSPsfU8VwiHylJXuH4=
X-Google-Smtp-Source: APXvYqwKcgMErg7JEDUy+wyLR524SPRvaaxPz/kLU2UjT/EztHP9fc+lWMa2kSOuptbwsVl4ppDV0w==
X-Received: by 2002:a62:5c01:: with SMTP id q1mr39002258pfb.53.1565667433116;
        Mon, 12 Aug 2019 20:37:13 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id u18sm54897pfl.29.2019.08.12.20.37.12
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 20:37:12 -0700 (PDT)
Date:   Mon, 12 Aug 2019 20:37:11 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Vlastimil Babka <vbabka@suse.cz>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Mel Gorman <mgorman@techsingularity.net>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [patch] mm, page_alloc: move_freepages should not examine struct
 page of reserved memory
Message-ID: <alpine.DEB.2.21.1908122036560.10779@chino.kir.corp.google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit 907ec5fca3dc ("mm: zero remaining unavailable struct pages"),
struct page of reserved memory is zeroed.  This causes page->flags to be 0
and fixes issues related to reading /proc/kpageflags, for example, of
reserved memory.

The VM_BUG_ON() in move_freepages_block(), however, assumes that
page_zone() is meaningful even for reserved memory.  That assumption is no
longer true after the aforementioned commit.

There's no reason why move_freepages_block() should be testing the
legitimacy of page_zone() for reserved memory; its scope is limited only
to pages on the zone's freelist.

Note that pfn_valid() can be true for reserved memory: there is a backing
struct page.  The check for page_to_nid(page) is also buggy but reserved
memory normally only appears on node 0 so the zeroing doesn't affect this.

Move the debug checks to after verifying PageBuddy is true.  This isolates
the scope of the checks to only be for buddy pages which are on the zone's
freelist which move_freepages_block() is operating on.  In this case, an
incorrect node or zone is a bug worthy of being warned about (and the
examination of struct page is acceptable bcause this memory is not
reserved).

Signed-off-by: David Rientjes <rientjes@google.com>
---
 mm/page_alloc.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2238,27 +2238,12 @@ static int move_freepages(struct zone *zone,
 	unsigned int order;
 	int pages_moved = 0;
 
-#ifndef CONFIG_HOLES_IN_ZONE
-	/*
-	 * page_zone is not safe to call in this context when
-	 * CONFIG_HOLES_IN_ZONE is set. This bug check is probably redundant
-	 * anyway as we check zone boundaries in move_freepages_block().
-	 * Remove at a later date when no bug reports exist related to
-	 * grouping pages by mobility
-	 */
-	VM_BUG_ON(pfn_valid(page_to_pfn(start_page)) &&
-	          pfn_valid(page_to_pfn(end_page)) &&
-	          page_zone(start_page) != page_zone(end_page));
-#endif
 	for (page = start_page; page <= end_page;) {
 		if (!pfn_valid_within(page_to_pfn(page))) {
 			page++;
 			continue;
 		}
 
-		/* Make sure we are not inadvertently changing nodes */
-		VM_BUG_ON_PAGE(page_to_nid(page) != zone_to_nid(zone), page);
-
 		if (!PageBuddy(page)) {
 			/*
 			 * We assume that pages that could be isolated for
@@ -2273,6 +2258,10 @@ static int move_freepages(struct zone *zone,
 			continue;
 		}
 
+		/* Make sure we are not inadvertently changing nodes */
+		VM_BUG_ON_PAGE(page_to_nid(page) != zone_to_nid(zone), page);
+		VM_BUG_ON_PAGE(page_zone(page) != zone, page);
+
 		order = page_order(page);
 		move_to_free_area(page, &zone->free_area[order], migratetype);
 		page += 1 << order;
