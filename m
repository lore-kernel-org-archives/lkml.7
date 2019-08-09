Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3252DC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 18:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A5CC20C01
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 18:18:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t4ojcX4z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437059AbfHISSj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 14:18:39 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:36424 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbfHISSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 14:18:38 -0400
Received: by mail-qt1-f202.google.com with SMTP id q26so89703034qtr.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 11:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=1tTOS0Kr72a3ig2rpitn9bCmZeR/zOLT1qe1/3whgEM=;
        b=t4ojcX4zM3ReDMDWCqGhCTvaqHBK+DuPIlzAdeiU72qvxO9xy9fn1Q6XpZm7bG1TY9
         DcTgReEoKCXV6hx6uhDkgrOBydyAG7m95uH2GgH+MpjoY5dBW1XlJuSLaiClxd80i9wQ
         uGWlwouFz2kNGMsP82G5m5c3QdsA3UTgtCzOWJZbC62mlfPkPyeTb/PGohfZneqJjjII
         e4TziFLEBwXH8c7dph/NR4Cf/P3BHtpNUUqq70fVcaV4P871k09OTx/GBiyEROIIHgAO
         qjIIeON5PngXGZ9T/XsUQBgx8jcAvK93OCFYAvJHYk8d6nDQ7VHqphneeXOaVwdVn+9U
         YyWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=1tTOS0Kr72a3ig2rpitn9bCmZeR/zOLT1qe1/3whgEM=;
        b=qOl+iNhLXYyJLuGMBpn0fGx3fdmtlHT/YOmzjft0+uypxwOm47ospAKtN4/Geudg6m
         4g76Yeb2rs2Hnlj8XcfwMnor0f0bjFZobr/Rbhx0qwbDyW9vQJrBTYcyCqhleAzp/0v0
         IkbXM/nv1EtT1WljTOTcnLB+hNJrvRF/3kSLTK0okK4tDl9mOfFISqVSvwuk5+zPjj4+
         aGV9j48JGUqz02jrmERNo9uND1V2EQtmelz+QPwgGmm8xw4M6ZFPAod3jHg27RY72hqq
         qOxJhmcHvzWrVNdRdi29Ydz9zVqpgIsvwIIyapdLplhq/+/lIePVbVS2FmKy4eJ7vLI2
         YTHA==
X-Gm-Message-State: APjAAAWszIV0mzIcWuOR8cDvL/YPA11F68xUC4N7kPkSoDuKYDMHjDJa
        cRJB4zwvA8fNFC7fMKL2A80Pp7EE/hFNUeLK
X-Google-Smtp-Source: APXvYqw2K/VdYvQblbTHJHxoM6dqlB8YfnUUHpG4eYjJSnSc4X/YL0P/7AjXqV062axKFffWbIEPqpGDJf00/gB/
X-Received: by 2002:a37:5e04:: with SMTP id s4mr15541529qkb.268.1565374717530;
 Fri, 09 Aug 2019 11:18:37 -0700 (PDT)
Date:   Fri,  9 Aug 2019 11:17:50 -0700
Message-Id: <20190809181751.219326-1-henryburns@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH 1/2 v2] mm/zsmalloc.c: Migration can leave pages in ZS_EMPTY indefinitely
From:   Henry Burns <henryburns@google.com>
To:     Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Jonathan Adams <jwadams@google.com>,
        HenryBurns <henrywolfeburns@gmail.com>, linux-mm@kvack.org,
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

Fixes: 48b4800a1c6a ("zsmalloc: page migration support")
Signed-off-by: Henry Burns <henryburns@google.com>
---
 Changelog since v1:
 - Moved the comment from putback_zspage_deferred() to
   zs_page_putback().

 mm/zsmalloc.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 57fbb7ced69f..5105b9b66653 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1862,6 +1862,18 @@ static void dec_zspage_isolation(struct zspage *zspage)
 	zspage->isolated--;
 }
 
+static void putback_zspage_deferred(struct zs_pool *pool,
+				    struct size_class *class,
+				    struct zspage *zspage)
+{
+	enum fullness_group fg;
+
+	fg = putback_zspage(class, zspage);
+	if (fg == ZS_EMPTY)
+		schedule_work(&pool->free_work);
+
+}
+
 static void replace_sub_page(struct size_class *class, struct zspage *zspage,
 				struct page *newpage, struct page *oldpage)
 {
@@ -2031,7 +2043,7 @@ static int zs_page_migrate(struct address_space *mapping, struct page *newpage,
 	 * the list if @page is final isolated subpage in the zspage.
 	 */
 	if (!is_zspage_isolated(zspage))
-		putback_zspage(class, zspage);
+		putback_zspage_deferred(pool, class, zspage);
 
 	reset_page(page);
 	put_page(page);
@@ -2077,14 +2089,13 @@ static void zs_page_putback(struct page *page)
 	spin_lock(&class->lock);
 	dec_zspage_isolation(zspage);
 	if (!is_zspage_isolated(zspage)) {
-		fg = putback_zspage(class, zspage);
 		/*
 		 * Due to page_lock, we cannot free zspage immediately
 		 * so let's defer.
 		 */
-		if (fg == ZS_EMPTY)
-			schedule_work(&pool->free_work);
+		putback_zspage_deferred(pool, class, zspage);
 	}
+
 	spin_unlock(&class->lock);
 }
 
-- 
2.23.0.rc1.153.gdeed80330f-goog

