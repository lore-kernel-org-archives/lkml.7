Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05ADACA9EB7
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 14:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9730218AE
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 14:48:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="mxq29U7K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387786AbfJVOsU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 10:48:20 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46535 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730076AbfJVOsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 10:48:18 -0400
Received: by mail-qt1-f194.google.com with SMTP id u22so27093511qtq.13
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 07:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q6d0e71c1U6ZW8RKPMSK80x36zGerojsdp9LXPgfjJI=;
        b=mxq29U7KFf8nIL2EPYKGYZG3PSPLfnfyyUP3N9kMMBJep9Noe7BqgaM7RFDkI//avH
         +lWfp9sEakhlXGJS7YoZspH/bCa783BlFJaZLulfx06SkaVO6nseVrPLlE02uM46F5BT
         aXX+S5xo0gm2UsAhO2A+VmjIUQsL1r/v4PvaaiE2y1ld5cy0y2xidgDz/jYugGswM5YV
         XXV8qKlJgxAtFWHtk1MlF7jqqYsu3cW2zhBUYJ9MJyMxm8kVj4CL23AeGxB9bcLq1Cws
         cSqoKgFqCMpFHjtqd2m7RkiZsKaft0d6fZFpH0OP4v5ikJ/CxQXmt9q7gy7W0QOWLeLy
         G68g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q6d0e71c1U6ZW8RKPMSK80x36zGerojsdp9LXPgfjJI=;
        b=Yt4rUay80/tiHEtsYODqtgU1eHtyqH9cqgfiNyyFfODrUjzUtAvlxdlGTl5H/iCNEM
         VmOnk5MEY0HEdocz9wtF68amngNBEAps8S9Bmyj3vgb9zWVm16I28EwtZnrzZpoYPQWS
         oljRsyukxiiyayUL8yUhAu+Qky+NBR1XQrA5u/fRz1OKIp/aHkwnU0lOUEVBjcS4m0G+
         C+nkfr3zp/8X9J02Dx6wnvoiL9Wu3QRi20h01L1GXKpg+Hb/hpMskAFne+AKYKLLk99m
         jUtlXx5HCh5+TsqH0ZjN/TLUXqvVjfLh/IyPGaN37tkfTNhTKVtd/ojZ/+60ZhiM3aSo
         29RQ==
X-Gm-Message-State: APjAAAV/xNUoDs7/dbvLbzObLy4IT/VRUFBv1SU2LxkjISj3px0tyZ5G
        Cd/VWCug+UrRJWi+PZFqLNv/GQ==
X-Google-Smtp-Source: APXvYqxLvuowjOIIcKYn75H2RxPI6SfUMcvB5TDKG/Hu0VfyuATYs1IGLTNo2b4pr6S1lKK5e7BkVg==
X-Received: by 2002:ac8:6146:: with SMTP id d6mr3741857qtm.271.1571755697749;
        Tue, 22 Oct 2019 07:48:17 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::3:10ad])
        by smtp.gmail.com with ESMTPSA id p4sm10518531qkf.112.2019.10.22.07.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 07:48:17 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 3/8] mm: vmscan: move inactive_list_is_low() swap check to the caller
Date:   Tue, 22 Oct 2019 10:47:58 -0400
Message-Id: <20191022144803.302233-4-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191022144803.302233-1-hannes@cmpxchg.org>
References: <20191022144803.302233-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

inactive_list_is_low() should be about one thing: checking the ratio
between inactive and active list. Kitchensink checks like the one for
swap space makes the function hard to use and modify its
callsites. Luckly, most callers already have an understanding of the
swap situation, so it's easy to clean up.

get_scan_count() has its own, memcg-aware swap check, and doesn't even
get to the inactive_list_is_low() check on the anon list when there is
no swap space available.

shrink_list() is called on the results of get_scan_count(), so that
check is redundant too.

age_active_anon() has its own totalswap_pages check right before it
checks the list proportions.

The shrink_node_memcg() site is the only one that doesn't do its own
swap check. Add it there.

Then delete the swap check from inactive_list_is_low().

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/vmscan.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index be3c22c274c1..622b77488144 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2226,13 +2226,6 @@ static bool inactive_list_is_low(struct lruvec *lruvec, bool file,
 	unsigned long refaults;
 	unsigned long gb;
 
-	/*
-	 * If we don't have swap space, anonymous page deactivation
-	 * is pointless.
-	 */
-	if (!file && !total_swap_pages)
-		return false;
-
 	inactive = lruvec_lru_size(lruvec, inactive_lru, sc->reclaim_idx);
 	active = lruvec_lru_size(lruvec, active_lru, sc->reclaim_idx);
 
@@ -2653,7 +2646,7 @@ static void shrink_node_memcg(struct pglist_data *pgdat, struct mem_cgroup *memc
 	 * Even if we did not try to evict anon pages at all, we want to
 	 * rebalance the anon lru active/inactive ratio.
 	 */
-	if (inactive_list_is_low(lruvec, false, sc, true))
+	if (total_swap_pages && inactive_list_is_low(lruvec, false, sc, true))
 		shrink_active_list(SWAP_CLUSTER_MAX, lruvec,
 				   sc, LRU_ACTIVE_ANON);
 }
-- 
2.23.0

