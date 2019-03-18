Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED42C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 08:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 142942082F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 08:57:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r1wle0+3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbfCRI5w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 04:57:52 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33981 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbfCRI5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 04:57:49 -0400
Received: by mail-pg1-f193.google.com with SMTP id v12so10955325pgq.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 01:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LKae2yJqXHMc22mwuhI+bIHxTHfgmDQs6kkCV1HxHEU=;
        b=r1wle0+3N0/veASaRVmv4ciCjgGLnFDE+Jb5XYpAoC/CIVeYfMgBewoAY20vl7uBkj
         1vD9N5crd9P3ZqO525GBQHYDQLsuDQySG/1+X8DZrlkIh+r78GvhYIgLR31KZZSb/R2t
         QmqKRmIrOht0CabVkEednmrghlmPUrhrZKSBdt/IYCyz1JWL4r9n5wHuzETG5VZTbxZC
         mszCQaqWoGHESz51lDyC15nm5E+8NIjGZQRS1w1YP9qYrwW17KBmTa9X0Qb3/S3BOZ4L
         YXGZllhpxNM62ECVMWG0IgRQ1iQj497+j+mPbRGsM1bwsqSG6dogaBls3O+kkKt4wfmP
         xVHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LKae2yJqXHMc22mwuhI+bIHxTHfgmDQs6kkCV1HxHEU=;
        b=JdtIEpWOF2EUpsQeGuXJecMR5TJ1zaurai7e2wRdMM8Kzp6EFhFsklyVD6UZKTpqBL
         a9dsayYD1oU2KXkhGzGjmveKetLgOfs4KUz5ul8QH8gMilVFYI9zPg2fjY2o5FbDN+Pw
         T/gUaw75P9jZjaPUzlZe6rP26K1C9Y9rIxIwjyUP41TR9Z9j3IY1x6k+Eb5jOvwp84jT
         71AX+H3skYOwZqQn+7O9SoN/SaRM/XCJdtD9YYvqMu1MzHEPHbCYcQyQs8kIBnUtLbkN
         VuFCio51Tx9I+i+6K4bk8qnDtGDI8xMD7dFTw/CYYTRmBrqBfKtMfjxzyLHgwHlNZ+p+
         SjSg==
X-Gm-Message-State: APjAAAXMQD4SByHm2vJI7/CcU7iuwWVwquC4qjXn5Fn+MRnw/AM3GwmJ
        V8L1FP5GVbhHtje+CfILyA0=
X-Google-Smtp-Source: APXvYqxU5pzQSllNvOP+w5GYLoJ6/T7e2Hi7WGd+oXGlOFe3FALk6FAHhEWsBtBgd+P9BStVfgwiYQ==
X-Received: by 2002:a17:902:e5:: with SMTP id a92mr18418375pla.326.1552899469319;
        Mon, 18 Mar 2019 01:57:49 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id k8sm11147024pgq.37.2019.03.18.01.57.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 01:57:48 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com,
        linux-kernel@vger.kernel.org, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v2 02/19] locking/lockdep: Add description and explanation in lockdep design doc
Date:   Mon, 18 Mar 2019 16:57:16 +0800
Message-Id: <20190318085733.3143-3-duyuyang@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20190318085733.3143-1-duyuyang@gmail.com>
References: <20190318085733.3143-1-duyuyang@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

More words are added to lockdep design document regarding key concepts,
which helps people understand the design as well as read the reports.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 Documentation/locking/lockdep-design.txt | 89 +++++++++++++++++++++++---------
 1 file changed, 64 insertions(+), 25 deletions(-)

diff --git a/Documentation/locking/lockdep-design.txt b/Documentation/locking/lockdep-design.txt
index 49f58a0..621d8f4 100644
--- a/Documentation/locking/lockdep-design.txt
+++ b/Documentation/locking/lockdep-design.txt
@@ -10,56 +10,95 @@ Lock-class
 The basic object the validator operates upon is a 'class' of locks.
 
 A class of locks is a group of locks that are logically the same with
