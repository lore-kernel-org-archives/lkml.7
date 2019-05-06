Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1549C04AAA
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 08:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8535D2082F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 08:21:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oKpHRgXa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbfEFIU7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 04:20:59 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40068 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbfEFIU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 04:20:56 -0400
Received: by mail-pg1-f196.google.com with SMTP id d31so6091803pgl.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 01:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t70GCGACIUWewKKDD5qrnEovI01jL9vwBiMVTScwpdQ=;
        b=oKpHRgXa47NOgo/vGp8semc/qpulzzzXcb0ttnNg7EYsNlpSoFZWioiUrf26bGC98m
         eUSR7Bf5/qcCkM4+azAcADd6p3WmhznVa+1uMTr4pQuk4DeU0UWxmGBCD/r4+xuveWko
         /HjMWAMZpilSY3qMkE2b6ATMUdO41dCUl6s0Kur5Q/lXHCQo45PuQURtf/7rWwBqz+JO
         8E82e1ZL9hS2Jkg3DeYWpvV1gZV5R59CLlOcxIiu4dSPkcJqfjhmwvVsi9cOFMRHYqNo
         k2XvmnWaii49/JGdhW2ZQEe51yxsdq6IlbcAfmh3ZhJQA/mFDJgr8CVD1iIHOBL40Fmu
         m8xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t70GCGACIUWewKKDD5qrnEovI01jL9vwBiMVTScwpdQ=;
        b=ihKc2BZ5lTaqH2mdCilxBKvnW2FYMI5FUWDvGvTtRsadPzpyM3YuR0UROK+Zho1pM0
         t62dZ8u3Ji+wuukGEPOmJpLGN5uDpyiR0zVwYt7kFckcCPRAfFGFWwkH6RzO9nK6pPNm
         i2LW34n4xs0jxSlf1aWkzn37FmoOGwloZ5SqGPyRSKl2kmE9rDM0ZHTOYX91QP1k9W/d
         ZJCB2VbqoTSSwoeAtrgSxUuKm6V7TyfJKNEnBd5JsaWDHjK8q+DCuI88OxeZ/h+I/tlt
         9aNQ885365tI3WspIUlYJVBqhGf1hvKYcstpNK+QPlpHNNuBxNVwD6FizoNUI1KWcFs7
         EAMg==
X-Gm-Message-State: APjAAAXmTSUfoXb7wT1CLp8u+MwK3hqAo+fv/4LHM3maWz4ZArWoKMfz
        s9+uHjbkHRiSRGP/wbEsD4s=
X-Google-Smtp-Source: APXvYqzp4NzdTux9vAnYxuI9usVUVhWVyeu9wamNRRWSVnNAtFhUUgpZmDuUkFtMSRZHJffkCNjH/Q==
X-Received: by 2002:a63:1604:: with SMTP id w4mr30773662pgl.148.1557130856083;
        Mon, 06 May 2019 01:20:56 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id v19sm20958013pfa.138.2019.05.06.01.20.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 01:20:55 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v2 21/23] locking/lockdep: Consolidate lock usage bit initialization
Date:   Mon,  6 May 2019 16:19:37 +0800
Message-Id: <20190506081939.74287-22-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190506081939.74287-1-duyuyang@gmail.com>
References: <20190506081939.74287-1-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lock usage bit initialization is consolidated into one function
mark_usage(). Trivial readability improvement. No functional change.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 kernel/locking/lockdep.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 9d2728c..79bc6cd 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -3459,8 +3459,12 @@ void trace_softirqs_off(unsigned long ip)
 		debug_atomic_inc(redundant_softirqs_off);
 }
 
-static int mark_irqflags(struct task_struct *curr, struct held_lock *hlock)
+static int
+mark_usage(struct task_struct *curr, struct held_lock *hlock, int check)
 {
+	if (!check)
+		goto lock_used;
+
 	/*
 	 * If non-trylock use in a hardirq or softirq context, then
 	 * mark the lock as used in these contexts:
@@ -3504,6 +3508,11 @@ static int mark_irqflags(struct task_struct *curr, struct held_lock *hlock)
 		}
 	}
 
+lock_used:
+	/* mark it as used: */
+	if (!mark_lock(curr, hlock, LOCK_USED))
+		return 0;
+
 	return 1;
 }
 
@@ -3545,8 +3554,8 @@ int mark_lock_irq(struct task_struct *curr, struct held_lock *this,
 	return 1;
 }
 
-static inline int mark_irqflags(struct task_struct *curr,
-		struct held_lock *hlock)
+static inline int
+mark_usage(struct task_struct *curr, struct held_lock *hlock, int check)
 {
 	return 1;
 }
@@ -3832,11 +3841,8 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 #endif
 	hlock->pin_count = pin_count;
 
-	if (check && !mark_irqflags(curr, hlock))
-		return 0;
-
-	/* mark it as used: */
-	if (!mark_lock(curr, hlock, LOCK_USED))
+	/* Initialize the lock usage bit */
+	if (!mark_usage(curr, hlock, check))
 		return 0;
 
 	/*
-- 
1.8.3.1

