Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55AC4CA9EBA
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 20:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2570021783
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 20:15:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="KaaLg/bw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389355AbfJVUPX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 16:15:23 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34914 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389342AbfJVUPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 16:15:21 -0400
Received: by mail-qt1-f196.google.com with SMTP id m15so28843992qtq.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 13:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SKH3PcY5YzXD6Qge68ymWg6Ins6ocLR9l5DfPryEBgk=;
        b=KaaLg/bw88z77buICYAJEe5iw5ThIZJCDvLL4q2RSdmGOXSdlsryIy4UAPdKiR3U1i
         TnF8jNwIgRKrMzBMH2cBT8Qyy9tg/M9wTtR3Wrx6e/JrVGOp77QhbBjRArE2l/meQdby
         SOdO/mGWcTubS8kR90ln5IenSVxDk0WPTvDqpdaDO4iRAPQXIssKgsKkCTzxFI7D99tI
         K/w9BneoewwmdaDHDt5q8QWenhYLUUAhYRi0GJm58lfdROEHZrbuhSNsUmJ7vhrTLZoB
         TlgRns9OFeILnr1C45VJ/hBfpRmLpXl6WY6/23dwwSlktV02dZHRpDlk39xE/9wyzzJf
         OKPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SKH3PcY5YzXD6Qge68ymWg6Ins6ocLR9l5DfPryEBgk=;
        b=njth46QfQn7vl2AAzuC2CF1x8+E+T/tgREx++/f1vO2qqsaXgf6plBYvuIwrtyze64
         rozNH0LBedwXjVmc4FN14ov5Jflkc9QkBvsLQIhLx4WZnlbU0u7ATE0udsAQvE0Yc+SM
         uBGtjaTEvJSY1Dj4j/OCDtwiI7f/vN6/UMVzwaCswoIcA3s6pS/iBE4GIYtsHfBsdHo6
         j6iMlF/rYIgavh+uwiouNbyzYJbq+3cTr0J6Dz/VYBSKxYIPvv7J/bzM8MlG5jsDH+fE
         M/Jn+fPbbt8KhTZTPZbOlmGLviNm8p743XOBunOcqh9myYTFQQ4mK+lEyUP/Qvg++4W5
         xmiQ==
X-Gm-Message-State: APjAAAVHTPc9x8kamLX5elVtrm5ThigxU2huVfPwTdoScWSounEgpehS
        1Q+02f9hZIZnjhfWoKtLCXxuvg==
X-Google-Smtp-Source: APXvYqwgUaBUtrSrtIlAxyDVz2P4+gAp3Nwe5EnwHYyjxxj2PszLHekWjQXPyQk3tbOPUN9yPnbdVQ==
X-Received: by 2002:a0c:d0e1:: with SMTP id b30mr5126174qvh.197.1571775320721;
        Tue, 22 Oct 2019 13:15:20 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::3:869e])
        by smtp.gmail.com with ESMTPSA id e15sm7759814qkm.130.2019.10.22.13.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 13:15:20 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 2/2] mm: memcontrol: try harder to set a new memory.high
Date:   Tue, 22 Oct 2019 16:15:18 -0400
Message-Id: <20191022201518.341216-2-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191022201518.341216-1-hannes@cmpxchg.org>
References: <20191022201518.341216-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Setting a memory.high limit below the usage makes almost no effort to
shrink the cgroup to the new target size.

While memory.high is a "soft" limit that isn't supposed to cause OOM
situations, we should still try harder to meet a user request through
persistent reclaim.

For example, after setting a 10M memory.high on an 800M cgroup full of
file cache, the usage shrinks to about 350M:

+ cat /cgroup/workingset/memory.current
841568256
+ echo 10M
+ cat /cgroup/workingset/memory.current
355729408

This isn't exactly what the user would expect to happen. Setting the
value a few more times eventually whittles the usage down to what we
are asking for:

+ echo 10M
+ cat /cgroup/workingset/memory.current
104181760
+ echo 10M
+ cat /cgroup/workingset/memory.current
31801344
+ echo 10M
+ cat /cgroup/workingset/memory.current
10440704

To improve this, add reclaim retry loops to the memory.high write()
callback, similar to what we do for memory.max, to make a reasonable
effort that the usage meets the requested size after the call returns.

Afterwards, a single write() to memory.high is enough in all but
extreme cases:

+ cat /cgroup/workingset/memory.current
841609216
+ echo 10M
+ cat /cgroup/workingset/memory.current
10182656

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/memcontrol.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index ff90d4e7df37..8090b4c99ac7 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6074,7 +6074,8 @@ static ssize_t memory_high_write(struct kernfs_open_file *of,
 				 char *buf, size_t nbytes, loff_t off)
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
-	unsigned long nr_pages;
+	unsigned int nr_retries = MEM_CGROUP_RECLAIM_RETRIES;
+	bool drained = false;
 	unsigned long high;
 	int err;
 
@@ -6085,12 +6086,29 @@ static ssize_t memory_high_write(struct kernfs_open_file *of,
 
 	memcg->high = high;
 
-	nr_pages = page_counter_read(&memcg->memory);
-	if (nr_pages > high)
-		try_to_free_mem_cgroup_pages(memcg, nr_pages - high,
-					     GFP_KERNEL, true);
+	for (;;) {
+		unsigned long nr_pages = page_counter_read(&memcg->memory);
+		unsigned long reclaimed;
+
+		if (nr_pages <= high)
+			break;
+
+		if (signal_pending(current))
+			break;
+
+		if (!drained) {
+			drain_all_stock(memcg);
+			drained = true;
+			continue;
+		}
+
+		reclaimed = try_to_free_mem_cgroup_pages(memcg, nr_pages - high,
+							 GFP_KERNEL, true);
+
+		if (!reclaimed && !nr_retries--)
+			break;
+	}
 
-	memcg_wb_domain_size_changed(memcg);
 	return nbytes;
 }
 
-- 
2.23.0

