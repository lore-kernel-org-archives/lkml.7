Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72FB1C43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 12:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43A182146E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 12:29:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bq5cZhWK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729251AbfFKM32 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 08:29:28 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44984 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729050AbfFKM3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 08:29:25 -0400
Received: by mail-lf1-f66.google.com with SMTP id r15so9150838lfm.11
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 05:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7hMEiwXd0I+l76poKlKBlYMOg9hV5tc90xEAOH8Qg4A=;
        b=Bq5cZhWK3NhjjFgVpZXKHOhN3Pt5hIisyG+AXacZhzt+7u5/hIc3q/u+CU2HPkm8z6
         Tirujw8OBR3qtu+5gweLUBNk1/Ru0B1D6XZLVWsjZiQgNW1UpjnruGDHIsS3+q67BBMc
         6oGwgINu3ltnroF7jFY7LOEk/RkmNPMxQGM95EKwOXvSYIj/lqTy6rqvPppun7nnd9UZ
         MUqC4ld6G+PltinWkQW1I7zIOA/3pRnAMENnf9tA/WmPT03PEz/xEBmlvaZJJBDZBrQR
         PSX7yUvURRApV1dtJFVhpa7Q6NCyqN6ykRXkPmhhl7azkMi2e08nYmm59S02IR6QNzB6
         dWOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7hMEiwXd0I+l76poKlKBlYMOg9hV5tc90xEAOH8Qg4A=;
        b=HmBLsJikRf/AQvys2kJR/eHvct1C+pNT+8s100dO506UuAoGYJoabz/l2HrI8uYcPE
         835DhRyLDoO0NLNhcOMfofa4XIg7BJTJD8i+Qo5qL4SwPGHr79Wtq2E63Yfg0Y0P0uNd
         kZkeb5oIAw8jLenQunBkhZo6hmChMSOV4s3lYBQe2CnIhcnOdSro41CzGFc/ss4YdgqO
         8fpCb3We8KcUIpAO4X3vE9wJYXxfqwu0Gk1RcCzkOi/Cw5Hfr0L7oFSjXV+88DyYl7t9
         wZTmF69US7rpT6d4atpZC+wOMUzuj3ucLXN4bhOGYTs3zB/BvX/Y4twyYT8b5EFGNf3v
         3log==
X-Gm-Message-State: APjAAAWMkvHr90crh8peCQvEHo7nm8dwthNVa0+VvFXmPw3tcmZ3DeQs
        GjMe6H6f0XePCMxE4Ko6Ye4=
X-Google-Smtp-Source: APXvYqwbNZHa2HJHF++370RhqSB8dOKgg0B6wzcPO6aNMhZzGnFRk0GI4NpVZC3HMeLuJNv2Vb5pYQ==
X-Received: by 2002:ac2:44a4:: with SMTP id c4mr37165570lfm.116.1560256163486;
        Tue, 11 Jun 2019 05:29:23 -0700 (PDT)
Received: from localhost.localdomain ([178.127.187.52])
        by smtp.gmail.com with ESMTPSA id 25sm2520719ljo.38.2019.06.11.05.29.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 11 Jun 2019 05:29:22 -0700 (PDT)
From:   "Pavel Begunkov (Silence)" <asml.silence@gmail.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH 1/1] sched: Deduplicate code with do-while
Date:   Tue, 11 Jun 2019 15:29:07 +0300
Message-Id: <43ffea6ee2152b90dedf962eac851609e4197218.1560256112.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavel Begunkov <asml.silence@gmail.com>

Statements in the loop's body and before it are identical.
Use do-while to not repeat it.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 kernel/sched/wait.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/wait.c b/kernel/sched/wait.c
index fa0f9adfb752..c1e566a114ca 100644
--- a/kernel/sched/wait.c
+++ b/kernel/sched/wait.c
@@ -118,16 +118,12 @@ static void __wake_up_common_lock(struct wait_queue_head *wq_head, unsigned int
 	bookmark.func = NULL;
 	INIT_LIST_HEAD(&bookmark.entry);
 
-	spin_lock_irqsave(&wq_head->lock, flags);
-	nr_exclusive = __wake_up_common(wq_head, mode, nr_exclusive, wake_flags, key, &bookmark);
-	spin_unlock_irqrestore(&wq_head->lock, flags);
-
-	while (bookmark.flags & WQ_FLAG_BOOKMARK) {
+	do {
 		spin_lock_irqsave(&wq_head->lock, flags);
 		nr_exclusive = __wake_up_common(wq_head, mode, nr_exclusive,
 						wake_flags, key, &bookmark);
 		spin_unlock_irqrestore(&wq_head->lock, flags);
-	}
+	} while (bookmark.flags & WQ_FLAG_BOOKMARK);
 }
 
 /**
-- 
2.22.0

