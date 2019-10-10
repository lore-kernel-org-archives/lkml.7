Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B709C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 20:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DC1521835
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 20:11:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AMPzRcMz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbfJJULr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 16:11:47 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38828 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbfJJULr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 16:11:47 -0400
Received: by mail-lj1-f195.google.com with SMTP id b20so7519639ljj.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 13:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QJWOGN1T52H0uvWMZ9lrHPVpqM+o1MdQipUB8ycg4N0=;
        b=AMPzRcMzP0Q+ZRjBMDxm6q1DmMC6OYTMxAQ3EOwa/E47MuDYSz2TtMCOR2T/COr3eU
         EuHk30dqlS5g9nWsWRCUTKpuO9evJY5KqKWYfnevUFz2iEQHIL6QQ33AjYfU6yl/EA3N
         8bCaMqIE66VwOapMYxDbhgwUshFNpesAOP8teGjM3JHZB2MQJtNP3si1uzA+taJLCcu3
         5rn7t9yzAgoPSxXQgZN3T2RSou9+hGP9BfUhQzaxACPi+hnL8FofC4Gz2ebJ7VCBLySZ
         sQkByQJs/3CdOoJz/8rTfekiYBySlvQ39Qi+M8yNfpkTFepUFIe2I1ME5BT7LRvFlPHJ
         7Xlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QJWOGN1T52H0uvWMZ9lrHPVpqM+o1MdQipUB8ycg4N0=;
        b=QSw8JPXCV1msAhaIY4qespFWUV24OVoBltSWjBDtlfGAk+0vA4zMUrH4tOw+wtzpti
         99UT7OWuzwy0STnks1NWIYXU9g/4cvwQfbCBIWypVe+GWNdQoS9Vl9br6zgMeGNeu14e
         +s9WmiQ8ZLwbD7nvlRULhVLHH+pdoU8OYJOW9ZXg1+3OeHF0Ekxlc6wtaejhNLmb1UI8
         +ybLiWAm2WoW9c269ly1FQ1TpMMwBfi3woqLUNcyg82Gi3q1JBMN/uJyee8/B7tfJfS8
         S/njQsq6krZLw9RZBtjgLNs1+yF999ZzHlAJ/dCT4L7xeew1HtI42P/6tjsQ/7py+ns6
         sBeQ==
X-Gm-Message-State: APjAAAV/34O2/8F1Wx6xDtyTP37bvJ17GpIE2GPUb3YWaMnaTEV1Ot6O
        JEBSULtvM7VL7lrn+fuVCZk=
X-Google-Smtp-Source: APXvYqzN+Eo38GYZjgQvgyjVNpEmWykAfXX1SXTS5NplM6jQi15Q1eur5GZoG7DxYI04DSCojiWjxw==
X-Received: by 2002:a2e:3014:: with SMTP id w20mr7572909ljw.115.1570738304765;
        Thu, 10 Oct 2019 13:11:44 -0700 (PDT)
Received: from vitaly-Dell-System-XPS-L322X (c188-150-241-161.bredband.comhem.se. [188.150.241.161])
        by smtp.gmail.com with ESMTPSA id o13sm1457581lji.31.2019.10.10.13.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 13:11:44 -0700 (PDT)
Date:   Thu, 10 Oct 2019 23:11:43 +0300
From:   Vitaly Wool <vitalywool@gmail.com>
To:     Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Streetman <ddstreet@ieee.org>,
        Minchan Kim <minchan@kernel.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Shakeel Butt <shakeelb@google.com>,
        Henry Burns <henrywolfeburns@gmail.com>,
        Theodore Ts'o <tytso@thunk.org>
Subject: [PATCH 2/3] zsmalloc: add compaction and huge class callbacks
Message-Id: <20191010231143.09e4a2bd52f331efd0c4baf9@gmail.com>
In-Reply-To: <20191010230414.647c29f34665ca26103879c4@gmail.com>
References: <20191010230414.647c29f34665ca26103879c4@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compaction callbacks for zpool compaction API extension.
Add huge_class_size callback too to be fully aligned.

With these in place, we can proceed with ZRAM modification
to use the universal (zpool) API. 

Signed-off-by: Vitaly Wool <vitalywool@gmail.com>
---
 mm/zsmalloc.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 2b2b9aae8a3c..43f43272b998 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -437,11 +437,29 @@ static void zs_zpool_unmap(void *pool, unsigned long handle)
 	zs_unmap_object(pool, handle);
 }
 
+static unsigned long zs_zpool_compact(void *pool)
+{
+	return zs_compact(pool);
+}
+
+static unsigned long zs_zpool_get_compacted(void *pool)
+{
+	struct zs_pool_stats stats;
+
+	zs_pool_stats(pool, &stats);
+	return stats.pages_compacted;
+}
+
 static u64 zs_zpool_total_size(void *pool)
 {
 	return zs_get_total_pages(pool) << PAGE_SHIFT;
 }
 
+static size_t zs_zpool_huge_class_size(void *pool)
+{
+	return zs_huge_class_size(pool);
+}
+
 static struct zpool_driver zs_zpool_driver = {
 	.type =			  "zsmalloc",
 	.owner =		  THIS_MODULE,
@@ -453,6 +471,9 @@ static struct zpool_driver zs_zpool_driver = {
 	.map =			  zs_zpool_map,
 	.unmap =		  zs_zpool_unmap,
 	.total_size =		  zs_zpool_total_size,
+	.compact =		  zs_zpool_compact,
+	.get_num_compacted =	  zs_zpool_get_compacted,
+	.huge_class_size =	  zs_zpool_huge_class_size,
 };
 
 MODULE_ALIAS("zpool-zsmalloc");
-- 
2.20.1
