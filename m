Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EAB2C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 15:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFA4F2084E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 15:31:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fuK4lB9+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbfFUPbo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 11:31:44 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38003 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfFUPbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 11:31:43 -0400
Received: by mail-wr1-f65.google.com with SMTP id d18so7022161wrs.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 08:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JWWG2zIxOmDWYe8rHXUBcArY9/ATsP/XYEP3DtcCOfs=;
        b=fuK4lB9+T6YbLmGR8I6IvaXx2bH3xYDajvtykVso1Deqa/GAPTE2u1PcDkunMYy2R3
         ZJvzG53ItaL9ykdD4/oHfzGHlSkmVHAow0ABQIzYkddwz+vkwryxLl6FRX4kx95bCcDE
         lbnycNMPLK8H1r9htlyqL6H1J89aE+CJ4gHtmJDQJ1ovCveulFbyH2P9m+YWoQmXl8fR
         CMAoPXCbMIH6qYV30dK4VgkMbV7ASvpe3mGZi217hLkf+6jA6d/WvEAF6bzFqxhCSNhx
         e2s3TVPiP8stSQc8/e04ZO2UWQpoeft+m0qbGqYqe7HHtaUqI4Q9AaqU37CNuLe0TJxl
         96ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JWWG2zIxOmDWYe8rHXUBcArY9/ATsP/XYEP3DtcCOfs=;
        b=dv1eegkoqhj5gZFU2x4rrZNV+6FNx37LCys9FNI4de9xTelIFF+K2OzXQQdzdY8noD
         qdyYB/5TAZxtv8ZdEQH2B59Fh2DAtUMU2ggdraxl6Oe4JJcaymTVBvnaZjIUFj8CMkTG
         Gby7aCvcOhllLSpXMxaFWRAxzNQzWSLpIotCfVfq0wRBOb2LXd+4bm1DtRCqTZX+PsiU
         FNjtJgPqH6J72X8V3np4cFic6rZR0739W2BATk3gDtAVxOssymaEg+QRfXBLsWDRhQBh
         XRGu1dy30LZMkNWeQunkH/rCC8NtLcZ48nuEQbetdZ5+Wu5oL/5E8QDKNe/TzcllN7ox
         iExg==
X-Gm-Message-State: APjAAAWRXLTG7ytjmymI0kcrYOnGXrsuLucdxEUsTi+zwlz/szz0qSOq
        m1GpO8+L9T2iJsDB6ENBCJdH9p4/rAs=
X-Google-Smtp-Source: APXvYqyAW9yR+tYHSa53pZVTsEE/Hg18IvMwVe9mKGLtmJpJfqWcKoJHDeXBjtxQq4c5ys7FoD0kUw==
X-Received: by 2002:adf:ebc4:: with SMTP id v4mr795012wrn.113.1561131101120;
        Fri, 21 Jun 2019 08:31:41 -0700 (PDT)
Received: from alan-laptop.carrier.duckdns.org (host-89-243-246-11.as13285.net. [89.243.246.11])
        by smtp.gmail.com with ESMTPSA id 5sm5505682wrc.76.2019.06.21.08.31.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 21 Jun 2019 08:31:40 -0700 (PDT)
From:   Alan Jenkins <alan.christopher.jenkins@gmail.com>
To:     linux-mm@kvack.org
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        linux-kernel@vger.kernel.org,
        Bharath Vedartham <linux.bhar@gmail.com>,
        Alan Jenkins <alan.christopher.jenkins@gmail.com>
Subject: [PATCH v2] mm: avoid inconsistent "boosts" when updating the high and low watermarks
Date:   Fri, 21 Jun 2019 16:31:07 +0100
Message-Id: <20190621153107.23667-1-alan.christopher.jenkins@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <3d15b808-b7cd-7379-a6a9-d3cf04b7dcec@suse.cz>
References: <3d15b808-b7cd-7379-a6a9-d3cf04b7dcec@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When setting the low and high watermarks we use min_wmark_pages(zone).
I guess this was to reduce the line length.  Then this macro was modified
to include zone->watermark_boost.  So we needed to set watermark_boost
before we set the high and low watermarks... but we did not.

