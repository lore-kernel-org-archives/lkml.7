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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC0DC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 09:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 829CD208CB
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 09:17:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o3Kr9ncc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbfF1JRP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 05:17:15 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35532 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727059AbfF1JRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 05:17:13 -0400
Received: by mail-pl1-f194.google.com with SMTP id w24so2913943plp.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 02:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=183urw1MfrVHvspMp9oXDhwdMiQ5A5kZ+cnVzHTVPhU=;
        b=o3Kr9ncccY7J4ETX8NNJW0KwyJzwGgnfzcaarfqguC5OUu9pPwwF+wc07ht4obPYvo
         H4c+lXmK8VjEjdHuGQXe0lV7c6ooxrQyxqAt+x4AMailQz+co425ppy0HjUocjzrXtKs
         9QiXNaqRM6XqSoC/gul2RsTZvntZqsyIb+mDCkvIX8kdKPQ+niphDhcJIvS/SmJy1/qS
         0dw4CAKGurdfRUI+KnUkzJPq0UoZ4s4uPqcoWT4cFuPSoB//8O4Q5Dk57Gc9V6fZ0g89
         8iq0C7QswIAyCYsxvo1m005W85CwSlIWnoSNeNoEOHVdOPem/wiVEdY2m8pk9OIws3Vu
         Kk6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=183urw1MfrVHvspMp9oXDhwdMiQ5A5kZ+cnVzHTVPhU=;
        b=lttwhPOcB/7nfYG7dIIGmQhO2XmaLrn+ta9dYcfbu4lIuS/9otQMT4xJ+qeaEESRo4
         six/TiHvbmyQq5bGwUfIJBrkZIlbgL4vMlIW+c2J9Ilqml1EzFXrOh9TnOjRH0vJZA0m
         fNc7yPYthr/nFK9MxdWLwxve29g/z99JyKuEhx8cJLpaNhJVitLot4KBr1h+pSLpCxg2
         f08JH3xNfYdYIDdGLrUg0uqM60EqCYEI7xLWcbc+gJA+k7lT+TYmIxMqpoEfglqVFzNL
         1MNqanWh13XjLL5DV4Q42/Ng5oLCbhyeK4JUs/8MJyktScDzi18OLN4jA7OV4eyuEXpL
         NFYQ==
X-Gm-Message-State: APjAAAWleTpjD/QPGv2pE0Ai6/l2orCAyr0++ZdLbbobNoHRbvG/NUV3
        ZzXCgIo86UGXTmjr63tAW6g=
X-Google-Smtp-Source: APXvYqz2/cjSRAu6rqOW+olZEZBpcx9unYQSxmaESw8iTwG00cyfLL72X+3Be+wwEKwq6QDZzFLItA==
X-Received: by 2002:a17:902:b70f:: with SMTP id d15mr9833000pls.318.1561713433195;
        Fri, 28 Jun 2019 02:17:13 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id x65sm1754521pfd.139.2019.06.28.02.17.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2019 02:17:12 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        longman@redhat.com, paulmck@linux.vnet.ibm.com,
        boqun.feng@gmail.com, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v3 20/30] locking/lockdep: Introduce chain_hlocks_type for held lock's read-write type
Date:   Fri, 28 Jun 2019 17:15:18 +0800
Message-Id: <20190628091528.17059-21-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190628091528.17059-1-duyuyang@gmail.com>
References: <20190628091528.17059-1-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lock chain needs to include information about the read-write lock type. To
that end, introduce:

	chain_hlocks_type[MAX_LOCKDEP_CHAIN_HLOCKS]

in addition to:

	chain_hlocks[MAX_LOCKDEP_CHAIN_HLOCKS]

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 kernel/locking/lockdep.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 2329add..27eeacc 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -882,6 +882,7 @@ static bool class_lock_list_valid(struct lock_class *c, int forward)
 
 #ifdef CONFIG_PROVE_LOCKING
 static u16 chain_hlocks[MAX_LOCKDEP_CHAIN_HLOCKS];
+static u16 chain_hlocks_type[MAX_LOCKDEP_CHAIN_HLOCKS];
 #endif
 
 static bool check_lock_chain_key(struct lock_chain *chain)
@@ -2592,6 +2593,7 @@ static inline void inc_chains(void)
 static DECLARE_BITMAP(lock_chains_in_use, MAX_LOCKDEP_CHAINS);
 int nr_chain_hlocks;
 static u16 chain_hlocks[MAX_LOCKDEP_CHAIN_HLOCKS];
+static u16 chain_hlocks_type[MAX_LOCKDEP_CHAIN_HLOCKS];
 
 struct lock_class *lock_chain_get_class(struct lock_chain *chain, int i)
 {
@@ -2795,9 +2797,13 @@ static inline struct lock_chain *add_chain_cache(struct task_struct *curr,
 		chain->base = nr_chain_hlocks;
 		for (j = 0; j < chain->depth - 1; j++, i++) {
 			int lock_id = curr->held_locks[i].class_idx;
+			int lock_type = curr->held_locks[i].read;
+
 			chain_hlocks[chain->base + j] = lock_id;
+			chain_hlocks_type[chain->base + j] = lock_type;
 		}
 		chain_hlocks[chain->base + j] = class - lock_classes;
+		chain_hlocks_type[chain->base + j] = hlock->read;
 		nr_chain_hlocks += chain->depth;
 	} else {
 		if (!debug_locks_off_graph_unlock())
@@ -4811,6 +4817,9 @@ static void remove_class_from_lock_chain(struct pending_free *pf,
 			memmove(&chain_hlocks[i], &chain_hlocks[i + 1],
 				(chain->base + chain->depth - i) *
 				sizeof(chain_hlocks[0]));
+			memmove(&chain_hlocks_type[i], &chain_hlocks_type[i + 1],
+				(chain->base + chain->depth - i) *
+				sizeof(chain_hlocks_type[0]));
 		}
 		/*
 		 * Each lock class occurs at most once in a lock chain so once
@@ -5278,6 +5287,7 @@ void __init lockdep_init(void)
 		+ sizeof(lock_chains_in_use)
 		+ sizeof(lock_chains_in_dep)
 		+ sizeof(chain_hlocks)
+		+ sizeof(chain_hlocks_type)
 #endif
 		) / 1024
 		);
-- 
1.8.3.1

