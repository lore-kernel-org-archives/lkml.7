Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF9FC47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 11:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34860214E0
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 11:20:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=colorfullife-com.20150623.gappssmtp.com header.i=@colorfullife-com.20150623.gappssmtp.com header.b="0QpWmJT3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbfJKLUU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 07:20:20 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54357 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727226AbfJKLUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 07:20:19 -0400
Received: by mail-wm1-f67.google.com with SMTP id p7so10022189wmp.4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 04:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fPvm5aKUo3m6VNUgMDaYDplQQ9+Y7qvr7iXnVapNqxw=;
        b=0QpWmJT3DMoGSvj9aESlR0hwdw5Ii86mJL9w/2qZ8Gp/B0PfF59v1jfPslInshWm+c
         +eF0+aK+OK7KiQIimaFgI5ZkvO/PK5agOuk2isVINYlpfgFD3SdOhUqG9UemAQGn9mj0
         lJE6aDaOMTCyp+1k6FndB/evKKVh2Kyfv/7IgL7tw3ya+UlmIRQeruFrQ6p1CYFWldoQ
         op2v4O6trr+9rhU8tQyMPeWQSkTa1MIBOpDCMuF6AFr2gNRlsle7Cf5R1Fvjpl2HvjZH
         sV7X/fZHfcHXw0uddKP/3F8eVg18qfx0d+GcO4nuvzFEWoFJph2YK0Yiay3CXMruaxz9
         /EVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fPvm5aKUo3m6VNUgMDaYDplQQ9+Y7qvr7iXnVapNqxw=;
        b=HhLat8gbHqiY1GxzpG7EqsU9O7Uboyavo6ipUyuqdscVRr6HuajUUg49pLls/Ok9Sn
         P6YYoPlSxrXCGoAs9WABDVpA4eVZsu4rux1EPZQf3GdoBgT/CBUSq2B7EFDSzmjGKQln
         vu15Fkd0H76v61Gv5EOKNWREEOhDZBjcdVZR57DMvaOGJYIsBodQ69hOJwPFCO3z/ym+
         C2ebHtq3w1/Xxvu+dRs631XSaNBiqWJvBhsnxSivpjXuxZmFaiiw39XC4eE/TY+u5xeL
         fznqCTkgfTgUin3yi1W7+lT+4ou5LwUauZ5wXuY18ThPSLOIBNSEZyjCIOb9hZPVxwjP
         Mt0Q==
X-Gm-Message-State: APjAAAVe0PCys9Exa7alilQQ1ft+UtKD9h51eT26R4Yf3ZP7MHKyboy3
        vbOQLk1ZQ685XVIxSVn2YcpWIPPe81c=
X-Google-Smtp-Source: APXvYqw5V0EY8E7i0OWKHDkL0CgWxMqJOgMhRYPICBdFfcmyVxuHTqUldeOUDQDtEzQ7YXPavSkekQ==
X-Received: by 2002:a05:600c:34b:: with SMTP id u11mr2725338wmd.172.1570792817334;
        Fri, 11 Oct 2019 04:20:17 -0700 (PDT)
Received: from linux.fritz.box (p200300D99705BE00E22045ECB41D901D.dip0.t-ipconnect.de. [2003:d9:9705:be00:e220:45ec:b41d:901d])
        by smtp.googlemail.com with ESMTPSA id 63sm12781226wri.25.2019.10.11.04.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 04:20:16 -0700 (PDT)
From:   Manfred Spraul <manfred@colorfullife.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Waiman Long <longman@redhat.com>
Cc:     1vier1@web.de, Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Manfred Spraul <manfred@colorfullife.com>
Subject: [PATCH 1/5] wake_q: Cleanup + Documentation update.
Date:   Fri, 11 Oct 2019 13:20:05 +0200
Message-Id: <20191011112009.2365-2-manfred@colorfullife.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191011112009.2365-1-manfred@colorfullife.com>
References: <20191011112009.2365-1-manfred@colorfullife.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1) wake_q_add() contains a memory barrier, and callers such as
ipc/mqueue.c rely on this barrier.
Unfortunately, this is documented in ipc/mqueue.c, and not in the
description of wake_q_add().
Therefore: Update the documentation.
Removing/updating ipc/mqueue.c will happen with the next patch in the
series.

2) wake_up_q() relies on the memory barrier in try_to_wake_up().
Add a comment, to simplify searching.

3) wake_q.next is accessed without synchroniyation by wake_q_add(),
using cmpxchg_relaxed(), and by wake_up_q().
Therefore: Use WRITE_ONCE in wake_up_q(), to ensure that the
compiler doesn't perform any tricks.

Signed-off-by: Manfred Spraul <manfred@colorfullife.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
---
 kernel/sched/core.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index dd05a378631a..2cf3f7321303 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -440,8 +440,11 @@ static bool __wake_q_add(struct wake_q_head *head, struct task_struct *task)
  * @task: the task to queue for 'later' wakeup
  *
  * Queue a task for later wakeup, most likely by the wake_up_q() call in the
- * same context, _HOWEVER_ this is not guaranteed, the wakeup can come
- * instantly.
+ * same context, _HOWEVER_ this is not guaranteed. Especially, the wakeup
+ * may happen before the function returns.
+ *
+ * What is guaranteed is that there is a memory barrier before the wakeup,
+ * callers may rely on this barrier.
  *
  * This function must be used as-if it were wake_up_process(); IOW the task
  * must be ready to be woken at this location.
@@ -486,11 +489,14 @@ void wake_up_q(struct wake_q_head *head)
 		BUG_ON(!task);
 		/* Task can safely be re-inserted now: */
 		node = node->next;
-		task->wake_q.next = NULL;
+
+		WRITE_ONCE(task->wake_q.next, NULL);
 
 		/*
 		 * wake_up_process() executes a full barrier, which pairs with
 		 * the queueing in wake_q_add() so as not to miss wakeups.
+		 * The barrier is the smp_mb__after_spinlock() in
+		 * try_to_wake_up().
 		 */
 		wake_up_process(task);
 		put_task_struct(task);
-- 
2.21.0

