Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A843C04AB4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 08:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0912D20881
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 08:00:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dTU2Gci3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbfEPIAy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 04:00:54 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36346 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbfEPIAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 04:00:52 -0400
Received: by mail-pl1-f196.google.com with SMTP id d21so1229384plr.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 01:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8aoX0MhCXhDfp6r6BP2v4yLB8VnqTXCe1YaS9DQuIKs=;
        b=dTU2Gci3gWjB3WvLP9vPSZY3iwB4x3oSAG25cZzhHofzc8KwcnG9FAv9LrkqA3zxrB
         Vnr1ArHjz+RlfKeGqS3ul4B/Q2c4AE3Hqp51F2cP6m9/dcWSQRRxlFXoYk1v/0Lds4Yg
         F0AgcZ8qyZPO7UM4VKNtYasR+es3VY8iWJnL4GZEdIgJ/GmmCNxvZqEenLskv4Tkhhgp
         dshhdimJhxL/A/yaYFO+toTrlBUpzsYOmVXuiZoO3h4L6H8novYkKeTvZDJ2uQl78Z/M
         qc0b1hEnpvYA+pEYIobylKtMYZUl0wGaJOEsosWGA3xS34Wl8wSEmc8hD5xIbeEuIRb8
         Q6mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8aoX0MhCXhDfp6r6BP2v4yLB8VnqTXCe1YaS9DQuIKs=;
        b=WOhys2636hbdUP3L6sgsSsv9ZmYkdgoXIAgOwMtlmKWfMXbrFa8ZF3XYw0iCAUhvzv
         GiWS1klbgsjAhcEuDpF51zxLxkLRy0Ga2BIe/sFVfQwymx/5PV/I4yfA2KmbfmR3RhLR
         ZtpCcn+DCuzdookI1uz0FWgw8qHwXV9yGKBIlBYkSj6Jy1sdwJPQ9swYVHZaXxBcxSY0
         Awsa7q66Oqg9R6nVpgahn3rR6T3B0G0kUzCXC/PY+8ErMgg6AHkrcclFB+f9FYWVGOSM
         E1Dsy8e29Q3qkSvSMCyPpOOMpvhdd4WtAgC6suRzMSKc48G79CWHMcxx11nSDBnz+hvg
         yRuA==
X-Gm-Message-State: APjAAAUx+fnad94a16GSYdZR7ZooycATYGbfX3RuKmWAFVi20EY8fDhh
        JX3Jx69QUS3zipPR0Xwn/mY=
X-Google-Smtp-Source: APXvYqyjHi8TouKQGRdHZNa2onE0WeuSATcGJPttrwA8s5sGGN/9Wn1Fx6pfhU+FihWVsFBgTzsyHg==
X-Received: by 2002:a17:902:be0e:: with SMTP id r14mr31362163pls.152.1557993652408;
        Thu, 16 May 2019 01:00:52 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id p7sm2051471pgb.92.2019.05.16.01.00.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 01:00:51 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, boqun.feng@gmail.com, paulmck@linux.ibm.com,
        linux-kernel@vger.kernel.org, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v2 08/17] locking/lockdep: Introduce chain_hlocks_type for held lock's read-write type
Date:   Thu, 16 May 2019 16:00:06 +0800
Message-Id: <20190516080015.16033-9-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190516080015.16033-1-duyuyang@gmail.com>
References: <20190516080015.16033-1-duyuyang@gmail.com>
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
 kernel/locking/lockdep.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 617c0f4..f11d018d 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -861,6 +861,7 @@ static bool class_lock_list_valid(struct lock_class *c, struct list_head *h)
 
 #ifdef CONFIG_PROVE_LOCKING
 static u16 chain_hlocks[MAX_LOCKDEP_CHAIN_HLOCKS];
+static u16 chain_hlocks_type[MAX_LOCKDEP_CHAIN_HLOCKS];
 #endif
 
 static bool check_lock_chain_key(struct lock_chain *chain)
@@ -2668,6 +2669,7 @@ static inline void inc_chains(void)
 static DECLARE_BITMAP(lock_chains_in_use, MAX_LOCKDEP_CHAINS);
 int nr_chain_hlocks;
 static u16 chain_hlocks[MAX_LOCKDEP_CHAIN_HLOCKS];
+static u16 chain_hlocks_type[MAX_LOCKDEP_CHAIN_HLOCKS];
 
 struct lock_class *lock_chain_get_class(struct lock_chain *chain, int i)
 {
@@ -2872,9 +2874,12 @@ static inline int add_chain_cache(struct task_struct *curr,
 		chain->base = nr_chain_hlocks;
 		for (j = 0; j < chain->depth - 1; j++, i++) {
 			int lock_id = curr->held_locks[i].class_idx;
+			int lock_type = curr->held_locks[i].read;
 			chain_hlocks[chain->base + j] = lock_id;
+			chain_hlocks_type[chain->base + j] = lock_type;
 		}
 		chain_hlocks[chain->base + j] = class - lock_classes;
+		chain_hlocks_type[chain->base + j] = hlock->read;
 		nr_chain_hlocks += chain->depth;
 	} else {
 		if (!debug_locks_off_graph_unlock())
@@ -4824,6 +4829,9 @@ static void remove_class_from_lock_chain(struct pending_free *pf,
 			memmove(&chain_hlocks[i], &chain_hlocks[i + 1],
 				(chain->base + chain->depth - i) *
 				sizeof(chain_hlocks[0]));
+			memmove(&chain_hlocks_type[i], &chain_hlocks_type[i + 1],
+				(chain->base + chain->depth - i) *
+				sizeof(chain_hlocks_type[0]));
 		}
 		/*
 		 * Each lock class occurs at most once in a lock chain so once
@@ -5268,6 +5276,7 @@ void __init lockdep_init(void)
 		+ sizeof(lock_chains)
 		+ sizeof(lock_chains_in_use)
 		+ sizeof(chain_hlocks)
+		+ sizeof(chain_hlocks_type)
 #endif
 		) / 1024
 		);
-- 
1.8.3.1

