Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8310C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 07:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 981932146E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 07:58:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oL60oN3u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbfCUH6d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 03:58:33 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40729 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728136AbfCUH62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 03:58:28 -0400
Received: by mail-pg1-f194.google.com with SMTP id u9so3667572pgo.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 00:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XIbdZjziulIdw1G1xQh5CV9nJXeKA4NNKUqZvBV4Tzc=;
        b=oL60oN3uz+b2V2NqIB04X/fzmh1upvUQfRUhcnwlDLpXnp7Y+pH4ZtxP9w4byds0iI
         qHoonXx2McwKp4ZIp8XxonczQD7g4zR91IsC6HEuV8NldVDjPyonT3YoKYNlTb1q8EEI
         BzOTq/xMKbWhE6HcPwAKu0ZamzXBEK0abpQ3EQM/lD9bMLYoLZ0ZiWZXpmdS7ygve/Cb
         gDVGixwqux1sYBD5F+BNCcbp936jx5O9BVkprd2BDfkqw0OSywnuXC4RdmJpRc5zgIQe
         69zft9VdwED3I2PdJIX0lNSjxpDxrjT/lXtzHOt1iylRdhWRTARkG73qy+0ETH4ZDCJI
         DmnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XIbdZjziulIdw1G1xQh5CV9nJXeKA4NNKUqZvBV4Tzc=;
        b=Hnz9iDG8AGuRfUsabh7qz25A97hA9x6+Q0c4S4xK9gV8hN/OcmCHgqmlTBTYdEnnkK
         xmhKTH4hAXbINOJGU/2qcuCsS4qNBHm6nR3rQX78ognsRFde6oa6O2A2qfw06urV6H6j
         UPVe99Q9UhFtWqLF8dWXlbHqAU6b+AjtgUJ5h5YeHJRocYobUHmRaDzXO48lioL+PcFq
         T5WFOs0Qsn5acBhmefk9lNEbEh0J6tR7iYg7OCm3oLmUE88q3poxoRqK6SvTOqnP/PQ4
         kEvXDiGiGbSs0iUqSnhhqOAhCnuSSAzSXeCK5I3H2ksclE5s1W/VsG78xwim8x9et7BH
         VWgQ==
X-Gm-Message-State: APjAAAUbVm65EWk6F9CpMbbSjs3f4W1yyfAhr0q0C9MQsmNOI2tc5a+m
        0R3V5uO0K8OHSfk081JDjyg=
X-Google-Smtp-Source: APXvYqz5PO0fKNNeMfaXDEp1zeUxdTFslrnxLcNXAJOaQRrvF94y6g+4IMwjsQ/ufrE66vG5NYVqWA==
X-Received: by 2002:aa7:85cc:: with SMTP id z12mr2062513pfn.142.1553155107923;
        Thu, 21 Mar 2019 00:58:27 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id e184sm6467148pfc.143.2019.03.21.00.58.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 00:58:27 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com,
        linux-kernel@vger.kernel.org, joe@perches.com,
        Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v3 18/18] locking/lockdep: Add explanation to lock usage rules in lockdep design doc
Date:   Thu, 21 Mar 2019 15:57:25 +0800
Message-Id: <20190321075725.14054-19-duyuyang@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20190321075725.14054-1-duyuyang@gmail.com>
References: <20190321075725.14054-1-duyuyang@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rules that if violated a deacklock may happen are explained in more
detail concerning both irqs and circular dependencies.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 Documentation/locking/lockdep-design.txt | 35 +++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/Documentation/locking/lockdep-design.txt b/Documentation/locking/lockdep-design.txt
index 1dcceaa..83803c6 100644
--- a/Documentation/locking/lockdep-design.txt
+++ b/Documentation/locking/lockdep-design.txt
@@ -105,14 +105,24 @@ Unused locks (e.g., mutexes) cannot be part of the cause of an error.
 Single-lock state rules:
 ------------------------
 
+A lock is irq-safe means it was ever used in an irq context, while a lock
+is irq-unsafe means it was ever acquired with irq enabled.
+
 A softirq-unsafe lock-class is automatically hardirq-unsafe as well. The
-following states are exclusive, and only one of them is allowed to be
-set for any lock-class:
+following states must be exclusive: only one of them is allowed to be set
+for any lock-class based on its usage:
+
+ <hardirq-safe> or <hardirq-unsafe>
+ <softirq-safe> or <softirq-unsafe>
 
- <hardirq-safe> and <hardirq-unsafe>
- <softirq-safe> and <softirq-unsafe>
+This is because if a lock can be used in irq (safe) then it cannot be ever
+acquired with irq enabled (unsafe). Otherwise, a deadlock may happen. For
+example, in the scenario that after this lock was acquired but before
+released, if the context is interrupted this lock will be attempted to
+acquire twice, which creates a deadlock, sometimes referred to as lock
+recursion deadlock.
 
-The validator detects and reports lock usage that violate these
+The validator detects and reports lock usage that violates these
 single-lock state rules.
 
 Multi-lock dependency rules:
@@ -121,15 +131,20 @@ Multi-lock dependency rules:
 The same lock-class must not be acquired twice, because this could lead
 to lock recursion deadlocks.
 
-Furthermore, two locks may not be taken in different order:
+Furthermore, two locks can not be taken in inverse order:
 
  <L1> -> <L2>
  <L2> -> <L1>
 
-because this could lead to lock inversion deadlocks. (The validator
-finds such dependencies in arbitrary complexity, i.e. there can be any
-other locking sequence between the acquire-lock operations, the
-validator will still track all dependencies between locks.)
+because it could lead to a deadlock - sometimes referred to as lock
+inversion deadlock - as attempts to acquire the two locks form a circle
+which could lead to two contexts waiting for each other permanently, namely
+the two contexts are holding one lock while waiting for acquiring the other
+in an inverse order. The validator will find such circle in arbitrary
+complexity. In other words, there can be any number of locking sequences
+between two acquire-lock operations (holding one lock while acquiring
+another); the validator will still find whether these locks can be acquired
+in a circular fashion.
 
 Furthermore, the following usage based lock dependencies are not allowed
 between any two lock-classes:
-- 
1.8.3.1