-respect to locking rules, even if the locks may have multiple (possibly
-tens of thousands of) instantiations. For example a lock in the inode
-struct is one class, while each inode has its own instantiation of that
-lock class.
-
-The validator tracks the 'state' of lock-classes, and it tracks
-dependencies between different lock-classes. The validator maintains a
-rolling proof that the state and the dependencies are correct.
-
-Unlike an lock instantiation, the lock-class itself never goes away: when
-a lock-class is used for the first time after bootup it gets registered,
-and all subsequent uses of that lock-class will be attached to this
-lock-class.
+respect to locking rules, even if the locks may have multiple (possibly tens
+of thousands of) instantiations. For example a lock in the inode struct is
+one class, while each inode has its own instantiation of that lock class.
+
+The validator tracks the 'usage state' of lock-classes, and it tracks the
+dependencies between different lock-classes. The dependency can be
+understood as lock order, where L1 -> L2 suggests L1 depends on L2, which
+can also be expressed as a forward dependency (L1 -> L2) or a backward
+dependency (L2 <- L1). From lockdep's perspective, the two locks (L1 and L2)
+are not necessarily related as opposed to in some modules an order must be
+followed. Here it just means that order ever happened. The validator
+maintains a continuing effort to prove that the lock usages and their
+dependencies are correct or the validator will shoot a splat if they are
+potentially incorrect.
+
+Unlike a lock instance, a lock-class itself never goes away: when a
+lock-class's instance is used for the first time after bootup the class gets
+registered, and all (subsequent) instances of that lock-class will be mapped
+to the lock-class.
 
 State
 -----
 
-The validator tracks lock-class usage history into 4 * nSTATEs + 1 separate
-state bits:
+The validator tracks lock-class usage history and divides the usage into
+(4 usages * n STATEs + 1) categories:
 
+Where the 4 usages can be:
 - 'ever held in STATE context'
 - 'ever held as readlock in STATE context'
 - 'ever held with STATE enabled'
 - 'ever held as readlock with STATE enabled'
 
-Where STATE can be either one of (kernel/locking/lockdep_states.h)
- - hardirq
- - softirq
+Where the n STATEs are coded in kernel/locking/lockdep_states.h and as of
+now they include:
+- hardirq
+- softirq
 
+Where the last 1 category is:
 - 'ever used'                                       [ == !unused        ]
 
-When locking rules are violated, these state bits are presented in the
-locking error messages, inside curlies. A contrived example:
+When locking rules are violated, these usage bits are presented in the
+locking error messages, inside curlies, with a total of 2 * n STATEs bits.
+See a contrived example:
 
    modprobe/2287 is trying to acquire lock:
-    (&sio_locks[i].lock){-.-...}, at: [<c02867fd>] mutex_lock+0x21/0x24
+    (&sio_locks[i].lock){-.-.}, at: [<c02867fd>] mutex_lock+0x21/0x24
 
    but task is already holding lock:
-    (&sio_locks[i].lock){-.-...}, at: [<c02867fd>] mutex_lock+0x21/0x24
+    (&sio_locks[i].lock){-.-.}, at: [<c02867fd>] mutex_lock+0x21/0x24
 
 
-The bit position indicates STATE, STATE-read, for each of the states listed
-above, and the character displayed in each indicates:
+For a given lock, the bit positions from left to right indicate the usage
+of the lock and readlock (if exists), for each of the n STATEs listed
+above respectively, and the character displayed at each bit position
+indicates:
 
    '.'  acquired while irqs disabled and not in irq context
    '-'  acquired in irq context
    '+'  acquired with irqs enabled
    '?'  acquired in irq context with irqs enabled.
 
-Unused mutexes cannot be part of the cause of an error.
+The bits are illustrated with an example:
+
+    (&sio_locks[i].lock){-.-.}, at: [<c02867fd>] mutex_lock+0x21/0x24
+                         ||||
+                         ||| \-> softirq disabled and not in softirq context
+                         || \--> acquired in softirq context
+                         | \---> hardirq disabled and not in hardirq context
+                          \----> acquired in hardirq context
+
+
+For a given STATE, whether the lock is ever acquired in that STATE context
+and whether that STATE is enabled yields four possible cases as shown in the
+table below. It is worth noting that the bit character is able to indicate
+which exact case is for the lock as of the reporting time.
+
+   -------------------------------------------------
+  |              | enabled in irq | disabled in irq |
+   -------------------------------------------------
+  | ever in irq  |        ?       |        -        |
+   -------------------------------------------------
+  | never in irq |        +       |        .        |
+   -------------------------------------------------
+
+The character '-' suggests irq is disabled because if otherwise, the
+charactor '?' would have been shown instead. Similar deduction can be
+applied for '+' too.
+
+Unused locks (e.g., mutexes) cannot be part of the cause of an error.
 
 
 Single-lock state rules:
-- 
1.8.3.1

