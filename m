Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB1E8C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 09:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D127214AE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 09:18:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="Yd8XmSUa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387892AbfIMJS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 05:18:57 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40780 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387424AbfIMJS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 05:18:57 -0400
Received: by mail-ed1-f68.google.com with SMTP id v38so26428503edm.7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 02:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P+McjP7Vs/8Fdw818QwhQTYN2XV5u34Z3buqpTv4oXc=;
        b=Yd8XmSUaTaf5ZXgKPRqAuXJjkPnnIKhtkUDGK4eSkYWR2z+WrZsHrkfoEoYge1pAwM
         O/9uvHx98sl6+wB8+0mZewgDrizHc6Y40mM2Vil7twDyF3v9EabEVJD+ytCFQe63erMX
         cJU3UlfGLt5Nkbmnt2u/lrGZwZQt/MyteUxnz+N8+8PTtjBumNMjS2GygxXoPBjtNKIu
         Qx4uNIPEV6oFHzd5xUoMrkdM/07AQaZ0n+Cl0xs6QOYmtdAdQezQWuEio2R6Xvvz4NFB
         O9zIEae/QqfUSiWX9+uc+Vr4thoL6wlrqqs/TqdTe2s/UmYz5D0XXa/HirqYkU3UreWM
         tdig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P+McjP7Vs/8Fdw818QwhQTYN2XV5u34Z3buqpTv4oXc=;
        b=DW2A/iPmWnqak8aDqHYD158yrm1tYrXaNxPbp4R0Ewu9U4aeLb7ukTaXcbl2jb2ISz
         ZsHLjekF0/m1HyqzSCmR9Eb+VYonrDJAz4fdy4lAtwKAO9jar7LbBbBLxh3eQ2mDT0qd
         /QIzn2CUrfHxF8zQhHbEcC2chzU2hkXa1VHSnZ30OWRNXk7aeoWpa2cSoSBMADri029r
         VtsSWzUXwMZtM+jw6DWlXpgrvQ9ynU4652QHt1o0NY1wM/vY5KP9JIgmAmfQfSo8vw8n
         0uiPcxq6Pv4MjN5+UdrizEmWLFGTkXNASUVf9g8bIokLM1t6v5pTlchNZB26DFzmQaOs
         unVA==
X-Gm-Message-State: APjAAAWVrZoyjSFV5g06b1Mr7G2tLEpjSekpaklIhum7Dx/OXrZ4uCX5
        SYvjvaIytZ+wRxS+cOzZ8Sr44LN6TvhNKg==
X-Google-Smtp-Source: APXvYqxrvAdCPt/mVZYhIV/ppIx9ZAjVNEE6Dhb2/z3ku9W3ZB6upKxDogwZJJt3jIDzN3+F9eEpEA==
X-Received: by 2002:a50:c351:: with SMTP id q17mr9016890edb.123.1568366333883;
        Fri, 13 Sep 2019 02:18:53 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id j20sm5201057edy.95.2019.09.13.02.18.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Sep 2019 02:18:53 -0700 (PDT)
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
X-Google-Original-From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Received: by box.localdomain (Postfix, from userid 1000)
        id 3A8F510160B; Fri, 13 Sep 2019 12:18:55 +0300 (+03)
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH] mm, thp: Do not queue fully unmapped pages for deferred split
Date:   Fri, 13 Sep 2019 12:18:49 +0300
Message-Id: <20190913091849.11151-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding fully unmapped pages into deferred split queue is not productive:
these pages are about to be freed or they are pinned and cannot be split
anyway.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 mm/rmap.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index 003377e24232..45388f1bf317 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1271,12 +1271,20 @@ static void page_remove_anon_compound_rmap(struct page *page)
 	if (TestClearPageDoubleMap(page)) {
 		/*
 		 * Subpages can be mapped with PTEs too. Check how many of
-		 * themi are still mapped.
+		 * them are still mapped.
 		 */
 		for (i = 0, nr = 0; i < HPAGE_PMD_NR; i++) {
 			if (atomic_add_negative(-1, &page[i]._mapcount))
 				nr++;
 		}
+
+		/*
+		 * Queue the page for deferred split if at least one small
+		 * page of the compound page is unmapped, but at least one
+		 * small page is still mapped.
+		 */
+		if (nr && nr < HPAGE_PMD_NR)
+			deferred_split_huge_page(page);
 	} else {
 		nr = HPAGE_PMD_NR;
 	}
@@ -1284,10 +1292,8 @@ static void page_remove_anon_compound_rmap(struct page *page)
 	if (unlikely(PageMlocked(page)))
 		clear_page_mlock(page);
 
-	if (nr) {
+	if (nr)
 		__mod_node_page_state(page_pgdat(page), NR_ANON_MAPPED, -nr);
-		deferred_split_huge_page(page);
-	}
 }
 
 /**
-- 
2.21.0

