Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86011C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:21:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53CA02175B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:21:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U+Jrb3yE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729531AbfDXKVL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 06:21:11 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38312 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729174AbfDXKVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 06:21:08 -0400
Received: by mail-pl1-f196.google.com with SMTP id f36so9059849plb.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 03:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rhJZpnLOBOQ02N5rKilhuEzxJdUJm5UkAKEws5ZBLPc=;
        b=U+Jrb3yE8AQ5/gNnyaAAOPNj2fFpvgy5rkxz9PBLoOEhe6L2YP0rrca2vQ3SCyjhYI
         EGLgfG4c7lZIpeuulxu7MJAQRM2wOZJTvDqveZPsPYarIPXIOzgOhHX33f8ErGGzAesL
         pl/9sctMGLkt3klHNINT0ywG44Cw8D7/63jcRJkdMEW5+nvDx5JKLsO4JvPdPJ9OsgxI
         y8y0mpByp+EsWLEpTPg3in51Rx8bGAGmPnGgE5OFDeZbfTYFIDsoE68rzc7HMObT1xwS
         u2Y34yEwWuFkEFmxwByodtorNOFs89yAuwTF92iwISk4Mb6Osmku7f9TjJ0Hd4hrjPQH
         3HQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rhJZpnLOBOQ02N5rKilhuEzxJdUJm5UkAKEws5ZBLPc=;
        b=nAAEQMEUhnmJtSHpJt3Cfvum8pEy0a684es+YRtZBwvImaIMyzu9kz3OhapTrD3AwP
         C22BB+w9nvH0S8pZk2irgdO/Vk3uTr1ETqQ1qjd3mfxdw7DcKJzhZ/d0wWgttac7kd7Y
         L1y0i6EL0ULEDV2Gy8pGXv3qNbPdpoWsjzDE3GQB4spZxOwbCuC0oeEaeeA8/tx1bf2B
         csphH7iNCxY5A/pYetV+3gBkwtmmmwwc8cXxs9ERFXkcDL71BEJ6ahT5DXQk9eicc3Kf
         6HanHmvdfuFdIjk5szE3cjpXWY84MoeQ3SeX0WUL6VXtbstC+aeFjBf13f83kSFYSuDM
         g4bw==
X-Gm-Message-State: APjAAAUI+y9iVdr93wH86v+78Le2TLAiqunxq1eKydTcHtOwWgW2cNIc
        xAzd0dGZLOTO7aGauQfpUKQ=
X-Google-Smtp-Source: APXvYqwleibgcTxx8Hfk54E6G/H/37u8T5gMGNb7b6ejSR6E0F7vOcnOEUmTkOQVzC+5EIFTEgd+vQ==
X-Received: by 2002:a17:902:e08a:: with SMTP id cb10mr2172407plb.160.1556101267647;
        Wed, 24 Apr 2019 03:21:07 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id v19sm25051604pfn.62.2019.04.24.03.21.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 03:21:07 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH 13/28] locking/lockdep: Change the return type of __cq_dequeue()
Date:   Wed, 24 Apr 2019 18:19:19 +0800
Message-Id: <20190424101934.51535-14-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190424101934.51535-1-duyuyang@gmail.com>
References: <20190424101934.51535-1-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the change, we can slightly adjust the code to iterate the queue in BFS
search, which simplifies the code. No functional change.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 kernel/locking/lockdep.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 683aaf60..225eeeb 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1302,14 +1302,21 @@ static inline int __cq_enqueue(struct circular_queue *cq, struct lock_list *elem
 	return 0;
 }
 
-static inline int __cq_dequeue(struct circular_queue *cq, struct lock_list **elem)
+/*
+ * Dequeue an element from the circular_queue, return the lock if the queue
+ * is not empty, or NULL if otherwise
+ */
+static inline struct lock_list * __cq_dequeue(struct circular_queue *cq)
 {
+	struct lock_list * lock;
+
 	if (__cq_empty(cq))
-		return -1;
+		return NULL;
 
-	*elem = cq->element[cq->front];
+	lock = cq->element[cq->front];
 	cq->front = (cq->front + 1) & CQ_MASK;
-	return 0;
+
+	return lock;
 }
 
 static inline unsigned int  __cq_get_elem_count(struct circular_queue *cq)
@@ -1361,6 +1368,7 @@ static int __bfs(struct lock_list *source_entry,
 		 int forward)
 {
 	struct lock_list *entry;
+	struct lock_list *lock;
 	struct list_head *head;
 	struct circular_queue *cq = &lock_cq;
 	int ret = 1;
@@ -1382,10 +1390,7 @@ static int __bfs(struct lock_list *source_entry,
 	__cq_init(cq);
 	__cq_enqueue(cq, source_entry);
 
-	while (!__cq_empty(cq)) {
-		struct lock_list *lock;
-
-		__cq_dequeue(cq, &lock);
+	while ((lock = __cq_dequeue(cq))) {
 
 		if (!lock->class) {
 			ret = -2;
-- 
1.8.3.1

