Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDCF0C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 09:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF1FF208CB
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 09:16:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pkMUEqi2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbfF1JQU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 05:16:20 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41853 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726857AbfF1JQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 05:16:20 -0400
Received: by mail-pg1-f196.google.com with SMTP id q4so837279pgj.8
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 02:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xMgzax4HjoaAL0uerD4B+UL3X0tNIUoyb0iGc+fPFY0=;
        b=pkMUEqi2gh11gMyO1DLpyj6T4hT7ZIBs0smgUtCgoKOsFm1XzpuA2s+WwNvnIEyS76
         5c4BEyOEwRkuqSsIg0vepw+6AtPOG3kXJyJ2RIQBRzNknEu2wGwRhgGIei+yZ18W5CBj
         NQL5OWapwBwYNkHS+xngAyqNoyD/GpDeSOJ3aOeANW63Pev8JEDNQtSzloPMnDUIl4C5
         o1EvRqAwkmKEet0GLEbCmvadaDFfcc1mGi7mmN16ATrBqkGdpWXTOqAGhK5WTfq6+ZIP
         Z11o5bPE3hmSyPpwPx6DHuoHfNMvOS36o/kS6NMiQSWWRHJPfqau+uc7PEf+yTiCumKS
         9dUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xMgzax4HjoaAL0uerD4B+UL3X0tNIUoyb0iGc+fPFY0=;
        b=taQ7s0Smyob8VVz5xSuUn+SqFwgG5pDcezq7XH6ThnBmMNnZkMHj2N08ZvG0fXG9af
         o5qs9k9mn3vUR5HwFM+xeO93y5NJv6kwuLeQ0x0E+d1igzfBEK4m3gEmPKcZZ5Xb+xWF
         4ln4PIcjpGL4TSwD0bs/UAijiE0od48dB++55sxFTl8AyIiedKom7BEd9jG7uT0poNOi
         VPm4Mhn1Dyfl+OM0FCysjyBgFTq9fFggoeJK30ZwQU3wNlFGou5xfJGcyLt1vWdgMGpk
         vJ2bTIvWfJ5Y8rLGV37KjUWVHWgHn82h1ApzAm56SjU1Ebydzwjwg4N2wUZ7UykHiEx/
         Jr8Q==
X-Gm-Message-State: APjAAAWcNemjMUDqyZhAY84POtZHoA6xso70geKqZTJqHmpL2Sna9h3E
        3tzITcACMBpDFGT7kMm47T0=
X-Google-Smtp-Source: APXvYqz1+iWFsxYxrP7QqY0vWkc0JOGmeo1Cx9GCUrvUKOzDk6EzDJGVe7LEzAYQ8MNMPgrdQKbW7w==
X-Received: by 2002:a63:6d8d:: with SMTP id i135mr1290684pgc.303.1561713379501;
        Fri, 28 Jun 2019 02:16:19 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id x65sm1754521pfd.139.2019.06.28.02.16.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2019 02:16:19 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        longman@redhat.com, paulmck@linux.vnet.ibm.com,
        boqun.feng@gmail.com, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v3 08/30] locking/lockdep: Skip checks if direct dependency is already present
Date:   Fri, 28 Jun 2019 17:15:06 +0800
Message-Id: <20190628091528.17059-9-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190628091528.17059-1-duyuyang@gmail.com>
References: <20190628091528.17059-1-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When checking a dependency <prev> -> <next>, two checks are performed:

1. Lock inversion deadlock:

We search whether there is a path from <next> to <prev> in the dependency
graph for potential deadlock scenario in check_deadlock_graph(). But if
the direct dependency <prev> -> <next> is already in the graph, there
can't be such a path (i.e., <next> to <prev>) because otherwise this
path would have been found when adding the last critical dependency that
completes it.

2. IRQ usage violation:

The IRQ usage check searches whether there is a path through <prev> to
<next> that connects an irq-safe lock to an irq-unsafe lock in the
dependency graph in check_irq_usage(). Similarly, if <prev> -> <next> is
already in the graph, there can't be such a path.

This skipping should be able to greatly improve performance by reducing
the number of deadlock and IRQ usage checks. This number precisely
equals nr_redundant, which actually is not a small number.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 kernel/locking/lockdep.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index c61fdef..4ffb4df 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2363,6 +2363,25 @@ static inline void inc_chains(void)
 	}
 
 	/*
+	 * Is the <prev> -> <next> dependency already present?
+	 *
+	 * (this may occur even though this is a new chain: consider
+	 *  e.g. the L1 -> L2 -> L3 -> L4 and the L5 -> L1 -> L2 -> L3
+	 *  chains - the second one will be new, but L1 already has
+	 *  L2 added to its dependency list, due to the first chain.)
+	 */
+	list_for_each_entry(entry, &hlock_class(prev)->locks_after, entry) {
+		if (entry->class == hlock_class(next)) {
+			debug_atomic_inc(nr_redundant);
+
+			if (distance == 1)
+				entry->distance = 1;
+
+			return 1;
+		}
+	}
+
+	/*
 	 * Prove that the new <prev> -> <next> dependency would not
 	 * create a deadlock scenario in the graph. (We do this by
 	 * a breadth-first search into the graph starting at <next>,
@@ -2389,21 +2408,6 @@ static inline void inc_chains(void)
 	 */
 	if (next->read == 2 || prev->read == 2)
 		return 1;
-	/*
-	 * Is the <prev> -> <next> dependency already present?
-	 *
-	 * (this may occur even though this is a new chain: consider
-	 *  e.g. the L1 -> L2 -> L3 -> L4 and the L5 -> L1 -> L2 -> L3
-	 *  chains - the second one will be new, but L1 already has
-	 *  L2 added to its dependency list, due to the first chain.)
-	 */
-	list_for_each_entry(entry, &hlock_class(prev)->locks_after, entry) {
-		if (entry->class == hlock_class(next)) {
-			if (distance == 1)
-				entry->distance = 1;
-			return 1;
-		}
-	}
 
 	if (!trace->nr_entries && !save_trace(trace))
 		return 0;
-- 
1.8.3.1

