Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF393C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F0842166E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:37:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nfaWlfTV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbfKGTho (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 14:37:44 -0500
Received: from mail-pg1-f201.google.com ([209.85.215.201]:33706 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbfKGTho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 14:37:44 -0500
Received: by mail-pg1-f201.google.com with SMTP id y22so2662222pgc.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 11:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=LJ5qu1d1qYTmvRrw2/bIxoaJkdqKaiuo2RqaAL/gLjQ=;
        b=nfaWlfTVssvz5xKSSFcy1G4yFKmpFodEY52ELUWfRbdELBywKboP3WuzeqObOCPVJ+
         oibB5HCXQjUs6GGW1eBBLTPppMXXsLZPaPRTtLwL6w7ctbPO2FlLsZmKVJsaAGXkNHvy
         tv7Bdb+8EXr9w8CPJg41av4kkucclnrfkQ9Ucf95GgLoPFGlr3xtQE0x/DP78CO70VD+
         AfwMmNStevSZSvISY/QBZ2PKZ3M39VnXDG7Js8X5b25apb4AIR1MNVWs9abMFAVuVadg
         zblVAYfF8BZenWVPnU3SRdE/5iK2Son+iGZJlVhgEVsbedn3OdLVJGUcrnWibxKg+1SN
         YpFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=LJ5qu1d1qYTmvRrw2/bIxoaJkdqKaiuo2RqaAL/gLjQ=;
        b=kE/YUNyaRMHukotUbbJ/yVAIsmYzMnGoBBJl0jr9AlH9HstEV9x6RtNreL5OHoGjSw
         9LC8vfsYBpQ8TclahthEA9TW5FTAf0F7ZLvj8uK4QQ+VAcOJTaCbR4ZjWDPjTAFq4QfP
         /JWIvCFeDWsfLv9fXP3PgptSjlYJLxXg3jQZ+BOlTd9f9TvfvIEdvRZycUhKU5Mc6Pux
         FfKRiM/1/6ricHNODpK2RZp0CjVyw+bPxwGne8zORVDdMcNcDGQ3OMdNP4BALy7RKIyS
         drS2W/C+4YzBjNvrwvNZW/D2rxsX/31+yEWJ+OedZGux9JJ9Hby25bFZHB4eeqXonuUJ
         xIhw==
X-Gm-Message-State: APjAAAXN/bKn+eIcHSYjHEXpkGdBLTTyViTElDBL2zc7NilLdqPnYrOO
        cTr/sF73Fna1MqGMcsmpiRhKVGKIHYxEaQ==
X-Google-Smtp-Source: APXvYqxghuocbGVy4JqgXYeLsYpAilxoAYqmI6RcKnNtzoZtYEiMAd5XWQfVYaD23hAG7YMa2GfMfnIGv619kg==
X-Received: by 2002:a63:a5b:: with SMTP id z27mr6849735pgk.416.1573155461548;
 Thu, 07 Nov 2019 11:37:41 -0800 (PST)
Date:   Thu,  7 Nov 2019 11:37:37 -0800
Message-Id: <20191107193738.195914-1-edumazet@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: [PATCH 1/2] list: add hlist_unhashed_lockless()
From:   Eric Dumazet <edumazet@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We would like to use hlist_unhashed() from timer_pending(),
which runs without protection of a lock.

Note that other callers might also want to use this variant.

Instead of forcing a READ_ONCE() for all hlist_unhashed()
callers, add a new helper with an explicit _lockless suffix
in the name to better document what is going on.

Also add various WRITE_ONCE() in __hlist_del(), hlist_add_head()
and hlist_add_before()/hlist_add_behind() to pair with
the READ_ONCE().

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/list.h | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/include/linux/list.h b/include/linux/list.h
index 85c92555e31f85f019354e54d6efb8e79c2aee17..61f5aaf96192cdc4c1644741a415590b63c3c201 100644
--- a/include/linux/list.h
+++ b/include/linux/list.h
@@ -749,6 +749,16 @@ static inline int hlist_unhashed(const struct hlist_node *h)
 	return !h->pprev;
 }
 
+/* This variant of hlist_unhashed() must be used in lockless contexts
+ * to avoid potential load-tearing.
+ * The READ_ONCE() is paired with the various WRITE_ONCE() in hlist
+ * helpers that are defined below.
+ */
+static inline int hlist_unhashed_lockless(const struct hlist_node *h)
+{
+	return !READ_ONCE(h->pprev);
+}
+
 static inline int hlist_empty(const struct hlist_head *h)
 {
 	return !READ_ONCE(h->first);
@@ -761,7 +771,7 @@ static inline void __hlist_del(struct hlist_node *n)
 
 	WRITE_ONCE(*pprev, next);
 	if (next)
-		next->pprev = pprev;
+		WRITE_ONCE(next->pprev, pprev);
 }
 
 static inline void hlist_del(struct hlist_node *n)
@@ -782,32 +792,32 @@ static inline void hlist_del_init(struct hlist_node *n)
 static inline void hlist_add_head(struct hlist_node *n, struct hlist_head *h)
 {
 	struct hlist_node *first = h->first;
-	n->next = first;
+	WRITE_ONCE(n->next, first);
 	if (first)
-		first->pprev = &n->next;
+		WRITE_ONCE(first->pprev, &n->next);
 	WRITE_ONCE(h->first, n);
-	n->pprev = &h->first;
+	WRITE_ONCE(n->pprev, &h->first);
 }
 
 /* next must be != NULL */
 static inline void hlist_add_before(struct hlist_node *n,
 					struct hlist_node *next)
 {
-	n->pprev = next->pprev;
-	n->next = next;
-	next->pprev = &n->next;
+	WRITE_ONCE(n->pprev, next->pprev);
+	WRITE_ONCE(n->next, next);
+	WRITE_ONCE(next->pprev, &n->next);
 	WRITE_ONCE(*(n->pprev), n);
 }
 
 static inline void hlist_add_behind(struct hlist_node *n,
 				    struct hlist_node *prev)
 {
-	n->next = prev->next;
-	prev->next = n;
-	n->pprev = &prev->next;
+	WRITE_ONCE(n->next, prev->next);
+	WRITE_ONCE(prev->next, n);
+	WRITE_ONCE(n->pprev, &prev->next);
 
 	if (n->next)
-		n->next->pprev  = &n->next;
+		WRITE_ONCE(n->next->pprev, &n->next);
 }
 
 /* after that we'll appear to be on some hlist and hlist_del will work */
-- 
2.24.0.432.g9d3f5f5b63-goog

