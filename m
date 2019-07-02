Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EDE7C5B578
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 00:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB3DF21473
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 00:51:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ODdYbhrZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbfGBAvv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 20:51:51 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:34440 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726866AbfGBAvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 20:51:51 -0400
Received: by mail-pf1-f201.google.com with SMTP id i2so9811814pfe.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 17:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=fQRHpcnZQgmJ5EVYhy+Qqag9BuKV3GgR0RmH9DgVc30=;
        b=ODdYbhrZxLaj82QT81sQFex0PsUNmi7pkBfxxjI2BAqvUgbT1v5TtvMslVPTu/mUMp
         MnvG9TO9zNsxpUFKLqftjjjMTJsVYPqjIOmm2oNV41LiRHkjdcA3EKJ4EbQnS5uiPQfM
         Zpt0Pu7BsCzYycwnA83E8hGzxksbyCLMMp8GvRlzJdjwyfjNUsSW86ZNgnExlTFI0clR
         lrPk2JAuiLERvcNdFXCFwo9a7auujyK/+AtWsKFveHTrcIEjmeUqdfcQw+WmGs8kjTjm
         NrDfELXrRp/baVJbjHvlkgBpNBTz6IjR4P+aaniPxlvNq/kvztmSoJu5gT1ZU+y8IjCW
         UEJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=fQRHpcnZQgmJ5EVYhy+Qqag9BuKV3GgR0RmH9DgVc30=;
        b=ORm9Ub9JYC1aJEwhZRri0aeLuOgBhfxp+fic1fv+H/NgjzkJ450+CpZb0lKPDfmxTy
         lmukpAKrJZwrZPgqbmJTmMQE2yHYHssRKAVx2OyhIrjYKuVHDavziics6rQznL8qUOp9
         /f+C/EIoxLa6VuGiAmQ2VAiLYhe7Tnjlbxg6lDLhsQEVi1+gwHESMzkmzAsXeiFR9gfK
         sl/US78xneXLLcW228ebSqnfn2xAp74YH4duNxcrlEZTjxpHkrobi17txGY/fuNu2fnI
         zqWI8fzh9yt5fLHxySQQh1cqtEncwqhOus+cTJZheEyAlm4THu60Qi+XDyT8dW+1O3lH
         RRww==
X-Gm-Message-State: APjAAAV/DPb5z3hrp2VL/m+0xUTSIqLB76WYESkVaoGgMm9Ywu82u5oh
        gLpOaymeYQ/wW8ImCDF/PqOD9fO4d75yAwnZ
X-Google-Smtp-Source: APXvYqzXhknzPhp8ywA8IJFv6X8bS3qEb+pGQJo6CDssSNJBkI8XUGFWLMs249ByEsdnkPkZUi5H4YIv/jBLv21t
X-Received: by 2002:a65:44c8:: with SMTP id g8mr27400341pgs.443.1562028710037;
 Mon, 01 Jul 2019 17:51:50 -0700 (PDT)
Date:   Mon,  1 Jul 2019 17:51:22 -0700
Message-Id: <20190702005122.41036-1-henryburns@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v2] mm/z3fold.c: Lock z3fold page before  __SetPageMovable()
From:   Henry Burns <henryburns@google.com>
To:     Vitaly Wool <vitalywool@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Vitaly Vul <vitaly.vul@sony.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Xidong Wang <wangxidong_97@163.com>,
        Shakeel Butt <shakeelb@google.com>,
        Jonathan Adams <jwadams@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Henry Burns <henryburns@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__SetPageMovable() expects it's page to be locked, but z3fold.c doesn't
lock the page. Following zsmalloc.c's example we call trylock_page() and
unlock_page(). Also makes z3fold_page_migrate() assert that newpage is
passed in locked, as documentation.

Signed-off-by: Henry Burns <henryburns@google.com>
Suggested-by: Vitaly Wool <vitalywool@gmail.com>
---
 Changelog since v1:
 - Added an if statement around WARN_ON(trylock_page(page)) to avoid
   unlocking a page locked by a someone else.

 mm/z3fold.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/z3fold.c b/mm/z3fold.c
index e174d1549734..6341435b9610 100644
--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -918,7 +918,10 @@ static int z3fold_alloc(struct z3fold_pool *pool, size_t size, gfp_t gfp,
 		set_bit(PAGE_HEADLESS, &page->private);
 		goto headless;
 	}
-	__SetPageMovable(page, pool->inode->i_mapping);
+	if (!WARN_ON(!trylock_page(page))) {
+		__SetPageMovable(page, pool->inode->i_mapping);
+		unlock_page(page);
+	}
 	z3fold_page_lock(zhdr);
 
 found:
@@ -1325,6 +1328,7 @@ static int z3fold_page_migrate(struct address_space *mapping, struct page *newpa
 
 	VM_BUG_ON_PAGE(!PageMovable(page), page);
 	VM_BUG_ON_PAGE(!PageIsolated(page), page);
+	VM_BUG_ON_PAGE(!PageLocked(newpage), newpage);
 
 	zhdr = page_address(page);
 	pool = zhdr_to_pool(zhdr);
-- 
2.22.0.410.gd8fdbe21b5-goog

