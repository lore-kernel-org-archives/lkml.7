Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38FFDC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13E0A2075C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:28:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbfCRJ2P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:28:15 -0400
Received: from relay.sw.ru ([185.231.240.75]:41434 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728002AbfCRJ2H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 05:28:07 -0400
Received: from [172.16.25.169] (helo=localhost.localdomain)
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1h5oYv-00055C-LZ; Mon, 18 Mar 2019 12:28:05 +0300
Subject: [PATCH REBASED 2/4] mm: Move nr_deactivate accounting to
 shrink_active_list()
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     akpm@linux-foundation.org, daniel.m.jordan@oracle.com,
        mhocko@suse.com, ktkhai@virtuozzo.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 18 Mar 2019 12:28:05 +0300
Message-ID: <155290128498.31489.18250485448913338607.stgit@localhost.localdomain>
In-Reply-To: <155290113594.31489.16711525148390601318.stgit@localhost.localdomain>
References: <155290113594.31489.16711525148390601318.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We know which LRU is not active.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>
---
 mm/vmscan.c |   10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index e610737b36df..d2adabe4457d 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2040,12 +2040,6 @@ static unsigned move_active_pages_to_lru(struct lruvec *lruvec,
 		}
 	}
 
-	if (!is_active_lru(lru)) {
-		__count_vm_events(PGDEACTIVATE, nr_moved);
-		count_memcg_events(lruvec_memcg(lruvec), PGDEACTIVATE,
-				   nr_moved);
-	}
-
 	return nr_moved;
 }
 
@@ -2137,6 +2131,10 @@ static void shrink_active_list(unsigned long nr_to_scan,
 
 	nr_activate = move_active_pages_to_lru(lruvec, &l_active, &l_hold, lru);
 	nr_deactivate = move_active_pages_to_lru(lruvec, &l_inactive, &l_hold, lru - LRU_ACTIVE);
+
+	__count_vm_events(PGDEACTIVATE, nr_deactivate);
+	__count_memcg_events(lruvec_memcg(lruvec), PGDEACTIVATE, nr_deactivate);
+
 	__mod_node_page_state(pgdat, NR_ISOLATED_ANON + file, -nr_taken);
 	spin_unlock_irq(&pgdat->lru_lock);
 

