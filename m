Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD10C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 01:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 285B220644
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 01:53:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ljI7lFF3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbfHBBxh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 21:53:37 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:45292 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbfHBBxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 21:53:37 -0400
Received: by mail-pf1-f202.google.com with SMTP id i27so47085702pfk.12
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 18:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=VKzEuSkmyrWV8LhwIH3JFAo5TpB9gh8PzM9j2uJXmIA=;
        b=ljI7lFF3O1uGnDJgLjRw0nWAvDTSYyuHT002SegNqoGSSb9OLyCXLW4bvQwWX+qe6V
         V8wJyCYEPbFnkif6rt8y681avtdd4OXMPubBiEaIx1Lnxy6Lk4ro3uR/f0txJInnuZ0M
         yX2RYvNbUC3w9m+LKYUPbcjYgI+2S4RRgGV7dSs1rDRHmfuvkjs3QRY5Nom+99Lvujqy
         RVIFe5Kp3hVYnZpoOnuzgjOxx+c/yhMqr7N4KhLSFDHkeelY9Dec413o9Wt3oqVtk2ZU
         c8kH6QeWOT6aag7/h4j+Lzfi5RMbgcZlAgILtJrvzfZm0aWW409BAvH+WhXeRAiyeeoi
         zuTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=VKzEuSkmyrWV8LhwIH3JFAo5TpB9gh8PzM9j2uJXmIA=;
        b=Cn2/zawB5Um4/3ZJys2K5qSaSeKmKIC4tM5R4rI5a8vtCF1o0x7ARpxVqzoydauGHD
         HXPT0mrv8B185UIABGa+m5YiDbRc/3zl21TiPnShBw5oHDTwcZLgnYm3F2xcUpSTl3zx
         SqUv+iRUfZb3B1wmrvvLr/jlRz4T+nBkbpHxMdX3myVwJj3xDfi+erUlxINBMLv+wqiC
         nQ1q2iK8QI5rp8Tqrtp13yAyX80wGhUVsToNcbERHrFUoGWFXmN/quLeJ6HXYBxDx9UR
         YKCPUC6Qs59U9aabaqjANIT2oWRLiZp+kuJkaCOT6s/PKVLpyDV47m8awWKq/1B1f1ME
         +dkg==
X-Gm-Message-State: APjAAAXjsfePO/AQg63jqhX9AzgRjBSvjwb/E+ee8YSoAozP56l4q6LZ
        PPktRUR7ZWaLMb2vqZhQW8X23WXwWrT97teg
X-Google-Smtp-Source: APXvYqzcvYNu3kUvzm7uEj+DWVq5JRNiJA6B1G5NwHfF9cgJ8y3vPHN7XgvR2puOfpuYvp6BotAWHMYLYz5iAEeA
X-Received: by 2002:a63:f807:: with SMTP id n7mr125813928pgh.119.1564710816388;
 Thu, 01 Aug 2019 18:53:36 -0700 (PDT)
Date:   Thu,  1 Aug 2019 18:53:31 -0700
Message-Id: <20190802015332.229322-1-henryburns@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [PATCH 1/2] mm/zsmalloc.c: Migration can leave pages in ZS_EMPTY indefinitely
From:   Henry Burns <henryburns@google.com>
To:     Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Jonathan Adams <jwadams@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Henry Burns <henryburns@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In zs_page_migrate() we call putback_zspage() after we have finished
migrating all pages in this zspage. However, the return value is ignored.
If a zs_free() races in between zs_page_isolate() and zs_page_migrate(),
freeing the last object in the zspage, putback_zspage() will leave the page
in ZS_EMPTY for potentially an unbounded amount of time.

To fix this, we need to do the same thing as zs_page_putback() does:
schedule free_work to occur.  To avoid duplicated code, move the
sequence to a new putback_zspage_deferred() function which both
zs_page_migrate() and zs_page_putback() call.

Signed-off-by: Henry Burns <henryburns@google.com>
---
 mm/zsmalloc.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 1cda3fe0c2d9..efa660a87787 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1901,6 +1901,22 @@ static void dec_zspage_isolation(struct zspage *zspage)
 	zspage->isolated--;
 }
 
+static void putback_zspage_deferred(struct zs_pool *pool,
+				    struct size_class *class,
+				    struct zspage *zspage)
+{
+	enum fullness_group fg;
+
+	fg = putback_zspage(class, zspage);
+	/*
+	 * Due to page_lock, we cannot free zspage immediately
+	 * so let's defer.
+	 */
+	if (fg == ZS_EMPTY)
+		schedule_work(&pool->free_work);
+
+}
+
 static void replace_sub_page(struct size_class *class, struct zspage *zspage,
 				struct page *newpage, struct page *oldpage)
 {
@@ -2070,7 +2086,7 @@ static int zs_page_migrate(struct address_space *mapping, struct page *newpage,
 	 * the list if @page is final isolated subpage in the zspage.
 	 */
 	if (!is_zspage_isolated(zspage))
-		putback_zspage(class, zspage);
+		putback_zspage_deferred(pool, class, zspage);
 
 	reset_page(page);
 	put_page(page);
@@ -2115,15 +2131,9 @@ static void zs_page_putback(struct page *page)
 
 	spin_lock(&class->lock);
 	dec_zspage_isolation(zspage);
-	if (!is_zspage_isolated(zspage)) {
-		fg = putback_zspage(class, zspage);
-		/*
-		 * Due to page_lock, we cannot free zspage immediately
-		 * so let's defer.
-		 */
-		if (fg == ZS_EMPTY)
-			schedule_work(&pool->free_work);
-	}
+	if (!is_zspage_isolated(zspage))
+		putback_zspage_deferred(pool, class, zspage);
+
 	spin_unlock(&class->lock);
 }
 
-- 
2.22.0.770.g0f2c4a37fd-goog

