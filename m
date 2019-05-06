Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B490DC04AAA
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 08:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8707A2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 08:20:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f+T6M3RY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbfEFIUm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 04:20:42 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33146 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726280AbfEFIUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 04:20:40 -0400
Received: by mail-pl1-f195.google.com with SMTP id y3so5995668plp.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 01:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lS5QYxwdcrp0iJAnAclL63wUrAcimaL9hCgMEL5QUjw=;
        b=f+T6M3RYzzZf2OHXvLmIkUa9SbDCNC7EcP4ZnLh4n4929Qpf41FX+hmyMO3yOF2h2a
         augsF1iXEHqLCSejkA2XA8Ghxpmo8B8xjgM9LyI4Zc3lPT0YEnTPnPapBlxKqvzlboUL
         8UZVvgsL3kHesi6sGUv1uBRe0zEY0sjW1JnUGl1TJod0/oDAR3MJl3EZTclgKh/vkbHC
         4QLMEsl8MhWjEsY7CSohNieE4tYcJkKvDmpc+ZIm+M0LqfVlWOLbyPsqyTi8+AhYiN47
         poi6lb/2N3NbdgQoz0/2gTPIIrENGZ2aRWAvIHLZQDuSimsvUYHMzDm26cnWWxr8u1lO
         S+lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lS5QYxwdcrp0iJAnAclL63wUrAcimaL9hCgMEL5QUjw=;
        b=dUjLrw4hcW3FwrfDupz+CRXrJssshhwOZ3G6lwqBJp/3dpB89QOBlkbetMWxCz9TaW
         QTK+w3Qs19eNLq0KpeEL1oxLZkt0DMLKDmQuB6ovTHueS7HMRD4wuqeo3VnkbMf+loKG
         bIh6R3GW3uWnGLsxKq04f6GoqZi90/V7wm5mg1wMxLdAu/y7KCY1IpPpo0xNEcGsE+EW
         CBKC0zEMUinlsl4fGFzudHPXw66D00aN3jBbwblzkxB5NQKvZyHiHal89u1wVxNJjwxg
         3JzBfMx5tQgiW4pBVC7Kzr8b+Bx0O/qMR2PYykdffy4M1b4suv7jZoYLJlbovCILX9T5
         iIOw==
X-Gm-Message-State: APjAAAXiiY95kYw9V7ov3nfbsL0lwiGpVZtvr0qO4oQBcpYZfzOGKrmG
        rTK0sNjSuszdRMSxAnIkaQ4=
X-Google-Smtp-Source: APXvYqxQJfoa7ezRWyE652vgdizVVMrSeC9cCEaVVsGT77CwdMTNWRtEz3zH+EXjfYf4XAiXvS1QdQ==
X-Received: by 2002:a17:902:bd92:: with SMTP id q18mr30720831pls.136.1557130839988;
        Mon, 06 May 2019 01:20:39 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id v19sm20958013pfa.138.2019.05.06.01.20.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 01:20:39 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v2 16/23] locking/lockdep: Add explanation to lock usage rules in lockdep design doc
Date:   Mon,  6 May 2019 16:19:32 +0800
Message-Id: <20190506081939.74287-17-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190506081939.74287-1-duyuyang@gmail.com>
References: <20190506081939.74287-1-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The irq usage and lock dependency rules that if violated a deacklock may
happen are explained in more detail.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 Documentation/locking/lockdep-design.txt | 33 ++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/Documentation/locking/lockdep-design.txt b/Documentation/locking/lockdep-design.txt
index ae65758..f189d13 100644
--- a/Documentation/locking/lockdep-design.txt
+++ b/Documentation/locking/lockdep-design.txt
@@ -108,14 +108,24 @@ Unused locks (e.g., mutexes) cannot be part of the cause of an error.
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
+This is because if a lock can be used in irq context (irq-safe) then it
+cannot be ever acquired with irq enabled (irq-unsafe). Otherwise, a
+deadlock may happen. For example, in the scenario that after this lock
+was acquired but before released, if the context is interrupted this
+lock will be attempted to acquire twice, which creates a deadlock,
+referred to as lock recursion deadlock.
 
-The validator detects and reports lock usage that violate these
+The validator detects and reports lock usage that violates these
 single-lock state rules.
 
 Multi-lock dependency rules:
@@ -124,15 +134,18 @@ Multi-lock dependency rules:
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
+because this could lead to a deadlock - referred to as lock inversion
+deadlock - as attempts to acquire the two locks form a circle which
+could lead to the two contexts waiting for each other permanently. The
+validator will find such dependency circle in arbitrary complexity,
+i.e., there can be any other locking sequence between the acquire-lock
+operations; the validator will still find whether these locks can be
+acquired in a circular fashion.
 
 Furthermore, the following usage based lock dependencies are not allowed
 between any two lock-classes:
-- 
1.8.3.1

