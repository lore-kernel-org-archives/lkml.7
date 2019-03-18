Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93AE7C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 08:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6303A20857
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 08:57:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WsRWPL6+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbfCRI54 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 04:57:56 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45099 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727169AbfCRI5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 04:57:55 -0400
Received: by mail-pg1-f196.google.com with SMTP id y3so1690981pgk.12
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 01:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3lried6XaOFyWkZmq/CgDO0B4r8ya+eoSN9YUAuR9FI=;
        b=WsRWPL6+NI6kMq6/xXk+lseVkZjqMPPlm7wk8GcBEpTFm9fJj6hgTUXDMeFXX5lhlQ
         jWHziyRaODcxvT+D9t/VWwDw/nvcYlHDcJLljYyusVv9o/58grVQNEaK9cb1AQ5KsDAT
         782lf91+IuAJKEMhrpDYKlBc2scb0ADn/UItco439jGtG40+SrPrcsGxForhboOHSnuM
         7kYVNzNonkaONFj4GURDOTjC0T4xbkpkAkglQZ1CqxjCvyxkqdzsxHrs/iLxvPjszkyG
         Mw1BuPxSkiR0Q8YBQpwxKCP5W9c6iAqeTnYhTRz05fTuaQ4EzuUFJKSRrXaXN4lIgxuC
         Rmfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3lried6XaOFyWkZmq/CgDO0B4r8ya+eoSN9YUAuR9FI=;
        b=qvCwkX+6smYckgSrzMVh3DNFX6YlN72+Mdj1cQrovXJyukS2LB/qMpbZOLw8B2TTvH
         JX+xi+MzIeQI88apKd/MpWHURTiuNSrAGv/g8YJOpg/ZJTOFLpu+zPuq8sD0ZrfrvzJn
         hUlWFnzditF/r3X8f2dbBebLkNKfUFnLeGw5PsiDGFiIFsnp09tpy9AUNF1ekGWzW8gF
         dY9+wPyYEqA9vUpcMEozMACU7alXGVXBxg/l8QxTeZ3AKprMS7v+x2YKd8G46Ka3MeS/
         vCHjIYeznvBNzWEwtzZ6/adPg5gCje76hvnLReKuLFMGobiCcJah/668xXjRavs+h5gE
         QaLQ==
X-Gm-Message-State: APjAAAXioAJMaQHJrFXNlsUcQsZw+67cyoelXTl1ILon3qCHrmpl86hv
        ozlRKGdEDVjgS67Zh4/fmpU=
X-Google-Smtp-Source: APXvYqwKAl+M8VP4qpLJRNzWmfIYMOw87eUMkA+wXeZOv5cNHMCFhhajS/4v85ab22O9hJS1I3kBnQ==
X-Received: by 2002:aa7:8012:: with SMTP id j18mr18605947pfi.42.1552899474848;
        Mon, 18 Mar 2019 01:57:54 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id k8sm11147024pgq.37.2019.03.18.01.57.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 01:57:54 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com,
        linux-kernel@vger.kernel.org, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v2 04/19] locking/lockdep: Remove useless conditional macro
Date:   Mon, 18 Mar 2019 16:57:18 +0800
Message-Id: <20190318085733.3143-5-duyuyang@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20190318085733.3143-1-duyuyang@gmail.com>
References: <20190318085733.3143-1-duyuyang@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since #defined(CONFIG_PROVE_LOCKING) is used in the scope of #ifdef
CONFIG_PROVE_LOCKING, it can be removed.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 kernel/locking/lockdep.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index d5b66cf..dea495b 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1677,7 +1677,7 @@ unsigned long lockdep_count_backward_deps(struct lock_class *class)
 	return result;
 }
 
-#if defined(CONFIG_TRACE_IRQFLAGS) && defined(CONFIG_PROVE_LOCKING)
+#if defined(CONFIG_TRACE_IRQFLAGS)
 /*
  * Forwards and backwards subgraph searching, for the purposes of
  * proving that two subgraphs can be connected by a new dependency
@@ -2055,7 +2055,7 @@ static inline void inc_chains(void)
 	nr_process_chains++;
 }
 
-#endif
+#endif /* CONFIG_TRACE_IRQFLAGS */
 
 static void print_deadlock_scenario(struct held_lock *nxt,
 				    struct held_lock *prv)
@@ -2737,7 +2737,7 @@ static inline int validate_chain(struct task_struct *curr,
 {
 	return 1;
 }
-#endif
+#endif /* CONFIG_PROVE_LOCKING */
 
 /*
  * We are building curr_chain_key incrementally, so double-check
-- 
1.8.3.1

