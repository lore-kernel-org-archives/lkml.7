Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72FF0C742D7
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 22:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 412472146E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 22:22:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qSqUpYgx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbfGLWW1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 18:22:27 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:36135 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727245AbfGLWW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 18:22:26 -0400
Received: by mail-vk1-f201.google.com with SMTP id o75so2392522vke.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2019 15:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=kEx1JTVWGnPw7PBaID0vQzLE5AVxmop4HrGd6+u6kxc=;
        b=qSqUpYgxDFOWLl7WX5ZMCvv2dnzMaJCqPuNXx+1t+LERJgI7++uG0ZO8RDFLJAvyCI
         6vtlGj/aPA2PgSjWEt8UtsZ2xZdxNwmtf+811n5cci63SBJXhTeNlao84VjBtwx3aiTl
         s38YNeMwPr3A3vty/petaHAj8L8Cp0/4FFpjrNOxoaoFY0wMbu+pYKT24o7mxuljGGk1
         3n0I9/ZcxrVJxkW7sWptnhLEWk3ERnQ1o+AXflBrA9HjWDQk8m55PwirzEGfHMLb1vh8
         q7+siU7xerds1v9PduFCN+C6GGgZPfPvY7YYRFUuFFfJmz0Rx+3B38Y4gM9Pr7Gm2W8t
         rdAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=kEx1JTVWGnPw7PBaID0vQzLE5AVxmop4HrGd6+u6kxc=;
        b=Az3SvaA6YLT2qbwtOlKf5i3OiQPxwp+U2RC9nFFxTZDF8F773ddliKU0iKZiSp/FHn
         tf3RrE8MT81tb+OXBJ6AsyKetw8kpfmzD9cBvg3lHOQkHtwDNtWW4Ph3eYIDZHqKQi89
         J4xRH8UFat2OHkgw4QYbo1smp2FegPWHyJKROURgKWHcRUy6xxMOOQ++nt4A/ILj6VFe
         LbcUyi7tg8jCo74iagq5VOQQg6X9ZfgXOv85hw9ANEt49y7HvWVFp+n1LKiDFxXWCcV7
         B/8J/L5Iz7Iip0838uFq5nIz8CJDb7EqUa3UR547bplnKFjcJFf8kW33wrdtX718YR4T
         LiMg==
X-Gm-Message-State: APjAAAX148R2UU8YQ3zECo0kjRLbpJmgbIhB/ToNye8w1xpR6sNupY2/
        FKh9IIGI12f4/8KhA4271GP0z71U5fS6zWMS
X-Google-Smtp-Source: APXvYqw6UZScP0QuYWM6ggxZU6RObcNzc+ZCIWguGEz2HJky3VLBkJe0y3M2lj9SX52WcJWNIbqPrvDmuPtF+BPV
X-Received: by 2002:a1f:1d58:: with SMTP id d85mr6949921vkd.13.1562970145444;
 Fri, 12 Jul 2019 15:22:25 -0700 (PDT)
Date:   Fri, 12 Jul 2019 15:21:18 -0700
Message-Id: <20190712222118.108192-1-henryburns@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH] mm/z3fold.c: Allow __GFP_HIGHMEM in z3fold_alloc
From:   Henry Burns <henryburns@google.com>
To:     Vitaly Wool <vitalywool@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Vitaly Vul <vitaly.vul@sony.com>,
        Shakeel Butt <shakeelb@google.com>,
        Jonathan Adams <jwadams@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Snild Dolkow <snild@sony.com>,
        Thomas Gleixner <tglx@linutronix.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Henry Burns <henryburns@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One of the gfp flags used to show that a page is movable is
__GFP_HIGHMEM.  Currently z3fold_alloc() fails when __GFP_HIGHMEM is
passed.  Now that z3fold pages are movable, we allow __GFP_HIGHMEM. We
strip the movability related flags from the call to kmem_cache_alloc()
for our slots since it is a kernel allocation.

Signed-off-by: Henry Burns <henryburns@google.com>
---
 mm/z3fold.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/z3fold.c b/mm/z3fold.c
index e78f95284d7c..cb567ddf051c 100644
--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -193,7 +193,8 @@ static inline struct z3fold_buddy_slots *alloc_slots(struct z3fold_pool *pool,
 							gfp_t gfp)
 {
 	struct z3fold_buddy_slots *slots = kmem_cache_alloc(pool->c_handle,
-							    gfp);
+							    (gfp & ~(__GFP_HIGHMEM
+								   | __GFP_MOVABLE)));
 
 	if (slots) {
 		memset(slots->slot, 0, sizeof(slots->slot));
@@ -844,7 +845,7 @@ static int z3fold_alloc(struct z3fold_pool *pool, size_t size, gfp_t gfp,
 	enum buddy bud;
 	bool can_sleep = gfpflags_allow_blocking(gfp);
 
-	if (!size || (gfp & __GFP_HIGHMEM))
+	if (!size)
 		return -EINVAL;
 
 	if (size > PAGE_SIZE)
-- 
2.22.0.510.g264f2c817a-goog

