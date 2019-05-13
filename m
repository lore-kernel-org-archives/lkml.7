Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BBD6C04AB1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 09:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 589B020989
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 09:13:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eavWDj0t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728694AbfEMJNn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 05:13:43 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34226 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728669AbfEMJNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 05:13:40 -0400
Received: by mail-pg1-f193.google.com with SMTP id c13so6465893pgt.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 02:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SdiRF7cmY2+TjzGTcChzgzJlbCutxASQzMbp0ZC+13I=;
        b=eavWDj0tkUpwBOJomcDBEsvxr77LpmthAm3l0tEiRxVYetXL3d7CuGVCqPzsujS7eg
         C75jZS83QZwYtmtJMrMRTcmlbyLULKuJ+iehtf8Pp4weDgssbxm67c+3dcc32L1tNt/+
         C2VYQxAFmCAzIueiGAOsdpxz1GII8McQRY8dm5XTUwHhV1uWSt50NAg0IjomIC3S9WmG
         6iNvA1XvHhHvwS+H9v7KfDY3zRVe1BEvQBgQBp+WS2R3a0NxiKNy4Ec+XJx6DpWeybfS
         LuAthLCx/pZBvN9Lrhs/wB1//ujwrLBlic5JPpcixe7iz3M/pdWXQEEVaBYjClMDUDPQ
         3izw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SdiRF7cmY2+TjzGTcChzgzJlbCutxASQzMbp0ZC+13I=;
        b=aFgNRLC20drlCjk7sfzjBpATO6PMAcy645RSfE7elKqp5sWVbjb7Dz4ioQslAG1aqs
         qZRZl7QFBcU5ORHTtCGUD6EQtqG3Mid9LrBaYj7rOtIRuhv3rO7udUzwUYNcbsEma6FF
         5l1wySNfctAGO+6AHFUUJkCchAi2Xi6o4xG+ZhxGZZse+NLlIWh60Tf2s/QtW6dvVCGK
         UIb81QKq7PeprB75+ghdLweMUbqHU6OeeCytwUgcmfM/11DqHeKQKJTb6bSk70um4A2U
         WwmHaILmzkZ65RJCElGnz6WM8AbCPZwen1LvBJX66Mst+pb5uI0bMFeFxR//vym4X164
         2TMQ==
X-Gm-Message-State: APjAAAUSa0HlWobL+RseynyVLYo+nK/e7vlZ4dvs/BhJs/xNVefpFJBo
        7Gwu7NcNCmMSy6qmflY4Wa0=
X-Google-Smtp-Source: APXvYqxMOAyKXOC8AZDyaR9eBcLFEXpgTtCDZhK62zE4wfBweys2zm+z9BYmgltRGYqgA/VXDL40Yw==
X-Received: by 2002:a65:44c8:: with SMTP id g8mr29987962pgs.443.1557738820456;
        Mon, 13 May 2019 02:13:40 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id n18sm35500837pfi.48.2019.05.13.02.13.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 02:13:40 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, boqun.feng@gmail.com,
        linux-kernel@vger.kernel.org, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH 07/17] locking/lockdep: Introduce mark_lock_unaccessed()
Date:   Mon, 13 May 2019 17:11:53 +0800
Message-Id: <20190513091203.7299-8-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190513091203.7299-1-duyuyang@gmail.com>
References: <20190513091203.7299-1-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since in graph search, multiple matches may be needed, a matched lock
needs to rejoin the search for another match, thereby introduce
mark_lock_unaccessed().

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 kernel/locking/lockdep.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 4d96bdd..a2d5148 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1338,6 +1338,15 @@ static inline void mark_lock_accessed(struct lock_list *lock,
 	lock->class->dep_gen_id = lockdep_dependency_gen_id;
 }
 
+static inline void mark_lock_unaccessed(struct lock_list *lock)
+{
+	unsigned long nr;
+
+	nr = lock - list_entries;
+	WARN_ON(nr >= ARRAY_SIZE(list_entries)); /* Out-of-bounds, input fail */
+	lock->class->dep_gen_id--;
+}
+
 static inline unsigned long lock_accessed(struct lock_list *lock)
 {
 	unsigned long nr;
-- 
1.8.3.1

