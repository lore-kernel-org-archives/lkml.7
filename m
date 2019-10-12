Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8ABCC4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 05:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91CC1206A1
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 05:50:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=colorfullife-com.20150623.gappssmtp.com header.i=@colorfullife-com.20150623.gappssmtp.com header.b="BUejGE/Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728718AbfJLFuM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 01:50:12 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36606 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728111AbfJLFuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 01:50:12 -0400
Received: by mail-wm1-f67.google.com with SMTP id m18so11985966wmc.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 22:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hCNAY2B4GBIEKWr43sCTvg0r8VIO3WoulIoqc6vcbII=;
        b=BUejGE/YewtG8QRFa4GDkLjSw/OD4LH50xhdOaOYjdzPaj2XHySFdxP7PZANsQFkAF
         5n2evKkK+65beOfaMT2hsDTt+iHliNx1sKU/7W/dk4dgoQwAolTotPaNW8mbmWLDy3Gz
         BsJjfBOAulLe4nSiKkztTTSy8zb88yHgo07H3B07JE5r1xw1iPt6H8eed2h1my1lxD3D
         86aZZOUqNuHJl5wqARnTSPI+2BB7Ox2C1ahFFpq+34Mn6b/PHcvof9xUDqkWKJVnPuTX
         OcHaQ+IQIY8MECOsa7oOka3eJ0LlRblKJu4cS2vtRzx5nrMC8pGVEQCZhRM6Q/Vk0LyH
         btLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hCNAY2B4GBIEKWr43sCTvg0r8VIO3WoulIoqc6vcbII=;
        b=d6MiQMwEjfDn42dfuQrmIPJhDHcbV6Fl7Ue+Hu1rI0x9VtArFGcj3FQQ9Iu71mOHUt
         MjSb7AjSjWsz+DFMiyecRw4+3cRDsFUMGoHHCUVYiiewf7jX26x3hfaIxnHValx+xQnx
         6owitlPmp8AlZLOHTLCsx9oXSxxN534L9segRQRhAUWR2CBZJAsaPGBaam8JsLa5kf4B
         GDMMdRpTH59pOMttwUnlpE7QnKjXgQm36/yZGk66KLTKqlpffmm6f2XqRWutzEusWbw9
         G6R96paBkLrAI023Zi5W5uP0+xm4WXDN23fTgAHbAF6XU8Fx+ADyUaerfleS16v4DnxB
         MQ5A==
X-Gm-Message-State: APjAAAUEv95gLLcVSmCsWftXY7JNlwZJ196+vnUI8Usp6HZB/hbJ6DWf
        a60BmeYAKQYOjbOekoxCqUMS+9gBjcqB0Q==
X-Google-Smtp-Source: APXvYqxi2Kynkb2oaXxpE++GQrXEfK6e+zY9ektEt4hRBhr/tQgG8ctUb38sakWNbkjyNdDFLgzBtA==
X-Received: by 2002:a05:600c:2549:: with SMTP id e9mr5812884wma.64.1570859409766;
        Fri, 11 Oct 2019 22:50:09 -0700 (PDT)
Received: from linux.fritz.box (p200300D9973AD600F159A589C745B52A.dip0.t-ipconnect.de. [2003:d9:973a:d600:f159:a589:c745:b52a])
        by smtp.googlemail.com with ESMTPSA id z4sm9344955wrh.93.2019.10.11.22.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 22:50:09 -0700 (PDT)
From:   Manfred Spraul <manfred@colorfullife.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Waiman Long <longman@redhat.com>
Cc:     1vier1@web.de, Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Manfred Spraul <manfred@colorfullife.com>
Subject: [PATCH 1/6] wake_q: Cleanup + Documentation update.
Date:   Sat, 12 Oct 2019 07:49:53 +0200
Message-Id: <20191012054958.3624-2-manfred@colorfullife.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191012054958.3624-1-manfred@colorfullife.com>
References: <20191012054958.3624-1-manfred@colorfullife.com>
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

2) wake_q_add() ends with get_task_struct(), which is an
unordered refcount increase. Add a clear comment that the callers
are responsible for a barrier: most likely spin_unlock() or
smp_store_release().

3) wake_up_q() relies on the memory barrier in try_to_wake_up().
Add a comment, to simplify searching.

4) wake_q.next is accessed without synchroniyation by wake_q_add(),
using cmpxchg_relaxed(), and by wake_up_q().
Therefore: Use WRITE_ONCE in wake_up_q(), to ensure that the
compiler doesn't perform any tricks.

Signed-off-by: Manfred Spraul <manfred@colorfullife.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
---
 kernel/sched/core.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index dd05a378631a..60ae574317fd 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -440,8 +440,16 @@ static bool __wake_q_add(struct wake_q_head *head, struct task_struct *task)
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
+ *
+ * On the other hand, the caller must guarantee that @task does not disappear
+ * before wake_q_add() completed. wake_q_add() does not contain any memory
+ * barrier to ensure ordering, thus the caller may need to use
+ * smp_store_release().
  *
  * This function must be used as-if it were wake_up_process(); IOW the task
  * must be ready to be woken at this location.
@@ -486,11 +494,14 @@ void wake_up_q(struct wake_q_head *head)
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

