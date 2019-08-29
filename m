Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB9EC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 08:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B1472341B
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 08:31:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cre7Bo7X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbfH2Ib6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 04:31:58 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42845 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfH2Ib5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 04:31:57 -0400
Received: by mail-pg1-f195.google.com with SMTP id p3so1198493pgb.9
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 01:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TkzTBcVpZa2pxLJ2bxAvVhbFsL+5xrEmIrdNVlXt1l4=;
        b=Cre7Bo7Xvf5hrNK93X8DBQfJEvIiczSsN3uRWMPmYiuRoiblSuUf7noiKiVzznOwgt
         572U0w/IJ/T4Elfptw3oJuFNNN8TH41lgjXIA0IH/PQReW18EMGrgYa+rbPFV3k1BDjO
         CBMQ6dE4pqaNjoM9obeS28iN7Htaizhynp3WRksmPmXhPEw391WqYdbXVlywqDsLDu+k
         7Lncezark+rms+6sIgikgJ7lQowh6OZX6PzCTz2w7Q0HSy2fHRdtIxvbj0Ua3EDFDEaX
         zRCzqDUsUXiA0jgb0D1347DLFDJtW1G2dBNOPIduCiroje8LGTquPq9U+bpX/v11lO+B
         edDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TkzTBcVpZa2pxLJ2bxAvVhbFsL+5xrEmIrdNVlXt1l4=;
        b=kNBs9JyxmsucIJny2Yd14JCCjfSggBlIgr3/T/odZYIMmROJ6EGNw3O4hJr2v6TkyT
         8H9PIOL6zOlEY+ZjkhR+SBZuA6cHSG17HWdezmeeh8/93HZxtrOk2r8bFaZ98+PceZBF
         o5qGYSozUTSvG6Jy22k+JzdT2IWP4Llej9ECXj72DiWo+7hClGeIznrxqL1EmNE9s8MQ
         +ys0dT2PZSPn2YUSJMqMLXzaT7WyEeOYYyCm/C2NY7HZy5VPCvDl51zreU42pN2dCoKD
         1CrqrRHaGG0m2tj1nJudMCBP3fkBLrDiYFJPKdouwYQF49AhKIV1WcaJuZffoEmNaMNp
         9J+g==
X-Gm-Message-State: APjAAAWG0HkUmn7p9zovPtb/lpp3xq32mw3EOrxUWlRBPIx2QMwnlX0J
        RegdGDh976EXTZhkHl8zoIQ=
X-Google-Smtp-Source: APXvYqxLyf5ci6S7sBkl0kVpeDPkLfluUPsXcywgOEjpL6+fPdkvOpPTErw7WsdB1E2f0hAyUzATtg==
X-Received: by 2002:a65:6709:: with SMTP id u9mr7218769pgf.58.1567067517225;
        Thu, 29 Aug 2019 01:31:57 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id v22sm1260155pgk.69.2019.08.29.01.31.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Aug 2019 01:31:56 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        longman@redhat.com, paulmck@linux.vnet.ibm.com,
        boqun.feng@gmail.com, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v4 03/30] locking/lockdep: Change return type of lookup_chain_cache_add()
Date:   Thu, 29 Aug 2019 16:31:05 +0800
Message-Id: <20190829083132.22394-4-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190829083132.22394-1-duyuyang@gmail.com>
References: <20190829083132.22394-1-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like the previous change, the function lookup_chain_cache_add() returns
the pointer of the lock chain if the chain is new.

No functional change.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 kernel/locking/lockdep.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 9c9b408..51918d2 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2870,13 +2870,13 @@ static inline struct lock_chain *lookup_chain_cache(u64 chain_key)
 
 /*
  * If the key is not present yet in dependency chain cache then
- * add it and return 1 - in this case the new dependency chain is
- * validated. If the key is already hashed, return 0.
- * (On return with 1 graph_lock is held.)
+ * add it and return the chain - in this case the new dependency
+ * chain will be validated. If the key is already hashed, return
+ * NULL. (On return with the new chain graph_lock is held.)
  */
-static inline int lookup_chain_cache_add(struct task_struct *curr,
-					 struct held_lock *hlock,
-					 u64 chain_key)
+static inline struct lock_chain *
+lookup_chain_cache_add(struct task_struct *curr, struct held_lock *hlock,
+		       u64 chain_key)
 {
 	struct lock_class *class = hlock_class(hlock);
 	struct lock_chain *chain = lookup_chain_cache(chain_key);
@@ -2884,7 +2884,7 @@ static inline int lookup_chain_cache_add(struct task_struct *curr,
 	if (chain) {
 cache_hit:
 		if (!check_no_collision(curr, hlock, chain))
-			return 0;
+			return NULL;
 
 		if (very_verbose(class)) {
 			printk("\nhash chain already cached, key: "
@@ -2893,7 +2893,7 @@ static inline int lookup_chain_cache_add(struct task_struct *curr,
 					class->key, class->name);
 		}
 
-		return 0;
+		return NULL;
 	}
 
 	if (very_verbose(class)) {
@@ -2902,7 +2902,7 @@ static inline int lookup_chain_cache_add(struct task_struct *curr,
 	}
 
 	if (!graph_lock())
-		return 0;
+		return NULL;
 
 	/*
 	 * We have to walk the chain again locked - to avoid duplicates:
@@ -2913,10 +2913,7 @@ static inline int lookup_chain_cache_add(struct task_struct *curr,
 		goto cache_hit;
 	}
 
-	if (!add_chain_cache(curr, hlock, chain_key))
-		return 0;
-
-	return 1;
+	return add_chain_cache(curr, hlock, chain_key);
 }
 
 static int validate_chain(struct task_struct *curr,
-- 
1.8.3.1

