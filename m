Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E1E4C5B578
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 21:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E35A206A2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 21:23:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EzSrG+EO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfGAVXW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 17:23:22 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:38020 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbfGAVXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 17:23:21 -0400
Received: by mail-pl1-f202.google.com with SMTP id s22so7872412plp.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 14:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=bNhCMdMsg7N+4Vj+pDsH8brC1Mtm6ra3Zd4KbsCvcEc=;
        b=EzSrG+EOzG9aDUs5P322SatgarBV953/Mej+gjGvdaBvEjLbtuHMj8Hm6kudG6uq4z
         rKFwo/55vjbeO6TT1CU7JtUYo2FdUYmUJCAVZk4qGns8YP1W9DpR7aqe64iIEV5RgaNW
         DEL5Dn/lRt17aKbzq8laUj86banrVjWj2Fszvod4Q7hIHFTD6py1tQAre/nV3PZZOM5w
         gvsj0dYoRS2NMjOMVkmdecdK9QnfU4M57w5HZj9qcx5ZLdVLXwwrBZhlIgB1JWPvm25l
         DYramdXDEMzqdCivSXP1B1NhOq90bJQGBKHZM1E0K/metPuJZ0z9/BWvpyLMmK2xQ0CG
         qN8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=bNhCMdMsg7N+4Vj+pDsH8brC1Mtm6ra3Zd4KbsCvcEc=;
        b=FCJ4nj45/5f7XHffzFXGYxPekRCwwOWZNUdzUYt76aJ57BJLVjNOVBJI4Trg12q0yV
         C3QtJroDCRPKSH5rHGWeKJSsRNAxQqg88Re1JV/7REkZIUfnLe+iK//GhLk0PhpRwkrP
         YTqubl+f9kj4HFV/R+l7OSTGnRIA4LGh4aGJTmAa571dERBLnVbIHccsJTzvidlaXTiE
         22wPfZFnB4Lb0G3Xhqxsme4zoINfdva7itYp12Mg57vCA8SWpHwbqyiCQQlQ0F7oUBaa
         uPLk1tUSquVO7i4Po3NnTHyac6gdbBA9UFDJt656qmSDuMEZijVcygdrRUXhvHCDGKMJ
         u57Q==
X-Gm-Message-State: APjAAAUAIr4cjsQE+Cl5Am6s+xE5DDWbPezWPR33MQZkZan1IHXaRbDO
        NuxH7XjsCvb7r/2P8DVmI7XFD8cA63H3hmfK
X-Google-Smtp-Source: APXvYqwRQQWef9NfDlZUOW6uA8Q/I1Yr4IGLq0eWpS5i+Pg2BY9Si+Xw2iiaG9Nne6b5FjY/XumkMia5bSRjv2Mp
X-Received: by 2002:a63:c20e:: with SMTP id b14mr2877738pgd.96.1562016200672;
 Mon, 01 Jul 2019 14:23:20 -0700 (PDT)
Date:   Mon,  1 Jul 2019 14:23:03 -0700
Message-Id: <20190701212303.168581-1-henryburns@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH] mm/z3fold.c: Lock z3fold page before  __SetPageMovable()
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
---
 mm/z3fold.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/z3fold.c b/mm/z3fold.c
index e174d1549734..5bc404dbbb4a 100644
--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -918,7 +918,9 @@ static int z3fold_alloc(struct z3fold_pool *pool, size_t size, gfp_t gfp,
 		set_bit(PAGE_HEADLESS, &page->private);
 		goto headless;
 	}
+	WARN_ON(!trylock_page(page));
 	__SetPageMovable(page, pool->inode->i_mapping);
+	unlock_page(page);
 	z3fold_page_lock(zhdr);
 
 found:
@@ -1325,6 +1327,7 @@ static int z3fold_page_migrate(struct address_space *mapping, struct page *newpa
 
 	VM_BUG_ON_PAGE(!PageMovable(page), page);
 	VM_BUG_ON_PAGE(!PageIsolated(page), page);
+	VM_BUG_ON_PAGE(!PageLocked(newpage), newpage);
 
 	zhdr = page_address(page);
 	pool = zhdr_to_pool(zhdr);
-- 
2.22.0.410.gd8fdbe21b5-goog

