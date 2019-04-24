Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4654CC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1667621773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:21:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X9uHG703"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729805AbfDXKVe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 06:21:34 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44826 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729754AbfDXKVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 06:21:33 -0400
Received: by mail-pg1-f195.google.com with SMTP id z16so4550108pgv.11
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 03:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WVAxY5VbLxYG0IudT65LG8a11PjQGzGlAMRnmDJ0WLY=;
        b=X9uHG703Zy5DHf5VSE2SKoFNX+ZaOgXHc2sTAOB4sGrHJr/jREGgmmqUR9nAgLShxp
         PezHdrJWpSnWNJfTj+Pg5oLf3MdWvY4iq+LzUR441/IXekx43+XD/S6Cd8V7KD3IVO9p
         uSL6Kv7fJU+Y5QWxBe6yCPrtEuKXR99tztGYyVNaj6897H/ZzyUF53h8FjWCYcBfKPQH
         KNudWoiZOiImjVTt8jp6uxmjYj1rB8tRJAm1vD0yt76zXvwOy87ryGhA3jxTq406ll4o
         SFapbRFdjh0E3EMFd7eyWDS3xnUWs+lQzf5ziotZDNv7sE72SzWwfxqcF4CFP2KVOxq0
         qkkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WVAxY5VbLxYG0IudT65LG8a11PjQGzGlAMRnmDJ0WLY=;
        b=qNbQez+yptUUE6FDwa8edMjhtYk0uRCYcPXSrfNj4zVifBxzEywhQPrgpj12taJJqJ
         Cc4obMnYMvNPQ+GPcnYlLJtChcHyB1YNgmRpWBhSGyfDGJNrGlxnkp2qzKk+S5mfv334
         wjWyrRzRjuDbUYrKWVbJtxVXPZ2zI3fQPmAE+xXYtOaycb7BCOwp0+9P4w04DqTCBcjA
         2p+Ix1al96RYQLn//dkmjH3wrBDDUca1Dx0/gajUWhX6oz+B/Rb2jA8LgtzfK6LuM2w/
         ZLEPGO5erq9ay8YgFh0dMGgo8+vvq0LNkDVULiMjE/8cdZbULkUvBTUbJu+Ll18G+gJf
         MK/Q==
X-Gm-Message-State: APjAAAXzVL+N0B4T041dM7ZR6qie0XAtyLydi5PgNe4is894KFMNiqwM
        oSqIr0jrqbMUoDTdzSC9Ag4=
X-Google-Smtp-Source: APXvYqzyRRWINep0pXvbXu8a0AjrPHZQlGOSfsb8cNOPSNw2QS5kD0/cOgvFCeH5Mxqr0bqA3HtUkQ==
X-Received: by 2002:a62:b61a:: with SMTP id j26mr31774649pff.203.1556101292574;
        Wed, 24 Apr 2019 03:21:32 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id v19sm25051604pfn.62.2019.04.24.03.21.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 03:21:32 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH 21/28] locking/lockdep: Consolidate lock usage bit initialization
Date:   Wed, 24 Apr 2019 18:19:27 +0800
Message-Id: <20190424101934.51535-22-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190424101934.51535-1-duyuyang@gmail.com>
References: <20190424101934.51535-1-duyuyang@gmail.com>
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
index 4d42124..c08ec88 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -3354,8 +3354,12 @@ void trace_softirqs_off(unsigned long ip)
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
@@ -3399,6 +3403,11 @@ static int mark_irqflags(struct task_struct *curr, struct held_lock *hlock)
 		}
 	}
 
+lock_used:
+	/* mark it as used: */
+	if (!mark_lock(curr, hlock, LOCK_USED))
+		return 0;
+
 	return 1;
 }
 
@@ -3440,8 +3449,8 @@ int mark_lock_irq(struct task_struct *curr, struct held_lock *this,
 	return 1;
 }
 
-static inline int mark_irqflags(struct task_struct *curr,
-		struct held_lock *hlock)
+static inline int
+mark_usage(struct task_struct *curr, struct held_lock *hlock, int check)
 {
 	return 1;
 }
@@ -3727,11 +3736,8 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
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