It seems mostly harmless.  It might set the watermarks a bit higher than
needed: when 1) the watermarks have been "boosted" and 2) you then
triggered __setup_per_zone_wmarks() (by setting one of the sysctls, or
hotplugging memory...).

I noticed it because it also breaks the documented equality
(high - low == low - min).  Below is an example of reproducing the bug.

First sample.  Equality is met (high - low == low - min):

Node 0, zone   Normal
  pages free     11962
        min      9531
        low      11913
        high     14295
        spanned  1173504
        present  1173504
        managed  1134235

A later sample.  Something has caused us to boost the watermarks:

Node 0, zone   Normal
  pages free     12614
        min      10043
        low      12425
        high     14807

Now trigger the watermarks to be recalculated.  "cd /proc/sys/vm" and
"cat watermark_scale_factor > watermark_scale_factor".  Then the watermarks
are boosted inconsistently.  The equality is broken:

Node 0, zone   Normal
  pages free     12412
        min      9531
        low      12425
        high     14807

14807 - 12425 = 2382
12425 -  9531 = 2894

Co-developed-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Alan Jenkins <alan.christopher.jenkins@gmail.com>
Fixes: 1c30844d2dfe ("mm: reclaim small amounts of memory when an external
                      fragmentation event occurs")
Acked-by: Mel Gorman <mgorman@techsingularity.net>

---

Changes since v1:

Use Vlastimil's suggested code.  It is much cleaner, thanks :-).
I considered this "Co-developed-by" and s-o-b credit.

Update commit message to be specific about expected effects.

Node data is always allocated with kzalloc().  So there is no risk of
the code reading arbitrary unintialized data from ->watermark_boost,
the first time it is run.

AFAICT the bug is mostly harmless.  I do not require a -stable port.
I leave it to anyone else, if they think it's worth adding
"Cc: stable@vger.kernel.org".


 mm/page_alloc.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index c02cff1ed56e..01233705e490 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7570,6 +7570,7 @@ static void __setup_per_zone_wmarks(void)
 
 	for_each_zone(zone) {
 		u64 tmp;
+		unsigned long wmark_min;
 
 		spin_lock_irqsave(&zone->lock, flags);
 		tmp = (u64)pages_min * zone_managed_pages(zone);
@@ -7588,13 +7589,13 @@ static void __setup_per_zone_wmarks(void)
 
 			min_pages = zone_managed_pages(zone) / 1024;
 			min_pages = clamp(min_pages, SWAP_CLUSTER_MAX, 128UL);
-			zone->_watermark[WMARK_MIN] = min_pages;
+			wmark_min = min_pages;
 		} else {
 			/*
 			 * If it's a lowmem zone, reserve a number of pages
 			 * proportionate to the zone's size.
 			 */
-			zone->_watermark[WMARK_MIN] = tmp;
+			wmark_min = tmp;
 		}
 
 		/*
@@ -7606,8 +7607,9 @@ static void __setup_per_zone_wmarks(void)
 			    mult_frac(zone_managed_pages(zone),
 				      watermark_scale_factor, 10000));
 
-		zone->_watermark[WMARK_LOW]  = min_wmark_pages(zone) + tmp;
-		zone->_watermark[WMARK_HIGH] = min_wmark_pages(zone) + tmp * 2;
+		zone->_watermark[WMARK_MIN]  = wmark_min;
+		zone->_watermark[WMARK_LOW]  = wmark_min + tmp;
+		zone->_watermark[WMARK_HIGH] = wmark_min + tmp * 2;
 		zone->watermark_boost = 0;
 
 		spin_unlock_irqrestore(&zone->lock, flags);
-- 
2.20.1

