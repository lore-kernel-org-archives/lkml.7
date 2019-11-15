Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB7B3C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 14:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D3B12073A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 14:05:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="oD+ifSS2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727506AbfKOOFj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 09:05:39 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:42540 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727380AbfKOOFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 09:05:39 -0500
Received: by mail-qv1-f67.google.com with SMTP id n4so688762qvq.9
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 06:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=yP6sLpOI5gMHsWCnZ/lSHS0qOmzpZuHlPWbPumaUgRc=;
        b=oD+ifSS2SKqGImF4vBVAx87ixxYxtspxZw6PhenI10A2wEXjPO29zGqx1N9Wd0+4LH
         +xUQZe/Gxq2fg34qiWpzCEYKWDRugT8UF4ruFaaMeU3kgMdXOrvzhHfSXkhocNp3OOQO
         xoH/JYJv0F7hUkK4xTYbb+0j/2Xu9syfn9BagNvtVCCxUkg+GubztuWtiThoFt8EGcEr
         ARxbR1SyJ2MAChtAe3EuiQ73LUxk0DMdKlP/801OcACVB2F5UwVqXNjAJEPK+hW2SKf+
         V51cNhtnRuomj1wKxenCSgk/3EBwiWMKKaqpRQQVtyJUXOiHCh/k9+MIhcijTCxodZSK
         iK7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yP6sLpOI5gMHsWCnZ/lSHS0qOmzpZuHlPWbPumaUgRc=;
        b=tc8NLj6xyr1A4isGD876fzGyymMWW1NSGTaOqlsB2MJWB3Of0QvVF+jRJpn17BBA0M
         PyNtV4L4GwXwMx81PEnfD532Iao1Gbx2X4uU9lramBtDDDfV/Mlijrl+Y5UfpMbAKOQE
         O5keOk979KYa6OSuH/LEeo7e1DTEkx5aY3W//DVwQwc8n94upSJrC0wFUcLjc0u6AcYD
         QpkZdeQiTbGUQVanIfmnDtjLBVP2detTiVUZBwTetnB5AY28TDmmtEcSLJrwVkYqnRog
         BLcn2FO9uu+C9oY+gzjTc+w8VINPS2xzS09ysI0i9JKKo31PuwCaF/Gaf0gw6GbB29Vy
         k4sQ==
X-Gm-Message-State: APjAAAVWjvkFHp1DmR1I/GJPTbJ9ZDqhQoGuK6YLPUm1wzoyzzk7/GrM
        B9BoO0hyYRwJNHQyxlYf2P3xeQ==
X-Google-Smtp-Source: APXvYqxx+BgTj06EwM9BZfvsjh6JPSIXQtx4APEYcMMw1ZXobyEcgnrGVoKzFyNUCOpPdoBzLYnVQQ==
X-Received: by 2002:ad4:42a8:: with SMTP id e8mr13473546qvr.217.1573826738297;
        Fri, 15 Nov 2019 06:05:38 -0800 (PST)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id j10sm4989769qtb.34.2019.11.15.06.05.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Nov 2019 06:05:37 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, surenb@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH -next] mm/vmscan: fix some -Wenum-conversion warnings
Date:   Fri, 15 Nov 2019 09:04:57 -0500
Message-Id: <1573826697-869-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The -next commit "mm: vmscan: enforce inactive:active ratio at the
reclaim root" [1] introduced some GCC -Wenum-conversion warnings,

mm/vmscan.c:2216:39: warning: implicit conversion from enumeration type
'enum lru_list' to different enumeration type 'enum node_stat_item'
[-Wenum-conversion]
        inactive = lruvec_page_state(lruvec, inactive_lru);
                   ~~~~~~~~~~~~~~~~~         ^~~~~~~~~~~~
mm/vmscan.c:2217:37: warning: implicit conversion from enumeration type
'enum lru_list' to different enumeration type 'enum node_stat_item'
[-Wenum-conversion]
        active = lruvec_page_state(lruvec, active_lru);
                 ~~~~~~~~~~~~~~~~~         ^~~~~~~~~~
mm/vmscan.c:2746:42: warning: implicit conversion from enumeration type
'enum lru_list' to different enumeration type 'enum node_stat_item'
[-Wenum-conversion]
        file = lruvec_page_state(target_lruvec, LRU_INACTIVE_FILE);
               ~~~~~~~~~~~~~~~~~                ^~~~~~~~~~~~~~~~~

Fix them by adding casts where it is safe.

[1] http://lkml.kernel.org/r/20191107205334.158354-4-hannes@cmpxchg.org

Signed-off-by: Qian Cai <cai@lca.pw>
---
 mm/vmscan.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 122b3920aaa4..16c005ddfd9e 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2213,8 +2213,9 @@ static bool inactive_is_low(struct lruvec *lruvec, enum lru_list inactive_lru)
 	unsigned long inactive_ratio;
 	unsigned long gb;
 
-	inactive = lruvec_page_state(lruvec, inactive_lru);
-	active = lruvec_page_state(lruvec, active_lru);
+	inactive = lruvec_page_state(lruvec,
+				     (enum node_stat_item)inactive_lru);
+	active = lruvec_page_state(lruvec, (enum node_stat_item)active_lru);
 
 	gb = (inactive + active) >> (30 - PAGE_SHIFT);
 	if (gb)
@@ -2743,7 +2744,8 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 	 * thrashing, try to reclaim those first before touching
 	 * anonymous pages.
 	 */
-	file = lruvec_page_state(target_lruvec, LRU_INACTIVE_FILE);
+	file = lruvec_page_state(target_lruvec,
+				 (enum node_stat_item)LRU_INACTIVE_FILE);
 	if (file >> sc->priority && !(sc->may_deactivate & DEACTIVATE_FILE))
 		sc->cache_trim_mode = 1;
 	else
-- 
1.8.3.1

