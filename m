Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0CB9C072A4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 03:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDDB620449
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 03:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558324404;
	bh=kMvOfWGOrzLg4iBk8UqjCq2nCTldLJI6SJZezhK7wwM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ou5OC9Zwj0U28g7LqRHbjM6HVlLq7kTV49fXR3MHY+fKpjM20hluuWgaB41MyWZvn
	 cZjjfAXPL3UGQPa0cfsF64wTw+lfkf8o2Atx6MGY3qkuP9SPbHh9aKD2d3y+qYuMfS
	 b6/DX8NTBgCOGawpgQC1d2sgguIORLfLpci35xD4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729928AbfETDxO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 May 2019 23:53:14 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39292 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbfETDxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 May 2019 23:53:13 -0400
Received: by mail-pl1-f193.google.com with SMTP id g9so6040184plm.6
        for <linux-kernel@vger.kernel.org>; Sun, 19 May 2019 20:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=toPMA/JKL4+JCLITlgbKXa8Kcq8nIXcYZEy8G8dwb38=;
        b=m97MBGV8NBC+cNZm03BDXSfBTqmp4sA5sC300y9OchQG14lFyRfXZJxdfo2GW5E1Bb
         c3a2eND70z1kSueovPmNTmqKCpC99rpeTQndsDVUf33inyAsKgA6/RsH6E/gncjywccA
         vuM7cpJGZEfgjvvX222Uu1QRUDmeJ+PYc75lPHqnU+P/W987PxW3xyUbJChZSE6eMGyx
         cyN5a8kSJdLmiQhXGuthrx0P9H5qOS/gEWmOhYkfBZffzX36ft3VXIMnJACry2QLWwRS
         DR3UDJCoEm2n1/IbKW2+5zR3mM4UNJnM5ITqNNd3i5AbZ4bw07uLzmsXqbjkURtuljj3
         ug5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=toPMA/JKL4+JCLITlgbKXa8Kcq8nIXcYZEy8G8dwb38=;
        b=ZIS8iowopUGdM1CroouCra+YZDXD0uxKmAu2yQrLisVyCnpiUSmbA5LhCTxLtroXjT
         PR2VKVDUIWuTKpB6lfTpxc3uAUE9d0gdISOq42uZG/CsMz1nPq0lNi/EgJQnWfE8EHsx
         isJWGyys6WzR6o5Pt7B6pCzPSHC2nG2R5x6amtW2lNI9zGi6eYMBm7nmlzx8EPN9Y9ln
         6IFtRm5IhLBKDBK0YRs/NmtFpi+cbk6jPksbY/RnmxcRMBEWt7ikxexZJX7HF6c4xXlk
         EHFxKrTIRSgEgKouyEL2lvrbnuEsOhOiBZj2OY0WPXhjSa0AZYXlyJzJrS8GxOdDD8HP
         xhNA==
X-Gm-Message-State: APjAAAXvtsLq8ZH2VX/Opwm9lIliQm4GcQ1ShVQOECapv2uPeYeElf3W
        OVEumpcX9m1rUEWDtbOt2tc=
X-Google-Smtp-Source: APXvYqw1v+/XqFbH4qE/picLm8gJqscGg2vCb7a2xfoSbRTwDaEwwBRsuHR2FujTc9592q32a1eZZg==
X-Received: by 2002:a17:902:d892:: with SMTP id b18mr29342232plz.216.1558324393052;
        Sun, 19 May 2019 20:53:13 -0700 (PDT)
Received: from bbox-2.seo.corp.google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id x66sm3312779pfx.139.2019.05.19.20.53.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 May 2019 20:53:12 -0700 (PDT)
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Colascione <dancol@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Minchan Kim <minchan@kernel.org>
Subject: [RFC 2/7] mm: change PAGEREF_RECLAIM_CLEAN with PAGE_REFRECLAIM
Date:   Mon, 20 May 2019 12:52:49 +0900
Message-Id: <20190520035254.57579-3-minchan@kernel.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190520035254.57579-1-minchan@kernel.org>
References: <20190520035254.57579-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The local variable references in shrink_page_list is PAGEREF_RECLAIM_CLEAN
as default. It is for preventing to reclaim dirty pages when CMA try to
migrate pages. Strictly speaking, we don't need it because CMA didn't allow
to write out by .may_writepage = 0 in reclaim_clean_pages_from_list.

Moreover, it has a problem to prevent anonymous pages's swap out even
though force_reclaim = true in shrink_page_list on upcoming patch.
So this patch makes references's default value to PAGEREF_RECLAIM and
rename force_reclaim with skip_reference_check to make it more clear.

This is a preparatory work for next patch.

Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 mm/vmscan.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index d9c3e873eca6..a28e5d17b495 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1102,7 +1102,7 @@ static unsigned long shrink_page_list(struct list_head *page_list,
 				      struct scan_control *sc,
 				      enum ttu_flags ttu_flags,
 				      struct reclaim_stat *stat,
-				      bool force_reclaim)
+				      bool skip_reference_check)
 {
 	LIST_HEAD(ret_pages);
 	LIST_HEAD(free_pages);
@@ -1116,7 +1116,7 @@ static unsigned long shrink_page_list(struct list_head *page_list,
 		struct address_space *mapping;
 		struct page *page;
 		int may_enter_fs;
-		enum page_references references = PAGEREF_RECLAIM_CLEAN;
+		enum page_references references = PAGEREF_RECLAIM;
 		bool dirty, writeback;
 
 		cond_resched();
@@ -1248,7 +1248,7 @@ static unsigned long shrink_page_list(struct list_head *page_list,
 			}
 		}
 
-		if (!force_reclaim)
+		if (!skip_reference_check)
 			references = page_check_references(page, sc);
 
 		switch (references) {
-- 
2.21.0.1020.gf2820cf01a-goog

