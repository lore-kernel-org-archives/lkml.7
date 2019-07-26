Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B200C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 22:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B37E20657
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 22:48:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t93ANIwe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727733AbfGZWsR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 18:48:17 -0400
Received: from mail-vs1-f73.google.com ([209.85.217.73]:51151 "EHLO
        mail-vs1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbfGZWsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 18:48:16 -0400
Received: by mail-vs1-f73.google.com with SMTP id u17so14551907vsq.17
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 15:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ugYwzqnv6FobgASB/IV2QGrorIeaEWGKXnYtHi2Zf0I=;
        b=t93ANIwehynL05QpzsPZQsNzsYxLbN+DEc+mU/gC8S3QoOdwTg6FWn2YHKT6g/JEBV
         +plV+4WjbYjE9Iw7uZ1VG0BDJ+16Y9xWYd9v1LIt6vDngPyZg0/hmMjTS2I9YEl9jicA
         31jSLX5XQ9oBkwYmBtzOxenRKIsCwx4PNL90gPuNXhPk5XJ3rUEY55ZCDSl1dislK+H0
         g6Wfn1ehtdFKdIlTR020Dp7vd8oiLIwlhadCFIXKZS3z+9hQC3ZJf+K+w2i2gEvpCJ31
         DBHOPYqz9sCbWxdhFNbi+HS5+FiuDxaZBwOgrnmhPGa7Xuj/2HX8s72wsXj3lo0fpkwD
         hnag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ugYwzqnv6FobgASB/IV2QGrorIeaEWGKXnYtHi2Zf0I=;
        b=iDVWuiNuHyVZ2eR8pj5MCv1rrFOXroRswe3HFXMi3GKb1lEYP/ACAXaTw5Q3JeVfQg
         L3q9mjdLDAqNt6Sqxyb09B1kVAGklpYTDpYstupWb0Vm7LBAgYiv7rOowXXgcinloEY6
         wmv4ddNoOj3PNTrcAjp/vuMEH8gxXBmnhh/lLeeUqHOaywYMdLVQGjoQ4pPQefWR4gdH
         +FG8L/FXkLbvSmPRTT+FGYfPGkTOxCIyfVRQDB5h6wRApvO0fBSkFlkqy+5wGDTHeik1
         w7Q7VZuDUm7EwVvfMj7XgVDtLQGpeHBq0uPcFirvU9+tOuIMecsHmT8XQQCyYrsN6HL0
         dGYw==
X-Gm-Message-State: APjAAAXWoPBRrvJf7jv/nn+vVPdpYo496gsXmyCCGw49pMVTlpiY4Kq4
        Kck3PVBp1J3wnnWLZXOipUD59bhnVQStpkMs
X-Google-Smtp-Source: APXvYqwkSvswxUgvR5c6fCqlODLxRregW3zUnnkYsv9AKzH6EnFwtFPMVKnEpmizdeK6j5ngy/2lUoNmIaVHBLtU
X-Received: by 2002:a1f:6e8e:: with SMTP id j136mr2583640vkc.80.1564181295126;
 Fri, 26 Jul 2019 15:48:15 -0700 (PDT)
Date:   Fri, 26 Jul 2019 15:48:09 -0700
Message-Id: <20190726224810.79660-1-henryburns@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
Subject: [PATCH] mm/z3fold.c: Fix z3fold_destroy_pool() ordering
From:   Henry Burns <henryburns@google.com>
To:     Vitaly Vul <vitaly.vul@sony.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Jonathan Adams <jwadams@google.com>,
        David Howells <dhowells@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Henry Burns <henryburns@google.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The constraint from the zpool use of z3fold_destroy_pool() is there are no
outstanding handles to memory (so no active allocations), but it is possible
for there to be outstanding work on either of the two wqs in the pool.

If there is work queued on pool->compact_workqueue when it is called,
z3fold_destroy_pool() will do:

   z3fold_destroy_pool()
     destroy_workqueue(pool->release_wq)
     destroy_workqueue(pool->compact_wq)
       drain_workqueue(pool->compact_wq)
         do_compact_page(zhdr)
           kref_put(&zhdr->refcount)
             __release_z3fold_page(zhdr, ...)
               queue_work_on(pool->release_wq, &pool->work) *BOOM*

So compact_wq needs to be destroyed before release_wq.

Fixes: 5d03a6613957 ("mm/z3fold.c: use kref to prevent page free/compact race")

Signed-off-by: Henry Burns <henryburns@google.com>
Cc: <stable@vger.kernel.org>
---
 mm/z3fold.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/mm/z3fold.c b/mm/z3fold.c
index 1a029a7432ee..43de92f52961 100644
--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -818,8 +818,15 @@ static void z3fold_destroy_pool(struct z3fold_pool *pool)
 {
 	kmem_cache_destroy(pool->c_handle);
 	z3fold_unregister_migration(pool);
-	destroy_workqueue(pool->release_wq);
+
+	/*
+	 * We need to destroy pool->compact_wq before pool->release_wq,
+	 * as any pending work on pool->compact_wq will call
+	 * queue_work(pool->release_wq, &pool->work).
+	 */
+
 	destroy_workqueue(pool->compact_wq);
+	destroy_workqueue(pool->release_wq);
 	kfree(pool);
 }
 
-- 
2.22.0.709.g102302147b-goog

