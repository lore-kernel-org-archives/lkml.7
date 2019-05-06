Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65DC2C04AAA
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 08:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37EF32087F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 08:21:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iHbi3M+S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbfEFIUe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 04:20:34 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36930 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbfEFIUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 04:20:31 -0400
Received: by mail-pf1-f194.google.com with SMTP id g3so6351989pfi.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 01:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GkLxZzZEQh49peXTRh6HCXNZed/gc67U4FdgzKOiRaM=;
        b=iHbi3M+SN+CQ3EknQi4HBfan0m8/ckTiOHCCrTFgLS8Lk1v4r9DdCKabDsVxyLfmzP
         gjaOlg3DEmIvRHrI6riDUQhGdx0DJ6sgOG6He7nY6Mbw8qG51XPuOI8G6ERdJBej/nbO
         ibyHDhyY/ufghTKNT7wM8jPeTxhnhkQPveZKXc5+as4HO+z8ixIQUsN1DDRMWiLs0JHr
         450cWoqu9jSh7YUqViRu1ZGw7Rc4R2TXyTwUu/uqKvrH5pyWtCx00wcvkzphXzFT5iCY
         KKk+mFjS2TvFgI8oEPWV97yz2N/ur1wRNcVMEdbqZ2Se9xifbfP3v8hNz6zX8RCsS0mk
         bc9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GkLxZzZEQh49peXTRh6HCXNZed/gc67U4FdgzKOiRaM=;
        b=p0lbP+/5JmU4gM+iopkb7z+41PC1mvQRw9476/NBZwkpUEEcfc2mL7ny+NWKia1BBN
         3snzSSmlX3mV5LIoD4HB1BLHmeatVxaKmzBnFuaC9rb9GQHRwDUzb/igOSwI2BT3rPZ9
         B+4QV4U6pLBTir5/ObIdJe8nmv2/8lp5wkIWtPiZM5t5VWBYqSl26tl1JBcVohYSH447
         KgZQGxu2/25B1zH3jY3pWFAyfU3MhCkiwafZ/SHnDj1WH2/g3DJurKi3uoNy5IeW45hc
         OmdF/6G+XEkXd6IWKhE8YnBTtAkoYaacXXui59bGqf6cxHcMlf+3Cqa9fo1QrNTIkGJ+
         Dg1Q==
X-Gm-Message-State: APjAAAUt8smc+tPZmSZgn6yA/6KyQ1Y0svPeQJqSd/3An5sObeSKj9jH
        C5jY0z32ir8T2cptKM8Ya9o=
X-Google-Smtp-Source: APXvYqz6+B3v8x1Q54Bsrb3b9Ac7paHi+csFarKA7l4GCoZqNneTp8eik7Ky87ZkchBcAu/CidHTUQ==
X-Received: by 2002:a62:f247:: with SMTP id y7mr31398096pfl.18.1557130830765;
        Mon, 06 May 2019 01:20:30 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id v19sm20958013pfa.138.2019.05.06.01.20.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 01:20:30 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v2 13/23] locking/lockdep: Change the return type of __cq_dequeue()
Date:   Mon,  6 May 2019 16:19:29 +0800
Message-Id: <20190506081939.74287-14-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190506081939.74287-1-duyuyang@gmail.com>
References: <20190506081939.74287-1-duyuyang@gmail.com>
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
index eb8b190..5a0c908f 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1303,14 +1303,21 @@ static inline int __cq_enqueue(struct circular_queue *cq, struct lock_list *elem
 	return 0;
 }
 
-static inline int __cq_dequeue(struct circular_queue *cq, struct lock_list **elem)
+/*
+ * Dequeue an element from the circular_queue, return a lock_list if
+ * the queue is not empty, or NULL if otherwise.
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
@@ -1362,6 +1369,7 @@ static int __bfs(struct lock_list *source_entry,
 		 int forward)
 {
 	struct lock_list *entry;
+	struct lock_list *lock;
 	struct list_head *head;
 	struct circular_queue *cq = &lock_cq;
 	int ret = 1;
@@ -1383,10 +1391,7 @@ static int __bfs(struct lock_list *source_entry,
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

