Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E37E0C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 01:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE9CF2146E
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 01:55:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DUnVyYNN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbfF1BzZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 21:55:25 -0400
Received: from mail-yb1-f202.google.com ([209.85.219.202]:44402 "EHLO
        mail-yb1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbfF1BzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 21:55:25 -0400
Received: by mail-yb1-f202.google.com with SMTP id f2so5062642ybm.11
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 18:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=u6lsjuf98Kc/AH/lf0BUkh49bExoluT1S4n6ULTuKFE=;
        b=DUnVyYNN/gyqqnMjGKvOykd2YEMoFihsuKcNBpRiSYPenqIhA+Elq8/BHiIoW5qUOu
         btbWSyb52Whtu9ZpklkijJ16YRH3rBjx0uHKdwTjCIE1GQe+Lv4KgSZV1bKUBllCZ6aH
         fX2fpeKFG1jVPsbtlsxk1tOly+mFGT1x2b9f2ih+K8so+vZ/hfOD8fSEyJQ1kkNMCeRg
         4+5X6QfBrnXVlL209DLeJGIAF9hIs1bB3G1zPRMNJufafofGAgbgVV1THZnbJsJR8Bl3
         TeUl79Oj8sJ7UoxTAD2/0I7RL3QBFVvZ34CaD0GlgAjgb4QPG8wnM8F4dpvrjZVi5LWC
         4Log==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=u6lsjuf98Kc/AH/lf0BUkh49bExoluT1S4n6ULTuKFE=;
        b=Jc0uazxcgZP2k8nzz/bE5jYcWHMNz49UqJHJda7EfFOxSHD377foJ31Z2z2cWMvSFB
         qyKltJQv+Q0OV8/Gj0W2LD+/G46rfKovsLmMoblrsL/RnoyUQrPAPWzCXo0oR8ckcS73
         G4ukM46dQOVsxdC5rdh91J/vY+sIkUiSRkrPc8oIfQM3f7ZOQBJN2cISPOue/+NfuyN6
         wfYp6qdPNCPENEnyKlfQvcNc9Rvk+U2CuxgRy/PForsCdkWCU+1CmMZ3zGl6gSrR7AMd
         QD+oFufHZuFO6sutDB7p7kArSP9dmmpLHVpWZFgfpMeErYp6AJDwOpECfbM31k/Ckn08
         vbzw==
X-Gm-Message-State: APjAAAVVx3qHVZSegTT4RFKBKs5oeZzIaeBaxdarmIODgRNoaVwOMeI9
        3EPhi33FRkPxfh/du8X9YTNGi/VypxUN9A==
X-Google-Smtp-Source: APXvYqy7kjsd2xZhLd9HeGYNnKXRtvsGfFIL3x87rWz9m3sV7Arul7UieQMVekqzHVNsha/Z2VCam04Vm5F9eg==
X-Received: by 2002:a5b:8c7:: with SMTP id w7mr4666324ybq.242.1561686924273;
 Thu, 27 Jun 2019 18:55:24 -0700 (PDT)
Date:   Thu, 27 Jun 2019 18:55:20 -0700
Message-Id: <20190628015520.13357-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH] mm, vmscan: prevent useless kswapd loops
From:   Shakeel Butt <shakeelb@google.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hillf Danton <hdanton@sina.com>, Roman Gushchin <guro@fb.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On production we have noticed hard lockups on large machines running
large jobs due to kswaps hoarding lru lock within isolate_lru_pages when
sc->reclaim_idx is 0 which is a small zone. The lru was couple hundred
GiBs and the condition (page_zonenum(page) > sc->reclaim_idx) in
isolate_lru_pages was basically skipping GiBs of pages while holding the
LRU spinlock with interrupt disabled.

On further inspection, it seems like there are two issues:

1) If the kswapd on the return from balance_pgdat() could not sleep
(maybe all zones are still unbalanced), the classzone_idx is set to 0,
unintentionally, and the whole reclaim cycle of kswapd will try to reclaim
only the lowest and smallest zone while traversing the whole memory.

2) Fundamentally isolate_lru_pages() is really bad when the allocation
has woken kswapd for a smaller zone on a very large machine running very
large jobs. It can hoard the LRU spinlock while skipping over 100s of
GiBs of pages.

This patch only fixes the (1). The (2) needs a more fundamental solution.

Fixes: e716f2eb24de ("mm, vmscan: prevent kswapd sleeping prematurely
due to mismatched classzone_idx")
Signed-off-by: Shakeel Butt <shakeelb@google.com>
---
 mm/vmscan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 9e3292ee5c7c..786dacfdfe29 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3908,7 +3908,7 @@ static int kswapd(void *p)
 
 		/* Read the new order and classzone_idx */
 		alloc_order = reclaim_order = pgdat->kswapd_order;
-		classzone_idx = kswapd_classzone_idx(pgdat, 0);
+		classzone_idx = kswapd_classzone_idx(pgdat, classzone_idx);
 		pgdat->kswapd_order = 0;
 		pgdat->kswapd_classzone_idx = MAX_NR_ZONES;
 
-- 
2.22.0.410.gd8fdbe21b5-goog

