Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D2A1C28CC6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 22:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AD0A2677A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 22:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="jQQKpymP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbfFCWHI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 18:07:08 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38900 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbfFCWHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 18:07:07 -0400
Received: by mail-pf1-f194.google.com with SMTP id a186so10680522pfa.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 15:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0EoeyvI+6nSZVdPsXoo6A3bLjv7jCmnakg13/Vo0S7g=;
        b=jQQKpymP0x+HXM6AidEDpl+oryXhrFlsULaSJxrk+bRuLIK2zph32NK7fQ9YAJaCBe
         N7+enaR2Vc1oYLo8aptLEfjl+dIsZ+yBuVWMXGIzNgNQI9SdCmD/jLhITwBQ9ehLSkb+
         XEVP/h3PMZVC5vzDLRMA2ctacgD5ioiLhXBcIfjUB5IUWXVcT3hHScDrk9eh/9mNvu5o
         PWXDbM+Um+WQ9hcOjSXq+jo3FDIH6cYOI+MipuzXRWJvoaNI+qxII2acSgoctNl9nHHf
         375AuTgxJjHK4jIuhHyjGLr4uaIo2/oQ034Ox+mp98rzfJnHVOkExpOIKkw9vVPM1s+r
         yyag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0EoeyvI+6nSZVdPsXoo6A3bLjv7jCmnakg13/Vo0S7g=;
        b=fXEH/S5EbEJL2b6lp3NmmufeVU6mikGZOMeGjzPg1TvCeZm09XcIp6Hnghk2wqlAim
         +JpdWOsLt42RK/VlQ2jF6/Q9a76SSxfcoDjzu88EHJgMTj8mhjHkRSYPSZ9hcUD5do4o
         wY7v/4Wx+YBH8bkkhHXo7vH6WsK/jrNXvTcesBDADyoGJe0/I0H2gY6hxQGwhlrl4FrV
         4HT3wb2xqIcgPCgIzkzbnhPep8scFG9YVJQSquBkQgnRJEWxK89XG0VzSfAOpcEB0X9g
         uxRx8xqQXpiLou9uWRgGLZwEMfFiUqUp1DSAKk9n690VZNG5DQGp+0c9u3nrK09EuSpU
         t4qQ==
X-Gm-Message-State: APjAAAXpzE04zkA3KawjIc8zdF/5R2X6UptQuZOY6z1sPrbx2jVI+mwH
        QCGez4XYMh7MXDWq6YYwa5jDxw==
X-Google-Smtp-Source: APXvYqxa0AysWp131gGXPRfGsUoOrmmAU0oaOx10qyqfliSX/gy0fcowTdd1qaAaihU44ugQyNlEYQ==
X-Received: by 2002:a63:a34c:: with SMTP id v12mr30337699pgn.198.1559596104078;
        Mon, 03 Jun 2019 14:08:24 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::1:9fa4])
        by smtp.gmail.com with ESMTPSA id n32sm7753279pji.29.2019.06.03.14.08.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Jun 2019 14:08:23 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 01/11] mm: vmscan: move inactive_list_is_low() swap check to the caller
Date:   Mon,  3 Jun 2019 17:07:36 -0400
Message-Id: <20190603210746.15800-2-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190603210746.15800-1-hannes@cmpxchg.org>
References: <20190603210746.15800-1-hannes@cmpxchg.org>
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
index 84dcb651d05c..f396424850aa 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2165,13 +2165,6 @@ static bool inactive_list_is_low(struct lruvec *lruvec, bool file,
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
 
@@ -2592,7 +2585,7 @@ static void shrink_node_memcg(struct pglist_data *pgdat, struct mem_cgroup *memc
 	 * Even if we did not try to evict anon pages at all, we want to
 	 * rebalance the anon lru active/inactive ratio.
 	 */
-	if (inactive_list_is_low(lruvec, false, sc, true))
+	if (total_swap_pages && inactive_list_is_low(lruvec, false, sc, true))
 		shrink_active_list(SWAP_CLUSTER_MAX, lruvec,
 				   sc, LRU_ACTIVE_ANON);
 }
-- 
2.21.0

