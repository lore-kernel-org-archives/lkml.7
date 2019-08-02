Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11242C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 20:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4CE321726
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 20:38:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lFbzfYpq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394796AbfHBUij (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 16:38:39 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:36876 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394684AbfHBUij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 16:38:39 -0400
Received: by mail-io1-f65.google.com with SMTP id q22so35155119iog.4;
        Fri, 02 Aug 2019 13:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=15AsbvKNjYJ9b/OIIawZCeSMaB23ubOiCxSCFFS7Yik=;
        b=lFbzfYpqj4gNFEIdDDa2rrSFUKQHX9eHq6sxxGqzeYD8rfXC+01B1Z7TDcZBThIo+f
         76kjCfvBe5stXPAox2PEz1GwKO3hmHjUWRbEY4viPxPV6A8TaM8b9T5dwVUn3uAiEFiw
         6e2zQEveynWEn8PqmaX532H66kwHnOwDUSxBrsn7mcS66uXAn3qm47Du8dj5QBv4MAjW
         n8XOcg4+GjK/y4Ft1aNtreadOTFCa8LAm6D3HC3zjiXp9Vn6Yy1M7sUR3SlW3BiFkUQ4
         LYrY55rj/YeucqyTF/w0ms545iz7blyobBB4md3sZJddh6wI8dCD42q0WSffSqvZfzjV
         7jZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=15AsbvKNjYJ9b/OIIawZCeSMaB23ubOiCxSCFFS7Yik=;
        b=t/DcgJw9KDTBOcaKxNHFDZ8tyxWOpZ4tsDumCD33Cq1Kk3omY9KebNOgmkGRPg+KLZ
         WkVXwha4nUwyM3StB2/7G+ITYwTcCKNXBmG/EM7YAhbqNRtmClXEvOTlsA6BKYNiAUsv
         SurzGH+nGkD3J8J0o6u3xu1o4an8ylmDzDs/u8N7DXHOvcbZjLETKW4l2lEVy89KJJrb
         8rJtU6NuueyigVWLFPgIMVBySD90nf6p4/ynC47xEaSziRkK1149EFm+AqjGxPTogzOJ
         XkVP1FAr2kAmB9lgcf1pTH9Xw3EAmdQd8mWTWtAbVcg4Up9CxohB5JpfQiWzqbsl7NzT
         7kdA==
X-Gm-Message-State: APjAAAURIZ4jJivyQ4ek6EjMY08ri9TRIcMZRlBEVZjz285jDbRRTNrD
        UyS1Gjtmf+vc19KboEMp4BogRBbwXo49RQ==
X-Google-Smtp-Source: APXvYqwT+feVg8X6UqMPMCqRKdbFQ9B2D6vfO8WNoLfxLNmK6KJY/9+chpmP5qPARyRrm7YdJy+aqQ==
X-Received: by 2002:a05:6638:c8:: with SMTP id w8mr145347977jao.52.1564778317808;
        Fri, 02 Aug 2019 13:38:37 -0700 (PDT)
Received: from oc2825805254.ibm.com ([32.97.110.52])
        by smtp.gmail.com with ESMTPSA id r5sm65331912iom.42.2019.08.02.13.38.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Aug 2019 13:38:37 -0700 (PDT)
From:   Ethan Hansen <1ethanhansen@gmail.com>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, paulmck@linux.ibm.com,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, Ethan Hansen <1ethanhansen@gmail.com>
Subject: [PATCH tip/core/rcu 1/1] rcu: Remove unused function hlist_bl_del_init_rcu
Date:   Fri,  2 Aug 2019 13:37:58 -0700
Message-Id: <1564778278-21186-1-git-send-email-1ethanhansen@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function hlist_bl_del_init_rcu is declared in rculist_bl.h,
but never used. Remove hlist_bl_del_init_rcu to clean code.

Signed-off-by: Ethan Hansen <1ethanhansen@gmail.com>
---
 include/linux/rculist_bl.h | 28 ----------------------------
 1 file changed, 28 deletions(-)

diff --git a/include/linux/rculist_bl.h b/include/linux/rculist_bl.h
index 66e73ec..0b952d0 100644
--- a/include/linux/rculist_bl.h
+++ b/include/linux/rculist_bl.h
@@ -25,34 +25,6 @@ static inline struct hlist_bl_node *hlist_bl_first_rcu(struct hlist_bl_head *h)
 }
 
 /**
- * hlist_bl_del_init_rcu - deletes entry from hash list with re-initialization
- * @n: the element to delete from the hash list.
- *
- * Note: hlist_bl_unhashed() on the node returns true after this. It is
- * useful for RCU based read lockfree traversal if the writer side
- * must know if the list entry is still hashed or already unhashed.
- *
- * In particular, it means that we can not poison the forward pointers
- * that may still be used for walking the hash list and we can only
- * zero the pprev pointer so list_unhashed() will return true after
- * this.
- *
- * The caller must take whatever precautions are necessary (such as
- * holding appropriate locks) to avoid racing with another
- * list-mutation primitive, such as hlist_bl_add_head_rcu() or
- * hlist_bl_del_rcu(), running on this same list.  However, it is
- * perfectly legal to run concurrently with the _rcu list-traversal
- * primitives, such as hlist_bl_for_each_entry_rcu().
- */
-static inline void hlist_bl_del_init_rcu(struct hlist_bl_node *n)
-{
-	if (!hlist_bl_unhashed(n)) {
-		__hlist_bl_del(n);
-		n->pprev = NULL;
-	}
-}
-
-/**
  * hlist_bl_del_rcu - deletes entry from hash list without re-initialization
  * @n: the element to delete from the hash list.
  *
-- 
1.8.3.1

